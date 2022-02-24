import pytest

from run import app


@pytest.fixture
def client():
    app.config["TESTING"] = True
    with app.test_client() as client:
        yield client


def test_api(client):
    response = client.get("/")
    assert response.status_code == 200
    assert b"Flask" in response.data
