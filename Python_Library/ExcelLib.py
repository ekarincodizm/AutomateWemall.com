import openpyxl

wb = openpyxl.load_workbook('example.xlsx')
sheet_names = wb.get_sheet_names()
#['Sheet1', 'Sheet2', 'Sheet3']
print sheet_names
sheet = wb.get_sheet_by_name('Sheet1')

#print sheet 
print len(sheet.columns)

for cell in sheet.columns:
	print cell
# for row in sheet.rows:
#     for cell in row:
#         print("cell = " + cell.value)


#print sheet.title
anotherSheet = wb.get_active_sheet()
print anotherSheet