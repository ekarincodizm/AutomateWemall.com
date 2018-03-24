import random
import json
import MySQLdb as db

from ConnectDB import *

def py_get_productid_varaint(inventory_id=None) :

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)    
    query = "SELECT id, product_id, pkey  FROM variants WHERE inventory_id = '%s' " % inventory_id
    cursor = mydb.cursor()

    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["id"] = rows[0]
        data["product_id"] = rows[1]
        data["pkey"] = rows[2]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()


def py_get_pkey_product(product_id=None) :

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)    
    query = "SELECT pkey  FROM products WHERE id = '%s' " % product_id
    cursor = mydb.cursor()

    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["pkey"] = rows[0]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def py_get_multiple_style_options_pkey(inv_id=None):
    if inv_id is None:
        return None
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
        rows = cursor.fetchall()
        data = {}
        # data["style1"] = rows[0][0]
        # data["style2"] = rows[1][0]
        for index in range(len(rows)):
            data["style"+ str(index+1)] = rows[index][0]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()


def py_get_pkey_main_product_from_variant() :
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = "SELECT  variants.inventory_id as inventory_id , products.pkey as product_pkey, products.id as product_id , variants.id as variant_id,\
        (SELECT count(style_type_id) FROM variant_style_options WHERE  variants.id =  variant_style_options.variant_id ) as countStyle, \
        (SELECT count(id) FROM variants v WHERE v.product_id = products.id  AND v.status = 'active' ) as count_inventory \
        FROM variants \
        INNER JOIN variant_style_options ON variants.id = variant_style_options.variant_id \
        INNER JOIN style_options ON variant_style_options.style_option_id = style_options.id \
        Left JOIN products ON products.id = variants.product_id\
        Left JOIN product_collections ON product_collections.product_id = products.id \
        Left JOIN collections ON collections.id = product_collections.collection_id \
        Left JOIN apps_collections ON apps_collections.collection_id = collections.id \
        Left JOIN brands ON brands.id = products.brand_id \
        INNER JOIN imported_materials ON variants.inventory_id = imported_materials.inventory_id \
        WHERE variants.deleted_at is null \
        AND variants.status = 'active' \
        AND variants.stock_type = 1 \
        AND products.status = 'publish' \
        AND products.active = 1 \
        AND products.has_variants = 1 \
        AND products.deleted_at is null \
        AND products.pkey not in (SELECT pkey FROM product_verify_pendings) \
        AND collections.deleted_at is null \
        AND collections.parent_id = 0 \
        AND brands.deleted_at is null \
        And imported_materials.inventory_id IS NOT NULL\
        GROUP BY variants.id \
        HAVING countStyle = 1 AND  count_inventory >= 1 \
        ORDER BY variants.id asc"
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["inventory_id"] = rows[0]
        data["product_pkey"] = rows[1]
        data["product_id"] = rows[2]
        data["variant_id"] = rows[3]
        data["countStyle"] = rows[4]
        data["count_inventory"] = rows[5]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def py_get_pkey_main_product2_from_variant() :
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)    
    query = "SELECT  variants.inventory_id as inventory_id , products.pkey as product_pkey, products.id as product_id , variants.id as variant_id,\
        (SELECT count(style_type_id) FROM variant_style_options WHERE  variants.id =  variant_style_options.variant_id ) as countStyle, \
        (SELECT count(id) FROM variants v WHERE v.product_id = products.id  AND v.status = 'active' ) as count_inventory \
        FROM variants \
        INNER JOIN variant_style_options ON variants.id = variant_style_options.variant_id \
        INNER JOIN style_options ON variant_style_options.style_option_id = style_options.id \
        INNER JOIN products ON products.id = variants.product_id\
        Left JOIN product_collections ON product_collections.product_id = products.id \
        Left JOIN collections ON collections.id = product_collections.collection_id \
        Left JOIN apps_collections ON apps_collections.collection_id = collections.id \
        Left JOIN brands ON brands.id = products.brand_id \
        INNER JOIN imported_materials ON variants.inventory_id = imported_materials.inventory_id \
        WHERE variants.deleted_at is null \
        AND variants.status = 'active' \
        AND variants.stock_type = 1 \
        AND products.status = 'publish' \
        AND products.active = 1 \
        AND products.has_variants = 1 \
        AND products.deleted_at is null \
        AND products.pkey not in (SELECT pkey FROM product_verify_pendings) \
        AND collections.deleted_at is null \
        AND collections.parent_id = 0 \
        AND brands.deleted_at is null \
        And imported_materials.inventory_id IS NOT NULL\
        GROUP BY variants.id \
        HAVING countStyle = 1 AND  count_inventory = 3 \
        ORDER BY count(variants.id) ASC"
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["inventory_id"] = rows[0]
        data["product_pkey"] = rows[1]
        data["product_id"] = rows[2]
        data["variant_id"] = rows[3]
        data["countStyle"] = rows[4]
        data["count_inventory"] = rows[5]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()



