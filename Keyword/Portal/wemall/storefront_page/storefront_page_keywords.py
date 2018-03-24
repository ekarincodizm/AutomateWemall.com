import jsonLibrary
from robot.libraries.BuiltIn import BuiltIn
from robot.libraries.Collections import Collections
from robot.api import logger
import json
import os

_jquery_s = 'jquery='
_class_slide_content = '.wm-store-front-slide-content'
_class_next_lvl_slide = _class_slide_content + '.slide-next-level'
_first_slide = _class_slide_content + ' li a:contains(\''
_next_slide = _class_slide_content + ' li a.sub-menu:contains(\''

first_slide_content = _jquery_s + _class_slide_content + ' li a:contains(\''
next_lvl_slide_root = _jquery_s + _class_next_lvl_slide + ' li.root-level a:contains(\''
next_lvl_slide_sub = _jquery_s + _class_next_lvl_slide + ' li a.sub-menu:contains(\''

def compared_menus_with_expected_shop_menu(json_data, lang='th'):
    menu_data = json_data["data"]["menus"]
    menu_status = json_data["data"]["status"]

    if lang == 'en':
        name_lang = 'name_translation'
    else:
        name_lang = 'name'
    
    # Get selenium instance
    selenium = BuiltIn().get_library_instance('Selenium2Library')
    driver = selenium._current_browser()

    # If the expected menu is not active, the menu should not be displayed
    if menu_status != 'active':
        BuiltIn().run_keyword('Verify Menus Not Contain Menu')
        return

    # TODO: refactor this to use recursive because iteration with fix loops is not flexible and not cool at all
    # Verify menu foreach level with depth first search
    
    if json_data["data"].has_key('logo'):
        menu_logo = json_data["data"]["logo"]
        if menu_logo is not None:
            logo_element = selenium.get_webelements('jquery=.brand-name img')
            # verify src-img
            expected_logo_url = 'http:' + menu_logo[name_lang]['url_src'].replace(' ','%20')
            BuiltIn().should_be_equal_as_strings(expected_logo_url, logo_element[0].get_attribute('src'))

    # menu lv1
    index1 = 0
    menu_lv1_path = BuiltIn().get_variable_value("${MENU_LV1}")
    menu_lv1_span_elements = selenium.get_webelements('jquery=span' + menu_lv1_path)
    menu_lv1_a_elements    = selenium.get_webelements('jquery=a' + menu_lv1_path)

    for menu_lv1 in menu_data:

        # get web elements that display text
        menu_lv1_display_element = menu_lv1_a_elements[index1]
        if ('children' in menu_lv1) and len(menu_lv1['children']) > 0:
            menu_lv1_display_element = menu_lv1_span_elements[index1]

        # get links
        menu_lv1_links = selenium.get_webelements('jquery=a' + menu_lv1_path)
        menu_lv1_link = menu_lv1_a_elements[index1]

        # verify name
        BuiltIn().should_be_equal_as_strings(menu_lv1[name_lang]['name'], menu_lv1_display_element.text)

        # verify link
        # print menu_lv1[name_lang]['link']
        # print "href:" + menu_lv1_link.get_attribute('href')
        BuiltIn().should_be_equal_as_strings(menu_lv1[name_lang]['link'], menu_lv1_link.get_attribute('href'))

        # verify open in new tab
        BuiltIn().should_be_equal_as_strings(menu_lv1['target'], menu_lv1_link.get_attribute('target'))
        max_level = menu_lv1['max_level'];
        # menu lv2
        if ('children' in menu_lv1) and len(menu_lv1['children']) > 0:
            menu_lv2s = menu_lv1['children']
            index2 = 0
            selenium.mouse_over(menu_lv1_display_element)

            menu_lv2_displays = None
            menu_lv2_displays_a = None
            if max_level == 2:
                menu_lv2_path = BuiltIn().get_variable_value("${MENU_LV2}")
                menu_lv2_displays = selenium.get_webelements('jquery=.sub-menu a:visible')
            elif max_level > 2:
                menu_lv2_displays = selenium.get_webelements('jquery=.sub-menu-mega a:visible span:not(".icon-arrow-right-edge")')
                menu_lv2_displays_a = selenium.get_webelements('jquery=.sub-menu-mega a:visible')

            for menu_lv2 in menu_lv2s:
                # select level 2
                menu_lv2_display = menu_lv2_displays[index2]
                selenium.mouse_over(menu_lv2_display)

                if max_level == 2:
                    # verify name
                    #logger.console("rawData2 %s %s %s " %(menu_lv2[name_lang]['name'], menu_lv2[name_lang]['link'], menu_lv2_display.text))
                    BuiltIn().should_be_equal_as_strings(menu_lv2[name_lang]['name'], menu_lv2_display.text)
                    # verify link
                    BuiltIn().should_be_equal_as_strings(menu_lv2[name_lang]['link'], menu_lv2_display.get_attribute('href'))
                    # verify open in new tab
                    BuiltIn().should_be_equal_as_strings(menu_lv2['target'], menu_lv2_display.get_attribute('target'))
                elif max_level > 2:
                    # verify name
                    #logger.console("rawData2 %s %s %s " %(menu_lv2[name_lang]['name'], menu_lv2[name_lang]['link'], menu_lv2_display.text))
                    BuiltIn().should_be_equal_as_strings(menu_lv2[name_lang]['name'], menu_lv2_display.text)       
                     # verify link
                    if menu_lv2[name_lang]['link']:
                        menu_lv2_display_a = menu_lv2_displays_a[index2]
                        #logger.console("link %s %s %s " %(menu_lv2[name_lang]['name'], menu_lv2[name_lang]['link'], menu_lv2_display_a.get_attribute('href')))
                        BuiltIn().should_be_equal_as_strings(menu_lv2[name_lang]['link'], menu_lv2_display_a.get_attribute('href'))
                    # verify image : 
                    if menu_lv2['images'] and len(menu_lv2['images']) > 0:
                        menu_lv2_display_image = selenium.get_webelements('jquery=.image-contrainer img')
                        BuiltIn().should_be_equal_as_strings("http:" + menu_lv2['images'][0][name_lang]['image'], menu_lv2_display_image[0].get_attribute('src'))
                    # verify open in new teb
                    if menu_lv2['target']:
                        if menu_lv2['target'] != '_blank':
                            BuiltIn().should_be_equal_as_strings(menu_lv2['target'], menu_lv2_display_a.get_attribute('target'))
                    # menu lv3 (max_level > 2)
                    if ('children' in menu_lv2) and len(menu_lv2['children']) > 0:
                        #TODO check '-' display <br>
                        menu_lv3s = menu_lv2['children']
                        #Get li of level3
                        menu_lv3_displays_a = selenium.get_webelements('jquery=.sub-menu-contrainer li a')
                        menu_lv3_displays = selenium.get_webelements('jquery=.sub-menu-contrainer li span:visible')
                        index34 = 0
                        for menu_lv3 in menu_lv3s:

                            menu_lv3_display = menu_lv3_displays[index34]
                            menu_lv3_display_a = menu_lv3_displays_a[index34]
                            # verify name   
                            if menu_lv3[name_lang]['name'] == '-':
                                BuiltIn().should_be_equal_as_strings(menu_lv3_display.text, '')   
                            else:
                                BuiltIn().should_be_equal_as_strings(menu_lv3[name_lang]['name'], menu_lv3_display.text)
                                # verify link
                                BuiltIn().should_be_equal_as_strings(menu_lv3[name_lang]['link'], menu_lv3_display_a.get_attribute('href'))
                             
                                # verify open in new teb
                                BuiltIn().should_be_equal_as_strings(menu_lv3['target'], menu_lv3_display_a.get_attribute('target'))
                            index34 = index34 +1
                            # menu lv4
                            if ('children' in menu_lv3) and len(menu_lv3['children']) > 0:
                                menu_lv4s = menu_lv3['children']
                                for menu_lv4 in menu_lv4s:
                                    menu_lv4_display = menu_lv3_displays[index34]
                                    menu_lv4_display_a = menu_lv3_displays_a[index34]
                                    # verify name
                                    if menu_lv4[name_lang]['name'] == '-':
                                        BuiltIn().should_be_equal_as_strings(menu_lv4_display.text, '')
                                    else:
                                        BuiltIn().should_be_equal_as_strings(menu_lv4[name_lang]['name'], menu_lv4_display.text)

                                        # verify link
                                        #logger.console("link %s %s %s " %(menu_lv4[name_lang]['name'], menu_lv4['name']['link'], menu_lv4_display_a.get_attribute('href')))
                                        BuiltIn().should_be_equal_as_strings(menu_lv4[name_lang]['link'], menu_lv4_display_a.get_attribute('href'))

                                        # verify open in new teb
                                        #logger.console("target4 %s %s" %(menu_lv4['target'] ,menu_lv4_display_a.get_attribute('target') ))
                                        BuiltIn().should_be_equal_as_strings(menu_lv4['target'], menu_lv4_display_a.get_attribute('target'))

                                    index34 = index34 + 1

                index2 = index2 + 1

        index1 = index1 + 1
                                

