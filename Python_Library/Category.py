import MySQLdb as db

from ConnectDB import *
import socket
import urllib
import urllib2
import xlrd
import csv
import product


def get_exported_products_under_merchant_categories_data_csv(csv_filename):

    COLUMN_CATEGORY_KEY                 = 0
    COLUMN_PRODUCT_KEY                  = 1
    COLUMN_CATEGORY_NAME_TRAIL          = 2
    COLUMN_PRODUCT_NAME                 = 3

    COLUMN_EXPORTED_CATEGORY_KEY        = 4
    COLUMN_EXPORTED_CATEGORY_NAME_TRAIL = 5
    COLUMN_MERCHANT_OR_ALIAS_CODE       = 6

    COLUMN_MERCHANT_OR_ALIAS_NAME       = 7
    COLUMN_PRODUCT_STATUS               = 8
    COLUMN_STOCK                        = 9

    try:
        export_data_dict_list = list()
        if not csv_filename:
            csv_filename = "../Resource/TestData/Category/csv_file/merchant_categories_export_product_under_category.csv"
        with open(csv_filename, 'rb') as csvfile:
            csvreader = csv.reader(csvfile, delimiter=',')
            count = sum(1 for _ in csvreader)
            if count < 2:
                raise ValueError('The exported file contains no data.')
            csvfile.seek(0)
            csvreader = csv.reader(csvfile, delimiter=',')

            
            for row in csvreader:

                print "row[COLUMN_CATEGORY_KEY].strip():%s" %row[COLUMN_CATEGORY_KEY].strip()
                print "row:%s" %row

                row_dict = dict()
                
                category_key = row[COLUMN_CATEGORY_KEY].strip()
                product_key = row[COLUMN_PRODUCT_KEY].strip()

                category_name_trail = row[COLUMN_CATEGORY_NAME_TRAIL].strip()
                product_name = row[COLUMN_PRODUCT_NAME].strip()
                exported_category_key = row[COLUMN_EXPORTED_CATEGORY_KEY].strip()
                exported_category_name_trail = row[COLUMN_EXPORTED_CATEGORY_NAME_TRAIL].strip()
                merchant_or_alias_code = row[COLUMN_MERCHANT_OR_ALIAS_CODE].strip()
                merchant_or_alias_name = row[COLUMN_MERCHANT_OR_ALIAS_NAME].strip()
                product_status = row[COLUMN_PRODUCT_STATUS].strip()
                stock = row[COLUMN_STOCK].strip()

                row_dict['category_key'] = unicode(category_key, 'utf-8-sig').strip()
                row_dict['product_key'] = unicode(product_key, 'utf-8-sig').strip()
                row_dict['category_name_trail'] = unicode(category_name_trail, 'utf-8-sig').strip()
                row_dict['product_name'] = unicode(product_name, 'utf-8-sig').strip()
                row_dict['exported_category_key'] = unicode(exported_category_key, 'utf-8-sig').strip()
                row_dict['exported_category_name_trail'] = unicode(exported_category_name_trail, 'utf-8-sig').strip()
                row_dict['merchant_or_alias_code'] = unicode(merchant_or_alias_code, 'utf-8-sig').strip()
                row_dict['merchant_or_alias_name'] = unicode(merchant_or_alias_name, 'utf-8-sig').strip()
                row_dict['product_status'] = unicode(product_status, 'utf-8-sig').strip()
                row_dict['stock'] = unicode(stock, 'utf-8-sig').strip()

                export_data_dict_list.append(row_dict)
        return export_data_dict_list
    except Exception as e:
        print e
        print "Verify exported products from merchant categories failed."
        return "False"