def py_get_pkey_main_product_Inactive_from_variant() :

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = "SELECT variants.id, variants.product_id, products.pkey, variants.inventory_id, \
        (SELECT count(style_type_id) FROM variant_style_options WHERE  variants.id =  variant_style_options.variant_id ) as countStyle, \
        (SELECT count(id) FROM variants v WHERE v.product_id = products.id  AND v.status = 'active' ) as count_inventory \
        FROM variants \
        INNER JOIN products\
        INNER JOIN imported_materials ON variants.inventory_id = imported_materials.inventory_id \
        ON variants.product_id = products.id\
        WHERE variants.deleted_at is null \
        AND products.deleted_at is null \
        AND variants.status = 'disable'\
        AND products.status = 'publish'\
        AND products.active = '1'\
        AND products.pkey not in (SELECT pkey FROM product_verify_pendings) \
        And imported_materials.inventory_id IS NOT NULL\
        HAVING countStyle = 1 AND  count_inventory = 3 \
        ORDER BY variants.id DESC LIMIT 41, 1"
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["id"] = rows[0]
        data["product_id"] = rows[1]
        data["pkey"] = rows[2]
        data["inventory_id"] = rows[3]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def py_get_pkey_freebie_from_variant(start=0) :

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)    
    query = "SELECT variants.id,products.id ,products.pkey,variants.inventory_id  \
              FROM `variants` \
              INNER JOIN `products` ON `products`.`id` = `variants`.`product_id` \
              INNER JOIN `product_collections` ON `product_collections`.`product_id` = `products`.`id` \
              INNER JOIN `collections` ON `collections`.`id` = `product_collections`.`collection_id` \
              INNER JOIN `apps_collections` ON `apps_collections`.`collection_id` = `collections`.`id` \
              INNER JOIN `brands` ON `brands`.`id` = `products`.`brand_id` \
              INNER JOIN `imported_materials` ON `imported_materials`.`inventory_id` = `variants`.`inventory_id`\
              WHERE ( SELECT count( vo.variant_id ) FROM variant_style_options vo WHERE `variants`.`id` = vo.variant_id  ) = 0\
              AND ( SELECT count( ve.product_id ) FROM product_verify_pendings ve WHERE `variants`.`product_id` = ve.product_id  ) = 0\
              AND `variants`.`deleted_at` is null \
              AND `variants`.`status` = 'active' \
              AND `variants`.`stock_type` = 1 \
              AND `products`.`status` = 'publish'\
              AND `products`.`active` = 1\
              AND `products`.`deleted_at` is null\
              AND products.pkey not in (SELECT pkey FROM product_verify_pendings) \
              AND `collections`.`deleted_at` is null\
              AND `collections`.`parent_id` = 0\
              AND `brands`.`deleted_at` is null \
              And imported_materials.inventory_id IS NOT NULL\
              ORDER BY `variants`.`id` DESC  LIMIT %s,1 " % start
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["id"] = rows[0]
        data["product_id"] = rows[1]
        data["pkey"] = rows[2]
        data["inventory_id"] = rows[3]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def py_get_pkey_freebie_from_variant_D(start=0):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)    
    query = "SELECT variants.id,products.id ,products.pkey,variants.inventory_id  \
              FROM `variants` \
              INNER JOIN `products` ON `products`.`id` = `variants`.`product_id` \
              INNER JOIN `product_collections` ON `product_collections`.`product_id` = `products`.`id` \
              INNER JOIN `collections` ON `collections`.`id` = `product_collections`.`collection_id` \
              INNER JOIN `apps_collections` ON `apps_collections`.`collection_id` = `collections`.`id` \
              INNER JOIN `brands` ON `brands`.`id` = `products`.`brand_id` \
              INNER JOIN `imported_materials` ON `imported_materials`.`inventory_id` = `variants`.`inventory_id`\
              WHERE ( SELECT count( vo.variant_id ) FROM variant_style_options vo WHERE `variants`.`id` = vo.variant_id  ) = 0\
              AND `variants`.`deleted_at` is null \
              AND `variants`.`status` = 'active' \
              AND `variants`.`stock_type` = 1 \
              AND `products`.`status` = 'publish'\
              AND `products`.`active` = 1\
              AND `products`.`deleted_at` is null\
              AND products.pkey not in (SELECT pkey FROM product_verify_pendings) \
              AND `collections`.`deleted_at` is null\
              AND `collections`.`parent_id` = 0\
              AND `brands`.`deleted_at` is null \
              And imported_materials.inventory_id IS NOT NULL\
              ORDER BY `variants`.`id` ASC LIMIT %s,1" % start
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["id"] = rows[0]
        data["product_id"] = rows[1]
        data["pkey"] = rows[2]
        data["inventory_id"] = rows[3]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def py_get_pkey_freebie_draft_from_variant() :

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = "SELECT variants.id, variants.product_id, variants.pkey, variants.inventory_id,  \
        (SELECT count(style_type_id) FROM variant_style_options WHERE  variants.id =  variant_style_options.variant_id ) as countStyle, \
        (SELECT count(id) FROM variants v WHERE v.product_id = products.id  AND v.status = 'active' ) as count_inventory \
        FROM variants \
        INNER JOIN products ON variants.product_id = products.id\
        INNER JOIN imported_materials ON variants.inventory_id = imported_materials.inventory_id \
        WHERE variants.deleted_at is null \
        AND products.deleted_at is null \
        AND products.status = 'draft'\
        AND products.pkey not in (SELECT pkey FROM product_verify_pendings) \
        And imported_materials.inventory_id IS NOT NULL\
        HAVING countStyle = 1 AND  count_inventory = 3 \
        ORDER BY variants.id DESC "
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["id"] = rows[0]
        data["product_id"] = rows[1]
        data["pkey"] = rows[2]
        data["inventory_id"] = rows[3]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()


def py_get_multiple_style_options_pkey(inv_id=None):
    if inv_id is None:
        return None
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
        rows = cursor.fetchall()
        data = {}
        # data["style1"] = rows[0][0]
        # data["style2"] = rows[1][0]
        for index in range(len(rows)):
            data["style"+ str(index+1)] = rows[index][0]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def py_get_pkey_freebie_1active_2disable_from_variant() :
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = "SELECT variants.id,variants.product_id, products.pkey, variants.inventory_id as inventory_id,\
        (SELECT count(id) FROM variants v WHERE v.product_id = products.id  and v.status= 'active'  ) as count_inventory_active,\
        (SELECT count(id) FROM variants v WHERE v.product_id = products.id  and v.status= 'disable'  ) as count_inventory_disable\
        FROM variants \
        INNER JOIN variant_style_options ON variants.id = variant_style_options.variant_id\
        INNER JOIN style_options ON variant_style_options.style_option_id = style_options.id \
        INNER JOIN products ON products.id = variants.product_id \
        Left JOIN product_collections ON product_collections.product_id = products.id \
        Left JOIN collections ON collections.id = product_collections.collection_id \
        Left JOIN apps_collections ON apps_collections.collection_id = collections.id \
        Left JOIN brands ON brands.id = products.brand_id \
        INNER JOIN imported_materials ON variants.inventory_id = imported_materials.inventory_id \
        WHERE variants.deleted_at is null \
        AND variants.status = 'active' \
        AND variants.stock_type = 1\
        AND products.status = 'publish' \
        AND products.active = 1 \
        AND products.has_variants = 1 \
        AND products.deleted_at is null \
        AND products.pkey not in (SELECT pkey FROM product_verify_pendings) \
        AND collections.deleted_at is null\
        AND collections.parent_id = 0 \
        AND brands.deleted_at is null \
        And imported_materials.inventory_id IS NOT NULL\
        GROUP BY variants.id \
        HAVING  count_inventory_active = 1 and count_inventory_disable = 2\
        ORDER BY count(variants.id) DESC"
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["id"] = rows[0]
        data["product_id"] = rows[1]
        data["pkey"] = rows[2]
        data["inventory_id"] = rows[3]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def py_get_pkey_freebie_1active_2disable_status_is_approved_from_variant() :
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = "SELECT variants.id,variants.product_id, products.pkey, variants.inventory_id as inventory_id,\
        (SELECT count(id) FROM variants v WHERE v.product_id = products.id  and v.status= 'active'  ) as count_inventory_active,\
        (SELECT count(id) FROM variants v WHERE v.product_id = products.id  and v.status= 'disable'  ) as count_inventory_disable\
        FROM variants \
        INNER JOIN variant_style_options ON variants.id = variant_style_options.variant_id\
        INNER JOIN style_options ON variant_style_options.style_option_id = style_options.id \
        INNER JOIN products ON products.id = variants.product_id \
        Left JOIN product_collections ON product_collections.product_id = products.id \
        Left JOIN collections ON collections.id = product_collections.collection_id \
        Left JOIN apps_collections ON apps_collections.collection_id = collections.id \
        Left JOIN brands ON brands.id = products.brand_id \
        INNER JOIN imported_materials ON variants.inventory_id = imported_materials.inventory_id \
        WHERE variants.deleted_at is null \
        AND variants.status = 'active' \
        AND variants.stock_type = 1\
        AND products.status = 'approved' \
        AND products.active = 1 \
        AND products.has_variants = 1 \
        AND products.deleted_at is null \
        AND products.pkey not in (SELECT pkey FROM product_verify_pendings) \
        AND collections.deleted_at is null\
        AND collections.parent_id = 0 \
        AND brands.deleted_at is null \
        And imported_materials.inventory_id IS NOT NULL\
        GROUP BY variants.id \
        HAVING  count_inventory_active >= 1 and count_inventory_disable = 2\
        ORDER BY count(variants.id) DESC"
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["id"] = rows[0]
        data["product_id"] = rows[1]
        data["pkey"] = rows[2]
        data["inventory_id"] = rows[3]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()



