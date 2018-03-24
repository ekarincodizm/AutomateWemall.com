import sys
sys.path.append('${CURDIR}/../../Python_Library')
import requestapi
import jsonLibrary

def read_list(data_list):
    for s in data_list:
        print s

def request_get_operation(full_url):
    response = requestapi.get_request(full_url)
    print full_url
    requestapi.check_success(response)
    return response

def get_data_item_from_json_response(json_data):
    message_dict = jsonLibrary.get_data(json_data, 'data')
    message_json = jsonLibrary.convert_dict_to_json(message_dict)
    return jsonLibrary.convert_string_to_json(message_json)

def get_shop_list(url):
    # total_count = get_merchant_total_count(url)
    response = request_get_operation(url)
    shop_data = get_data_item_from_json_response(response)
    shop_list = []
    print shop_data
    for item in shop_data:
        shop_list.append(item['shop_name'])
    # read_list(merchant_list)
    return shop_list

def get_merchant_total_count(url):
    response = request_get_operation(url+'?limit=0')
    json_data = get_data_item_from_json_response(response)
    total_count = json_data['total']
    return total_count

def get_title_banner_list(response):
    banner_data = get_data_item_from_json_response(response)
    banner_list = []
    for item in banner_data['banner']['data']:
        banner_list.append(item['title'])
    # read_list(merchant_list)
    return banner_list

def get_order_banner_list(response):
    banner_data = get_data_item_from_json_response(response)
    banner_list = []
    for item in banner_data['banner']['data']:
        banner_list.append(item['order'])
    return banner_list

def get_banner_list_by_banner_status(response, status):
    banner_data = get_data_item_from_json_response(response)
    print banner_data
    banner_list = []
    for item in banner_data['banner']['data']:
        if item['status'] == status:
            banner_list.append(item['title'])
    return banner_list

def get_banner_list_by_index(response, index):
    banner_data = get_data_item_from_json_response(response)
    try:
        print "index is ", index
        print "responsd dat", banner_data['banner']['data']
        return banner_data['banner']['data'][int(index)]
    except:
        return []

def get_banner_index_by_name_list_and_order_list(name, orderName, nameList, orderNameList):
    try:
        index = nameList.index(name)
    except:
        index = -1

    try:
        index2 = orderNameList.index(orderName)
    except:
        index2 = -1

    if index == index2:
        return index
    else:
        return -1
