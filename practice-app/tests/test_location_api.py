from app.views import User
from app.worldtime import WorldTimeTable
from app.location import Location

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


def test_location_post(client):
    response = client.post("/show_map", data=dict(
        address="Istanbul"
    ), follow_redirects=True)
    assert response.status_code == 200


def test_location_post_invalid(client):
    response = client.post("/show_map", data=dict(
    address="Eurerererer"
    ), follow_redirects=True)
    assert response.status_code == 200


def test_show_all_favorite_location(client):
     response = client.post("/show_all_favorite_location", follow_redirects=True)
     assert response.status_code == 200 
    

def test_add_location_to_favorites(client):
    response = client.post("/add_location_to_favorites", data=dict(
    address = "Istanbul",
    latitude = 123,
    longitude = 234
    ), follow_redirects=True)
    assert response.status_code == 200


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