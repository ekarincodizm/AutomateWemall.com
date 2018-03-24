#**********************************************
#	@author   Preme Wongpatimakorn
#	@since    April 27, 2016
#	@version   1.0.0
#
#**********************************************

*** Settings ***
Resource    ${CURDIR}/web_element_footer.robot

*** Keywords ***

Footer - Wemall Footer Is Displayed
	Element Should Be Visible  ${XPATH_FOOTER.container}