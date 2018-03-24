import requests
import json
from ConnectDB import *
from robot.libraries.BuiltIn import BuiltIn

try :

    pcms_url = BuiltIn().get_variable_value("${PCMS_URL}")
    image_path = BuiltIn().get_variable_value("${MNP_IMAGE_PATH}")

except:

    pcms_url = "http://pcms.itruemart-dev.com"	


def get_mnp_propostion_priceplan() : 
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "SELECT propo.id, priceplan.id FROM truemoveh_propositions propo \
		INNER JOIN truemoveh_proposition_maps map ON propo.id = map.proposition_id \
		INNER JOIN truemoveh_price_plans priceplan ON map.price_plan_id = priceplan.id \
		WHERE propo.deleted_at is null \
		AND propo.source_type = 'mnp' \
		AND propo.`status` = 'Y' \
		AND priceplan.deleted_at is null \
		AND priceplan.`status` = 'Y' "
	
	cursor = mydb.cursor()
	cursor.execute(query)
	rows =  cursor.fetchone()
	return rows

def get_mnp_device_propostion_priceplan(inv_id = None) : 
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "SELECT `propo`.`id`, `priceplan`.`id`, `priceplan`.`pp_code` FROM `truemoveh_device_proposition_group_maps` device \
		INNER JOIN `truemoveh_proposition_group_maps` `propo_group` ON `propo_group`.`proposition_group_id` = `device`.`group_id` \
		INNER JOIN `truemoveh_propositions` `propo` ON `propo_group`.`proposition_id` = `propo`.`id` \
		INNER JOIN `truemoveh_proposition_maps` `map` ON `propo`.`id` = `map`.`proposition_id` \
		INNER JOIN `truemoveh_price_plans` `priceplan` ON `map`.`price_plan_id` = `priceplan`.`id` \
		WHERE `device`.`inventory_id` = '%s' \
		AND `propo`.`deleted_at` is null \
		AND `propo`.`source_type` = 'mnp_device' \
		AND `propo`.`status` = 'Y' \
		AND `priceplan`.`deleted_at` is null \
		AND `priceplan`.`status` = 'Y' " % inv_id
	
	cursor = mydb.cursor()
	cursor.execute(query)
	rows =  cursor.fetchone()
	return rows

def get_inventory_mnp() : 
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "SELECT `device`.`id`, `v`.`inventory_id` FROM `truemoveh_sim_variants` v \
			INNER JOIN `truemoveh_device_types` s ON `v`.`device_type_id` = `s`.`id` \
			INNER JOIN `truemoveh_sub_device` map ON `map`.`device_sub_id` = `s`.`id` \
			INNER JOIN `truemoveh_device` device ON `device`.`id` = `map`.`device_id` \
			WHERE `v`.`device_type` = 'mnp' "
	
	cursor = mydb.cursor()
	cursor.execute(query)
	rows =  cursor.fetchone()
	return rows[1]

def get_inventory_bundle() : 
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = " SELECT `device_group_maps`.`inventory_id`, `device`.`pkey` \
	, `price_plan`.`pp_code`, `device_group_maps`.`variant_id` \
    FROM `truemoveh_device` as `device` \
    INNER JOIN `truemoveh_device_proposition_group_maps` as `device_group_maps` \
	ON `device`.`id` = `device_group_maps`.`device_id` \
	INNER JOIN `truemoveh_proposition_group_maps` as `propo_group_maps` \
	ON `device_group_maps`.`group_id` = `propo_group_maps`.`proposition_group_id` \
	INNER JOIN `truemoveh_proposition_groups` as `group_propo` \
	ON `propo_group_maps`.`proposition_group_id` = `group_propo`.`id` \
	INNER JOIN `truemoveh_propositions` as `propo` \
	ON `propo_group_maps`.`proposition_id` = `propo`.`id` \
    INNER JOIN `truemoveh_proposition_maps` as `propo_maps` \
    ON `propo`.`id` = `propo_maps`.`proposition_id` \
    INNER JOIN truemoveh_price_plans as price_plan \
    ON `propo_maps`.`price_plan_id` = `price_plan`.`id` \
    WHERE `group_propo`.`status` = 'Y' \
    AND `price_plan`.`status` = 'Y' \
    AND `propo`.`source_type` = 'bundle' AND `propo`.`status` = 'Y' \
    ORDER BY `device_group_maps`.`inventory_id` ASC "

	try:
		cursor = mydb.cursor()
		cursor.execute(query)
		rows = cursor.fetchone()
		return rows[0]
	except:
		print "Cannot fetch data."
	
	mydb.close() 

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
		return rows[0]
	except:
		print "Cannot fetch data."
	mydb.close() 



