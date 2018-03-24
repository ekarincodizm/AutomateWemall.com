import requests
import json
from pprint import pprint

def get_request(url):
    response = requests.get(url=url)
    return response

def print_json(response):
    print response.json()

def check_success(response):
    assert response.status_code == 200, 'Status not 200'

