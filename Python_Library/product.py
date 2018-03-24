import MySQLdb as db
from ConnectDB import *  
from robot.libraries.BuiltIn import BuiltIn

def get_option_pkey_by_variant(inventory_id=None) : 
	if inventory_id is None : 
		return None
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
	
	query = "SELECT v.id, v.inventory_id, so.pkey, so.text \
		FROM `variants` AS `v` \
		INNER JOIN `variant_style_options` AS `vso` ON `v`.`id` = `vso`.`variant_id` \
		INNER JOIN `style_options` AS `so` ON `vso`.`style_option_id` = `so`.`id` \
	WHERE `v`.`inventory_id` = '%s' " % inventory_id
	#BuiltIn().log_to_console(query)
	try : 
		cursor = mydb.cursor()
		cursor.execute(query)
		rows = cursor.fetchall()
		plist = []
		for row in rows:
			plist.append(row[2])
		return plist

	except : 
		print "Cannot fetch edm data by prefix ."
		return False

def get_1inventory_id(except_product_id = None):
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "SELECT variants.inventory_id \
	FROM variants \
	, products \
	, imported_materials \
	, (SELECT product_style_type.product_id, sum(product_style_type.style_type_id) number \
	FROM product_style_type \
	GROUP BY product_style_type.product_id) style \
	WHERE `products`.`id` = `variants`.`product_id` \
	AND `products`.`` \
	AND `variants`.`deleted_at` is null \
	AND `variants`.`status` = 'active' \
	AND `variants`.`stock_type` = 1 \
	AND products.status = 'publish' \
	AND products.active = 1 \
	AND products.has_variants = 1 \
	AND products.deleted_at is null \
	AND style.product_id = products.id \
	AND style.number = 1 \
	AND variants.inventory_id = imported_materials.inventory_id "
	if except_product_id is not None : 
		query += "AND products.id NOT IN (%s) " % except_product_id 

	query += " ORDER BY products.id, variants.id desc "
	#BuiltIn().log_to_console(query)
	cursor = mydb.cursor()
	try:
		cursor.execute(query)	
		rows = cursor.fetchone()
		return rows[0]
	except:
		print "Cannot fetch data."
	mydb.close()

def get_title_of_incomplete_product():
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "SELECT `title`  FROM `products` WHERE `status` = 'incomplete' and `has_variants` = 1 ORDER BY created_at ASC"
	
	cursor = mydb.cursor()
	try:
		cursor.execute(query)	
		rows = cursor.fetchone()
		return rows[0]
	except:
		print "Cannot fetch data."
	mydb.close()

def  get_2inventory_ids_same_collection_diff_product():
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "SELECT product_collections.collection_id, products.id, variants.inventory_id \
	FROM variants JOIN products \
	ON products.id = variants.product_id \
	JOIN product_collections \
	ON product_collections.product_id = products.id \
	JOIN collections \
	ON collections.id = product_collections.collection_id \
    JOIN apps_collections \
    ON apps_collections.collection_id = collections.id \
	JOIN (SELECT product_style_type.product_id, sum(product_style_type.style_type_id) number \
		FROM product_style_type \
		GROUP BY product_style_type.product_id) style \
	ON style.product_id = products.id \
	JOIN imported_materials \
	ON variants.inventory_id = imported_materials.inventory_id \
	WHERE style.number = 1 \
	AND collections.deleted_at is null \
	AND collections.parent_id = 0 \
	AND variants.deleted_at is null \
	AND variants.status = 'active' \
	AND variants.stock_type = 1 \
	AND products.has_variants = 1 \
	AND products.status = 'publish' \
	AND products.active = 1 \
	AND products.deleted_at is null \
    AND apps_collections.app_id = 1 \
	ORDER BY product_collections.collection_id \
	"

	cursor = mydb.cursor()
	try:
		cursor.execute(query)
		rows = cursor.fetchall()

		i = 0
		collection_id = None
		product_id = None

		for row in rows:
			if row[0] == collection_id :
				if row[1] != product_id :
					break
			collection_id = row[0]
			product_id = row[1]
			i = i+1

		data = [rows[i-1][2], rows[i][2]]
		return data
	except:
		print "Cannot fetch data."
	mydb.close()

