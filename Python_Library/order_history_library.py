import MySQLdb as db
import socket
from ConnectDB import *  


def insert_order(customer_ref_id=None, customer_email=None, payment_method='1', order_status='new', payment_status='success', lang_code='th', created_at='NOW()') :

    if customer_ref_id is None :
        return False

    if customer_email is None :
        return False

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try : 
        query = "INSERT INTO `orders` (`pkey`, `order_ref`, `app_id`, `cart_id`, `booking_id`, `ref1`, `ref2`, `ref3`, `payment_order_id`, `payment_source`, `bank_name`, `tmn_name`, `installment_card_type`, `barcode`, `barcode_image`, `customer_ref_id`, `customer_name`, `customer_address`, `customer_district`, `customer_district_id`, `customer_city`, `customer_city_id`, `customer_province`, `customer_province_id`, `customer_postcode`, `customer_tel`, `customer_email`, `customer_info_modified_at`, `payment_channel`, `payment_method`, `selected_method`, `total_sent_pb`, `installment`, `transaction_time`, `total_price`, `discount`, `discount_text`, `total_discount`, `total_shipping_fee`, `sub_total`, `order_status`, `payment_status`, `bank_id`, `card_issuer`, `card_network`, `card_description`, `card_ref_id`, `gift_status`, `sla_time_at`, `customer_status`, `customer_sla_time_at`, `expired_at`, `invoice`, `analytics_status`, `lang_code`, `sync_status`, `sync_log`, `bundle`, `camp_data`, `camp_promotion`, `created_at`, `updated_at`, `deleted_at`) \
            VALUES( 11913824883597, '9160329948960', 1, 55210, NULL, 'NULL', 'NULL', '100003717', '9160329948960', 'truemoney', NULL, NULL, NULL, NULL, NULL, '%s', 'Robot Name', 'Robot Addr', 'xxx', 74, 'xxx', 18, 'xxx', 1, '10600', '0890000000', '%s', NULL, 'online', '%s', NULL, 0, NULL, NOW(), 2790.00, 19, NULL, 19, 0, 2771.00, '%s', '%s', NULL, 'OTHER', 'MASTER', '555555', NULL, NULL, NULL, NULL, NULL, NOW() + INTERVAL 3 DAY, NULL, 'N', '%s', 'success', '', 'N', NULL, NULL, %s, NOW(), NULL) \
        " % (customer_ref_id, customer_email, payment_method, order_status, payment_status, lang_code, created_at)
        
        result = cursor.execute(query)
        row_id = cursor.lastrowid
        mydb.commit()
        return row_id

    except Exception, e:
        BuiltIn().log_to_console('DB exception: %s' % e) 
        # mydb.rollback();
        return False


def insert_order_shipment(order_id=None, created_at='NOW()') :
    if order_id is None :
        return False

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try : 
        query = "INSERT INTO `order_shipments` (`order_id`, `shipment_ref`, `customer_address_id`, `shipping_method`, `shipping_fee`, `shipment_status`, `total_price`, `stock_type`, `vendor_id`, `shop_id`, `tracking_number`, `sla_time_at`, `created_at`, `updated_at`, `deleted_at`)  \
            VALUES('%s', '1459233699', NULL, '7', 0, '', 2790, '1', '2419', '322963', NULL, NULL, %s, NOW(), NULL) \
        " % (order_id, created_at)

        result = cursor.execute(query)
        row_id = cursor.lastrowid
        mydb.commit()
        return row_id

    except Exception, e: 
        mydb.rollback();
        return False


