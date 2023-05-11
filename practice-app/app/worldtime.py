from .views import app, session, Base, UserMixin
from flask import render_template, request
from flask_login import login_required, current_user
import requests
from sqlalchemy import Column, String, ForeignKey
from sqlalchemy.orm import Mapped, mapped_column


class WorldTimeTable(Base, UserMixin):
    __tablename__ = "WorldTimeTable"
    id: Mapped[int] = mapped_column(primary_key=True)
    timezone = Column(String(30))
    languageCode = Column(String(15))
    user_id: Mapped[int] = mapped_column(ForeignKey("User.id"))

@app.route(
    "/worldtime", methods=["GET", "POST"]
)  # it is a decorator we have to put a function under of it
@login_required
def worldTime():
    world_time = (
        session.query(WorldTimeTable)
        .filter(WorldTimeTable.user_id == current_user.id)
        .order_by(WorldTimeTable.id.desc())
        .first()
    )
    if request.method == "POST":
        timezone = request.form.get("query")
        if timezone == "":
            return render_template("worldtime.html", error="Timezone cannot be empty!")
        language_code = request.form.get("languageCode")
        if language_code == "":
            return render_template(
                "worldtime.html", error="Language code cannot be empty!"
            )
        response = requests.get(
            "https://timeapi.io/api/Time/current/zone?timeZone=" + timezone
        )
        response = response.json()
        if response == "Invalid Timezone":
            return render_template("worldtime.html", error="Timezone is not found!")
        else:
            if len(str(response["month"])) == 1:
                month = "0" + str(response["month"])
            else:
                month = str(response["month"])

            if len(str(response["day"])) == 1:
                day = "0" + str(response["day"])
            else:
                day = str(response["day"])

            if len(str(response["hour"])) == 1:
                hour = "0" + str(response["hour"])
            else:
                hour = str(response["hour"])

            if len(str(response["minute"])) == 1:
                minute = "0" + str(response["minute"])
            else:
                minute = str(response["minute"])

            if len(str(response["seconds"])) == 1:
                seconds = "0" + str(response["seconds"])
            else:
                seconds = str(response["seconds"])

            creating_json = {
                "dateTime": str(response["year"])
                + "-"
                + month
                + "-"
                + day
                + " "
                + hour
                + ":"
                + minute
                + ":"
                + seconds,
                "languageCode": request.form.get("languageCode"),
            }
            response = requests.post(
                "https://timeapi.io/api/Conversion/Translate", json=creating_json
            )
            response = response.json()
            if response == "Couldn't find a language with that code":
                return render_template(
                    "worldtime.html", error="Language code is not found!"
                )
            else:
                new_world_time = WorldTimeTable(
                    timezone=timezone,
                    languageCode=language_code,
                    user_id=current_user.id,
                )
                session.add(new_world_time)
                session.commit()
                return render_template("worldtime.html", response=response)
    else:
        if world_time:
            return render_template(
                "worldtime.html",
                timezone=world_time.timezone,
                languageCode=world_time.languageCode,
            )
        return render_template("worldtime.html")