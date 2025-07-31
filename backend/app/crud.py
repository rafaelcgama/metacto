from sqlalchemy.orm import Session
from . import models, schemas
from fastapi import HTTPException


# User CRUD
def create_user(db: Session, user: schemas.UserCreate):
    db_user = models.User(name=user.name, email=user.email)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user


# Feature CRUD
def create_feature(db: Session, feature: schemas.FeatureCreate):
    db_feature = models.Feature(
        title=feature.title,
        description=feature.description,
        created_by=feature.created_by
    )
    db.add(db_feature)
    db.commit()
    db.refresh(db_feature)
    return db_feature


def get_features(db: Session):
    return db.query(models.Feature).order_by(models.Feature.votes_count.desc()).all()


# Vote CRUD
def create_vote(db: Session, vote: schemas.VoteBase):
    # Prevent duplicate votes
    existing_vote = db.query(models.Vote).filter(
        models.Vote.feature_id == vote.feature_id,
        models.Vote.user_id == vote.user_id
    ).first()

    if existing_vote:
        raise HTTPException(status_code=400, detail="User has already voted for this feature")

    db_vote = models.Vote(feature_id=vote.feature_id, user_id=vote.user_id)
    db.add(db_vote)

    # Update feature vote count
    feature = db.query(models.Feature).filter(models.Feature.id == vote.feature_id).first()
    if feature:
        feature.votes_count += 1

    db.commit()
    db.refresh(db_vote)
    return db_vote