import MySQLdb as db

from ConnectDB import *
from robot.libraries.BuiltIn import BuiltIn

def py_get_product_level_d_has_style(start=0):
    
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT  `variants`.`inventory_id`  , products.pkey as product_pkey, products.id , `variants`.`id`, \
        (SELECT count(style_type_id) FROM variant_style_options WHERE  `variants`.`id` =  variant_style_options.variant_id ) as countStyle, \
        (  SELECT count(id) FROM `variants` v WHERE v.`product_id` = products.id  AND v.status = 'active' ) as count_inventory,\
        count(`variants`.`inventory_id`) as counts,   \
        (SELECT sum(`stock_sums`.`quantity`) FROM `stock_sums` WHERE `variants`.`inventory_id` = `stock_sums`.`sku_id`) as stockSums, \
        (SELECT count(`stock_holds`.`id`) FROM `stock_holds` WHERE `variants`.`inventory_id` = `stock_holds`.`sku_id` AND `stock_holds`.`status` != 'cancel') as stockHolds \
        FROM `variants` \
        INNER JOIN variant_style_options ON variants.id = variant_style_options.variant_id \
        INNER JOIN style_options ON variant_style_options.style_option_id = style_options.id \
        INNER JOIN `products` ON `products`.`id` = `variants`.`product_id` \
        INNER JOIN `product_collections` ON `product_collections`.`product_id` = `products`.`id` \
        INNER JOIN `collections` ON `collections`.`id` = `product_collections`.`collection_id` \
        INNER JOIN `apps_collections` ON `apps_collections`.`collection_id` = `collections`.`id` \
        INNER JOIN `brands` ON `brands`.`id` = `products`.`brand_id` \
        INNER JOIN `imported_materials` ON `imported_materials`.`inventory_id` = `variants`.`inventory_id`\
        WHERE (SELECT count(*) FROM truemoveh_device WHERE truemoveh_device.pkey = products.pkey ) = 0\
        AND (SELECT count(*) FROM product_verify_pendings WHERE product_verify_pendings.inventory_id = variants.inventory_id ) = 0\
        AND `variants`.`deleted_at` is null \
        AND `variants`.`status` = 'active' \
        AND `variants`.`stock_type` = 1 \
        AND `products`.`status` = 'publish' \
        AND `products`.`active` = 1\
        AND `products`.`has_variants` = 1\
        AND `products`.`deleted_at` is null\
        AND `collections`.`deleted_at` is null\
        AND `brands`.`deleted_at` is null\
        GROUP BY `variants`.`id`\
        HAVING countStyle = 1 AND  count_inventory > 1 AND (stockHolds < stockSums) \
        ORDER BY count(`variants`.`id`) DESC LIMIT %s,1" % ( start )

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

def py_get_any_product_level_d_has_style(start=1):
    
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT  `variants`.`inventory_id`  , products.pkey as product_pkey, products.id , `variants`.`id`, \
        (SELECT count(style_type_id) FROM variant_style_options WHERE  `variants`.`id` =  variant_style_options.variant_id ) as countStyle, \
        (  SELECT count(id) FROM `variants` v WHERE v.`product_id` = products.id  AND v.status = 'active' ) as count_inventory,\
        count(`variants`.`inventory_id`) as counts   \
        FROM `variants` \
        INNER JOIN variant_style_options ON variants.id = variant_style_options.variant_id \
        INNER JOIN style_options ON variant_style_options.style_option_id = style_options.id \
        INNER JOIN `products` ON `products`.`id` = `variants`.`product_id` \
        INNER JOIN `product_collections` ON `product_collections`.`product_id` = `products`.`id` \
        INNER JOIN `collections` ON `collections`.`id` = `product_collections`.`collection_id` \
        INNER JOIN `apps_collections` ON `apps_collections`.`collection_id` = `collections`.`id` \
        INNER JOIN `brands` ON `brands`.`id` = `products`.`brand_id` \
        INNER JOIN `imported_materials` ON `imported_materials`.`inventory_id` = `variants`.`inventory_id`\
        WHERE (SELECT count(*) FROM truemoveh_device WHERE truemoveh_device.pkey = products.pkey ) = 0\
        AND `variants`.`deleted_at` is null \
        AND `variants`.`status` = 'active' \
        AND `variants`.`stock_type` = 1 \
        AND `products`.`status` = 'publish' \
        AND `products`.`active` = 1\
        AND `products`.`has_variants` = 1\
        AND `products`.`deleted_at` is null\
        AND `collections`.`deleted_at` is null\
        AND `brands`.`deleted_at` is null\
        GROUP BY `variants`.`id`\
        HAVING countStyle = 1 AND  count_inventory > 1\
        ORDER BY count(`variants`.`id`) DESC LIMIT %s,1" % ( start )
    
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