def insert_order_shipment_item(order_id=None, order_shipment_id=None, image=None, created_at='NOW()', inventory_id='ASAAA1118511', shop_id='322963') :
    if order_id is None :
        return False

    if order_shipment_id is None :
        return False

    if image is None or image == 'None' :
        image = '/14-10-30/73f1daf122492feddc3d7a25c56ed148_s.jpg'
        # image = 'http://cdn-p3.itruemart-dev.com/pcms/uploads/14-10-30/73f1daf122492feddc3d7a25c56ed148_s.jpg'

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try : 
        product_name = 'Robot Asus Zenfone C ZC451CG : ' +inventory_id
        query = "INSERT INTO `order_shipment_items` (`shipment_id`, `order_id`, `inventory_id`, `inventory_id_old`, `material_code`, `name`, `category`, `brand`, `quantity`, `price`, `margin`, `discount`, `discount_weight`, `total_price`, `total_margin`, `vendor_id`, `shop_id`, `options`, `item_status`, `payment_status`, `is_gift_item`, `tracking_number`, `third_pl_id`, `images`, `created_at`, `updated_at`, `deleted_at`, `stock_type`, `sync_status`, `sync_log`, `material_id`, `serial_number`, `bundle`, `camp_type`, `camp_id`, `verify_note`, `verify_by_user_id`, `promotion_type`)   \
            VALUES('%s', '%s', '%s', NULL, 3000040896, '%s', NULL, NULL, 1, 2790, 2790, 0, 19, 2790, 2771, '2419', '%s', 'null', 'shipped', 'success', '0', 'tracking_order_id_4990805', 10, '%s', %s, NOW(), NULL, '1', NULL, NULL, '1234', '', 'N', 'none', NULL, NULL, NULL, 'none') \
        " % (order_shipment_id, order_id, inventory_id, product_name, shop_id, image, created_at)

        result = cursor.execute(query)
        row_id = cursor.lastrowid
        mydb.commit()
        BuiltIn().log_to_console('------ insert_order_shipment_item : data = %s' % query)
        BuiltIn().log_to_console('------ insert_order_shipment_item : inventory_id = %s' % inventory_id)
        return row_id

    except: 
        mydb.rollback();
        return False

def insert_order_billing(order_id=None) :
    if order_id is None :
        return False

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try : 
        query = "INSERT INTO `order_billings` (`pkey`, `order_id`, `tax_id`, `name`, `telephone`, `email`, `province_id`, `province_name`, `city_id`, `city_name`, `district_id`, `district_name`, `address`, `postcode`, `created_at`, `updated_at`, `deleted_at`) VALUES \
            (28878771674223, %s, NULL, 'Robot Name', NULL, NULL, 1, 'Bangkok', 46, 'City', 163, 'District', 'Test', 10510, NOW(), NOW(), NULL)\
            " % (order_id)

        result = cursor.execute(query)
        row_id = cursor.lastrowid
        mydb.commit()
        return row_id

    except Exception, e: 
        mydb.rollback();
        BuiltIn().log_to_console('DB exception: %s' % e)
        return False


def delete_order(order_id=None) :
    if order_id is None :
        return False

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    try : 
        query = "DELETE FROM orders \
                WHERE id = '%s' \
                " % order_id

        cursor = mydb.cursor()
        result = cursor.execute(query)
        mydb.commit()
        return True

    except : 
        mydb.rollback()
        return False


def get_order_by_created_at(created_at=None) : 

    if created_at is None : 
        return None 
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    try : 
        query = "SELECT * FROM `orders` \
            WHERE `created_at` = %s " % created_at 
        BuiltIn().log_to_console(query)
        cursor = mydb.cursor()
        result = cursor.execute(query)
        row = cursor.fetchone()
        #return True
        return row 

    except : 
        mydb.rollback()
        return False

def delete_order_with_condition(condition = None, mode = 'created_at') : 
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    try : 
        query = "DELETE FROM `orders` "
        if mode == 'created_at' : 
            query = query + " WHERE `created_at` = %s " % condition
        elif mode == 'id' : 
            query = query + " WHERE `id` = '%s' " % condition
                
        cursor = mydb.cursor()
        result = cursor.execute(query)
        mydb.commit()
        return True

    except Exception, e: 
        mydb.rollback();
        BuiltIn().log_to_console('DB exception: %s' % e)
        return False
        


def delete_order_shipment(order_id=None) :
    if order_id is None :
        return False

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    try : 
        query = "DELETE FROM order_shipments \
                WHERE order_id = '%s' \
                " % order_id

        cursor = mydb.cursor()
        result = cursor.execute(query)
        mydb.commit()
        return True

    except : 
        mydb.rollback()
        return False


def delete_order_shipment_item(order_id=None) :
    if order_id is None :
        return False

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    try : 
        query = "DELETE FROM order_shipment_items \
                WHERE order_id = '%s' \
                " % order_id

        cursor = mydb.cursor()
        result = cursor.execute(query)
        mydb.commit()
        return True

    except : 
        mydb.rollback()
        return False

def delete_order_billing(order_id=None) :
    if order_id is None :
        return False

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    try : 
        query = "DELETE FROM order_billings \
                WHERE id = '%s' \
                " % order_id

        cursor = mydb.cursor()
        result = cursor.execute(query)
        mydb.commit()
        return True

    except : 
        mydb.rollback()
        return False