def api_add_mnp_to_cart(inventory_id=None, customer_ref_id=None, mobile=None, idcard="8674861076129", price_plan_id = None, proposition_id=0, mnp_type="mnp", customer_type="user"):
	if inventory_id is None : 
		return None 
	if customer_ref_id is None : 
		return None  
	if mobile is None : 
		return None  
	if price_plan_id is None : 
		return None  

	path = get_canonical_path("../../../itruemart-robot-ux/Resources/TestData/data/images/image_profile.jpg")

	f = open(path, "rb")
	mock_data = {"customer_ref_id":"%s" % str(customer_ref_id),"customer_type":"user","inventory_id":"%s" % str(inventory_id),"type": "%s" % str(mnp_type),"mimeType":"image/jpg","fileType":"jpg","fileOriginalName":"1.jpg","mobile":"%s" % str(mobile),"operator":"AIS","idcard":"%s" % str(idcard),"idcard_expire":"11/11/2020","title":"mnp-regis-title","fname":"mnp-regis-fname","lname":"mnp-regis-lname","gender":"M","marital_status":"mnp-regis-marital_status","birth_date":"11/11/1911","customer_tel":"0890000000","customer_email":"mnp-regis-customer_email","file":"itruemart.jpg","customer_province":"1","customer_district":"1","customer_city":"1","customer_zipcode":"1","customer_address":"mnp-regis-customer_address","billing_province":"1","billing_district":"1","billing_city":"1","billing_zipcode":"1","billing_address":"mnp-regis-billing_address","price_plan_id":"%s" % price_plan_id,"proposition_id":"%s" % proposition_id,"same_address":"Y","device_name":"mnp-regis-device_name","device_name_sub":"%s" % str(inventory_id)}
# =======
# 	f = open(path)
# 	mock_data = {"customer_ref_id":"%s" % str(customer_ref_id),"customer_type":"%s" % str(customer_type),"inventory_id":"%s" % str(inventory_id),"type": "%s" % str(mnp_type),"mobile":"%s" % str(mobile),"operator":"AIS","idcard":"%s" % str(idcard),"idcard_expire":"11/11/2020","title":"mnp-regis-title","fname":"mnp-regis-fname","lname":"mnp-regis-lname","gender":"M","marital_status":"mnp-regis-marital_status","birth_date":"11/11/1911","customer_tel":"0890000000","customer_email":"mnp-regis-customer_email","file":"itruemart.jpg","customer_province":"1","customer_district":"1","customer_city":"1","customer_zipcode":"1","customer_address":"mnp-regis-customer_address","billing_province":"1","billing_district":"1","billing_city":"1","billing_zipcode":"1","billing_address":"mnp-regis-billing_address","price_plan_id":"%s" % price_plan_id,"proposition_id":"%s" % proposition_id,"same_address":"Y","device_name":"mnp-regis-device_name","device_name_sub":"%s" % str(inventory_id)}
# >>>>>>> a5a62d7115813919c43048caa5887e2ea204c246
	files = {'file': f}
	#return pcms_url

	resp = requests.post(pcms_url + "/api/45311375168544/truemoveh/mnp/register", files=files, data=mock_data)
	data = json.loads(resp.text)
	return data


