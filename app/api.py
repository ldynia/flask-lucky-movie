import os

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
