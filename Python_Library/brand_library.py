import MySQLdb as db
from ConnectDB import *
from robot.libraries.BuiltIn import BuiltIn

def py_get_brand():
	mysqlDb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
	query = "SELECT * FROM `brands` as b \
	WHERE `b`.`attachment_id` is not null \
	AND `b`.`attachment_id` != '' \
	AND `b`.`slug` is not null \
	AND `b`.`deleted_at` is null \
	order by id"
	try:
		cursor = mysqlDb.cursor()
		cursor.execute(query)
		columns = cursor.description
		result = cursor.fetchone()
		brand = {}
		for (index,column) in enumerate(result):
			brand[columns[index][0]] = column
		return brand
	except Exception, e:
		BuiltIn().log_to_console('DB exception: %s' % e)

def py_get_brand_slug_pkey_text():
	brand = py_get_brand()
	text = '%s-%s' % (brand['slug'],brand['pkey'])
	return text
def py_get_brand_pkey():
	brand = py_get_brand()
	return brand['pkey']