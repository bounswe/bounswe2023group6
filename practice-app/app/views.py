from typing import List
from flask import Flask, render_template, url_for, request, redirect
import requests
from flask_wtf import FlaskForm
from flask_bootstrap import Bootstrap
from wtforms import StringField, PasswordField
from wtforms.validators import InputRequired, Length
from sqlalchemy import create_engine, Column, Integer, Float, String, ForeignKey
from sqlalchemy.orm import (
    sessionmaker,
    scoped_session,
    relationship,
    Mapped,
    mapped_column,
)
from sqlalchemy.ext.declarative import declarative_base
from flask_login import (
    LoginManager,
    UserMixin,
    login_user,
    login_required,
    logout_user,
    current_user,
)
import os
from werkzeug.security import generate_password_hash, check_password_hash

db_username = os.environ[
    "DB_USERNAME"
]
db_password = os.environ[
    "DB_PASSWORD"
]
session_secret_key = os.environ[
    "SECRET_KEY"
]

engine = create_engine(
    f"postgresql://{db_username}:{db_password}@localhost:5432/postgres", echo=False
)
Session = sessionmaker(bind=engine)
session = scoped_session(Session)
Base = declarative_base()
Base.query = session.query_property()
app = Flask(__name__)  # name is global variable returning program name which is app
app.config["SECRET_KEY"] = session_secret_key  # for session
Bootstrap(app)
login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = "login"

from .worldtime import worldTime
from .game_information_api import get_game_information, add_game_to_favorites, show_all_favorites

class User(Base, UserMixin):
    __tablename__ = "User"
    id: Mapped[int] = mapped_column(primary_key=True)
    username = Column(String(15), unique=True)
    password = Column(String(120))
    world_time: Mapped[List["WorldTimeTable"]] = relationship()

class Location(Base):
    __tablename__ = 'LocationTable'
    id = Column(Integer, primary_key=True, autoincrement=True)
    address = Column(String(50))
    latitude = Column(Float)
    longitude = Column(Float)
    user_id: Mapped[int] = mapped_column(ForeignKey('User.id'), nullable=True)

Base.metadata.create_all(engine)

class LoginForm(FlaskForm):
    username = StringField(
        "username", validators=[InputRequired(), Length(min=4, max=15)]
    )
    password = PasswordField(
        "password", validators=[InputRequired(), Length(min=8, max=80)]
    )


class RegisterForm(FlaskForm):
    username = StringField(
        "username", validators=[InputRequired(), Length(min=4, max=15)]
    )
    password = PasswordField(
        "password", validators=[InputRequired(), Length(min=8, max=80)]
    )
    password_confirm = PasswordField(
        "confirm password", validators=[InputRequired(), Length(min=8, max=80)]
    )


@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))


@app.route("/logout")
@login_required
def logout():
    logout_user()
    return redirect(url_for("login"))


@app.route("/")  # it is a decorator we have to put a function under of it
@login_required
def index():
    return render_template("index.html")


@app.route(
    "/login", methods=["GET", "POST"]
)  # it is a decorator we have to put a function under of it
def login():
    form = LoginForm()
    if form.validate_on_submit():
        user = session.query(User).filter(User.username == form.username.data).first()
        if user:
            if check_password_hash(user.password, form.password.data):
                login_user(user)
                return redirect(url_for("index"))
            else:
                return render_template(
                    "login.html", form=form, error_password="Your password is wrong!"
                )
        else:
            return render_template(
                "login.html", form=form, error_username="Username is not found!"
            )

    return render_template("login.html", form=form)


@app.route("/signup", methods=["GET", "POST"])
def signup():
    form = RegisterForm()
    if form.validate_on_submit():
        if form.password.data == form.password_confirm.data:
            hash_password = generate_password_hash(form.password.data, method="sha256")
            new_user = User(username=form.username.data, password=hash_password)
            session.add(new_user)
            session.commit()
            return redirect(url_for("login"))
        else:
            return render_template(
                "signup.html",
                form=form,
                error_confirmation="Password confirmation is wrong!",
            )
    return render_template("signup.html", form=form)

import googlemaps

try: 
    GOOGLEMAPS_API_KEY = os.environ["GOOGLEMAPS_API_KEY"]
    app.config['GOOGLEMAPS_API_KEY'] = GOOGLEMAPS_API_KEY
    gmaps = googlemaps.Client(key=app.config['GOOGLEMAPS_API_KEY']) 
    is_google_api_key_valid = True
except: 
    is_google_api_key_valid = False

@app.route('/show_map', methods=['GET', 'POST'])
def show_map():
    if request.method == 'POST':
        address = request.form['address']
        try:
            if is_google_api_key_valid:
                geocode_result = gmaps.geocode(address)
                latitude = geocode_result[0]['geometry']['location']['lat']
                longitude = geocode_result[0]['geometry']['location']['lng']
                return render_template('map.html', address=address, latitude=latitude, longitude=longitude, GOOGLEMAPS_API_KEY=GOOGLEMAPS_API_KEY)
            else: 
                return render_template("map.html", error_message="Your google api key is empty or invalid")
        except:
            error_message = "Address is not found."
            return render_template('map.html', error_message=error_message)
    return render_template('map.html') 

@app.route("/show_all_favorite_location", methods=["POST"])
@login_required
def show_all_favorite_location():
    all_user_locations = Location.query.filter_by(user_id=current_user.id).all()
    return render_template("map.html", all_user_locations=all_user_locations)

@app.route("/add_location_to_favorites", methods=["POST"])
@login_required
def add_location_to_favorites(): 
    address = request.form.get("location_name")
    latitude = request.form.get("latitude") 
    longitude = request.form.get("longitude")
    previously_added = Location.query.filter_by(user_id=current_user.id, latitude=latitude, longitude=longitude).all()
    if len(previously_added) != 0: 
        log = "Location already added!"
    else:     
        favorite_location = Location(
            user_id=current_user.id,
            address=address, 
            latitude=latitude,
            longitude=longitude
        )
        session.add(favorite_location)
        session.commit()
        log = "Location added to favorites!"
    return render_template('map.html', address=address, latitude=latitude, longitude=longitude, error_message=log)