def py_get_truemoveh_device_types():
    
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT id, name, inventory_id \
    FROM `truemoveh_device_types` ORDER BY `truemoveh_device_types`.`id` ASC LIMIT 1" 
    
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        row = cursor.fetchone()
        data = {}
        data["id"] = row[0]
        data["name"] = row[1]
        data["inventory_id"] = row[2]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def py_insert_truemoveh_device(pkey=None, product_id=None, product_name='Robot Test Prodcut Device'):
    if pkey is None : 
        return None 

    if product_id is None : 
        return None    

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = "INSERT INTO truemoveh_device (product_id, name, pkey, created_at) \
    VALUES (%s , '%s', %s, NOW())" % (product_id, product_name, pkey)
    
    cursor = mydb.cursor()

    try :

        result = cursor.execute(query)
        data = {}
        data["status"] = True
        data["device_id"] = cursor.lastrowid
        mydb.commit()
        return data

    except:
        mydb.rollback();
        data = {}
        data["status"] = False
    mydb.close()

def py_delete_truemoveh_price_plans(price_plan_id=None):
    if price_plan_id is None : 
        return None 
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try : 
        query = "DELETE FROM truemoveh_price_plans WHERE id = '%s'" % price_plan_id
        result = cursor.execute(query)
        mydb.commit()
        return True
    except: 
        mydb.rollback()
        return False

def py_delete_truemoveh_proposition_groups(proposition_group_id=None):
    if proposition_group_id is None : 
        return None 
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try : 
        query = "DELETE FROM truemoveh_proposition_groups WHERE id = '%s'" % proposition_group_id
        result = cursor.execute(query)
        mydb.commit()
        return True
    except: 
        mydb.rollback()
        return False

def py_delete_truemoveh_propositions(proposition_id=None):
    if proposition_id is None : 
        return None 
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try : 
        query = "DELETE FROM truemoveh_propositions WHERE id = '%s'" % proposition_id
        result = cursor.execute(query)
        mydb.commit()
        return True
    except: 
        mydb.rollback()
        return False

def py_delete_truemoveh_device_by_name(product_name=None):
    if product_name is None : 
        return None 
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try : 
        query = "DELETE FROM truemoveh_device WHERE name = '%s'" % product_name
        result = cursor.execute(query)
        mydb.commit()
        return True
    except: 
        mydb.rollback()
        return False

def py_delete_truemoveh_device(device_id=None):
    if device_id is None : 
        return None 
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try : 
        query = "DELETE FROM truemoveh_device WHERE id = '%s'" % device_id
        result = cursor.execute(query)
        mydb.commit()
        return True
    except: 
        mydb.rollback()
        return False

def py_delete_truemoveh_sub_device(sub_device_id=None):
    if sub_device_id is None : 
        return None 
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try : 
        query = "DELETE FROM truemoveh_sub_device WHERE id = '%s'" % sub_device_id
        result = cursor.execute(query)
        mydb.commit()
        return True
    except: 
        mydb.rollback()
        return False

def py_delete_truemoveh_proposition_maps(proposition_map_id=None):
    if proposition_map_id is None : 
        return None 
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try : 
        query = "DELETE FROM truemoveh_proposition_maps WHERE id = '%s'" % proposition_map_id
        result = cursor.execute(query)
        mydb.commit()
        return True
    except: 
        mydb.rollback()
        return False

def py_delete_truemoveh_proposition_group_maps(proposition_group_map_id=None):
    if proposition_group_map_id is None : 
        return None 
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try : 
        query = "DELETE FROM truemoveh_proposition_group_maps WHERE id = '%s'" % proposition_group_map_id
        result = cursor.execute(query)
        mydb.commit()
        return True
    except: 
        mydb.rollback()
        return False

