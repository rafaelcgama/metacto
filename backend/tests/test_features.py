from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)

def test_create_feature():
    # Create user first
    user_resp = client.post("/users/", json={"name": "User A", "email": "usera@example.com"})
    user_id = user_resp.json()["id"]

    # Create feature
    response = client.post("/features/", json={"title": "Feature 1", "description": "Test desc", "created_by": user_id})
    assert response.status_code == 200
    data = response.json()
    assert data["title"] == "Feature 1"

def test_list_features():
    response = client.get("/features/")
    assert response.status_code == 200
    assert isinstance(response.json(), list)