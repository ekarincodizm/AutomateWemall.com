import sys, os, inspect
cmd_subfolder = os.path.realpath(os.path.abspath(os.path.join(os.path.split(inspect.getfile( inspect.currentframe() ))[0],"dbclass")))
if cmd_subfolder not in sys.path:
	sys.path.insert(0, cmd_subfolder)

import database_class as dc

#name - string
#merchant_code - string
#user_id - interger, for testing, we decide to set the default value to 35 (Admin)
def get_alias_merchant():
	rows = dc.execute("SELECT id FROM merchant_alias WHERE deleted_at is null")
	if len(rows) == 0:
		return
	alias_id = rows[0][0]
	return alias_id

def create_alias_merchant(name, merchant_code, user_id=35):
	
	delete_alias_merchant_by_merchant_code(merchant_code)

	insert_alias_merchant = "INSERT INTO merchant_alias (name, merchant_code, user_id, created_at) \
	VALUES \
	('%s', '%s', %d, '0000-00-00 00:00:00')" % (name, merchant_code, user_id)
	
	dc.execute(insert_alias_merchant)

	rows = dc.execute("SELECT * FROM merchant_alias WHERE merchant_code = '%s'" % merchant_code)
	alias_id = rows[0][0]

	return alias_id


#alias_id: integer - id field in merchant_alias table
def delete_alias_merchant_by_id(alias_id):
	dc.execute("DELETE FROM merchant_alias WHERE id = %d" % alias_id)


#alias_id: integer - id field in merchant_alias table
def delete_alias_merchant_by_merchant_code(merchant_code):
	rows = dc.execute("SELECT * FROM merchant_alias WHERE merchant_code = '%s'" % merchant_code)
	if len(rows) == 0:
		return
	alias_id = rows[0][0]
	delete_alias_merchant_by_id(alias_id)


#product_id - integer
#merchant_alias_id - integer
#user_id - interger, for testing, we decide to set the default value to 35 (Admin)
#source - enum (mass/manual), for flash team's automate test, we agree to use 'mass' to reflect mass upload feature which we implement
def add_product_to_alias_merchant(product_id, merchant_alias_id, user_id=35, source='mass'):

	delete_product_from_alias_merchant_by_product_id(product_id)

	insert_product = "INSERT INTO product_merchant_alias (product_id, merchant_alias_id, user_id, created_at, source) \
	VALUES \
	(%d, %d, %d, '0000-00-00 00:00:00', '%s')" % (product_id, merchant_alias_id, user_id, source)
	
	dc.execute(insert_product)

	rows = dc.execute("SELECT * FROM product_merchant_alias WHERE product_id = %d" % product_id)
	product_merchant_alias_id = rows[0][0]

	return product_merchant_alias_id


#product_merchant_alias_id: integer - id field in product_merchant_alias table
def delete_product_from_alias_merchant_by_id(product_merchant_alias_id):
	dc.execute("DELETE FROM product_merchant_alias WHERE id = %d" % product_merchant_alias_id)


#product_id - integer
def delete_product_from_alias_merchant_by_product_id(product_id):
	rows = dc.execute("SELECT * FROM product_merchant_alias WHERE product_id = %d" % product_id)
	if len(rows) == 0:
		return
	product_merchant_alias_id = rows[0][0]
	delete_product_from_alias_merchant_by_id(product_merchant_alias_id)
