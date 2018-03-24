#!/usr/bin/python
import re

def replace_characters(data) :
	num = re.sub('[A-Za-z\-\,\+]+', "", data)  
	return num

def py_remove_whitespace(string) : 
	return string.strip()

def py_convert_to_float(data) : 
	return float(data)

def py_convert_to_int(data) : 
	return int(data)

def py_convert_to_string(data) : 
	return str(data)

def py_get_type(data) : 
	return type(data)