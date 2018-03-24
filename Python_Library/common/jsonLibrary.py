import json
from pprint import pprint

def get_json(response):
    return response.json()

def compare_json(json1, json2):
    assert json1 == json2, 'Json not match'

def get_data(response, data):
    json_data = get_json(response)
    return json_data[data]

def convert_dict_to_json(dict_data):
    json_data = json.dumps(dict_data)
    print json_data
    return json_data

def convert_string_to_json(string):
    output = json.loads(string)
    return output

def convert_json_to_dict(json_object):
    return json.loads(json_object)

def load_json(file):
    with open(file) as data_file:    
        data = json.load(data_file)
    return data

def get_list_data_from_json(json_object, node_data):
    list_data = []
    for value in convert_json_to_dict(json_object):
        list_data.append(value[node_data])
    return list_data

def get_child_json_count(json_object, node=None):
    if node==None:
        dict_a = convert_json_to_dict(json_object)
    else:
        dict_a = convert_json_to_dict(json_object[node])
    return len(dict_a.keys())
