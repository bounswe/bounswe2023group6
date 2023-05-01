from flask import Flask, render_template, url_for, request
import requests

app = Flask(__name__)   # name is global variable returning program name which is app


@app.route("/")  # it is a decorator we have to put a function under of it
def Index():
    return render_template("index.html")


@app.route("/worldtime", methods= ["GET", "POST"])  # it is a decorator we have to put a function under of it
def WorldTime():
    if request.method == "POST":
        timezone = request.form.get("query")
        if timezone == "":
            return render_template("worldtime.html", error="Timezone cannot be empty!")
        languageCode = request.form.get("languageCode")
        if languageCode == "":
            return render_template("worldtime.html", error="Language code cannot be empty!")
        response = requests.get("https://timeapi.io/api/Time/current/zone?timeZone=" + timezone)
        response = response.json()
        if response == "Invalid Timezone":
            return render_template("worldtime.html", error="Timezone is not found!")
        else:
            if len(str(response['month'])) == 1:
                month = "0" + str(response['month'])
            else:
                month = str(response['month'])

            if len(str(response['day'])) == 1:
                day = "0" + str(response['day'])
            else:
                day = str(response['day'])

            if len(str(response['hour'])) == 1:
                hour = "0" + str(response['hour'])
            else:
                hour = str(response['hour'])

            if len(str(response['minute'])) == 1:
                minute = "0" + str(response['minute'])
            else:
                minute = str(response['minute'])

            if len(str(response['seconds'])) == 1:
                seconds = "0" + str(response['seconds'])
            else:
                seconds = str(response['seconds'])

            creating_json = {"dateTime":  str(response['year']) + "-" + month + "-" + day
                                         + " " + hour + ":" +minute + ":" + seconds
                            , "languageCode": request.form.get("languageCode")}
            response = requests.post("https://timeapi.io/api/Conversion/Translate", json= creating_json)
            response = response.json()
            if response == "Couldn't find a language with that code":
                return render_template("worldtime.html", error="Language code is not found!")
            return render_template("worldtime.html", response=response)
    else:
        return render_template("worldtime.html")


