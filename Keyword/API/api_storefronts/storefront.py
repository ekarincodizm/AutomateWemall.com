# coding=utf-8
import requests
import json
import unittest
import os

def get_json(response):
    return response.json()

def _check_status(response, code):
    assert response.status_code == code, 'Status not '+str(code)

def check_success(response):
    _check_status(response, 200)

def get_storefront(url, shop_id, view, version=None, type=None, lang=None, mode=None, anonymousId=None, accessToken=None, getData=None):
    full_url = url+shop_id+'/'+view+'?'
    headers = {}
    if version is not None:
        full_url = full_url+'&version='+version
    if type is not None:
        full_url = full_url+'&type='+type
    if lang is not None:
        full_url = full_url+'&lang='+lang
    if mode=='raw':
        full_url = full_url+'&mode='+mode
    if anonymousId != None and anonymousId:
        headers = {'X-Wm-Anonymousid': anonymousId}
    if accessToken != None and accessToken:
        headers = {'X-Wm-Accesstoken': accessToken}
    print full_url
    response = requests.get(full_url, headers=headers)
    
    if getData == 'True':
        return response.json()

    return response

def get_storefront_header(url, shop_id, view, version=None, lang=None, anonymousId=None, accessToken=None):
    return get_storefront(url, shop_id, view, version=version, type='header', lang=lang, anonymousId=anonymousId, accessToken=accessToken)

def get_storefront_menu(url, shop_id, view, version=None, lang=None, mode=None, anonymousId=None, accessToken=None):
    return get_storefront(url, shop_id, view, version=version, type='menu', lang=lang, mode=mode, anonymousId=anonymousId, accessToken=accessToken)

def get_storefront_banner(url, shop_id, view, version=None, lang=None, mode=None, anonymousId=None, accessToken=None):
    return get_storefront(url, shop_id, view, version=version, type='banner', lang=lang, mode=mode, anonymousId=anonymousId, accessToken=accessToken)

def get_storefront_content(url, shop_id, view, version=None, lang=None, anonymousId=None, accessToken=None):
    return get_storefront(url, shop_id, view, version=version, type='content', lang=lang, anonymousId=anonymousId, accessToken=accessToken)

def get_storefront_footer(url, shop_id, view, version=None, lang=None, anonymousId=None, accessToken=None):
    return get_storefront(url, shop_id, view, version=version, type='footer', lang=lang, anonymousId=anonymousId, accessToken=accessToken)

def get_storefront_updatetime(url, shop_id, view, version=None, lang=None, anonymousId=None, accessToken=None):
    return get_storefront(url, shop_id, view, version=version, type='updated_at', lang=lang, anonymousId=anonymousId, accessToken=accessToken)

def response_should_contain_data(response):
    check_success(response)
    json_data = get_json(response)
    data = json_data['data']
    # print data
    assert data is not None and data, 'data is null or empty'

def response_header_should_contain_data(response, expected_shop_id):
    response_should_contain_data(response)
    _check_response_success_and_shop_id_matched(response, 'header', expected_shop_id)

def response_menu_should_contain_data(response, expected_shop_id):
    response_should_contain_data(response)
    _check_response_success_and_shop_id_matched(response, 'menu', expected_shop_id)

def response_banner_should_contain_data(response, expected_shop_id):
    response_should_contain_data(response)
    _check_response_success_and_shop_id_matched(response, 'banner', expected_shop_id)

def response_content_should_contain_data(response, expected_shop_id):
    response_should_contain_data(response)
    _check_response_success_and_shop_id_matched(response, 'content', expected_shop_id)

def response_footer_should_contain_data(response, expected_shop_id):
    response_should_contain_data(response)
    _check_response_success_and_shop_id_matched(response, 'footer', expected_shop_id)

def response_updatetime_should_contain_data(response):
    response_should_contain_data(response)
    _check_response_success_and_udpate_time_not_null(response)

def response_version_draft_should_contain_data(response, expected_shop_id):
    response_should_contain_data(response)
    _check_response_success_and_shop_id_matched(response, 'header', expected_shop_id)
    _check_response_success_and_shop_id_matched(response, 'menu', expected_shop_id)
    _check_response_success_and_shop_id_matched(response, 'banner', expected_shop_id)
    _check_response_success_and_shop_id_matched(response, 'content', expected_shop_id)
    _check_response_success_and_shop_id_matched(response, 'footer', expected_shop_id)

