import json

def get_expected_mega_menu_template_list(count):
    list_data = []
    for x in xrange(0, int(count)):
        list_data.append('template_00'+str(x+1))
    return list_data

def should_list_contain_only_one_value(list_data, expected):
    for value in list_data:
        if value != expected:
            return False
    return True