def verify_menus_with_expected_data(expected_data_path, lang='th'):
    # Read expected data and convert into a dictionary
    json_data = jsonLibrary.load_json(expected_data_path)
    compared_menus_with_expected_shop_menu(json_data, lang)

def verify_menus_with_expected_respones_data(response, lang='th'):
    # Read expected data and convert into a dictionary
    response_data = response.json()
    print response_data
    try:
        menu_data = response_data['data']['menu']
    except IndexError:
        assert False, "Don't have node Menus in json data"
    assert menu_data != [] or len(menu_data)==0, "menu data is null"
    compared_menus_with_expected_shop_menu(menu_data, lang)


def verify_shop_menu_mobile_with_json_data_file(json_data_file, lang='th'):
    with open(json_data_file) as data_file:
        json_data = json.load(data_file)
    try:
        menu_data = json_data['data']['menus']
    except IndexError:
        assert False, "Don't have node Menus in json data"
    assert menu_data != [] or len(menu_data)==0, "menu data is null"
    _recursive_print_menu(menu_data, 1, lang=lang)

def verify_shop_menu_mobile_with_response_data(response, lang='th'):
    response_data = response.json()
    print response_data
    try:
        menu_data = response_data['data']['menu']['data']['menus']
    except IndexError:
        assert False, "Don't have node Menus in json data"
    assert menu_data != [] or len(menu_data)==0, "menu data is null"
    _recursive_print_menu(menu_data, 1, lang=lang)