def py_get_pkey_freebie_1active_2disable_product_as_draft_from_variant() :
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = "SELECT variants.id,variants.product_id, products.pkey, variants.inventory_id as inventory_id,\
        (SELECT count(id) FROM variants v WHERE v.product_id = products.id  and v.status= 'active'  ) as count_inventory_active,\
        (SELECT count(id) FROM variants v WHERE v.product_id = products.id  and v.status= 'disable'  ) as count_inventory_disable\
        FROM variants \
        INNER JOIN variant_style_options ON variants.id = variant_style_options.variant_id\
        INNER JOIN style_options ON variant_style_options.style_option_id = style_options.id \
        INNER JOIN products ON products.id = variants.product_id \
        LEFT JOIN product_collections ON product_collections.product_id = products.id \
        LEFT JOIN collections ON collections.id = product_collections.collection_id \
        LEFT JOIN apps_collections ON apps_collections.collection_id = collections.id \
        LEFT JOIN brands ON brands.id = products.brand_id \
        INNER JOIN imported_materials ON variants.inventory_id = imported_materials.inventory_id \
        WHERE variants.deleted_at is null \
        AND variants.status = 'active' \
        AND variants.stock_type = 1\
        AND products.status = 'draft' \
        AND products.active = 1 \
        AND products.has_variants = 1 \
        AND products.deleted_at is null \
        AND products.pkey not in (SELECT pkey FROM product_verify_pendings) \
        AND collections.deleted_at is null\
        AND collections.parent_id = 0 \
        AND brands.deleted_at is null \
        And imported_materials.inventory_id IS NOT NULL\
        GROUP BY variants.id \
        HAVING  count_inventory_active >= 1 and count_inventory_disable = 2\
        ORDER BY count(variants.id) DESC"
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["id"] = rows[0]
        data["product_id"] = rows[1]
        data["pkey"] = rows[2]
        data["inventory_id"] = rows[3]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def py_get_pkey_freebie_1active_2disable_product_as_draft_no_apps() :
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = "SELECT variants.id,variants.product_id, products.pkey, variants.inventory_id as inventory_id,\
        (SELECT count(id) FROM variants v WHERE v.product_id = products.id  and v.status= 'active'  ) as count_inventory_active,\
        (SELECT count(id) FROM apps  WHERE apps.id = apps_collections.app_id  ) as count_apps\
        FROM variants \
        INNER JOIN variant_style_options ON variants.id = variant_style_options.variant_id\
        INNER JOIN style_options ON variant_style_options.style_option_id = style_options.id \
        INNER JOIN products ON products.id = variants.product_id \
        left JOIN product_collections ON product_collections.product_id = products.id\
        left JOIN collections ON collections.id = product_collections.collection_id\
        left JOIN apps_collections ON apps_collections.collection_id = collections.id \
        INNER JOIN brands ON brands.id = products.brand_id \
        INNER JOIN imported_materials ON variants.inventory_id = imported_materials.inventory_id \
        left JOIN apps ON apps_collections.app_id = apps.id \
        WHERE variants.deleted_at is null \
        AND variants.status = 'active'\
        AND variants.stock_type = 1\
        AND products.status = 'draft' \
        AND products.active = 1 \
        AND products.has_variants = 1 \
        AND products.deleted_at is null \
        AND products.pkey not in (SELECT pkey FROM product_verify_pendings) \
        AND collections.deleted_at is null\
        AND collections.parent_id = 0 \
        AND brands.deleted_at is null \
        And imported_materials.inventory_id IS NOT NULL\
        GROUP BY variants.id \
        HAVING  count_inventory_active >= 1 and count_apps = 0\
        ORDER BY variants.id DESC limit 9,1"
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["id"] = rows[0]
        data["product_id"] = rows[1]
        data["pkey"] = rows[2]
        data["inventory_id"] = rows[3]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def py_get_pkey_freebie_1active_2disable_product_as_draft_collection_is_itruemart() :
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = "SELECT variants.id,variants.product_id, products.pkey, variants.inventory_id as inventory_id,\
        (SELECT count(id) FROM variants v WHERE v.product_id = products.id  and v.status= 'active'  ) as count_inventory_active,\
        (SELECT count(id) FROM variants v WHERE v.product_id = products.id  and v.status= 'disable'  ) as count_inventory_disable\
        FROM variants \
        INNER JOIN variant_style_options ON variants.id = variant_style_options.variant_id\
        INNER JOIN style_options ON variant_style_options.style_option_id = style_options.id \
        INNER JOIN products ON products.id = variants.product_id \
        INNER JOIN product_collections ON product_collections.product_id = products.id \
        INNER JOIN collections ON collections.id = product_collections.collection_id \
        INNER JOIN apps_collections ON apps_collections.collection_id = collections.id \
        INNER JOIN apps ON apps_collections.app_id = apps.id \
        INNER JOIN brands ON brands.id = products.brand_id \
        INNER JOIN imported_materials ON variants.inventory_id = imported_materials.inventory_id \
        WHERE variants.deleted_at is null \
        AND variants.status = 'active' \
        AND variants.stock_type = 1\
        AND products.status = 'draft' \
        AND products.active = 1 \
        AND products.has_variants = 1 \
        AND products.deleted_at is null \
        AND products.pkey not in (SELECT pkey FROM product_verify_pendings) \
        AND collections.deleted_at is null\
        AND collections.parent_id = 0 \
        AND brands.deleted_at is null \
        And imported_materials.inventory_id IS NOT NULL\
        And apps.id = 1\
        And apps.name = 'iTruemart'\
        GROUP BY variants.id \
        HAVING  count_inventory_active = 1 and count_inventory_disable = 2\
        ORDER BY count(variants.id) DESC"
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["id"] = rows[0]
        data["product_id"] = rows[1]
        data["pkey"] = rows[2]
        data["inventory_id"] = rows[3]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def py_get_inventory_id_from_fms() :

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = "SELECT stock_sums.sku_id  \
        FROM stock_sums \
        Left join variants on stock_sums.sku_id = variants.inventory_id\
        where variants.inventory_id is null\
        ORDER BY stock_sums.sku_id DESC limit 47,1"
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["sku_id"] = rows[0]

        return data
    except:
        print "Cannot fetch data."
    mydb.close()