def response_version_publish_should_contain_data(response, expected_shop_id):
    response_should_contain_data(response)
    _check_response_success_and_shop_id_matched(response, 'header', expected_shop_id)
    _check_response_success_and_shop_id_matched(response, 'menu', expected_shop_id)
    _check_response_success_and_shop_id_matched(response, 'banner', expected_shop_id)
    _check_response_success_and_shop_id_matched(response, 'content', expected_shop_id)
    _check_response_success_and_shop_id_matched(response, 'footer', expected_shop_id)
    _check_response_success_and_udpate_time_not_null(response)

def response_pages_content_should_contain_data(response, expected_shop_id):
    response_should_contain_data(response)
    _check_response_success_and_shop_id_matched(response, 'content', expected_shop_id)
    _check_response_success_and_udpate_time_not_null(response)
    # No node
    _check_node_data_in_response_must_not_exist(response, 'header')
    _check_node_data_in_response_must_not_exist(response, 'menu')
    _check_node_data_in_response_must_not_exist(response, 'banner')
    _check_node_data_in_response_must_not_exist(response, 'footer')

def _check_node_data_in_response_must_not_exist(response, node):
    json_data = get_json(response)
    # data_dict = json.loads(json_data['data'])
    print json_data['data']
    assert node not in json_data['data'], "Node: " + node + " exist in response data"

def _check_response_success_and_shop_id_matched(response, type, expected_shop_id):
    json_data = get_json(response)
    # data = json_data['data']
    assert expected_shop_id==json_data['data'][type]['id'], 'Shop id is not matched.'

def _check_response_success_and_udpate_time_not_null(response):
    json_data = get_json(response)
    data = json_data['data']['updated_at']
    assert data, 'updated_at is empty'

def response_should_contain_only_filter_language_data(response, lang):
    response_should_contain_data(response)
    _check_language_filter_exist_in_response(response, 'header',lang)
    _check_language_filter_exist_in_response(response, 'menu',lang)
    _check_language_filter_exist_in_response(response, 'banner',lang)
    _check_language_filter_exist_in_response(response, 'content',lang)
    _check_language_filter_exist_in_response(response, 'footer',lang)

def response_pages_content_should_contain_only_filter_language_data(response, lang):
    response_should_contain_data(response)
    _check_language_filter_exist_in_response(response, 'content',lang)
    # No node
    _check_node_data_in_response_must_not_exist(response, 'header')
    _check_node_data_in_response_must_not_exist(response, 'menu')
    _check_node_data_in_response_must_not_exist(response, 'banner')
    _check_node_data_in_response_must_not_exist(response, 'footer')
    
def response_should_contain_only_filter_view_data(response, view):
    response_should_contain_data(response)
    _check_view_filter_exist_in_response(response, 'header',view)
    _check_view_filter_exist_in_response(response, 'menu',view)
    _check_view_filter_exist_in_response(response, 'banner',view)
    _check_view_filter_exist_in_response(response, 'content',view)
    _check_view_filter_exist_in_response(response, 'footer',view)

def _check_language_filter_exist_in_response(response, type, lang):
    json_data = get_json(response)
    if type=='banner':
        if lang not in json_data['data'][type]['data'][0]:
                    raise ValueError("Do not have filter data in type-"+type)
    elif type=='menu':
        if lang not in json_data['data'][type]['data']['menus'][0]:
                    raise ValueError("Do not have filter data in type-"+type)
    else:
        if lang not in json_data['data'][type]['data']:
            raise ValueError("Do not have filter data in type-"+type)

def _check_view_filter_exist_in_response(response, type, view):
    json_data = get_json(response)
    if type=='banner':
        if view not in json_data['data'][type]['data'][0]['th_TH'] or view not in json_data['data'][type]['data'][0]['en_US']:
                    raise ValueError("Do not have filter data in type-"+type)
    else:
        if view not in json_data['data'][type]['data']['en_US'] or view not in json_data['data'][type]['data']['th_TH']:
            raise ValueError("Do not have filter data in type-"+type)

def request_success_but_response_data_should_empty(response):
    check_success(response)
    json_data = get_json(response)
    data = json_data['data']
    print data
    assert not data, 'data is not empty'

def request_storefront_specific_type_success_but_response_data_should_empty(response, type):
    check_success(response)
    json_data = get_json(response)
    if type == 'menu':
        data = json_data['data'][type]['data']['menus']
    else:
        data = json_data['data'][type]['data']
    print data
    assert not data, 'data is not empty'

def _request_failed_with_code_and_message_error(response, code, message):
    _check_status(response, code)
    json_data = get_json(response)
    data = json_data['message']
    print json_data
    assert data==message, 'message not equal'

