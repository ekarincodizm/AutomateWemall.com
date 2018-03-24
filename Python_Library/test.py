from ConnectDB import *

def get_config() : 
	r = []
	r["dbhost"] = dbhost
    r["dbuser"] = dbuser 
    r["dbpass"] = dbpass
    r["dbname"] = dbname
    r["dbcharset"] = dbcharset

    return r

r = get_config()
print r