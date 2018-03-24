from selenium.common.exceptions import UnexpectedAlertPresentException
from selenium.common.exceptions import NoAlertPresentException

from selenium import webdriver
# from selenium.webdriver.support.ui import WebDriverWait
# from selenium.webdriver.support import expected_conditions as EC
# from selenium.common.exceptions import TimeoutException

driver = webdriver.Firefox()

def alert_is_present() :
	
	try:
	 	Alert alert = driver.switchTo().alert();
		alert.accept();
	    return True
	except UnexpectedAlertPresentException:
		return False
	except NoAlertPresentException as e: 
	    return False