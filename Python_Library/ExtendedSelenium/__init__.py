from robot.libraries.BuiltIn import BuiltIn
from keywords.extendedwaiting import ExtendedWaiting
from keywords.extendedelement import ExtendedElement
from keywords.extendedformelement import ExtendedFormElement

__all__ = ['ExtendedSelenium']

class ExtendedSelenium(ExtendedWaiting, ExtendedElement, ExtendedFormElement):
    # DO NOT KNOW What is for?
    JQUERY_URL = '//code.jquery.com/jquery-1.11.3.min.js'
    JQUERY_BOOTSTRAP = 'var a=document.getElementsByTagName(\'head\')[0];' \
                       'var b=document.createElement(\'script\');' \
                       'b.type=\'text/javascript\';b.src=document.location.' \
                       'protocol+\'%(jquery_url)s\';a.appendChild(b);'
    NG_WRAPPER = '%(prefix)s' \
                 'var $inj;try{$inj=angular.element(document.querySelector(' \
                 '\'[data-ng-app],[ng-app],.ng-scope\')||document).injector()||' \
                 'angular.injector([\'ng\'])}catch(ex){' \
                 '$inj=angular.injector([\'ng\'])};$inj.get=$inj.get||$inj;' \
                 '$inj.get(\'$browser\').notifyWhenNoOutstandingRequests(%(handler)s)' \
                 '%(suffix)s'
    PAGE_READY_WRAPPER = 'var cb=arguments[arguments.length-1];if(window.jQuery){' \
                         '$(document).ready(function(){cb(true)})}else{'\
                         '%(jquery_bootstrap)s' \
                         'cb(document.readyState===\'complete\' && document.body && ' \
                         'document.body.childNodes.length)}'

    def __init__(self, implicit_wait=None, **kwargs):
        self._se2lib = BuiltIn().get_library_instance('Selenium2Library')
        self._inputs = {
            'block_until_page_ready': bool(kwargs.pop('block_until_page_ready', True)),
            'browser_breath_delay': float(kwargs.pop('browser_breath_delay', 0.05)),
            'ensure_jq': bool(kwargs.pop('ensure_jq', True)),
            'poll_frequency': float(kwargs.pop('poll_frequency', 0.2)),
        }
        self._builtin = BuiltIn()
        ExtendedWaiting.__init__(self)

        self._timeout_in_secs = self._se2lib._timeout_in_secs

        if implicit_wait is None:
            self._implicit_wait_in_secs = self._se2lib._implicit_wait_in_secs
        else:
            self._implicit_wait_in_secs = float(implicit_wait)
        self._page_ready_keyword_list = []
    
    def extended_get_location(self):
        # AngularJS support
        response = self._wait_until_page_ready(handler='function(){cb(location.href)}',
                                               suffix='}else{cb(location.href)}',
                                               timeout=self._implicit_wait_in_secs)['response']
        # retry with sync approach
        if response is None:
            response = self._se2lib._current_browser().execute_script('return location.href')
        # fallback
        if response is None:
            response = self._se2lib._current_browser().get_current_url()
        return response
