from shared.weather_utils import get_weather_history
from sklearn.ensemble import RandomForestRegressor
from sklearn.preprocessing import LabelEncoder
import pandas as pd
import numpy as np
from datetime import datetime, timedelta

def train_and_predict(city: str) -> list:
    data = get_weather_history(city, days=7)

    if len(data) < 5:
        raise ValueError("Zu wenig Daten für ML-Vorhersage")

    df = pd.DataFrame(data)

    encoder = LabelEncoder()
    df["condition_enc"] = encoder.fit_transform(df["condition"])

    features = ["avgtemp_c", "humidity", "condition_enc"]
    X = []
    y = []

    for i in range(len(df) - 4):
        X.append(df[features].iloc[i:i+4].values.flatten())
        y.append(df["avgtemp_c"].iloc[i+4])

    X = np.array(X)
    y = np.array(y)

    model = RandomForestRegressor()
    model.fit(X, y)

    last_4 = df[features].iloc[-4:].values.flatten()
    predictions = []

    for i in range(3):
        pred_temp = model.predict([last_4])[0]
        predictions.append(pred_temp)

        dummy = [pred_temp, 65.0, 0.0]
        last_4 = np.concatenate([last_4[3:], dummy]) 

    return predictions

