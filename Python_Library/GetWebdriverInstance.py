from Selenium2Library import Selenium2Library

# create new class that inherits from Selenium2Library
class GetWebdriverInstance(Selenium2Library):
    # create a new keyword called "get webdriver instance"
    def get_webdriver_instance(self):
        return self._current_browser()