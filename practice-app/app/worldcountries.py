from flask import render_template, request, redirect,url_for
from flask_login import current_user
import requests
from sqlalchemy import Column, String, Integer
from sqlalchemy.orm import (
    Mapped,
    mapped_column,
)
from .views import app, Base, session




class Country(Base):
    __tablename__ = "Country"
    id: Mapped[int] = mapped_column(primary_key=True)
    name = Column(String(25))
    official_name = Column(String(120))
    currency = Column(String(20))
    region= Column(String(50))
    capital = Column(String(60))
    population = Column(Integer)


@app.get("/worldcountries")
def GetWorldCountries():
    
    ret = session.query(Country).all()
    return render_template("worldcountries.html",entries= ret)


@app.post("/worldcountries")
def PostWorldCountries():

    data = request.form["country"]
    

    response = requests.get("https://restcountries.com/v3.1/name/" + data)
    
    parsed_data = response.json()
    name = parsed_data[0]['name']['common']
    official_name = parsed_data[0]['name']['official']
    currencies_dict = parsed_data[0]["currencies"]
    currencies = list()
    print(currencies_dict)
    for k, v in currencies_dict.items():

        currencies.append(v['name'])
        print(v)
        print(v['name'])

    cur_string = " ".join(currencies)
    print(cur_string)
    print(currencies)
    capital = parsed_data[0]["capital"][0]
    region = parsed_data[0]["region"]
    population = parsed_data[0]["population"]

    CountryEntry = Country(name=name, official_name=official_name,currency = cur_string,capital= capital,region= region,population=population)

    session.add(CountryEntry)
    session.commit()
    
    

    return redirect(url_for("GetWorldCountries"))


