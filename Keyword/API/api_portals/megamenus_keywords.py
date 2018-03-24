import json
import os
import requests

def build_mega_menu_showroom_banner_data(data, menu_index, template_id, banner_data):
    try:
        data = json.loads(data)
        data = data['data']['data']
    except Exception, e:
        raise Exception("Invalid mega menu data:" + str(e))

    try:
        banner_data = json.loads(banner_data)
        banner_th = banner_data['showroom']['th']['child']
        banner_en = banner_data['showroom']['en']['child']
    except Exception, e:
        raise Exception("Invalid input banner data:" + str(e))

    menu_key_th = None
    menu_key_en = None

    for key, value in data['th_TH']['child'].iteritems():
        if str(value['sort_index']) == str(menu_index):
            menu_key_th = key
            break
    for key, value in data['en_US']['child'].iteritems():
        if str(value['sort_index']) == str(menu_index):
            menu_key_en = key
            break

    if menu_key_th == None or menu_key_en == None:
        raise Exception("Menu index not found:" + str(menu_index))

    # set template_id and set banner data
    data['th_TH']['child'][menu_key_th]['showroom']['template_id'] = str(template_id)
    data['en_US']['child'][menu_key_en]['showroom']['template_id'] = str(template_id)

    # set banner data
    data['th_TH']['child'][menu_key_th]['showroom']['child'] = banner_th
    data['en_US']['child'][menu_key_en]['showroom']['child'] = banner_en

    # set version
    data = dict(version="draft", data=data)

    return json.dumps(data)


def prepare_mega_menu_link(data, menu_index, lv, link, lv2_index=1):
    try:
        data = json.loads(data)
        data = data['data']['data']
    except Exception, e:
        raise Exception("Invalid mega menu data:" + str(e))

    menu_key_th = None
    menu_key_en = None
    for key, value in data['th_TH']['child'].iteritems():
        if str(value['sort_index']) == str(menu_index):
            menu_key_th = key
            break
    for key, value in data['en_US']['child'].iteritems():
        if str(value['sort_index']) == str(menu_index):
            menu_key_en = key
            break

    if menu_key_th == None or menu_key_en == None:
        raise Exception("Menu index not found:" + str(menu_index))

    if 1 == int(lv):
        data['th_TH']['child'][menu_key_th]['link_url'] = link
        data['en_US']['child'][menu_key_en]['link_url'] = link
        data['th_TH']['child'][menu_key_th]['link_target'] = "_blank"
        data['en_US']['child'][menu_key_en]['link_target'] = "_blank"

    if 2 == int(lv):
        for key, value in data['th_TH']['child'][menu_key_th]['child'].iteritems():
            if str(value['sort_index']) == str(lv2_index):
                lv2_menu_key_th = key
                break

        for key, value in data['en_US']['child'][menu_key_th]['child'].iteritems():
            if str(value['sort_index']) == str(lv2_index):
                lv2_menu_key_en = key
                break

        if lv2_menu_key_th == None or lv2_menu_key_en == None:
            raise Exception("Menu lv2 index not found:" + str(lv2_index))

        data['th_TH']['child'][menu_key_th]['child'][lv2_menu_key_th]['link_url'] = link
        data['en_US']['child'][menu_key_th]['child'][lv2_menu_key_en]['link_url'] = link
        data['th_TH']['child'][menu_key_th]['child'][lv2_menu_key_th]['link_target'] = "_blank"
        data['en_US']['child'][menu_key_th]['child'][lv2_menu_key_en]['link_target'] = "_blank"

    data = dict(version="draft", data=data)

    return json.dumps(data)

def upload_banner_image_to_general_service(upload_url, service, lang, save_path, image_folder):

    if os.path.isfile(save_path):
        return

    files = [f for f in os.listdir(image_folder) if os.path.isfile(os.path.join(image_folder, f))]
    files.sort()

    upload_url = "%suploads/%s/dir/%s"%(upload_url, service, lang)

    upload_dict = {}

    for file in files:
        files = {'upload_file': open("%s/%s"%(image_folder, file),'rb')}
        r = requests.post(upload_url, files=files)
        if(r.status_code != 200):
            raise Exception("Error upload file")

        try:
            data = r.json()
            upload_dict[file.split('.')[0]] = data['data']['cdn_url']
        except Exception, e:
            raise Exception("Error upload file:" + str(e))
    open(save_path, 'w').write( json.dumps(upload_dict))

def make_test_data_key(int1, int2):
    int1    =   int(int1)
    int2    =   int(int2)
    return "%02d-%02d"%(int1, int2)

def convert_child_to_list(data):
    #type check
    if type(data) == type([]):
        return data
    if data == None:
        return []
    data_list = list()
    temp_dict = dict()
    for key, menu in data.iteritems():
        try:
            sort_index = menu['sort_index']
        except:
            sort_index = key
        temp_dict[int(sort_index)] = menu

    for key, menu in temp_dict.iteritems():
        data_list.append(menu)

    return data_list

def get_from_dictionary_ignore_data(data, key):
    try:
        return data[key]
    except:
        return dict()

def report_failure(msg):
    if msg is None:
        raise AssertionError()
    raise AssertionError(msg)