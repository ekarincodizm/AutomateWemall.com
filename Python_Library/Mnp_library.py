import MySQLdb as db

from ConnectDB import *  
import socket
import datetime
dt = datetime.datetime.now()


robot_campaign_name = "Campaign Name"

def delete_edm_by_prefix(prefix=None, campaign_name=None):
	if prefix is None : 
		return None 

	if campaign_name is None : 
		return None

	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	try : 
		query = "DELETE FROM edms \
				WHERE prefix = '%s'" % prefix
		cursor = mydb.cursor()
		result = cursor.execute(query)
		mydb.commit()
		return True

	except : 
		mydb.rollback()
		return False

def check_not_exist_edm_by_prefix(prefix=None):
	if prefix is None : 
		return None 

	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	try : 
		query = "SELECT count(*) FROM edms \
				WHERE prefix = '%s' " % (prefix)
		print query
		cursor = mydb.cursor()
		cursor.execute(query)
		result = cursor.fetchone()
		print result[0]
		if result[0] < 1:
			return True
		else:
			return False

	except : 
		print "Cannot fetch edm data by prefix ."
		return False

def create_truemoveh_order_verify(fields=None) : 
	if fields is None : 
		return None

	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
	cursor = mydb.cursor()

	if fields.has_key('created_at') : 
		created_at = fields["created_at"]
	else : 
		created_at = dt.isoformat()
	try : 
		query = " INSERT INTO `truemoveh_order_verifys` \
			( \
			`idcard`, \
			`status`, \
			`activate_status`, \
			`mnp1_status`, \
			`mobile`, \
			`created_at`, \
			`deleted_at`, \
			`updated_at`, \
			`bundle_type` \
			) \
			VALUES ('%s', '%s', '%s', '%s', '%s', '%s', NULL, NOW(), 'mnp') \
		" % (fields["idcard"], fields["status"], fields["activate_status"], fields["mnp1_status"], fields["mobile"], created_at)
		#return query 
		result = cursor.execute(query)
		data = {}
		data["status"] = True
		data["lastid"] = cursor.lastrowid
		mydb.commit()
		return data
	except: 
		mydb.rollback();
		data = {}
		data["status"] = False
		return data

def delete_from_truemoveh_order_verify(pid=None) : 
	if pid is None : 
		return None 
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
	cursor = mydb.cursor()
	try : 
		query = " DELETE FROM `truemoveh_order_verifys` \
			WHERE `id` = '%s' \
		" % pid
		result = cursor.execute(query)
		mydb.commit()
		return True
	except: 
		mydb.rollback()
		return False


def delete_order_verify_by_mobile_number(mobile=None) : 
	if mobile is None : 
		return None 
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
	cursor = mydb.cursor()
	try : 
		query = " DELETE FROM `truemoveh_order_verifys` \
			WHERE `mobile` = '%s' \
		" % mobile
		result = cursor.execute(query)
		mydb.commit()
		return True
	except: 
		mydb.rollback()
		return False	

def check_not_exist_proposition_by_source_type(source_type=None):
	if source_type is None : 
		return False 

	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	print dbhost
	try : 
		query = "SELECT count(*) FROM truemoveh_propositions JOIN truemoveh_proposition_maps \
				ON truemoveh_propositions.id = truemoveh_proposition_maps.proposition_id \
				WHERE truemoveh_propositions.status = 'Y' \
				AND truemoveh_propositions.deleted_at is null \
				AND truemoveh_proposition_maps.deleted_at is null \
				AND truemoveh_propositions.source_type = '%s' " % (source_type)
		print query
		cursor = mydb.cursor()
		cursor.execute(query)
		result = cursor.fetchone()
		print result[0]
		if result[0] < 1:
			return True
		else:
			return False

	except : 
		print "Cannot fetch proposition data by source type ."
		return False

def check_exist_edm(prefix=None) : 
	if prefix is None : 
		return None 

	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	try : 
		query = "SELECT count(*) FROM edms \
		WHERE prefix = '%s' " % prefix
		cursor = mydb.cursor()
		cursor.execute(query)
		result = cursor.fetchone()
		print result[0]
		if result[0] > 0:
			return True
		else:
			return False

	except : 
		print "Cannot fetch proposition data by source type ."
		return False	



