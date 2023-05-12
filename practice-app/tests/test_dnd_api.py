from app.views import User
from app.dnd_information_api import FavoriteRCCombination
from app.dnd_information_api import get_dnd_information

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

def test_get_dnd_information(client):
    response = get_dnd_information("elf","barbarian")

    assert response["name"] == "Elf" and response["class_name"] == "Barbarian"

def test_get_dnd(client):
    response = client.get("/dnd")
    assert b"<h1>Dungeons and Dragons Race-Class Description</h1>" in response.data

def test_post_dnd_info(client):
    response = client.post("/dnd", data={
    "race" : "elf",
    "class" : "barbarian"
    }, follow_redirects=True)

    assert response.status_code == 200

    assert b"Race: Elf" in response.data
    assert b"Class: Barbarian" in response.data

def test_show_most_liked(client):
    response = client.post("/show_most_liked_combinations", follow_redirects=True)

    assert response.status_code == 200
    assert b"<h1>Dungeons and Dragons Race-Class Description</h1>" in response.data

def test_like_combination(client):
    client.post("/login", data=dict(
    username=TEST_USER, password=TEST_USERPASS
    ), follow_redirects=True)
    response = client.post("/like_combination", data={
    "race_name" : "elf",
    "class_name" : "barbarian"
    }, follow_redirects=True)

    assert response.status_code == 200
    assert  b"\"log\":\"Combination added!\"" in response.data

def test_logout(client):
    client.post("/login", data=dict(
        username=TEST_USER, password=TEST_USERPASS
    ), follow_redirects=True)
    client.get("/logout", follow_redirects=True)
    response = client.get("/")
    assert response.status_code == 302

def test_clean(session):

    user = User.query.filter_by(username=TEST_USER).first()
    combin = FavoriteRCCombination.query.filter_by(user_id= user.id).all()
    if combin:
        for i in combin:
            session.delete(i)
            session.commit()

    if user:
        session.delete(user)
        session.commit()