def py_delete_truemoveh_device_proposition_group_maps(device_proposition_group_map_id=None):
    if device_proposition_group_map_id is None : 
        return None 
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try : 
        query = "DELETE FROM truemoveh_device_proposition_group_maps WHERE id = '%s'" % device_proposition_group_map_id
        result = cursor.execute(query)
        mydb.commit()
        return True
    except: 
        mydb.rollback()
        return False

def py_truemoveh_map_device_and_device_sub(device_id=None, device_sub_id=None) :
    if device_id is None :
        return None
    
    if device_sub_id is None :
        return None

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = "INSERT INTO `truemoveh_sub_device` (`id`, `device_id`, `device_sub_id`, `created_at`, `updated_at`, `deleted_at`) \
    VALUES (NULL, %s, %s, NOW(), NULL, NULL) " % (device_id, device_sub_id)

    cursor = mydb.cursor()

    try :
        result = cursor.execute(query)
        data = {}
        data["status"] = True
        data["sub_device_id"] = cursor.lastrowid
        mydb.commit()
        return data
    except:
        mydb.rollback();
        data = {}
        data["status"] = False
    mydb.close()

def py_insert_truemoveh_price_plan(status='Y', recommend='N', pp_code='PLTEST01', sub_description='Robot iSmart 00001') :

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    
    query = "INSERT INTO `truemoveh_price_plans` (`pp_code`, `sub_description`, `description`, `long_description`, `status`, `recommend`, `created_at`, `updated_at`)\
    VALUES ('%s', '%s', \
    'Robot Description', \
    'Robot Long Description', '%s', '%s', NOW(), NOW()) " % (pp_code, sub_description, status, recommend)

    cursor = mydb.cursor()

    try :
        result = cursor.execute(query)
        data = {}
        data["status"] = True
        data["price_plan_id"] = cursor.lastrowid
        mydb.commit()
        return data
    except:
        mydb.rollback();
        data = {}
        data["status"] = False
    mydb.close()

def py_get_truemoveh_mobile(start=1):
    
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT truemoveh_mobiles.id as mobile_id, truemoveh_mobiles.mobile_type, truemoveh_provinces.id as province_id, \
        truemoveh_mobiles.mobile, truemoveh_mobiles.proposition_id  , truemoveh_provinces.name_th\
        FROM `truemoveh_mobiles` \
        INNER JOIN truemoveh_zone_maps ON truemoveh_zone_maps.zone_id = truemoveh_mobiles.zone_id\
        INNER JOIN truemoveh_provinces ON truemoveh_provinces.id = truemoveh_zone_maps.province_id\
        ORDER BY truemoveh_mobiles.id ASC LIMIT %s,1 " % start 
    
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        row = cursor.fetchone()
        data = {}
        data["mobile_id"] = row[0]
        data["mobile_type"] = row[1]
        data["province_id"] = row[2]
        data["mobile"] = row[3]
        data["proposition_id"] = row[4]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()


def py_insert_truemoveh_proposition(source_type=None, parent_id=0, status='Y', proposition_name='Robot Test Proposition') :
    if source_type is None:
        return None

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    
    query = "INSERT INTO truemoveh_propositions (nas_code, proposition_name, \
    pool_number, baseline, penalty, contract, t_and_c, t_and_c_long, \
    parent_id, status, source_type, created_at, updated_at) \
    VALUES ('1120666', '%s', \
    'TEST1234', '299', '1000', '12', 'robot t and c ', \
    'robot t and c lonf', %s, '%s', '%s', NOW(), NOW()) \
    " % (proposition_name, parent_id, status, source_type)
    
    cursor = mydb.cursor()

    try :
        result = cursor.execute(query)
        data = {}
        data["status"] = True
        data["proposition_id"] = cursor.lastrowid
        mydb.commit()
        return data
    except:
        mydb.rollback();
        data = {}
        data["status"] = False
    mydb.close()

def py_truemoveh_map_proposition_and_price_plan(proposition_id=None, price_plan_id=None) :
    
    if proposition_id is None:
        return None

    if price_plan_id is None:
        return None

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = "INSERT INTO `truemoveh_proposition_maps` (`proposition_id`, `price_plan_id`, `created_at`, `updated_at`) \
    VALUES ('%s', '%s', NOW(), NOW())" % (proposition_id, price_plan_id)

    cursor = mydb.cursor()

    try :

        result = cursor.execute(query)
        data = {}
        data["status"] = True
        data["proposition_map_id"] = cursor.lastrowid
        mydb.commit()
        return data

    except:
        mydb.rollback();
        data = {}
        data["status"] = False
    mydb.close()

