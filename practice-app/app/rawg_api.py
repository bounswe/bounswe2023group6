from flask import  render_template, request, redirect
import xml.etree.ElementTree
import requests, time, os 
from .views import app, Base, session
from flasgger import swag_from
from sqlalchemy import (
    Column,
    String,
    Integer,
    PrimaryKeyConstraint,
    BigInteger,
    func,
)

def remove_tags(text):
    return ''.join(xml.etree.ElementTree.fromstring(text).itertext())

api_key = os.getenv('RAWG_API_KEY')

class FavoriteGenre(Base):
    __tablename__ = "FavoriteGenreTable"
    genre_id = Column(Integer)
    genre_name = Column(String(100))
    time_id = Column(BigInteger, primary_key=True)
    __table_args__ = (PrimaryKeyConstraint(time_id),)

@app.route('/get_genres', methods=['GET','POST'])
@swag_from({
    'tags': ['Genres'],
    'methods': ['GET', 'POST'],
    'responses': {
        200: {
            'description': 'Returns a list of genres and their respective favorite count',
            'schema': {
                'type': 'object',
                'properties': {
                    'genres': {
                        'type': 'array',
                        'items': {
                            'type': 'object',
                            'properties': {
                                'id': {'type': 'integer'},
                                'name': {'type': 'string'}
                            }
                        }
                    },
                    'genre_count_dict': {
                        'type': 'object',
                        'additionalProperties': {'type': 'integer'}
                    }
                }
            },
            'examples': {
                'application/json': {
                    'genres': [{'id': 1, 'name': 'Action'}, {'id': 4, 'name': 'Action'}],
                    'genre_count_dict': {'Action': 5, 'Adventure': 2}
                }
            }
        },
        404: {'description': 'Invalid request'},
    }
})
def get_genres():
    if request.method == 'GET':
        url = f"https://api.rawg.io/api/genres?key={api_key}"
        response = requests.get(url)
        if response.status_code == 200:
            genres = response.json().get('results')
            genre_counts = session.query(FavoriteGenre.genre_name, func.count(FavoriteGenre.genre_name)).group_by(FavoriteGenre.genre_name).all()
            genre_count_dict = {genre_name: count for genre_name, count in genre_counts}
            return render_template('get_genres.html', genres=genres, genre_count_dict=genre_count_dict)
        else:
            return None
    elif request.method == 'POST':
        genre_id = request.form.get('genre')
        genre_name = get_genre_name_from_id(genre_id)
        time_id = int(round(time.time()))
        if not genre_name:
            return redirect('/get_genres')
        favorite_genre = FavoriteGenre(genre_name=genre_name, genre_id=genre_id, time_id=time_id)
        session.add(favorite_genre)
        session.commit()
        return redirect('/get_genres')

def get_genre_name_from_id(genre_id):
    url = f"https://api.rawg.io/api/genres/{genre_id}?key={api_key}"
    response = requests.get(url)
    if response.status_code == 200:
        genre = response.json()
        return genre['name']
    else:
        return None
@app.route('/get_genres/<int:id>')
@swag_from({
    'tags': ['Genres'],
    'methods': ['GET'],
    'parameters': [
        {
            'in': 'path',
            'name': 'id',
            'description': 'The ID of the genre to retrieve information about',
            'required': True,
            'type': 'integer'
        }
    ],
    'responses': {
        200: {
            'description': 'Returns the genre information in an HTML template',
            'examples': {
                'text/html': '<!DOCTYPE html>\n<html>\n<head>\n<title>Genre Info</title>\n</head>\n<body>\n<h1>Genre Info</h1>\n<h2>{{ genre.name }}</h2>\n<p>{{ genre.description }}</p>\n<p>Games count: {{ genre.games_count }}</p>\n<p>Image:<br/><img src="{{ genre.image_background }}" /></p>\n</body>\n</html>'
            }
        },
        404: {
            'description': 'The requested genre was not found',
            'examples': {
                'application/json': {
                    'status': 404,
                    'message': 'Genre not found'
                }
            }
        }
    }
})
def get_genre_info(id):
    url = f"https://api.rawg.io/api/genres/{id}?key={api_key}"
    response = requests.get(url)
    if response.status_code == 200:
        genre = response.json()
        genre['description'] = remove_tags(genre['description'])
        return render_template('get_genre_info.html', genre=genre)
    else:
        return None

if __name__ == '__main__':
    app.run(debug=True, port=3000)