def py_update_variantid_is_disable(inv_id=None) :
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = db.cursor()
    sql = "UPDATE variants SET status = 'disable' WHERE inventory_id = '%s' " % inv_id
    try:
       cursor.execute(sql)
       db.commit()
    except:
       db.rollback()
    db.close()

def py_get_main_product_have_3_variant_Inactive(start=0) :
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = "SELECT variants.id,variants.product_id, products.pkey, variants.inventory_id as inventory_id,\
        (SELECT count(id) FROM variants v WHERE v.product_id = products.id  and v.status= 'active') as count_inventory_active,\
        (SELECT count(id) FROM variants v WHERE v.product_id = products.id  and v.status= 'disable') as count_inventory_disable,\
                (SELECT count(style_type_id) FROM variant_style_options WHERE  variants.id =  variant_style_options.variant_id ) as countStyle \
        FROM variants \
        INNER JOIN variant_style_options ON variants.id = variant_style_options.variant_id\
        INNER JOIN style_options ON variant_style_options.style_option_id = style_options.id \
        INNER JOIN products ON products.id = variants.product_id \
        Left JOIN product_collections ON product_collections.product_id = products.id \
        Left JOIN collections ON collections.id = product_collections.collection_id \
        Left JOIN apps_collections ON apps_collections.collection_id = collections.id \
        Left JOIN brands ON brands.id = products.brand_id \
        INNER JOIN imported_materials ON variants.inventory_id = imported_materials.inventory_id \
        WHERE variants.deleted_at is null \
        AND variants.status = 'active' \
        AND variants.stock_type = 1\
        AND products.status = 'publish' \
        AND products.active = 1 \
        AND products.has_variants = 1 \
        AND products.deleted_at is null \
        AND products.pkey not in (SELECT pkey FROM product_verify_pendings) \
        AND collections.deleted_at is null\
        AND collections.parent_id = 0 \
        AND brands.deleted_at is null \
        And imported_materials.inventory_id IS NOT NULL\
        GROUP BY variants.id \
        HAVING  count_inventory_active >= 3  And countStyle = 1 \
        ORDER BY count(variants.id) DESC limit %s,1" % start
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["id"] = rows[0]
        data["product_id"] = rows[1]
        data["pkey"] = rows[2]
        data["inventory_id"] = rows[3]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def py_get_main_product_have_3_variant_Inactive_b(start=0) :
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = "SELECT variants.id,variants.product_id, products.pkey, variants.inventory_id as inventory_id,\
        (SELECT count(id) FROM variants v WHERE v.product_id = products.id  and v.status= 'active') as count_inventory_active,\
        (SELECT count(id) FROM variants v WHERE v.product_id = products.id  and v.status= 'disable') as count_inventory_disable,\
        (SELECT count(style_type_id) FROM variant_style_options WHERE  variants.id =  variant_style_options.variant_id ) as countStyle \
        FROM variants \
        INNER JOIN variant_style_options ON variants.id = variant_style_options.variant_id\
        INNER JOIN style_options ON variant_style_options.style_option_id = style_options.id \
        INNER JOIN products ON products.id = variants.product_id \
        Left JOIN product_collections ON product_collections.product_id = products.id \
        Left JOIN collections ON collections.id = product_collections.collection_id \
        Left JOIN apps_collections ON apps_collections.collection_id = collections.id \
        Left JOIN brands ON brands.id = products.brand_id \
        INNER JOIN imported_materials ON variants.inventory_id = imported_materials.inventory_id \
        WHERE variants.deleted_at is null \
        AND ( SELECT count( ve.product_id ) FROM product_verify_pendings ve WHERE `variants`.`product_id` = ve.product_id  ) = 0\
        AND variants.status = 'active' \
        AND variants.stock_type = 1\
        AND products.status = 'publish' \
        AND products.active = 1 \
        AND products.has_variants = 1 \
        AND products.deleted_at is null \
        AND products.pkey not in (SELECT pkey FROM product_verify_pendings) \
        AND collections.deleted_at is null\
        AND collections.parent_id = 0 \
        AND brands.deleted_at is null \
        And imported_materials.inventory_id IS NOT NULL  \
        GROUP BY variants.id \
        HAVING  count_inventory_active >= 3  and countStyle = 1\
        ORDER BY count(variants.id) DESC limit %s,1" % start
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["id"] = rows[0]
        data["product_id"] = rows[1]
        data["pkey"] = rows[2]
        data["inventory_id"] = rows[3]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def py_get_main_product_have_1_variant_active(start=0) :
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = "SELECT variants.id,products.id ,products.pkey,variants.inventory_id  \
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
              AND products.pkey not in (SELECT pkey FROM product_verify_pendings) \
              AND `collections`.`deleted_at` is null\
              AND `collections`.`parent_id` = 0\
              AND `brands`.`deleted_at` is null \
              And imported_materials.inventory_id IS NOT NULL\
              ORDER BY `variants`.`id` DESC limit %s,1" % start
    # return query          
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["id"] = rows[0]
        data["product_id"] = rows[1]
        data["pkey"] = rows[2]
        data["inventory_id"] = rows[3]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()
def py_get_main_product_have_1_variant_active_b(start=0) :
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = "SELECT variants.id,products.id ,products.pkey,variants.inventory_id  \
              FROM `variants` \
              INNER JOIN `products` ON `products`.`id` = `variants`.`product_id` \
              INNER JOIN `product_collections` ON `product_collections`.`product_id` = `products`.`id` \
              INNER JOIN `collections` ON `collections`.`id` = `product_collections`.`collection_id` \
              INNER JOIN `apps_collections` ON `apps_collections`.`collection_id` = `collections`.`id` \
              INNER JOIN `brands` ON `brands`.`id` = `products`.`brand_id` \
              INNER JOIN `imported_materials` ON `imported_materials`.`inventory_id` = `variants`.`inventory_id`\
              WHERE ( SELECT count( vo.variant_id ) FROM variant_style_options vo WHERE `variants`.`id` = vo.variant_id  ) = 0\
              AND `variants`.`deleted_at` is null \
              AND `variants`.`status` = 'active' \
              AND `variants`.`stock_type` = 1 \
              AND `products`.`status` = 'publish'\
              AND `products`.`active` = 1\
              AND `products`.`deleted_at` is null\
              AND products.pkey not in (SELECT pkey FROM product_verify_pendings) \
              AND `collections`.`deleted_at` is null\
              AND `collections`.`parent_id` = 0\
              AND `brands`.`deleted_at` is null \
              And imported_materials.inventory_id IS NOT NULL\
              ORDER BY `variants`.`id` DESC limit %s,1" % start
    # return query          
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["id"] = rows[0]
        data["product_id"] = rows[1]
        data["pkey"] = rows[2]
        data["inventory_id"] = rows[3]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()