def py_insert_truemoveh_proposition_group(status='Y', name='Robot test Group Propo') :

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query="INSERT INTO `truemoveh_proposition_groups` \
    (`name`,`status`, `description`,`created_at`, `updated_at`)\
    VALUES ('%s', '%s', 'Test Robot Proposition Group Description' ,NOW() , NOW())" % (name, status)

    cursor = mydb.cursor()

    try :
        result = cursor.execute(query)
        data = {}
        data["status"] = True
        data["proposition_group_id"] = cursor.lastrowid
        mydb.commit()
        return data
    except:
        mydb.rollback();
        data = {}
        data["status"] = False
    mydb.close()


def py_truemoveh_map_group_proposition_and_proposition(proposition_group_id=None, proposition_id=None) :
    if proposition_group_id is None:
       return None
    if proposition_id is None:
       return None

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query="INSERT INTO `truemoveh_proposition_group_maps` (`proposition_group_id`, `proposition_id`, `created_at`, `updated_at`)\
    VALUES ( '%s', '%s', NOW(), NOW() )" % (proposition_group_id, proposition_id)

    cursor = mydb.cursor()

    try :
        result = cursor.execute(query)
        data = {}
        data["status"] = True
        data["proposition_group_map_id"] = cursor.lastrowid
        mydb.commit()
        return data
    except:
        mydb.rollback();
        data = {}
        data["status"] = False
    mydb.close()

def py_truemoveh_map_device_and_proposition_group(device_id=None, variant_id=None, group_id=None, inventory_id=None):
    if device_id is None:
        return None
    if variant_id is None:
        return None

    if group_id is None:
        return None

    if inventory_id is None:
        return None

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "INSERT INTO `truemoveh_device_proposition_group_maps` \
    (`device_id`, `variant_id`, `group_id`, `inventory_id`, `created_at`, `updated_at`)\
     VALUES ('%s', '%s', '%s', '%s', NOW(), NOW())" % (device_id, variant_id, group_id, inventory_id)

    cursor = mydb.cursor()

    try :
        result = cursor.execute(query)
        data = {}
        data["status"] = True
        data["device_proposition_group_map_id"] = cursor.lastrowid
        mydb.commit()
        return data
    except:
        mydb.rollback();
        data = {}
        data["status"] = False
    mydb.close()

def py_get_truemoveh_mobile_sim(start=1):
    
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = " SELECT \
        truemoveh_mobiles.mobile_type, \
        truemoveh_price_plans.id as price_plan_id,\
        truemoveh_provinces.id as province_id\
        FROM truemoveh_mobiles\
        LEFT JOIN truemoveh_propositions ON truemoveh_mobiles.proposition_id = truemoveh_propositions.id\
        LEFT JOIN truemoveh_proposition_maps ON truemoveh_propositions.id = truemoveh_proposition_maps.proposition_id\
        LEFT JOIN truemoveh_price_plans ON truemoveh_proposition_maps.price_plan_id = truemoveh_price_plans.id\
        LEFT JOIN truemoveh_zone_maps ON truemoveh_zone_maps.zone_id = truemoveh_mobiles.zone_id\
        LEFT JOIN truemoveh_provinces ON truemoveh_provinces.id = truemoveh_zone_maps.province_id\
        WHERE truemoveh_propositions.deleted_at IS NULL\
        AND truemoveh_propositions.status = 'Y'\
        AND truemoveh_propositions.source_type = 'sim'\
        AND truemoveh_price_plans.deleted_at IS NULL\
        AND truemoveh_price_plans.status = 'Y'\
        AND truemoveh_mobiles.used = 'N'\
        AND truemoveh_mobiles.status = 'Y' \
        LIMIT %s,1" % start
    
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        row = cursor.fetchone()
        data = {}
        data["mobile_type"] = row[0]
        data["price_plan_id"] = row[1]
        data["province_id"] = row[2]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()    

