import MySQLdb as db
import socket
from ConnectDB import *  

def py_delete_product_merchant_alias_by_alias_id(alias_id=None) : 
	if alias_id is None : 
		return None 

	try:
		mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

		query = "DELETE FROM `product_merchant_alias` \
			WHERE `merchant_alias_id` = '%s' \
			" % alias_id
			
		cursor = mydb.cursor()
		result = cursor.execute(query)


		mydb.commit()
		return True

	except Exception, e:
		mydb.rollback()

		return BuiltIn().log_to_console('DB exception: %s' % e)