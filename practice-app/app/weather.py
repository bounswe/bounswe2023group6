import os
from flask import render_template, request
from flask_login import current_user
import requests
from sqlalchemy import Column, String, ForeignKey, Integer
from sqlalchemy.orm import (
    Mapped,
    mapped_column,
)
from .views import app, Base, session



class Weather(Base):
    __tablename__ = "Weather"
    id: Mapped[int] = mapped_column(primary_key=True)
    city = Column(String(100), nullable=False)
    condition = Column(String(100), nullable=False)
    temp = Column(String(100), nullable=False)
    pressure = Column(String(100), nullable=False)
    humidity = Column(String(100), nullable=False)
    user_id: Mapped[int] = mapped_column(ForeignKey("User.id"))

@app.route("/weather", methods=["GET", "POST"])
def weather():
    if request.method == "POST":
            city = request.form.get("city")
            if city == "":
                return render_template("weather.html", error="City cannot be empty!")
            else:
                try:
                    weather_info = get_weather_info(city)
                    return render_template("weather.html", response=weather_info)
                except:
                    return render_template("weather.html", error="Not found! Try with a different city name.")
                
    else:
        return render_template("weather.html")
    
    
def get_weather_info(city):
    api_key = os.environ[
    "API_KEY_WEATHERAPP"
    ]
    url = f"https://api.openweathermap.org/data/2.5/weather?q={city}&appid={api_key}&units=metric"
    response = requests.get(url)
    data = response.json()
    weather = Weather(
        city=data["name"],
        condition=data['weather'][0]['main'],
        temp=data['main']['temp'],
        pressure=data['main']['pressure'],
        humidity=data['main']['humidity']
    )
    return weather

@app.route("/weathersave", methods=["POST"])
def save_weather():
    city_name=request.form.get("city")
    cond=request.form.get("condition")
    temperature=request.form.get("temp")
    press=request.form.get("pressure")
    hum=request.form.get("humidity")
    
    weather=Weather.query.filter_by(
        user_id=current_user.id,
        city=city_name
    ).first()
    
    if weather:
        return render_template(
            "weather.html",
            error="You have already added weather information about this city!"
        )
    response=Weather(
        city=city_name,
        condition=cond,
        temp=temperature,
        pressure=press,
        humidity=hum,
        user_id=current_user.id
    )
    session.add(response)
    session.commit()
    return render_template(
        "weather.html",
        response=response,
        succeed_message="Added successfully."
    )
    
    
    




