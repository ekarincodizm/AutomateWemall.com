
def get_parent_id(url):
    index_parent = url.split("/")
    return index_parent[len(index_parent)-2]

def check_banner(ui_banner,api_banner):
    for index,banner_group in api_banner.iteritems():
        assert banner_group["name"] == ui_banner[int(index)-1]
        print   banner_group["name"] == ui_banner[int(index)-1]