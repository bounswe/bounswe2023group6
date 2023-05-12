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


def test_worldtime_post(client):
    client.post("/login", data=dict(
        username=TEST_USER, password=TEST_USERPASS
    ), follow_redirects=True)
    user = User.query.filter_by(username=TEST_USER).first()
    response = client.post("/worldtime", data=dict(
        query="Europe/London", languageCode="en", user_id=user.id
    ), follow_redirects=True)
    assert response.status_code == 200


def test_worldtime_post_invalid(client):
    client.post("/login", data=dict(
        username=TEST_USER, password=TEST_USERPASS
    ), follow_redirects=True)
    response = client.post("/worldtime", data=dict(
        query="Europe/London", languageCode=""
    ), follow_redirects=True)
    assert response.status_code == 200


def test_worldtime_post_invalid_timezone(client):
    client.post("/login", data=dict(
        username=TEST_USER, password=TEST_USERPASS
    ), follow_redirects=True)
    response = client.post("/worldtime", data=dict(
        query="", languageCode="en"
    ), follow_redirects=True)
    assert response.status_code == 200


def test_worldtime_post_invalid_timezone_and_language(client):
    client.post("/login", data=dict(
        username=TEST_USER, password=TEST_USERPASS
    ), follow_redirects=True)
    response = client.post("/worldtime", data=dict(
        timezone="", languageCode=""
    ), follow_redirects=True)
    assert response.status_code == 200


def test_cleanworldtime(session):
    user = User.query.filter_by(username=TEST_USER).first()
    worldtime = WorldTimeTable.query.filter_by(user_id=user.id).first()
    if worldtime:
        session.delete(worldtime)
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
