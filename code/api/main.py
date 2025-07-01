from fastapi import FastAPI, Request
import requests
from urllib.parse import quote
from datetime import datetime
import pytz
from deep_translator import GoogleTranslator
import locale
import os
from prometheus_fastapi_instrumentator import Instrumentator

try:
    locale.setlocale(locale.LC_TIME, "de_CH.UTF-8")
except locale.Error:
    try:
        locale.setlocale(locale.LC_TIME, "de_DE.UTF-8")
    except locale.Error:
        pass

app = FastAPI()
Instrumentator().instrument(app).expose(app)
API_KEY = os.getenv("WEATHER_API_KEY")

@app.get("/weather")
def get_weather(request: Request, q: str):
    location = f"{q},Switzerland"
    url = f"http://api.weatherapi.com/v1/forecast.json?key={API_KEY}&q={quote(location)}&days=3&aqi=no&alerts=no"

    try:
        res = requests.get(url)
        data = res.json()

        if "error" in data:
            return {"error": data["error"]["message"]}

        translator = GoogleTranslator(source="auto", target="de")
        zurich = pytz.timezone('Europe/Zurich')
        now_zurich = datetime.now(zurich)

        forecast = []
        for i, day in enumerate(data["forecast"]["forecastday"]):
            forecast_dt = datetime.fromtimestamp(day["date_epoch"], tz=zurich)
            if forecast_dt.date() >= now_zurich.date():
                if i == 0:
                    day_formatted = "Rest des Tages"
                else:
                    day_formatted = forecast_dt.strftime("%A, %d.%m.%Y")
                condition_en = day["day"]["condition"]["text"]
                condition_de = translator.translate(condition_en)
                forecast.append({
                    "day": day_formatted,
                    "temp": f'{day["day"]["avgtemp_c"]}°C',
                    "condition": condition_de
                })



        if not forecast:
            return {"error": "Keine Wettervorhersage für diesen Ort verfügbar."}

        current_condition_en = data["current"]["condition"]["text"]
        current_condition_de = translator.translate(current_condition_en)

        return {
            "location": q.capitalize(),
            "temperature": f'{data["current"]["temp_c"]}°C',
            "condition": current_condition_de,
            "forecast": forecast
        }

    except Exception as e:
        return {"error": str(e)}