def get_product_has_sku_diff_price() : 
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "SELECT tmp.product_id, tmp.total_different_price \
	FROM \
		( \
			SELECT \
	  			`products`.`id` as product_id \
				, COUNT(DISTINCT `variants`.`price`) as total_different_price \
			FROM \
				`variants` \
				, `products` \
 				, `imported_materials` \
		, \
		( \
			SELECT product_style_type.product_id, sum(product_style_type.style_type_id) number 	\
			FROM product_style_type \
			GROUP BY product_style_type.product_id \
	  	) style \
	WHERE \
		`products`.`id` = `variants`.`product_id` \
		AND `variants`.`deleted_at` is null \
		AND `variants`.`status` = 'active' \
		AND `variants`.`stock_type` = 1 \
		AND `products`.`status` = 'publish' \
		AND `products`.`active` = 1 \
		AND `products`.`has_variants` = 1 \
		AND `products`.`deleted_at` is null \
		AND `style`.`product_id` = `products`.`id` \
		AND `style`.`number` >= 1 \
		AND `variants`.`inventory_id` = `imported_materials`.`inventory_id` \
		AND `variants`.`price` != 0 \
	GROUP BY \
		product_id \
	) tmp \
	WHERE tmp.total_different_price > 1 \
	ORDER BY \
		tmp.product_id, tmp.total_different_price desc "
	

	#BuiltIn().log_to_console(query)
	cursor = mydb.cursor()
	try:
		cursor.execute(query)
		rows = cursor.fetchone()
		return rows[0]
	except:
		print "Cannot fetch data."
	mydb.close()	

def get_sku_by_product_id(product_id = None) : 
	if product_id is None : 
		return None 
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "SELECT `inventory_id`, `price` \
			 FROM `variants`  \
			 WHERE `product_id` = %s " % product_id

	cursor = mydb.cursor()
	try:
		cursor.execute(query)
		BuiltIn().log_to_console(query)
		rows = cursor.fetchall()
		plist = []
		inv_id = ""
		for row in rows:
			plist.append((row[0], row[1]))
			inv_id = row[0]

		data_return = {}
		data_return["data"] = plist
		data_return["inv_id"] = inv_id
		return data_return 
	except:
		BuiltIn().log_to_console("Cannot fetch data")
	 	 


def get_inventory_normal() :
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	sim_query = "select `inventory_id` from `truemoveh_sim_variants`"
	cursor = mydb.cursor()
	cursor.execute(sim_query)
	sim_list = [str(item[0]) for item in cursor.fetchall()]

	device_query = "select `inventory_id` from `truemoveh_device_proposition_group_maps`"
	cursor = mydb.cursor()
	cursor.execute(device_query)
	device_list = [str(item[0]) for item in cursor.fetchall()]

	except_list = sim_list+device_list
	except_invs = str(tuple(except_list))

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
		AND `brands`.`deleted_at` is null \
		AND `variants`.`inventory_id` not in %s \
		ORDER BY `variants`.`inventory_id` desc " % except_invs

	cursor = mydb.cursor()
	try:
		cursor.execute(query)
		rows = cursor.fetchone()
		mydb.close() 
		BuiltIn().log_to_console(rows[0])
		return rows[0]
	except:
		print "Cannot fetch data."
	mydb.close() 

def get_product_name(inv_id):
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "SELECT `products`.`title` \
	FROM `variants` \
	, `products` \
	WHERE `products`.`id` = `variants`.`product_id` \
	AND `variants`.`inventory_id` = '%s' \
	" % inv_id

	cursor = mydb.cursor()
	try:
		cursor.execute(query)
		rows = cursor.fetchone()
		return rows[0]
	except:
		print "Cannot fetch data."
	mydb.close()

def get_product_name_by_pkey(pkey):
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "SELECT `products`.`title` \
	FROM `products` \
	WHERE `products`.`pkey` = '%s' \
	" % pkey

	cursor = mydb.cursor()
	try:
		cursor.execute(query)
		rows = cursor.fetchone()
		return rows[0]
	except:
		print "Cannot fetch data."
	mydb.close()

def get_product_id(inv_id):
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "SELECT `products`.`id` \
	FROM `variants` \
	, products \
	WHERE `products`.`id` = `variants`.`product_id` \
	AND `variants`.`inventory_id` = '%s' \
	" % inv_id

	cursor = mydb.cursor()
	try:
		cursor.execute(query)
		rows = cursor.fetchone()
		return rows[0]
	except:
		print "Cannot fetch data."
	mydb.close()



