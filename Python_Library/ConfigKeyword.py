from util.Logger import Logger
from Config import Config


    
# fanout latest config vale to every modules
def update_python_config():
    Logger.setSeverity(Config.maps["LOG_LEVEL"])

def set_python_config(name, val):
        Config.maps[name] = val
        print "Set " + name + " = " + Config.maps[name]
        
def set_python_config_as_int(name, val):
        if type(val)!=int:
            val = int(val)
        Config.maps[name] = val
        print "Set %s = %d" % (name, Config.maps[name])  

def get_python_config(name):
        return Config.maps[name]