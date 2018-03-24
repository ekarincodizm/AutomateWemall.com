import json

def list_tables():
    tab_list = list_tables()
    for item in tab_list:
        print item

def check_lang(data, lang):
    print lang
    arrayData = json.loads(data)
    if len(arrayData["data"]) == 0:
        return True
    if lang in arrayData["data"]:
        return True
    else:
        return False

def check_key(data, key_check):
    arrayData = json.loads(data)

    if key_check in arrayData :
        return True
    else:
        return False