from sys import exc_info
from time import sleep
from robot import utils
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.remote.webelement import WebElement
from selenium.webdriver.support.expected_conditions import staleness_of, visibility_of
from selenium.webdriver.support.ui import WebDriverWait
# from ExtendedSelenium.utis import BrowserCache
# from Selenium2Library.keywords import _WaitingKeywords

class ExtendedWaiting(object):
    def __init__(self):
        # self._cache = BrowserCache()
        super(ExtendedWaiting, self).__init__()
        
    def wait_until_angular_ready(self, timeout=None, error=None):
        """Waits until [https://goo.gl/Kzz8Y3|AngularJS] is ready to process the next request or
        ``timeout`` expires.
        You generally *do not* need to call this keyword directly,
        below is the list of keywords which already call this keyword internally:
        | `Click Button`                 |
        | `Click Element`                |
        | `Click Element At Coordinates` |
        | `Click Image`                  |
        | `Click Link`                   |
        | `Double Click Element`         |
        | `Input Password`               |
        | `Input Text`                   |
        | `Open Browser`                 |
        | `Select All From List`         |
        | `Select Checkbox`              |
        | `Select From List`             |
        | `Select From List By Index`    |
        | `Select From List By Label`    |
        | `Select From List By Value`    |
        | `Select Radio Button`          |
        | `Submit Form`                  |
        Arguments:
        - ``timeout``: The maximum value to wait for [https://goo.gl/Kzz8Y3|AngularJS]
                       to be ready to process the next request.
                       See `introduction` for more information about ``timeout`` and
                       its default value.
        - ``error``: The value that would be use to override the default error message.
        See also `Wait For Condition`, `Wait Until Page Contains`,
        `Wait Until Page Contains Element`, `Wait Until Element Is Visible`
        and BuiltIn keyword `Wait Until Keyword Succeeds`.
        Examples:
        | Wait Until Angular Ready | 15s |
        """
        # pylint: disable=no-member
        timeout = self._get_timeout_value(timeout, self._implicit_wait_in_secs)
        if not error:
            error = 'AngularJS is not ready in %s' % self._format_timeout(timeout)
        # we add more validation here to support transition
        # between AngularJs to non AngularJS page.
        # pylint: disable=no-member
        script = self.NG_WRAPPER % {'prefix': 'var cb=arguments[arguments.length-1];'
                                              'if(window.angular){',
                                    'handler': 'function(){cb(true)}',
                                    'suffix': '}else{cb(true)}'}
        # pylint: disable=no-member
        browser = self._se2lib._current_browser()
        browser.set_script_timeout(timeout)
        try:
            WebDriverWait(browser, timeout, self._inputs['poll_frequency']).\
                until(lambda driver: driver.execute_async_script(script), error)
        except TimeoutException:
            # prevent double wait
            pass
        # pylint: disable=bare-except
        except:
            self._se2lib._debug(exc_info()[0])
            # still inflight, second chance. let the browser take a deep breath...
            sleep(self._inputs['browser_breath_delay'])
            try:
                WebDriverWait(browser, timeout, self._inputs['poll_frequency']).\
                    until(lambda driver: driver.execute_async_script(script), error)
            # pylint: disable=bare-except
            except:
                # instead of halting the process because AngularJS is not ready
                # in <TIMEOUT>, we try our luck...
                self._se2lib._debug(exc_info()[0])
            finally:
                browser.set_script_timeout(self._timeout_in_secs)
        finally:
            browser.set_script_timeout(self._timeout_in_secs)

    def wait_until_location_contains(self, expected, timeout=None, error=None):
        """Waits until current URL contains ``expected``.
        Fails if ``timeout`` expires before the ``expected`` URL presents on the page.

        Arguments:
        - ``expected``: The expected URL value.
        - ``timeout``: The maximum value to wait for URL to contains ``expected``.
                       See `introduction` for more information about ``timeout`` and
                       its default value.
        - ``error``: The value that would be use to override the default error message.

        See also `Wait Until Location Does Not Contain`, `Wait Until Page Contains`,
        `Wait Until Page Contains Element`, `Wait For Condition`,
        `Wait Until Element Is Visible` and BuiltIn keyword `Wait Until Keyword Succeeds`.

        Examples:
        | Wait Until Location Contains | www | 15s |
        """
        # pylint: disable=no-member
        timeout = self._get_timeout_value(timeout, self._timeout_in_secs)
        if not error:
            error = "Location did not contain '%s' after %s" %\
                    (expected, self._format_timeout(timeout))
        WebDriverWait(self, timeout, self._inputs['poll_frequency']).\
            until(lambda driver: expected in driver.extended_get_location(), error)

    @staticmethod
    def _get_timeout_value(timeout, default):
        """Returns default timeout when timeout is None."""
        return default if timeout is None else utils.timestr_to_secs(timeout)

    def _format_timeout(self, timeout):
        timeout = utils.timestr_to_secs(timeout) if timeout is not None else self._timeout_in_secs
        return utils.secs_to_timestr(timeout)

    def _current_browser(self):
        if not self._cache.current:
            raise RuntimeError('No browser is open')
        return self._cache.current

    def _wait_until_html_ready(self, browser, timeout):
        """Wait until HTML is ready by using stale check."""
        # pylint: disable=no-member
        delay = self._inputs['browser_breath_delay']
        if delay < 1:
            delay *= 10
        # let the browser take a deep breath...
        sleep(delay)
        try:
            # pylint: disable=no-member
            WebDriverWait(None, timeout, self._inputs['poll_frequency']).\
                until_not(staleness_of(browser.find_element_by_tag_name('html')), '')
        # pylint: disable=bare-except
        except:
            # instead of halting the process because document is not ready
            # in <TIMEOUT>, we try our luck...
            # pylint: disable=no-member
            self._se2lib._debug(exc_info()[0])
            
    def _wait_until_page_ready(self, *args, **kwargs):
        """Semi blocking API that incorporated different strategies for cross-browser support."""
        responses = {
            'page_ready_keywords': [],
            'response': kwargs.pop('default', None)
        }
        # pylint: disable=no-member
        if not self._inputs['block_until_page_ready']:
            return responses
        # pylint: disable=no-member
        browser = kwargs.pop('browser', self._se2lib._current_browser())
        locator_position = int(kwargs.pop('locator_position', 0))
        prefix = kwargs.pop('prefix', 'var cb=arguments[arguments.length-1];if(window.angular){')
        skip_stale_check = bool(kwargs.pop('skip_stale_check', False))
        # pylint: disable=no-member
        if self._inputs['ensure_jq'] and not skip_stale_check:
            # only during possible page re-load/re-route
            jquery_bootstrap = self.JQUERY_BOOTSTRAP % {'jquery_url': self.JQUERY_URL}
            prefix = 'if(!window.jQuery){%(jquery_bootstrap)s}%(prefix)s' % \
                {'jquery_bootstrap': jquery_bootstrap, 'prefix': prefix}
        # pylint: disable=no-member
        script = self.NG_WRAPPER % {'prefix': prefix,
                                    'handler': kwargs.pop('handler', 'function(){cb(true)}'),
                                    'suffix': kwargs.pop('suffix', '}else{cb(false)}')}
        # pylint: disable=no-member
        default_timeout = self._implicit_wait_in_secs if skip_stale_check \
            else self._timeout_in_secs
        # pylint: disable=no-member
        timeout = self._get_timeout_value(kwargs.pop('timeout', None), default_timeout)
        if len(args) > locator_position and not isinstance(args[locator_position], WebElement):
            args = list(args)
            args[locator_position] = self._se2lib._element_find(args[locator_position], True, True)
        if not skip_stale_check:
            self._wait_until_html_ready(browser, timeout)
        responses['response'] = self._wait_until_script_ready(browser, timeout, script, *args)
        # pylint: disable=no-member
        responses['page_ready_keywords'] = [self._builtin.run_keyword(keyword)
                                            for keyword in self._page_ready_keyword_list]
        return responses

    def _wait_until_script_ready(self, browser, timeout, script, *args):
        response = None
        # pylint: disable=no-member
        selenium_timeout = self._timeout_in_secs
        try:
            # pylint: disable=no-member
            if timeout != selenium_timeout:
                browser.set_script_timeout(timeout)
            response = browser.execute_async_script(script, *args)
        except TimeoutException:
            # instead of halting the process because document is not ready
            # in <TIMEOUT>, we try our luck...
            # pylint: disable=no-member
            self._se2lib._debug(exc_info()[0])
        finally:
            if timeout != selenium_timeout:
                # pylint: disable=no-member
                browser.set_script_timeout(selenium_timeout)
        return response