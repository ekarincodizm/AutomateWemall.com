from ConnectDB import *
import datetime
import time
dt = datetime.datetime.now()

def get_truemoveh_order_verify(order_id=None) : 
	if order_id is None : 
		return None 

	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
	cursor = mydb.cursor()

	query = "SELECT `mnp1_status`, `activate_status`, `status` FROM `truemoveh_order_verifys` WHERE `id` = %s " % order_id 
	try : 
		result = cursor.execute(query)
		row = cursor.fetchone()
		return row[0]
	except : 
		return False


def create_truemoveh_order_verify(fields=None) : 
	if fields is None : 
		return None

	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
	cursor = mydb.cursor()

	if fields.has_key('created_at') : 
		created_at = fields["created_at"]
		activate_date = fields["activate_date"]
		mnp1_success_date = fields["mnp1_success_date"]
	else : 
		created_at = dt.isoformat()
		activate_date = dt.isoformat()
		mnp1_success_date = dt.isoformat()
	#try : 
	query = " INSERT INTO `truemoveh_order_verifys` \
		( \
		  `pcms_order_id` \
		, `mnp_order_id` \
		, `pcms_item_id` \
		, `img_path` \
		, `img_type` \
		, `img_file_name` \
		, `birth_date` \
		, `idcard` \
		, `idcard_expire` \
		, `mobile_id` \
		, `mobile` \
		, `operator` \
		, `device_name` \
		, `device_name_sub` \
		, `price_plan_id` \
		, `proposition_id` \
		, `pdf_path` \
		, `title` \
		, `gender` \
		, `marital_status` \
		, `nationality` \
		, `fname` \
		, `lname` \
		, `same_address` \
		, `customer_address` \
		, `customer_road` \
		, `customer_district_id` \
		, `customer_district` \
		, `customer_city_id` \
		, `customer_city` \
		, `customer_province_id` \
		, `customer_province` \
		, `customer_zipcode` \
		, `customer_tel` \
		, `customer_email` \
		, `billing_address` \
		, `billing_road` \
		, `billing_district_id` \
		, `billing_district` \
		, `billing_city_id` \
		, `billing_city` \
		, `billing_province_id` \
		, `billing_province` \
		, `billing_zipcode` \
		, `status` \
		, `bundle_type` \
		, `verify_date` \
		, `approve_user_id` \
		, `activate_user_id` \
		, `updated_image_by` \
		, `activate_status` \
		, `activate_date` \
		, `tcc_order` \
		, `note` \
		, `download_count` \
		, `mnp1_status` \
		, `mnp1_success_date` \
		, `mnp_used` \
		, `mnp_used_log` \
		, `created_at` \
		, `updated_at` \
		, `deleted_at` \
	) VALUES ( \
		  '%s' \
		, NULL \
		, 4426204 \
		, 'truemoveh/idcard/2016/03/1729900076844_20160307114442.jpg' \
		, 'jpg' \
		, 'thai_id_img.jpg' \
		, '1995-11-15' \
		, '%s' \
		, '2022-11-02' \
		, 53 \
		, '%s' \
		, 'AIS' \
		, 'GALAXY CAMERA' \
		, 'Combi SIM' \
		, 2 \
		, 131 \
		, 'truemoveh/pdf_confirm/truemoveh/pdf/20160320160307115240.pdf' \
		, 'Mr.' \
		, 'M' \
		, NULL \
		, '-' \
		, 'testName' \
		, 'testSurname' \
		, 'N' \
		, 'test addr' \
		, '-' \
		, 614 \
		, 'Bangkhor' \
		, 108 \
		, 'Jomthong' \
		, 6 \
		, 'Bangkok' \
		, '10150' \
		, '0810104311' \
		, '' \
		, 'test addr' \
		, '-' \
		, 614 \
		, 'Bangkhor' \
		, 108 \
		, 'Jomthong' \
		, 6 \
		, 'Bangkok' \
		, '10150' \
		, '%s' \
		, 'mnp' \
		, '2016-03-07 11:50:07' \
		, 173 \
		, 173 \
		, NULL \
		, '%s' \
		, '%s' \
		, '123456' \
		, NULL \
		, 1 \
		, '%s' \
		, '%s' \
		, 0 \
		, NULL \
		, '%s' \
		, '2016-03-07 14:34:33' \
		, NULL \
	) " % (fields["pcms_order_id"], fields["idcard"], fields["mobile"], fields["status"], fields["activate_status"], activate_date, fields["mnp1_status"], mnp1_success_date, created_at)
	try : 
 		result = cursor.execute(query)
		data = {}
		data["status"] = True
		data["lastid"] = cursor.lastrowid
		mydb.commit()
		mydb.close()
		return data
	except: 
		mydb.rollback();
		data = {}
		data["status"] = False
		return data

def delete_truemoveH_order_verify_by_mobile(mobile_no=None) : 
	if mobile_no is None : 
		return None
	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
	cursor = mydb.cursor()

	query = " DELETE FROM `truemoveh_order_verifys` WHERE `mobile` = %s " % mobile_no
	try : 
 		result = cursor.execute(query)
		mydb.commit()
		return result
	except: 
		mydb.rollback();
	
		return false

#r = delete_truemoveH_order_verify_by_mobile('080000000')
#print r
#order = get_truemoveh_order_verify(1306)
#print order
	