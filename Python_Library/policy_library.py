import MySQLdb as db
import socket
import datetime
from ConnectDB import *
from robot.libraries.BuiltIn import BuiltIn


def get_policy_global(shop_code='WEMALLGLOBAL'):
    #get shop_code = WEMALLGLOBAL from tbl shops

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    try :
        query = "SELECT `s`.`shop_code` as shop_code, \
                        `s`.`name`  as shop_name, \
                        `pm`.`id` as policy_maps_id, \
                        `pm`.`delivery_min_day` as delivery_min, \
                        `pm`.`delivery_max_day` as delivery_max, \
                        `pt`.`lang` as policylang, \
                        `pt`.`slug` as policy_slug, \
                        `pt`.`value` as policy_value \
                FROM `shops` as s \
                INNER JOIN `policy_maps` as pm on `s`.`shop_id` = `pm`.`ref_id` \
                INNER JOIN `policy_translates` as pt on `pm`.`id` = `pt`.`policy_maps_id` \
                WHERE `s`.`shop_code` = '%s' \
                AND `pm`.`module` = 'shops' \
                " % shop_code
        cursor = mydb.cursor()
        result = cursor.execute(query)
        result = cursor.fetchall()
        return result

    except :
        mydb.rollback()
        return None

def py_get_merchant_id_by_shop_code(shop_code='WEMALLGLOBAL'):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    try:
        query = "SELECT shop_id FROM shops WHERE shop_code = '%s'" % (shop_code)
        cursor = mydb.cursor()
        result = cursor.execute(query)
        result = cursor.fetchone()
        return result[0]
        pass
    except Exception, e:
        print "*WARN* Unexpected error on `py_get_merchant_id_by_shop_code`:", e
        raise

def py_delete_merchant_policy_by_merchant_id(merchant_id):

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    try :
        query = "SELECT id \
            FROM policy_maps \
            WHERE module = 'Shops' \
            AND ref_id = %s \
            " % merchant_id
        cursor = mydb.cursor()
        result = cursor.execute(query)
        result = cursor.fetchone()
        policy_maps_id = result[0]

        query = "DELETE FROM policy_maps \
            WHERE id = %s \
            " % policy_maps_id
        cursor = mydb.cursor()
        result = cursor.execute(query)

        query = "DELETE FROM policy_translates \
            WHERE policy_maps_id = %s \
            " % policy_maps_id
        cursor = mydb.cursor()
        result = cursor.execute(query)
        mydb.commit()

    except :
        mydb.rollback()


def py_get_merchant_policy_by_merchant_id(merchant_id='322963'):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    try :
        query = "SELECT * FROM `policy_maps` as pm \
         WHERE `pm`.`module` = 'shops' \
         AND `pm`.`ref_id` = %s " % merchant_id

        cursor = mydb.cursor()
        result = cursor.execute(query)
        policy_map = cursor.fetchone()

        # Get policy_translates
        query = "SELECT * FROM `policy_translates` as pt \
                WHERE `pt`.`policy_maps_id` = %s \
                " % policy_map[0]

        cursor = mydb.cursor()
        result = cursor.execute(query)
        policy_translate = cursor.fetchall()

        policy = {}
        policy["policy_maps"] = policy_map
        policy["policy_translates"] = policy_translate

        BuiltIn().log_to_console("xxxxxxxxx")
        BuiltIn().log_to_console(policy)
        BuiltIn().log_to_console("xxxxxxxxx")

        return policy

    except Exception, e:
        print "*WARN* Unexpected error on `py_get_merchant_policy_by_merchant_id`:", e
        mydb.rollback()
        return 0

def py_get_policy_map(merchant_id):
    query = "SELECT * FROM `policy_maps` as pm WHERE `pm`.`module` = 'shops' AND `pm`.`ref_id` = %s " % merchant_id
    return fetch_one_assoc(query)

def py_get_policy_translate(merchant_id):
    mysqlDb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT * FROM `policy_translates` as pt WHERE `pt`.`policy_maps_id` = %s" % merchant_id

    cursor = mysqlDb.cursor()
    cursor.execute(query)
    columns = cursor.description
    result = {}

    for value in cursor.fetchall():
        tmp = {}

        for (index,column) in enumerate(value):
            tmp[columns[index][0]] = column

        result[tmp["slug"] + "-" + tmp["lang"]] = tmp["value"].rstrip('\r\n')

    return result

def update_delivery_by_merchant(merchant_id, delivery_min, delivery_max):

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    try :
        query = "UPDATE policy_maps \
            SET delivery_min_day = %s \
            , delivery_max_day = %s \
            WHERE ref_id = %s \
            AND module = 'shops' \
            " % (delivery_min, delivery_max, merchant_id)

        cursor = mydb.cursor()
        cursor.execute(query)
        mydb.commit()

        query = "SELECT * FROM policy_maps \
            WHERE ref_id = %s \
            AND module = 'shops' \
            " % (merchant_id)
        cursor = mydb.cursor()
        cursor.execute(query)
        policy_map = cursor.fetchone()
        cursor.close()
        mydb.close()

        return policy_map
    except :
        return None

