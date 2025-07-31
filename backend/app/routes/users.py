from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from .. import schemas, crud, database

router = APIRouter(prefix="/users", tags=["Users"])

@router.post("/", response_model=schemas.UserResponse)
def create_user(user: schemas.UserCreate, db: Session = Depends(database.get_db)):
    return crud.create_user(db, user)

@router.get("/", response_model=list[schemas.UserResponse])
def list_users(db: Session = Depends(database.get_db)):
    return db.query(crud.models.User).all()