def py_get_pkey_freebie_have_3_variant() :
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = "SELECT variants.id,variants.product_id, products.pkey, variants.inventory_id as inventory_id,\
        (SELECT count(id) FROM variants v WHERE v.product_id = products.id  and v.status= 'active'  ) as count_inventory_active\
        FROM variants \
        INNER JOIN variant_style_options ON variants.id = variant_style_options.variant_id\
        INNER JOIN style_options ON variant_style_options.style_option_id = style_options.id \
        INNER JOIN products ON products.id = variants.product_id \
        Left JOIN product_collections ON product_collections.product_id = products.id \
        Left JOIN collections ON collections.id = product_collections.collection_id \
        Left JOIN apps_collections ON apps_collections.collection_id = collections.id \
        Left JOIN brands ON brands.id = products.brand_id \
        INNER JOIN imported_materials ON variants.inventory_id = imported_materials.inventory_id \
        WHERE variants.deleted_at is null \
        AND variants.status = 'active' \
        AND variants.stock_type = 1\
        AND products.status = 'publish' \
        AND products.active = 1 \
        AND products.has_variants = 1 \
        AND products.deleted_at is null \
        AND products.pkey not in (SELECT pkey FROM product_verify_pendings) \
        AND collections.deleted_at is null\
        AND collections.parent_id = 0 \
        AND brands.deleted_at is null \
        And imported_materials.inventory_id IS NOT NULL\
        GROUP BY variants.id \
        HAVING  count_inventory_active >= 3\
        ORDER BY count(variants.id) DESC"
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data["id"] = rows[0]
        data["product_id"] = rows[1]
        data["pkey"] = rows[2]
        data["inventory_id"] = rows[3]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def py_get_inventory_by_product_id(product_id=None, start=0):
    if product_id is None:
        return None

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = "SELECT inventory_id  FROM `variants` WHERE `product_id` = %s AND `status` = 'active' LIMIT %s,1" % (product_id, start)

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows[0]
    except:
        print "Cannot fetch data."
    mydb.close()

def py_get_inventory_no_style_different_main_inventory(not_inv_id=None,start=1):
    if not_inv_id is None:
        return None

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT `variants`.`inventory_id`, `products`.`pkey`, `products`.`id`  ,`variants`.id    \
  FROM `variants` \
  INNER JOIN `products` ON `products`.`id` = `variants`.`product_id` \
  INNER JOIN `product_collections` ON `product_collections`.`product_id` = `products`.`id` \
  INNER JOIN `collections` ON `collections`.`id` = `product_collections`.`collection_id` \
  INNER JOIN `apps_collections` ON `apps_collections`.`collection_id` = `collections`.`id` \
  INNER JOIN `brands` ON `brands`.`id` = `products`.`brand_id` \
  INNER JOIN `imported_materials` ON `imported_materials`.`inventory_id` = `variants`.`inventory_id`\
  WHERE ( SELECT count( vo.variant_id ) FROM variant_style_options vo WHERE `variants`.`id` = vo.variant_id  ) = 0\
  AND `variants`.`deleted_at` is null \
  AND `variants`.`status` = 'active' \
  AND `variants`.`stock_type` = 1 \
  AND `products`.`status` = 'publish'\
  AND `products`.`active` = 1\
  AND `products`.`deleted_at` is null\
  AND products.pkey not in (SELECT pkey FROM product_verify_pendings) \
  AND `collections`.`deleted_at` is null\
  AND `collections`.`parent_id` = 0\
  AND `brands`.`deleted_at` is null \
  AND `variants`.`inventory_id` != '%s'\
  ORDER BY `variants`.`id` DESC\
  LIMIT %s,1" % (not_inv_id,start)

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

def  py_get_product_same_collection(collection_id=339, start=0):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT collections.id, products.id, variants.inventory_id, collections.name, products.title \
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
    AND collections.id = %s \
    AND variants.deleted_at is null \
    AND variants.status = 'active' \
    AND variants.stock_type = 1 \
    AND products.has_variants = 1 \
    AND products.status = 'publish' \
    AND products.active = 1 \
    AND products.deleted_at is null \
    AND products.pkey not in (SELECT pkey FROM product_verify_pendings) \
    AND apps_collections.app_id = 1 \
    ORDER BY products.id   DESC  LIMIT %s,3" % (collection_id, start) 
    # return query
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        result = []
         
        i = 0   
        for row in rows:
            data = {}
            data["collection_id"] = rows[i][0]
            data["inventory_id"] = rows[i][2]
            data["collection_name"] = rows[i][3]
            data["product_title"] = rows[i][4]
            result.append(data)
            i = i+1

        return result
    except:
        print "Cannot fetch data."
    mydb.close()

# status : enum('active', 'disable')
def py_update_variant_status(status=None, variants_id=None):
    if status is None : 
        return None 
    if variants_id is None : 
        return None 
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try : 
        query = "UPDATE `variants` SET `status` = '%s' WHERE `variants`.`id` = %s;" %(status, variants_id)
        result = cursor.execute(query)
        mydb.commit()
        return True
    except: 
        mydb.rollback()
        return False

# status : enum('draft', 'approved', 'incomplete', 'publish')
# active :  enum('1', '0')
def py_update_product_status(status=None, active=None, product_id=None):
    if status is None : 
        return None 
    if active is None : 
        return None 
    if product_id is None : 
        return None     

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try : 
        query = "UPDATE `products` SET `status` = '%s', `active` = '%s' WHERE `products`.`id` = %s;" %(status, active, product_id)
        result = cursor.execute(query)
        mydb.commit()
        return True
    except: 
        mydb.rollback()
        return False

def py_get_product_no_collections_all_status(start=1) :

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = "SELECT variants.id, products.id, products.pkey, variants.inventory_id, products.`status`, products.`active`, variants.status   \
        FROM `products` \
        INNER JOIN variants ON variants.product_id = products.id\
        INNER JOIN imported_materials ON variants.inventory_id = imported_materials.inventory_id \
        WHERE (SELECT count(*) FROM product_collections WHERE product_id IN (products.id)  ) = 0\
        AND ( SELECT count( vo.variant_id ) FROM variant_style_options vo WHERE `variants`.`id` = vo.variant_id  ) = 0\
        AND ( SELECT count( ve.product_id ) FROM product_verify_pendings ve WHERE `variants`.`product_id` = ve.product_id  ) = 0\
        AND products.`deleted_at` IS NULL \
        AND variants.deleted_at is NULL\
        AND products.pkey not in (SELECT pkey FROM product_verify_pendings) \
        AND imported_materials.inventory_id IS NOT NULL\
        ORDER BY variants.id DESC LIMIT %s,2" % start

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        result = []
         
        i = 0   
        for row in rows:
            data = {}
            data["variant_id"] = rows[i][0]
            data["product_id"] = rows[i][1]
            data["pkey"] = rows[i][2]
            data["inventory_id"] = rows[i][3]
            data["product_status"] = rows[i][4]
            data["product_active"] = rows[i][5]
            data["variant_status"] = rows[i][6]
            result.append(data)
            i = i+1

        return result
    except:
        print "Cannot fetch data."
    mydb.close()


