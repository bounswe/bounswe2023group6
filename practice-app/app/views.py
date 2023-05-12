from typing import List
from flask import Flask, render_template, url_for, request, redirect, make_response
import requests
from flask_wtf import FlaskForm
from flask_bootstrap import Bootstrap
from wtforms import StringField, PasswordField
from wtforms.validators import InputRequired, Length
from sqlalchemy import create_engine, Column, Integer, Float, String, ForeignKey, delete

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
db_host = os.environ.get("DB_HOST", "localhost:5432")
db_name = os.environ.get("DB_NAME", "postgres")

engine = create_engine(
    f"postgresql://{db_username}:{db_password}@{db_host}/{db_name}", echo=False
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
from .tcorp import get_status_page, change_status, get_all_incidents, get_current_status
from .location import show_map, show_all_favorite_location, add_location_to_favorites 
from .pokemon_api import pokemon_page, save_pokemon
from .bored_api import bored, get_bored_saved,  delete_bored_saved, Activities, bored_save
from .weather import weather, save_weather
from .dnd_information_api import dnd, like_combination, show_most_liked_combinations
from .worldcountries import GetWorldCountries,PostWorldCountries
from .rawg_api import get_genres, get_genre_info

class User(Base, UserMixin):
    __tablename__ = "User"
    id: Mapped[int] = mapped_column(primary_key=True)
    username = Column(String(15), unique=True)
    password = Column(String(120))
    world_time: Mapped[List["WorldTimeTable"]] = relationship()


Base.metadata.create_all(engine)


class LoginForm(FlaskForm):
    username = StringField(
        "username", validators=[InputRequired(), Length(min=4, max=15)]
    )
    password = PasswordField(
        "password", validators=[InputRequired(), Length(min=8, max=160)]
    )


class RegisterForm(FlaskForm):
    username = StringField(
        "username", validators=[InputRequired(), Length(min=4, max=15)]
    )
    password = PasswordField(
        "password", validators=[InputRequired(), Length(min=8, max=160)]
    )
    password_confirm = PasswordField(
        "confirm password", validators=[InputRequired(), Length(min=8, max=160)]
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
                # if user.password == form.password.data:
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
