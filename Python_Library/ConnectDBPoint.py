import ConfigParser as cfg
from robot.libraries.BuiltIn import BuiltIn
import os
import sys
import socket
from helper import *
import MySQLdb as db

#m = get_message()
#print m

try :

    env = BuiltIn().get_variable_value("${ENV}")
    dbhost = BuiltIn().get_variable_value("${POINT_DB_HOSTNAME}")
    dbuser = BuiltIn().get_variable_value("${POINT_DB_USERNAME}")
    dbpass = BuiltIn().get_variable_value("${POINT_DB_PASSWORD}")
    dbname = BuiltIn().get_variable_value("${POINT_DB_NAME}")
    dbcharset = BuiltIn().get_variable_value("${POINT_DB_CHARSET}")

except:

    env = "alpha"

    config_file_path = get_canonical_path("../Resource/Config/" + env + "/database.ini")

    config = cfg.RawConfigParser()
    config.read(config_file_path)
    dbhost = config.get('DB', 'POINT_HOSTNAME')
    dbuser = config.get('DB', 'POINT_USERNAME')
    dbpass = config.get('DB', 'POINT_PASSWORD')
    dbname = config.get('DB', 'POINT_NAME')
    dbcharset = config.get('DB', 'POINT_CHARSET')



# print "dbhost = " + dbhost
# print "dbuser = " + dbuser
# print "dbpass = " + dbpass
# print "dbname = " + dbname
# print "dbcharset = " + dbcharset


def fetch_all_assoc(query, primaryKey='id'):
    mysqlDb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    cursor = mysqlDb.cursor()
    cursor.execute(query)
    columns = cursor.description
    result = {}

    for value in cursor.fetchall():
        tmp = {}

        for (index,column) in enumerate(value):
            tmp[columns[index][0]] = column

        result[tmp[primaryKey]] = tmp

    return result

def fetch_one_assoc(query):
    mysqlDb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    cursor = mysqlDb.cursor()
    cursor.execute(query)
    columns = cursor.description
    result = {}

    for (index,column) in enumerate(cursor.fetchone()):
        result[columns[index][0]] = column

    return result
