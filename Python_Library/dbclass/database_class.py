import MySQLdb as db
from ConnectDB import *
	
def execute(query_str):
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
	cursor = mydb.cursor()
	result = None
	try:
		cursor.execute(query_str)
		mydb.commit()
		result = cursor.fetchall()
	except Exception as e:
		print e
		print 'database_class execute failed'
		mydb.rollback()
	mydb.close()
	return result
