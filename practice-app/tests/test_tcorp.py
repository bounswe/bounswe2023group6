import json
from unittest.mock import patch, MagicMock


@patch("app.views.get_all_incidents")
def test_get_current_status(mock_get_all_incidents, client):
    mock_get_all_incidents.return_value = [{"id": "1", "status": "RESOLVED"}]
    response = client.get("/get_current_status")
    assert response.json == {"status": 200, "message": "RESOLVED"}


@patch("app.views.get_all_incidents")
@patch("requests.post")
def test_change_status_resolved(mock_post, mock_get_all_incidents, client):
    mock_get_all_incidents.return_value = [{"id": "1", "status": "INVESTIGATING"}]
    mock_post.return_value.status_code = 200
    response = client.post("/change_status/resolved")
    print(response.json)
    assert response.json == {
        "status": 200,
        "message": "Status changed - resolved",
    } or response.json == {
        "message": "Status RESOLVED already",
        "status": 200,
    }  # TODO: May improve this


@patch("app.views.get_all_incidents")
@patch("requests.post")
def test_change_status_investigating(mock_post, mock_get_all_incidents, client):
    mock_get_all_incidents.return_value = [{"id": "1", "status": "RESOLVED"}]
    mock_post.return_value.status_code = 200
    response = client.post("/change_status/investigating")
    assert response.json == {
        "status": 200,
        "message": "Status changed - investigating",
    } or response.json == {
        "message": "Status INVESTIGATING already",
        "status": 200,
    }  # TODO: May improve this


def test_change_status_invalid(client):
    response = client.post("/change_status/invalid")
    assert response.json == {"status": 404, "message": "Page not found"}


@patch("app.views.get_current_status")
def test_get_status_page(mock_get_current_status, client):
    mock_get_current_status.return_value = MagicMock(
        response=[json.dumps({"status": 200, "message": "RESOLVED"})]
    )
    response = client.get("/status_page")
    assert response.status_code == 200
    assert b"Current Status: STABLE" in response.data