def py_get_truemoveh_inventory_id_sim(start=1):
    
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = " SELECT truemoveh_sim_variants.inventory_id as inventory_id_sim FROM \
        truemoveh_sub_device \
        INNER JOIN truemoveh_device ON truemoveh_device.id = truemoveh_sub_device.device_id\
        INNER JOIN truemoveh_device_types ON truemoveh_device_types.id = truemoveh_sub_device.device_sub_id\
        INNER JOIN truemoveh_sim_variants ON truemoveh_device_types.id = truemoveh_sim_variants.device_type_id\
        WHERE truemoveh_sim_variants.device_type = 'sim'\
        GROUP BY  inventory_id_sim LIMIT 1" \
    
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        row = cursor.fetchone() 
        inventory_id_sim = row[0]
        return inventory_id_sim
    except:
        print "Cannot fetch data."
    mydb.close()    


def py_get_price_plan_mnp_sim():
    
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT  truemoveh_price_plans.id\
        FROM `truemoveh_proposition_maps` \
        INNER JOIN truemoveh_propositions ON truemoveh_proposition_maps.proposition_id = truemoveh_propositions.id\
        INNER JOIN truemoveh_price_plans ON truemoveh_proposition_maps.price_plan_id = truemoveh_price_plans.id  \
        WHERE truemoveh_propositions.source_type = 'mnp' \
        AND truemoveh_propositions.status = 'Y' \
        AND truemoveh_price_plans.status = 'Y' \
        ORDER BY truemoveh_price_plans.id ASC LIMIT 0,1"

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        row = cursor.fetchone()
        return row[0]
    except:
        print "Cannot fetch data."
    mydb.close()

def py_get_commission_report_data(bundle_type='sim', download_operation='>=', merchant=None, start=0):
    
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT `truemoveh_order_verifys`.`pcms_order_id`,\
           `bundle_type`, `download_count`\
    FROM `truemoveh_order_verifys`\
    INNER JOIN `order_shipment_items` AS `i` ON `i`.`id` = `truemoveh_order_verifys`.`pcms_item_id`\
    WHERE `truemoveh_order_verifys`.`deleted_at` IS NULL\
      AND (`download_count` %s 0\
           AND `bundle_type` = '%s')\
      AND (`i`.`item_status` = 'shipped'\
           OR `i`.`item_status` = 'delivered')\
      AND `activate_date` IS NOT NULL\
      AND `status` = 'Y'\
      AND `activate_status` = 'success'\
      AND `merchant_id` %s \
    ORDER BY `pcms_order_id` DESC LIMIT %s,1 " % (download_operation, bundle_type, merchant, start)

    # return query
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        row = cursor.fetchone()
        data = {}
        data["pcms_order_id"] = row[0]
        data["bundle_type"] = row[1]
        data["download_count"] = row[2]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()    

def py_get_commission_report_data_mnp(start=0):
    
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT `truemoveh_order_verifys`.`pcms_order_id`,\
           `bundle_type`, `download_count` \
    FROM `truemoveh_order_verifys`\
    INNER JOIN `order_shipment_items` AS `i` ON `i`.`id` = `truemoveh_order_verifys`.`pcms_item_id`\
    WHERE `truemoveh_order_verifys`.`deleted_at` IS NULL\
      AND (`truemoveh_order_verifys`.`mnp1_status` = 'success'\
           AND `download_count` >= 0\
           AND `bundle_type` = 'mnp')\
      AND (`i`.`item_status` = 'shipped'\
           OR `i`.`item_status` = 'delivered')\
      AND `activate_date` IS NOT NULL\
      AND `status` = 'Y'\
      AND `activate_status` = 'success'\
      AND (`mnp1_status` = 'success')\
    ORDER BY `pcms_order_id` DESC  LIMIT %s,1 " % start

    # return query
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        row = cursor.fetchone()
        data = {}
        data["pcms_order_id"] = row[0]
        data["bundle_type"] = row[1]
        data["download_count"] = row[2]

        return data
    except:
        print "Cannot fetch data."
    mydb.close()    

