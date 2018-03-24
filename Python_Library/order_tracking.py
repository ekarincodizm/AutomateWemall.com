import random
import MySQLdb as db

from ConnectDB import *

def get_order_tracking_item_status_is_shipped_payment_method_is_cod() :
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)    
    query = "SELECT a.id,a.payment_method,a.transaction_time,b.inventory_id,b.tracking_number,b.received_date,c.access_token,b.item_status\
     FROM orders a INNER JOIN `order_shipment_items` b ON a.id = b.order_id INNER JOIN `third_pl` c ON b.third_pl_id = c.id \
     WHERE payment_method = 7 \
     and b.inventory_id is NOT null \
     and b.tracking_number is NOT null \
     and a.transaction_time is NULL \
     and b.received_date is NULL \
     and b.third_pl_id is NOT null \
     and b.item_status = 'shipped'\
     and b.tracking_number like 'ITM%' " 
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["id"] = rows[0]
        data["payment_method"] = rows[1]
        data["transaction_time"] = rows[2]
        data["inventory_id"] = rows[3]
        data["tracking_number"] = rows[4]
        data["received_date"] = rows[5]
        data["access_token"] = rows[6]
        data["item_status"] = rows[7]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def get_order_tracking_item_status_is_pending_shipment_payment_method_is_cod() :
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)    
    query = "SELECT a.id,a.payment_method,a.transaction_time,b.inventory_id,b.tracking_number,b.received_date,c.access_token,b.item_status\
     FROM orders a INNER JOIN `order_shipment_items` b ON a.id = b.order_id INNER JOIN `third_pl` c ON b.third_pl_id = c.id \
     WHERE payment_method = 7 \
     and b.inventory_id is NOT null \
     and b.tracking_number is NOT null \
     and b.received_date is NULL \
     and b.third_pl_id is NOT null \
     and b.item_status 'pending_shipment'\
     and b.tracking_number like 'ITM%' " 
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["id"] = rows[0]
        data["payment_method"] = rows[1]
        data["transaction_time"] = rows[2]
        data["inventory_id"] = rows[3]
        data["tracking_number"] = rows[4]
        data["received_date"] = rows[5]
        data["access_token"] = rows[6]
        data["item_status"] = rows[7]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def get_order_tracking_item_status_is_shipped_payment_method_is_ccw() :
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)    
    query = "SELECT a.id,a.payment_method,a.transaction_time,b.inventory_id,b.tracking_number,b.received_date,c.access_token,b.item_status\
     FROM orders a INNER JOIN `order_shipment_items` b ON a.id = b.order_id INNER JOIN `third_pl` c ON b.third_pl_id = c.id \
     WHERE payment_method = 1 \
     and b.inventory_id is NOT null \
     and b.tracking_number is NOT null \
     and b.received_date is NULL \
     and b.third_pl_id is NOT null \
     and b.item_status IN ('shipped')\
     and b.tracking_number like 'ITM%' " 
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["id"] = rows[0]
        data["payment_method"] = rows[1]
        data["transaction_time"] = rows[2]
        data["inventory_id"] = rows[3]
        data["tracking_number"] = rows[4]
        data["received_date"] = rows[5]
        data["access_token"] = rows[6]
        data["item_status"] = rows[7]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def get_order_tracking_item_status_is_shipped_payment_method_is_installment() :
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)    
    query = "SELECT a.id,a.payment_method,a.transaction_time,b.inventory_id,b.tracking_number,b.received_date,c.access_token,b.item_status\
     FROM orders a INNER JOIN `order_shipment_items` b ON a.id = b.order_id INNER JOIN `third_pl` c ON b.third_pl_id = c.id \
     WHERE payment_method = 3 \
     and b.inventory_id is NOT null \
     and b.tracking_number is NOT null \
     and b.received_date is NULL \
     and b.third_pl_id is NOT null \
     and b.item_status IN ('shipped')\
     and b.tracking_number like 'ITM%' " 
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["id"] = rows[0]
        data["payment_method"] = rows[1]
        data["transaction_time"] = rows[2]
        data["inventory_id"] = rows[3]
        data["tracking_number"] = rows[4]
        data["received_date"] = rows[5]
        data["access_token"] = rows[6]
        data["item_status"] = rows[7]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def get_order_tracking_item_status_is_shipped_payment_method_is_CounterService() :
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)    
    query = "SELECT a.id,a.payment_method,a.transaction_time,b.inventory_id,b.tracking_number,b.received_date,c.access_token,b.item_status\
     FROM orders a INNER JOIN `order_shipment_items` b ON a.id = b.order_id INNER JOIN `third_pl` c ON b.third_pl_id = c.id \
     WHERE payment_method = 8 \
     and b.inventory_id is NOT null \
     and b.tracking_number is NOT null \
     and b.received_date is NULL \
     and b.third_pl_id is NOT null \
     and b.item_status IN ('shipped')\
     and b.tracking_number like 'ITM%' " 
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["id"] = rows[0]
        data["payment_method"] = rows[1]
        data["transaction_time"] = rows[2]
        data["inventory_id"] = rows[3]
        data["tracking_number"] = rows[4]
        data["received_date"] = rows[5]
        data["access_token"] = rows[6]
        data["item_status"] = rows[7]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def get_order_tracking_item_status_is_delivered_payment_method_is_cod() :
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)    
    query = "SELECT a.id,a.payment_method,a.transaction_time,b.inventory_id,b.tracking_number,b.received_date,c.access_token,b.item_status\
     FROM orders a INNER JOIN `order_shipment_items` b ON a.id = b.order_id INNER JOIN `third_pl` c ON b.third_pl_id = c.id \
     WHERE payment_method = 7 \
     and b.inventory_id is NOT null \
     and b.tracking_number is NOT null \
     and b.received_date is NULL \
     and b.third_pl_id is NOT null \
     and b.item_status IN ('delivered')\
     and b.payment_status = 'success'\
     and b.tracking_number like 'ITM%' " 
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["id"] = rows[0]
        data["payment_method"] = rows[1]
        data["transaction_time"] = rows[2]
        data["inventory_id"] = rows[3]
        data["tracking_number"] = rows[4]
        data["received_date"] = rows[5]
        data["access_token"] = rows[6]
        data["item_status"] = rows[7]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def get_order_tracking_item_status_is_delivered_payment_method_is_wallet() :
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)    
    query = "SELECT a.id,a.payment_method,a.transaction_time,b.inventory_id,b.tracking_number,b.received_date,c.access_token,b.item_status\
     FROM orders a INNER JOIN `order_shipment_items` b ON a.id = b.order_id INNER JOIN `third_pl` c ON b.third_pl_id = c.id \
     WHERE payment_method = 11 \
     and b.inventory_id is NOT null \
     and b.tracking_number is NOT null \
     and b.received_date is NULL \
     and b.third_pl_id is NOT null \
     and b.item_status IN ('delivered')\
     and b.tracking_number like 'ITM%' " 
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["id"] = rows[0]
        data["payment_method"] = rows[1]
        data["transaction_time"] = rows[2]
        data["inventory_id"] = rows[3]
        data["tracking_number"] = rows[4]
        data["received_date"] = rows[5]
        data["access_token"] = rows[6]
        data["item_status"] = rows[7]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def get_check_order_tracking(tracking_number=None) :
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)    
    query = "SELECT a.id,a.payment_method,a.transaction_time,b.inventory_id,b.tracking_number,b.received_date,c.access_token,b.item_status,b.payment_status\
     FROM orders a INNER JOIN `order_shipment_items` b ON a.id = b.order_id INNER JOIN `third_pl` c ON b.third_pl_id = c.id \
     WHERE b.tracking_number = '%s' " % tracking_number
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["id"] = rows[0]
        data["payment_method"] = rows[1]
        data["transaction_time"] = rows[2]
        data["inventory_id"] = rows[3]
        data["tracking_number"] = rows[4]
        data["received_date"] = rows[5]
        data["access_token"] = rows[6]
        data["item_status"] = rows[7]
        data["payment_status"] = rows[8]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()