def get_product_pkey(inv_id):
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "SELECT `products`.`pkey` \
	FROM `variants` \
	, `products` \
	WHERE `products`.`id` = `variants`.`product_id` \
	AND variants.inventory_id = '%s' \
	ORDER BY products.id, variants.id \
	" % inv_id

	cursor = mydb.cursor()
	try:
		cursor.execute(query)
		rows = cursor.fetchone()
		return rows[0]
	except:
		print "Cannot fetch data."
	mydb.close()

def get_product_detail(inv_id):
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "SELECT `products`.`id` \
		, `products`.`pkey` \
		, `products`.`title` \
		, `products`.`slug` \
		, `products`.`has_variants` \
	FROM `variants` \
	, `products` \
	WHERE `products`.`id` = `variants`.`product_id` \
	AND `variants`.`inventory_id` = '%s' \
	" % inv_id

	cursor = mydb.cursor()
	try:
		cursor.execute(query)
		rows = cursor.fetchone()

		return rows
	except:
		print "Cannot fetch data."
	mydb.close()

def py_get_shop_name_by_inventory_id(inventory_id):
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
	query = "SELECT im.inventory_id, s.name \
		FROM imported_materials AS im \
		LEFT JOIN shops AS s ON im.shop_id = s.shop_id \
		WHERE im.inventory_id = '%s' " % inventory_id

	cursor = mydb.cursor()
	try:
		cursor.execute(query)
		rows = cursor.fetchone()

		return rows[1] # Return only shop_name
	except:
		print "Cannot fetch data."
	mydb.close()

def py_get_shop_id_and_name_by_inventory_id(inventory_id):
    print env
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT s.shop_id, s.name \
		FROM imported_materials AS im \
		LEFT JOIN shops AS s ON im.shop_id = s.shop_id \
		WHERE im.inventory_id = '%s' " % inventory_id

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
	print env
        row = cursor.fetchone()
        data = {}
        data["merchant_id"] = row[0]
        data["merchant_name"] = row[1]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def py_get_merchant_data_by_product_pkey(product_pkey):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT s.shop_id, s.shop_code, s.name \
		FROM shops as s \
		WHERE s.shop_id in ( \
			SELECT v.shop_id \
			FROM variants as v \
			WHERE v.product_id IN ( \
				SELECT p.id \
				FROM products as p \
				where p.pkey = %s \
				) \
			) \
		LIMIT 1" % product_pkey

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        row = cursor.fetchone()
        data = {}
        data["merchant_id"] = row[0]
        data["merchant_code"] = row[1]
        data["merchant_name"] = row[2]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def update_priceplan_status(pp_id):

	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "UPDATE truemoveh_price_plans \
		SET status = 'N' \
		WHERE id = %s \
		" % pp_id

	cursor = mydb.cursor()
	cursor.execute(query)
	mydb.commit()
	cursor.close()
	mydb.close()

# r = get_product_has_sku_diff_price()
# print r

