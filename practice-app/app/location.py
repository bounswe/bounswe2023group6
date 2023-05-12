from .views import app, session, Base
from flask import render_template, request
from flask_login import login_required, current_user
from sqlalchemy import Column, String, ForeignKey, Float, Integer
from sqlalchemy.orm import Mapped, mapped_column
import os
import googlemaps


class Location(Base):
    __tablename__ = 'LocationTable'
    id = Column(Integer, primary_key=True, autoincrement=True)
    address = Column(String(50))
    latitude = Column(Float)
    longitude = Column(Float)
    user_id: Mapped[int] = mapped_column(ForeignKey('User.id'), nullable=True)


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
