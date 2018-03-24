import sys, os, inspect
cmd_subfolder = os.path.realpath(os.path.abspath(os.path.join(os.path.split(inspect.getfile( inspect.currentframe() ))[0],"dbclass")))
if cmd_subfolder not in sys.path:
	sys.path.insert(0, cmd_subfolder)

import database_class as dc

#example: collection.create_collection(0, 9991234567890, 'Collection for QA', 'col-slug', '1', 'CZ9999', '1')
def create_collection(parent_id, pkey, name, slug, is_category, category_id, pds_collection):

	delete_collection_by_category_id(category_id)

	insert_collections = "INSERT INTO collections (parent_id,pkey,attachment_id,name,slug,is_category,collection_type,category_id,created_at,updated_at,deleted_at,pds_collection) \
	VALUES \
	(%d, %d, NULL, '%s', '%s', '%s', 'default', '%s', '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, '%s')" % (parent_id, pkey, name, slug, is_category, category_id, pds_collection)
	
	dc.execute(insert_collections)

	rows = dc.execute("SELECT * FROM collections WHERE category_id = '%s'" % category_id)
	colId = rows[0][0]

	insert_translation = "INSERT INTO translates (locale, languagable_id,languagable_type,text,title,name,description,key_feature,body,unit_type,caption,advantage) \
	VALUES \
	('en_US', %d, 'Collection', NULL, NULL, '%s', NULL, NULL, NULL, NULL, NULL, NULL)" % (colId, name)
	dc.execute(insert_translation)

	insert_app_collections = "INSERT INTO apps_collections (collection_id, app_id, `order`) \
	VALUES (%d, 1, NULL)" % colId
	dc.execute(insert_app_collections)

	return colId


#collection_id: integer - id field in collections table
#example: collection.delete_collection_by_collection_id(18397)
def delete_collection_by_collection_id(collection_id):
	dc.execute("DELETE FROM translates where languagable_id=%d and languagable_type='Collection'" % collection_id)
	dc.execute("DELETE FROM apps_collections WHERE collection_id = %d" % collection_id)
	dc.execute("DELETE FROM collections WHERE id = %d" % collection_id)
	dc.execute("DELETE FROM product_collections WHERE collection_id = '%s'" % collection_id)


#category_id: string - category_id field in collections table
#example: collection.delete_collection_by_category_id('CZ9999')
def delete_collection_by_category_id(category_id):
	rows = dc.execute("SELECT * FROM collections WHERE category_id = '%s'" % category_id)
	if len(rows) == 0:
		return
	collection_id = rows[0][0]
	delete_collection_by_collection_id(collection_id)


