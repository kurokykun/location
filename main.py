from fastapi import FastAPI
from pydantic import BaseModel

class Coordenadas(BaseModel):
    coordenadas: str

app = FastAPI()
@app.get("/test")
def hello():
    return {"coordenadas": "Hello, world!"}

@app.post("/test")
def create_item(coordenadas: Coordenadas):
    print(coordenadas)
    return {"coordenadas": coordenadas}
