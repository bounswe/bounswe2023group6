import requests
from flask import render_template, request, redirect
from sqlalchemy import Column, String, Integer, ForeignKey, PrimaryKeyConstraint
from sqlalchemy.orm import Mapped, mapped_column
from flask_login import login_required, current_user

from .views import app, Base, session

class FavoriteGame(Base):
    __tablename__ = 'FavoriteGameTable'
    id = Column(Integer, autoincrement=True)
    game_id = Column(Integer)
    game_name = Column(String(50))
    user_id: Mapped[int] = mapped_column(ForeignKey('User.id'), nullable=True)
    __table_args__ = (
        PrimaryKeyConstraint(user_id, game_id),
    )

def get_game_id_from_name(game_name):
    steam_api_game_list_url = "https://api.steampowered.com/ISteamApps/GetAppList/v2/"
    response = requests.get(steam_api_game_list_url)
    if response.status_code != 200: 
        return None
    all_games_list = response.json()["applist"]["apps"]
    game_name = "".join(game_name.lower().split())
    for game in all_games_list:
        if game_name == "".join(game["name"].lower().split()): 
            return game["appid"]
    return None

def get_game_information_from_id(game_id): 
    steam_api_get_game_url = "https://store.steampowered.com/api/appdetails?appids={game_id}"
    response = requests.get(steam_api_get_game_url.format(game_id=game_id))
    if response.status_code != 200:
        return None
    game_information = response.json()[str(game_id)]["data"]
    return game_information

def get_game_information_from_name(game_name): 
    game_id = get_game_id_from_name(game_name)
    if game_id == None: 
        return None
    game_information = get_game_information_from_id(game_id)
    return game_information

@app.route("/get_game_information", methods= ["GET", "POST"])
def get_game_information(log=None):
    if request.method == "POST":
        game_name = request.form.get("game_name")
        if not game_name:
            log = 'Game name is required!'
        else:
            game_information = get_game_information_from_name(game_name)
            if game_information == None: 
                log = "Game can not be found! Try with a different name"
            else: 
                return render_template('show_game_information.html', response=game_information) 
    return render_template("get_game_information.html", log=log)

@app.route("/show_all_favorites", methods=["POST"])
@login_required
def show_all_favorites():
    all_user_games = FavoriteGame.query.filter_by(user_id=current_user.id).all()
    return render_template("show_all_games.html", user_games=all_user_games)

@app.route("/add_to_favorites", methods=["POST"])
@login_required
def add_game_to_favorites(): 
    if request.method == "POST": 
        game_name = request.form.get("game_name")
        game_id = int(request.form.get("game_id"))
        log = None
        if not game_name or not game_id: 
            log = "Problems occurred! Game could not be added to favorites."
        else: 
            previously_added = FavoriteGame.query.filter_by(user_id=current_user.id, game_id=game_id).all()
            if len(previously_added) != 0: 
                log = "Game already added to favorites for this user!"
            else: 
                favorite_game = FavoriteGame(
                    user_id=current_user.id,
                    game_id=game_id,
                    game_name=game_name
                )
                session.add(favorite_game)
                session.commit()
                log = "Game added to favorites!"
        print(log)
        return redirect(request.referrer)