from app import app
from app.rawg_api import FavoriteGenre, remove_tags, get_genre_name_from_id
from sqlalchemy import (
    func,
)

def test_get_genres(client):
    response = client.get('/get_genres')
    assert response.status_code == 200
def test_get_genre_info(client):
    response = client.get('/get_genres5')
    assert response.status_code == 200
def test_get_genre_name(client):
    # Mock the response from the API
    response = client.get('/get_genres3')
    assert "Adventure" in response.data.decode('utf-8')
    assert response.status_code == 200
def test_get_genre_description(client):
    response = client.get('/get_genres3')
    assert "Adventure focus on story, many of them are designed for a single player." in response.data.decode('utf-8')
    assert response.status_code == 200

def test_post_genre(client,session):
    genre_counts = session.query(FavoriteGenre.genre_name, func.count(FavoriteGenre.genre_name)).group_by(FavoriteGenre.genre_name).all()
    genre_count_dict = {genre_name: count for genre_name, count in genre_counts}
    numberofaction = genre_count_dict['Action']
    response = client.post('/get_genres', data={'genre': 4},follow_redirects=True)
    genre_counts2 = session.query(FavoriteGenre.genre_name, func.count(FavoriteGenre.genre_name)).group_by(FavoriteGenre.genre_name).all()
    genre_count_dict2 = {genre_name: count for genre_name, count in genre_counts2}
    numberofaction2 = genre_count_dict2['Action']
    assert numberofaction2 == numberofaction + 1
    assert response.status_code == 200
def test_genre_name_from_id(client):
    assert "Sports" == get_genre_name_from_id(15)
    


