import MySQLdb as db
import requests, json, urlparse
import os.path

from ConnectDB import *
from robot.libraries.BuiltIn import BuiltIn

def py_api_apply_coupon(customer_ref_id=None, customer_type=None, code=None):
	if customer_ref_id is None :
		return None

	mock_data = {"customer_ref_id":"%s" % str(customer_ref_id),"customer_type":"%s" % str(customer_type),"code":"%s" % str(code)}
	api_url = pcms_url + "/api/45311375168544/cart/apply-coupon"
	resp = requests.post(url=api_url, data=mock_data)
	data = json.loads(resp.text)
	return data

def py_get_promotion_id(promotion_name, campaign_name):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT promotions.id, promotions.name FROM promotions \
    INNER JOIN campaigns ON promotions.campaign_id = campaigns.id \
    WHERE campaigns.name = '%s' AND promotions.name = '%s' " % (promotion_name, campaign_name)

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows[0]
    except Exception, e:
        BuiltIn().log_to_console('DB exception: %s' % e)
        BuiltIn().log_to_console('DB exception: %s' % e)
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

def remove_promotion(promotion_name):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    try:
        query_promotion_code_log = "DELETE FROM promotion_code_logs \
        WHERE promotion_code_logs.promotion_code_id IN (SELECT promotion_codes.id \
            FROM campaigns, promotions, promotion_codes \
            WHERE promotions.name = '%s' \
            AND campaigns.id = promotions.campaign_id \
            AND promotions.id = promotion_codes.promotion_id) \
        " % promotion_name
        cursor = mydb.cursor()
        result = cursor.execute(query_promotion_code_log)
        mydb.commit()
        try:
            query_promotion_code = "DELETE FROM promotion_codes \
            WHERE promotion_codes.promotion_id IN (SELECT promotions.id \
                FROM campaigns, promotions \
                WHERE promotions.name = '%s' \
                AND campaigns.id = promotions.campaign_id) \
            " % promotion_name
            cursor = mydb.cursor()
            result = cursor.execute(query_promotion_code)
            mydb.commit()
            try:
                query_promotion = "DELETE FROM promotions \
                WHERE promotions.name = '%s' \
                " % promotion_name
                cursor = mydb.cursor()
                result = cursor.execute(query_promotion)
                mydb.commit()

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

def py_remove_promotion_code_logs(promotion_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    try:
        query_promotion_code_log = "DELETE FROM promotion_code_logs \
        WHERE promotion_code_logs.promotion_code_id IN (SELECT promotion_codes.id \
            FROM campaigns, promotions, promotion_codes \
            WHERE promotions.id = '%s' \
            AND campaigns.id = promotions.campaign_id \
            AND promotions.id = promotion_codes.promotion_id) \
        " % promotion_id
        cursor = mydb.cursor()
        result = cursor.execute(query_promotion_code_log)
        mydb.commit()
    except:
        mydb.rollback()
        print "Cannot delete promotion code logs"

    mydb.close()


def py_remove_promotion_codes(promotion_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    try:
        query_promotion_code = "DELETE FROM promotion_codes \
        WHERE promotion_codes.promotion_id IN (SELECT promotions.id \
            FROM campaigns, promotions \
            WHERE promotions.id = '%s' \
            AND campaigns.id = promotions.campaign_id) \
        " % promotion_id
        cursor = mydb.cursor()
        result = cursor.execute(query_promotion_code_log)
        mydb.commit()
    except:
        mydb.rollback()
        print "Cannot delete promotion codes"

    mydb.close()


def py_remove_promotions(promotion_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    try:
        query_promotion = "DELETE FROM promotions \
        WHERE promotions.id = '%s' \
        " % promotion_id
        cursor = mydb.cursor()
        result = cursor.execute(query_promotion)
        mydb.commit()
    except:
        mydb.rollback()
        print "Cannot delete promotion"

    mydb.close()


def remove_promotion_by_id(promotion_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    try:
        query_promotion_code_log = "DELETE FROM promotion_code_logs \
        WHERE promotion_code_logs.promotion_code_id IN (SELECT promotion_codes.id \
            FROM campaigns, promotions, promotion_codes \
            WHERE promotions.id = '%s' \
            AND campaigns.id = promotions.campaign_id \
            AND promotions.id = promotion_codes.promotion_id) \
        " % promotion_id
        cursor = mydb.cursor()
        result = cursor.execute(query_promotion_code_log)
        mydb.commit()
        try:
            query_promotion_code = "DELETE FROM promotion_codes \
            WHERE promotion_codes.promotion_id IN (SELECT promotions.id \
                FROM campaigns, promotions \
                WHERE promotions.id = '%s' \
                AND campaigns.id = promotions.campaign_id) \
            " % promotion_id
            cursor = mydb.cursor()
            result = cursor.execute(query_promotion_code)
            mydb.commit()
            try:
                query_promotion = "DELETE FROM promotions \
                WHERE promotions.id = '%s' \
                " % promotion_id
                cursor = mydb.cursor()
                result = cursor.execute(query_promotion)
                mydb.commit()

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

def py_validate_product_pkey_in_excluded_product_table(promotion_id, product_pkey_list):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    product_pkey_list_string = ','.join(product_pkey_list)
    product_pkey_list_count = len(product_pkey_list)
    try:
        query_pkey = "SELECT count(DISTINCT `pkey`) FROM `promotion_display_exclude_products` \
            WHERE promotion_id = '%s' \
            AND `pkey` IN (%s)" \
            % (promotion_id, product_pkey_list_string)
        BuiltIn().log_to_console(query_pkey)

        cursor = mydb.cursor()
        cursor.execute(query_pkey)
        pkeys = cursor.fetchone()
        count_pkey = pkeys[0]

        if product_pkey_list_count != pkeys[0]:
           raise Exception('Assert ')

    except Exception, e:
        count_pkey = 0
        mydb.rollback()
        BuiltIn().log_to_console('DB exception: %s' % e)

    mydb.close()
    return count_pkey

def py_get_promotion_display_on_web_text(promotion_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT lang, title_text, code_text, discount_text \
    FROM `promotion_display_translates` \
    WHERE promotion_id = '%s' " % (promotion_id)

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        data = {}
        for row in rows:
            data[row[0]] = {
            'title_text': row[1],
            'code_text': row[2],
            'discount_text': row[3],
            }
        return data
    except Exception, e:
        BuiltIn().log_to_console('DB exception: %s' % e)
        BuiltIn().log_to_console('DB exception: %s' % e)
        print "Cannot fetch data."
    mydb.close()


