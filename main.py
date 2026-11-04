
from fastapi import FastAPI

# Create FastAPI application instance
app = FastAPI()


@app.get("/")
def home():
    return {"message": "Hello World from FastAPI!"}


@app.get("/users")
def get_users():
    return [
        {"id": 1, "name": "John"},
        {"id": 2, "name": "Alex"}
    ]


@app.get("/users/{user_id}")
def get_user(user_id: int):
    return {
        "id": user_id,
        "name": "John"
    }
