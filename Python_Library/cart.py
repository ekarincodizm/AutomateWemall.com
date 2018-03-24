import MySQLdb as db
from ConnectDB import *  
from robot.libraries.BuiltIn import BuiltIn

def clear_cart_by_email(customer_email):
    mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

    try:
        query_cart = "SELECT id FROM carts WHERE customer_email = '%s' and deleted_at is null " % customer_email
        cursor = mydb.cursor()
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
    except Exception, e:
        mydb.rollback()
        BuiltIn().log_to_console('Cannot clear cart by customer email. %s' % e)

    mydb.close()