def py_get_product_normal(start=1):

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT `variants`.`inventory_id`, `products`.`pkey`, `products`.`id` ,`variants`.id, `variants`.price \
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
    AND `products`.`deleted_at` is null\
    AND `products`.`pkey` not in (SELECT pkey FROM product_verify_pendings) \
    AND `collections`.`deleted_at` is null\
    AND `collections`.`parent_id` = 0\
    AND `brands`.`deleted_at` is null \
    ORDER BY `variants`.`id` DESC\
    LIMIT %s,1" % start

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        row = cursor.fetchone()
        data = {}
        data["inventory_id"] = row[0]
        data["product_pkey"] = row[1]
        data["product_id"] = row[2]
        data["variant_id"] = row[3]
        data["variant_price"] = row[4]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def py_get_product_normal_has_installment(start=1, bank='ktc', periods='["3","6","10"]'):

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT `variants`.`inventory_id`, `products`.`pkey`, `products`.`id`  ,`variants`.id    \
  FROM `variants` \
  INNER JOIN `products` ON `products`.`id` = `variants`.`product_id` \
  INNER JOIN `product_collections` ON `product_collections`.`product_id` = `products`.`id` \
  INNER JOIN `collections` ON `collections`.`id` = `product_collections`.`collection_id` \
  INNER JOIN `apps_collections` ON `apps_collections`.`collection_id` = `collections`.`id` \
  INNER JOIN `app_category_collections` ON `app_category_collections`.`collection_id` = `collections`.`id` \
  INNER JOIN `brands` ON `brands`.`id` = `products`.`brand_id` \
  INNER JOIN `imported_materials` ON `imported_materials`.`inventory_id` = `variants`.`inventory_id`\
  INNER JOIN bank_product ON bank_product.product_id = products.id\
  INNER JOIN banks ON bank_product.bank_id = banks.id\
  WHERE ( SELECT count( vo.variant_id ) FROM variant_style_options vo WHERE `variants`.`id` = vo.variant_id  ) = 0\
  AND `variants`.`deleted_at` is null \
  AND `variants`.`status` = 'active' \
  AND `variants`.`stock_type` = 1 \
  AND `products`.`status` = 'publish'\
  AND `products`.`active` = 1\
  AND `products`.`deleted_at` is null\
  AND `products`.`pkey` not in (SELECT pkey FROM product_verify_pendings) \
  AND `collections`.`deleted_at` is null\
  AND `collections`.`parent_id` = 0\
  AND `brands`.`deleted_at` is null \
  AND banks.deleted_at is null\
  AND banks.abbreviation = '%s'\
  AND bank_product.periods LIKE '%s'\
  ORDER BY `variants`.`id` DESC\
  LIMIT %s,1" % (bank, "%" + periods + "%", start)

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        row = cursor.fetchone()
        data = {}
        data["inventory_id"] = row[0]
        data["product_pkey"] = row[1]
        data["product_id"] = row[2]
        data["variant_id"] = row[3]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def py_get_product_normal_allow_cod(start=1):

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT `variants`.`inventory_id`, `products`.`pkey`, `products`.`id`  ,`variants`.id    \
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
    AND `products`.`deleted_at` is null\
    AND `products`.`allow_cod` = 1\
    AND `products`.`pkey` not in (SELECT pkey FROM product_verify_pendings) \
    AND `collections`.`deleted_at` is null\
    AND `collections`.`parent_id` = 0\
    AND `brands`.`deleted_at` is null \
    ORDER BY `variants`.`id` DESC\
    LIMIT %s,1" % start

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        row = cursor.fetchone()
        data = {}
        data["inventory_id"] = row[0]
        data["product_pkey"] = row[1]
        data["product_id"] = row[2]
        data["variant_id"] = row[3]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def py_get_product_normal_with_payment(payment=1):

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT `variants`.`inventory_id`, `products`.`pkey`, `products`.`id`  ,`variants`.id    \
    FROM `variants` \
    INNER JOIN `products` ON `products`.`id` = `variants`.`product_id` \
    INNER JOIN `product_payment_methods` ON `product_payment_methods`.`product_id` = `variants`.`product_id`\
    INNER JOIN `product_collections` ON `product_collections`.`product_id` = `products`.`id` \
    INNER JOIN `collections` ON `collections`.`id` = `product_collections`.`collection_id` \
    INNER JOIN `apps_collections` ON `apps_collections`.`collection_id` = `collections`.`id` \
    INNER JOIN `app_category_collections` ON `app_category_collections`.`collection_id` = `collections`.`id` \
    INNER JOIN `brands` ON `brands`.`id` = `products`.`brand_id` \
    INNER JOIN `imported_materials` ON `imported_materials`.`inventory_id` = `variants`.`inventory_id`\
    LEFT JOIN product_verify_pendings on products.pkey = product_verify_pendings.pkey\
    WHERE ( SELECT count( vo.variant_id ) FROM variant_style_options vo WHERE `variants`.`id` = vo.variant_id  ) = 0\
    AND `variants`.`deleted_at` is null \
    AND `variants`.`status` = 'active' \
    AND `variants`.`stock_type` = 1 \
    AND `products`.`status` = 'publish'\
    AND `products`.`active` = 1\
    AND `products`.`deleted_at` is null\
    AND product_verify_pendings.pkey is null\
    AND `collections`.`deleted_at` is null\
    AND `collections`.`parent_id` = 0\
    AND `brands`.`deleted_at` is null \
    AND `product_payment_methods`.`payment_method_id` = %s\
    ORDER BY `variants`.`id` DESC" % payment
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        row = cursor.fetchone()
        data = {}
        data["inventory_id"] = row[0]
        data["product_pkey"] = row[1]
        data["product_id"] = row[2]
        data["variant_id"] = row[3]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def py_get_product_normal_without_alias(start=1):

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT DISTINCT `products`.`id`, `products`.`pkey` , `products`.`title` \
    FROM `variants` \
    INNER JOIN `products` ON `products`.`id` = `variants`.`product_id` \
    INNER JOIN `product_collections` ON `product_collections`.`product_id` = `products`.`id` \
    INNER JOIN `collections` ON `collections`.`id` = `product_collections`.`collection_id` \
    INNER JOIN `apps_collections` ON `apps_collections`.`collection_id` = `collections`.`id` \
    INNER JOIN `app_category_collections` ON `app_category_collections`.`collection_id` = `collections`.`id` \
    INNER JOIN `brands` ON `brands`.`id` = `products`.`brand_id` \
    INNER JOIN `imported_materials` ON `imported_materials`.`inventory_id` = `variants`.`inventory_id`\
    LEFT JOIN `product_merchant_alias` as `pma` on `products`.`id` = `pma`.`product_id` \
    WHERE ( SELECT count( vo.variant_id ) FROM variant_style_options vo WHERE `variants`.`id` = vo.variant_id  ) = 0\
	AND `pma`.`product_id` is null \
    AND `variants`.`deleted_at` is null \
    AND `variants`.`status` = 'active' \
    AND `variants`.`stock_type` = 1 \
    AND `products`.`status` = 'publish'\
    AND `products`.`active` = 1\
    AND `products`.`deleted_at` is null\
    AND `products`.`pkey` not in (SELECT pkey FROM product_verify_pendings) \
    AND `collections`.`deleted_at` is null\
    AND `collections`.`parent_id` = 0\
    AND `brands`.`deleted_at` is null \
    ORDER BY `variants`.`id` DESC\
    LIMIT %s" % start

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        row = cursor.fetchall()
        data = []
        for idx, value in enumerate(row):
        	product = {}
	        product["product_id"] = value[0]
	        product["product_pkey"] = value[1]
	        product["product_title"] = value[2]
	        data.append(product)
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def py_get_product_without_alias():
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    
    query = "SELECT DISTINCT `products`.`id`, `products`.`pkey`, `products`.`slug` \
    FROM `variants` \
    INNER JOIN `products` ON `products`.`id` = `variants`.`product_id` \
    INNER JOIN `product_collections` ON `product_collections`.`product_id` = `products`.`id` \
    INNER JOIN `collections` ON `collections`.`id` = `product_collections`.`collection_id` \
    INNER JOIN `apps_collections` ON `apps_collections`.`collection_id` = `collections`.`id` \
    INNER JOIN `app_category_collections` ON `app_category_collections`.`collection_id` = `collections`.`id` \
    INNER JOIN `brands` ON `brands`.`id` = `products`.`brand_id` \
    INNER JOIN `imported_materials` ON `imported_materials`.`inventory_id` = `variants`.`inventory_id`\
    LEFT JOIN `product_merchant_alias` as `pma` on `products`.`id` = `pma`.`product_id` \
    WHERE ( SELECT count( vo.variant_id ) FROM variant_style_options vo WHERE `variants`.`id` = vo.variant_id  ) = 0\
    AND `pma`.`product_id` is null \
    AND `variants`.`deleted_at` is null \
    AND `variants`.`status` = 'active' \
    AND `variants`.`stock_type` = 1 \
    AND `products`.`status` = 'publish'\
    AND `products`.`active` = 1\
    AND `products`.`deleted_at` is null\
    AND `products`.`pkey` not in (SELECT pkey FROM product_verify_pendings) \
    AND `collections`.`deleted_at` is null\
    AND `collections`.`parent_id` = 0\
    AND `brands`.`deleted_at` is null \
    ORDER BY `variants`.`id` DESC "

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows
    except:
        print "Cannot fetch data."

    mydb.close()