def py_get_product_freebie_brand(start=1):
    
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT `variants`.`id`, `products`.`id`, `products`.`pkey`, variants.inventory_id as inventory_id, `products`.`status`, `products`.`active`, `variants`.`status` \
      FROM `variants` \
      INNER JOIN `products` ON `products`.`id` = `variants`.`product_id` \
      INNER JOIN `product_collections` ON `product_collections`.`product_id` = `products`.`id` \
      INNER JOIN `collections` ON `collections`.`id` = `product_collections`.`collection_id` \
      INNER JOIN `apps_collections` ON `apps_collections`.`collection_id` = `collections`.`id` \
      INNER JOIN `brands` ON `brands`.`id` = `products`.`brand_id` \
      INNER JOIN `imported_materials` ON `imported_materials`.`inventory_id` = `variants`.`inventory_id`\
      WHERE ( SELECT count( vo.variant_id ) FROM variant_style_options vo WHERE `variants`.`id` = vo.variant_id  ) = 0\
      AND ( SELECT count( ve.product_id ) FROM product_verify_pendings ve WHERE `variants`.`product_id` = ve.product_id  ) = 0\
      AND `products`.`deleted_at` is null\
      AND products.pkey not in (SELECT pkey FROM product_verify_pendings) \
      AND `variants`.`deleted_at` is null \
      AND `variants`.`stock_type` = 1 \
      AND `collections`.`deleted_at` is null\
      AND `collections`.`parent_id` = 0\
      AND `brands`.`deleted_at` is null \
      AND `brands`.`name` LIKE '%s' \
      ORDER BY `variants`.`id` DESC\
      LIMIT %s,1" % ( ( "%" + "Freebie Automate Brand" + "%" ), start)
    # return query  
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        result = []
         
        i = 0   
        for row in rows:
            data = {}
            data["variant_id"] = rows[i][0]
            data["product_id"] = rows[i][1]
            data["pkey"] = rows[i][2]
            data["inventory_id"] = rows[i][3]
            data["product_status"] = rows[i][4]
            data["product_active"] = rows[i][5]
            data["variant_status"] = rows[i][6]
            result.append(data)
            i = i+1

        return result
    except:
        print "Cannot fetch data."
    mydb.close()    


def py_get_product_has_collection_app_itruemart(products_status='publish', products_active=1,  variants_status='active', start=1):
    
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT `variants`.`id`, `products`.`id`, `products`.`pkey`, variants.inventory_id as inventory_id \
      FROM `variants` \
      INNER JOIN `products` ON `products`.`id` = `variants`.`product_id` \
      INNER JOIN `product_collections` ON `product_collections`.`product_id` = `products`.`id` \
      INNER JOIN `collections` ON `collections`.`id` = `product_collections`.`collection_id` \
      INNER JOIN `apps_collections` ON `apps_collections`.`collection_id` = `collections`.`id` \
      INNER JOIN apps ON apps_collections.app_id = apps.id \
      INNER JOIN `brands` ON `brands`.`id` = `products`.`brand_id` \
      INNER JOIN `imported_materials` ON `imported_materials`.`inventory_id` = `variants`.`inventory_id`\
      WHERE ( SELECT count( vo.variant_id ) FROM variant_style_options vo WHERE `variants`.`id` = vo.variant_id  ) = 0\
      AND `products`.`status` = '%s'\
      AND `products`.`active` = '%s'\
      AND `products`.`deleted_at` is null\
      AND `products`.`pkey` not in (SELECT pkey FROM product_verify_pendings) \
      AND `variants`.`deleted_at` is null \
      AND `variants`.`status` = '%s' \
      AND `variants`.`stock_type` = 1 \
      AND `collections`.`deleted_at` is null\
      AND `collections`.`parent_id` = 0\
      AND `brands`.`deleted_at` is null \
      AND apps.id = 1\
      AND apps.name = 'iTruemart'\
      ORDER BY `variants`.`id` DESC\
      LIMIT %s,1" % (products_status, products_active, variants_status ,start)
    # return query  
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        result = []
         
        i = 0   
        for row in rows:
            data = {}
            data["variant_id"] = rows[i][0]
            data["product_id"] = rows[i][1]
            data["pkey"] = rows[i][2]
            data["inventory_id"] = rows[i][3]
            result.append(data)
            i = i+1

        return result
    except:
        print "Cannot fetch data."
    mydb.close()    


def py_get_product_has_collection_app_itruemart_all_status(start=1) :
    
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = "SELECT variants.id, variants.product_id, products.pkey, variants.inventory_id as inventory_id, `products`.`status`, `products`.`active`, `variants`.`status`\
        FROM variants \
        INNER JOIN products ON products.id = variants.product_id \
        INNER JOIN product_collections ON product_collections.product_id = products.id \
        INNER JOIN collections ON collections.id = product_collections.collection_id \
        INNER JOIN apps_collections ON apps_collections.collection_id = collections.id \
        INNER JOIN apps ON apps_collections.app_id = apps.id \
        INNER JOIN brands ON brands.id = products.brand_id \
        INNER JOIN imported_materials ON variants.inventory_id = imported_materials.inventory_id \
        WHERE ( SELECT count( vo.variant_id ) FROM variant_style_options vo WHERE `variants`.`id` = vo.variant_id  ) = 0\
        AND ( SELECT count( ve.product_id ) FROM product_verify_pendings ve WHERE `variants`.`product_id` = ve.product_id  ) = 0\
        AND variants.deleted_at is null \
        AND variants.stock_type = 1\
        AND products.deleted_at is null \
        AND products.pkey not in (SELECT pkey FROM product_verify_pendings) \
        AND collections.deleted_at is null\
        AND collections.parent_id = 0 \
        AND brands.deleted_at is null \
        AND imported_materials.inventory_id IS NOT NULL\
        AND apps.id = 1\
        AND apps.name = 'iTruemart'\
        GROUP BY variants.id \
        ORDER BY count(variants.id) DESC LIMIT %s,2" % start
    # return query
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        result = []
         
        i = 0   
        for row in rows:
            data = {}
            data["variant_id"] = rows[i][0]
            data["product_id"] = rows[i][1]
            data["pkey"] = rows[i][2]
            data["inventory_id"] = rows[i][3]
            data["product_status"] = rows[i][4]
            data["product_active"] = rows[i][5]
            data["variant_status"] = rows[i][6]
            result.append(data)
            i = i+1
        return result

    except:
        print "Cannot fetch data."
    mydb.close()


