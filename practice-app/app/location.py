from .views import app, session, Base
from flask import render_template, request
from flask_login import login_required, current_user
from sqlalchemy import Column, String, ForeignKey, Float, Integer
from sqlalchemy.orm import Mapped, mapped_column
import os
import googlemaps
from flasgger import swag_from


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



@swag_from({
    'tags': ['Locations'],
    'parameters': [
        {
            'name': 'address',
            'description': 'The address to display on the map',
            'in': 'formData',
            'type': 'string',
            'required': 'true'
        }
    ],
    'responses': {
        '200': {
            'description': 'Returns the HTML template for displaying the map',
            'examples': {
                'text/html': '<html><body><div id="map"></div><script>/* JS code to display the map */</script></body></html>'
            }
        },
        '400': {
            'description': 'Missing or invalid input parameter. Returns an error message.',
            'examples': {
                'application/json': {
                    'error': 'Invalid input parameter: address'
                }
            }
        }
    }
})
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




@swag_from({
    'tags': ['Locations'],
    'security': [{'Bearer Auth': []}],
    'responses': {
        '200': {
            'description': 'Returns all favorite locations of the authenticated user.',
            'examples': {
                'application/json': {
                    "all_user_locations": [
                        {
                            "id": 1,
                            "name": "Home",
                            "latitude": 37.7749,
                            "longitude": -122.4194,
                            "user_id": 123
                        },
                        {
                            "id": 2,
                            "name": "Work",
                            "latitude": 37.7749,
                            "longitude": -122.4194,
                            "user_id": 123
                        }
                    ]
                }
            }
        },
        '401': {
            'description': 'Unauthorized access. Please login to access this resource.',
            'examples': {
                'application/json': {
                    "message": "Unauthorized access. Please login to access this resource."
                }
            }
        }
    }
})
@app.route("/show_all_favorite_location", methods=["POST"])
@login_required
def show_all_favorite_location():
    all_user_locations = Location.query.filter_by(user_id=current_user.id).all()
    return render_template("map.html", all_user_locations=all_user_locations)

@swag_from({
    'tags': ['Locations'],
    'parameters': [
        {
            'name': 'location_name',
            'description': 'Name of the location to add to favorites.',
            'in': 'formData',
            'type': 'string',
            'required': 'true',
        },
        {
            'name': 'latitude',
            'description': 'Latitude of the location to add to favorites.',
            'in': 'formData',
            'type': 'float',
            'required': 'true',
        },
        {
            'name': 'longitude',
            'description': 'Longitude of the location to add to favorites.',
            'in': 'formData',
            'type': 'float',
            'required': 'true',
        },
    ],
    'responses': {
        '200': {
            'description': 'Location added to favorites successfully. Returns a message detailing the result.',
            'examples': {
                'application/json': {
                    "status": 200,
                    "message": "Location added to favorites!"
                }
            }
        },
        '400': {
            'description': 'Location already added to favorites. Returns a message indicating the location was already in the user\'s favorites.',
            'examples': {
                'application/json': {
                    "status": 400,
                    "message": "Location already added!"
                }
            }
        }
    }
})
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