def py_insert_policy(policy_data):  # Including policy_maps and array of policy_translates
    
    BuiltIn().log_to_console(policy_data)

    policy_maps = policy_data.get('policy_maps')
    policy_translates = policy_data.get('policy_translates')
    policy_maps_id = policy_maps[0]

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    try :
        if policy_maps_id == "":
            query = "INSERT INTO policy_maps (`module`, `ref_id`, `delivery_min_day`, `delivery_max_day`, `updated_by_user_id`, `created_at`) \
                VALUES ('%s', %s, %s, %s, %s, '%s')\
                " % (policy_maps[1], policy_maps[2], policy_maps[3], policy_maps[4], policy_maps[5], policy_maps[6])
        else:
            query = "INSERT INTO policy_maps (`id`, `module`, `ref_id`, `delivery_min_day`, `delivery_max_day`, `updated_by_user_id`, `created_at`) \
                VALUES (%s, '%s', %s, %s, %s, %s, '%s')\
                " % (policy_maps[0], policy_maps[1], policy_maps[2], policy_maps[3], policy_maps[4], policy_maps[5], policy_maps[6])

        BuiltIn().log_to_console(query)
        cursor = mydb.cursor()
        cursor.execute(query)

        policy_maps_id = mydb.insert_id()

        for policy_translate in policy_translates:

            if policy_translate[0] == "":
                 query = "INSERT INTO policy_translates (`policy_maps_id`, `lang`, `slug`, `value`, `updated_by_user_id`, `created_at`) \
                    VALUES (%s, '%s', '%s', '%s', %s, '%s')\
                    " % (policy_maps_id, policy_translate[2], policy_translate[3], policy_translate[4], policy_translate[5], policy_translate[6])

            else:
                 query = "INSERT INTO policy_translates (`id`, `policy_maps_id`, `lang`, `slug`, `value`, `updated_by_user_id`, `created_at`) \
                    VALUES (%s, %s, '%s', '%s', '%s', %s, '%s')\
                    " % (policy_translate[0], policy_translate[1], policy_translate[2], policy_translate[3], policy_translate[4], policy_translate[5], policy_translate[6])

            cursor = mydb.cursor()
            cursor.execute(query)


        mydb.commit()
        return True

    except IOError as e:
        mydb.rollback()
        return e

def py_insert_merchant_policy_data(shop_id):
    return insert_merchant_policy_data(shop_id, 2, 10);

def insert_merchant_policy_data(shop_id, delivery_min, delivery_max):
    try:
        policy_maps_id = insert_policy_maps('shops', shop_id, delivery_min, delivery_max)

        insert_policy_translate(policy_maps_id, 'th_TH', 'delivery.title', 'delivery.title-DUMMY')
        insert_policy_translate(policy_maps_id, 'th_TH', 'delivery.detail', 'delivery.detail-DUMMY')
        insert_policy_translate(policy_maps_id, 'th_TH', 'return.title', 'return.title-DUMMY')
        insert_policy_translate(policy_maps_id, 'th_TH', 'return.detail', 'return.detail-DUMMY')
        insert_policy_translate(policy_maps_id, 'th_TH', 'refund.title', 'refund.title-DUMMY')
        insert_policy_translate(policy_maps_id, 'th_TH', 'refund.detail', 'refund.detail-DUMMY')

        insert_policy_translate(policy_maps_id, 'en_US', 'delivery.title', 'delivery.title-DUMMY')
        insert_policy_translate(policy_maps_id, 'en_US', 'delivery.detail', 'delivery.detail-DUMMY')
        insert_policy_translate(policy_maps_id, 'en_US', 'return.title', 'return.title-DUMMY')
        insert_policy_translate(policy_maps_id, 'en_US', 'return.detail', 'return.detail-DUMMY')
        insert_policy_translate(policy_maps_id, 'en_US', 'refund.title', 'refund.title-DUMMY')
        insert_policy_translate(policy_maps_id, 'en_US', 'refund.detail', 'refund.detail-DUMMY')

        return policy_maps_id
    except Exception, e:
        print "*WARN* Unexpected error on `insert_merchant_policy_data`:", e
        return 0

