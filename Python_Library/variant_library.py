import MySQLdb as db
import socket
from ConnectDB import *  

def get_available_inventory_id():
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()
    try : 
        query = "SELECT DISTINCT `variants`.`inventory_id` \
            FROM `variants` \
            INNER JOIN `products` ON `products`.`id` = `variants`.`product_id` \
            INNER JOIN `product_collections` ON `product_collections`.`product_id` = `products`.`id` \
            INNER JOIN `collections` ON `collections`.`id` = `product_collections`.`collection_id` \
            INNER JOIN `apps_collections` ON `apps_collections`.`collection_id` = `collections`.`id` \
            INNER JOIN `brands` ON `brands`.`id` = `products`.`brand_id` \
            WHERE `variants`.`deleted_at` is null \
            AND `variants`.`status` = 'active' \
            AND `variants`.`stock_type` = 1  \
            AND `products`.`status` = 'publish' \
            AND `products`.`active` = 1 \
            AND `products`.`has_variants` = 1 \
            AND `products`.`deleted_at` is null \
            AND `collections`.`deleted_at` is null \
            AND `collections`.`parent_id` = 0 \
            AND `apps_collections`.`app_id` = 1 \
            AND `brands`.`deleted_at` is null \
            ORDER BY RAND() \
            LIMIT 0, 1 "

        cursor.execute(query)
        rows = cursor.fetchone()
        inventory_id = rows[0]
        BuiltIn().log_to_console('------ get_available_inventory_id : inventory_id = %s' % inventory_id)
        return inventory_id

    except Exception, e:
        BuiltIn().log_to_console('DB exception : get_available_pinventory_id : %s' % e) 
        return False

def get_two_available_product_id_from_variant():
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try : 
        query = "SELECT `products`.`id`   \
                    FROM `variants` \
                    INNER JOIN `products` ON `products`.`id` = `variants`.`product_id` \
                    INNER JOIN `product_collections` ON `product_collections`.`product_id` = `products`.`id` \
                    INNER JOIN `collections` ON `collections`.`id` = `product_collections`.`collection_id` \
                    INNER JOIN `apps_collections` ON `apps_collections`.`collection_id` = `collections`.`id` \
                    INNER JOIN `app_category_collections` ON `app_category_collections`.`collection_id` = `collections`.`id` \
                    INNER JOIN `brands` ON `brands`.`id` = `products`.`brand_id` \
                    INNER JOIN `imported_materials` ON `imported_materials`.`inventory_id` = `variants`.`inventory_id`\
                    WHERE ( SELECT count( vo.variant_id ) FROM variant_style_options vo WHERE `variants`.`id` = vo.variant_id  ) = 0\
                    AND `variants`.`deleted_at` is null \
                    AND `variants`.`status` = 'active' \
                    AND `variants`.`stock_type` = 1 \
                    AND `products`.`status` = 'publish'\
                    AND `products`.`active` = 1\
                    AND `products`.`title` NOT LIKE '%qct%' \
                    AND `products`.`title` NOT LIKE '%automate%' \
                    AND `products`.`title` NOT LIKE '%robot%' \
                    AND `products`.`title` NOT LIKE '%phoenix%' \
                    AND `products`.`title` NOT LIKE '%flash%' \
                    AND `products`.`title` NOT LIKE '%thor%' \
                    AND `products`.`deleted_at` is null\
                    AND `products`.`pkey` not in (SELECT pkey FROM product_verify_pendings) \
                    AND `collections`.`deleted_at` is null\
                    AND `collections`.`parent_id` = 0\
                    AND `brands`.`deleted_at` is null \
                    ORDER BY RAND() \
                    LIMIT 5,10"
        
        cursor.execute(query)
        rows = cursor.fetchall()

        product_id_list = [rows[0][0],rows[1][0]]
        BuiltIn().log_to_console("======== get_two_available_product_id_from_variant ======== %s" % product_id_list)
        return product_id_list

    except Exception, e:
        BuiltIn().log_to_console('DB exception: %s' % e) 
        return False

def get_inventory_id_from_product_id(product_id):
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
	cursor = mydb.cursor()

	try : 
		query = "SELECT `inventory_id` FROM `variants` WHERE `product_id` = %i" % (product_id)
        
		cursor.execute(query)
		row = cursor.fetchone()

		inventory_id = row[0]
		return inventory_id

	except Exception, e:
		BuiltIn().log_to_console('DB exception: %s' % e) 
		return False

def get_original_shop_id_by_inventory_id(inventory_id):
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
	cursor = mydb.cursor()

	try : 
		query = "SELECT `shop_id` FROM `variants` WHERE `inventory_id` = '%s'" % (inventory_id)
        
		cursor.execute(query)
		row = cursor.fetchone()

		shop_id = row[0]
		return shop_id

	except Exception, e:
		BuiltIn().log_to_console('DB exception: %s' % e) 
		return False

def assign_shop_id_to_existing_inventory_id(shop_id, inventory_id):
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
	cursor = mydb.cursor()

	try:
		query = "UPDATE `variants` \
				SET shop_id=%s \
				WHERE inventory_id='%s'" % (shop_id, inventory_id)
		#BuiltIn().log_to_console(query)
		cursor.execute(query)
		mydb.commit()
		return True

	except Exception, e:
		BuiltIn().log_to_console('DB exception: %s' % e)
		mydb.rollback() 
		return False

def get_variant_by_product_id(product_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = "SELECT id, inventory_id, status FROM `variants` \
			WHERE product_id = %s \
			" % product_id

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        return rows;

    except:
        print "Cannot fetch data."
    mydb.close()

def get_product_have_2_variants_by_product_active_status(product_active):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = " SELECT p2v.id, p2v.title \
    FROM \
        (SELECT p.id , p.title, count(v.inventory_id) as inventory_count \
        FROM products p \
        INNER JOIN variants v on p.id = v.product_id \
        WHERE p.status = 'publish' and p.active = '%s' \
        GROUP BY p.id \
        HAVING inventory_count = 2 \
        ) AS p2v \
    INNER JOIN variants v on v.product_id = p2v.id \
    WHERE v.status = 'active' \
    GROUP BY p2v.id , p2v.title \
    ORDER BY p2v.id \
    "% product_active

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        row = cursor.fetchone()
        return row

    except:
        print "Cannot fetch data."
    mydb.close()

def update_variants_status_by_inventory_id(inventory_id, status):
   mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

   query = "UPDATE variants  \
   SET  status = '%s' \
   WHERE `inventory_id` = '%s' \
   " % (status, inventory_id)

   cursor = mydb.cursor()
   try:
        cursor.execute(query)
        mydb.commit()
   except:
        mydb.rollback()
        print "update variants status by product id fail"
   mydb.close()
