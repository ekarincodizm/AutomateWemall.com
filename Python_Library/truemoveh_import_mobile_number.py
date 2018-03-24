import MySQLdb as db
import sys

from ConnectDB import *
from robot.libraries.BuiltIn import BuiltIn

def get_db():
    return db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

def db_fetchone(query):
    mydb = get_db()
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        mydb.close()
        return rows
    except:
        mydb.close()
        print "Cannot fetch data."

def db_fetchone_as_dictionary(query):
    mydb = get_db()
    cursor = mydb.cursor(db.cursors.DictCursor)
    try:
        cursor.execute(query)
        rows = cursor.fetchone()
        mydb.close()
        return rows
    except:
        mydb.close()
        print "Cannot fetch data."

def db_fetchall(query):
    mydb = get_db()
    cursor = mydb.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        mydb.close()
        return rows
    except:
        mydb.close()
        print "Cannot fetch data."

def get_proposition_by_id(proposition_id):
    query = "SELECT * \
        FROM truemoveh_propositions \
        WHERE id = '%s' \
        LIMIT 1" % proposition_id

    return db_fetchone(query)

def get_proposition_by_nascode(nas_code):
    query = "SELECT id, nas_code, parent_id \
        FROM truemoveh_propositions \
        WHERE nas_code = '%s' \
        LIMIT 1" % nas_code

    return db_fetchone(query)

def add_proposition(proposition):
    columns = []
    values = []
    for key, value in proposition.iteritems():
        columns.append(key)
        values.append(value)

    query = "INSERT INTO truemoveh_propositions \
        (%s) \
        VALUES ('%s') " % (", ".join(columns), "', '".join(values))

    mydb = get_db()
    insert_id = 0
    try:
        cursor = mydb.cursor()
        cursor.execute(query)
        insert_id = cursor.lastrowid
        mydb.commit()
    except:
        mydb.rollback()
        sys.stderr.write("insert proposition fail")

    return insert_id

def add_price_plan(price_plan_code, sub_description, long_description, recommend, description='Package ROBOT'):
    query = "INSERT INTO truemoveh_price_plans \
        (pp_code, sub_description, description, long_description, status, recommend, created_at, updated_at) \
        VALUES ('%s', '%s', '%s', '%s', 'Y', '%s', now(), now())" \
        % (price_plan_code, sub_description, description, long_description, recommend)

    mydb = get_db()
    insert_id = 0
    try:
        cursor = mydb.cursor()
        cursor.execute(query)
        insert_id = cursor.lastrowid
        mydb.commit()
    except:
        mydb.rollback()
        sys.stderr.write("insert price plan fail")

    return insert_id

def get_price_plan_by_price_plan_code(price_plan_code):
    query = "SELECT id, pp_code \
        FROM truemoveh_price_plans \
        WHERE pp_code = '%s' \
        LIMIT 1" % price_plan_code

    return db_fetchone(query)

def remove_price_plan_by_id(price_plan_id):
    query = "DELETE FROM truemoveh_price_plans \
        WHERE id = '%s'" % price_plan_id

    mydb = get_db()
    try:
        cursor = mydb.cursor()
        result = cursor.execute(query)
        mydb.commit()
    except:
        mydb.rollback()
        sys.stderr.write("remove proposition fail")

    return result

def add_proposition_maps(proposition_id, price_plan_id):
    query = "INSERT INTO truemoveh_proposition_maps \
        (proposition_id, price_plan_id, created_at, updated_at) \
        VALUES ('%s', '%s', now(), now())" \
        % (proposition_id, price_plan_id)

    mydb = get_db()
    insert_id = 0
    try:
        cursor = mydb.cursor()
        cursor.execute(query)
        insert_id = cursor.lastrowid
        mydb.commit()
    except:
        mydb.rollback()
        sys.stderr.write("insert price plan fail")

    return insert_id

def remove_proposition_maps_by_proposition_id(proposition_id):
    query = "DELETE FROM truemoveh_proposition_maps \
        WHERE proposition_id = '%s'" % proposition_id

    mydb = get_db()
    try:
        cursor = mydb.cursor()
        result = cursor.execute(query)
        mydb.commit()
    except:
        mydb.rollback()
        sys.stderr.write("remove proposition maps fail")

    return result

def remove_proposition_maps_by_price_plan_id(price_plan_id):
    query = "DELETE FROM truemoveh_price_plans \
        WHERE price_plan_id = '%s'" % price_plan_id

    mydb = get_db()
    result = '';
    try:
        cursor = mydb.cursor()
        result = cursor.execute(query)
        mydb.commit()
    except:
        mydb.rollback()
        sys.stderr.write("remove proposition maps fail")

    return result

def get_mobile_by_mobile_number(mobile_number):
    query = "SELECT mobiles.*, patterns.pattern, types.name as type_name \
        FROM truemoveh_mobiles AS mobiles \
        INNER JOIN truemoveh_mobile_number_types AS types ON (mobiles.mobile_type = types.id) \
        LEFT JOIN truemoveh_mobile_patterns AS patterns ON (mobiles.mobile_pattern_id = patterns.id)  \
        WHERE mobiles.mobile = '%s' \
        LIMIT 1" % mobile_number

    return db_fetchone_as_dictionary(query)

def remove_proposition_by_nascode(nas_code):
    query = "DELETE FROM truemoveh_propositions \
        WHERE nas_code = '%s'" % nas_code

    mydb = get_db()
    try:
        cursor = mydb.cursor()
        result = cursor.execute(query)
        mydb.commit()
    except:
        mydb.rollback()
        sys.stderr.write("remove proposition fail")

    return result

def remove_mobile_by_number(mobile_number):
    query = "DELETE FROM truemoveh_mobiles \
        WHERE mobile = '%s'" % mobile_number

    mydb = get_db()
    try:
        cursor = mydb.cursor()
        result = cursor.execute(query)
        mydb.commit()
    except:
        mydb.rollback()
        sys.stderr.write("remove mobile fail")

    return result

def get_cart_mobile_number(mobile_number, package_id):
    query = "SELECT url_key, mobile_number, price_plan_id FROM truemoveh_cart_mobile_numbers \
        WHERE mobile_number = '%s' AND price_plan_id = '%s' ORDER BY `id` DESC LIMIT 1" \
        % (mobile_number, package_id)
    return db_fetchone(query)

def get_mobile_type():
    query = "SELECT name FROM truemoveh_mobile_number_types \
        Order By id ASC"

    return db_fetchall(query)
