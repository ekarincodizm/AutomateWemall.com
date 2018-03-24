*** Settings ***
Library           Selenium2Library
Resource          WebElement_ThankYouPage.robot
Resource          ../Login/keywords_login.robot    # Library    ${CURDIR}/../../../Python_Library/message_library.py

*** Variables ***

*** Keywords ***
Display Summary Shipping Price On Thankyou As Not Free For Mobile
    Wait Until Element Is Visible     ${XPATH_THANKYOU.lbl_summary_shipping_price}    ${CHECKOUT_TIMEOUT}
    ${shipping-price}=    Get Text    ${XPATH_THANKYOU.lbl_summary_shipping_price}
    Should Not Be Equal As Strings    ${shipping-price}    ฟรี