def api_add_mnp_to_cart_v2(inventory_id=None, customer_ref_id=None, customer_type="user", mobile=None, idcard="8674861076129", price_plan_id=None, mnp_type="mnp"):

	mock_data = {"customer_ref_id":"%s" % str(customer_ref_id),"customer_type":"%s" % str(customer_type),"inventory_id":"%s" % str(inventory_id),"mobile":"%s" % str(mobile),"operator":"DTAC","idcard":"%s" % str(idcard),"idcard_expire":"11/11/2020","title":"MISS","fname":"Robot","lname":"Automate","gender":"M","marital_status":"marital_status","birth_date":"11/11/1990","customer_tel":"0890000000","customer_email":"blackpantherautomate@gmail.com","customer_province":"1","customer_district":"9","customer_city":"2","customer_zipcode":"9","customer_address":"89 AIA Capital Center","billing_province":"1","billing_district":"9","billing_city":"2","billing_zipcode":"9","billing_address":"Bill 89 AIA Capital Center","price_plan_id":"%s" % str(price_plan_id),"same_address":"N","device_name":"Device Name","device_name_sub":"%s" % str(inventory_id),"type": "%s" % str(mnp_type),"mimeType":"jpg","fileType":"jpg","fileOriginalName":"test-file"}
	# return mock_data
	# files = {'file': open("../../../Resource/TestData/MNP/images/image_profile.jpg")}
	# pcms_url = "http://pcms.itruemart-dev.com"
	path = get_canonical_path(image_path)
	resp = requests.post(pcms_url + "/api/45311375168544/truemoveh/mnp/register", files={'file': open(path)}, data=mock_data)
	data = json.loads(resp.text)
	return data

def get_inventory_mnp_device() :
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "SELECT DISTINCT `variants`.`inventory_id` \
		FROM `variants` \
		INNER JOIN `products` ON `products`.`id` = `variants`.`product_id` \
		INNER JOIN `product_collections` ON `product_collections`.`product_id` = `products`.`id` \
		INNER JOIN `collections` ON `collections`.`id` = `product_collections`.`collection_id` \
		INNER JOIN `apps_collections` ON `apps_collections`.`collection_id` = `collections`.`id` \
		INNER JOIN `brands` ON `brands`.`id` = `products`.`brand_id` \
		INNER JOIN `truemoveh_device_proposition_group_maps` device ON `device`.`inventory_id` = `variants`.`inventory_id` \
		INNER JOIN `truemoveh_proposition_group_maps` propo_group ON `propo_group`.`proposition_group_id` = `device`.`group_id` \
		INNER JOIN `truemoveh_propositions` propo ON `propo`.`id` = `propo_group`.`proposition_id` \
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
		AND `propo`.`source_type` = 'mnp_device' \
		AND propo.deleted_at is null \
		AND propo.`status` = 'Y' \
		ORDER BY `products`.`id` desc "

	cursor = mydb.cursor()
	try:
		cursor.execute(query)
		rows = cursor.fetchone()
		return rows[0]
	except:
		print "Cannot fetch data."
	mydb.close() 
	

def py_delete_truemoveh_order_verifys_by_mobile(mobile_number=None):
    if mobile_number is None : 
        return None 
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try : 
        query = "UPDATE `truemoveh_order_verifys` SET `deleted_at` = '2016-05-01 00:00:00' WHERE `truemoveh_order_verifys`.`mobile` LIKE '%s';" % mobile_number
        result = cursor.execute(query)
        mydb.commit()
        return True
    except: 
        mydb.rollback()
        return False

