import MySQLdb as db
import requests, json, urlparse
import os.path

from ConnectDB import *

def chk_order_promotion_log(order_id) : 

    if order_id is None : 
        return None 
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    try : 
        query = "SELECT count(*) FROM `order_promotion_logs` WHERE `order_id` = %s and `promotion_type` = 'coupon_code'" % order_id 
        # BuiltIn().log_to_console(query)
        cursor = mydb.cursor()
        result = cursor.execute(query)
        row = cursor.fetchone()
        #return True
        return row 

    except : 
        mydb.rollback()
        return False

