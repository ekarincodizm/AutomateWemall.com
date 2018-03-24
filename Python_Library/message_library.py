from ConnectDB import *
def email_has_been_sent(order_id=None) : 
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "SELECT *  \
		FROM messages M \
		WHERE `M`.`status` = 'sent' \
		AND `M`,`channel` = 'gmail' \
		AND `M`.`messagable_id` = '%s' \
		" % order_id
	cursor = mydb.cursor()
	try : 
		cursor.execute(query)


	except : 
		return "XX"

def sms_has_been_sent(order_id=None) : 
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
	
	query = "SELECT *  \
		FROM messages M \
		WHERE `M`.`status` = 'sent' \
		AND `M`,`channel` = 'sms' \
		AND `M`.`messagable_id` = '%s' \
		" % order_id
	cursor = mydb.cursor()
	try : 
		cursor.execute(query)


	except : 
		return "XX"

def get_message(order_id=None, action_name=None, channel=None, status=None) : 

	if order_id is None : 
		return None 

	if action_name is None : 
		return None 

	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
	
	query = "SELECT count(*) as count_row  \
		FROM `messages` `M` \
		WHERE `M`.`status` = 'sent' \
		AND `M`.`channel` = 'gmail' \
		AND `M`.`action_name` = '%s' \
		AND `M`.`messagable_id` = %s \
		" % (action_name, order_id)
	cursor = mydb.cursor()
	try : 
		cursor.execute(query)
		row = cursor.fetchone()
		return row

	except : 
		return "XX"

def delete_message_by_order(order_id=None) : 
	if order_id is None : 
		return None 
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
	
	try : 
		query = "DELETE FROM `messages` \
			WHERE `messages`.`messagable_id` = %s \
			AND `messages`.`messagable_type` = 'Order' \
			" % order_id

		cursor = mydb.cursor()

		cursor.execute(query)
		mydb.commit()
		return True

	except Exception, e : 
		BuiltIn().log_to_console('DB exception: %s' % e) 
		mydb.rollback()
		return False

def get_email_by_delivery(order_id=None, customer_email=None, delivery_time=None, delivery_text=None, action_name='thankyou-page') :
	if (order_id is None) or (customer_email is None) or (delivery_time is None) or (delivery_text is None) :
		return None

	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
	
	try : 
		query = "SELECT count(*) as count_row  \
		FROM `messages` `M` \
			WHERE `M`.`status` = 'sent' \
			AND `M`.`channel` = 'gmail' \
			AND `M`.`messagable_type` = 'Order' \
			AND `M`.`messagable_id` = %s \
			AND `M`.`action_name` = '%s' \
			AND `M`.`send_to` = '%s' \
			AND (`M`.`content` LIKE '%%%s%%' AND `M`.`content` LIKE '%%%s%%') \
			" % (order_id, action_name, customer_email, delivery_time, delivery_text)

		BuiltIn().log_to_console(query)
		cursor = mydb.cursor()

		cursor.execute(query)
		row = cursor.fetchone()
		return row[0]

	except Exception, e : 
		BuiltIn().log_to_console('DB exception: %s' % e) 
		return False

def py_get_sms_by_delivery_txt(order_id=None, action_name=None, delivery_time=None) : 

	if order_id is None : 
		return None 

	if action_name is None : 
		return None 

	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
	
	query = "SELECT count(*) as count_row  \
		FROM `messages` `M` \
		WHERE `M`.`status` = 'sent' \
		AND `M`.`channel` = 'sms' \
		AND `M`.`action_name` = '%s' \
		AND `M`.`messagable_id` = %s \
		AND `M`.`content` LIKE '%%%s%%' \
		" % (action_name, order_id, delivery_time)
	cursor = mydb.cursor()
	try : 
		cursor.execute(query)
		row = cursor.fetchone()
		return row[0]

	except Exception, e : 
		BuiltIn().log_to_console('DB exception: %s' % e) 
		return 0

import MySQLdb as db 
from ConnectDB import *

def get_sms_thankyou(order_id=None) : 
	if order_id is None : 
		return None 
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "SELECT subject, send_to, channel, content, response \
		FROM `messages` `M` \
		WHERE `M`.`status` = 'sent' \
		AND `M`.`messagable_id` = '%s' \
		AND `M`.`channel` = 'sms' \
		AND `M`.`action_name` = 'thankyou-page' \
		" % order_id
	cursor = mydb.cursor()
	try : 
	
		result = cursor.execute(query)
		rows = cursor.fetchall()
		return rows[0]

	except : 
		return "None"