def _recursive_print_menu(menu_data, level, menu_0=None, lang='th'):
    _se2lib = BuiltIn().get_library_instance('Selenium2Library')
    BuiltIn().sleep('500ms')
    if lang == 'en':
        name_lang = 'name_translation'
    else:
        name_lang = 'name'
    for menu_1 in menu_data:
        if len(menu_1['children'])!=0:
            # print "----level: " + str(level) + "name: " + menu_1[name_lang]['name']
            if level == 1:
                # print "$(\"" + _first_slide + menu_1[name_lang]['name'] + "')\").click()"
                _se2lib.execute_javascript("$(\"" + _first_slide + menu_1[name_lang]['name'] + "')\").click()")
            else:
                # print "$(\"" + _next_slide + menu_1[name_lang]['name'] + "')\").click()"
                _se2lib.execute_javascript("$(\"" + _next_slide + menu_1[name_lang]['name'] + "')\").click()")
            _recursive_print_menu(menu_1['children'], level+1, menu_0=menu_1, lang=lang)
        if menu_0 is not None:
            _check_menu_data(menu_1, level, name_lang, menu_0)
        else:
            _check_menu_data(menu_1, level, name_lang)
    if menu_0 is not None:
        # print next_lvl_slide_root + menu_0[name_lang]['name'] + "')"
        _se2lib.click_element(next_lvl_slide_root + menu_0[name_lang]['name'] + "')")
        BuiltIn().sleep('500ms')


def _check_menu_data(menu, level, name_lang, parent=None):
    # if parent is not None:
    #     print "level: " + str(level) + ", parent: " + parent[name_lang]['name'] + ", name: " + menu[name_lang]['name']
    # else:
    #     print "level: " + str(level) + ", parent: Root" + ", name: " + menu[name_lang]['name']

    _se2lib = BuiltIn().get_library_instance('Selenium2Library')
    if menu[name_lang]['link'] is not None:
        href_link = menu[name_lang]['link']
    else:
        href_link = ''
    if parent is not None:
        _se2lib.wait_until_page_contains_element(next_lvl_slide_root + parent[name_lang]['name'] + "')")
        if len(menu['children'])!=0:
            _se2lib.wait_until_page_contains_element(next_lvl_slide_sub + menu[name_lang]['name'] + "') i.icon-arrow-right")
        else:
            _se2lib.wait_until_page_contains_element(next_lvl_slide_sub + menu[name_lang]['name'] + "')[href='" + href_link +"']")
            _se2lib.page_should_not_contain_element(next_lvl_slide_sub + menu[name_lang]['name'] + "') i.icon-arrow-right")
        _se2lib.wait_until_page_contains_element(next_lvl_slide_sub + menu[name_lang]['name'] + "')")
    else:
        if len(menu['children'])!=0:
            _se2lib.wait_until_page_contains_element(first_slide_content + menu[name_lang]['name'] + "') i.icon-arrow-right")
        else:
            _se2lib.wait_until_page_contains_element(first_slide_content + menu[name_lang]['name'] + "')[href='" + href_link +"']")
            _se2lib.page_should_not_contain_element(first_slide_content + menu[name_lang]['name'] + "') i.icon-arrow-right")
        _se2lib.wait_until_page_contains_element(first_slide_content + menu[name_lang]['name'] + "')")

    # for menu_1 in menu_data:
    #     if len(menu_1['children'])!=0:
    #         for menu_2 in menu_1['children']:
    #             if len(menu_2['children'])!=0:
    #                 for menu_3 in menu_2['children']:
    #                     if len(menu_3['children'])!=0:
    #                         for menu_4 in menu_3['children']:
    #                             _check_menu_data(menu_4, 4)
    #                     _check_menu_data(menu_3, 3)
    #             _check_menu_data(menu_2, 2)
    #     _check_menu_data(menu_1, 1)



