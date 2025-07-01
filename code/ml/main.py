from fastapi import FastAPI, Request
from train import train_and_predict
from datetime import datetime, timedelta
from prometheus_fastapi_instrumentator import Instrumentator

app = FastAPI()
Instrumentator().instrument(app).expose(app)

@app.get("/forecast")
def get_ml_forecast(request: Request, q: str):
    try:
        preds = train_and_predict(q)

        today = datetime.utcnow().date()
        prediction_days = [
            (today + timedelta(days=i)).strftime("%A, %d.%m.%Y")
            for i in range(3, 7)  
        ]

        response = []
        for date, temp in zip(prediction_days, preds):
            response.append({
                "day": date,
                "predicted_temp": f"{round(temp, 1)}°C"
            })

        return {
            "location": q.capitalize(),
            "predicted": response
        }

    except Exception as e:
        return { "error": str(e) }
