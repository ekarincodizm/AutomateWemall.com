from robot.libraries.BuiltIn import BuiltIn
from selenium.webdriver.common.action_chains import ActionChains

def get_webdriver_instance():
    se2lib = BuiltIn().get_library_instance('Selenium2Library')
    return se2lib._current_browser()

def get_element(driver, by_locator):
    by = by_locator['by']
    locator = by_locator['locator']
    if by == 'id' :
        return driver.find_element_by_id(locator)
    elif by == 'name' :
        return driver.find_element_by_name(locator)
    elif by == 'xpath' :
        print 'return xpath'
        return driver.find_element_by_xpath(locator)
    elif by == 'link_text' :
        return driver.find_element_by_link_text(locator)
    elif by == 'partial_link_text' :
        return driver.find_element_by_partial_link_text(locator)
    elif by == 'tag_name' :
        return driver.find_element_by_tag_name(locator)
    elif by == 'class_name' :
        return driver.find_element_by_class_name(locator)
    elif by == 'css_selector' :
        return driver.find_element_by_css_selector(locator)
    else :
        return None


def find_element_by_css(element, css_locator):
    try:
        return driver.find_element_by_css_selector(css_locator)
    except:
         return None
   

def actions_send_keys(by_locator, text):
    driver = get_webdriver_instance()
    element = get_element(driver, by_locator)
    print 'element'
    # element = driver.find_element_by_xpath(locator)
    element.click()
    actions = ActionChains(driver)
    actions.send_keys(text)
    actions.perform()