def py_get_product_has_collections_no_apps(products_status='publish', products_active=1,  variants_status='active', start=1):
    
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT `variants`.`id`, `products`.`id`, `products`.`pkey`, variants.inventory_id as inventory_id \
      FROM `variants` \
      INNER JOIN `products` ON `products`.`id` = `variants`.`product_id` \
      INNER JOIN `product_collections` ON `product_collections`.`product_id` = `products`.`id` \
      INNER JOIN `collections` ON `collections`.`id` = `product_collections`.`collection_id` \
      INNER JOIN `apps_collections` ON `apps_collections`.`collection_id` = `collections`.`id` \
      INNER JOIN `brands` ON `brands`.`id` = `products`.`brand_id` \
      INNER JOIN `imported_materials` ON `imported_materials`.`inventory_id` = `variants`.`inventory_id`\
      WHERE (SELECT count(*) FROM product_collections WHERE product_id IN (products.id)  ) = 0\
      AND ( SELECT count( vo.variant_id ) FROM variant_style_options vo WHERE `variants`.`id` = vo.variant_id  ) = 0\
      AND `products`.`status` = '%s'\
      AND `products`.`active` = '%s'\
      AND `products`.`deleted_at` is null\
      AND `products`.`pkey` not in (SELECT pkey FROM product_verify_pendings) \
      AND `variants`.`deleted_at` is null \
      AND `variants`.`status` = '%s' \
      AND `variants`.`stock_type` = 1 \
      AND `collections`.`deleted_at` is null\
      AND `collections`.`parent_id` = 0\
      AND `brands`.`deleted_at` is null \
      ORDER BY `variants`.`id` DESC\
      LIMIT %s,1" % (products_status, products_active, variants_status ,start)
    # return query  
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        result = []
         
        i = 0   
        for row in rows:
            data = {}
            data["variant_id"] = rows[i][0]
            data["product_id"] = rows[i][1]
            data["pkey"] = rows[i][2]
            data["inventory_id"] = rows[i][3]
            result.append(data)
            i = i+1

        return result
    except:
        print "Cannot fetch data."
    mydb.close()    


def py_get_product_has_collections_no_apps_all_status(products_status='publish', products_active=1,  variants_status='active', start=1) :

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    query = "SELECT variants.id, products.id, products.pkey, variants.inventory_id, `products`.`status`, `products`.`active`, `variants`.`status` \
        FROM `products` \
        INNER JOIN variants ON variants.product_id = products.id\
        INNER JOIN imported_materials ON variants.inventory_id = imported_materials.inventory_id \
        WHERE (SELECT count(*) FROM product_collections WHERE product_id IN (products.id)  ) = 0\
        AND ( SELECT count( vo.variant_id ) FROM variant_style_options vo WHERE `variants`.`id` = vo.variant_id  ) = 0\
        AND ( SELECT count( ve.product_id ) FROM product_verify_pendings ve WHERE `variants`.`product_id` = ve.product_id  ) = 0\
        AND products.`deleted_at` IS NULL \
        AND products.pkey not in (SELECT pkey FROM product_verify_pendings) \
        AND variants.deleted_at is NULL\
        AND imported_materials.inventory_id IS NOT NULL\
        ORDER BY variants.id DESC LIMIT %s,2" % start

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        result = []
         
        i = 0   
        for row in rows:
            data = {}
            data["variant_id"] = rows[i][0]
            data["product_id"] = rows[i][1]
            data["pkey"] = rows[i][2]
            data["inventory_id"] = rows[i][3]
            data["product_status"] = rows[i][4]
            data["product_active"] = rows[i][5]
            data["variant_status"] = rows[i][6]
            result.append(data)
            i = i+1

        return result
    except:
        print "Cannot fetch data."
    mydb.close()

def py_get_inventory_no_style_options(start=1):

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

def py_get_inventory_has_style_options(count_style=1, count_variant=3, start=1, variants_status='active'):

	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "SELECT  `variants`.`inventory_id`  , products.pkey as product_pkey, products.id , `variants`.`id`, \
		(SELECT count(style_type_id) FROM variant_style_options WHERE  `variants`.`id` =  variant_style_options.variant_id ) as countStyle, \
		(  SELECT count(id) FROM `variants` v WHERE v.`product_id` = products.id  AND v.status = '%s' ) as count_inventory,\
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
		WHERE `variants`.`deleted_at` is null \
        AND ( SELECT count( ve.product_id ) FROM product_verify_pendings ve WHERE `variants`.`product_id` = ve.product_id  ) = 0\
		AND `variants`.`status` = '%s' \
		AND `variants`.`stock_type` = 1 \
		AND `products`.`status` = 'publish' \
		AND `products`.`active` = 1\
		AND `products`.`has_variants` = 1\
		AND `products`.`deleted_at` is null\
        AND `products`.`pkey` not in (SELECT pkey FROM product_verify_pendings) \
		AND `collections`.`deleted_at` is null\
		AND `collections`.`parent_id` = 0\
		AND `brands`.`deleted_at` is null\
		GROUP BY `variants`.`id`\
		HAVING countStyle = %s AND  count_inventory = %s\
		ORDER BY count(`variants`.`id`) DESC LIMIT %s,1" % (variants_status, variants_status, count_style, count_variant, start)

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


def py_get_product_by_content_status_and_active(products_status='publish', products_active=1,  variants_status='active', start=1):
    
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT `variants`.`id`, `products`.`id`, `products`.`pkey`, variants.inventory_id as inventory_id \
      FROM `variants` \
      INNER JOIN `products` ON `products`.`id` = `variants`.`product_id` \
      INNER JOIN `product_collections` ON `product_collections`.`product_id` = `products`.`id` \
      INNER JOIN `collections` ON `collections`.`id` = `product_collections`.`collection_id` \
      INNER JOIN `apps_collections` ON `apps_collections`.`collection_id` = `collections`.`id` \
      INNER JOIN `brands` ON `brands`.`id` = `products`.`brand_id` \
      INNER JOIN `imported_materials` ON `imported_materials`.`inventory_id` = `variants`.`inventory_id`\
      WHERE ( SELECT count( vo.variant_id ) FROM variant_style_options vo WHERE `variants`.`id` = vo.variant_id  ) = 0\
      AND `products`.`status` = '%s'\
      AND `products`.`active` = '%s'\
      AND `products`.`deleted_at` is null\
      AND `products`.`pkey` not in (SELECT pkey FROM product_verify_pendings) \
      AND `variants`.`deleted_at` is null \
      AND `variants`.`status` = '%s' \
      AND `variants`.`stock_type` = 1 \
      AND `collections`.`deleted_at` is null\
      AND `collections`.`parent_id` = 0\
      AND `brands`.`deleted_at` is null \
      ORDER BY `variants`.`id` DESC\
      LIMIT %s,1" % (products_status, products_active, variants_status ,start)
    # return query  
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        result = []
         
        i = 0   
        for row in rows:
            data = {}
            data["variant_id"] = rows[i][0]
            data["product_id"] = rows[i][1]
            data["pkey"] = rows[i][2]
            data["inventory_id"] = rows[i][3]
            result.append(data)
            i = i+1

        return result
    except:
        print "Cannot fetch data."
    mydb.close()    


