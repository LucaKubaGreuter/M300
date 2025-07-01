import requests
from datetime import datetime, timedelta
from typing import List, Dict
import os

API_KEY = os.getenv("WEATHER_API_KEY")

def get_weather_history(city: str, days: int = 7) -> List[Dict]:
    base_url = "http://api.weatherapi.com/v1/history.json"
    today = datetime.utcnow().date()

    history = []

    for i in range(days):
        date = today - timedelta(days=(days - 1 - i))  
        date_str = date.strftime("%Y-%m-%d")

        url = f"{base_url}?key={API_KEY}&q={city},Switzerland&dt={date_str}"
        res = requests.get(url)
        data = res.json()

        if "forecast" not in data:
            continue

        day_data = data["forecast"]["forecastday"][0]["day"]
        history.append({
            "date": date_str,
            "avgtemp_c": day_data["avgtemp_c"],
            "humidity": day_data["avghumidity"],
            "condition": day_data["condition"]["text"]
        })

    return history
