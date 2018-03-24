import MySQLdb as db

from ConnectDB import *
import socket
import urllib
import urllib2
import xlrd
import csv
import product

def get_environment() :
    hostname = socket.gethostname()

    if hostname == "ip-10-229-14-20.itruemart-dev.com" :
        env = "alpha"
    elif hostname == "ip-10-229-0-92.itruemart-dev.com" :
        env = "staging"
    else :
        env = "staging40k"
    return env

def get_data_in_position(data, number):
    return data[int(number)]

def get_db():
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    return mydb

def check_allow_cod_by_inventory_id(inv_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT products.allow_cod \
    FROM variants \
    , products \
    WHERE `products`.`id` = `variants`.`product_id` \
    AND variants.inventory_id = '%s' \
    " % inv_id

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows[0]
    except:
        print "Cannot fetch data."
    mydb.close()

def get_message_data(order_id):
   mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

   query = "SELECT send_to, channel, status, action_name\
   FROM  messages\
   WHERE messagable_id = '%s' \
   "% order_id
   cursor = mydb.cursor()
   try:
      cursor.execute(query)
      rows = cursor.fetchall()
      return rows
   except:
      print "Cannot fetch data."
   mydb.close()

def get_user_id_by_email(email):
   mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

   query = "SELECT id\
   FROM  users\
   WHERE email = '%s' \
   "% email

   cursor = mydb.cursor()
   try:
      cursor.execute(query)
      rows = cursor.fetchone()
      return rows
   except:
      print "Cannot fetch data."
   mydb.close()

def get_1order_data(order_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT customer_email, customer_tel\
    FROM  orders\
    WHERE id = '%s' \
    "% order_id
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows
    except:
        print "Cannot fetch data."
    mydb.close()

def get_customer_ref_id_data(order_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT customer_ref_id \
    FROM  orders \
    WHERE id = '%s' \
    "% order_id
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows
    except:
        print "Cannot fetch data."
    mydb.close()

def get_point_reference_id_data(order_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT point_reference_id \
    FROM  orders \
    WHERE id = '%s' \
    "% order_id
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows
    except:
        print "Cannot fetch data."
    mydb.close()

def get_shipping_fee_in_order(order_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT total_shipping_fee \
    FROM  orders \
    WHERE id = '%s' \
    "% order_id
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows
    except:
        print "Cannot fetch data."
    mydb.close()

def get_order_shipment_payment_status(item_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT payment_status \
    FROM order_shipment_items \
    WHERE `id` = '%s' \
    " % item_id

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        return rows[0]
    except:
        print "Cannot fetch data."
    mydb.close()

def get_order_shipment_item_status(item_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT item_status \
    FROM order_shipment_items \
    WHERE `id` = '%s' \
    " % item_id

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        return rows[0]
    except:
        print "Cannot fetch data."
    mydb.close()

def get_order_shipment_item_merchant_type(order_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT id, merchant_type, display_stock_type\
    FROM order_shipment_items \
    WHERE `order_id` = '%s' \
    " % order_id

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        return rows;

    except:
        print "Cannot fetch data."
    mydb.close()

def get_status_in_stock_hold_table(item_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT status \
    FROM stock_holds \
    WHERE `order_shipment_item_id` = '%s' \
    "% item_id

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        return rows[0][0];

    except:
        print "Cannot fetch data."
    mydb.close()

def get_together_order_items_merchant_type(pcms_order_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT pcms_item_id, merchant_type, inventory_id, display_stock_type \
    FROM together_order_items \
    WHERE `pcms_order_id` = '%s' \
    " % pcms_order_id

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        return rows;

    except:
        print "Cannot fetch data."
    mydb.close()

def get_order_ref_by_id(id):

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = "SELECT order_ref \
    FROM orders \
    WHERE `id` = '%s' \
    " % id
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        return unicode(rows[0][0]).encode('utf-8')
    except:
        print "Cannot fetch data."
    mydb.close()

def get_order_shipment_operation_status(item_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT operation_status \
    FROM order_shipment_items \
    WHERE `id` = '%s' \
    " % item_id

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        return rows[0]
    except:
        print "Cannot fetch data."
    mydb.close()

def set_expired_date(order_id,expired_date):
   mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

   query = "UPDATE orders  \
   SET  expired_at = '%s' \
   WHERE `order_id` = '%s' \
   " % (expired_date, order_id)

   cursor = mydb.cursor()
   try:
        cursor.execute(query)
        mydb.commit()
   except:
        mydb.rollback()
        print "update expired date fail"
   mydb.close()

def get_operation_status_latest_update(item_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT transaction_operation_item_statuses.*, users.display_name \
    FROM transaction_operation_item_statuses \
    LEFT JOIN users ON (users.id = transaction_operation_item_statuses.user_id) \
    WHERE transaction_operation_item_statuses.order_shipment_item_id = '%s' \
    ORDER BY transaction_operation_item_statuses.created_at DESC \
    " % item_id

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows
    except:
        print "Cannot fetch data."
    mydb.close()

def get_order_shipment_bank_ref(item_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT bank_ref_tmn \
    FROM order_shipment_items \
    WHERE `id` = '%s' \
    " % item_id

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        return rows[0]
    except:
        print "Cannot fetch data."
    mydb.close()

def get_order_shipment_cancel_reason(item_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT cancel_reason_id \
    FROM order_shipment_items \
    WHERE `id` = '%s' \
    " % item_id

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows
    except:
        print "Cannot fetch data."
    mydb.close()

def get_log_bank_ref(item_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT user_id, bank_ref_tmn \
    FROM  transaction_bank_ref_tmn \
    WHERE `order_shipment_item_id` = '%s' \
    ORDER BY `id` DESC \
    LIMIT 1 \
    " % item_id

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        return rows[0]
    except:
        print "Cannot fetch data."
    mydb.close()

def get_SLA(item_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT operation_request_start_time \
    FROM order_shipment_items \
    WHERE `id` = '%s' \
    " % item_id

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        return rows[0]
    except:
        print "Cannot fetch data."
    mydb.close()

def set_SLA(item_id,sla_date):
   mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

   query = "UPDATE order_shipment_items  \
   SET  operation_request_start_time = '%s' \
   WHERE `id` = '%s' \
   " % (sla_date, item_id)

   cursor = mydb.cursor()
   try:
        cursor.execute(query)
        mydb.commit()
   except:
        mydb.rollback()
        print "update sla fail"
   mydb.close()

def get_order_shipment_ids(order_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT `id` \
    FROM order_shipment_items \
    WHERE `order_id` = '%s' \
    " % order_id

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        return rows
    except:
        print "Cannot fetch data."
    mydb.close()

def get_clt_document_path(order_id, doc_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT document_path, user_id \
    FROM order_document_upload \
    WHERE `order_id` = '%s' \
    AND document_type_id = '%s' \
    " % (order_id, doc_id)

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        print rows
        return rows
    except:
        print "Cannot fetch data."
    mydb.close()

def check_has_stock_by_inventory_id(inv_id) :
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    remaining = 0
    query = "SELECT s.quantity - s.sold \
    FROM (SELECT stock_sums.sku_id, stock_sums.quantity, COUNT(stock_holds.order_id) sold \
        FROM stock_sums LEFT JOIN stock_holds \
        ON stock_sums.sku_id = stock_holds.sku_id \
        WHERE stock_holds.`status` != 'cancle' \
        GROUP BY stock_sums.sku_id) s \
    , variants \
    WHERE variants.inventory_id = s.sku_id \
    AND variants.inventory_id = '%s' \
    AND s.quantity > s.sold \
    " % inv_id

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        # if rows is not null:
        #   remaining = rows[0]
        return rows
    except:
        print "Cannot fetch data."

    mydb.close()

def get_sla_time(sid):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT order_shipment_items.operation_request_start_time \
    FROM order_shipment_items \
    WHERE order_shipment_items.id = '%s' \
    " % sid

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows[0]
    except:
        print "Cannot fetch data."
    mydb.close()

def get_stock_type(sid):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT order_shipment_items.display_stock_type \
    FROM order_shipment_items \
    WHERE order_shipment_items.id = '%s' \
    " % sid

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        return rows
    except:
        print "Cannot fetch data."
    mydb.close()

def get_latest_doc_remark(order_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT * \
    FROM order_document_remarks \
    WHERE order_id = '%s' \
    ORDER BY id DESC \
    LIMIT 1 \
    " % order_id

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows
    except:
        print "Cannot fetch data."
    mydb.close()

# def get_1inventory_id():
#   mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

#   query = "SELECT variants.inventory_id \
#   FROM variants \
#   , products \
#   , imported_materials \
#   , (SELECT product_style_type.product_id, sum(product_style_type.style_type_id) number \
#   FROM product_style_type \
#   GROUP BY product_style_type.product_id) style \
#   WHERE `products`.`id` = `variants`.`product_id` \
#   AND variants.deleted_at is null \
#   AND variants.status = 'active' \
#   AND variants.stock_type = 1 \
#   AND products.status = 'publish' \
#   AND products.active = 1 \
#   AND products.has_variants = 1 \
#   AND products.deleted_at is null \
#   AND style.product_id = products.id \
#   AND style.number = 1 \
#   AND variants.inventory_id = imported_materials.inventory_id \
#   ORDER BY products.id, variants.id desc \
#   "

#   cursor = mydb.cursor()
#   try:
#       cursor.execute(query)
#       rows = cursor.fetchone()
#       return rows[0]
#   except:
#       print "Cannot fetch data."
#   mydb.close()

def get_1inventory_id_for_installment():
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT variants.inventory_id \
    FROM variants \
    , products \
    , imported_materials \
    , (SELECT product_style_type.product_id, sum(product_style_type.style_type_id) number \
    FROM product_style_type \
    GROUP BY product_style_type.product_id) style \
    WHERE `products`.`id` = `variants`.`product_id` \
    AND variants.deleted_at is null \
    AND variants.status = 'active' \
    AND variants.price > 5000 \
    AND variants.stock_type = 1 \
    AND products.status = 'publish' \
    AND products.active = 1 \
    AND products.has_variants = 1 \
    AND products.deleted_at is null \
    AND style.product_id = products.id \
    AND style.number = 1 \
    AND variants.inventory_id = imported_materials.inventory_id \
    ORDER BY products.id, variants.id desc \
    "

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows[0]
    except:
        print "Cannot fetch data."
    mydb.close()

def get_2inventory_ids_same_product_diff_variant():
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT variants.inventory_id \
    FROM products \
    JOIN    (SELECT variants.product_id, count(variants.inventory_id) number \
    FROM variants JOIN products \
    ON products.id = variants.product_id \
    WHERE variants.deleted_at is null \
    AND variants.status = 'active' \
    AND variants.stock_type = 1 \
    AND products.status = 'publish' \
    AND products.active = 1 \
    AND products.deleted_at is null \
    AND products.has_variants = 1 \
    GROUP BY products.id) child \
    ON child.product_id = products.id \
    JOIN variants \
    ON products.id = variants.product_id \
    JOIN imported_materials \
    ON variants.inventory_id = imported_materials.inventory_id \
    JOIN (SELECT product_style_type.product_id, sum(product_style_type.style_type_id) number \
    FROM product_style_type \
    GROUP BY product_style_type.product_id) style \
    ON style.product_id = products.id \
    WHERE style.number = 1 \
    AND child.number > 1 \
    AND variants.deleted_at is null \
    AND variants.status = 'active' \
    ORDER BY products.id desc\
    "

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        data = [rows[0][0], rows[1][0]]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def get_3inventory_ids_same_product_diff_variant():
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT variants.inventory_id \
    FROM products \
    JOIN    (SELECT variants.product_id, count(variants.inventory_id) number \
    FROM variants JOIN products \
    ON products.id = variants.product_id \
    WHERE variants.deleted_at is null \
    AND variants.status = 'active' \
    AND variants.stock_type = 1 \
    AND products.status = 'publish' \
    AND products.active = 1 \
    AND products.deleted_at is null \
    AND products.has_variants = 1 \
    GROUP BY products.id) child \
    ON child.product_id = products.id \
    JOIN variants \
    ON products.id = variants.product_id \
    JOIN imported_materials \
    ON variants.inventory_id = imported_materials.inventory_id \
    JOIN (SELECT product_style_type.product_id, sum(product_style_type.style_type_id) number \
    FROM product_style_type \
    GROUP BY product_style_type.product_id) style \
    ON style.product_id = products.id \
    WHERE style.number = 1 \
    AND child.number > 2 \
    AND variants.deleted_at is null \
    AND variants.status = 'active' \
    ORDER BY products.id desc\
    "

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        data = [rows[0][0], rows[1][0], rows[2][0]]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def  get_2inventory_ids_same_brand_diff_product():
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
    ORDER BY products.brand_id \
    "

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()

        i = 0
        brand_id = None
        product_id = None

        for row in rows:
            if row[0] == brand_id :
                if row[1] != product_id :
                    break
            brand_id = row[0]
            product_id = row[1]
            i = i+1

        data = [rows[i-1][2], rows[i][2]]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()



# def  get_2inventory_ids_same_collection_diff_product():
#     mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

#     query = "SELECT product_collections.collection_id, products.id, variants.inventory_id \
#     FROM variants JOIN products \
#     ON products.id = variants.product_id \
#     JOIN product_collections \
#     ON product_collections.product_id = products.id \
#     JOIN collections \
#     ON collections.id = product_collections.collection_id \
#     JOIN apps_collections \
#     ON apps_collections.collection_id = collections.id \
#     JOIN (SELECT product_style_type.product_id, sum(product_style_type.style_type_id) number \
#         FROM product_style_type \
#         GROUP BY product_style_type.product_id) style \
#     ON style.product_id = products.id \
#     JOIN imported_materials \
#     ON variants.inventory_id = imported_materials.inventory_id \
#     WHERE style.number = 1 \
#     AND collections.deleted_at is null \
#     AND collections.parent_id = 0 \
#     AND variants.deleted_at is null \
#     AND variants.status = 'active' \
#     AND variants.stock_type = 1 \
#     AND products.has_variants = 1 \
#     AND products.status = 'publish' \
#     AND products.active = 1 \
#     AND products.deleted_at is null \
#     AND apps_collections.app_id = 1 \
#     ORDER BY product_collections.collection_id \
#     "

#     cursor = mydb.cursor()
#     try:
#         cursor.execute(query)
#         rows = cursor.fetchall()

#         i = 0
#         collection_id = None
#         product_id = None

#         for row in rows:
#             if row[0] == collection_id :
#                 if row[1] != product_id :
#                     break
#             collection_id = row[0]
#             product_id = row[1]
#             i = i+1

#         data = [rows[i-1][2], rows[i][2]]
#         return data
#     except:
#         print "Cannot fetch data."
#     mydb.close()

# def  get_3inventory_ids_same_collection_diff_product():
#     mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

#     query = "SELECT product_collections.collection_id, products.id, variants.inventory_id \
#     FROM variants JOIN products \
#     ON products.id = variants.product_id \
#     JOIN product_collections \
#     ON product_collections.product_id = products.id \
#     JOIN collections \
#     ON collections.id = product_collections.collection_id \
#     JOIN apps_collections \
#     ON apps_collections.collection_id = collections.id \
#     JOIN (SELECT product_style_type.product_id, sum(product_style_type.style_type_id) number \
#         FROM product_style_type \
#         GROUP BY product_style_type.product_id) style \
#     ON style.product_id = products.id \
#     JOIN imported_materials \
#     ON variants.inventory_id = imported_materials.inventory_id \
#     WHERE style.number = 1 \
#     AND collections.deleted_at is null \
#     AND collections.parent_id = 0 \
#     AND variants.deleted_at is null \
#     AND variants.status = 'active' \
#     AND variants.stock_type = 1 \
#     AND products.has_variants = 1 \
#     AND products.status = 'publish' \
#     AND products.active = 1 \
#     AND products.deleted_at is null \
#     AND apps_collections.app_id = 1 \
#     ORDER BY product_collections.collection_id \
#     "

#     cursor = mydb.cursor()
#     try:
#         cursor.execute(query)
#         rows = cursor.fetchall()

#         i = 0
#         collection_id = None
#         product_id = None

#         exist_products = []
#         invent = []
#         for row in rows:
#             if row[0] == collection_id :
#                 #if row[1] != product_id :
#                 if (row[1] not in exist_products) :
#                     invent.append(row[2])
#                 exist_products.append(row[1])
#             collection_id = row[0]
#             #product_id = row[1]

#             i = i+1


#         data = [invent[0], invent[1], invent[2]]
#         return data
#     except:
#         print "Cannot fetch data."
#     mydb.close()

# def  get_2inventory_ids_diff_collection():
#     mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

#     query = "SELECT product_collections.collection_id, products.id, variants.inventory_id \
#     FROM variants JOIN products \
#     ON products.id = variants.product_id \
#     JOIN product_collections \
#     ON product_collections.product_id = products.id \
#     JOIN collections \
#     ON collections.id = product_collections.collection_id \
#     JOIN apps_collections \
#     ON apps_collections.collection_id = collections.id \
#     JOIN (SELECT product_style_type.product_id, sum(product_style_type.style_type_id) number \
#         FROM product_style_type \
#         GROUP BY product_style_type.product_id) style \
#     ON style.product_id = products.id \
#     JOIN imported_materials \
#     ON variants.inventory_id = imported_materials.inventory_id \
#     WHERE style.number = 1 \
#     AND collections.deleted_at is null \
#     AND collections.parent_id = 0 \
#     AND variants.deleted_at is null \
#     AND variants.status = 'active' \
#     AND variants.stock_type = 1 \
#     AND products.has_variants = 1 \
#     AND products.status = 'publish' \
#     AND products.active = 1 \
#     AND products.deleted_at is null \
#     AND apps_collections.app_id = 1 \
#     ORDER BY product_collections.collection_id \
#     "

#     cursor = mydb.cursor()
#     try:
#         cursor.execute(query)
#         rows = cursor.fetchall()

#         i = 0
#         j = 0
#         collection_id = None
#         product_id = None
#         found = 0

#         for row in rows:
#             collection_id = row[0]
#             product_id = row[1]

#             for j in xrange(i+1, len(rows)-1):
#                 if rows[j][0] != collection_id :
#                     if rows[j][1] != product_id :
#                         found = 1
#                         break
#             if found == 1 :
#                 break
#             i = i+1

#         data = [rows[i][2], rows[j][2]]
#         return data
#     except:
#         print "Cannot fetch data."
#     mydb.close()

# def get_1product_pkey_not_verify_pending():
#     mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

#     query = "SELECT products.pkey \
#             FROM variants \
#             JOIN products \
#             ON `products`.`id` = `variants`.`product_id` \
#             JOIN product_collections \
#             ON product_collections.product_id = products.id \
#             JOIN collections \
#             ON collections.id = product_collections.collection_id \
#             JOIN apps_collections \
#             ON apps_collections.collection_id = collections.id \
#             JOIN brands \
#             ON brands.id = products.brand_id \
#             WHERE variants.deleted_at is null \
#             AND variants.status = 'active' \
#             AND variants.stock_type = 1 \
#             AND products.status = 'publish' \
#             AND products.active = 1 \
#             AND products.has_variants = 1 \
#             AND products.deleted_at is null \
#             AND collections.deleted_at is null \
#             AND collections.parent_id = 0 \
#             AND brands.deleted_at is null \
#             AND products.pkey not in (SELECT pkey FROM product_verify_pendings) \
#             ORDER BY products.id desc "

#     cursor = mydb.cursor()
#     try:
#         cursor.execute(query)
#         rows = cursor.fetchone()
#         return rows[0]
#     except:
#         print "Cannot fetch data."
#     mydb.close()

def get_1order_shipment_item_data(order_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT id, inventory_id, item_status , tracking_number, third_pl_id \
    FROM order_shipment_items \
    WHERE order_id = '%s' \
    "% order_id
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows
    except:
        print "Cannot fetch data."
    mydb.close()

def get_point_data_from_order_shipment_item(order_item_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT id, redeem_point, redeem_point_to_money , redeem_point_to_money_original, redeem_partner \
    FROM order_shipment_items \
    WHERE id = '%s' \
    "% order_item_id
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows
    except:
        print "Cannot fetch data."
    mydb.close()

def get_log_api_send_item_status(sid):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT request_data, status_code, order_id, item_id, item_status \
    FROM log_api_send_item_status \
    WHERE item_id = '%s' \
    ORDER BY log_api_send_item_status.id DESC LIMIT 1 \
    "% sid
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        return rows
    except:
        print "Cannot fetch data."
    mydb.close()

def get_log_order_shipment_item(sid):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT order_shipment_item_id, item_status, user_id \
    FROM transaction_order_item_statuses \
    WHERE order_shipment_item_id = '%s' \
    ORDER BY transaction_order_item_statuses.id DESC LIMIT 1 \
    "% sid
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        return rows
    except:
        print "Cannot fetch data."
    mydb.close()

def get_all_log_order_shipment_item(sid):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT order_shipment_item_id, item_status, user_id \
    FROM transaction_order_item_statuses \
    WHERE order_shipment_item_id = '%s' \
    ORDER BY transaction_order_item_statuses.id DESC \
    "% sid
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        return rows
    except:
        print "Cannot fetch data."
    mydb.close()

def get_log_operation_status(sid):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT order_shipment_item_id, operation_status, user_id \
    FROM transaction_operation_item_statuses \
    WHERE order_shipment_item_id = '%s' \
    ORDER BY transaction_operation_item_statuses.id DESC LIMIT 1 \
    "% sid
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        return rows
    except:
        print "Cannot fetch data."
    mydb.close()

def get_order_shipment_item_data(order_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT id, inventory_id, item_status , tracking_number, third_pl_id, serial_number \
    FROM order_shipment_items \
    WHERE order_id = '%s' \
    "% order_id
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        return rows
    except:
        print "Cannot fetch data."
    mydb.close()

def get_variant_pkey(inv_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT variants.pkey \
    FROM variants \
    WHERE variants.inventory_id = '%s' \
    " % inv_id

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows[0]
    except:
        print "Cannot fetch data."
    mydb.close()

# def get_product_name(inv_id):
#   mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

#   query = "SELECT products.title \
#   FROM variants \
#   , products \
#   WHERE `products`.`id` = `variants`.`product_id` \
#   AND variants.inventory_id = '%s' \
#   " % inv_id

#   cursor = mydb.cursor()
#   try:
#       cursor.execute(query)
#       rows = cursor.fetchone()
#       return rows[0]
#   except:
#       print "Cannot fetch data."
#   mydb.close()

# def get_product_id(inv_id):
#   mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

#   query = "SELECT products.id \
#   FROM variants \
#   , products \
#   WHERE `products`.`id` = `variants`.`product_id` \
#   AND variants.inventory_id = '%s' \
#   " % inv_id

#   cursor = mydb.cursor()
#   try:
#       cursor.execute(query)
#       rows = cursor.fetchone()
#       return rows[0]
#   except:
#       print "Cannot fetch data."
#   mydb.close()



# def get_product_pkey(inv_id):
#   mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

#   query = "SELECT products.pkey \
#   FROM variants \
#   , products \
#   WHERE `products`.`id` = `variants`.`product_id` \
#   AND variants.inventory_id = '%s' \
#   ORDER BY products.id, variants.id \
#   " % inv_id

#   cursor = mydb.cursor()
#   try:
#       cursor.execute(query)
#       rows = cursor.fetchone()
#       return rows[0]
#   except:
#       print "Cannot fetch data."
#   mydb.close()



def get_inventory_pkey(inv_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT products.pkey \
    FROM variants \
    , products \
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

def get_brand_name(inv_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT brands.name \
    FROM brands, products, variants \
    WHERE products.brand_id = brands.id \
    AND brands.deleted_at is null \
    AND products.id = variants.product_id \
    AND variants.inventory_id = '%s' \
    ORDER BY brands.id \
    " % inv_id

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows[0]
    except:
        print "Cannot fetch data."
    mydb.close()

def get_collection_id(inv_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT collections.id \
    FROM product_collections, products, variants, apps_collections, collections \
    WHERE apps_collections.collection_id = collections.id \
    AND apps_collections.app_id = 1 \
    AND collections.id = product_collections.collection_id \
    AND collections.deleted_at is null \
    AND collections.parent_id = 0 \
    AND products.id = product_collections.product_id \
    AND products.id = variants.product_id \
    AND variants.inventory_id = '%s' \
    ORDER BY product_collections.collection_id \
    " % inv_id

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows[0]
    except:
        print "Cannot fetch data."
    mydb.close()

def get_collection_name(inv_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT collections.id,collections.name \
    FROM product_collections, products, variants, apps_collections, collections \
    WHERE apps_collections.collection_id = collections.id \
    AND apps_collections.app_id = 1 \
    AND collections.id = product_collections.collection_id \
    AND collections.deleted_at is null \
    AND collections.parent_id = 0 \
    AND products.id = product_collections.product_id \
    AND products.id = variants.product_id \
    AND variants.inventory_id = '%s' \
    ORDER BY product_collections.collection_id \
    " % inv_id

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows[1]
    except:
        print "Cannot fetch data."
    mydb.close()

def get_other_collection_id(inv_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT collections.id \
    FROM product_collections, products, variants, apps_collections, collections \
    WHERE apps_collections.collection_id = collections.id \
    AND apps_collections.app_id = 1 \
    AND collections.id = product_collections.collection_id \
    AND collections.deleted_at is null \
    AND products.id = product_collections.product_id \
    AND products.id = variants.product_id \
    AND variants.inventory_id = '%s' \
    ORDER BY product_collections.collection_id \
    " % inv_id

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()

        collectionList = []
        for x in rows :
            collectionList.append(x[0])

        collectionStr = ', '.join(str(x) for x in collectionList)
        query = "SELECT collections.id \
        FROM apps_collections, collections \
        WHERE apps_collections.collection_id = collections.id \
        AND apps_collections.app_id = 1 \
        AND collections.deleted_at is null \
        AND collections.id not in (%s) \
        " % collectionStr
        print query

        cursor = mydb.cursor()
        try:
            cursor.execute(query)
            collection_rows = cursor.fetchone()

            print collection_rows
        except:
            print "Cannot fetch data."

    except:
        print "Cannot fetch data."
    mydb.close()

def get_style_options_pkey(inv_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT style_options.pkey \
    FROM variants \
    , variant_style_options \
    , style_options \
    WHERE variants.id = variant_style_options.variant_id \
    AND variant_style_options.style_option_id = style_options.id \
    AND variants.inventory_id = '%s' \
    " % inv_id

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows[0]
    except:
        print "Cannot fetch data."
    mydb.close()

def remove_campaign(campaign_name, remove_campaign=None):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    try:
        query_promotion_code_log = "DELETE FROM promotion_code_logs \
        WHERE promotion_code_logs.promotion_code_id IN (SELECT promotion_codes.id \
            FROM campaigns, promotions, promotion_codes \
            WHERE campaigns.name = '%s' \
            AND campaigns.id = promotions.campaign_id \
            AND promotions.id = promotion_codes.promotion_id) \
        " % campaign_name
        cursor = mydb.cursor()
        result = cursor.execute(query_promotion_code_log)
        mydb.commit()
        try:
            query_promotion_code = "DELETE FROM promotion_codes \
            WHERE promotion_codes.promotion_id IN (SELECT promotions.id \
                FROM campaigns, promotions \
                WHERE campaigns.name = '%s' \
                AND campaigns.id = promotions.campaign_id) \
            " % campaign_name
            cursor = mydb.cursor()
            result = cursor.execute(query_promotion_code)
            mydb.commit()
            try:
                query_promotion = "DELETE FROM promotions \
                WHERE promotions.campaign_id IN (SELECT campaigns.id \
                    FROM campaigns \
                    WHERE campaigns.name = '%s') \
                " % campaign_name
                cursor = mydb.cursor()
                result = cursor.execute(query_promotion)
                mydb.commit()

                if (remove_campaign is not None) : 
                    try:
                        query_campaign_id = "DELETE FROM campaigns WHERE campaigns.name = '%s' " % campaign_name
                        cursor = mydb.cursor()
                        result = cursor.execute(query_campaign_id)
                        mydb.commit()
                    except:
                        mydb.rollback()
                        print 'Cannot delete campaign'
            except:
                mydb.rollback()
                print 'Cannot delete promotions'
        except:
            mydb.rollback()
            print 'Cannot delete promotion codes'
    except:
        mydb.rollback()
        print 'Cannot delete promotion code logs'
    mydb.close()

# def remove_promotion(promotion_name):
#     mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

#     try:
#         query_promotion_code_log = "DELETE FROM promotion_code_logs \
#         WHERE promotion_code_logs.promotion_code_id IN (SELECT promotion_codes.id \
#             FROM campaigns, promotions, promotion_codes \
#             WHERE promotions.name = '%s' \
#             AND campaigns.id = promotions.campaign_id \
#             AND promotions.id = promotion_codes.promotion_id) \
#         " % promotion_name
#         cursor = mydb.cursor()
#         result = cursor.execute(query_promotion_code_log)
#         mydb.commit()
#         try:
#             query_promotion_code = "DELETE FROM promotion_codes \
#             WHERE promotion_codes.promotion_id IN (SELECT promotions.id \
#                 FROM campaigns, promotions \
#                 WHERE promotions.name = '%s' \
#                 AND campaigns.id = promotions.campaign_id) \
#             " % promotion_name
#             cursor = mydb.cursor()
#             result = cursor.execute(query_promotion_code)
#             mydb.commit()
#             try:
#                 query_promotion = "DELETE FROM promotions \
#                 WHERE promotions.name = '%s' \
#                 " % promotion_name
#                 cursor = mydb.cursor()
#                 result = cursor.execute(query_promotion)
#                 mydb.commit()

#             except:
#                 mydb.rollback()
#                 print 'Cannot delete promotions'
#         except:
#             mydb.rollback()
#             print 'Cannot delete promotion codes'
#     except:
#         mydb.rollback()
#         print 'Cannot delete promotion code logs'
#     mydb.close()

def get_type(data): 
    return type(data)

def clear_cart(customer_ref_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query_cart = "SELECT id FROM carts WHERE customer_ref_id = '%s' and deleted_at is null " % customer_ref_id
    cursor = mydb.cursor()
    try:
        cursor.execute(query_cart)
        rows = cursor.fetchall()

        for row in rows:
            try :
                # Delete carts
                query_delete_cart = "UPDATE carts SET deleted_at = NOW() where id = '%s' " % row[0]
                cursor = mydb.cursor()
                cursor.execute(query_delete_cart)
                mydb.commit()
                try :
                    query_delete_cart_detail = "UPDATE cart_details SET deleted_at = NOW() where cart_id = '%s' " % row[0]
                    cursor = mydb.cursor()
                    cursor.execute(query_delete_cart_detail)
                    mydb.commit()
                    return True
                except:
                    mydb.rollback()
                    print 'Cannot delete cart detail'
            except:
                mydb.rollback()
                print 'cannot delete cart'
    except:
        mydb.rollback()
        print 'Cannot clear cart'

    mydb.close()

def py_get_cart_detail(user_id) :
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = "SELECT customer_province_id, customer_city_id, customer_district_id FROM carts \
        WHERE customer_ref_id = '%s' " % user_id
    print query
    cursor = mydb.cursor()
    try :
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows
    except :
        return False
    mydb.close()

def py_get_cart_detail_point(user_id) :
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = "SELECT point, point_discount_money, point_partner FROM carts \
        WHERE customer_ref_id = '%s' ORDER BY updated_at DESC LIMIT 1" % user_id 
    print query
    cursor = mydb.cursor()
    try :
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows
    except :
        return False
    mydb.close()

def remove_collection_data_test():

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    try:
        cursor = mydb.cursor()
        cursor.execute("DELETE FROM collections WHERE category_id = 'AETEST0000001'")
        mydb.commit()
        cursor.execute("DELETE FROM collections WHERE category_id = 'AETEST0000002'")
        mydb.commit()
        cursor.execute("DELETE FROM collections WHERE category_id = 'AETEST0000003'")
        mydb.commit()
        cursor.execute("DELETE FROM collections WHERE category_id = 'AETEST0000004'")
        mydb.commit()
    except:
        mydb.rollback()
        print "insert collections fail"

    mydb.close()



def insert_collection_test():
    # dbhost = '10.229.3.248'
    # dbuser = 'pcms_qa'
    # dbpass = 'read1234'
    # dbname = 'pcms_db_prod'
    # dbcharset = 'utf8'

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    insert1 = "INSERT INTO collections (parent_id,pkey,attachment_id,name,slug,is_category,collection_type,category_id,created_at,updated_at,deleted_at,pds_collection) \
VALUES \
    (0, 1234567890123, NULL, 'TEST 1', 'slug 1', '0', 'default', 'AETEST0000001', '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, '0')"

    insert2 = "INSERT INTO collections (parent_id,pkey,attachment_id,name,slug,is_category,collection_type,category_id,created_at,updated_at,deleted_at,pds_collection) \
VALUES \
    (0, 1234567890124, NULL, 'TEST 2', 'slug 2', '0', 'default', 'AETEST0000002', '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, '0')"

    try:
        cursor = mydb.cursor()
        cursor.execute("DELETE FROM collections WHERE category_id = 'AETEST0000001'")
        mydb.commit()
        cursor.execute("DELETE FROM collections WHERE category_id = 'AETEST0000002'")
        mydb.commit()
        cursor.execute("DELETE FROM collections WHERE category_id = 'AETEST0000003'")
        mydb.commit()
        cursor.execute("DELETE FROM collections WHERE category_id = 'AETEST0000004'")
        mydb.commit()

        try:
            result = cursor.execute(insert1)
            mydb.commit()

            result = cursor.execute(insert2)
            mydb.commit()
        except:
            mydb.rollback()
            print "insert collections fail"
    except:
        mydb.rollback()
        print "Cannot DELETE data."

    try:
        cursor.execute("SELECT * FROM collections WHERE category_id = 'AETEST0000001'")
        rows = cursor.fetchall()
        parent1 = rows[0][0]
        cursor.execute("SELECT * FROM collections WHERE category_id = 'AETEST0000002'")
        rows = cursor.fetchall()
        parent2 = rows[0][0]
    except:
        print "Select fail"

    try:
        insert3 = "INSERT INTO collections (parent_id,pkey,attachment_id,name,slug,is_category,collection_type,category_id,created_at,updated_at,deleted_at,pds_collection) \
VALUES \
    (%d, 1234567890125, NULL, 'TEST 3', 'slug 3', '0', 'default', 'AETEST0000003', '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, '0')" % parent1

        cursor.execute(insert3)
        mydb.commit()

        insert4 = "INSERT INTO collections (parent_id,pkey,attachment_id,name,slug,is_category,collection_type,category_id,created_at,updated_at,deleted_at,pds_collection) \
VALUES \
    (%d, 1234567890126, NULL, 'TEST 4', 'slug 4', '0', 'default', 'AETEST0000004', '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, '0')" % parent2

        cursor.execute(insert4)
        mydb.commit()

    except:
        print "error"

    mydb.close()

def insert_collection_multi():
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    insert1 = "INSERT INTO collections (parent_id,pkey,attachment_id,name,slug,is_category,collection_type,category_id,created_at,updated_at,deleted_at,pds_collection) \
VALUES \
    (0, 0, NULL, 'AE TEST 10', 'ae slug 10', '0', 'default', 'AETEST0000010', '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, '0')"

    try:
        cursor = mydb.cursor()
        cursor.execute("DELETE FROM collections WHERE category_id = 'AETEST0000010'")
        mydb.commit()
        cursor.execute(insert1)
        mydb.commit()

        cursor.execute("SELECT * FROM collections WHERE category_id = 'AETEST0000010'")
        rows = cursor.fetchall()
        colId = rows[0][0]

        insertTranslation = "INSERT INTO translates (locale, languagable_id,languagable_type,text,title,name,description,key_feature,body,unit_type,caption,advantage) \
VALUES \
    ('en_US', %d, 'Collection', NULL, NULL, 'AETEST', NULL, NULL, NULL, NULL, NULL, NULL)" % colId
        cursor.execute(insertTranslation)
        mydb.commit()


        insertMeta = "INSERT INTO app_metadatas (app_id,attachment_id,type,`key`,value,metadatable_id,metadatable_type,created_at,updated_at) VALUES \
    (1, NULL, 'file', 'banner', 'http://cdn.itruemart.com/files/category/2/2_935x290_1391744693.jpg', %d, 'Collection', '2014-05-16 11:44:21', '2014-05-16 11:44:21');" % colId
        cursor.execute(insertMeta)
        mydb.commit()

    except:
        mydb.rollback()
        print "insert collections fail"

    mydb.close()


def delete_collection_multi():
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    try:
        cursor = mydb.cursor()
        cursor.execute("SELECT * FROM collections WHERE category_id = 'AETEST0000010'")
        rows = cursor.fetchall()
        colId = rows[0][0]

        cursor.execute("DELETE FROM app_metadatas where metadatable_id = %d and metadatable_type='Collection'" % colId)
        mydb.commit()
        cursor.execute("DELETE FROM translates where languagable_id=%d and languagable_type='Collection'" % colId)
        mydb.commit()
        cursor.execute("DELETE FROM collections WHERE category_id = 'AETEST0000010'")
        mydb.commit()

    except:
        mydb.rollback()
        print "delete collections fail"

def check_collection_multi():
    flag = True;

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT * FROM collections WHERE category_id = 'AETEST0000010'"

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        collectionId = rows[0]
        cursor.execute("select * from `translates` where languagable_id = %d and languagable_type='Collection'" % collectionId)
        rows = cursor.fetchone()
        if rows[6]!= 'AETEST':
            flag = False

        cursor.execute("select * from app_metadatas where `metadatable_id` = %d and metadatable_type='Collection'" % collectionId)
        rows = cursor.fetchone()
        if rows[5]!= 'http://cdn.itruemart.com/files/category/2/2_935x290_1391744693.jpg':
            flag = False

    except:
        print "Cannot fetch data."
    mydb.close()
    return flag

def delete_history_massupload_by_user(userId):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    print 'here1'
    query = "DELETE FROM upload_history WHERE username = \'" + userId + "\'"
    print 'here2'
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        mydb.commit()
    except:
        print "Cannot delete data."
        flag = False;
    mydb.close()

def get_upload_history_by_type(upload_type):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT username, filename, result, reason  \
    FROM upload_history \
    WHERE `type` = '%s' \
    ORDER BY created_at desc" % upload_type

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        return rows;

    except:
        print "Cannot fetch data."
    mydb.close()	

def delete_history_massupload_by_user_and_type(userId, filename, upload_type):
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "DELETE FROM upload_history WHERE username = \'" + userId + "\' and type =\'" + upload_type + "\'" + " and filename =\'" + filename + "\'"
	cursor = mydb.cursor()
	try:
		cursor.execute(query)
		mydb.commit()
	except:
		print "Cannot delete data."
		flag = False;
	mydb.close()

def delete_user_by_email(email):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query_user = "SELECT id FROM users WHERE email = '%s' and deleted_at is null " % email
    cursor = mydb.cursor()
    try:
        cursor.execute(query_user)
        rows = cursor.fetchall()

        for row in rows:
            try :
                # Delete user
                query_delete_user = "DELETE FROM users where email = '%s' " % email
                cursor = mydb.cursor()
                cursor.execute(query_delete_user)
                mydb.commit()


                try :
                    query_delete_user_group = "DELETE FROM users_groups where user_id = '%s' " % row[0]
                    cursor = mydb.cursor()
                    cursor.execute(query_delete_user_group)
                    mydb.commit()
                except:
                    mydb.rollback()
                    print 'Cannot delete user group'
            except:
                mydb.rollback()
                print 'cannot delete user'

    except:
        mydb.rollback()
        print 'Cannot remove user'


    mydb.close()

def delete_user_role_by_name(name):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query_user_role = "SELECT id FROM groups WHERE name = '%s' and deleted_at is null " % name
    cursor = mydb.cursor()
    try:
        cursor.execute(query_user_role)
        rows = cursor.fetchall()

        for row in rows:
            try :
                # Delete user role
                query_delete_user_role = "DELETE FROM groups where name = '%s' " % name
                cursor = mydb.cursor()
                cursor.execute(query_delete_user_role)
                mydb.commit()


                try :
                    query_delete_user_group = "DELETE FROM users_groups where group_id = '%s' " % row[0]
                    cursor = mydb.cursor()
                    cursor.execute(query_delete_user_group)
                    mydb.commit()
                except:
                    mydb.rollback()
                    print 'Cannot delete user group'
            except:
                mydb.rollback()
                print 'cannot delete user role'

    except:
        mydb.rollback()
        print 'Cannot remove user role'


    mydb.close()

#data = py_get_cart_detail("90de9d08852d2bf04f7706bfb87b1018c163452f55ad9610dff1ee80f3ddf019")
#print data
# def create_product_installment(product_id, bank_id, period) :
#   mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
#   query = "REPLACE INTO `bank_product` (`product_id`, `bank_id`, `periods`) \
#       VALUES (%s, %s, %s) "
#   cursor = mydb.cursor()
#   try :
#       cursor.execute(query, (product_id, bank_id, period))
#       mydb.commit()
#   except :
#       return "roll back"
#       mydb.rollback()
#   mydb.close()

# def set_installment_promotion(product_id, is_allow) :
#   mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

#   query = "INSERT INTO `product_installment_meta` (`product_id`, `allow_promotion`, `created_at`) \
#       VALUES (%s, %s, NOW()) "

#   cursor = mydb.cursor()
#   try :
#       cursor.execute(query, (product_id, is_allow))
#       mydb.commit()
#   except:
#       mydb.rollback()
#   mydb.close()

# def remove_installment_promotion(product_id) :
#   mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
#   query = "UPDATE `product_installment_meta` SET deleted_at = NOW() \
#       WHERE product_id = %s "
#   cursor = mydb.cursor()
#   try :
#       cursor.execute(query, (prdocut_id))

#row = get_3inventory_ids_same_collection_diff_product()
#print row


def insert_collection_for_product_upload():
    # dbhost = '192.168.99.102'
    # dbuser = 'root'
    # dbpass = 'root'
    # dbname = 'pcms_db'
    # dbcharset = 'utf8'

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    try:
        cursor = mydb.cursor()

        delete_collection_for_product_upload()


        #collection with no child
        insert1 = "INSERT INTO collections (parent_id,pkey,attachment_id,name,slug,is_category,collection_type,category_id,created_at,updated_at,deleted_at,pds_collection) \
    VALUES \
        (0, 9991234567890, NULL, 'Collection for Product Upload 1', 'col-prod-1', '1', 'default', 'CZZ01', '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, '1')"

        cursor.execute(insert1)
        mydb.commit()

        cursor.execute("SELECT * FROM collections WHERE category_id = 'CZZ01'")
        rows = cursor.fetchall()
        colId = rows[0][0]

        insertTranslation = "INSERT INTO translates (locale, languagable_id,languagable_type,text,title,name,description,key_feature,body,unit_type,caption,advantage) \
    VALUES \
        ('en_US', %d, 'Collection', NULL, NULL, 'Collection for Product Upload 1', NULL, NULL, NULL, NULL, NULL, NULL)" % colId
        cursor.execute(insertTranslation)
        mydb.commit()

        insertAppCollection = "INSERT INTO apps_collections (collection_id, app_id, `order`) \
    VALUES (%d, 1, NULL)" % colId
        cursor.execute(insertAppCollection)
        mydb.commit()


        #collection with one child
        insert21 = "INSERT INTO collections (parent_id,pkey,attachment_id,name,slug,is_category,collection_type,category_id,created_at,updated_at,deleted_at,pds_collection) \
    VALUES \
        (0, 9991234567891, NULL, 'Collection for Product Upload 2', 'col-prod-21', '1', 'default', 'CZZ02', '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, '1')"

        cursor.execute(insert21)
        mydb.commit()

        cursor.execute("SELECT * FROM collections WHERE category_id = 'CZZ02'")
        rows = cursor.fetchall()
        colId = rows[0][0]

        insertTranslation = "INSERT INTO translates (locale, languagable_id,languagable_type,text,title,name,description,key_feature,body,unit_type,caption,advantage) \
    VALUES \
        ('en_US', %d, 'Collection', NULL, NULL, 'Collection for Product Upload 2', NULL, NULL, NULL, NULL, NULL, NULL)" % colId
        cursor.execute(insertTranslation)
        mydb.commit()

        insertAppCollection = "INSERT INTO apps_collections (collection_id, app_id, `order`) \
    VALUES (%d, 1, NULL)" % colId
        cursor.execute(insertAppCollection)
        mydb.commit()

        insert22 = "INSERT INTO collections (parent_id,pkey,attachment_id,name,slug,is_category,collection_type,category_id,created_at,updated_at,deleted_at,pds_collection) \
    VALUES \
        (%d, 9991234567892, NULL, 'Collection for Product Upload 2 Sub 1', 'col-prod-22', '1', 'default', 'CZZ0201', '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, '1')" % colId

        cursor.execute(insert22)
        mydb.commit()

        cursor.execute("SELECT * FROM collections WHERE category_id = 'CZZ0201'")
        rows = cursor.fetchall()
        colId = rows[0][0]

        insertTranslation = "INSERT INTO translates (locale, languagable_id,languagable_type,text,title,name,description,key_feature,body,unit_type,caption,advantage) \
    VALUES \
        ('en_US', %d, 'Collection', NULL, NULL, 'Collection for Product Upload 2 Sub 1', NULL, NULL, NULL, NULL, NULL, NULL)" % colId
        cursor.execute(insertTranslation)
        mydb.commit()

        insertAppCollection = "INSERT INTO apps_collections (collection_id, app_id, `order`) \
    VALUES (%d, 1, NULL)" % colId
        cursor.execute(insertAppCollection)
        mydb.commit()


        #collection with one child with another child
        insert31 = "INSERT INTO collections (parent_id,pkey,attachment_id,name,slug,is_category,collection_type,category_id,created_at,updated_at,deleted_at,pds_collection) \
    VALUES \
        (0, 9991234567893, NULL, 'Collection for Product Upload 3-1', 'col-prod-31', '1', 'default', 'CZZ03', '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, '1')"

        cursor.execute(insert31)
        mydb.commit()

        cursor.execute("SELECT * FROM collections WHERE category_id = 'CZZ03'")
        rows = cursor.fetchall()
        colId = rows[0][0]

        insertTranslation = "INSERT INTO translates (locale, languagable_id,languagable_type,text,title,name,description,key_feature,body,unit_type,caption,advantage) \
    VALUES \
        ('en_US', %d, 'Collection', NULL, NULL, 'Collection for Product Upload 3-1', NULL, NULL, NULL, NULL, NULL, NULL)" % colId
        cursor.execute(insertTranslation)
        mydb.commit()

        insertAppCollection = "INSERT INTO apps_collections (collection_id, app_id, `order`) \
    VALUES (%d, 1, NULL)" % colId
        cursor.execute(insertAppCollection)
        mydb.commit()

        insert32 = "INSERT INTO collections (parent_id,pkey,attachment_id,name,slug,is_category,collection_type,category_id,created_at,updated_at,deleted_at,pds_collection) \
    VALUES \
        (%d, 9991234567894, NULL, 'Collection for Product Upload 3-2', 'col-prod-32', '1', 'default', 'CZZ0301', '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, '1')" % colId

        cursor.execute(insert32)
        mydb.commit()

        cursor.execute("SELECT * FROM collections WHERE category_id = 'CZZ0301'")
        rows = cursor.fetchall()
        colId = rows[0][0]

        insertTranslation = "INSERT INTO translates (locale, languagable_id,languagable_type,text,title,name,description,key_feature,body,unit_type,caption,advantage) \
    VALUES \
        ('en_US', %d, 'Collection', NULL, NULL, 'Collection for Product Upload 3-2', NULL, NULL, NULL, NULL, NULL, NULL)" % colId
        cursor.execute(insertTranslation)
        mydb.commit()

        insertAppCollection = "INSERT INTO apps_collections (collection_id, app_id, `order`) \
    VALUES (%d, 1, NULL)" % colId
        cursor.execute(insertAppCollection)
        mydb.commit()

        insert33 = "INSERT INTO collections (parent_id,pkey,attachment_id,name,slug,is_category,collection_type,category_id,created_at,updated_at,deleted_at,pds_collection) \
    VALUES \
        (%d, 9991234567895, NULL, 'Collection for Product Upload 3-3', 'col-prod-33', '1', 'default', 'CZZ030101', '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, '1')" % colId

        cursor.execute(insert33)
        mydb.commit()

        cursor.execute("SELECT * FROM collections WHERE category_id = 'CZZ030101'")
        rows = cursor.fetchall()
        colId = rows[0][0]

        insertTranslation = "INSERT INTO translates (locale, languagable_id,languagable_type,text,title,name,description,key_feature,body,unit_type,caption,advantage) \
    VALUES \
        ('en_US', %d, 'Collection', NULL, NULL, 'Collection for Product Upload 3-3', NULL, NULL, NULL, NULL, NULL, NULL)" % colId
        cursor.execute(insertTranslation)
        mydb.commit()

        insertAppCollection = "INSERT INTO apps_collections (collection_id, app_id, `order`) \
    VALUES (%d, 1, NULL)" % colId
        cursor.execute(insertAppCollection)
        mydb.commit()



        #category with no child
        insert4 = "INSERT INTO collections (parent_id,pkey,attachment_id,name,slug,is_category,collection_type,category_id,created_at,updated_at,deleted_at,pds_collection) \
    VALUES \
        (0, 9991234567896, NULL, 'Collection for Product Upload 4 (category)', 'col-prod-4', '1', 'default', 'CZZ04', '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, '2')"

        cursor.execute(insert4)
        mydb.commit()

        cursor.execute("SELECT * FROM collections WHERE category_id = 'CZZ04'")
        rows = cursor.fetchall()
        colId = rows[0][0]

        insertTranslation = "INSERT INTO translates (locale, languagable_id,languagable_type,text,title,name,description,key_feature,body,unit_type,caption,advantage) \
    VALUES \
        ('en_US', %d, 'Collection', NULL, NULL, 'Collection for Product Upload 4 (category)', NULL, NULL, NULL, NULL, NULL, NULL)" % colId
        cursor.execute(insertTranslation)
        mydb.commit()

        insertAppCollection = "INSERT INTO apps_collections (collection_id, app_id, `order`) \
    VALUES (%d, 1, NULL)" % colId
        cursor.execute(insertAppCollection)
        mydb.commit()


        #category with one child with another child
        insert51 = "INSERT INTO collections (parent_id,pkey,attachment_id,name,slug,is_category,collection_type,category_id,created_at,updated_at,deleted_at,pds_collection) \
    VALUES \
        (0, 9991234567897, NULL, 'Collection for Product Upload 5 (category)', 'col-prod-51', '1', 'default', 'CZZ05', '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, '2')"

        cursor.execute(insert51)
        mydb.commit()

        cursor.execute("SELECT * FROM collections WHERE category_id = 'CZZ05'")
        rows = cursor.fetchall()
        colId = rows[0][0]

        insertTranslation = "INSERT INTO translates (locale, languagable_id,languagable_type,text,title,name,description,key_feature,body,unit_type,caption,advantage) \
    VALUES \
        ('en_US', %d, 'Collection', NULL, NULL, 'Collection for Product Upload 5 (category)', NULL, NULL, NULL, NULL, NULL, NULL)" % colId
        cursor.execute(insertTranslation)
        mydb.commit()

        insertAppCollection = "INSERT INTO apps_collections (collection_id, app_id, `order`) \
    VALUES (%d, 1, NULL)" % colId
        cursor.execute(insertAppCollection)
        mydb.commit()

        insert52 = "INSERT INTO collections (parent_id,pkey,attachment_id,name,slug,is_category,collection_type,category_id,created_at,updated_at,deleted_at,pds_collection) \
    VALUES \
        (%d, 9991234567898, NULL, 'Collection for Product Upload 5 Sub 1 (category)', 'col-prod-52', '1', 'default', 'CZZ0501', '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, '2')" % colId

        cursor.execute(insert52)
        mydb.commit()

        cursor.execute("SELECT * FROM collections WHERE category_id = 'CZZ0501'")
        rows = cursor.fetchall()
        colId = rows[0][0]

        insertTranslation = "INSERT INTO translates (locale, languagable_id,languagable_type,text,title,name,description,key_feature,body,unit_type,caption,advantage) \
    VALUES \
        ('en_US', %d, 'Collection', NULL, NULL, 'Collection for Product Upload 5 Sub 1 (category)', NULL, NULL, NULL, NULL, NULL, NULL)" % colId
        cursor.execute(insertTranslation)
        mydb.commit()

        insertAppCollection = "INSERT INTO apps_collections (collection_id, app_id, `order`) \
    VALUES (%d, 1, NULL)" % colId
        cursor.execute(insertAppCollection)
        mydb.commit()

        insert53 = "INSERT INTO collections (parent_id,pkey,attachment_id,name,slug,is_category,collection_type,category_id,created_at,updated_at,deleted_at,pds_collection) \
    VALUES \
        (%d, 9991234567899, NULL, 'Collection for Product Upload 5 Sub 1 Sub 1', 'col-prod-53', '1', 'default', 'CZZ050101', '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, '2')" % colId

        cursor.execute(insert53)
        mydb.commit()

        cursor.execute("SELECT * FROM collections WHERE category_id = 'CZZ050101'")
        rows = cursor.fetchall()
        colId = rows[0][0]

        insertTranslation = "INSERT INTO translates (locale, languagable_id,languagable_type,text,title,name,description,key_feature,body,unit_type,caption,advantage) \
    VALUES \
        ('en_US', %d, 'Collection', NULL, NULL, 'Collection for Product Upload 5 Sub 1 Sub 1 (category)', NULL, NULL, NULL, NULL, NULL, NULL)" % colId
        cursor.execute(insertTranslation)
        mydb.commit()

        insertAppCollection = "INSERT INTO apps_collections (collection_id, app_id, `order`) \
    VALUES (%d, 1, NULL)" % colId
        cursor.execute(insertAppCollection)
        mydb.commit()


    except Exception as e:
        print e
        mydb.rollback()
        print "Insert collections failed."

    mydb.close()


def delete_collection_for_product_upload():
    # dbhost = '192.168.99.102'
    # dbuser = 'root'
    # dbpass = 'root'
    # dbname = 'pcms_db'
    # dbcharset = 'utf8'

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    try:

        deleteIds = ['CZZ01', 'CZZ02', 'CZZ0201', 'CZZ03', 'CZZ0301', 'CZZ030101', 'CZZ04', 'CZZ05', 'CZZ0501', 'CZZ050101']

        for deleteId in deleteIds:
            cursor = mydb.cursor()
            cursor.execute("SELECT * FROM collections WHERE category_id = '%s'" % deleteId)
            rows = cursor.fetchall()
            if len(rows) == 0:
                continue
            colId = rows[0][0]

            cursor.execute("DELETE FROM translates where languagable_id=%d and languagable_type='Collection'" % colId)
            mydb.commit()
            cursor.execute("DELETE FROM apps_collections WHERE collection_id = %d" % colId)
            mydb.commit()
            cursor.execute("DELETE FROM collections WHERE category_id = '%s'" % deleteId)
            mydb.commit()
            cursor.execute("DELETE FROM product_collections WHERE collection_id = '%s'" % colId)
            mydb.commit()

    except Exception as e:
        print e
        mydb.rollback()
        print "Delete collections failed."

def verify_exported_product_csv(csv_filename):
    # dbhost = '192.168.99.102'
    # dbuser = 'root'
    # dbpass = 'root'
    # dbname = 'pcms_db'
    # dbcharset = 'utf8'

    COLUMN_PRODUCT_ID      = 0
    COLUMN_PRODUCT_KEY     = 1
    COLUMN_PRODUCT_NAME    = 2
    COLUMN_ACTIVE          = 3
    COLUMN_STOCK           = 4
    COLUMN_TYPE            = 5
    COLUMN_COLLECTION_KEY  = 6
    COLUMN_COLLECTION_NAME = 7

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    try:
        cursor = mydb.cursor()

        if not csv_filename:
            csv_filename = "../Resource/TestData/Collection/csv_file/exported_products.csv"
        with open(csv_filename, 'rb') as csvfile:
            csvreader = csv.reader(csvfile, delimiter=',')
            count = sum(1 for _ in csvreader)
            if count < 2:
                #no content
                raise ValueError('The exported file contains no data.')
            csvfile.seek(0)
            csvreader = csv.reader(csvfile, delimiter=',')
            for row in csvreader:
                product_id = row[COLUMN_PRODUCT_ID].strip()
                if not isinstance( product_id, ( int, long ) ):
                    #header
                    continue
                product_key = row[COLUMN_PRODUCT_KEY].strip()
                product_name = row[COLUMN_PRODUCT_NAME].strip()
                active = row[COLUMN_ACTIVE].strip()
                stock = row[COLUMN_STOCK].strip()
                collection_type = row[COLUMN_TYPE].strip()
                collection_key = row[COLUMN_COLLECTION_KEY].strip()
                collection_trail = row[COLUMN_COLLECTION_NAME].strip()

                #product information
                cursor.execute("SELECT title, active FROM products WHERE id = %d AND pkey = %d" \
                    % (int(product_id), int(product_key)))
                rows = cursor.fetchall()
                if len(rows) == 0:
                    raise ValueError('Product not found - Product Key: ' + product_key)
                db_title = rows[0][0]
                db_product_active = rows[0][1]

                product_name = unicode(product_name, 'utf-8')
                if db_title != product_name:
                    raise ValueError('Product name not match - Product Key: ' + product_key)

                if (active == 'Inactive' and db_product_active == '0') is False and \
                   (active == 'Active' and db_product_active == '1') is False:
                    raise ValueError('Active/Inactive not match - Product Key: ' + product_key)

                #stock information
                db_stock = 0
                cursor.execute("SELECT inventory_id FROM variants WHERE product_id = %d" % int(product_id))
                rows = cursor.fetchall()
                if len(rows) != 0:
                    for row in rows:
                        inventory_id = row[0]
                        cursor.execute("SELECT quantity FROM stock_sums WHERE sku_id = '%s'" % inventory_id)
                        stock_rows = cursor.fetchall()
                        if len(stock_rows) != 0:
                            db_stock = db_stock + stock_rows[0][0]

                if int(stock) != db_stock:
                    raise ValueError('Stock by item not match - Product Key: ' + product_key)

                #collection information
                cursor.execute("SELECT name, pds_collection FROM collections WHERE pkey = %d" \
                    % int(collection_key))
                rows = cursor.fetchall()
                if len(rows) == 0:
                    raise ValueError('Collection not found - Collection Key: ' + collection_key)
                db_name = rows[0][0]
                db_collection_type = rows[0][1]

                collection_trail = unicode(collection_trail, 'utf-8')
                if db_name not in collection_trail:
                    raise ValueError('Collection name not match - Collection Key: ' + collection_key)

                if (collection_type == '' and db_collection_type == '0') is False and \
                   (collection_type == 'Collection' and db_collection_type == '1') is False and \
                   (collection_type == 'Category' and db_collection_type == '2') is False:
                    raise ValueError('Type (Collection or Category) not match - Collection Key: ' + collection_key)

        return "True"
    except Exception as e:
        print e
        mydb.rollback()
        print "Verify exported product csv failed."
        return "False"

def verify_exported_product_collection_csv(csv_filename):
    # dbhost = '192.168.99.102'
    # dbuser = 'root'
    # dbpass = 'root'
    # dbname = 'pcms_db'
    # dbcharset = 'utf8'

    COLUMN_PRODUCT_ID      = 0
    COLUMN_PRODUCT_KEY     = 1
    COLUMN_PRODUCT_NAME    = 2
    COLUMN_ACTIVE          = 3
    COLUMN_STOCK           = 4
    COLUMN_TYPE            = 5
    COLUMN_COLLECTION_KEY  = 6
    COLUMN_COLLECTION_NAME = 7

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    try:
        cursor = mydb.cursor()

        if not csv_filename:
            csv_filename = "../Resource/TestData/Product/csv_file/export_product_collection_up.csv"
        with open(csv_filename, 'rb') as csvfile:
            csvreader = csv.reader(csvfile, delimiter=',')
            count = sum(1 for _ in csvreader)
            if count < 2:
                #no content
                raise ValueError('The exported file contains no data.')
            csvfile.seek(0)
            csvreader = csv.reader(csvfile, delimiter=',')
            for row in csvreader:
                product_id = row[COLUMN_PRODUCT_ID].strip()
                if not isinstance( product_id, ( int, long ) ):
                    #header
                    continue
                product_key = row[COLUMN_PRODUCT_KEY].strip()
                collection_key = row[COLUMN_COLLECTION_KEY].strip()
                product_name = row[COLUMN_PRODUCT_NAME].strip()
                collection_trail = row[COLUMN_COLLECTION_NAME].strip()

                #product information
                cursor.execute("SELECT title, active FROM products WHERE id = %d AND pkey = %d" \
                    % (int(product_id), int(product_key)))
                rows = cursor.fetchall()
                if len(rows) == 0:
                    raise ValueError('Product not found - Product Key: ' + product_key)
                db_title = rows[0][0]
                db_product_active = rows[0][1]

                product_name = unicode(product_name, 'utf-8')
                if db_title != product_name:
                    raise ValueError('Product name not match - Product Key: ' + product_key)

                if (active == 'Inactive' and db_product_active == '0') is False and \
                   (active == 'Active' and db_product_active == '1') is False:
                    raise ValueError('Active/Inactive not match - Product Key: ' + product_key)

                #collection information
                cursor.execute("SELECT name FROM collections WHERE pkey = %d" \
                    % int(collection_key))
                rows = cursor.fetchall()
                if len(rows) == 0:
                    raise ValueError('Collection not found - Collection Key: ' + collection_key)
                db_name = rows[0][0]

                collection_trail = unicode(collection_trail, 'utf-8')
                if db_name not in collection_trail:
                    raise ValueError('Collection name not match - Collection Key: ' + collection_key)

        return "True"
    except Exception as e:
        print e
        mydb.rollback()
        print "Verify exported product collection csv failed."
        return "False"

def write_download_file(cookie,download_url,filename):
        opener = urllib2.build_opener()
        opener.addheaders.append(('Cookie', cookie))
        f = opener.open(download_url)
        content = f.read()
        with open(filename, 'wb') as f:
            f.write(content)

def write_download_with_headers(download_url,filename, header_dict):
        opener = urllib2.build_opener()

        keys = header_dict.keys()

        for key in keys:
            value = header_dict[key]
            opener.addheaders.append((key, value))

        f = opener.open(download_url)
        content = f.read()
        with open(filename, 'wb') as f:
            f.write(content)

def write_download_file_post(cookie,download_url,filename,products,collection):
    opener = urllib2.build_opener()
    opener.addheaders.append(('Cookie', cookie))
    values = { 'product_ids': str(products) ,'collection_id': str(collection) }
    data = urllib.urlencode(values)
    req = urllib2.Request(download_url, data)
    # req.add_header('Cookie', cookie)
    f = opener.open(req)
    # f = urllib2.urlopen(req)

    content = f.read()
    with open(filename, 'wb') as f:
        f.write(content)

def write_download_file_post_products_id(cookie,download_url,filename,products):
    opener = urllib2.build_opener()
    opener.addheaders.append(('Cookie', cookie))
    values = { 'product_ids': str(products)}
    data = urllib.urlencode(values)
    req = urllib2.Request(download_url, data)
    f = opener.open(req)

    content = f.read()
    with open(filename, 'wb') as f:
        f.write(content)

def get_ip_from_url(url):
    urls = str(url)
    return socket.gethostbyname(urls)



def verify_exported_templete(csv_filename):

    COLUMN_COLLECTION_KEY    = 0
    COLUMN_PRODUCT_KEY       = 1

    expected_data = [['Collection Key', 'Product Key'], ['3166522299723', '2214511774379'], ['3166522299723', '2922481192741'], ['3166522299723', '2663396027269']]

    try:
        if not csv_filename:
            csv_filename = "../Resource/TestData/Collection/csv_file/collection_product_upload.csv"
        with open(csv_filename, 'rb') as csvfile:
            csvreader = csv.reader(csvfile, delimiter=',')
            count = sum(1 for _ in csvreader)
            if count < 2:
                #no content
                raise ValueError('The exported file contains no data.')
            csvfile.seek(0)
            count = 0
            csvreader = csv.reader(csvfile, delimiter=',')
            for row in csvreader:
                collection_key = row[COLUMN_COLLECTION_KEY].strip()
                product_key = row[COLUMN_PRODUCT_KEY].strip()
                if collection_key != expected_data[count][0]:
                    raise ValueError('Collection key not match - expect ' + expected_data[count][0] + ' acutal ' + collection_key)
                if product_key != expected_data[count][1]:
                    raise ValueError('Product key not match - expect ' + expected_data[count][1] + ' acutal ' + product_key)
                count = count + 1;

        return "True"
    except Exception as e:
        print e
        print "Verify exported template csv failed."
        return "False"

def verify_exported_templete_product_collection(csv_filename):

    COLUMN_PRODUCT_KEY       = 0

    expected_data = [['Product key'], ['2106374239768'], ['2804434080543'], ['2782548680360'], ['2545332992126']]

    try:
        if not csv_filename:
            csv_filename = "../Resource/TestData/Product/csv_file/export_product_collection_up.csv"
        with open(csv_filename, 'rb') as csvfile:
            csvreader = csv.reader(csvfile, delimiter=',')
            count = sum(1 for _ in csvreader)
            if count < 2:
                #no content
                raise ValueError('The exported file contains no data.')
            csvfile.seek(0)
            count = 0
            csvreader = csv.reader(csvfile, delimiter=',')
            for row in csvreader:
                product_key = row[COLUMN_PRODUCT_KEY].strip()
                if product_key != expected_data[count][0]:
                    raise ValueError('Product key not match - expect ' + expected_data[count][0] + ' acutal ' + product_key)
                count = count + 1;

        return "True"
    except Exception as e:
        print e
        print "Verify exported template csv failed."
        return "False"

def verify_example_template_of_mass_upload_product_collection(csv_filename):

    COLUMN_PRODUCT_KEY	     = 0
    COLUMN_COLLECTION_KEY	 = 1

    expected_data = [['Product Key', 'Collection Key'], ['2214511774379', '3166522299723'], ['2922481192741', '3166522299723'], ['2663396027269', '3166522299723']]

    try:
        if not csv_filename:
            csv_filename = "../Resource/TestData/Collection/csv_file/template_product_collection_upload.csv"
        with open(csv_filename, 'rb') as csvfile:
            csvreader = csv.reader(csvfile, delimiter=',')
            count = sum(1 for _ in csvreader)
            if count < 2:
                raise ValueError('The example csv file contains no data.')
            csvfile.seek(0)
            count = 0
            csvreader = csv.reader(csvfile, delimiter=',')
            for row in csvreader:
                product_key = row[COLUMN_PRODUCT_KEY].strip()
                collection_key = row[COLUMN_COLLECTION_KEY].strip()

                if product_key != expected_data[count][0]:
                    raise ValueError('Product key not match - expect ' + expected_data[count][0] + ' acutal ' + product_key)

                if collection_key != expected_data[count][1]:
                    raise ValueError('Collection key not match - expect ' + expected_data[count][1] + ' acutal ' + collection_key)
                count = count + 1;

        return "True"
    except Exception as e:
        print e
        print "Verify example csv failed."
        return "False"

def verify_shop_merchant_type(shop_code):
    # dbhost = '10.229.13.49'
    # dbuser = 'pcms_app'
    # dbpass = 'root'
    # dbname = 'pcms_db'
    # dbcharset = 'utf8'

    ret_type = ''

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT merchant_type \
    FROM shops \
    WHERE shop_code = '%s' \
    " % shop_code

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        ret_type = rows[0]
    except:
        print "Cannot fetch data."
    mydb.close()

    return ret_type


def insert_collection_for_create_prod():
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)


    cursor = mydb.cursor()

    #collection with no child
    insert1 = "INSERT INTO collections (parent_id,pkey,attachment_id,name,slug,is_category,collection_type,category_id,created_at,updated_at,deleted_at,pds_collection) \
    VALUES \
        (0, 11111, NULL, 'test_for_create_prod', 'test-for-create-prod', '1', 'default', 'TEST0000010', '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, '2')"

    cursor.execute(insert1)
    mydb.commit()

    cursor.execute("SELECT * FROM collections WHERE category_id = 'TEST0000010'")
    rows = cursor.fetchall()
    colId = rows[0][0]

    insertTranslation = "INSERT INTO translates (locale, languagable_id,languagable_type,text,title,name,description,key_feature,body,unit_type,caption,advantage) \
    VALUES \
        ('en_US', %d, 'Collection', NULL, NULL, 'test_for_create_prod', NULL, NULL, NULL, NULL, NULL, NULL)" % colId
    cursor.execute(insertTranslation)
    mydb.commit()

    insertAppCollection = "INSERT INTO apps_collections (collection_id, app_id, `order`) \
    VALUES (%d, 1, NULL)" % colId
    cursor.execute(insertAppCollection)
    mydb.commit()
    mydb.close()


def get_inventory_by_pkey(pkey):

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = "SELECT v.inventory_id \
    FROM products p \
    JOIN variants v ON p.id = v.product_id \
    WHERE p.pkey = '%s' \
    AND v.status = 'active' \
    AND v.deleted_at is null \
    LIMIT 1" % pkey
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows[0]
    except:
        print "Cannot fetch data."
    
    mydb.close()

def get_wow_product_pkey():

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = "SELECT p.pkey \
    FROM view_special_discount vsd \
    JOIN products p ON p.id = vsd.product_id \
    WHERE p.status = 'publish' \
    AND p.active = 1 \
    AND p.deleted_at is null \
    ORDER BY product_id DESC \
    LIMIT 1"
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows[0]
    except:
        print "Cannot fetch data."
    
    mydb.close()

def get_3pl_access_token(third_pl_name):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT access_token \
    FROM third_pl \
    WHERE `third_pl_name` = '%s' \
    " % (third_pl_name)

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows[0]
    except:
        print "Cannot fetch data."
    mydb.close()

def get_3pl_id_by_name(third_pl_name):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT id \
    FROM third_pl \
    WHERE `third_pl_name` = '%s' \
    " % (third_pl_name)

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows[0]
    except:
        print "Cannot fetch data."
    mydb.close()

def get_together_item_status(order_id, item_id):
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "SELECT item_status \
	FROM together_order_items \
	WHERE `pcms_order_id` = '%s' \
	AND pcms_item_id = '%s' \
    " % (order_id, item_id)

	cursor = mydb.cursor()
	try:
		cursor.execute(query)
		rows = cursor.fetchone()
		return rows[0]
	except:
		print "Cannot fetch data."
	mydb.close()

def get_together_order_shipping_fee(order_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT total_shipping_fee \
    FROM together_orders \
    WHERE `pcms_order_id` = '%s' \
    " % order_id

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows[0]
    except:
        print "Cannot fetch data."
    mydb.close()

def get_together_order_status(order_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT order_status \
    FROM together_orders \
    WHERE `pcms_order_id` = '%s' \
    " % order_id

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows[0]
    except:
        print "Cannot fetch data."
    mydb.close()

def get_together_order(order_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT count(id) \
    FROM together_orders \
    WHERE `pcms_order_id` = '%s' \
    " % order_id

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows[0]
    except:
        print "Cannot fetch data."
    mydb.close()

def get_together_order_item(order_id, item_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT count(id) \
    FROM together_order_items \
    WHERE `pcms_order_id` = '%s' \
    AND pcms_item_id = '%s' \
    " % (order_id, item_id)

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows[0]
    except:
        print "Cannot fetch data."
    mydb.close()

def get_data_tracking_receive_queues(tracking_number):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT third_pl_id, tracking_number, alert_count, error_type, status, created_at, updated_at \
    FROM tracking_receive_queues \
    WHERE `tracking_number` = '%s' \
    " % (tracking_number)

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows
    except:
        print "Cannot fetch data."
    mydb.close()

def insert_new_third_pl(third_pl_name, third_pl_fullname, access_token):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    delete_third_pl(third_pl_name, third_pl_fullname, access_token)

        #collection with no child
    insert = "INSERT INTO third_pl (third_pl_name, third_pl_fullname, access_token, created_at, updated_at, deleted_at) \
    VALUES \
    ('%s', '%s', '%s', NOW(), null, null)" % (third_pl_name, third_pl_fullname, access_token)

    try:
        cursor = mydb.cursor()
        result = cursor.execute(insert)
        mydb.commit()
    except:
        mydb.rollback()
        print "insert third_pl fail"

    mydb.close()

def delete_third_pl(third_pl_name, third_pl_fullname, access_token):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "DELETE FROM third_pl WHERE third_pl_name = '%s' AND third_pl_fullname = '%s' AND access_token = '%s'" % (third_pl_name, third_pl_fullname, access_token)
    try:
        cursor = mydb.cursor()
        cursor.execute(query)
        mydb.commit()
    except:
        mydb.rollback()
        print "deleted third_pl fail"

    mydb.close()

def get_count_tracking_receive_log(tracking_number):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT count(id) \
    FROM tracking_receive_logs \
    WHERE `tracking_number` = '%s' \
    " % (tracking_number)

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows[0]
    except:
        print "Cannot fetch data."
    mydb.close()

def get_count_tracking_receive_queues(tracking_number):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT count(id) \
    FROM tracking_receive_queues \
    WHERE `tracking_number` = '%s' \
    " % (tracking_number)

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows[0]
    except:
        print "Cannot fetch data."
    mydb.close()

# clear_cart('5b20772e28e12a52e4a375d2c5046c95fb40a3bef6cd80173d1b8e3d66c8bf05')

def get_products_in_alias_merchant():
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT products.pkey as product_pkey,products.id as product_id, products.title as product_name, `merchant_alias`.id as alias_id, `merchant_alias`.merchant_code as alias_code, `merchant_alias`.name as alias_name\
    FROM `product_merchant_alias` as product_alias , `merchant_alias` , products \
    WHERE products.id = product_alias.product_id and `merchant_alias`.id = product_alias.merchant_alias_id and products.has_variants = 1 \
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

def verify_example_template_of_mass_upload_campaign_price_and_product(csv_filename):

    COLUMN_CAMPAIGN_ID     = 0
    COLUMN_SKU_ID          = 1
    COLUMN_DISCOUNT_PRICE  = 2

    expected_data = [['Campaign ID', 'SKU ID (Inventory ID)' , 'Discount Price'], ['101' , 'TRAAA1112211' , '100'], ['80' , 'ACAAA1111211' , '100'], ['144' , 'BEAAB1125411' , '100']]

    try:
        if not csv_filename:
            csv_filename = "../Resource/TestData/Collection/csv_file/template_campaign_price_and_product_upload.csv"
        with open(csv_filename, 'rb') as csvfile:
            csvreader = csv.reader(csvfile, delimiter=',')
            count = sum(1 for _ in csvreader)
            if count < 2:
                raise ValueError('The example csv file contains no data.')
            csvfile.seek(0)
            count = 0
            csvreader = csv.reader(csvfile, delimiter=',')
            for row in csvreader:
                campaign_id = row[COLUMN_CAMPAIGN_ID].strip()
                sku_id = row[COLUMN_SKU_ID].strip()
                discount_price = row[COLUMN_DISCOUNT_PRICE].strip()

                if campaign_id != expected_data[count][0]:
                    raise ValueError('Campaign ID not match - expect ' + expected_data[count][0] + ' acutal ' + campaign_id)

                if sku_id != expected_data[count][1]:
                    raise ValueError('SKU ID (Inventory ID) not match - expect ' + expected_data[count][1] + ' acutal ' + sku_id)

                if discount_price != expected_data[count][2]:
                    raise ValueError('Discount Price not match - expect ' + expected_data[count][2] + ' acutal ' + discount_price)
                count = count + 1
        return "True"
    except Exception as e:
        print e
        print "Verify example csv failed."
        return "False"

def verify_export_product_merchant_alias_csv(csv_filename):
    # dbhost = '192.168.99.102'
    # dbuser = 'root'
    # dbpass = 'root'
    # dbname = 'pcms_db'
    # dbcharset = 'utf8'

    COLUMN_PRODUCT_KEY     = 0
    COLUMN_ALIAS_CODE      = 1
    COLUMN_PRODUCT_NAME    = 2

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    try:
        cursor = mydb.cursor()

        if not csv_filename:
            csv_filename = "../Resource/TestData/Product/csv_file/export_product_merchant_alias.csv"
        with open(csv_filename, 'rb') as csvfile:
            csvreader = csv.reader(csvfile, delimiter=',')
            count = sum(1 for _ in csvreader)

            if count < 2:
                #no content
                raise ValueError('The exported file contains no data.')
            csvfile.seek(0)
            csvreader = csv.reader(csvfile, delimiter=',')
            for row in csvreader:

                product_key  = row[COLUMN_PRODUCT_KEY].strip()
                product_name = row[COLUMN_PRODUCT_NAME].strip()
                alias_code   = row[COLUMN_ALIAS_CODE].strip()

                if not isinstance( product_key, ( int, long ) ):
                    #header
                    continue
                #product information
                cursor.execute("SELECT title FROM products WHERE pkey = %d" \
                    % int(product_key))
                rows = cursor.fetchall()
                if len(rows) == 0:
                    raise ValueError('Product not found - Product Key: ' + product_key)
                db_title = rows[0][0]

                product_name = unicode(product_name, 'utf-8')
                if db_title != product_name:
                    raise ValueError('Product name not match - Product Key: ' + product_key)
                
                #alias information
                cursor.execute("SELECT name FROM merchant_alias WHERE merchant_code = %d" \
                    % int(alias_code))
                rows = cursor.fetchall()
                if len(rows) == 0:
                    raise ValueError('Merchant code not found - Merchant code: ' + alias_code)

        return "True"
    except Exception as e:
        print e
        mydb.rollback()
        print "Verify export product merchant alias csv failed."
        return "False"


def get_latest_order_by_customer_ref_id(customer_ref_id=None) : 
    if customer_ref_id is None : 
        return None
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    
    query = "SELECT `id`,`cart_id`,`payment_order_id`,`customer_ref_id`,`payment_method`,`total_price`,`discount`,`sub_total`,`order_status`,`payment_status` \
    FROM `orders` WHERE `customer_ref_id` = '%s' \
    ORDER BY `id` DESC LIMIT 1" % customer_ref_id

    #BuiltIn().log_to_console(query)
    try : 
        cursor = mydb.cursor()
        cursor.execute(query)
        rows = cursor.fetchall()
        return rows

    except Exception, e:
        mydb.rollback()
        BuiltIn().log_to_console('DB exception: %s' % e)
        return False
