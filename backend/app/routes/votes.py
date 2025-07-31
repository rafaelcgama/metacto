from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from .. import schemas, crud, database

router = APIRouter(prefix="/votes", tags=["Votes"])

@router.post("/")
def vote(vote: schemas.VoteBase, db: Session = Depends(database.get_db)):
    created_vote = crud.create_vote(db, vote)
    if not created_vote:
        raise HTTPException(status_code=400, detail="User has already voted for this feature")
    return created_vote