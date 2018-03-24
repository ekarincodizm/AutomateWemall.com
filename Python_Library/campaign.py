import MySQLdb as db
from ConnectDB import *  
from robot.libraries.BuiltIn import BuiltIn

def is_exist_campaign(campaign_name=None) : 
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "SELECT `campaigns`.`id` FROM `campaigns` \
		WHERE `name` = '%s' \
		" % campaign_name

	cursor = mydb.cursor()
	r = cursor.execute(query)
	row = cursor.fetchone()
	#BuiltIn().log_to_console("========")
	#BuiltIn().log_to_console(row)
	#BuiltIn().log_to_console("========")
	if row is None : 
	 	return False
	
	return True

def set_campaign_deactivate(campaign_id=None) : 
	
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "UPDATE `campaigns` \
		SET `status` = 'deactivate' \
		WHERE `id` = %s \
		" % campaign_id

	#BuiltIn().log_to_console("set campapign expire = " + query)
	cursor = mydb.cursor()
	r = cursor.execute(query)
	mydb.commit()
	
	mydb.close()
	return r 

def set_campaign_activate(campaign_id=None) : 
	
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "UPDATE `campaigns` \
		SET `status` = 'activate' \
		WHERE `id` = %s \
		" % campaign_id

	#BuiltIn().log_to_console("set campapign expire = " + query)
	cursor = mydb.cursor()
	r = cursor.execute(query)
	mydb.commit()
	
	mydb.close()
	return r 


def set_campaign_expire(campaign_id=None):

	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "UPDATE `campaigns` \
		SET `start_date` = '2015-01-01 00:00:00', `end_date` = '2015-02-01 00:00:00' \
		WHERE `id` = %s \
		" % campaign_id

	#BuiltIn().log_to_console("set campapign expire = " + query)
	cursor = mydb.cursor()
	r = cursor.execute(query)
	mydb.commit()
	
	mydb.close()
	return r 

def set_campaign_not_expire(campaign_id=None):

	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "UPDATE `campaigns` \
		SET `start_date` = '2015-01-01 00:00:00', `end_date` = '2019-02-01 00:00:00' \
		WHERE `id` = %s \
		" % campaign_id

	cursor = mydb.cursor()
	r = cursor.execute(query)
	mydb.commit()
	
	mydb.close()
	return r 


def get_campaign_id_by_name(campaign_name=None):

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT `campaigns`.`id` FROM `campaigns` \
		WHERE `name` = '%s' ORDER BY `id` desc LIMIT 1 \
		" % campaign_name
	
    #BuiltIn().log_to_console(query)		
    cursor = mydb.cursor()
    cursor.execute(query)
    row = cursor.fetchone()

    mydb.close()

    BuiltIn().log_to_console(row)
    return row[0]

	