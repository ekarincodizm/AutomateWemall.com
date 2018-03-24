from selenium import webdriver
from selenium.webdriver import ActionChains

# def py_convert_to_float(data) : 
# 	return float(data)

# def py_convert_to_string(data) : 
# 	return str(data)

def py_convert_to_int(data):
	return int(data)


def is_key_exist(dicts, key) : 
	if key in dicts :
		return True  
	else : 
		return False   

def is_same_as(product, product_on_cart) : 
	if product in product_on_cart : 
		return True 
	else : 
		return False

def is_visible(self, locator):
    element = self._element_find(locator, True, False)
    if element is not None:
        return element.is_displayed()
    return None
# def is_checked(locator) : 
# 	driver = webdriver.Chrome()
# 	try : 
# 		#driver.should_be_checked(locator)
# 		isChecked = driver.find_element_by_xpath(locator).

# 	except AssertionError : 
# 		return False
# 	else : 
# 		return True


# def is_checked(locator):

# 	driver = webdriver.Chrome()

#     try:
#     	driver.should_be_checked(locator)
#     except AssertionError:
# 		return False
#     else :
#        return True	