def request_failed_because_version_missing_or_invalid(response):
    _request_failed_with_code_and_message_error(response, 400, 'Missing or invalid version')

def _json_response_matched_with_expected(response, type, expected_result):
    reponse_data = get_json(response)
    with open(expected_result) as data_file:
        expected_json = json.load(data_file)
    print reponse_data['data'][type]['data']
    if type=='banner':
        expected_json = expected_json['data']
    response_should_contain_data(response)
    assert reponse_data['data'][type]['data']==expected_json, 'Data not matched'

def response_should_contain_data_like_expected(response, type, expected_result):
    _json_response_matched_with_expected(response, type, expected_result)

def verify_storefront_menu_from_api_response_with_expected_data(response, data_node, **kwargs):
    try:
        expected_data = list(kwargs['expected'])
    except KeyError:
        assert False, "!!!!!!!!!#Please input expected arguments.!!!!!!!!!"
    response_data = get_json(response)
    # with open(response) as data_file:
    #     response_data = json.load(data_file)
    actual_data = _get_data_from_data_node(response_data, data_node)
    print actual_data
    # Check Menu TH Name
    if not expected_data[0]:
        expected_data[0] = None
    assert actual_data['name']['name']==expected_data[0], "Menu name TH not equal, actual: " + actual_data['name']['name'] + ", expected: " + expected_data[0]
    # Check Menu EN Name
    if not expected_data[1]:
        expected_data[1] = None
    assert actual_data['name_translation']['name']==expected_data[1], "Menu name EN not equal, actual: " + actual_data['name_translation']['name'] + ", expected: " + expected_data[1]
    # Check Menu TH Link
    if not expected_data[2]:
        expected_data[2] = None
    assert actual_data['name']['link']==expected_data[2], "Menu link TH not equal, actual: " + actual_data['name']['link'] + ", expected: " + expected_data[2]
    # Check Menu EN Link
    if not expected_data[3]:
        expected_data[3] = None
    assert actual_data['name_translation']['link']==expected_data[3], "Menu link EN not equal, actual: " + actual_data['name_translation']['link'] + ", expected: " + expected_data[3]
    # Check Open New Tab for menu
    if expected_data[4]:
        assert actual_data['target']=="_blank", "Menu open new tab is not '_blank'"
    else:
        assert actual_data['target']=="_self", "Menu open new tab is not '_self'"
    # Check image TH
    if len(expected_data) > 5:
        if not expected_data[5]:
            expected_data[5] = None
        assert os.path.basename(expected_data[5]) in actual_data['images'][0]['name']['image'], "Menu image TH does not contain " + os.path.basename(expected_data[5])
    else:
        assert actual_data['images'] == [], "Menu image should be null but is not, actual: " + actual_data['images']
    # Check image ALT TH
    if len(expected_data) > 6:
        if not expected_data[6]:
            expected_data[6] = None
        assert actual_data['images'][0]['name']['alt']==expected_data[6], "Menu image alt TH not equal, actual: " + actual_data['images'][0]['name']['alt'] + ", expected: " + expected_data[6]
    else:
        assert actual_data['images'] == [], "Menu image should be null but is not, actual: " + actual_data['images']
    # Check image Link TH   
    if len(expected_data) > 7:
        if not expected_data[7]:
            expected_data[7] = None
        assert actual_data['images'][0]['name']['link']==expected_data[7], "Menu image link TH not equal, actual: " + actual_data['images'][0]['name']['link'] + ", expected: " + expected_data[7]
    else:
        assert actual_data['images'] == [], "Menu image should be null but is not, actual: " + actual_data['images']
    # Check image EN    
    if len(expected_data) > 8:
        if not expected_data[8]:
            assert actual_data['images'][0]['name_translation']['image']==None
        else:
            assert os.path.basename(expected_data[8]) in actual_data['images'][0]['name_translation']['image'], "Menu image TH does not contain " + os.path.basename(expected_data[8])
    else:
        assert actual_data['images'] == [], "Menu image should be null but is not, actual: " + actual_data['images']
    # Check image ALT EN   
    if len(expected_data) > 9:
        if not expected_data[9]:
            expected_data[9] = None
        assert actual_data['images'][0]['name_translation']['alt']==expected_data[9], "Menu image alt EN not equal, actual: " + actual_data['images'][0]['name_translation']['alt'] + ", expected: " + expected_data[9]
    else:
        assert actual_data['images'] == [], "Menu image should be null but is not, actual: " + actual_data['images']
    # Check image Link EN   
    if len(expected_data) > 10:
        if not expected_data[10]:
            expected_data[10] = None
        assert actual_data['images'][0]['name_translation']['link']==expected_data[10], "Menu image link EN not equal, actual: " + actual_data['images'][0]['name_translation']['link'] + ", expected: " + expected_data[10]
    else:
        assert actual_data['images'] == [], "Menu image should be null but is not, actual: " + actual_data['images']
    # Check Open New Tab for image 
    if (len(expected_data) > 11):
        if (expected_data[11]):
            assert actual_data['images'][0]['target']=="_blank", "Menu image open new tab is not '_blank'"
        else:
            assert actual_data['images'][0]['target']=="_self", "Menu image open new tab is not '_self'" 
    else:
        assert actual_data['images'] == [], "Menu image should be null but is not, actual: " + actual_data['images']
    # #Check Order but now order in api data didn't use in front or CMS so we will ignore it
    # try:
    #     if kwargs['order'] is not None :
    #         assert int(actual_data['order'])==int(kwargs['order']), "Menu order not match, actual: " + str(actual_data['order']) + ", expected: " + str(kwargs['order'])
    #     else:
    #         assert False, "!!!!!!!!!#Please check order of Menu too.!!!!!!!!!"
    # except KeyError:
    #     assert False, "!!!!!!!!!#Please check order of Menu too.!!!!!!!!!"
    # except IndexError:
    #     assert False, "!!!!!!!!!#This Node do not have order data.!!!!!!!!!"
    #Check max_level
    try:
        if kwargs['max_level'] is not None :
            assert int(actual_data['max_level'])==int(kwargs['max_level']), "Menu max_level don't match, actual: " + str(actual_data['max_level']) + ", expected: " + str(kwargs['max_level'])
    except KeyError:
        pass    
    except IndexError:
        assert False, "!!!!!!!!!#This Node do not have max_level data.!!!!!!!!!"

