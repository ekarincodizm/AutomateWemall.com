import os


def get_canonical_path(path):
    return os.path.abspath(path)

def py_convert_to_float(data) : 
    return float(data)

def py_convert_to_string(data) : 
    return str(data)

def py_convert_to_int(data) : 
    return int(data)

def write_to_console(s):
	BuiltIn().log_to_console(s)

def write(): 
	write_to_console("Hello World")

def get_type(data) : 
	return type(data)

def replace_characters(data) :
	num = re.sub('[A-Za-z\-\,\+]+', "", data)  
	return num

