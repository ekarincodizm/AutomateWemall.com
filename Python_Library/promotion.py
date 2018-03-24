import MySQLdb as db
from ConnectDB import *

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

def promotion_expire(promotion_name):
   mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
   
   query = "UPDATE promotions \
   SET `end_date` = `start_date` \
   WHERE `name` = '%s' " % (promotion_name)
   cursor = mydb.cursor()
   try:
        cursor.execute(query)
        mydb.commit()
   except:
        mydb.rollback()
        print "update promotion Period by promotion_id fail"
   mydb.close()

def py_set_promotion_expire(promotion_id=None) : 
    BuiltIn().log_to_console("promotion_id = " + str(promotion_id))
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "UPDATE `promotions` \
        SET `start_date` = '2015-01-01 00:00:00', `end_date` = '2015-01-02 00:00:00' \
        WHERE `id` = %s \
        " % promotion_id
    BuiltIn().log_to_console("Set promotion expire = " + query)
    cursor = mydb.cursor()
    r = cursor.execute(query)
    mydb.commit()
    
    mydb.close()
    return r  
def set_promotion_deactivate(promotion_id=None) :
    
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    query = "UPDATE `promotions` \
        SET `status` = 'deactivate' \
        WHERE `id` = %s \
        " % promotion_id

    BuiltIn().log_to_console("set promotion deactivate = " + query)
    cursor = mydb.cursor()
    r = cursor.execute(query)
    mydb.commit()
    
    mydb.close()
    return r  


#r = set_promotion_expire(9028)
#print r