def py_get_commission_report_with_activated_date(bundle_type='sim', download_operation='>=', activate_operation='>=', merchant=None, start=0):
    
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT `truemoveh_order_verifys`.`pcms_order_id`,\
           `bundle_type`, `download_count`,\
           DATEDIFF(DATE_FORMAT(NOW(),'%s'), DATE_FORMAT(activate_date,'%s')) AS diff_date\
    FROM `truemoveh_order_verifys`\
    INNER JOIN `order_shipment_items` AS `i` ON `i`.`id` = `truemoveh_order_verifys`.`pcms_item_id`\
    WHERE `truemoveh_order_verifys`.`deleted_at` IS NULL\
      AND (`download_count` %s 0\
           AND `bundle_type` = '%s')\
      AND (`i`.`item_status` = 'shipped'\
           OR `i`.`item_status` = 'delivered') \
      AND `activate_date` IS NOT NULL\
      AND `status` = 'Y' \
      AND `activate_status` = 'success' \
      AND `merchant_id` %s \
    HAVING `diff_date` %s 15 \
    ORDER BY `pcms_order_id` DESC LIMIT %s,1 " % ('%Y-%m-%d', '%Y-%m-%d', download_operation, bundle_type, merchant,activate_operation, start)

    # return query
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        row = cursor.fetchone()
        data = {}
        data["pcms_order_id"] = row[0]
        data["bundle_type"] = row[1]
        data["download_count"] = row[2]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()    


def py_delete_truemoveh_device_proposition_group_maps_by_device_name(device_name=None):
    if device_name is None : 
        return None 
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try : 
        query = "DELETE `truemoveh_device_proposition_group_maps`.* \
    FROM `truemoveh_device_proposition_group_maps` \
    INNER JOIN truemoveh_device ON truemoveh_device.id = truemoveh_device_proposition_group_maps.group_id \
    WHERE truemoveh_device.name LIKE '%s' " % device_name
        result = cursor.execute(query)
        mydb.commit()
        return True
    except: 
        mydb.rollback()
        return False


def py_get_mobile_is_hold_by_customer(mobile, customer_ref_id):
    
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT hold_expired_date FROM `truemoveh_mobiles` \
    WHERE mobile LIKE '%s' AND hold_expired_date IS NOT NULL AND customer_ref_id = '%s'\
    LIMIT 0,1" % (mobile, customer_ref_id)
    
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        row = cursor.fetchone()
        data = {}
        data["hold_expired_date"] = row[0]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()


def py_get_data_for_buy_bundle():
    
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT \
    truemoveh_device.pkey as product_pkey, \
    variants.inventory_id as product_inventory_id, \
    truemoveh_device_types.inventory_id as product_sim_inventory_id, \
    truemoveh_price_plans.id as price_plan_id, \
    truemoveh_price_plans.pp_code as pp_code, \
    truemoveh_propositions.parent_id as parent_id \
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
    WHERE truemoveh_propositions.source_type = 'bundle' \
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
        data["parent_id"] = row[5]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()


def py_get_mobile_by_proposition_id(proposition_id):
    
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT id, mobile  FROM `truemoveh_mobiles` \
    WHERE `proposition_id` = %s \
    AND hold_expired_date IS NULL \
    AND customer_ref_id IS NULL \
    AND used = 'N' \
    AND status = 'Y' \
    ORDER BY `id`  ASC \
    LIMIT 0,1 " % proposition_id
    
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        row = cursor.fetchone()
        data = {}
        data["mobile_id"] = row[0]
        data["mobile_number"] = row[1]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()


def py_get_pcms_order_id_by_mobile_and_idcard(mobile, idcard, source_type='mnp'):
    
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT pcms_order_id  FROM `truemoveh_order_verifys` \
        WHERE `idcard` LIKE '%s' \
        AND `mobile` LIKE '%s' \
        AND `bundle_type` = '%s' \
        AND deleted_at IS NULL\
        ORDER BY `pcms_order_id`  DESC LIMIT 0,1" % (idcard, mobile, source_type)
    
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        row = cursor.fetchone()
        return row[0]
    except:
        print "Cannot fetch data."
    mydb.close()

def py_insert_truemoveh_mobile_hold_expired_date_is_null(mobile, mobile_type, used, status, expired_date):

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "INSERT INTO truemoveh_mobiles (mobile, mobile_type, used, status, created_at, expired_date) \
        VALUES ('%s' , '%s', '%s', '%s', NOW(), '%s')" % (mobile, mobile_type, used, status, expired_date)

    try :
        cursor = mydb.cursor()
        result = cursor.execute(query)
        mydb.commit()
        return result
    except:
        mydb.rollback()
        return "Cannot Insert"
    mydb.close()

