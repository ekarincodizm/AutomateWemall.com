
import sys, os, inspect
cmd_subfolder = os.path.realpath(os.path.abspath(os.path.join(os.path.split(inspect.getfile( inspect.currentframe() ))[0],"dbclass")))
if cmd_subfolder not in sys.path:
	sys.path.insert(0, cmd_subfolder)

import database_class as dc



def delete_brand_by_brand_id(brand_id):
	dc.execute("DELETE FROM brands where id=%d " % brand_id)


def update_brand(name, name_e, des_e):

	res = dc.execute("SELECT * FROM brands WHERE name = '%s'" % name)
	dc.execute("UPDATE brands SET name = '%s', description = '%s' WHERE id = %d" %(name_e, des_e, res[0][0]))
	return res

