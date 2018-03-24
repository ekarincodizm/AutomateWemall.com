#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys
import traceback
import difflib
import json
from configparser import ConfigParser

def compare_with_baseline (baselineFile, act):
    try:
        f1 = open(baselineFile)
        baselineContent = f1.readlines()
        actualContent = act.splitlines()
        diff = difflib.ndiff(baselineContent, actualContent)
        changes = [l for l in diff if l.startswith('+ ') or l.startswith('- ')]
        if (len(changes)>0):
            print "> compare_with_baseline found diff result"
            for c in changes:
                print("> %s" % c)
            return False
        return True 
    except:
        traceback.print_exc(file=sys.stdout)
        raise
    finally:
        f1.close()
    return ""


def compare_files (file1, file2):
    try:
        f1 = open(file1)
        f2 = open(file2)
        file1Content = open(file1).readlines()
        file2Content = open(file2).readlines()
        diff = difflib.ndiff(file1Content, file2Content)
        changes = [l for l in diff if l.startswith('+ ') or l.startswith('- ')]
        if (len(changes)>0):
            print "> compare_with_baseline found diff result"
            for c in changes:
                print("> %s" % c)
            return False
        return True
    except: 
        traceback.print_exc(file=sys.stdout)
        raise
    finally:
        f1.close()
        f2.close()

def write_to_new_file ( filename, content):
    try:
        f1 = open(filename, "w")
        f1.write(content)
    except: 
        traceback.print_exc(file=sys.stdout)
        raise
    finally:
        f1.close()
    return ""

def compare_json_files_with_ignored_keys (file1, file2, *ignoreKeys):
    try:
        f1 = open(file1)
        f2 = open(file2)
        file1Content = open(file1).read()
        file2Content = open(file2).read()
       
        json1 = json.loads(file1Content)
        json2 = json.loads(file2Content)
        for ignoreKey in ignoreKeys:
            del json1[ignoreKey]
            del json2[ignoreKey]
        return json1 == json2
    except: 
        traceback.print_exc(file=sys.stdout)
        raise
    finally:
        f1.close()
        f2.close()
        
        
def compare_json_files (file1, file2):
    return compare_json_files_with_ignored_keys(file1, file2)


def read_template_file(filename, *keyValuePairs):

    try:    
        # prepare body
        f1 = open(filename);
        body = f1.read();
        body = body.decode("ISO-8859-1")
        
        # parse key-value pair
        for kvpair in keyValuePairs:
            idx = kvpair.find("=")
            if (idx != -1):
                key = kvpair[0:idx]
                val = kvpair[idx+1:]
                body = body.replace("${"+key+"}", val)
        return body
    except:
        traceback.print_exc(file=sys.stdout)
        raise
    finally:
        f1.close()
    
def save_to_ini_file(filename, *keyValuePairs):
    try:
        config = ConfigParser()
        config.add_section('data')
        for kvpair in keyValuePairs:
            idx = kvpair.find("=")
            if (idx != -1):
                key = kvpair[0:idx]
                val = kvpair[idx+1:]
                config.set('data', key, val)
        with open(filename, 'w') as configfile:
            config.write(configfile)
    except:
        traceback.print_exc(file=sys.stdout)
        raise

def get_from_ini_file(filename, key):
    try:
        config = ConfigParser()
        config.read(filename)
        # read values from a section
        val = config.get('data', key)
        return val
    except:
        traceback.print_exc(file=sys.stdout)
        raise
    
# instantiate

#save_to_ini_file("d:/test.ini","xx=11","yy=2","zz=3")
#get_from_ini_file("d:/test.ini","zz")
'''
# parse existing file
config.read('/cygdrive/d/test.ini')

# read values from a section
string_val = config.get('section_a', 'string_val')
bool_val = config.getboolean('section_a', 'bool_val')
int_val = config.getint('section_a', 'int_val')
float_val = config.getfloat('section_a', 'pi_val')

# update existing value
config.set('section_a', 'string_val', 'world')
'''
# add a new section and some values


