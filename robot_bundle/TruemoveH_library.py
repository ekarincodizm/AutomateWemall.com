import MySQLdb as db

from ConnectDB import *
from robot.libraries.BuiltIn import BuiltIn

def py_get_product_level_d_has_style(start=1):
    
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
        AND `collections`.`slug` LIKE '%s' \
        AND `collections`.`parent_id` = 0\
        AND `brands`.`deleted_at` is null\
        GROUP BY `variants`.`id`\
        HAVING countStyle = 1 AND  count_inventory > 1\
        ORDER BY count(`variants`.`id`) DESC LIMIT %s,1" % ( ("%"+"smartphone"+"%") ,start )


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
        AND `collections`.`parent_id` = 0\
        AND `brands`.`deleted_at` is null\
        GROUP BY `variants`.`id`\
        HAVING countStyle = 1 AND  count_inventory > 1\
        ORDER BY count(`variants`.`id`) DESC LIMIT %s,1" % ( start )
            # AND `collections`.`slug` LIKE '%s' \
                    # ORDER BY count(`variants`.`id`) DESC LIMIT %s,1" % ( ("%"+"smartphone"+"%") ,start )


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
        data["proposition_id"] = row[3]
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