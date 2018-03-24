import MySQLdb as db
import socket
from ConnectDB import *

def get_inventoryID_priceplans_more_than1(source_type) : 

	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "SELECT * from \
		(SELECT `truemoveh_device_proposition_group_maps`.`inventory_id`,COUNT(DISTINCT `price_plan_id`) as quantity \
        FROM `products` \
    	INNER JOIN `variants` \
 		ON `products`.`id` = `variants`.`product_id` \
 		INNER JOIN `truemoveh_device_proposition_group_maps` \
 		ON `truemoveh_device_proposition_group_maps`. `variant_id` = `variants`.`id` \
    	INNER JOIN `truemoveh_proposition_groups` \
		ON `truemoveh_device_proposition_group_maps`.`group_id` = `truemoveh_proposition_groups`.`id` \
		INNER JOIN `truemoveh_proposition_group_maps` \
		ON `truemoveh_proposition_group_maps`.`proposition_group_id` = `truemoveh_proposition_groups`.`id` \
		INNER JOIN `truemoveh_propositions` \
		ON `truemoveh_propositions`.`id` = `truemoveh_proposition_group_maps`.`proposition_group_id` \
		INNER JOIN `truemoveh_proposition_maps` \
		ON `truemoveh_proposition_maps`.`proposition_id` = `truemoveh_propositions`.`id` \
    	INNER JOIN `truemoveh_price_plans` \
   	 	ON `truemoveh_price_plans`.`id` = `truemoveh_proposition_maps`.`proposition_id` \
    	WHERE `truemoveh_propositions`.`source_type` = '%s' \
 		AND `products`.`status` = 'publish' \
 		AND `products`.`active` = 1 \
 		AND `variants`.`status` = 'active' \
        GROUP BY `truemoveh_device_proposition_group_maps`.`inventory_id`) as inv \
        WHERE quantity > 1 " % source_type

	try:
		cursor = mydb.cursor()
		cursor.execute(query)
		rows = cursor.fetchone()
		return rows[0]
	except:
		print "Cannot fetch data."
	mydb.close() 


def get_inventoryID_one_priceplan(source_type) : 

	mydb = db.connect(host=dbhost, user=dbuser, passwd=dbpass, db=dbname, charset=dbcharset)

	query = "SELECT * from \
		(SELECT `truemoveh_device_proposition_group_maps`.`inventory_id`,COUNT(DISTINCT `price_plan_id`) as quantity \
        FROM `products` \
    	INNER JOIN `variants` \
 		ON `products`.`id` = `variants`.`product_id` \
 		INNER JOIN `truemoveh_device_proposition_group_maps` \
 		ON `truemoveh_device_proposition_group_maps`. `variant_id` = `variants`.`id` \
    	INNER JOIN `truemoveh_proposition_groups` \
		ON `truemoveh_device_proposition_group_maps`.`group_id` = `truemoveh_proposition_groups`.`id` \
		INNER JOIN `truemoveh_proposition_group_maps` \
		ON `truemoveh_proposition_group_maps`.`proposition_group_id` = `truemoveh_proposition_groups`.`id` \
		INNER JOIN `truemoveh_propositions` \
		ON `truemoveh_propositions`.`id` = `truemoveh_proposition_group_maps`.`proposition_group_id` \
		INNER JOIN `truemoveh_proposition_maps` \
		ON `truemoveh_proposition_maps`.`proposition_id` = `truemoveh_propositions`.`id` \
    	INNER JOIN `truemoveh_price_plans` \
   	 	ON `truemoveh_price_plans`.`id` = `truemoveh_proposition_maps`.`proposition_id` \
    	WHERE `truemoveh_propositions`.`source_type` = '%s' \
 		AND `products`.`status` = 'publish' \
 		AND `products`.`active` = 1 \
 		AND `variants`.`status` = 'active' \
        GROUP BY `truemoveh_device_proposition_group_maps`.`inventory_id`) as inv \
        WHERE quantity = 1 " % source_type

	try:
		cursor = mydb.cursor()
		cursor.execute(query)
		rows = cursor.fetchone()
		return rows[0]
	except:
		print "Cannot fetch data."
	mydb.close() 




