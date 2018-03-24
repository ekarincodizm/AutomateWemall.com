import sys
from filelibrary import filelibrary
import os
import shutil
import requests
import hashlib
import datetime

def create_file_for_general_service(path, file_name):
    filelib = filelibrary()
    input_text = "File name:"+path+file_name+'\n'
    input_text = input_text+"Date time:"+datetime.datetime.now().isoformat()+'\n'
    filelib.create_file(path, file_name, input_text)

def create_file_with_fileSize(path, file_name, filesize):
    f = open(path+'/'+file_name,"w+")
    f.seek(int(filesize)-1)
    f.write('\0')
    f.close()

def create_folder(directory):
    filelib = filelibrary()
    filelib.create_folder(directory)

def get_json(response):
    return response.json()

def _check_status(response, code):
    assert response.status_code == code, 'Status not '+str(code)+ ', Message: '+response.content

def check_success(response):
    _check_status(response, 200)

def check_status(response, code):
    _check_status(response, int(code))

def check_message(response,message):
    response_data = get_json(response)
    print response_data["message"]
    assert  response_data["message"] == message ,'Message not '+message+ ', Message: '+response.content

def check_message_nginx(response,message):
    first = response.text.index('<title>')
    last = response.text.index('</title>')
    assert response.text[first+7:last] == message ,'Message not '+message+ ', Message: '+response.content

def post_uploads_files(url, s3_path, file_full_path, max_age=None):
    full_url = url+'uploads/'+s3_path
    files = {'file': open(file_full_path, 'rb')}
    if max_age != None:
        data = {'cache_max_age' : max_age}
        response = requests.post(url=full_url, files=files, data=data)
    else:
        data = {'cache_max_age' : max_age}
        response = requests.post(url=full_url, files=files)
    return response

def post_uploads_files_wo_cache_max_age(url, s3_path, file_full_path):
    full_url = url+'uploads/'+s3_path
    files = {'file': open(file_full_path, 'rb')}
    response = requests.post(url=full_url, files=files)
    return response

def get_uploaded_file_from_cdn_s3(full_url):
    print full_url
    response = requests.get(url=full_url)
    return response

def get_response_headers(response):
    return response.headers

def get_response_headers_value(response, key):
    if key in response.headers:
        return response.headers[key]
    else:
        return None

def verify_cache_control_in_response_header(response, expected_max_age):
    actual_max_age = get_response_headers_value(response, 'Cache-Control')

    if expected_max_age is not None:
        print 'Expected: max-age='+str(expected_max_age)
        print 'Actual: '+str(actual_max_age)
        assert 'max-age='+expected_max_age == actual_max_age, ('Cache-Control value do not equal as expedted ' 
            + '(Expected: max-age='+expected_max_age + ', Actual: '+actual_max_age+')')
    else:
        print 'Expected: max-age='+str(expected_max_age)
        print 'Actual: '+str(actual_max_age)
        assert actual_max_age is None and actual_max_age, ('Expected is Null but Cache-Control ' 
            + 'has value and it is "'+actual_max_age+'"')

def check_response_success_and_data_not_empty(response):
    check_success(response)
    json_data = get_json(response)
    data = json_data['data']
    assert data is not None and data, 'data is null or empty'
    return data

def check_response_error_and_data_empty(response):
    print response
    _check_status(response, 500)
    json_data = get_json(response)
    print json_data

def get_cdn_url_from_response(response):
    json_data = get_json(response)
    return json_data['data']['cdn_url']

def get_cdn_url_expected(url, file_full_path):
    md5 = _get_md5_string(file_full_path)
    return url + '?v=' + md5[0:8]

def _get_md5_string(file_full_path):
    return hashlib.md5(open(file_full_path, 'rb').read()).hexdigest()

def post_common_file(url, file_full_path):
    files = {'file': open(file_full_path, 'rb')}
    response = requests.post(url=url, files=files)
    return [str(response.status_code), response.content]

def put_common_file(url, file_full_path):
    files = {'file': open(file_full_path, 'rb')}
    response = requests.put(url=url, files=files)
    return [str(response.status_code), response.content]
    