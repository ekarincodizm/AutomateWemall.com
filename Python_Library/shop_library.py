import MySQLdb as db
import socket
from ConnectDB import *

def delete_shop_from_tbl_shops(shop_code=None):

    print shop_code
    
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    try : 
        query = "DELETE FROM shops \
                WHERE shop_code = '%s' \
                " % shop_code
        cursor = mydb.cursor()
        result = cursor.execute(query)
        mydb.commit()
        return True

    except : 
        mydb.rollback()
        return False

def db_create_shop(shop_code=None, shop_name=None) : 
    if shop_code is None : 
        return None 
    if shop_name is None : 
        return None 

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    try :
        query = "INSERT INTO `shops` (`shop_code`, `name`) VALUES ('%s', '%s')" % (shop_code, shop_name) 
        #BuiltIn().log_to_console(query)
        cursor = mydb.cursor()
        result = cursor.execute(query)
        BuiltIn().log_to_console("result = " + str(result))
        
        shop_id =  cursor.lastrowid
        BuiltIn().log_to_console("shop_id = " + str(shop_id))
        mydb.commit()
        return shop_id
        
    except : 
        mydb.rollback()
        return False

def db_delete_shop(shop_code=None, shop_name=None) : 
    if shop_code is None : 
        return None 
    if shop_name is None : 
        return None 

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    try :
        query = "DELETE FROM `shops` WHERE shop_code = '%s' AND name = '%s' " % (shop_code, shop_name)
        cursor = mydb.cursor()
        result = cursor.execute(query)
        mydb.commit()
        return True
    except : 
        mydb.rollback()
        return False

def db_delete_shop_by_id(shop_id=None) : 
    if shop_id is None : 
        return None 

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    try :
        query = "DELETE FROM `shops` WHERE shop_id = '%s' " % shop_id
        cursor = mydb.cursor()
        result = cursor.execute(query)
        mydb.commit()
        return True
    except : 
        mydb.rollback()
        return False

def count_shop_from_tbl_shops():

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    try : 
        query = "SELECT count(shop_code) as sum_shop FROM `shops`"
        cursor = mydb.cursor()
        result = cursor.execute(query)
        total = cursor.fetchone()
        return total[0]

    except : 
        mydb.rollback()
        return 0

def py_get_merchant_id_by_merchant_code(merchant_code):

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    try :
        query = "SELECT shop_id \
            FROM shops \
            WHERE shop_code = '%s'\
            " % merchant_code

        cursor = mydb.cursor()
        result = cursor.execute(query)
        result = cursor.fetchall()

        if not result:
            return None

        return result[0]
    except Exception, e:
        BuiltIn().log_to_console(e)
        return None

def get_shop_code_by_shop_id(shop_id):

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    try :
        query = "SELECT shop_code \
            FROM shops \
            WHERE shop_id = %s" % shop_id

        cursor = mydb.cursor()
        result = cursor.execute(query)
        result = cursor.fetchall()

        shop_code = result[0]
        return shop_code

    except Exception, e:
        print e.strerror

def get_shop_id_by_inv_id(inventory_id):

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    try :
        query = "SELECT `shop_id` \
            FROM `variants` \
            WHERE `inventory_id` = '%s'" % inventory_id

        cursor = mydb.cursor()
        result = cursor.execute(query)
        result = cursor.fetchone()

        shop_id = result[0]

        return shop_id

    except Exception, e:
        return BuiltIn().log_to_console('DB exception: %s' % e)

def check_merchant_exists_by_merchant_code(merchant_code):
    result = py_get_merchant_id_by_merchant_code(merchant_code)
    if result:
        return True
    return False
