import os
import shutil

#file_path: string - an absolute path to file including file name
#content_array: two dimentional array
#    - the outermost array is for each row
#    - the innermost array is for each column in each row
#example: csvlibrary.create_file('/Users/qa/test.csv', [['test', 3, 4], ['another', '1']])
def create_file(file_path, content_array):
    file = open(file_path, 'w')
    for row in content_array:
        row_content = ''
        for column in row:
            if (len(row_content) != 0):
                row_content += ','
            row_content += str(column).strip()
        file.write(row_content+'\n')
    file.close()

def delete_file(file_path):
    if os.path.isfile(file_path):
        os.remove(file_path)
    else:
        print 'File not found'
 


