import MySQLdb as db
import sys

from ConnectDB import *
from robot.libraries.BuiltIn import BuiltIn

def get_db():
    return db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

def db_fetchone(query):
    mydb = get_db()
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        mydb.close()
        return rows
    except:
        mydb.close()
        print "Cannot fetch data."

def db_fetchone_as_dictionary(query):
    mydb = get_db()
    cursor = mydb.cursor(db.cursors.DictCursor)
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        mydb.close()
        return rows
    except:
        mydb.close()
        print "Cannot fetch data."

def db_fetchall(query):
    mydb = get_db()
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        mydb.close()
        return rows
    except:
        mydb.close()
        print "Cannot fetch data."

def get_order_by_id(order_id):
    query = "SELECT order_status, payment_status \
        FROM orders \
        WHERE id = '%s' \
        LIMIT 1" % order_id

    return db_fetchone(query)

def get_order_shipment_items_by_id(order_id):
    query = "SELECT inventory_id, item_status, payment_status \
        FROM order_shipment_items \
        WHERE order_id = '%s' \
        LIMIT 1" % order_id

    return db_fetchone(query)

def get_truemoveh_order_verify_by_pcms_order_id(order_id):
    query = "SELECT merchant_id, mobile_id, mobile, price_plan_id, bundle_type \
        FROM truemoveh_order_verifys \
        WHERE pcms_order_id = '%s' \
        LIMIT 1" % order_id

    return db_fetchone(query)

def get_stock_hold_by_order_id(order_id):
    query = "SELECT status, DATE_ADD(created_at,INTERVAL 30 DAY) as extend_created_at, expired_at \
        FROM stock_holds \
        WHERE order_id = '%s' \
        LIMIT 1" % order_id

    return db_fetchone(query)

def get_truemoveh_hold_mobile_log_by_mobile(mobile):
    query = "SELECT mobile, status, DATE_ADD(created_at,INTERVAL 100 YEAR) as extend_created_at, expired_time \
        FROM truemoveh_hold_mobile_logs \
        WHERE mobile = '%s' \
        ORDER BY id Desc LIMIT 1" % mobile

    return db_fetchone(query)

def get_truemoveh_mobiles_by_mobile(mobile):
    query = "SELECT import_lot, zone_id, mobile, mobile_type, proposition_id, \
            used, status\
        FROM truemoveh_mobiles \
        WHERE mobile = '%s' \
        ORDER BY id Desc LIMIT 1" % mobile

    return db_fetchone(query)

def get_tmh_merchant_type():
    query = "SELECT name FROM truemoveh_merchants \
        Order By id ASC"

    return db_fetchall(query)

def update_max_allow_date_truemoveh_mobiles_number_types(date, name):

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try :
        query = "UPDATE truemoveh_mobile_number_types \
                         SET check_max_allow_day='%s' \
                         WHERE name='%s'" % (date, name)
        result = cursor.execute(query)
        mydb.commit()
        return result
    except:
        return "Cannot Update"
    mydb.close()

def get_data_truemoveh_mobile_number_types(name):

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    query = "SELECT check_max_allow_day \
                     FROM truemoveh_mobile_number_types \
                     WHERE name = '%s'" % (name)

    return db_fetchone(query)

def substract_created_date(day, pcms_order_id):

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try :
        query = "UPDATE truemoveh_order_verifys\
                        SET created_at = DATE_SUB(created_at,INTERVAL '%s' DAY)\
                        WHERE pcms_order_id = '%s'" % (day, pcms_order_id)

        result = cursor.execute(query)
        mydb.commit()
        return result
    except:
        return "Cannot Update"
    mydb.close()