def py_insert_merchant_alias(merchant_alias_name, merchant_alias_code, user_id=1):
    try:
        mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
        query = "INSERT INTO `merchant_alias` (`name`, `merchant_code`, `user_id`, `created_at`, `updated_at`, `deleted_at`) \
        VALUES ('%s', '%s', '%s', NOW(), NOW(), NULL) \
        "  % (merchant_alias_name, merchant_alias_code, user_id)

        cursor = mydb.cursor()
        cursor.execute(query)
        merchant_alias_id = cursor.lastrowid
        mydb.commit()

        return merchant_alias_id

    except Exception, e:
        mydb.rollback()
        return BuiltIn().log_to_console('DB exception: %s' % e)

	mydb.close()

def py_insert_product_merchant_alias(product_id, merchant_alias_id, user_id=1, source='manual'):

	try:
		mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
		query = "INSERT INTO `product_merchant_alias` (`product_id`, `merchant_alias_id`, `user_id`, `created_at`, `source`) \
		VALUES (%s, %s, %s, NOW(), '%s') \
		"  % (product_id, merchant_alias_id, user_id, source)

		cursor = mydb.cursor()
		cursor.execute(query)
		product_merchant_alias_id = cursor.lastrowid
		mydb.commit()

		return product_merchant_alias_id

	except Exception, e:
		mydb.rollback()
        return BuiltIn().log_to_console('DB exception: %s' % e)
	
	mydb.close()

