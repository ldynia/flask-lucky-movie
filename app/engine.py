import random


class RecoMenda():
    """
    Movies recommendation engine.
    """

    def __init__(self, movies, features):
        self.movies = movies
        self.title = features.get("title")
        self.features = ["genre", "stars"]

    def recommend(self):
        """
        I'm feeling lucky - random choice selection.
        """
        return [random.choice(self.movies)]
