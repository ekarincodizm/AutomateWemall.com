import MySQLdb as db
import socket
import product
import time
import urllib2
from robot.libraries.BuiltIn import BuiltIn
from ConnectDB import *

def shipping_prompt():
	BuiltIn().log_to_console('\n')
	BuiltIn().log_to_console('Enter P-key for shipping info valiation (by default P-key = 2634908634297):')

	pKey = raw_input()
	pKey = pKey.strip()

	if not pKey:
		pKey = 2634908634297

	return pKey

def lv_c_tmvh_prompt():
	BuiltIn().log_to_console('\n')
	BuiltIn().log_to_console('Enter P-key for Truemove-h Lv C valiation (by default P-key = 2634908634297):')

	pKey = raw_input()
	pKey = pKey.strip()

	if not pKey:
		pKey = 2634908634297

	return pKey

def buy_with_package():
	BuiltIn().log_to_console('\n')
	BuiltIn().log_to_console('Enter P-key for buy with package valiation (by default P-key = 2634908634297):')

	pKey = raw_input()
	pKey = pKey.strip()

	if not pKey:
		pKey = 2634908634297

	return pKey

def get_category_xpath(pKey=2634908634297):
	pKey = str(pKey)
	xpath =  "//div[contains(@class, 'breadcrumb__inner_wrapper')]//*[contains(@href,'%s')]/../preceding::a[1]" % pKey
	 
	return xpath

def get_ui_floating_ads_url():
	currentTime = time.strftime("%H%M")
	ui_floating_url = "https://cdn-static.itruemart-dev.com/pcms/uploads/js/uifloatingads_stg.js?v=20160531T" + currentTime

	urllib2.install_opener
	data = urllib2.urlopen(ui_floating_url)
	
	for line in data:
		return line