def py_delete_merchant_alias_and_product(merchant_alias_id):

	try:
		mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

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

	except Exception, e:
		mydb.rollback()

		return BuiltIn().log_to_console('DB exception: %s' % e)
		
def update_product_active_status_by_product_id(product_id, product_active_status):
   mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

   query = "UPDATE products  \
   SET  active = '%s' \
   WHERE `id` = '%s' \
   " % (product_active_status, product_id)

   cursor = mydb.cursor()
   try:
        cursor.execute(query)
        mydb.commit()
   except:
        mydb.rollback()
        print "update product active status by product_id fail"
   mydb.close()


def py_get_product_by_pkey(product_pkey):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = " SELECT p.id , p.title \
        FROM products p \
        WHERE p.pkey = '%s' \
        ORDER BY p.id \
        "% product_pkey

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        row = cursor.fetchone()
        return row

    except:
        print "Cannot fetch data."
    mydb.close()

def get_one_product_detail():
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = " SELECT pkey, id \
        FROM products \
        WHERE deleted_at is null and active = 1 and has_variants !=0 \
        limit 1 \
        "

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        return rows;

    except:
        print "Cannot fetch data."
    mydb.close()

def get_products_not_in_alias_merchant():
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = " SELECT pkey, id, title \
        FROM products \
        WHERE deleted_at is null  and id not in (select product_id from `product_merchant_alias`) \
        limit 1 \
    "

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        return rows;

    except:
        print "Cannot fetch data."
    mydb.close()

def py_get_product_has_image(start=1):
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
	query = "SELECT p.id, p.pkey, p.title, p.slug, p.cdn_path_config, a.location \
		FROM `products` p \
		JOIN `media_contents` pm \
		ON p.id = pm.mediable_id \
		JOIN `attachments` a \
		ON a.id =  pm.attachment_id \
		WHERE p.deleted_at is null \
		AND p.has_variants = 0 \
		AND mediable_type='Product' \
		AND p.status = 'publish' \
		AND p.active = 1 \
		LIMIT %s" % start
	cursor = mydb.cursor()
	try:
		cursor.execute(query)
		row = cursor.fetchall()
		BuiltIn().log_to_console(query)
		data = []
		for idx, value in enumerate(row):
			product = {}
			product["product_id"] = value[0]
			product["product_pkey"] = value[1]
			product["product_title"] = value[2]
			product["product_slug"] = value[3]
			product["product_cdn"] = value[4]
			product["product_image"] = value[5]
			data.append(product)
		return data
	except:
		print "Cannot fetch data."
	mydb.close()

def py_get_product_different_brand(limit=1):

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT DISTINCT `products`.`brand_id` \
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
    AND `products`.`deleted_at` is null\
    AND `products`.`pkey` not in (SELECT pkey FROM product_verify_pendings) \
    AND `collections`.`deleted_at` is null\
    AND `collections`.`parent_id` = 0\
    AND `brands`.`deleted_at` is null \
    GROUP BY `products`.`id` \
    ORDER BY `products`.`id` DESC\
    LIMIT 0, %s" % limit

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        return rows
    except:
        print "Cannot fetch data."
    mydb.close()

