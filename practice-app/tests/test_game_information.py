from app.views import User

TEST_USER = "practiceapp"
TEST_USERPASS = "practiceapp"
TEST_GAME = "Stardew Valley"
TEST_GAME_ID = 413150

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


def test_get_game_information(client):
    response = client.get("/get_game_information", follow_redirects=True)
    assert response.status_code == 200


def test_post_game_information(client): 
    response = client.post("/get_game_information", data=dict(
        game_name=TEST_GAME
    ), follow_redirects=True)
    assert response.status_code == 200
    assert TEST_GAME in response.data.decode("utf-8")


def test_add_game_to_favorites(client): 
    client.post("/login", data=dict(
        username=TEST_USER, password=TEST_USERPASS
    ), follow_redirects=True)
    response = client.post("/add_to_favorites", data=dict(
        game_name=TEST_GAME,
        game_id=TEST_GAME_ID
    ), follow_redirects=True)
    assert response.status_code == 200
    assert response.json["log"] == "Game added to favorites!"


def test_show_all_favorites(client):
    client.post("/login", data=dict(
        username=TEST_USER, password=TEST_USERPASS
    ), follow_redirects=True)
    response = client.post("/show_all_favorites", follow_redirects=True)
    response_body = response.data.decode("utf-8")
    assert response.status_code == 200
    assert TEST_GAME in response_body


def test_invalid_login(client):
    client.post("/login", data={"username": "not_logged_username", "password": "not_logged_username_password"})
    response = client.get("/")
    assert response.status_code == 302


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