*** Settings ***
Resource    ${CURDIR}/web_element_order_history.robot
Resource    ${CURDIR}/../../../Database/PCMS/keyword_order.robot

*** Variables ***

*** Keywords ***
End Test Case
    Remove Order    ${TV_order_id}
    Close All Browsers

Click Open Menu Order History
    # ${user-menu}=    Run Keyword If  '${IS_WEMALL}' == 'on'    Set variable    ${wm-header-user-menu}
    #                 ...    ELSE    Set variable    ${header-user-menu}

    # ${user-menu-history}=    Run Keyword If  '${IS_WEMALL}' == 'on'    Set variable    ${wm-header-user-menu-history}
    #                 ...    ELSE    Set variable    ${header-user-menu-history}

    # Wait Until Element Is Visible    ${user-menu}
    # Click Element    ${user-menu}
    # Click Element    ${user-menu-history}

    Go To   ${ITM_URL}/member/orders

Get Image From Item List
    ${image}=    Selenium2Library.Get Element Attribute    ${header-user-menu-history-image}@src
    [Return]    ${image}

Verify Order History Page Exist
    Wait Until Element Is Visible    ${order_tracking_list_div}    30s
    Location Should Contain    /member/orders

Expect Delivery Text On Order History
    [Arguments]   ${customer_email}=robotautomate@gmail.com   ${customer_password}=true1234
    Login User to iTrueMart  ${customer_email}   ${customer_password}
    Go to Order Tracking Page
    # Sleep    60
    Page Should Contain    ${delivery_text_th}

Expect Delivery Date On Order History
    [Arguments]    ${expected_delivery_date}=10 มิ.ย. 69 - 16 มิ.ย. 69
    ${actuat_delivery_date}=    Get Text    //*[text()="${var.order_id}"]/../../../../../tbody/tr[1]/td[4]/div[2]/span
    Should Be Equal    ${expected_delivery_date}    ${actuat_delivery_date}

Expect EN Delivery Text On Order History
    [Arguments]   ${customer_email}=robotautomate@gmail.com   ${customer_password}=true1234
    Login User to iTrueMart   ${customer_email}  ${customer_password}
    Go to EN Order Tracking Page
    Page Should Contain    ${delivery_text_en}

Expect EN Delivery Date On Order History
    [Arguments]    ${expected_delivery_date}=10 Jun 26
    ${actuat_delivery_date}=    Get Text    //*[text()="${var.order_id}"]/../../../../../tbody/tr[1]/td[4]/div[2]/span
    Should Be Equal    ${expected_delivery_date}    ${actuat_delivery_date}

Prepare CCW Order
    [Arguments]   ${customer_ref_id}=28951449   ${customer_email}=robotautomate03@gmail.com
    Prepare Order    ${customer_ref_id}    ${customer_email}    1    draft    failed

Prepare CS Order
    [Arguments]   ${customer_ref_id}=28951449   ${customer_email}=robotautomate03@gmail.com
    Prepare Order    ${customer_ref_id}    ${customer_email}    8    new    success    en

Expect Two Corrent Delivery Dates On Order History
    [Arguments]    ${expected_delivery_date_1}=09 มิ.ย. 69 - 16 มิ.ย. 69
    ...            ${expected_delivery_date_2}=10 มิ.ย. 69 - 12 มิ.ย. 69
    ${actuat_delivery_date_1}=    Get Text    //*[text()="${var.order_id}"]/../../../../../tbody/tr[1]/td[4]/div[2]/span
    ${actuat_delivery_date_2}=    Get Text    //*[text()="${var.order_id}"]/../../../../../tbody/tr[2]/td[4]/div[2]/span

    Should Be Equal    ${expected_delivery_date_1}    ${actuat_delivery_date_1}
    Should Be Equal    ${expected_delivery_date_2}    ${actuat_delivery_date_2}

Expect Two Current Delivery Dates On Order History
    [Arguments]    ${expected_delivery_date_1}=09 มิ.ย. 69 - 16 มิ.ย. 69
    ...            ${expected_delivery_date_2}=10 มิ.ย. 69 - 12 มิ.ย. 69
    ${actual_delivery_date_1}=    Get Text    //*[text()="${var.order_id}"]/../../../../../tbody/tr[1]/td[4]/div[2]/span
    ${actual_delivery_date_2}=    Get Text    //*[text()="${var.order_id}"]/../../../../../tbody/tr[2]/td[4]/div[2]/span

    Should Be Equal    ${expected_delivery_date_1}    ${actual_delivery_date_1}
    Should Be Equal    ${expected_delivery_date_2}    ${actual_delivery_date_2}


Prepare Product Which Has Only One Delivery Date
    Prepare Product Delivery Day    3    3

Prepare Product Which Has Two Delivery Dates
    Prepare Product Delivery Day    3    7