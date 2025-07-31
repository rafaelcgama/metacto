from fastapi import FastAPI
from .database import Base, engine
from .routes import users, features, votes

# Create tables automatically
Base.metadata.create_all(bind=engine)

app = FastAPI(title="Feature Voting API")

# Routes
app.include_router(users.router)
app.include_router(features.router)
app.include_router(votes.router)