*** Settings ***
Library         Selenium2Library
Library           ${CURDIR}/../../../../Python_Library/cart.py
Resource        ${CURDIR}/webelement_cart.robot
Resource        ${CURDIR}/../../wemall/cart/keywords_cart.robot
Resource        ${CURDIR}/../../../API/PCMS/Shop/keywords_policy.robot

*** Keywords ***
Metchant Name Should Not Appear
    Page Should Not Contain    ${MERCHANT-TEXT}

Go To Cart Page
    Go to    ${ITM_URL}/cart

User Click Next Process On Cart Page
    Wait Until Element Is Visible   ${BTN-NEXT-XAPTH}    20s
    Wemall Common - Close Live Chat
    Page Should Contain Element    ${BTN-NEXT-XAPTH}
    # Click Element    ${BTN-NEXT-XAPTH}
    ${is_click}=   Run Keyword And Return Status   Click Element  ${BTN-NEXT-XAPTH}
    Run Keyword If   '${is_click}' == '${False}'   Click Element  ${BTN-NEXT-XAPTH}

Wait For Cart Loading
    Sleep    3s

Clear Shops And Policies
    Delete 2 Shops
    Delete 2 Shop Policies
    #Assign Backup Shop Id Back To Variant
    Email Sms - Assign Backup Shop Id Back To Variant
    Close All Browsers

Get Selected Item Quantity
    Wait Until Element Is Visible    ${CART_ITEM_QUANTITY}
    ${item_q}=    Get Text    ${CART_ITEM_QUANTITY}
    Page Should contain Element    jquery=span[data-noti-number=${item_q}]

Remove First Product
    Wait Until Element Is Visible    ${REMOVE_PRODUCT}
    Click Element    ${REMOVE_PRODUCT}

Clear Cart By Customer Email
    [Arguments]    ${customer_email}=${EMPTY}
    Run Keyword If    "${customer_email}"!="${EMPTY}"    clear_cart_by_email    ${customer_email}
    ...    ELSE    Log To Console    Cannot clear cart : 'CUSTOMER IS EMPTY'

