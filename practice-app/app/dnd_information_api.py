import requests
from flask import render_template, request, redirect
from sqlalchemy import (
    Column,
    String,
    Integer,
    ForeignKey,
    PrimaryKeyConstraint,
    Sequence,
    func,
)
from sqlalchemy.orm import Mapped, mapped_column
from flask_login import login_required, current_user

from .views import app, Base, session
from flasgger import swag_from


class FavoriteRCCombination(Base):
    __tablename__ = "FavoriteCombinationsTable"
    id_sec = Sequence(__tablename__ + "_id_seq")
    id = Column(Integer, id_sec, server_default=id_sec.next_value(), nullable=False)
    race_name = Column(String(50))
    class_name = Column(String(50))
    user_id: Mapped[int] = mapped_column(ForeignKey("User.id"), nullable=True)
    __table_args__ = (PrimaryKeyConstraint(user_id, race_name, class_name),)


def get_race_information(race_name):
    race_name = race_name.lower().strip()
    response = requests.get(f"https://www.dnd5eapi.co/api/races/{race_name}")
    if response.status_code != 200:
        return None

    race_information = response.json()

    abilities = race_information["ability_bonuses"]
    ability_text = ""
    for i in abilities:
        ability_text += i["ability_score"]["name"] + " +" + str(i["bonus"]) + ", "
    ability_text = ability_text[:-2]
    race_information["ability_text"] = ability_text

    return race_information


def get_class_information(class_name):
    class_name = class_name.lower().strip()
    response = requests.get(f"https://www.dnd5eapi.co/api/classes/{class_name}")
    if response.status_code != 200:
        return None

    class_information = response.json()

    return class_information


def get_dnd_information(race_name, class_name):
    dnd_info = get_race_information(race_name)
    class_info = get_class_information(class_name)
    if (class_info == None) or (dnd_info == None):
        return None
    dnd_info["hit_die"] = class_info["hit_die"]
    dnd_info["class_name"] = class_info["name"]
    return dnd_info


@app.route("/dnd", methods=["GET", "POST"])
@swag_from({
    'tags': ['DND'],
    'methods': ['GET', 'POST'],
    'responses': {
        '200': {
            'description': 'Renders the dnd page with the race and class information. But rendering is not correct format it should be like this. I learned that so late',
            'examples': {
                'application/json': {
                    "log": "Race and class information received"
                }
            }    
        },
        '400': {
            'description': 'Invalid request. Returns a message indicating the required fields are missing.',
            'examples': {
                'application/json': {
                    "log": "Race name is required!"
                }
            }
        },
        '404': {
            'description': 'Invalid race or class. Returns a message indicating that the information could not be found.',
            'examples': {
                'application/json': {
                    "log": "Information can not be found! Try with a different race or class"
                }
            }
        }        
    }
})
def dnd(log=None):
    if request.method == "POST":
        race_name = request.form.get("race")
        if not race_name:
            log = "Race name is required!"
        class_name = request.form.get("class")
        if not class_name:
            log = "Class name is required!"
        else:
            dnd_information = get_dnd_information(race_name, class_name)
            if dnd_information == None:
                log = "Information can not be found! Try with a different race or class"
            else:
                return render_template("dnd.html", response=dnd_information)

    return render_template("dnd.html", log=log)


@app.route("/show_most_liked_combinations", methods=["POST"])
@swag_from({
    'tags': ['DND'],
    'methods': ['POST'],
    'responses': {
        '200': {
            'description': 'Renders the dnd page with liked combinations and their like counts.But rendering is not correct format it should be like this. I learned that so late',
            'examples': {
                'application/json': {
                    "status": 200,
                    "message": "Race-class combinations and like counts received"
                }
            }    
        }
    }
})
def show_most_liked_combinations():
    counts = (
        FavoriteRCCombination.query.with_entities(
            FavoriteRCCombination.race_name,
            FavoriteRCCombination.class_name,
            func.count(FavoriteRCCombination.id).label("count"),
        )
        .group_by(FavoriteRCCombination.race_name, FavoriteRCCombination.class_name)
        .all()
    )

    counts.sort(key=lambda a: a.count, reverse = True)
    return render_template("dnd.html", combinations=counts)


@app.route("/like_combination", methods=["POST"])
@swag_from({
    'tags': ['DND'],
    'methods': ['POST'],
    'responses': {

        '200': {
            'description': 'Like a race and class combination and return log message.',
            'examples': {
                'application/json': {
                    "log": "Combination added!"
                }
            }    
        },
        '400': {
            'description': 'Invalid request. Returns a message indicating the required fields are missing.',
            'examples': {
                'application/json': {
                   
                    "log": "Problems occured!"
                }
            }    
        },
        '404': {
            'description': 'Already exist',
            'examples': {
                'application/json': {
                    
                    "log": "Combination already liked!"
                }
            }    
        },        
    }
})
def like_combination():
    race_name = request.form.get("race_name")
    class_name = request.form.get("class_name")
    log = None
    if not race_name or not class_name:
        log = "Problems occured!"
    else:
        previously_added = FavoriteRCCombination.query.filter_by(
            user_id=current_user.id, race_name=race_name, class_name=class_name
        ).all()
        if len(previously_added) != 0:
            log = "Combination already liked!"
        else:
            combination = FavoriteRCCombination(
                user_id=current_user.id, race_name=race_name, class_name=class_name
            )
            session.add(combination)
            session.commit()
            log = "Combination added!"
    return {"log": log}