def insert_merchant_policy_data_th_only(shop_id, delivery_min, delivery_max):
    try:
        policy_maps_id = insert_policy_maps('shops', shop_id, delivery_min, delivery_max)
        
        insert_policy_translate(policy_maps_id, 'th_TH', 'delivery.title', 'delivery.title-DUMMY')
        insert_policy_translate(policy_maps_id, 'th_TH', 'delivery.detail', 'delivery.detail-DUMMY')
        insert_policy_translate(policy_maps_id, 'th_TH', 'return.title', 'return.title-DUMMY')
        insert_policy_translate(policy_maps_id, 'th_TH', 'return.detail', 'return.detail-DUMMY')
        insert_policy_translate(policy_maps_id, 'th_TH', 'refund.title', 'refund.title-DUMMY')
        insert_policy_translate(policy_maps_id, 'th_TH', 'refund.detail', 'refund.detail-DUMMY')

        insert_policy_translate(policy_maps_id, 'en_US', 'delivery.title', '')
        insert_policy_translate(policy_maps_id, 'en_US', 'delivery.detail', '')
        insert_policy_translate(policy_maps_id, 'en_US', 'return.title', '')
        insert_policy_translate(policy_maps_id, 'en_US', 'return.detail', '')
        insert_policy_translate(policy_maps_id, 'en_US', 'refund.title', '')
        insert_policy_translate(policy_maps_id, 'en_US', 'refund.detail', '')

        return policy_maps_id
    except Exception, e:
        print "*WARN* Unexpected error on `insert_merchant_policy_data`:", e
        return 0

def py_insert_policy_maps(module, ref_id):
    return insert_policy_maps(module, ref_id, 2, 10);

def insert_policy_maps(module, ref_id, delivery_min, delivery_max):
    mysqlDb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    try :

        query = "INSERT INTO policy_maps (module, ref_id, delivery_min_day, delivery_max_day, updated_by_user_id, created_at) \
            VALUES ('%s', '%s', '%s', '%s', '1', CURRENT_TIMESTAMP)" \
            % (module, ref_id, delivery_min, delivery_max)

        # BuiltIn().log_to_console('------- insert_policy_maps= %s' % query)
        cursor = mysqlDb.cursor()
        cursor.execute(query)
        lastInsertId = cursor.lastrowid
        mysqlDb.commit()
        return lastInsertId
    except Exception, e:
        print "*WARN* Unexpected error on `insert_policy_maps`:", e
        return 0

def py_update_delivery(module, ref_id, delivery_type, value):
    return update_delivery(module, ref_id, delivery_type, value)

def update_delivery(module, ref_id, delivery_type, value):
    mysqlDb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    try:
        query = "UPDATE policy_maps SET %s='%s' WHERE module = '%s' AND ref_id = '%s'" % (delivery_type, value, module, ref_id)
        BuiltIn().log_to_console(query)
        cursor = mysqlDb.cursor()
        cursor.execute(query)
        mysqlDb.commit()
        return 1
    except Exception, e:
        print "*WARN* Unexpected error on `update_delivery`:", e
        return 0

def insert_policy_translate(policy_maps_id, lang, slug, value):
    mysqlDb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    try :
        query = "INSERT INTO policy_translates (policy_maps_id, lang, slug, value, updated_by_user_id, created_at) VALUES ('%s', '%s', '%s', '%s', '1', CURRENT_TIMESTAMP)" % (policy_maps_id, lang, slug, value)
        mysqlDb.cursor().execute(query)
        mysqlDb.commit()
    except Exception, e:
        print "*WARN* Unexpected error on `insert_policy_translate`:", e

def py_backup_delivery_day(module, ref_id):
    
    mysqlDb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    
    try :
        query = "SELECT delivery_min_day, delivery_max_day \
                    FROM policy_maps \
                    WHERE module = 'shops' AND ref_id = %s " % ref_id
        
        cursor = mysqlDb.cursor()
        result = cursor.execute(query)
        result = cursor.fetchone()

        data = {}
        data["delivery_min_day"] = result[0]
        data["delivery_max_day"] = result[1]
        return data

    except Exception, e:
        return BuiltIn().log_to_console('DB exception: %s' % e)

def py_update_delivery_day(module, ref_id, delivery_min_day, delivery_max_day):
    
    mysqlDb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    
    try:
        query = "UPDATE policy_maps \
                    SET delivery_min_day = %s ,\
                    delivery_max_day = %s \
                    WHERE module = '%s' \
                    AND ref_id = '%s'" % (delivery_min_day, delivery_max_day, module, ref_id)
        
        cursor = mysqlDb.cursor()
        cursor.execute(query)
        mysqlDb.commit()
        return 1
    except Exception, e:
        return BuiltIn().log_to_console('DB exception: %s' % e)

## Required Plz Run Keyword - delete_detail_of_policy After before
def delete_deliverytime_by_shop_code(shop_code):
    print shop_code

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    try : 
        query = "DELETE FROM `policy_maps` \
        WHERE `ref_id` = (SELECT `shop_id` FROM `shops` WHERE `shop_code` = '%s') \
        " % shop_code
        cursor = mydb.cursor()
        result = cursor.execute(query)
        mydb.commit()
        return True

    except : 
        mydb.rollback()
        return False

def delete_detail_of_policy(shop_code):
    print shop_code
    
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    try : 
        query = "DELETE FROM `policy_translates` \
         WHERE `policy_maps_id` = (SELECT `id` FROM `policy_maps` WHERE `ref_id` = \
            (SELECT `shop_id` FROM `shops` WHERE `shop_code` = '%s'\
            ))" % shop_code
        cursor = mydb.cursor()
        result = cursor.execute(query)
        mydb.commit()
        return True

    except : 
        mydb.rollback()
        return False