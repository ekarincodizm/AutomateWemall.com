#!/usr/bin/env python
import requests
import json
import os
import collections
import sys
from datetime import datetime
from robot.libraries.BuiltIn import BuiltIn

def py_delete_storefront_shop_by_slug(shop_slug):
    try :
        env = BuiltIn().get_variable_value("${ENV}")
        BuiltIn().log_to_console('Delete Shop: %s on Env: %s' % (shop_slug,env))
    except Exception, e:
        BuiltIn().log_to_console('Exception on `py_delete_storefront_shop_by_slug`: %s' % e)

    if env == 'staging':
        url = 'http://apis-gateway.wemall-dev.com/css/'
    elif env == 'alpha':
        url = 'http://alpha-apis-gateway.wemall-dev.com/css/'
    elif env == 'antman':
        url = 'http://alpha-apis-gateway.wemall-dev.com/css/'
    elif env == 'sandbox':
        url = 'http://sandbox-storefront-api.wemall-dev.com/'
    else:
        url = 'http://sandbox-storefront-api.wemall-dev.com/'

    # Get shop ID
    # print url+'v3/shops/slug/'+shop_slug
    response = requests.get(url+'v3/shops/slug/'+shop_slug)
    if response.status_code != 200:
        raise Exception('status_code: %s' % str(response.status_code))

    json_data = response.json()
    if json_data['data']==None:
        raise Exception('Not found shop slug: %s' % shop_slug)
    shop_id = json_data['data']['id']

    #Delete shop by ID
    requests.delete(url+'v3/shops/'+shop_id)

    requests.delete(url+'v3/storefronts/'+shop_id+'/web?type=header&version=draft')
    requests.delete(url+'v3/storefronts/'+shop_id+'/web?type=menu&version=draft')
    requests.delete(url+'v3/storefronts/'+shop_id+'/web?type=banner&version=draft')
    requests.delete(url+'v3/storefronts/'+shop_id+'/web?type=content&version=draft')
    requests.delete(url+'v3/storefronts/'+shop_id+'/web?type=footer&version=draft')

    requests.delete(url+'v3/storefronts/'+shop_id+'/web?type=header&version=published')
    requests.delete(url+'v3/storefronts/'+shop_id+'/web?type=menu&version=published')
    requests.delete(url+'v3/storefronts/'+shop_id+'/web?type=banner&version=published')
    requests.delete(url+'v3/storefronts/'+shop_id+'/web?type=content&version=published')
    requests.delete(url+'v3/storefronts/'+shop_id+'/web?type=footer&version=published')

    requests.delete(url+'v3/storefronts/'+shop_id+'/mobile?type=header&version=draft')
    requests.delete(url+'v3/storefronts/'+shop_id+'/mobile?type=menu&version=draft')
    requests.delete(url+'v3/storefronts/'+shop_id+'/mobile?type=banner&version=draft')
    requests.delete(url+'v3/storefronts/'+shop_id+'/mobile?type=content&version=draft')
    requests.delete(url+'v3/storefronts/'+shop_id+'/mobile?type=footer&version=draft')

    requests.delete(url+'v3/storefronts/'+shop_id+'/mobile?type=header&version=published')
    requests.delete(url+'v3/storefronts/'+shop_id+'/mobile?type=menu&version=published')
    requests.delete(url+'v3/storefronts/'+shop_id+'/mobile?type=banner&version=published')
    requests.delete(url+'v3/storefronts/'+shop_id+'/mobile?type=content&version=published')
    requests.delete(url+'v3/storefronts/'+shop_id+'/mobile?type=footer&version=published')

    if response.status_code != 200:
        raise Exception('status_code: %s' % str(response.status_code))
    
    BuiltIn().log_to_console('Delete Shop %s success' % shop_slug)
