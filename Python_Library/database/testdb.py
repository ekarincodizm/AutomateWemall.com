import sys
import os

run_path = os.getcwd()
os.chdir(os.path.dirname(os.path.realpath(__file__)))
os.chdir('../../')
sys.path.append(os.getcwd())

import Python_Library.ConnectDB as db
os.chdir(run_path)

print os.getcwd()

query = "SELECT * \
FROM `promotions` \
WHERE `promotions`.`id` in (1425,1424)"

def query_promotion_data():
    return db.query_data(query)

print 'AAA'