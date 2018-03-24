from selenium import webdriver

def input_text_admin_wemall():
    form_textfield = webdriver.find_element_by_id('inputPassword')
    form_textfield.send_keys("hulktestpassword")