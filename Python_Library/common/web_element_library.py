from robot.libraries.BuiltIn import BuiltIn

def scroll_to_element(elem, x_offset, y_offset):
    se2lib = BuiltIn().get_library_instance('Selenium2Library')
    x = elem.location['x']
    y = elem.location['y']
    x = x - float(x_offset)
    y = y - float(y_offset)
    se2lib.execute_javascript('window.scrollTo(' + str(x) + ',' + str(y) + ')')
    BuiltIn().sleep('500ms')

def scroll_page_to_offset(x_offset, y_offset):
    se2lib = BuiltIn().get_library_instance('Selenium2Library')
    se2lib.execute_javascript('window.scrollTo(' + str(x_offset) + ',' + str(y_offset) + ')')
    BuiltIn().sleep('500ms')

def scroll_page_to_offset_for_wemall(y_offset):
    se2lib = BuiltIn().get_library_instance('Selenium2Library')
    se2lib.execute_javascript("$('.body-wrapper').animate({scrollTop: " + str(y_offset) + '}, 100);')
    BuiltIn().sleep('500ms')

def scroll_page_to_element_for_wemall(elem):
    se2lib = BuiltIn().get_library_instance('Selenium2Library')
    se2lib.execute_javascript("$('.body-wrapper').animate({scrollTop: $('" + str(elem) + "').offset().top}, 100);")
    BuiltIn().sleep('500ms')

    # browser = BuiltIn().get_variable_value("${BROWSER}")
    # if browser == 'firefox' or browser == 'ff':
    #     se2lib.execute_javascript("$('.body-wrapper').animate({scrollTop: $('" + str(elem) + "').offset().top}, 100);")
    #     BuiltIn().sleep('500ms')
    # else:
    #     se2lib.execute_javascript("$('.body-wrapper').animate({scrollTop: $('" + str(elem) + "').offset().top}, 100);")
    #     BuiltIn().sleep('500ms')
    #     # se2lib.execute_javascript("$(window).scrollTop( $('" + str(elem) + "').offset().top )")
    #     # BuiltIn().sleep('500ms')

