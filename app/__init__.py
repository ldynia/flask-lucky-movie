from flask import Flask

from .db.db import read_data
from .engine import RecoMenda


# Set up app
app = Flask(__name__)
app.config["JSON_AS_ASCII"] = False