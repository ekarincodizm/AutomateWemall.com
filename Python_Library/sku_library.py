import MySQLdb as db
import socket
from ConnectDB import *  

def py_delete_sku_from_imported_material(skuID=None):
	
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	try : 
		query = "DELETE FROM imported_materials \
				WHERE inventory_id = '%s' \
				AND deleted_at IS NULL \
				" % skuID
		cursor = mydb.cursor()
		result = cursor.execute(query)
		mydb.commit()
		return True

	except : 
		mydb.rollback()
		return False

def count_record_in_imported_material_by_skuID(skuID=None):
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	try :
		query = "SELECT COUNT(id) FROM imported_materials \
				WHERE inventory_id = '%s'	\
				AND deleted_at IS NULL	\
				" % skuID
		cursor = mydb.cursor()
		result = cursor.execute(query)

		return result

	except :
		return -1

def py_delete_sku_from_varaint(skuID=None):
	
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	try : 
		query = "DELETE FROM variants \
				WHERE inventory_id = '%s' \
				AND deleted_at IS NULL \
				" % skuID
		cursor = mydb.cursor()
		result = cursor.execute(query)
		mydb.commit()
		return True

	except : 
		mydb.rollback()
		return False

def py_delete_product_by_title(productTitle=None):
	
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	try : 
		query = "DELETE FROM products \
				WHERE title = '%s' \
				" % productTitle
		cursor = mydb.cursor()
		result = cursor.execute(query)
		mydb.commit()
		return True

	except : 
		mydb.rollback()
		return False

def insert_dummy_record_with_no_shop():

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try : 
        query = "INSERT INTO `imported_materials` (`id`,`variant_id`,`master_id`,`shop_id`,`id_vendor`,`vendor_name`,`material_code`,`inventory_id`,`inventory_id_old`,`inventory_id_new`,`sku_vendor`,`stock_type`,`stock_status`,`status`,`remark`,`name`,`color`,`size`,`brand`,`gen`,`surface`,`linesheet`,`detail`,`material_description`,`plant`,`unit_type`,`image_preview_1`,`image_preview_2`,`image_preview_3`,`image_production_1`,`image_production_2`,`image_production_3`,`price`,`normal_price`,`price_inc_vat`,`cost_rtp`,`is_sourcing_select`,`select_time`,`sc_create_time`,`is_sap`,`group_type`,`stock_safety_type`,`movement_at`,`created_at`,`updated_at`,`deleted_at`,`long_text`,`short_text`,`category_id`,`model`) VALUES \
         (NULL,NULL,NULL,NULL,NULL,NULL,'0','RobotSku1',NULL,NULL,NULL,'1','in','wait',NULL,'RobotSku1',NULL,NULL,'1-2-Wink',NULL,NULL,NULL,NULL,NULL,NULL,'piece','','','','','','',NULL,1.00,NULL,1.00,0,NULL,NULL,0,0,'standard',NULL,'2016-04-05 11:44:09','2016-04-05 11:44:09',NULL,NULL,NULL,'C171003000000',NULL);"

        result = cursor.execute(query)
        row_id = cursor.lastrowid
        mydb.commit()
        return True

    except: 
        mydb.rollback();
        return False

def count_record_in_variant_by_skuID(skuID=None):
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	try :
		query = "SELECT COUNT(*) FROM variants \
				WHERE inventory_id = '%s'	\
				AND deleted_at IS NULL	\
				" % skuID
		cursor = mydb.cursor()
		cursor.execute(query)
		res = cursor.fetchone()
		total_rows = res[0] 

		return total_rows

	except :
		return -1