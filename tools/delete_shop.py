#!/usr/bin/env python
import requests
import json
import os
import collections
import sys
from datetime import datetime

print (30 * '-')
print ("   Select Environment   ")
print (30 * '-')
print ("1. Staging")
print ("2. Alpha")
print ("3. Sandbox")
print (30 * '-')
is_valid=0
 
while not is_valid :
    try :
            choice = int ( raw_input('Enter your choice [1-3] : ') )
            is_valid = 1 ## set it to 1 to validate input and to terminate the while..not loop
    except ValueError, e :
            print ("'%s' is not a valid integer." % e.args[0].split(": ")[1])
 
### Take action as per selected menu-option ###
if choice == 1:
    url = 'http://apis-gateway.wemall-dev.com/css/'
elif choice == 2:
    url = 'http://alpha-apis-gateway.wemall-dev.com/css/'
elif choice == 3:
    url = 'http://sandbox-storefront-api.wemall-dev.com/'
elif choice == 999:
    url = 'http://apis-gateway.wemall.com/css/'
else:
    print ("Invalid number. Try again...")
    sys.exit()

#Input shop slug
shop_slug = raw_input('Please enter shop slug: ')
shop_slug = shop_slug.strip()
if not shop_slug:
    print ("Invalid Shop slug. Try again...")
    sys.exit()

# Get shop ID
# print url+'v3/shops/slug/'+shop_slug
response = requests.get(url+'v3/shops/slug/'+shop_slug)

if response.status_code != 200:
    print 'status_code: ' + str(response.status_code)
    sys.exit()

json_data = response.json()
if json_data['data']==None:
    print ("Shop not found. Try again...")
    sys.exit()

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
    print 'status_code: ' + str(response.status_code)
    sys.exit()
    
print 'Delete Shop "' + shop_slug + '" success'



