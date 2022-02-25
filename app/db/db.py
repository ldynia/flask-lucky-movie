import json

from json.decoder import JSONDecodeError


def read_data(path):
    """
    Reads file that is expected to hold JSON encoded content.
    In case of errors return empty data and list holding error message.
    """
    data = []
    errors = []
    try:
        with open(path) as db:
            content = db.read()
        data = json.loads(content)
    except FileNotFoundError as e:
        errors = [f"Reading {path}, {str(e)}"]
    except JSONDecodeError as e:
        errors = [f"Reading {path}, {str(e)}"]
    except Exception as e:
        errors = [f"Reading {path}, {str(e)}"]

    return data, errors