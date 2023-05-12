import requests
from flask import render_template, request, redirect
from sqlalchemy import (
    Column,
    String,
    Integer,
    ForeignKey,
    PrimaryKeyConstraint,
    Sequence,
)
from sqlalchemy.orm import Mapped, mapped_column
from flask_login import login_required, current_user
from flasgger import swag_from
from .views import app, Base, session, UserMixin

class Activities(Base, UserMixin):
    __tablename__ = "Activities"

    id = Column(Integer, primary_key=True)
    activity_name = Column(String)
    user_id: Mapped[int] = mapped_column(ForeignKey("User.id"))

@app.route(
    "/bored", methods=["GET"]
)  # it is a decorator we have to put a function under of it
@login_required
@swag_from({
    'tags': ['Bored'],
    'responses': {
        '200': {
            'description': 'The request was successfully sent to the Bored API',
            'examples': {
                'application/json': {
                    "NOTE":"MY API DOES NOT RETURN ANY JSON BUT RENDERS AN HTML"
                }
            }
        }
    }
})
def bored():
    
    response = requests.get("http://www.boredapi.com/api/activity/")

    if response.status_code != 200:
        return render_template("bored.html", error=response.status_code)

    response = response.json()
    return render_template("bored.html", kamela=response)



@app.route(
    "/bored/save", methods=["POST"]
)  # it is a decorator we have to put a function under of it
@login_required
@swag_from({
    'tags': ['Bored'],
    'parameters': [
        {
            'activity_name':'go to the gym'
        }
    ],
    'responses': {
        '200': {
            'description': 'The activity successfully saved to the database',
            'examples': {
                'application/json': {
                    "NOTE":"MY API DOES NOT RETURN ANY JSON BUT RENDERS AN HTML",
                    "status":200
                }
            }
        }
    }
})
def bored_save():
    
    activityName = request.form.get("activity")

    session.add(Activities(activity_name=activityName, user_id=current_user.id))
    session.commit()

    return redirect("/bored"), 200   


@app.route(
    "/bored/getSaved", methods=["GET"]
)  # it is a decorator we have to put a function under of it
@login_required
@swag_from({
    'tags': ['Bored'],
    'responses': {
        '200': {
            'description': 'The activity successfully saved to the database',
            'examples': {
                'application/json': {
                    "NOTE":"MY API DOES NOT RETURN ANY JSON BUT RENDERS AN HTML",
                    "status":200
                }
            }
        }
    }
})
def get_bored_saved():
    
    activities = session.query(Activities).filter(
        Activities.user_id == current_user.id
    )

    return render_template("bored.html", activities=activities), 200



@app.route(
    "/bored/delete", methods=["POST"]
)  # it is a decorator we have to put a function under of it
@login_required
@swag_from({
    'tags': ['Bored'],
    'responses': {
        '200': {
            'description': 'The activity successfully saved to the database',
            'examples': {
                'application/json': {
                    "NOTE":"MY API DOES NOT RETURN ANY JSON BUT RENDERS AN HTML",
                    "status":200
                }
            }
        }
    }
})
def delete_bored_saved():
    
    Activities.query.filter(Activities.user_id == current_user.id).delete()
    session.commit()
    return render_template("bored.html", activities=None), 200