def py_insert_truemoveh_mobile_full(import_lot, zone_id, mobile, mobile_type, mobile_pattern_id, proposition_id, company_code, used, status, expired_date, hold_expired_date=None, user_id=999):

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    if hold_expired_date == '' :
        query = "INSERT INTO truemoveh_mobiles (import_lot, zone_id, mobile, mobile_type, mobile_pattern_id, proposition_id, expired_date, company_code, used, status, user_id, created_at, updated_at) \
                VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', NOW(), NOW())" % (import_lot, zone_id, mobile, mobile_type, mobile_pattern_id, proposition_id, expired_date, company_code, used, status, user_id)
    else :
        query = "INSERT INTO truemoveh_mobiles (import_lot, zone_id, mobile, mobile_type, mobile_pattern_id, proposition_id, expired_date, hold_expired_date, company_code, used, status, user_id, created_at, updated_at) \
                VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', NOW(), NOW())" % (import_lot, zone_id, mobile, mobile_type, mobile_pattern_id, proposition_id, expired_date, hold_expired_date, company_code, used, status, user_id)

    try :
        cursor = mydb.cursor()
        result = cursor.execute(query)
        mydb.commit()
        return result
    except:
        mydb.rollback()
        return "Cannot Insert"
    mydb.close()

def py_insert_truemoveh_mobile(mobile, mobile_type, hold_expired_date, used, status, expired_date):

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "INSERT INTO truemoveh_mobiles (mobile, mobile_type, hold_expired_date, used, status, created_at, expired_date) \
        VALUES ('%s' , '%s', '%s', '%s', '%s', NOW(), '%s')" % (mobile, mobile_type, hold_expired_date, used, status, expired_date)

    try :
        cursor = mydb.cursor()
        result = cursor.execute(query)
        mydb.commit()
        return result
    except:
        mydb.rollback()
        return "Cannot Insert"
    mydb.close()

def py_delete_truemoveh_mobile(mobile):

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try :
        query = "DELETE FROM truemoveh_mobiles WHERE mobile = '%s'" % mobile
        result = cursor.execute(query)
        mydb.commit()
        return result
    except:
        mydb.rollback()
        return "Cannot Delete"
    mydb.close()

def py_delete_truemoveh_mobile_with_lot_and_company_code(import_lot, company_code):

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try :
        query = "DELETE FROM truemoveh_mobiles WHERE import_lot = '%s' AND company_code = '%s'" % (import_lot, company_code)
        result = cursor.execute(query)
        mydb.commit()
        return result
    except:
        mydb.rollback()
        return "Cannot Delete"
    mydb.close()

def get_mobile_id_by_mobile_number(mobile_number):

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try :
        query = "SELECT id FROM truemoveh_mobiles WHERE mobile = '%s' AND deleted_at is NULL" % (mobile_number)
        cursor.execute(query)
        row = cursor.fetchone()
        data = {}
        data["mobile_id"] = row[0]
        return data
    except:
        return "Cannot fetch data"
    mydb.close()

def update_mobile_number_in_cart(mobile_number, url_key):

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try :
        query = "UPDATE truemoveh_cart_mobile_numbers SET mobile_number= '%s' WHERE url_key= '%s'" % (mobile_number, url_key)
        result = cursor.execute(query)
        mydb.commit()
        return result
    except:
        return "Cannot Update"
    mydb.close()

