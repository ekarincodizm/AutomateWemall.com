import os
import shutil

class filelibrary:
    def create_file(self, path, file_name, input_text):
        files = open(path+file_name, 'w')
        files.write(input_text)

    def delete_file(self, path, file_name):
        if os.path.isfile(path+file_name):
            os.remove(path+file_name)
        else:
            print 'Files not exist'

    def create_folder(self, directory):
        if not os.path.exists(directory):
            os.makedirs(directory)

    def delete_empty_folder(self, directory): # Force delete
        if os.path.exists(directory):
            os.removedirs(directory)

    def delete_folder(self, directory): #delete folder one by one
        if os.path.exists(directory):
            shutil.rmtree(directory)


