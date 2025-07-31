from sqlalchemy import Column, Integer, String, ForeignKey, Text, DateTime, func, UniqueConstraint
from sqlalchemy.orm import relationship
from .database import Base


class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    email = Column(String, unique=True, index=True, nullable=False)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    features = relationship("Feature", back_populates="creator")
    votes = relationship("Vote", back_populates="user")


class Feature(Base):
    __tablename__ = "features"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, nullable=False)
    description = Column(Text)
    created_by = Column(Integer, ForeignKey("users.id"))
    votes_count = Column(Integer, default=0)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    creator = relationship("User", back_populates="features")
    votes = relationship("Vote", back_populates="feature")


class Vote(Base):
    __tablename__ = "votes"

    id = Column(Integer, primary_key=True, index=True)
    feature_id = Column(Integer, ForeignKey("features.id"))
    user_id = Column(Integer, ForeignKey("users.id"))
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    feature = relationship("Feature", back_populates="votes")
    user = relationship("User", back_populates="votes")

    __table_args__ = (
        UniqueConstraint('feature_id', 'user_id', name='uq_vote_feature_user'),
    )