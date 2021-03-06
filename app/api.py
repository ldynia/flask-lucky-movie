import os
import socket

from flask import jsonify
from flask import request

from . import app
from . import read_data
from . import RecoMenda


@app.route("/api/v1/movies/recommend", methods=["GET"])
def recommend():
    """
    Function loads movies from db and returns recommendations.
    """
    app_dir = os.path.dirname(os.path.realpath(__file__))
    movies, errors = read_data(f"{app_dir}/db/db.json")
    if errors:
        return jsonify({"errors": errors, "status_code": 500}), 500

    sherlock = RecoMenda(movies, request.args)
    recommendation = sherlock.recommend()

    return jsonify(recommendation)


@app.route("/healthz/alive", methods=["GET"])
def alive():
    return jsonify()


@app.route("/healthz/ready", methods=["GET"])
def ready():
    DB_REDIS_HOST = os.environ.get('DB_REDIS_HOST', 'redis')
    DB_REDIS_PORT = os.environ.get('DB_REDIS_PORT', 6379)
    try:
        soc = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        soc.connect((DB_REDIS_HOST, DB_REDIS_PORT))
        soc.shutdown(socket.SHUT_RDWR)
        return jsonify()
    except:
        return jsonify(), 500
