from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)

def test_create_and_get_users():
    # Create user
    client.post("/users/", json={"name": "Alice", "email": "alice@example.com"})

    # Get users
    resp = client.get("/users/")
    assert resp.status_code == 200
    data = resp.json()
    assert len(data) == 1
    assert data[0]["name"] == "Alice"