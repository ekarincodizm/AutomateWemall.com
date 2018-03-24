from robot.api import logger
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.remote.webelement import WebElement

class ExtendedElement(object):
    def __init__(self):
        super(ExtendedElement, self).__init__()

    # pylint: disable=arguments-differ
    def click_element_and_wait_angular_ready(self, locator, skip_ready=False):
        """Clicks an element identified by ``locator``.

        Arguments:
        - ``locator``: The locator to find requested element. Key attributes for
                       arbitrary elements are ``id`` and ``name``. See `introduction` for
                       details about locating elements.
        - ``skip_ready``: A boolean flag to skip the wait for page ready. (Default False)

        Examples:
        | Click Element | css=div.class |
        | Click Element | css=div.class | True |
        """
        # pylint: disable=no-member
        # self._se2lib._info("Clicking element '%s'." % locator)
        # self._se2lib._element_find(locator, True, True).click()
        self._se2lib.click_element(locator)
        if not skip_ready:
            # pylint: disable=no-member
            self._wait_until_page_ready()
