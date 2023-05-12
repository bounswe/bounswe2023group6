import json
from app.views import User
from app.worldtime import WorldTimeTable

TEST_USER = "practiceapp"
TEST_USERPASS = "practiceapp"

def test_signup(client):
    client.post('/signup', data=dict(
        username=TEST_USER, password=TEST_USERPASS, password_confirm=TEST_USERPASS
    ), follow_redirects=True)
    user = User.query.filter_by(username=TEST_USER).first()
    assert str(user.username) == TEST_USER


def test_login(client):
    client.post("/login", data=dict(
        username=TEST_USER, password=TEST_USERPASS
    ), follow_redirects=True)
    response = client.get("/")
    assert response.status_code == 200


def test_invalid_login(client):
    client.post("/login", data={"username": "not_logged_username", "password": "not_logged_username_password"})
    response = client.get("/")
    assert response.status_code == 302

def test_pokemon_page_get(client):
    response = client.get("/pokemon")
    assert response.status_code == 200

def test_pokemon_page_post_pikachu(client):
    response = client.post('/pokemon', data=dict(poke_name='pikachu'), follow_redirects=True)
    assert response.status_code == 200
    assert b'pikachu' in response.data
    assert b'4' in response.data  
    assert b'60' in response.data  


def test_pokemon_page_post_ditto(client):
    response = client.post('/pokemon', data=dict(poke_name='ditto'), follow_redirects=True)
    assert response.status_code == 200
    assert b'ditto' in response.data
    assert b'3' in response.data
    assert b'40' in response.data

def test_logout(client):
    client.post("/login", data=dict(
        username=TEST_USER, password=TEST_USERPASS
    ), follow_redirects=True)
    client.get("/logout", follow_redirects=True)
    response = client.get("/")
    assert response.status_code == 302


def test_clean(session):
    user = User.query.filter_by(username=TEST_USER).first()
    if user:
        session.delete(user)
        session.commit()




