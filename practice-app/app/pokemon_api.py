from flask import render_template, request
from flask_login import current_user
import requests
from sqlalchemy import Column, String, ForeignKey, Integer
from sqlalchemy.orm import (
    Mapped,
    mapped_column,
)
from .views import app, Base, session


class Pokemon(Base):
    __tablename__ = "Pokemon"
    id: Mapped[int] = mapped_column(primary_key=True)
    name = Column(String(100), nullable=False)
    height = Column(Integer, nullable=False)
    weight = Column(Integer, nullable=False)
    user_id: Mapped[int] = mapped_column(ForeignKey("User.id"))


@app.route("/pokemon", methods=["GET", "POST"])
def pokemon_page():
    if request.method == "GET":
        return render_template("pokemon.html")
    else:
        pokemon_name = request.form.get("poke_name")
        if pokemon_name == "":
            return render_template("pokemon.html", error="Please enter a pokemon name ")
        url = f"https://pokeapi.co/api/v2/pokemon/{pokemon_name.lower()}"
        response = requests.get(url)
        if response.status_code == 200:
            data = response.json()
            pokemon = Pokemon(
                name=data["name"], height=data["height"], weight=data["weight"]
            )
            return render_template("pokemon.html", response=pokemon)
        else:
            return render_template(
                "pokemon.html", error="Something went wrong. (Maybe wrong poke name) "
            )


@app.route("/pokesave", methods=["POST"])
def save_pokemon():
    poke_name = request.form.get("name")
    poke_weight = request.form.get("weight")
    poke_height = request.form.get("height")

    pokemon = Pokemon.query.filter_by(name=poke_name).first()
    if pokemon:
        return render_template(
            "pokemon.html",
            error="This pokemon is already owned by you or someone else!",
        )

    temp_poke = Pokemon(
        name=poke_name, height=poke_height, weight=poke_weight, user_id=current_user.id
    )
    session.add(temp_poke)
    session.commit()
    return render_template(
        "pokemon.html",
        response=temp_poke,
        succeed_message="Congrats! This pokemon is now yours.",
    )
