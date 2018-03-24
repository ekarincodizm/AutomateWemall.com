import sys
import os
import unicodedata

def get_os():
    os = sys.platform
    if (os.startswith("win")):
        return "win"
    elif (os.startswith("linux")):
        return "linux"
    else:
        return os
    
    
def add_path_environment(path):
    path = unicodedata.normalize('NFKD', path).encode('ascii','ignore') # need to convert from unicode to string
    os.environ["PATH"] = "%s%s%s" % (os.environ["PATH"], os.pathsep, path)
    return os.environ["PATH"]

def convert_to_unix_path(path):
    if path.find(":") > 0:
        # this is windows absolute file path
        tmp = path.replace(":", "")
        tmp = tmp.replace("\\", "/")
        tmp = "/cygdrive/" + tmp
        return tmp
    elif path.find("\\") >= 0:
        # this is windows relative file path
        tmp = path.replace("\\", "/")
        return tmp
    else:
        # this is already unix file path
        return path
    
def convert_to_ssh_command_compatible(cmd):
    if cmd.find("\\") >= 0:
        # this is windows relative file path
        tmp = cmd.replace("\\", "/")
        return tmp
    else:
        # this is already unix file path
        return cmd
    
'''
inputString = """Line 1
Line 2
ERRORLEVEL=34
Line 3"""

print get_return_code_from_remote_command(inputString)
''' 
    