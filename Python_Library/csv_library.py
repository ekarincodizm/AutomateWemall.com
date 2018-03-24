import csv
from robot.api import logger
from robot.libraries.BuiltIn import BuiltIn
from helper import *

def read_csv_file(filename):
    '''Read CSV file and return its content as a Python list.
    Use Robot Framework's Collections library to futher manipulate lists.
    '''

    f = open(filename, 'r')
    csvfile = csv.reader(f)
    f.close
    return [row for row in csvfile]

def empty_csv_file(filename):
    '''This keyword will empty (truncate) the CSV file.
    '''

    f = open(filename, "w")
    f.truncate()
    f.close()

def append_to_csv_file(filename, data):
    '''This keyword will append data to a new or existing CSV file.
    Data should be iterable (e.g. list or tuple)
    '''

    f = open(filename, 'a')
    csvfile = csv.writer(f)
    for item in data:
        csvfile.writerow([item])
    f.close()


def py_write_data_to_csv(data=None, filename=None) : 
    #curdir = BuiltIn().get_variable_value("${CURDIR}")
    #BuiltIn().log_to_console(get_canonical_path())
    BuiltIn().log_to_console("filename = " + str(filename))
    with open(filename, 'w') as csvfile:
        fieldnames = ['product_pkey']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

        writer.writeheader()    
        for product in data : 
            writer.writerow({'product_pkey': product['product_pkey']})
        

# 2106374239768
# 2804434080543
# 2782548680360
# 2545332992126

# class CSVLibrary(object):

#     def read_csv_file(self, filename):
#         '''Read CSV file and return its content as a Python list.
#         Use Robot Framework's Collections library to futher manipulate lists.
#         '''

#         f = open(filename, 'r')
#         csvfile = csv.reader(f)
#         f.close
#         return [row for row in csvfile]

#     def empty_csv_file(self, filename):
#         '''This keyword will empty (truncate) the CSV file.
#         '''

#         f = open(filename, "w")
#         f.truncate()
#         f.close()

#     def append_to_csv_file(self, filename, data):
#         '''This keyword will append data to a new or existing CSV file.
#         Data should be iterable (e.g. list or tuple)
#         '''

#         f = open(filename, 'a')
#         csvfile = csv.writer(f)
#         for item in data:
#             csvfile.writerow([item])
#         f.close()