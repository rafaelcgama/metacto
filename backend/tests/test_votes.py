from fastapi.testclient import TestClient
from app.main import app
from app.database import Base, engine, SessionLocal
import pytest

client = TestClient(app)

@pytest.fixture(autouse=True)
def reset_db():
    # Drop and recreate database for each test
    Base.metadata.drop_all(bind=engine)
    Base.metadata.create_all(bind=engine)
    yield

def test_user_cannot_vote_twice():
    # Create user
    user_resp = client.post("/users/", json={"name": "Rafael", "email": "rafael@example.com"})
    user_id = user_resp.json()["id"]

    # Create feature
    feature_resp = client.post("/features/", json={"title": "Feature X", "description": "Test", "created_by": user_id})
    feature_id = feature_resp.json()["id"]

    # First vote (should succeed)
    vote_1 = client.post("/votes/", json={"feature_id": feature_id, "user_id": user_id})
    assert vote_1.status_code == 200

    # Second vote (should fail)
    vote_2 = client.post("/votes/", json={"feature_id": feature_id, "user_id": user_id})
    assert vote_2.status_code == 400
    assert vote_2.json()["detail"] == "User has already voted for this feature"