from ConnectDB import *

def delete_tcc_transaction(file_name=None) : 
	if file_name is None : 
		return None 

	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)
	query = " DELETE FROM `mnp_download_tcc_transaction` WHERE `filename` = '%s' " % file_name
	cursor = mydb.cursor()
	try : 
		cursor.execute(query)
		mydb.commit()
		mydb.close()
		return True
	except : 
		mydb.rollback()
		return False
	#MNPSUCCESS_22032016.txt

#r = delete_tcc_transaction('MNPSUCCESS_22032016.txt')
#print r