
import os, sys, xlrd ,filecmp

current_dir = os.path.dirname(os.path.realpath(__file__))

sys.path.append(current_dir)

import MySQLdb as db
import ConnectDB as dbConfig

def get_db_connection():
    mydb = db.connect(host=dbConfig.dbhost, user=dbConfig.dbuser, passwd=dbConfig.dbpass, db=dbConfig.dbname, charset=dbConfig.dbcharset, local_infile=1)
    return mydb

def close_db_connection(mydb):
    mydb.close()

def read_excel_to_list(path):
    workbook = xlrd.open_workbook(path)
    head = [];
    rows = []
    for sheet in workbook.sheets():
        number_of_rows = sheet.nrows
        number_of_columns = sheet.ncols
        for row in range(0, number_of_rows):
            values = []
            for col in range(number_of_columns):
                value = (sheet.cell(row, col).value)
                try:
                    value = str(int(value))
                except ValueError:
                    pass
                finally:
                    value = value.replace('"', '""')
                    values.append(value)
            if row == 0:
                head = values
            else:
                rows.append(values)
        break

    return head, rows

def build_query_insert_string(head, rows, table_name):
    query_str_list = []
    for row in rows:
        values_str = "";
        cols = []
        for col in row:
            if col != "NULL":
                col = "\"%s\""%(col)
            values_str += ','+col
            cols.append(col)
        values_str = ','.join(cols)

        sql = "INSERT INTO %s ( `%s` ) VALUES ( %s )"%(table_name, '`,`'.join(head), values_str)
        query_str_list.append(sql)

    return query_str_list

def insert_data(sql):
    mydb = get_db_connection()
    curs = mydb.cursor()
    curs.execute(sql)
    insert_id = mydb.insert_id()
    mydb.commit()
    close_db_connection(mydb)
    return insert_id

def delete_data(sql):
    mydb = get_db_connection()
    curs = mydb.cursor()
    curs.execute(sql)
    mydb.commit()
    close_db_connection(mydb)

def insert_order_all():
    order_template = current_dir + '/../Resources/Template/order_template.xlsx'
    order_shipment_template = current_dir + '/../Resources/Template/order_shipment_template.xlsx'
    order_shipment_items_template = current_dir + '/../Resources/Template/order_shipment_items_template.xlsx'
    order_billings_template = current_dir + '/../Resources/Template/order_billings_template.xlsx'
    order_promotion_logs_template = current_dir + '/../Resources/Template/order_promotion_logs_template.xlsx'

    order_id = insert_order(order_template)
    order_shipment_id = insert_shipment(order_shipment_template, order_id)
    insert_shipment_items(order_shipment_items_template, order_id, order_shipment_id)
    insert_billing(order_billings_template, order_id)
    insert_order_promotion_logs(order_promotion_logs_template, order_id)
    return order_id

def insert_order(order_template):
    head, rows = read_excel_to_list(order_template)
    queries = build_query_insert_string(head, rows, 'orders')
    order_id = insert_data(queries[0])
    return order_id

def insert_shipment(order_shipment_template, order_id):
    head, rows = read_excel_to_list(order_shipment_template)
    rows = replace_value_column(rows, "{order_id}", order_id)
    query = build_query_insert_string(head, rows, 'order_shipments')
    order_shipment_id = insert_data(query[0])
    return order_shipment_id

def insert_shipment_items(order_shipment_items_template, order_id, shipment_id):
    head, rows = read_excel_to_list(order_shipment_items_template)
    rows = replace_value_column(rows, "{order_id}", order_id)
    rows = replace_value_column(rows, "{shipment_id}", shipment_id)
    query = build_query_insert_string(head, rows, 'order_shipment_items')
    for sql in query:
        insert_data(sql)

def insert_billing(order_billings_template, order_id):
    head, rows = read_excel_to_list(order_billings_template)
    rows = replace_value_column(rows, "{order_id}", order_id)
    query = build_query_insert_string(head, rows, 'order_billings')
    order_billing_id = insert_data(query[0])
    return order_billing_id

def insert_order_promotion_logs(order_promotion_logs_template, order_id):
    head, rows = read_excel_to_list(order_promotion_logs_template)
    rows = replace_value_column(rows, "{order_id}", order_id)
    query = build_query_insert_string(head, rows, 'order_promotion_logs')
    for sql in query:
         insert_data(sql)

def delete_order(order_id):
    delete_sql_list = []
    sql = "DELETE FROM order_promotion_logs WHERE order_id = %s"%(order_id)
    delete_sql_list.append(sql)

    sql = "DELETE FROM order_billings WHERE order_id = %s"%(order_id)
    delete_sql_list.append(sql)

    sql = "DELETE FROM order_shipment_items WHERE order_id = %s"%(order_id)
    delete_sql_list.append(sql)

    sql = "DELETE FROM order_shipments WHERE order_id = %s"%(order_id)
    delete_sql_list.append(sql)

    sql = "DELETE FROM together_orders WHERE pcms_order_id = %s"%(order_id)
    delete_sql_list.append(sql)

    sql = "DELETE FROM together_order_items WHERE pcms_order_id = %s"%(order_id)
    delete_sql_list.append(sql)

    sql = "DELETE FROM orders WHERE id = %s"%(order_id)
    delete_sql_list.append(sql)
    for sql in delete_sql_list:
        delete_data(sql)

def replace_value_column(rows, key, value):
    i = 0
    for row in rows:
        j = 0
        for col in row:
            if col == key:
                rows[i][j] = value
            j += 1
        i += 1
    return rows

def check_dif_file(file1,file2):
    return filecmp.cmp(file1,file2)

