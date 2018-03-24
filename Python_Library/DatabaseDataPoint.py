import MySQLdb as db

from ConnectDBPoint import *
import socket
import urllib
import urllib2
import xlrd
import csv
import product
import datetime

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

def get_admin(id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT * \
    FROM admin \
    WHERE `id` = '%s' \
    AND deleted_at IS NULL \
    " % id

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows
    except:
        print "Cannot fetch data."
    mydb.close()

def get_token_by_api_key_and_api_secret(api_key, api_secret):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT api_token \
    FROM merchant \
    WHERE `api_key` = '%s' \
    AND `api_secret` = '%s' \
    AND deleted_at IS NULL \
    " % (api_key, api_secret)

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows[0]
    except:
        print "Cannot fetch data."
    mydb.close()

def get_api_key_and_api_secret_by_name(name):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT api_key, api_secret \
    FROM merchant \
    WHERE `name` = '%s' \
    AND deleted_at IS NULL \
    " % (name)

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows
    except:
        print "Cannot fetch data."
    mydb.close()

def get_api_key_and_api_secret():
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT api_key, api_secret \
    FROM merchant \
    WHERE deleted_at IS NULL \
    LIMIT 1" 

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows
    except:
        print "Cannot fetch data."
    mydb.close()

def check_user_token_exists(user_id ,token , partner_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT COUNT(id) \
    FROM user_token \
    WHERE `user_id` = '%s' \
    AND `token` = '%s' \
    AND `partner_id` = '%s' \
    " % (user_id , token , partner_id)

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows[0]
    except:
        print "Cannot fetch data."
    mydb.close()

def get_partner():
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT id , name \
    FROM partner \
    LIMIT 1"

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows
    except:
        print "Cannot fetch data."
    mydb.close()

def get_return_point(user_id,request_id,merchant_id,partner_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT point, status \
    FROM return_point \
    WHERE `user_id` = '%s' \
    AND `request_id` = '%s' \
    AND `merchant_id` = '%s' \
    AND `partner_id` = '%s' \
    LIMIT 1" \
    % (user_id ,request_id, merchant_id, partner_id)

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows
    except:
        print "Cannot fetch data."
    mydb.close()


def get_ref_transaction_redeem_point(user_id,request_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT ref_transaction \
    FROM redeem_point \
    WHERE `user_id` = '%s' \
            AND `request_id` = '%s' \
    LIMIT 1" \
    % (user_id , request_id)

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows[0]
    except:
        print "Cannot fetch data."
    mydb.close()

def insert_point_campaign(merchantID,campaign_name,campaign_ratio):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    create_time = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    insert_campaign = "INSERT INTO campaign (merchant_id,name,ratio,active_status,created_date,active_date) \
    VALUES ('%s', '%s', '%s', 'Y', '%s', '%s')" \
    % (merchantID, campaign_name, campaign_ratio, create_time, create_time)

    try:
        cursor = mydb.cursor()
        cursor.execute(insert_campaign)
        mydb.commit()

    except:
        mydb.rollback()
        print "Cannot insert campaign data."

    mydb.close()

def delete_point_campaign(campaign_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    delete_campaign = "DELETE FROM campaign WHERE id = '%s'" \
    % (campaign_id)

    try:
        cursor = mydb.cursor()
        cursor.execute(delete_campaign)
        mydb.commit()

    except:
        mydb.rollback()
        print "Cannot delete campaign data."

    mydb.close()


def get_campaign_id(merchant_id,campaign_name,campaign_ratio):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT id \
    FROM campaign \
    WHERE `merchant_id` = '%s' \
    AND `name` = '%s' \
    AND `ratio` = '%s'" \
    % (merchant_id, campaign_name, campaign_ratio)

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        return rows
    except:
        print "Cannot fetch data."

    mydb.close()

def insert_point_campaign_keys(campaign_id,inventory_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    insert_campaign_keys = "INSERT INTO campaign_keys (campaign_id,`key`) \
    VALUES ('%d', '%s')" \
    % (campaign_id, inventory_id)

    try:
        cursor = mydb.cursor()
        cursor.execute(insert_campaign_keys)
        mydb.commit()

    except:
        mydb.rollback()
        print "Cannot insert campagin key data."

    mydb.close()

def delete_point_campaign_key(campaign_id):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    delete_campaign_key_id = "DELETE FROM campaign_keys WHERE `key` = '%s'" \
    % (campaign_id)

    try:
        cursor = mydb.cursor()
        cursor.execute(delete_campaign_key_id)
        mydb.commit()

    except:
        mydb.rollback()
        print "Cannot delete campaign data."

    mydb.close()
