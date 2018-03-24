import MySQLdb as db 
from ConnectDB import *

def py_count_stock_hold_by_order_id(order_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    
    query = "SELECT COUNT(*)  FROM `stock_holds` \
        WHERE `order_id` = %s AND status = 'permanent' " % order_id

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows[0]
    except:
        print "Cannot fetch data."
    mydb.close()    


def py_count_stock_hold_permanent_by_order_id(order_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    
    query = "SELECT COUNT(*)  FROM `stock_holds` \
        WHERE `order_id` = %s AND status = 'permanent' " % order_id

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows[0]
    except:
        print "Cannot fetch data."
    mydb.close()    


def py_count_stock_hold_temporary_by_order_id(order_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    
    query = "SELECT COUNT(*)  FROM `stock_holds` \
        WHERE `order_id` = %s AND status = 'temporary' " % order_id

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows[0]
    except:
        print "Cannot fetch data."
    mydb.close()        