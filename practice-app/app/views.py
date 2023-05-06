from flask import Flask, render_template, url_for, request, redirect
import requests
from flask_wtf import FlaskForm
from flask_bootstrap import Bootstrap
from wtforms import StringField, PasswordField, BooleanField
from wtforms.validators import InputRequired, Length
from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.orm import sessionmaker, scoped_session
from sqlalchemy.ext.declarative import declarative_base
from flask_login import LoginManager, UserMixin, login_user, login_required, logout_user

engine = create_engine('postgresql://postgres:Practice1.@localhost:5432/postgres', echo=False)
Session = sessionmaker(bind=engine)
session = scoped_session(Session)
Base = declarative_base()
Base.query = session.query_property()
app = Flask(__name__)  # name is global variable returning program name which is app
app.config['SECRET_KEY'] = 'Thisissupposedtobesecret!'
Bootstrap(app)
login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'login'


class User(Base, UserMixin):
    __tablename__ = 'User'
    id = Column(Integer, primary_key=True)
    username = Column(String(15), unique=True)
    password = Column(String(15))


Base.metadata.create_all(engine)


class LoginForm(FlaskForm):
    username = StringField('username', validators=[InputRequired(), Length(min=4, max=15)])
    password = PasswordField('password', validators=[InputRequired(), Length(min=8, max=80)])


class RegisterForm(FlaskForm):
    username = StringField('username', validators=[InputRequired(), Length(min=4, max=15)])
    password = PasswordField('password', validators=[InputRequired(), Length(min=8, max=80)])
    password_confirm = PasswordField('confirm password', validators=[InputRequired(), Length(min=8, max=80)])


@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))


@app.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect(url_for('login'))


@app.route("/")  # it is a decorator we have to put a function under of it
@login_required
def Index():
    return render_template("index.html")


@app.route("/login", methods=['GET', 'POST'])  # it is a decorator we have to put a function under of it
def login():
    form = LoginForm()
    if form.validate_on_submit():
        user = session.query(User).filter(User.username == form.username.data).first()
        if user:
            if user.password == form.password.data:
                login_user(user)
                return redirect(url_for('Index'))
            else:
                return render_template("login.html", form=form, error_password="Your password is wrong!")
        else:
            return render_template("login.html", form=form, error_username="Username is not found!")

    return render_template("login.html", form=form)


@app.route('/signup', methods=['GET', 'POST'])
def signup():
    form = RegisterForm()
    if form.validate_on_submit():
        if form.password.data == form.password_confirm.data:
            new_user = User(username=form.username.data, password=form.password.data)
            session.add(new_user)
            session.commit()
            return redirect(url_for('login'))
        else:
            return render_template("signup.html", form=form, error_confirmation="Password confirmation is wrong!")
    return render_template('signup.html', form=form)


@app.route("/worldtime", methods=["GET", "POST"])  # it is a decorator we have to put a function under of it
@login_required
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

            creating_json = {"dateTime": str(response['year']) + "-" + month + "-" + day
                                         + " " + hour + ":" + minute + ":" + seconds
                , "languageCode": request.form.get("languageCode")}
            response = requests.post("https://timeapi.io/api/Conversion/Translate", json=creating_json)
            response = response.json()
            if response == "Couldn't find a language with that code":
                return render_template("worldtime.html", error="Language code is not found!")
            return render_template("worldtime.html", response=response)
    else:
        return render_template("worldtime.html")
