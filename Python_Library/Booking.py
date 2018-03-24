import random
import MySQLdb as db

from ConnectDB import *
def py_get_booking_data(booking_code=None) :
    if booking_code is None:
        return None
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)    
    query = "SELECT payment_status, booking_status, expired_at, booking_at, \
    DATE_ADD(booking_at, INTERVAL 3 MONTH) as booking_at_3m,   \
    DATE_ADD(booking_at, INTERVAL 1 HOUR) as booking_at_1hr,   \
    id   \
    FROM `bookings` WHERE `booking_code` LIKE '%s' ORDER BY `id`  DESC" % booking_code
    cursor = mydb.cursor()

    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["payment_status"] = rows[0]
        data["booking_status"] = rows[1]
        data["expired_at"] = rows[2]
        data["booking_at"] = rows[3]
        data["booking_at_3m"] = rows[4] #extend 3 month 
        data["booking_at_1hr"] = rows[5] #extend 1 hour
        data["id"] = rows[6]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def py_get_province(province_id=None) :
    if province_id is None:
        return None
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)    
    query = "SELECT name, name_1 FROM `provinces` WHERE `id` = '%s' " % province_id
    cursor = mydb.cursor()

    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["name_th"] = rows[0]
        data["name_en"] = rows[1]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def py_get_city(citie_id=None) :
    if citie_id is None:
        return None
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)    
    query = "SELECT name, name_1 FROM `cities` WHERE `id` = '%s' " % citie_id
    cursor = mydb.cursor()

    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["name_th"] = rows[0]
        data["name_en"] = rows[1]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def py_get_district(district_id=None) :
    if district_id is None:
        return None
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)    
    query = "SELECT name, name_1 FROM `districts` WHERE `id` = '%s' " % district_id
    cursor = mydb.cursor()

    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["name_th"] = rows[0]
        data["name_en"] = rows[1]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def py_check_stock_hold_bookings_by_inventory_id(inventory_id=None, date_now=None) :
    if inventory_id is None:
        return None
    if date_now is None:
        return None
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)    
    query = "SELECT count(*) as count  FROM `stock_hold_bookings` WHERE `inventory_id` LIKE '%s' AND `status` = 'temporary' AND `expired_at` >= '%s' " % (inventory_id, date_now)
    cursor = mydb.cursor()

    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows[0]
    except:
        print "Cannot fetch data."
    mydb.close()


#    