def py_insert_truemoveh_order_verify(
		idcard=None, 
	    mobile=None, 
	    fname='Automate', 
	    lname='Test',
	    status=None, 
	    bundle_type=None, 
	    activate_status=None, 
	    activate_date=None, 
	    mnp1_status=None, 
	    mnp1_success_date=None, 
	    mnp_used=None, 
	    created_at=None 
	):
    
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = "INSERT INTO `truemoveh_order_verifys` \
    ( `idcard`, \
    `mobile`, \
    `fname`, \
    `lname`,\
    `status`, \
    `bundle_type`, \
    `activate_status`, \
    `activate_date`, \
    `mnp1_status`, \
    `mnp1_success_date`, \
    `mnp_used`, \
    `created_at`) VALUES (  \
		'%s', \
		'%s', \
		'%s', \
		'%s', \
		'%s', \
		'%s', \
		'%s', \
		'%s',  \
		'%s', \
		'%s', \
		%s, \
		'%s'\
	);" % (idcard, mobile, fname,  lname, status, bundle_type, activate_status,  activate_date, mnp1_status,  mnp1_success_date,  mnp_used,  created_at )
    # return query
    cursor = mydb.cursor()

    try :
        result = cursor.execute(query)
        data = {}
        data["status"] = True
        mydb.commit()
        return data
    except:
        mydb.rollback();
        data = {}
        data["status"] = False
    mydb.close()


def py_get_data_for_buy_mnp_device():
    
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT \
    truemoveh_device.pkey as product_pkey, \
    variants.inventory_id as product_inventory_id, \
    truemoveh_device_types.inventory_id as product_sim_inventory_id, \
    truemoveh_price_plans.id as price_plan_id, \
    truemoveh_price_plans.pp_code as pp_code \
    FROM `truemoveh_proposition_maps` \
    INNER JOIN truemoveh_propositions ON truemoveh_propositions.id = truemoveh_proposition_maps.proposition_id \
    INNER JOIN truemoveh_price_plans ON truemoveh_price_plans.id = truemoveh_proposition_maps.price_plan_id \
    INNER JOIN truemoveh_proposition_group_maps ON truemoveh_proposition_group_maps.proposition_id = truemoveh_propositions.id \
    INNER JOIN truemoveh_device_proposition_group_maps ON truemoveh_device_proposition_group_maps.group_id = truemoveh_proposition_group_maps.proposition_group_id \
    INNER JOIN truemoveh_device ON truemoveh_device.id = truemoveh_device_proposition_group_maps.device_id \
    INNER JOIN truemoveh_sub_device ON truemoveh_sub_device.device_id = truemoveh_device.id \
    INNER JOIN truemoveh_device_types ON truemoveh_device_types.id = truemoveh_sub_device.device_sub_id \
    INNER JOIN products ON products.pkey = truemoveh_device.pkey \
    INNER JOIN variants ON variants.product_id = products.id \
    WHERE truemoveh_propositions.source_type = 'mnp_device' \
    AND variants.inventory_id IS NOT NULL \
    AND truemoveh_propositions.status = 'Y' \
    AND truemoveh_price_plans.status = 'Y' \
    GROUP BY variants.inventory_id \
    ORDER BY variants.inventory_id ASC "
    
    # return query
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        row = cursor.fetchone()
        data = {}
        data["product_pkey"] = row[0]
        data["product_inventory_id"] = row[1]
        data["product_sim_inventory_id"] = row[2]
        data["price_plan_id"] = row[3]
        data["pp_code"] = row[4]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

# def get_option_pkey_by_variant(inventory_id=None) : 
# 	if inventory_id is None : 
# 		return None
# 	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
	
# 	query = "SELECT v.id, v.inventory_id, so.pkey, so.text \
# 		FROM `variants` AS `v` \
# 		INNER JOIN `variant_style_options` AS `vso` ON `v`.`id` = `vso`.`variant_id` \
# 		INNER JOIN `style_options` AS `so` ON `vso`.`style_option_id` = `so`.`id` \
# 	WHERE `v`.`inventory_id` = '%s' " % inventory_id
# 	try : 
# 		cursor = mydb.cursor()
# 		cursor.execute(query)
# 		rows = cursor.fetchall()
# 		plist = []
# 		for row in rows:
# 			plist.append(row[2])

# 		return plist

# 	except : 
# 		print "Cannot fetch edm data by prefix ."
# 		return False