def py_get_product_normal_by_brand_id(brand_id=1):

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT `products`.`brand_id`, `variants`.`inventory_id`, `products`.`pkey`, `products`.`id` , `brands`.`id`, `brands`.`pkey`, `brands`.`name`   \
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
    AND `products`.`deleted_at` is null\
    AND `products`.`pkey` not in (SELECT pkey FROM product_verify_pendings) \
    AND `collections`.`deleted_at` is null\
    AND `collections`.`parent_id` = 0\
    AND `brands`.`deleted_at` is null \
    AND `products`.`brand_id` = %s \
    ORDER BY `variants`.`id` DESC\
    LIMIT %s,1" % (brand_id, 0)

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        row = cursor.fetchone()
        data = {}
        data["brand_id"] = row[0]
        data["inventory_id"] = row[1]
        data["product_pkey"] = row[2]
        data["product_id"] = row[3]
        data["brand_id"] = row[4]
        data["brand_pkey"] = row[5]
        data["brand_name"] = row[6]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def py_get_product_normal_not_has_variant(start=1, not_in_product_pkey=None):

    if not_in_product_pkey is None :
        not_in_product_pkey = (1)
    else :
        not_in_product_pkey = ', '.join(not_in_product_pkey)

    try:
        mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

        query = "SELECT `variants`.`inventory_id`, `products`.`pkey`, `products`.`id` ,`variants`.id  ,`variants`.price \
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
        AND `products`.`status` = 'publish' \
        AND `products`.`active` = 1 \
        AND `products`.`has_variants` = 0 \
        AND `products`.`deleted_at` is null\
        AND `products`.`pkey` not in (%s) \
        AND `products`.`pkey` not in (SELECT pkey FROM product_verify_pendings) \
        AND `collections`.`deleted_at` is null\
        AND `collections`.`parent_id` = 0\
        AND `brands`.`deleted_at` is null \
        ORDER BY RAND() \
        LIMIT %s,1" % (not_in_product_pkey, start)
        cursor = mydb.cursor()
        cursor.execute(query)
        row = cursor.fetchone()

        data = {}
        data["inventory_id"] = row[0]
        data["product_pkey"] = row[1]
        data["product_id"] = row[2]
        data["variant_id"] = row[3]
        data["variant_price"] = row[4]
        return data
    except Exception, e :
        BuiltIn().log_to_console('Cannot fetch data. %s' % e);

    mydb.close()

def py_get_product_normal_has_variant(start=1, not_in_product_pkey=None):

    if not_in_product_pkey is None :
        not_in_product_pkey = (1)
    else :
        not_in_product_pkey = ', '.join(not_in_product_pkey)

    try:
        mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

        query = "SELECT `variants`.`inventory_id`, `products`.`pkey`, `products`.`id` ,`variants`.id  ,`variants`.price \
        FROM `variants` \
        INNER JOIN `products` ON `products`.`id` = `variants`.`product_id` \
        INNER JOIN `product_collections` ON `product_collections`.`product_id` = `products`.`id` \
        INNER JOIN `collections` ON `collections`.`id` = `product_collections`.`collection_id` \
        INNER JOIN `apps_collections` ON `apps_collections`.`collection_id` = `collections`.`id` \
        INNER JOIN `app_category_collections` ON `app_category_collections`.`collection_id` = `collections`.`id` \
        INNER JOIN `brands` ON `brands`.`id` = `products`.`brand_id` \
        INNER JOIN `imported_materials` ON `imported_materials`.`inventory_id` = `variants`.`inventory_id`\
        WHERE ( SELECT count( vo.variant_id ) FROM variant_style_options vo WHERE `variants`.`id` = vo.variant_id  ) > 1\
        AND `variants`.`deleted_at` is null \
        AND `variants`.`status` = 'active' \
        AND `variants`.`stock_type` = 1 \
        AND `products`.`status` = 'publish' \
        AND `products`.`active` = 1 \
        AND `products`.`has_variants` = 1 \
        AND `products`.`deleted_at` is null\
        AND `products`.`pkey` not in (%s) \
        AND `products`.`pkey` not in (SELECT pkey FROM product_verify_pendings) \
        AND `collections`.`deleted_at` is null\
        AND `collections`.`parent_id` = 0\
        AND `brands`.`deleted_at` is null \
        ORDER BY RAND() \
        LIMIT %s,1" % (not_in_product_pkey, start)
        cursor = mydb.cursor()
        cursor.execute(query)
        row = cursor.fetchone()

        data = {}
        data["inventory_id"] = row[0]
        data["product_pkey"] = row[1]
        data["product_id"] = row[2]
        data["variant_id"] = row[3]
        data["variant_price"] = row[4]
        return data
    except Exception, e :
        BuiltIn().log_to_console('Cannot fetch data. %s' % e);

    mydb.close()

