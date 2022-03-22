import redis

from flask import Flask

from .db.db import read_data
from .engine import RecoMenda


# DB setup
red = redis.Redis(host='redis-db', port=6379, db=0, decode_responses=True)

# App setup
app = Flask(__name__)
app.config["JSON_AS_ASCII"] = False
app.config["JSONIFY_MIMETYPE"] = "application/json; charset=utf-8"