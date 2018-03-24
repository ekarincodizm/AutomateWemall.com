import MySQLdb as db
from ConnectDB import *
from robot.libraries.BuiltIn import BuiltIn

def py_get_category_collection():
	mysqlDb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
	query = "SELECT * FROM `collections` as c JOIN `app_category_collections` as a ON `c`.`id` = `a`.`collection_id` WHERE `c`.`is_category` = 1 and `c`.`deleted_at` is null"
	try:
		cursor = mysqlDb.cursor()
		cursor.execute(query)
		columns = cursor.description
		result = cursor.fetchone()
		category = {}
		for (index,column) in enumerate(result):
			category[columns[index][0]] = column
		return category
	except Exception, e:
		BuiltIn().log_to_console('DB exception: %s' % e)

def py_get_category_collection_slug_pkey_text():
	category = py_get_category_collection()
	text = '%s-%s' % (category['slug'],category['pkey'])
	return text

def py_get_category_collection_pkey():
	category = py_get_category_collection()
	return category['pkey']