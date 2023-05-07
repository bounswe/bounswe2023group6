import json
import urllib.request
import requests

def get_weather_info(city):
    
    API_KEY="d780ee102b76e27371b06d65806c55c0"
    response = urllib.request.urlopen("https://api.openweathermap.org/data/2.5/weather?q=" + city + "&appid=" + API_KEY + "&units=metric").read()  
    list_of_data = json.loads(response)
  
    weather_info = {
        "city": str(list_of_data["name"]),
        "condition": str(list_of_data['weather'][0]['main']),
        "temp": str(list_of_data['main']['temp']) + 'k',
        "pressure": str(list_of_data['main']['pressure']),
        "humidity": str(list_of_data['main']['humidity']),
    }
    return weather_info