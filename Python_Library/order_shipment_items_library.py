from ConnectDB import *
from robot.libraries.BuiltIn import BuiltIn

def get_item_id(order_id=None, inventory_id=None) :
	if order_id is None :
		return None

	if inventory_id is None :
		return None

	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "SELECT id FROM `order_shipment_items` \
		WHERE `order_id` = %s \
		AND inventory_id = '%s'\
		" % (order_id, inventory_id)
	cursor = mydb.cursor()
	try :

		result = cursor.execute(query)
		rows = cursor.fetchall()
		return rows[0]

	except :
		return "None"


def get_all_item(order_id=None) :
	if order_id is None :
		return None

	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "SELECT * FROM `order_shipment_items` \
		WHERE `order_id` = %s " % (order_id)
	cursor = mydb.cursor()
	try :
		result = cursor.execute(query)
		rows = cursor.fetchall()
		return rows

	except :
		return "None"


def get_item_used_by_Cron() :

	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "select max(b.created_at) as create_at , b.item_status, b.order_shipment_item_id, b.id, a.order_id, a.operation_status \
			from order_shipment_items as a \
			left join transaction_order_item_statuses as b \
			on a.id = b.order_shipment_item_id where a.item_status='return_pending' \
			and b.item_status='return_pending' \
			and DATE(b.created_at) < CURDATE() - INTERVAL 10 DAY \
			group by b.item_status, b.order_shipment_item_id, a.order_id, a.operation_status ORDER BY b.id asc LIMIT 10"
	cursor = mydb.cursor()

	result = cursor.execute(query)
	rows = cursor.fetchall()
	return rows


def check_all_shipment_items_have_delivered_status(items):

    items_array = None
    if items is None:
        items_array = (0)
    else:
        items_array = ', '.join(items)

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = "SELECT count(id) FROM order_shipment_items WHERE id IN (%s) AND item_status = 'Delivered'" % (items_array)

    try:
        cursor = mydb.cursor()
        cursor.execute(query)
        rows = cursor.fetchone()

        if rows[0] == len(items):
            return True
        else:
            return False

    except:
        print "Error Querying Database"


def get_order_id_by_item_id(item_id=None) :
	if item_id is None :
		return None

	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "SELECT order_id FROM `order_shipment_items` WHERE `id` = %s " % (item_id)

	BuiltIn().log_to_console("Def [get_order_id_by_item_id Query] : " + query)

	cursor = mydb.cursor()
	try :

		result = cursor.execute(query)
		rows = cursor.fetchall()
		return rows[0]

	except :
		return "None"

def verify_item_status_create_date(item_id, days) :

	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "SELECT `order_shipment_item_id`  FROM `transaction_order_item_statuses` WHERE `order_shipment_item_id` = %s and DATE(created_at) < CURDATE() - INTERVAL %s DAY" % (item_id, days)
	cursor = mydb.cursor()

	try :

		result = cursor.execute(query)
		rows = cursor.fetchall()
		order_shipment_item_id = rows[0]
		if not order_shipment_item_id:
			return False

		return True

	except :
		return "None"
