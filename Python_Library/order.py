from ConnectDB import *


def create_order() : 
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = " INSERT INTO `orders` ( \
		  `pkey` \
		, `order_ref` \
		, `customer_email` \
		, `payment_source` \
		, `payment_channel` \
		, `payment_method` \
		, `created_at` \
		, `updated_at` \
		, `lang_code` \
		, `customer_name` \
		, `customer_address` \
		, `customer_district` \
		, `customer_district_id` \
		, `customer_city` \
		, `customer_city_id` \
		, `customer_province` \
		, `customer_province_id` \
		, `customer_postcode` \
		, `customer_tel` \
		, `order_status` \
		, `payment_status` \
		, `card_issuer` \
		, `card_network` \
		, `card_description` \
		, `card_ref_id` \
		, `expired_at` \
		, `sub_total` \
		, `total_price` \
		, `discount` \
		, `customer_ref_id` \
		) \
		VALUES ( \
		  '1111' \
		, '3333' \
		, 'robotautomate@gmail.com' \
		, 'truemoney' \
		, 'online' \
		, '1' \
		, NOW() \
		, NOW() \
		, 'th' \
		, 'Customer Name' \
		, 'Customer Address' \
		, 'Tumbol' \
		, '158' \
		, 'City' \
		, '45' \
		, 'Bangkok' \
		, '1' \
		, '10600' \
		, '081234567' \
		, 'new' \
		, 'success' \
		, 'Credit Card' \
		, 'VISA' \
		, 'Aomsin Debit Card' \
		, '157' \
		, '2020-01-01' \
		, 1000.00 \
		, 1000.00 \
		, 0 \
		, 'xxxx' \
		) "
	
	cursor = mydb.cursor()
	try : 
		cursor.execute(query)
		mydb.commit()
		data = {}
		data["status"] = True
		data["lastid"] = cursor.lastrowid
		mydb.close()
		return data

	except:
		mydb.rollback()
		print "Cannot fetch data."
	mydb.close() 


def create_order_shipment(order_id = None) : 
	if order_id is None : 
		return None

	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = " INSERT INTO `orders` ( \
		  `order_id` \
		, `shipment_ref` \
		, `` \
		, `payment_source` \
		, `payment_channel` \
		, `payment_method` \
		, `created_at` \
		, `updated_at` \
		, `lang_code` \
		, `customer_name` \
		, `customer_address` \
		, `customer_district` \
		, `customer_district_id` \
		, `customer_city` \
		, `customer_city_id` \
		, `customer_province` \
		, `customer_province_id` \
		, `customer_postcode` \
		, `customer_tel` \
		, `order_status` \
		, `payment_status` \
		, `card_issuer` \
		, `card_network` \
		, `card_description` \
		, `card_ref_id` \
		, `expired_at` \
		, `sub_total` \
		, `total_price` \
		, `discount` \
		, `customer_ref_id` \
		) \
		VALUES ( \
		  '%s' \
		, NULL \
		, 'robotautomate@gmail.com' \
		, 'truemoney' \
		, 'online' \
		, '1' \
		, NOW() \
		, NOW() \
		, 'th' \
		, 'Customer Name' \
		, 'Customer Address' \
		, 'Tumbol' \
		, '158' \
		, 'City' \
		, '45' \
		, 'Bangkok' \
		, '1' \
		, '10600' \
		, '081234567' \
		, 'new' \
		, 'success' \
		, 'Credit Card' \
		, 'VISA' \
		, 'Aomsin Debit Card' \
		, '157' \
		, '2020-01-01' \
		, 1000.00 \
		, 1000.00 \
		, 0 \
		, 'xxxx' \
		) " % order_id
	
	cursor = mydb.cursor()
	try : 
		cursor.execute(query)
		mydb.commit()
		data = {}
		data["status"] = True
		data["lastid"] = cursor.lastrowid
		mydb.close()
		return data

	except:
		mydb.rollback()
		print "Cannot fetch data."
	mydb.close() 

def create_order_shipment_items(order_id = None, order_shipment_id = None) : 
	if order_id is None : 
		return None 

	if order_shipment_id is None : 
		return None 

def delete_order_by_order_id(order_id=None) : 
	if order_id is None : 
		return None 
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
	query = " DELETE FROM `orders` WHERE `id` = %s " % order_id 
	cursor = mydb.cursor()
	try : 
		cursor.execute(query)
		mydb.commit()

		mydb.close()
		return True
	except : 
		mydb.rollback()
		return False

