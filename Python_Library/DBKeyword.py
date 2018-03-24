import sys
import traceback
from util.Logger import Logger
import os 
os.environ["NLS_LANG"] = ".UTF8" 

from common.DBHandler import DBConfig
from common.DBFactory import DBFactory
'''
con = cx_Oracle.connect('QA_Weerawat', 'p@$$w0rd',  cx_Oracle.makedsn('10.224.101.1', 2992, 'pstg'))
cur = con.cursor()
if cur.execute('select * from BPAY.CF_COMPANY'):
    for row in cur:
        print row
else:
    print "facepalm"
con.close()
'''
def connect_db(dbcfg, dbtype = "oracle"):
        
        config = DBConfig.createFromDict(dbcfg)
        db = DBFactory.createDBConnection(config, dbtype.lower())
        db.connect()
        return db
        
        
def execute_sql_keep_connection(db, sql):
    try:
        Logger.logDebug("excute_db: " + sql)
        affect = db.execute(sql)
        db.commit()
        return affect
    except:
        traceback.print_exc(file=sys.stdout)
        db.close()
        raise

def query_sql_keep_connection(db, sql):
    try:
        Logger.logDebug("query_db: " + sql)
        rs = db.query(sql)
        return rs
    except:
        traceback.print_exc(file=sys.stdout)
        db.close()
        raise

def get_resultset_count(rs):
    return rs.getCount()

def get_field_from_resultset(rs, rowid, field_name):
    data = rs.getField(rowid, field_name)
    return data    

def close_db(db):
    db.close()
    

def execute_sql(sql, dbcfg, dbtype = "oracle"):
    try:
        db = connect_db(dbcfg, dbtype)
        Logger.logDebug("execute_sql: " + sql)
        affect = db.execute(sql)
        db.commit()
        return affect
    except:
        traceback.print_exc(file=sys.stdout)
        raise 
    finally:
        db.close()
    

def query_db(sql, rowid, field_name, dbcfg, dbtype = "oracle"):
    try:
        db = connect_db(dbcfg, dbtype)
        rs = query_sql_keep_connection(db,sql)
        result = get_field_from_resultset(rs, int(rowid), field_name)
        return result
    except:
        traceback.print_exc(file=sys.stdout)
        raise 
    finally:
        db.close()


#sql = "DELETE from PAYMENT.PAYMENTID where PAYMENT.PAYMENTID.PAYMENT_ID >= 1000000";

#print execute_sql(sql, host="10.224.101.1", port=2992, sid="pstg", username="Qa_Weerawat", password="dbpa$$w0rd2")

#db = connect_db(host="10.224.101.1", port=2992, sid="pstg", username="Qa_Weerawat", password="dbpa$$w0rd2")
#rs =query_db(db, "select * from BPAY.CF_BILL_INFO  where rownum <= 1")
#print get_from_resultset(rs, 0, "BILL_CODE")