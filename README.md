# flask-init-mini

This project is a boilerplate for future Flask applications.

Below steps can be executed on any unix like system. I will use ubuntu deployed on
[O'Reilly's sandbox](https://learning.oreilly.com/scenarios/ubuntu-sandbox/9781492062837) (alternatively you could use [Katacoda's playground](https://www.katacoda.com/courses/ubuntu/playground2004)). Once the sandbox/playground is ready, execute instructions specified in below sections.

## Installation

```bash
# Cloning the source code
git clone https://github.com/ldynia/flask-lucky-movie.git
cd flask-lucky-movie

# Building and running docker container
docker build --tag flask-lucky --build-arg FLASK_DEBUG=True .
docker run --detach --name app-lucky-movie --publish 80:8080 --rm flask-lucky
docker ps
```
## API

```bash
curl "http://localhost"
```

## Testing

Unit test
```bash
docker exec app-lucky-movie pytest
```

Code coverage
```bash
docker exec app-lucky-movie coverage run -m pytest
docker exec app-lucky-movie coverage report
```

Stop container
```bash
docker stop app-lucky-movie
```