def py_update_receive_date_and_item_status(tracking_number=None,item_status=None):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try : 
        query = "UPDATE order_shipment_items SET received_date = NULL,item_status = '%s' WHERE tracking_number = '%s' " % (item_status, tracking_number)
        result = cursor.execute(query)
        mydb.commit()
        return True
    except: 
        mydb.rollback()
        return False

def py_update_transaction_time_is_null(order_id=None,transaction_time=None):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try : 
        query = "UPDATE orders SET transaction_time = NULL WHERE id = '%s' " % (order_id)
        result = cursor.execute(query)
        mydb.commit()
        return True
    except: 
        mydb.rollback()
        return False

def py_update_item_status(tracking_number=None,item_status=None):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try : 
        query = "UPDATE order_shipment_items SET item_status = '%s' WHERE tracking_number = '%s' " % (item_status, tracking_number)
        result = cursor.execute(query)
        mydb.commit()
        return True
    except: 
        mydb.rollback()
        return False

def get_check_tracking_queue(tracking_number=None) :
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)    
    query = "SELECT a.tracking_number,a.error_type	FROM tracking_receive_queues a  \
     WHERE a.tracking_number = '%s' " % tracking_number
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["tracking_number"] = rows[0]
        data["error_type"] = rows[1]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()


def delete_tracking_queue(tracking_number=None) : 
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
	query = " DELETE FROM `tracking_receive_queues` WHERE `tracking_number` = '%s' " % tracking_number
	cursor = mydb.cursor()
	try : 
		cursor.execute(query)
		mydb.commit()
		mydb.close()
		return True
	except : 
		mydb.rollback()
		return False

def get_order_tracking_item_status_is_shipped_payment_method_is_cod_receive_date_is_not_null() :
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)    
    query = "SELECT a.id,a.payment_method,a.transaction_time,b.inventory_id,b.tracking_number,b.received_date,c.access_token,b.item_status\
     FROM orders a INNER JOIN `order_shipment_items` b ON a.id = b.order_id INNER JOIN `third_pl` c ON b.third_pl_id = c.id \
     WHERE payment_method = 7 \
     and b.inventory_id is NOT null \
     and b.tracking_number is NOT null \
     and b.received_date is NOT NULL \
     and b.third_pl_id is NOT null \
     and b.item_status = 'delivered'\
     and b.tracking_number like 'ITM%' " 
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["id"] = rows[0]
        data["payment_method"] = rows[1]
        data["transaction_time"] = rows[2]
        data["inventory_id"] = rows[3]
        data["tracking_number"] = rows[4]
        data["received_date"] = rows[5]
        data["access_token"] = rows[6]
        data["item_status"] = rows[7]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def get_transaction_order_item_statuses_return_pending(item_id=None):
    if item_id is None : 
        return None

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = " SELECT max(id) FROM transaction_order_item_statuses WHERE item_status = 'return_pending' AND order_shipment_item_id = %s " % item_id
    cursor = mydb.cursor()
    result = cursor.execute(query)
    rows = cursor.fetchone()
    mydb.close()
    return rows


def update_return_pending_less_than_current_date(tran_id=None):
    if tran_id is None : 
        return None

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = " UPDATE transaction_order_item_statuses SET created_at = NOW() - INTERVAL 1 MONTH WHERE id = %s " % tran_id
    cursor = mydb.cursor()
    result = cursor.execute(query)
    mydb.commit()
    mydb.close()
    return True
