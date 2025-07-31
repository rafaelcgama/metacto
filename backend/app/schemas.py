from pydantic import BaseModel
from datetime import datetime
from typing import Optional

class UserBase(BaseModel):
    name: str
    email: str

class UserCreate(UserBase):
    pass

class UserResponse(UserBase):
    id: int
    created_at: datetime
    class Config:
        orm_mode = True

class FeatureBase(BaseModel):
    title: str
    description: Optional[str] = None

class FeatureCreate(FeatureBase):
    created_by: int

class FeatureResponse(FeatureBase):
    id: int
    votes_count: int
    created_at: datetime
    class Config:
        orm_mode = True

class VoteBase(BaseModel):
    feature_id: int
    user_id: int

class VoteResponse(BaseModel):
    id: int
    feature_id: int
    user_id: int
    created_at: datetime
    class Config:
        orm_mode = True