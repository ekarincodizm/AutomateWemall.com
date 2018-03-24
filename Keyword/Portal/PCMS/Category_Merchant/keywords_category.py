# -*- coding: utf-8 -*-
import json
import requests

def join_trail(id,data):
    for item in data:
        if(item.id == id):
            return " ▸ ".decode("utf-8").join(item.trail).strip()


# This two function use to find category ID for Delete it all #########
list_id = []
    # Return All Children Get All CATEGORIES ID FOR DELETE
def get_all_categories_id_for_delete(url,parent_id):
    # call get parent for first time
    data = requests.get(url+str(parent_id))
    jsondata = data.json()["data"]
    id = jsondata["id"]
    getId(url,id)
    list_id.append(id)
    return list_id

    # Get All Children
def getId(url,parent_id):
    data = requests.get(url+str(parent_id))
    jsondata = data.json()["data"]
    #  May be change node to get children id ** if Key change **
    child_count = jsondata["last_child_sequence"]
    # Recursive for get children id and append to array
    # print  parent_id,child_count
    if child_count > 0 :
        children_id = jsondata["children"].keys() 
        print "children_id : ",children_id
        for child_id in children_id:
            print "child_id : ",child_id
            list_id.append(int(getId(url,child_id)))

    return parent_id
# #################################################################