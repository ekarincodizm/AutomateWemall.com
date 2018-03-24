
import sys, os, json
current_dir = os.path.dirname(os.path.realpath(__file__))
sys.path.append(current_dir + "/../../../../Python_Library")
import DatabaseData as db

file_path = current_dir + "/../../../../Resource/TestData/current_collection_data.json"

def save_current_collection_display(prefix):
    prefix = prefix.strip()
    sql = "SELECT  `id`, `name`, `is_category` FROM `collections` WHERE `deleted_at` is NULL AND `name` NOT LIKE '%s%%'"%( prefix )
    mydb = db.get_db()
    try:
        cursor = mydb.cursor()
        cursor.execute(sql)
        rows = cursor.fetchall()
        open(file_path, 'w').write(json.dumps(rows))
    except :
        raise Exception('Can not select collection')


    try:
        sql = "UPDATE `collections` SET `is_category` = '1'  WHERE `name` LIKE '%s%%'" % (prefix)
        cursor.execute(sql)

        #sql = "UPDATE `collections` SET `is_category` = '0'  WHERE `deleted_at` is NULL AND  `name` NOT LIKE '%s%%'" % (prefix)
        #cursor.execute(sql)

        mydb.commit()
    except:
        mydb.rollback()
        raise Exception('Can not update collection')

    mydb.close()

def restore_collection_display(prefix):
    prefix = prefix.strip()
    mydb = db.get_db()
    cursor = mydb.cursor()

    data = open(file_path, 'r').read()
    rows = json.loads(data)
    try:
        for id, name, status in rows:
            sql = "UPDATE `collections` SET `is_category` = '%s' WHERE `id` = '%s'"%(status, id)
            cursor.execute(sql)

        sql = "UPDATE `collections` SET `is_category` = '0'  WHERE `name` LIKE '%s%%'" % (prefix)
        cursor.execute(sql)

        mydb.commit()
    except:
        mydb.rollback()
        raise Exception('Can not update collection')
    mydb.close()
