# Movie Recommendation Microservice

This project is a movie recomendation microservice. It works like I'm feeling lucky google search.

## Installation

```bash
# Cloning the source code
git clone https://github.com/ldynia/flask-lucky-movie.git
cd flask-lucky-movie

# Building and running docker container
docker build --tag flask-lucky-movie --build-arg FLASK_DEBUG=True .
docker run --detach --name movie-app --publish 80:8080 --rm flask-lucky-movie
docker ps
```
## API

```bash
curl "http://localhost/api/v1/movies/recommend"
curl "http://localhost:8080/api/v1/movies/recommend"
```

## Testing

Code coverage
```bash
docker exec movie-app coverage run -m pytest
docker exec movie-app coverage report
```

Stop container
```bash
docker stop movie-app
```

## Development

```bash
docker run --name app-debug --rm -d -p 80:8080 -w /app -v $PWD/app:/app python:3.9.5-alpine sleep 1d
pip install --upgrade pip --requirement /app/requirements.txt
docker exec -it app-debug ash

export PORT=8080
export HOST=0.0.0.0
export FLASK_APP=/app/run.py
flask run --host=$HOST --port=$PORT
```