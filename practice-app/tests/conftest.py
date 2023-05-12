import pytest

from app import app as project
from app.views import Base, engine, session as project_session

@pytest.fixture()
def app():
    app = project
    app.config["WTF_CSRF_ENABLED"] = []

    with app.app_context():
        Base.metadata.create_all(engine)

    yield app

@pytest.fixture()
def client(app):
    return app.test_client()

@pytest.fixture()
def session():
    return project_session