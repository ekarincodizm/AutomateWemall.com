class ExtendedFormElement(object):
    def __init__(self):
        super(ExtendedFormElement, self).__init__()

    def extended_select_checkbox(self, locator):
        """Selects checkbox identified by ``locator``.
        Does nothing if checkbox is already selected.

        Arguments:
        - ``locator``: The locator to find requested checkbox. Key attributes for
                       arbitrary checkboxes are ``id``, and ``name``.
                       See `introduction` for details about locating elements.

        Examples:
        | Select Checkbox | css=input[type="checkbox"] |
        """
        # pylint: disable=no-member
        self._se2lib._info("Selecting checkbox '%s'." % locator)
        element = self._se2lib._get_checkbox(locator)
        if not element.is_selected():
            self._select_checkbox_or_radio_button(locator)

    def _select_checkbox_or_radio_button(self, locator):
        """Select checkbox or radio button with AngularJS support."""
        # pylint: disable=no-member
        self._wait_until_page_ready(locator,
                                    skip_stale_check=True,
                                    prefix='var cb=arguments[arguments.length-1];'
                                           'var el=arguments[0];if(window.angular){',
                                    handler='function(){angular.element(el).'
                                            'prop(\'checked\',true).triggerHandler(\'click\');'
                                            'cb(true)}',
                                    suffix='}else{el.click();cb(false)}')