def verify_menu_from_api_storefront_menus_is_empty(response):
    try:
        response_data = get_json(response)
        print response_data['data']['menu']['data']['menus']
        assert response_data['data']['menu']['data']['menus']==[], "Menus in menu data is not null."
    except IndexError:
        assert False, "Don't have node Menus in response data"

def verify_menu_status_from_api_storefront_menus(response, expected_menu_status):
    try:
        response_data = get_json(response)
        assert response_data['data']['menu']['data']['status']==expected_menu_status, "Menu status don't match with expected, actual: " + response_data['data']['menu']['data']['status'] + ", expected: " + expected_menu_status
    except IndexError:
        assert False, "Don't have node status in response data"

def _get_data_from_data_node(json_data, data_node):
    data_node_list = data_node.split('/')
    data = json_data
    for node in data_node_list:
        try:
           node_data = int(node)
           data = data[node_data]
        except ValueError:
           data = data[node]
    return data

def get_data_in_response_from_node(response, node):
    response_data = get_json(response)
    return _get_data_from_data_node(response_data, node)

def verify_menu_logo_from_api_storefront_menus(response, *expected_logo_data):
    try:
        response_data = get_json(response)
        if response_data['data']['menu']['data']['logo'] is not None :
            actual_logo_data = response_data['data']['menu']['data']['logo']
            assert os.path.basename(expected_logo_data[0]) in actual_logo_data['name']['url_src'], "Logo url path TH don't match with expected, actual: " + response_data['data']['menu']['data']['status'] + ", expected: " + os.path.basename(expected_logo_data[0])
            assert actual_logo_data['name']['link']==expected_logo_data[1], "Logo link TH don't match with expected, actual: " +  actual_logo_data['name']['link'] + ", expected: " + expected_logo_data[1]
            assert os.path.basename(expected_logo_data[2]) in actual_logo_data['name_translation']['url_src'], "Logo url path EN don't match with expected, actual: " +  actual_logo_data['name']['url_src'] + ", expected: " + os.path.basename(expected_logo_data[2])
            assert actual_logo_data['name_translation']['link']==expected_logo_data[3], "Logo link EN don't match with expected, actual: " +  actual_logo_data['name']['link'] + ", expected: " + expected_logo_data[3]
            if (expected_logo_data[4]):
                assert actual_logo_data['target']=="_blank", "Logo image open new tab is not '_blank'"
            else:
                assert actual_logo_data['target']=="_self", "Logo image open new tab is not '_self'" 
    except IndexError:
        assert False, "Don't have node status in response data"

def verify_menu_logo_from_api_storefront_menus_is_null(response):
    # with open(response) as data_file:
    #     response_data = json.load(data_file)
    response_data = get_json(response)
    assert response_data['data']['menu']['data']['logo'] is None, "Logo image data is not Null"


































