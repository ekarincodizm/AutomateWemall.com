import os.path
from robot.libraries.BuiltIn import BuiltIn

def get_canonical_path(path):
    return os.path.abspath(path)

def write_name_to_console(s):
   BuiltIn().log_to_console('\033[92m'+s)