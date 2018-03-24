from ConnectDB import *
from random import randint

def get_data_from_list_by_index(data, index):
    try:
        return data[int(index)]
    except:
        return ""

def get_random_bundle_order_with_payment_status_success() :
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = "SELECT orders.id FROM orders LEFT JOIN order_shipment_items ON orders.id = order_shipment_items.order_id WHERE order_shipment_items.bundle = 'Y' AND orders.payment_status = 'success' GROUP BY orders.id"
    try :
       	cursor = mydb.cursor()
        cursor.execute(query)
        rows = cursor.fetchall()

        if len(rows) == 0:
        	return False
        
        random = randint(0,len(rows)-1)
        return rows[random][0]

    except :
        print "Error Querying Database"