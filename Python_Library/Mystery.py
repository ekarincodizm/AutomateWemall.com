import random
import json
import MySQLdb as db

from ConnectDB import *

def py_get_predition_list(prediton_type="color", status="Y" ) :

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)    
    query = "SELECT id, name_th, img_thumb, img_thumb_hover, short_desc_th, long_desc_th FROM `prediction` WHERE \
prediction.type = '%s' AND prediction.status = '%s' \
ORDER BY prediction.sort_by ASC " % (prediton_type, status)
    cursor = mydb.cursor()

    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        data = []
        for index in range(len(rows)):
            val = {}
            val['id'] = rows[index][0]
            val['name_th'] = rows[index][1]
            val['img_thumb'] = rows[index][2]
            val['img_thumb_hover'] = rows[index][3]
            val['short_desc_th'] = rows[index][4]
            val['long_desc_th'] = rows[index][5]
            data.append(val)
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def py_update_prediction_status(prediton_type='color', status='Y') :

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try : 
        query = "UPDATE prediction SET status = '%s' WHERE type = '%s' " % (status, prediton_type)
        result = cursor.execute(query)
        mydb.commit()
        return True
    except: 
        mydb.rollback()
        return False

def convert_json_to_array(param_json):
    data  = json.loads(param_json)
    return data

def py_get_id_by_prefix(prefix):

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT `edms`.`id` \
    FROM `edms` \
    WHERE `edms`.`prefix` = '%s'" % prefix

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        row = cursor.fetchone()
        data = {}
        data["id"] = row[0]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def py_get_secret_code():

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT `angpao_codes`.`code` \
    FROM `angpao_codes` \
    WHERE `angpao_codes`.`status` = '1'\
    AND `angpao_codes`.`deleted_at` IS NULL\
    LIMIT 1"

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        row = cursor.fetchone()
        data = {}
        data["code"] = row[0]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()


def py_delete_automate_data_on_angpao_members(email=None):
    if email is None : 
        return None 
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
    cursor = mydb.cursor()

    try : 
        query = "DELETE FROM angpao_members WHERE email LIKE '%s'" % email
        result = cursor.execute(query)
        mydb.commit()
        return True
    except: 
        mydb.rollback()
        return False


def py_get_predition_item(prediton_type="color", status="Y" ) :

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)    
    query = "SELECT id, name_th, img_thumb, img_thumb_hover, short_desc_th, long_desc_th FROM `prediction` WHERE \
prediction.type = '%s' AND prediction.status = '%s' \
ORDER BY prediction.sort_by DESC LIMIT 1" % (prediton_type, status)
    cursor = mydb.cursor()
    # return query
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        data = {}
        data['id'] = rows[0]
        data['name_th'] = rows[1]
        data['img_thumb'] = rows[2]
        data['img_thumb_hover'] = rows[3]
        data['short_desc_th'] = rows[4]
        data['long_desc_th'] = rows[5]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()


def py_get_predition_sub_by_id(prediction_id) :

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)    
    query = "SELECT img_main  FROM `prediction_sub` WHERE `prediction_id` = %s" % (prediction_id)
    cursor = mydb.cursor()

    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        data = []
        for index in range(len(rows)):
            val = {}
            val['img_main'] = rows[index][0]
            data.append(val)
        return data
    except:
        print "Cannot fetch data."
    mydb.close()

def py_get_detail_coupon(email,firstname,lastname,mobile,gender):

    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "SELECT `angpao_codes`.`status` as status FROM `angpao_members` \
                 LEFT JOIN `angpao_codes` ON (`angpao_members`.`code` = `angpao_codes`.`code`) \
                 WHERE `angpao_members`.`email` = '%s' \
                 AND `angpao_members`.`firstname` = '%s' \
                 AND `angpao_members`.`lastname` = '%s' \
                 AND `angpao_members`.`mobile` = '%s' \
                 AND `angpao_members`.`birthdate` = '1992-01-01' \
                 AND `angpao_members`.`gender` = '%s' \
                 AND `angpao_members`.`prediction_id` = 1 \
                 AND `angpao_members`.`campaign` = 1 \
                 AND `angpao_members`.`sent_email` = 1 \
                 AND DATE(`angpao_members`.`created_at`) = CURDATE() \
                 AND DATE(`angpao_codes`.`updated_at`) = CURDATE()" % (email,firstname,lastname,mobile,gender)

    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        row = cursor.fetchone()
        data = {}
        data["status"] = row[0]
        return data
    except:
        print "Cannot fetch data."
    mydb.close()
