import requests
from flask import render_template, request, jsonify, redirect, url_for
from sqlalchemy import Column, String, Integer, Boolean, ForeignKey, Text
from flask_login import login_required, current_user

from .views import app, Base, session


class LikedGame(Base):
    __tablename__ = "LikedGameTable"
    id = Column(Integer, primary_key=True)
    game_id = Column(Integer)
    game_name = Column(String(50))
    user_id = Column(Integer, ForeignKey("User.id"))
    __table_args__ = {'extend_existing': True}
    
class DislikedGame(Base):
    __tablename__ = "DislikedGameTable"
    id = Column(Integer, primary_key=True)
    game_id = Column(Integer)
    game_name = Column(String(50))
    user_id = Column(Integer, ForeignKey("User.id"))
    __table_args__ = {'extend_existing': True}

@app.route('/find-free-games', methods=['GET', 'POST'])
def find_free_games():
    if request.method == 'POST':
        tag = request.form.get('tag')
        if tag == '':
            return render_template('find_free_games.html', error='Please enter a tag!')
        url = f'https://www.freetogame.com/api/games?category={tag}'
        response = requests.get(url)
        if response.status_code == 404:
            return render_template('find_free_games.html', error='No games found with that tag!')
        else:
            games = response.json()
            for game in games:
                game['game_name'] = game['title']  # Add the 'game_name' attribute with the value of 'title'
                game['game_short_description'] = game['short_description']
            game_names = [game.get('game_name') for game in games]
            return render_template('find_free_games.html', games=games)
    else:
        return render_template('find_free_games.html')



@app.route("/like_game", methods=["POST"])
@login_required
def like_game():
    game_name = request.form.get("game_name")
    game_id = int(request.form.get("game_id"))
    log = None
    if not game_id:
        log = "Problems occurred! Game could not be liked."
    else:
        liked_game = LikedGame.query.filter_by(user_id=current_user.id, game_id=game_id).first()
        if liked_game:
            log = "Game already liked by this user!"
        else:
            #game_name = Game.query.get(game_id).game_name
            liked_game = LikedGame(user_id=current_user.id, game_id=game_id, game_name=game_name)
            session.add(liked_game)
            session.commit()
            log = "Game liked!"
    return redirect(request.referrer or url_for("find_free_games"))

@app.route("/see_liked_games")
@login_required
def see_liked_games():
    liked_games = LikedGame.query.filter_by(user_id=current_user.id).all()
    game_names = [game.game_name for game in liked_games]
    return render_template("see_liked_games.html", liked_games=liked_games)


@app.route("/dislike_game", methods=["POST"])
@login_required
def dislike_game():
    game_name = request.form.get("game_name")
    game_id = int(request.form.get("game_id"))
    log = None
    if not game_id:
        log = "Problems occurred! Game could not be disliked."
    else:
        disliked_game = DislikedGame.query.filter_by(user_id=current_user.id, game_id=game_id).first()
        if disliked_game:
            log = "Game already disliked by this user!"
        else:
            disliked_game = DislikedGame(user_id=current_user.id, game_id=game_id, game_name=game_name)
            session.add(disliked_game)
            session.commit()
            log = "Game disliked!"
    return redirect(request.referrer or url_for("find_free_games"))



@app.route("/see_disliked_games")
@login_required
def see_disliked_games():
    disliked_games = DislikedGame.query.filter_by(user_id=current_user.id).all()
    game_names = [game.game_name for game in disliked_games]
    return render_template("see_disliked_games.html", disliked_games=disliked_games)



