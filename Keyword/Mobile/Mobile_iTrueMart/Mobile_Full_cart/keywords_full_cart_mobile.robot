*** Settings ***
Resource          ${CURDIR}/web_element_full_cart.robot
Resource          ../../../Common/keywords_itruemart_common.robot

*** Keywords ***
Full Cart Mobile - Merchant Name Should Not Appear
    Page Should Not Contain    ${XPATH_FULL_CART_MOBILE.lbl_merchant_name}
    Page Should Not Contain Element    ${XPATH_FULL_CART_MOBILE.lbl_merchant_name}

Full Cart Mobile - Go To Mobile Cart Page
    Go to    ${ITM_MOBILE_URL}/cart

Full Cart Mobile - User Click Next
    Wait Until Element Is Visible    ${CartNext_Mobile}    20s
    Click Element    ${CartNext_Mobile}

Full Cart Mobile - Full Cart Is Displayed
    Wait Until Page Contains Element    ${XPATH_FULL_CART_MOBILE.div_container}    ${TIMEOUT}
    Wait Until Page Contains    ${XPATH_FULL_CART_MOBILE.lbl_items_in_cart}
    Page Should Contain Element    ${XPATH_FULL_CART_MOBILE.div_container}

Full Cart Mobile - User Click Next Process On Cart Page
    Wait Until Page Contains Element    ${XPATH_FULL_CART_MOBILE.btn_proceed}    60s
    Wait Until Element Is Visible    ${XPATH_FULL_CART_MOBILE.btn_proceed}    60s
    Click Element    ${XPATH_FULL_CART_MOBILE.btn_proceed}

Full Cart Mobile - Delete Specific Item in Cart
    [Arguments]    ${inventory_id}
    Full Cart Mobile - Full Cart Is Displayed
    ${result}=    Run Keyword And Return Status    Wait Until Element Is Visible    //*[@id="inventory_id-${inventory_id}"]/div/div[2]/div[4]/div[2]/a    5s
    Click Element    //*[@id="inventory_id-${inventory_id}"]/div/div[2]/div[4]/div[2]/a
    Sleep    3s
    Mobile - Wait Until Ajax Loading Is Not Visible