def py_get_pcms_truemove_order_id_and_dealer_name(dealer_id):

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT `pcms_order_id`, `truemoveh_merchants`.`name` AS `name`, date(`truemoveh_order_verifys`.`created_at`) AS `created_at`, \
        date(`transaction_time`) AS `transaction_time`, `orders`.`payment_status` AS `payment_status`, `truemoveh_order_verifys`.`status` AS `status`, \
        `item_status`, `activate_status`, `truemoveh_mobiles`.`mobile` AS `mobile_no`, `order_shipment_items`.`id` AS `item_id` \
        FROM `truemoveh_order_verifys` \
        LEFT JOIN `truemoveh_merchants` ON `truemoveh_merchants`.`id` = `truemoveh_order_verifys`.`merchant_id` \
        LEFT JOIN `order_shipment_items` ON `order_shipment_items`.`id` = `pcms_item_id` \
        LEFT JOIN `orders` ON `orders`.`id` = `pcms_order_id` \
        LEFT JOIN `truemoveh_mobiles` ON `truemoveh_mobiles`.`id` = `truemoveh_order_verifys`.`mobile_id` \
        LEFT JOIN `truemoveh_price_plans` ON `truemoveh_order_verifys`.`price_plan_id` = `truemoveh_price_plans`.`id` \
        LEFT JOIN `truemoveh_propositions` ON `truemoveh_mobiles`.`proposition_id` = `truemoveh_propositions`.`id` \
        LEFT JOIN `truemoveh_mobile_number_types` ON `truemoveh_mobiles`.`mobile_type` = `truemoveh_mobile_number_types`.`id` \
        WHERE `merchant_id` = '%s' \
        AND `transaction_time` IS NOT NULL \
        AND `activate_status` IS NOT NULL \
        AND `truemoveh_mobiles`.`mobile` IS NOT NULL \
        AND `truemoveh_order_verifys`.`deleted_at` IS NULL \
        AND `truemoveh_order_verifys`.`bundle_type` = 'sim' \
        ORDER BY `pcms_order_id`  DESC LIMIT 0,1" % (dealer_id)

    cursor = mydb.cursor()
    try:
            cursor.execute(query)
            row = cursor.fetchone()
            data = {}
            data["pcms_order_id"] = row[0]
            data["name"] = row[1]
            data["created_at"] = row[2]
            data["transaction_time"] = row[3]
            data["payment_status"] = row[4]
            data["status"] = row[5]
            data["item_status"] = row[6]
            data["activate_status"] = row[7]
            data["mobile_no"] = row[8]
            data["item_id"] = row[9]
            return data
    except:
        print "Cannot fetch data."
    mydb.close()

def py_get_pcms_truemove_order_id_and_dealer_null():

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT `pcms_order_id`, `truemoveh_merchants`.`name` AS `name`, date(`truemoveh_order_verifys`.`created_at`) AS `created_at`, \
        date(`transaction_time`) AS `transaction_time`, `orders`.`payment_status` AS `payment_status`, `truemoveh_order_verifys`.`status` AS `status`, \
        `item_status`, `activate_status`, `truemoveh_mobiles`.`mobile` AS `mobile_no`, `order_shipment_items`.`id` AS `item_id` \
        FROM `truemoveh_order_verifys` \
        LEFT JOIN `truemoveh_merchants` ON `truemoveh_merchants`.`id` = `truemoveh_order_verifys`.`merchant_id` \
        LEFT JOIN `order_shipment_items` ON `order_shipment_items`.`id` = `pcms_item_id` \
        LEFT JOIN `orders` ON `orders`.`id` = `pcms_order_id` \
        LEFT JOIN `truemoveh_mobiles` ON `truemoveh_mobiles`.`id` = `truemoveh_order_verifys`.`mobile_id` \
        LEFT JOIN `truemoveh_price_plans` ON `truemoveh_order_verifys`.`price_plan_id` = `truemoveh_price_plans`.`id` \
        LEFT JOIN `truemoveh_propositions` ON `truemoveh_mobiles`.`proposition_id` = `truemoveh_propositions`.`id` \
        LEFT JOIN `truemoveh_mobile_number_types` ON `truemoveh_mobiles`.`mobile_type` = `truemoveh_mobile_number_types`.`id` \
        WHERE `merchant_id` IS NULL \
        AND `transaction_time` IS NOT NULL \
        AND `activate_status` IS NOT NULL \
        AND `truemoveh_mobiles`.`mobile` IS NOT NULL \
        AND `truemoveh_order_verifys`.`deleted_at` IS NULL \
        AND `truemoveh_order_verifys`.`bundle_type` = 'sim' \
        ORDER BY `pcms_order_id`  DESC LIMIT 0,1"

    cursor = mydb.cursor()
    try:
            cursor.execute(query)
            row = cursor.fetchone()
            data = {}
            data["pcms_order_id"] = row[0]
            data["name"] = row[1]
            data["created_at"] = row[2]
            data["transaction_time"] = row[3]
            data["payment_status"] = row[4]
            data["status"] = row[5]
            data["item_status"] = row[6]
            data["activate_status"] = row[7]
            data["mobile_no"] = row[8]
            data["item_id"] = row[9]
            return data
    except:
        print "Cannot fetch data."
    mydb.close()