def py_get_inventory_has_style_options_has_installment(count_style=1, count_variant=3, start=1, variants_status='active', bank='ktc', periods='["3","6","10"]'):
    #periods = ["3","6","10"]
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT  `variants`.`inventory_id`  , products.pkey as product_pkey, products.id , `variants`.`id`,  `variants`.`id`, banks.id, banks.name,\
        (SELECT count(style_type_id) FROM variant_style_options WHERE  `variants`.`id` =  variant_style_options.variant_id ) as countStyle, \
        (  SELECT count(id) FROM `variants` v WHERE v.`product_id` = products.id  AND v.status = '%s' ) as count_inventory,\
        count(`variants`.`inventory_id`) as counts   \
        FROM `variants` \
        INNER JOIN variant_style_options ON variants.id = variant_style_options.variant_id \
        INNER JOIN style_options ON variant_style_options.style_option_id = style_options.id \
        INNER JOIN  product_payment_methods ON `variants`.`product_id` = `product_payment_methods`.`product_id`\
        INNER JOIN `products` ON `products`.`id` = `variants`.`product_id` \
        INNER JOIN `product_collections` ON `product_collections`.`product_id` = `products`.`id` \
        INNER JOIN `collections` ON `collections`.`id` = `product_collections`.`collection_id` \
        INNER JOIN `apps_collections` ON `apps_collections`.`collection_id` = `collections`.`id` \
        INNER JOIN `brands` ON `brands`.`id` = `products`.`brand_id` \
        INNER JOIN `imported_materials` ON `imported_materials`.`inventory_id` = `variants`.`inventory_id`\
        INNER JOIN bank_product ON bank_product.product_id = products.id\
        INNER JOIN banks ON bank_product.bank_id = banks.id\
        WHERE `variants`.`deleted_at` is null \
        AND `variants`.`status` = '%s' \
        AND `variants`.`stock_type` = 1 \
        AND `products`.`status` = 'publish' \
        AND `products`.`active` = 1\
        AND `products`.`has_variants` = 1\
        AND `products`.`deleted_at` is null\
        AND `collections`.`deleted_at` is null\
        AND `collections`.`parent_id` = 0\
        AND `brands`.`deleted_at` is null\
        AND banks.deleted_at is null\
        AND banks.abbreviation = '%s'\
        AND bank_product.periods LIKE '%s'\
        GROUP BY `variants`.`id`\
        HAVING countStyle = %s AND  count_inventory = %s\
        ORDER BY count(`variants`.`id`) DESC LIMIT %s,1" % (variants_status, variants_status, bank, "%" + periods + "%", count_style, count_variant, start)
     
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


def py_get_inventory_has_style_options_allow_cod(count_style=1, count_variant=3, start=1, variants_status='active', allow_cod=1):
    
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT  `variants`.`inventory_id`  , products.pkey as product_pkey, products.id , `variants`.`id`,  `variants`.`id`, \
        (SELECT count(style_type_id) FROM variant_style_options WHERE  `variants`.`id` =  variant_style_options.variant_id ) as countStyle, \
        (  SELECT count(id) FROM `variants` v WHERE v.`product_id` = products.id  AND v.status = '%s' ) as count_inventory,\
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
        WHERE `variants`.`deleted_at` is null \
        AND `variants`.`status` = '%s' \
        AND `variants`.`stock_type` = 1 \
        AND `products`.`status` = 'publish' \
        AND `products`.`active` = 1\
        AND `products`.`has_variants` = 1\
        AND `products`.`deleted_at` is null\
        AND `products`.`allow_cod` = %s\
        AND `collections`.`deleted_at` is null\
        AND `collections`.`parent_id` = 0\
        AND `brands`.`deleted_at` is null\
        AND imported_materials.inventory_id IS NOT NULL\
        GROUP BY `variants`.`id`\
        HAVING countStyle = %s AND  count_inventory = %s\
        ORDER BY count(`variants`.`id`) DESC LIMIT %s,1" % (variants_status, variants_status, allow_cod, count_style, count_variant, start)

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

def py_get_inventory_has_style_options_has_cs(count_style=1, count_variant=3, start=1, variants_status='active'):
    #periods = ["3","6","10"]
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT  `variants`.`inventory_id`  , products.pkey as product_pkey, products.id , `variants`.`id`,  `variants`.`id`, \
        (SELECT count(style_type_id) FROM variant_style_options WHERE  `variants`.`id` =  variant_style_options.variant_id ) as countStyle, \
        (  SELECT count(id) FROM `variants` v WHERE v.`product_id` = products.id  AND v.status = '%s' ) as count_inventory,\
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
        INNER JOIN product_payment_methods ON product_payment_methods.product_id = products.id\
        INNER JOIN payment_methods ON payment_methods.id = product_payment_methods.payment_method_id\
        WHERE `variants`.`deleted_at` is null \
        AND `variants`.`status` = '%s' \
        AND `variants`.`stock_type` = 1 \
        AND `products`.`status` = 'publish' \
        AND `products`.`active` = 1\
        AND `products`.`has_variants` = 1\
        AND `products`.`deleted_at` is null\
        AND `collections`.`deleted_at` is null\
        AND `collections`.`parent_id` = 0\
        AND `brands`.`deleted_at` is null\
        AND payment_methods.code LIKE 'CS'\
        GROUP BY `variants`.`id`\
        HAVING countStyle = %s AND  count_inventory = %s\
        ORDER BY count(`variants`.`id`) DESC LIMIT %s,1" % (variants_status, variants_status, count_style, count_variant, start)
     
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


def  py_get_2inventory_ids_same_collection_diff_product(start=0):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT collections.id, products.id, variants.inventory_id, collections.name, products.title \
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
    ORDER BY product_collections.collection_id  LIMIT %s,3" % start 
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        result = []
         
        i = 0   
        for row in rows:
            data = {}
            data["collection_id"] = rows[i][0]
            data["inventory_id"] = rows[i][2]
            data["collection_name"] = rows[i][3]
            data["product_title"] = rows[i][4]
            result.append(data)
            i = i+1

        return result
    except:
        print "Cannot fetch data."
    mydb.close()


def py_freebie_get_wow_product_pkey():

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

def convert_json_to_array(param_json):
    data  = json.loads(param_json)
    return data