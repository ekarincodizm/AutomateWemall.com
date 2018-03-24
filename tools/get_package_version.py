#!/usr/bin/env python
import requests
import json
import os
import collections
import sys
from datetime import datetime

### Take action as per selected menu-option ###
raw_url_wemall = 'wemall-dev.com'
raw_url_api_gateway = 'apis-gateway.wemall-dev.com'
raw_url_wemall_web = 'resource.wemall-dev.com'
raw_url_itruemart = 'www.wemall-dev.com'
raw_url_pcms = 'pcms.itruemart-dev.com'

def print_version(reponse_content, response_type):
    if int(response_type) == 1:
        list_item = reponse_content.split('<br/>')
    elif int(response_type) == 2:
        list_item = reponse_content.split('\n')
    else:
        print ("Invalid Response Type. Try again...")
        sys.exit()
    for item in list_item:
        if 'version' in item:
            version = item.split('=')[1]
            print item
        if 'GIT_COMMIT' in item:
            git_commit = item.split('=')[1]
            print item
        if 'GIT_BRANCH' in item:
            git_branch = item.split('=')[1]
            print item
    print ''

def get_version(service_name, url, response_type, username=None, password=None):
    print "********* " + service_name + " *********"
    if username is not None and password is not None:
        response = requests.get(url, auth=(username, password))
    else:
        response = requests.get(url)
    if response.status_code != 200:
        print '!!!!!!!!!!!!!!Cannot Get Version Service: ' + service_name
    print_version(response.content, response_type)

def main():
    print (30 * '-')
    print ("   Select Environment   ")
    print (30 * '-')
    print ("1. Staging")
    print ("2. Alpha")
    # print ("3. Sandbox")
    print (30 * '-')
    is_valid=0
    while not is_valid :
        try :
            choice = int(raw_input('Enter your choice [1-2] : '))
            is_valid = 1 ## set it to 1 to validate input and to terminate the while..not loop
            if choice == 1: #Staging
                api_gateway = 'http://' + raw_url_api_gateway + '/'
                wemall_web = 'http://' + raw_url_wemall_web + '/version.txt'
                storefront_cms = 'http://storefront-cms.' + raw_url_wemall + '/version.txt'
                portal_cms = 'http://portal-cms.' + raw_url_wemall + '/version.txt'
                itruemart = 'http://' + raw_url_itruemart + '/version'
                pcms = 'http://' + raw_url_pcms + '/version'
            elif choice == 2: #Alpha
                api_gateway = 'http://alpha-' + raw_url_api_gateway + '/'
                wemall_web = 'http://alpha-' + raw_url_wemall_web + '/version.txt'
                storefront_cms = 'http://alpha-storefront-cms.' + raw_url_wemall + '/version.txt'
                portal_cms = 'http://alpha-portal-cms.' + raw_url_wemall + '/version.txt'
                itruemart = 'http://alpha-' + raw_url_itruemart + '/version'
                pcms = 'http://alpha-' + raw_url_pcms + '/version'
            # elif choice == 3: #Sandbox
            #     api_gateway = 'http://sandbox-' + raw_url_api_gateway + '/'
            #     wemall_web = 'http://hulk-' + raw_url_wemall_web + '/version.txt'
            #     storefront_cms = 'http://sandbox-storefront-cms.' + raw_url_wemall + '/version.txt'
            #     portal_cms = 'http://sandbox-portal-cms.' + raw_url_wemall + '/version.txt'
            #     itruemart = 'http://hulk-' + raw_url_itruemart + '/version'
            #     pcms = 'http://hulk-' + raw_url_pcms + '/version'
            elif choice == 999: #Production
                api_gateway = 'http://apis-gateway.wemall.com/'
                wemall_web = 'http://resource.wemall.com/version.txt'
                storefront_cms = 'http://storefront-cms.wemall.com/version.txt'
                portal_cms = 'http://portal-cms.wemall.com/version.txt'
                itruemart = 'http://www.wemall.com/version'
                pcms = 'http://pcms.itruemart.com/version'
            else:
                print ("Invalid number. Try again...")
        except ValueError, e :
                print ("'%s' is not a valid integer." % e.args[0].split(": ")[1])
    print 'Get Service Version'
    # Get package version from service and you can add new service here
    get_version('iTruemart', itruemart, 1, username='devitm', password=';uvkwvmi^,kiNm19')
    get_version('PCMS', pcms, 1)
    get_version('CSS API Service', api_gateway+'css/v3/version', 1)
    get_version('CPS API Service', api_gateway+'cps/v1/version', 1)
    get_version('Storefront CMS', storefront_cms, 2, username='hulk', password='kluh')
    get_version('Portal CMS', portal_cms, 2, username='hulk', password='kluh')
    get_version('General Service', api_gateway+'gen/v1/version', 2)
    get_version('Wemall Web', wemall_web, 2, username='hulk', password='kluh')

main()