def py_get_product_normal_not_has_variant_allow_cod(start=1, not_in_product_pkey=None):

    if not_in_product_pkey is None :
        not_in_product_pkey = (1)
    else :
        not_in_product_pkey = ', '.join(not_in_product_pkey)

    try:
        mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

        query = "SELECT `variants`.`inventory_id`, `products`.`pkey`, `products`.`id` ,`variants`.id  ,`variants`.price \
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
        AND `products`.`status` = 'publish' \
        AND `products`.`active` = 1 \
        AND `products`.`has_variants` = 0 \
        AND `products`.`allow_cod` = 1 \
        AND `products`.`deleted_at` is null\
        AND `products`.`pkey` not in (%s) \
        AND `products`.`pkey` not in (SELECT pkey FROM product_verify_pendings) \
        AND `collections`.`deleted_at` is null\
        AND `collections`.`parent_id` = 0\
        AND `brands`.`deleted_at` is null \
        ORDER BY RAND() \
        LIMIT %s,1" % (not_in_product_pkey, start)
        cursor = mydb.cursor()
        cursor.execute(query)
        row = cursor.fetchone()

        data = {}
        data["inventory_id"] = row[0]
        data["product_pkey"] = row[1]
        data["product_id"] = row[2]
        data["variant_id"] = row[3]
        data["variant_price"] = row[4]
        return data
    except Exception, e :
        BuiltIn().log_to_console('Cannot fetch data. %s' % e);

    mydb.close()

def get_2inventory_ids_diff_brand():
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT products.brand_id, products.id, variants.inventory_id \
    FROM variants JOIN products \
    ON products.id = variants.product_id \
    JOIN brands \
    ON brands.id = products.brand_id \
    JOIN (SELECT product_style_type.product_id, sum(product_style_type.style_type_id) number \
        FROM product_style_type \
        GROUP BY product_style_type.product_id) style \
    ON style.product_id = products.id \
    JOIN imported_materials \
    ON variants.inventory_id = imported_materials.inventory_id \
    WHERE style.number = 1 \
    AND brands.deleted_at is null \
    AND variants.deleted_at is null \
    AND variants.status = 'active' \
    AND variants.stock_type = 1 \
    AND products.status = 'publish' \
    AND products.active = 1 \
    AND products.has_variants = 1 \
    AND products.deleted_at is null \
    ORDER BY products.id, products.brand_id \
    "

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        i = 0
        j = 0
        brand_id = None
        product_id = None
        found = 0

        for row in rows:
            brand_id = row[0]
            product_id = row[1]

            for j in xrange(i, len(rows)-1):
                if rows[j][0] != brand_id :
                    if rows[j][1] != product_id :
                        found = 1
                        break
            if found == 1 :
                break
            i = i+1

        data = [rows[i][2], rows[j][2]]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def get_2inventory_ids_diff_collection():
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT product_collections.collection_id, products.id, variants.inventory_id \
    FROM variants JOIN products \
    ON products.id = variants.product_id \
    JOIN product_collections \
    ON product_collections.product_id = products.id \
    JOIN collections \
    ON collections.id = product_collections.collection_id \
    JOIN apps_collections \
    ON apps_collections.collection_id = collections.id \
    JOIN (SELECT product_style_type.product_id, sum(product_style_type.style_type_id) number \
        FROM product_style_type \
        GROUP BY product_style_type.product_id) style \
    ON style.product_id = products.id \
    JOIN imported_materials \
    ON variants.inventory_id = imported_materials.inventory_id \
    WHERE style.number = 1 \
    AND collections.deleted_at is null \
    AND collections.parent_id = 0 \
    AND variants.deleted_at is null \
    AND variants.status = 'active' \
    AND variants.stock_type = 1 \
    AND products.has_variants = 1 \
    AND products.status = 'publish' \
    AND products.active = 1 \
    AND products.deleted_at is null \
    AND apps_collections.app_id = 1 \
    ORDER BY product_collections.collection_id \
    "

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()

        i = 0
        j = 0
        collection_id = None
        product_id = None
        found = 0

        for row in rows:
            collection_id = row[0]
            product_id = row[1]

            for j in xrange(i+1, len(rows)-1):
                if rows[j][0] != collection_id :
                    if rows[j][1] != product_id :
                        found = 1
                        break
            if found == 1 :
                break
            i = i+1

        data = [rows[i][2], rows[j][2]]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()