import MySQLdb as db
import socket
from ConnectDB import *  

def py_delete_merchant_alias(alias = None) :
	try:
		mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

		merchant_alias_id = get_merchant_alias_by_merchant_name(alias)
		query = "DELETE FROM `product_merchant_alias` \
			WHERE `product_merchant_alias`.`merchant_alias_id` = %s \
				" % merchant_alias_id

		cursor = mydb.cursor()
		result = cursor.execute(query)

		query = "DELETE FROM `merchant_alias` \
			WHERE `merchant_alias`.`id` = %s \
			" % merchant_alias_id

		cursor = mydb.cursor()
		result = cursor.execute(query)

		mydb.commit()

		return True

	except Exception, e:
		mydb.rollback()
		return BuiltIn().log_to_console('DB exception: %s' % e)


def create_alias():
	mySqlDb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	try:
		query = "INSERT INTO `merchant_alias` (`id`, `name`, `merchant_code`, `user_id`, `created_at`, `updated_at`, `deleted_at`) VALUES \
				(NULL, 'Automated Test', 'AM99999', 35, '2016-05-26 12:00:00', '2016-05-26 12:00:00', NULL)"

		cursor = mySqlDb.cursor()
		cursor.execute(query)
		mySqlDb.commit()

		return True

	except:
		mySqlDb.rollback()
		return False

def py_create_alias_data(alias, merchant_code) : 
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)	
	try :
		query = "INSERT INTO `merchant_alias` ( \
			  `id`, `name`, `merchant_code` \
			, `user_id`, `created_at`, `updated_at`, `deleted_at`) \
			VALUES ( \
			   NULL, '%s', '%s' \
			, 35, NOW(), NOW(), NULL)" % (alias, merchant_code)
		cursor = mydb.cursor()
		cursor.execute(query)
		mydb.commit()
		return cursor.lastrowid

	except : 
		mydb.rollback()
		return False 

def py_delete_by_alias_and_code(alias_name, merchant_code) : 
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)	
	try :
		query = "DELETE FROM `merchant_alias` WHERE \
				name = '%s' AND merchant_code = '%s' " % (alias_name, merchant_code)
		cursor = mydb.cursor()
		cursor.execute(query)
		mydb.commit()
		return True

	except : 
		mydb.rollback()
		return False 	

def delete_products_in_alias():
	mySqlDb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	try:
		merchantAliasId = get_merchant_alias_by_merchant_name()
		query = "DELETE FROM `product_merchant_alias` WHERE `merchant_alias_id`= %s" % (merchantAliasId)

		cursor = mySqlDb.cursor()
		cursor.execute(query)
		mySqlDb.commit()

		return True

	except:
		mySqlDb.rollback()
		return False

def delete_alias():
	mySqlDb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	try:
		delete_products_in_alias()
		query = "DELETE FROM `merchant_alias` WHERE `name` LIKE '%Automated Test%'"

		cursor = mySqlDb.cursor()
		cursor.execute(query)
		mySqlDb.commit()

		return True

	except:
		mySqlDb.rollback()
		return False

def get_product_id():
	mySqlDb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	try:
		queryProduct = "SELECT `products`.`id` FROM `products` \
						LEFT JOIN `product_merchant_alias` ON `products`.`id` = `product_merchant_alias`.`product_id` \
						WHERE `products`.`status` = 'publish' \
						AND `products`.`active` = '1' \
						AND `product_merchant_alias`.`product_id` IS NULL \
						ORDER BY `products`.`created_at` DESC"

		cursor = mySqlDb.cursor()
		cursor.execute(queryProduct)
		productId = cursor.fetchone()

		return productId[0]

	except:
		mySqlDb.rollback()
		return False

def get_merchant_alias_by_merchant_name(name='Automated Test'):
	mySqlDb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)


	try:
		query = "SELECT `id` FROM `merchant_alias` WHERE `name` = '%s'" % (name)

		cursor = mySqlDb.cursor()
		cursor.execute(query)
		merchantName = cursor.fetchone()
		
		return merchantName[0]

	except:
		mySqlDb.rollback()
		return False


def assign_product_to_alias(alias='Automated Test'):
	mySqlDb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	try:
		productId = get_product_id()
		merchantAliasId = get_merchant_alias_by_merchant_name(alias)
		query = "INSERT INTO `product_merchant_alias` (`id`, `product_id`, `merchant_alias_id`, `user_id`, `created_at`, `source`)  \
				VALUES (NULL, %s, %s, '35', CURRENT_TIMESTAMP, 'manual')" % (productId, merchantAliasId)

		cursor = mySqlDb.cursor()
		cursor.execute(query)
		mySqlDb.commit()

		return True

	except:
		mySqlDb.rollback()
		return False


#def assign_mass_product_to_alias(total_product=1, alias='Automated Test') :
#	mydb =  

def create_30_alias():
	mySqlDb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	try:
		for i in range(1, 32):
			alisa_name = 'Automated Test' + str(i)
			query = "INSERT INTO `merchant_alias` (`id`, `name`, `merchant_code`, `user_id`, `created_at`, `updated_at`, `deleted_at`) VALUES \
					(NULL, '%s', 'AM99999', 35, '2016-05-26 12:00:00', '2016-05-26 12:00:00', NULL)" % alisa_name

			cursor = mySqlDb.cursor()
			cursor.execute(query)

		mySqlDb.commit()

		return True

	except:
		mySqlDb.rollback()
		return False
