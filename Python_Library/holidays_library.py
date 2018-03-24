# import MySQLdb as db
import socket
import datetime
from ConnectDB import *
from robot.libraries.BuiltIn import BuiltIn

def test():
	pass

def py_insert_holidays(started_at='CURDATE()',ended_at=None) :
	if ended_at==None:
		ended_at=started_at

	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
	cursor = mydb.cursor()

	try : 
		query = "INSERT INTO `holidays` (`title`, `description`, `started_at`, `ended_at`, `created_at`, `updated_at`)  \
            VALUES('Robot Holiday(s)', 'Robot absent on this/these day(s)', '%s', '%s', NOW(), NOW()) \
        " % (started_at, ended_at)
		result = cursor.execute(query)
		row_id = cursor.lastrowid
		mydb.commit()
		return row_id

	except Exception, e:
		return BuiltIn().log_to_console('DB exception: %s' % e)

def py_delete_holidays(holiday_id=None) :
	if holiday_id==None:
		return False

	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
	cursor = mydb.cursor()
	try : 
		query = "DELETE FROM `holidays` WHERE id = '%s'" % (holiday_id)
		cursor.execute(query)
		mydb.commit()
		return True

	except Exception, e:
		return BuiltIn().log_to_console('DB exception: %s' % e)
