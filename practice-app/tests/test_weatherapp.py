from app.weather import Weather
from app.views import User

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

def test_weatherapp_post(client):
    response = client.post("/weather", data=dict(
        city="Istanbul",
    ), follow_redirects=True)
    assert response.status_code == 200


def test_weather_post_invalid(client):
    response = client.post("/weather", data=dict(
        city="",
    ), follow_redirects=True)
    assert response.status_code == 200


def test_cleanweather(session):
    user = User.query.filter_by(username=TEST_USER).first()
    weather=Weather.query.filter_by(
        user_id=user.id,
    ).first()
    if weather:
        session.delete(weather)
        session.commit()


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




