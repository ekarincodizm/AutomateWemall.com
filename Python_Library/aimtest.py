import xlrd

# function to open an Excel File
def get_value_from_excel(path, row, col):
    # Open and read an Excel file
    book = xlrd.open_workbook(path)
    sh = book.sheet_by_index(0)
    data = sh.cell_value(rowx=int(row), colx=int(col))

    return data

def get_row_count_from_excel(path):
    # Open and read an Excel file
    book = xlrd.open_workbook(path)
    sh = book.sheet_by_index(0)
    data = sh.nrows
    return data
