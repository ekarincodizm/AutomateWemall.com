from selenium import webdriver
import os
import base64
import mimetypes
import sys

class _CustomKeyword(object):
	"""docstring for ClassName"""
	#def __init__(self, arg):
	#	super(ClassName, self).__init__()
	#	self.arg = arg

def get_chrome_mobile_options(user_agent_string):
		chrome_options = webdriver.ChromeOptions()
		chrome_options.add_argument("--user-agent={0}".format(user_agent_string))
		return chrome_options