def delete_order_by_customer_email(email=None) : 
	if email is None : 
		return None 
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
	query = " DELETE FROM `orders` WHERE `customer_email` = '%s' " % email 
	cursor = mydb.cursor()
	try : 
		cursor.execute(query)
		mydb.commit()

		mydb.close()
		return True
	except : 
		mydb.rollback()
		return False

def update_order_expired(order_id=None, expired_at=None):
    if order_id is None : 
        return None     
    if expired_at is None : 
        return None 
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try : 
        query = "UPDATE `orders` SET `expired_at` = '%s' WHERE `orders`.`id` = %s;" % (expired_at, order_id)
        result = cursor.execute(query)
        mydb.commit()
        return True
    except: 
        mydb.rollback()
        return False


def py_update_order_item_create_at(item_id=None, created_at_time=None):
    if item_id is None : 
        return None     
    if created_at_time is None : 
        return None 
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try : 
        query = "UPDATE `order_shipment_items` SET `created_at` = '%s' WHERE `order_shipment_items`.`id` = %s;" % (created_at_time, item_id)
        result = cursor.execute(query)
        mydb.commit()
        return True
    except: 
        mydb.rollback()
        return False
        

def py_get_orders():
    
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT orders.id, orders.customer_email, FORMAT(orders.sub_total,2), orders.created_at FROM `orders`\
		INNER JOIN order_shipments ON order_shipments.order_id = orders.id \
		INNER JOIN order_shipment_items ON order_shipment_items.order_id = orders.id \
		GROUP BY orders.id \
		ORDER BY orders.id DESC LIMIT 1"

    # return query
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        row = cursor.fetchone()
        data = {}
        data["order_id"] = row[0]
        data["customer_email"] = row[1]
        data["sub_total"] = row[2]
        data["created_at"] = row[3]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()


def py_get_order_by_order_id(order_id=None):
    if order_id is None : 
        return None 
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT orders.id, orders.customer_email, FORMAT(orders.sub_total,2), orders.created_at, \
        orders.customer_name, orders.customer_address, orders.customer_district, orders.customer_city, \
        orders.customer_province, orders.customer_postcode, orders.customer_tel FROM `orders`\
        INNER JOIN order_shipments ON order_shipments.order_id = orders.id \
        INNER JOIN order_shipment_items ON order_shipment_items.order_id = orders.id \
        WHERE orders.id = %s \
        ORDER BY orders.id DESC" % order_id

    # return query
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        row = cursor.fetchone()
        data = {}
        data["order_id"] = row[0]
        data["customer_email"] = row[1]
        data["sub_total"] = row[2]
        data["created_at"] = row[3]
        data["customer_name"] = row[4]
        data["customer_address"] = row[5]
        data["customer_district"] = row[6]
        data["customer_city"] = row[7]
        data["customer_province"] = row[8]
        data["customer_postcode"] = row[9]
        data["customer_tel"] = row[10]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()    


def py_get_order_shipment_items_by_order_id(order_id=None):
    if order_id is None : 
        return None    
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT items.id, items.inventory_id, items.name, items.quantity , FORMAT(items.price,2),\
		items.tracking_number ,\
		status_payment.label as payment_status_customer, \
		status_item.label as item_status_customer,\
        items.item_status,\
        items.payment_status\
		FROM `order_shipment_items` as items \
		LEFT JOIN status_translates as status_payment ON ( status_payment.slug  = items.payment_status AND status_payment.type = 'payment_status' AND status_payment.locale = 'th')\
		LEFT JOIN status_translates as status_item ON ( status_item.slug = items.item_status AND status_item.type = 'item_status' AND status_item.locale = 'th')\
		WHERE items.order_id = %s" % order_id

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        data = []
        total_item = 0
        for index in range(len(rows)):
            val = {}
            val['item_id'] = rows[index][0]
            val['inventory_id'] = rows[index][1]
            val['item_name'] = rows[index][2]
            val['quantity'] = rows[index][3]
            val['item_price'] = rows[index][4]
            val['tracking_number'] = rows[index][5]
            val['payment_status_customer'] = rows[index][6]
            val['item_status_customer'] = rows[index][7]
            total_item += rows[index][3] 
            val['total_item'] = total_item
            val['item_status'] = rows[index][8]
            val['payment_status'] = rows[index][9]
            data.append(val)
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

        
def py_get_order_by_customer_tel(customer_tel=None):
    if customer_tel is None : 
        return None 
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT orders.id,\
        orders.customer_tel FROM `orders`\
        WHERE orders.customer_tel = '%s' \
        ORDER BY orders.id DESC LIMIT 1" % customer_tel

    # return query
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        row = cursor.fetchone()
        data = {}
        data["order_id"] = row[0]
        data["customer_tel"] = row[1]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()    


        
        
        
#r = create_order()
#print r