def get_email_thankyou(order_id=None) : 
	if order_id is None : 
		return None 
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "SELECT subject, send_to, channel, content \
		FROM `messages` `M` \
		WHERE `M`.`status` = 'sent' \
		AND `M`.`messagable_id` = '%s' \
		AND `M`.`channel` = 'gmail' \
		AND `M`.`action_name` = 'thankyou-page' \
		" % order_id
	cursor = mydb.cursor()
	try : 
	
		result = cursor.execute(query)
		rows = cursor.fetchall()
		return rows[0]

	except : 
		return "None"

def get_email_mnp(order_id=None) : 
	if order_id is None : 
		return None 
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "SELECT subject, send_to, channel, content \
		FROM `messages` `M` \
		WHERE `M`.`status` = 'sent' \
		AND `M`.`messagable_id` = '%s' \
		AND `M`.`channel` = 'gmail' \
		AND `M`.`action_name` = 'register-truemoveh-mnp' \
		" % order_id
	cursor = mydb.cursor()
	try : 
	
		result = cursor.execute(query)
		rows = cursor.fetchall()
		return rows[0]

	except : 
		return "None"

def get_email_register_truemoveh(order_id=None) : 
	if order_id is None : 
		return None 
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "SELECT subject, send_to, channel, content \
		FROM `messages` `M` \
		WHERE `M`.`status` = 'sent' \
		AND `M`.`messagable_id` = '%s' \
		AND `M`.`channel` = 'gmail' \
		AND `M`.`action_name` = 'register-truemoveh' \
		" % order_id
	cursor = mydb.cursor()
	try : 
	
		result = cursor.execute(query)
		rows = cursor.fetchall()
		return rows[0]

	except : 
		return "None"

def get_email_activate_success_truemoveh(order_id=None) :
	if order_id is None :
		return None
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "SELECT subject, send_to, channel, content \
		FROM `messages` `M` \
		WHERE `M`.`status` = 'sent' \
		AND `M`.`messagable_id` = '%s' \
		AND `M`.`channel` = 'gmail' \
		AND `M`.`action_name` = 'activatesuccess-truemoveh' \
		" % order_id
	cursor = mydb.cursor()
	try :

		result = cursor.execute(query)
		rows = cursor.fetchall()
		return rows[0]

	except :
		return "None"

def get_email_activate_fail_truemoveh(order_id=None) :
	if order_id is None :
		return None
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "SELECT subject, send_to, channel, content \
		FROM `messages` `M` \
		WHERE `M`.`status` = 'sent' \
		AND `M`.`messagable_id` = '%s' \
		AND `M`.`channel` = 'gmail' \
		AND `M`.`action_name` = 'activatefail-truemoveh' \
		" % order_id
	cursor = mydb.cursor()
	try :

		result = cursor.execute(query)
		rows = cursor.fetchall()
		return rows[0]

	except :
		return "None"

def get_email_after_success(order_id=None) :
	if order_id is None :
		return None
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "SELECT subject, send_to, channel, content \
		FROM `messages` `M` \
		WHERE `M`.`status` = 'sent' \
		AND `M`.`messagable_id` = '%s' \
		AND `M`.`channel` = 'gmail' \
		AND `M`.`action_name` = 'payment-success' \
		" % order_id
	cursor = mydb.cursor()
	try :

		result = cursor.execute(query)
		rows = cursor.fetchall()
		return rows[0]

	except :
		return "None"

def get_thankyou_send_smail(order_id, email) : 

    if order_id is None : 
        return None 
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    try : 		 
        query = "SELECT * FROM `messages` WHERE `messagable_id` = '%s' AND `action_name` = 'thankyou-page' AND `send_to` = '%s' and `status` = 'sent' and `messagable_type` = 'Order'" %(order_id,email)  
        # BuiltIn().log_to_console(query)
        cursor = mydb.cursor()
        result = cursor.execute(query)
        row = cursor.fetchone()
        #return True
        return row 

    except : 
        mydb.rollback()
        return False
