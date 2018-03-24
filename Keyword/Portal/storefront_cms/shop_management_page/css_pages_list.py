import datetime
import json

def get_pages_list_data_from_response(response, view):
    pages_list = []
    response_data = json.loads(response)
    for key, item in response_data['data'].items():
        pages_data = {}
        pages_data['page_name'] = item['name']
        if item['page_status'] == 'active':
            pages_data['page_status'] = 'Active'
        elif item['page_status'] == 'inactive':
            pages_data['page_status'] = 'Inactive'
        else:
            pages_data['page_status'] = 'wrong'
        pages_data['content_status'] = _calculate_page_content_status(item['updated_at_'+view], item['published_at_'+view])
        pages_data['live'] = _calculate_page_live(item['page_status'], item['published_at_'+view])
        if item['updated_at_'+view] is None:
            pages_data['last_updated'] = '-'
        else:
            pages_data['last_updated'] = _convert_time(item['updated_at_'+view])
        if item['published_at_'+view] is None:
            pages_data['last_published'] = '-'
        else:
            pages_data['last_published'] = _convert_time(item['published_at_'+view])
        if item['page_updated_by'] is None:
            pages_data['modified_by'] = ''
        else:
            pages_data['modified_by'] = item['page_updated_by']
        #Add to Page list
        pages_list.append(pages_data)
    return pages_list

def _convert_time(str_date):
    return datetime.datetime.strptime(str_date, "%Y-%m-%dT%H:%M:%S+07:00").strftime("%d/%m/%Y %H:%M:%S")

def _calculate_page_content_status(content_updated_at, content_published_at):
    if content_updated_at is not None:
        if content_published_at is not None:
            if content_updated_at < content_published_at:
                return 'Published'
            else:
                return 'Modified'
        else:
            return 'Draft'
    else:
        return 'Waiting'

def _calculate_page_live(page_status, content_published_at):
    if page_status == 'inactive':
        return False
    elif content_published_at is not None:
        return True
    else:
        return False

def compare_list(list1, list2):
    list1_len = len(list1)
    list2_len = len(list2)
    assert list1_len==list2_len, 'Length of list not equal'
    for item in list1:
        assert item in list2, 'List not equal: ' + str(item)

def should_more_than_as_string(str1, str2, message=None):
    assert str1 > str2, message








