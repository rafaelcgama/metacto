from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from .. import schemas, crud, database

router = APIRouter(prefix="/features", tags=["Features"])

@router.post("/", response_model=schemas.FeatureResponse)
def create_feature(feature: schemas.FeatureCreate, db: Session = Depends(database.get_db)):
    return crud.create_feature(db, feature)

@router.get("/", response_model=list[schemas.FeatureResponse])
def list_features(db: Session = Depends(database.get_db)):
    return crud.get_features(db)