# save to a file

        
#print read_template_file("d:\\temp\\test.json", "amount==12=345=", "channel=ch8")
#print compare_json_files_with_ignored_keys("d:/temp/json1.json","d:/temp/json2.json", "transaction_id")
#compare_files("D:\\automation\\robot\\bpay\\baseline\\Sample Test BPay\\TC01\\baseline.json", 
#              "D:\\automation\\robot\\bpay\\baseline\\Sample Test BPay\\TC01\\baseline.json")
#compare_with_baseline("D:\\automation\\robot\\bpay\\baseline\\Sample Test BPay\\TC01\\baseline.json",
#                      '{"transaction_id":"14112113453600790102","bill_customer_firstname":"SOOKJAI","bill_customer_lastname":"DISCOUNT2PER","bans":[{"products":[{"product_description_en":"Hi Speed Internet","product_description_th":"\xe0\xb8\xad\xe0\xb8\xb4\xe0\xb8\x99\xe0\xb9\x80\xe0\xb8\x97\xe0\xb8\xad\xe0\xb8\xa3\xe0\xb9\x8c\xe0\xb9\x80\xe0\xb8\x99\xe0\xb9\x87\xe0\xb8\x95\xe0\xb8\x84\xe0\xb8\xa7\xe0\xb8\xb2\xe0\xb8\xa1\xe0\xb9\x80\xe0\xb8\xa3\xe0\xb9\x87\xe0\xb8\xa7\xe0\xb8\xaa\xe0\xb8\xb9\xe0\xb8\x87","product_id":"NF0007478I","product_group":"True Online"}],"invoices":[{"invoice_no":"511A00600703","invoice_status":"O","due_date":"22/11/2015","cycle_run_month":"11","cycle_run_year":"2015","bill_amount":"12473.55","bill_amount_left":"747.93","vat_amount":"48.93","discount_amount":"0.00"},{"invoice_no":"510A00600701","invoice_status":"O","due_date":"22/10/2015","cycle_run_month":"10","cycle_run_year":"2015","bill_amount":"11725.62","bill_amount_left":"747.93","vat_amount":"48.93","discount_amount":"0.00"},{"invoice_no":"509A00600702","invoice_status":"O","due_date":"22/09/2015","cycle_run_month":"9","cycle_run_year":"2015","bill_amount":"10977.69","bill_amount_left":"747.93","vat_amount":"48.93","discount_amount":"0.00"},{"invoice_no":"508A00600705","invoice_status":"O","due_date":"22/08/2015","cycle_run_month":"8","cycle_run_year":"2015","bill_amount":"10229.76","bill_amount_left":"747.93","vat_amount":"48.93","discount_amount":"0.00"},{"invoice_no":"507A00600701","invoice_status":"O","due_date":"22/07/2015","cycle_run_month":"7","cycle_run_year":"2015","bill_amount":"9481.83","bill_amount_left":"747.93","vat_amount":"48.93","discount_amount":"0.00"},{"invoice_no":"506A00600697","invoice_status":"O","due_date":"22/06/2015","cycle_run_month":"6","cycle_run_year":"2015","bill_amount":"8733.90","bill_amount_left":"747.93","vat_amount":"48.93","discount_amount":"0.00"},{"invoice_no":"505A00600695","invoice_status":"O","due_date":"22/05/2015","cycle_run_month":"5","cycle_run_year":"2015","bill_amount":"7985.97","bill_amount_left":"747.93","vat_amount":"48.93","discount_amount":"0.00"},{"invoice_no":"504A00600693","invoice_status":"O","due_date":"22/04/2015","cycle_run_month":"4","cycle_run_year":"2015","bill_amount":"7238.04","bill_amount_left":"747.93","vat_amount":"48.93","discount_amount":"0.00"},{"invoice_no":"503A00600694","invoice_status":"O","due_date":"22/03/2015","cycle_run_month":"3","cycle_run_year":"2015","bill_amount":"6490.11","bill_amount_left":"747.93","vat_amount":"48.93","discount_amount":"0.00"},{"invoice_no":"502A00600694","invoice_status":"O","due_date":"22/02/2015","cycle_run_month":"2","cycle_run_year":"2015","bill_amount":"5742.18","bill_amount_left":"747.93","vat_amount":"48.93","discount_amount":"0.00"},{"invoice_no":"501A00600693","invoice_status":"O","due_date":"22/01/2015","cycle_run_month":"1","cycle_run_year":"2015","bill_amount":"4994.25","bill_amount_left":"747.93","vat_amount":"48.93","discount_amount":"0.00"},{"invoice_no":"412A00600685","invoice_status":"O","due_date":"22/12/2014","cycle_run_month":"12","cycle_run_year":"2014","bill_amount":"4246.32","bill_amount_left":"747.93","vat_amount":"48.93","discount_amount":"0.00"},{"invoice_no":"411A00600685","invoice_status":"O","due_date":"22/11/2014","cycle_run_month":"11","cycle_run_year":"2014","bill_amount":"3498.39","bill_amount_left":"747.93","vat_amount":"48.93","discount_amount":"0.00"},{"invoice_no":"410A00600672","invoice_status":"O","due_date":"22/10/2014","cycle_run_month":"10","cycle_run_year":"2014","bill_amount":"2750.46","bill_amount_left":"747.93","vat_amount":"48.93","discount_amount":"0.00"},{"invoice_no":"409A00600666","invoice_status":"O","due_date":"22/09/2014","cycle_run_month":"9","cycle_run_year":"2014","bill_amount":"2002.53","bill_amount_left":"747.93","vat_amount":"48.93","discount_amount":"0.00"},{"invoice_no":"408A00600664","invoice_status":"O","due_date":"22/08/2014","cycle_run_month":"8","cycle_run_year":"2014","bill_amount":"1254.60","bill_amount_left":"1254.60","vat_amount":"82.08","discount_amount":"0.00"}],"billcode":"TI","ban_no":"110004235691","ban_status":"O","account_type":"C","account_balance":"12473.55","account_category":null,"tax_id10":"3011629857","tax_id13":"0105538114103","support_partial":"TRUE","support_overdue":"TRUE","addition_info_en":null,"addition_info_th":null,"additionals":null,"service_min_amount":"50.00","service_max_amount":"30000.00","customer_fee":"5.00","callcenter_number":"1331"},{"products":[{"product_description_en":"Hi Speed Internet","product_description_th":"\xe0\xb8\xad\xe0\xb8\xb4\xe0\xb8\x99\xe0\xb9\x80\xe0\xb8\x97\xe0\xb8\xad\xe0\xb8\xa3\xe0\xb9\x8c\xe0\xb9\x80\xe0\xb8\x99\xe0\xb9\x87\xe0\xb8\x95\xe0\xb8\x84\xe0\xb8\xa7\xe0\xb8\xb2\xe0\xb8\xa1\xe0\xb9\x80\xe0\xb8\xa3\xe0\xb9\x87\xe0\xb8\xa7\xe0\xb8\xaa\xe0\xb8\xb9\xe0\xb8\x87","product_id":"NF0007482I","product_group":"True Online"}],"invoices":[],"billcode":"TI","ban_no":"150004235695","ban_status":"O","account_type":"C","account_balance":"-14804.01","account_category":null,"tax_id10":"3011629857","tax_id13":"0105538114103","support_partial":"TRUE","support_overdue":"TRUE","addition_info_en":null,"addition_info_th":null,"additionals":null,"service_min_amount":"50.00","service_max_amount":"30000.00","customer_fee":"5.00","callcenter_number":"1331"},{"products":[{"product_description_en":"Hi Speed Internet","product_description_th":"\xe0\xb8\xad\xe0\xb8\xb4\xe0\xb8\x99\xe0\xb9\x80\xe0\xb8\x97\xe0\xb8\xad\xe0\xb8\xa3\xe0\xb9\x8c\xe0\xb9\x80\xe0\xb8\x99\xe0\xb9\x87\xe0\xb8\x95\xe0\xb8\x84\xe0\xb8\xa7\xe0\xb8\xb2\xe0\xb8\xa1\xe0\xb9\x80\xe0\xb8\xa3\xe0\xb9\x87\xe0\xb8\xa7\xe0\xb8\xaa\xe0\xb8\xb9\xe0\xb8\x87","product_id":"NF0007484I","product_group":"True Online"}],"invoices":[{"invoice_no":"511A00600704","invoice_status":"O","due_date":"22/11/2015","cycle_run_month":"11","cycle_run_year":"2015","bill_amount":"16042.51","bill_amount_left":"961.93","vat_amount":"62.93","discount_amount":"0.00"},{"invoice_no":"510A00600702","invoice_status":"O","due_date":"22/10/2015","cycle_run_month":"10","cycle_run_year":"2015","bill_amount":"15080.58","bill_amount_left":"961.93","vat_amount":"62.93","discount_amount":"0.00"},{"invoice_no":"509A00600703","invoice_status":"O","due_date":"22/09/2015","cycle_run_month":"9","cycle_run_year":"2015","bill_amount":"14118.65","bill_amount_left":"961.93","vat_amount":"62.93","discount_amount":"0.00"},{"invoice_no":"508A00600707","invoice_status":"O","due_date":"22/08/2015","cycle_run_month":"8","cycle_run_year":"2015","bill_amount":"13156.72","bill_amount_left":"961.93","vat_amount":"62.93","discount_amount":"0.00"},{"invoice_no":"507A00600703","invoice_status":"O","due_date":"22/07/2015","cycle_run_month":"7","cycle_run_year":"2015","bill_amount":"12194.79","bill_amount_left":"961.93","vat_amount":"62.93","discount_amount":"0.00"},{"invoice_no":"506A00600699","invoice_status":"O","due_date":"22/06/2015","cycle_run_month":"6","cycle_run_year":"2015","bill_amount":"11232.86","bill_amount_left":"961.93","vat_amount":"62.93","discount_amount":"0.00"},{"invoice_no":"505A00600697","invoice_status":"O","due_date":"22/05/2015","cycle_run_month":"5","cycle_run_year":"2015","bill_amount":"10270.93","bill_amount_left":"961.93","vat_amount":"62.93","discount_amount":"0.00"},{"invoice_no":"504A00600695","invoice_status":"O","due_date":"22/04/2015","cycle_run_month":"4","cycle_run_year":"2015","bill_amount":"9309.00","bill_amount_left":"961.93","vat_amount":"62.93","discount_amount":"0.00"},{"invoice_no":"503A00600696","invoice_status":"O","due_date":"22/03/2015","cycle_run_month":"3","cycle_run_year":"2015","bill_amount":"8347.07","bill_amount_left":"961.93","vat_amount":"62.93","discount_amount":"0.00"},{"invoice_no":"502A00600696","invoice_status":"O","due_date":"22/02/2015","cycle_run_month":"2","cycle_run_year":"2015","bill_amount":"7385.14","bill_amount_left":"961.93","vat_amount":"62.93","discount_amount":"0.00"},{"invoice_no":"501A00600695","invoice_status":"O","due_date":"22/01/2015","cycle_run_month":"1","cycle_run_year":"2015","bill_amount":"6423.21","bill_amount_left":"961.93","vat_amount":"62.93","discount_amount":"0.00"},{"invoice_no":"412A00600687","invoice_status":"O","due_date":"22/12/2014","cycle_run_month":"12","cycle_run_year":"2014","bill_amount":"5461.28","bill_amount_left":"961.93","vat_amount":"62.93","discount_amount":"0.00"},{"invoice_no":"411A00600687","invoice_status":"O","due_date":"22/11/2014","cycle_run_month":"11","cycle_run_year":"2014","bill_amount":"4499.35","bill_amount_left":"961.93","vat_amount":"62.93","discount_amount":"0.00"},{"invoice_no":"410A00600674","invoice_status":"O","due_date":"22/10/2014","cycle_run_month":"10","cycle_run_year":"2014","bill_amount":"3537.42","bill_amount_left":"961.93","vat_amount":"62.93","discount_amount":"0.00"},{"invoice_no":"409A00600668","invoice_status":"O","due_date":"22/09/2014","cycle_run_month":"9","cycle_run_year":"2014","bill_amount":"2575.49","bill_amount_left":"961.93","vat_amount":"62.93","discount_amount":"0.00"},{"invoice_no":"408A00600666","invoice_status":"O","due_date":"22/08/2014","cycle_run_month":"8","cycle_run_year":"2014","bill_amount":"1613.56","bill_amount_left":"1613.56","vat_amount":"105.56","discount_amount":"0.00"}],"billcode":"TI","ban_no":"150004235705","ban_status":"O","account_type":"C","account_balance":"16042.51","account_category":null,"tax_id10":"3011629857","tax_id13":"0105538114103","support_partial":"TRUE","support_overdue":"TRUE","addition_info_en":null,"addition_info_th":null,"additionals":null,"service_min_amount":"50.00","service_max_amount":"30000.00","customer_fee":"5.00","callcenter_number":"1331"},{"products":[{"product_description_en":"True Move H Post Pay","product_description_th":"\xe0\xb8\x97\xe0\xb8\xa3\xe0\xb8\xb9\xe0\xb8\xa1\xe0\xb8\xb9\xe0\xb8\x9f \xe0\xb9\x80\xe0\xb8\xad\xe0\xb8\x8a \xe0\xb8\xa3\xe0\xb8\xb2\xe0\xb8\xa2\xe0\xb9\x80\xe0\xb8\x94\xe0\xb8\xb7\xe0\xb8\xad\xe0\xb8\x99","product_id":"0870200081","product_group":"TrueMove H"}],"invoices":[{"invoice_no":"9112015020009517","invoice_status":"O","due_date":"23/11/2015","cycle_run_month":"11","cycle_run_year":"2015","bill_amount":"640.93","bill_amount_left":"640.93","vat_amount":"41.93","discount_amount":"0.00"},{"invoice_no":"9102015020008616","invoice_status":"O","due_date":"22/10/2015","cycle_run_month":"10","cycle_run_year":"2015","bill_amount":"640.93","bill_amount_left":"640.93","vat_amount":"41.93","discount_amount":"0.00"},{"invoice_no":"9092015020007693","invoice_status":"O","due_date":"22/09/2015","cycle_run_month":"9","cycle_run_year":"2015","bill_amount":"640.93","bill_amount_left":"640.93","vat_amount":"41.93","discount_amount":"0.00"},{"invoice_no":"9082015020006758","invoice_status":"O","due_date":"24/08/2015","cycle_run_month":"8","cycle_run_year":"2015","bill_amount":"640.93","bill_amount_left":"640.93","vat_amount":"41.93","discount_amount":"0.00"},{"invoice_no":"9072015020005880","invoice_status":"O","due_date":"22/07/2015","cycle_run_month":"7","cycle_run_year":"2015","bill_amount":"640.93","bill_amount_left":"640.93","vat_amount":"41.93","discount_amount":"0.00"},{"invoice_no":"9062015020005004","invoice_status":"O","due_date":"22/06/2015","cycle_run_month":"6","cycle_run_year":"2015","bill_amount":"640.93","bill_amount_left":"640.93","vat_amount":"41.93","discount_amount":"0.00"},{"invoice_no":"9052015020004179","invoice_status":"O","due_date":"22/05/2015","cycle_run_month":"5","cycle_run_year":"2015","bill_amount":"640.93","bill_amount_left":"640.93","vat_amount":"41.93","discount_amount":"0.00"},{"invoice_no":"9042015020003491","invoice_status":"O","due_date":"22/04/2015","cycle_run_month":"4","cycle_run_year":"2015","bill_amount":"640.93","bill_amount_left":"640.93","vat_amount":"41.93","discount_amount":"0.00"},{"invoice_no":"9032015020002767","invoice_status":"O","due_date":"23/03/2015","cycle_run_month":"3","cycle_run_year":"2015","bill_amount":"640.93","bill_amount_left":"640.93","vat_amount":"41.93","discount_amount":"0.00"},{"invoice_no":"9022015020002217","invoice_status":"O","due_date":"23/02/2015","cycle_run_month":"2","cycle_run_year":"2015","bill_amount":"640.93","bill_amount_left":"640.93","vat_amount":"41.93","discount_amount":"0.00"},{"invoice_no":"9012015020001678","invoice_status":"O","due_date":"22/01/2015","cycle_run_month":"1","cycle_run_year":"2015","bill_amount":"640.93","bill_amount_left":"476.73","vat_amount":"41.93","discount_amount":"0.00"}],"billcode":"TMVH","ban_no":"857028763","ban_status":"O","account_type":"RPI","account_balance":"6886.03","account_category":"I","tax_id10":"3032357685","tax_id13":"0105549112786","support_partial":"TRUE","support_overdue":"TRUE","addition_info_en":null,"addition_info_th":null,"additionals":null,"service_min_amount":"50.00","service_max_amount":"30000.00","customer_fee":"0.00","callcenter_number":"1331"}],"namespace":"BPAY","response_code":"0","user_message_en":"SUCCESS","user_message_th":"\xe0\xb8\xaa\xe0\xb8\xb3\xe0\xb9\x80\xe0\xb8\xa3\xe0\xb9\x87\xe0\xb8\x88","developer_message":null}'
# )