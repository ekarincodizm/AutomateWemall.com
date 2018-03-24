*** Settings ***
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           OperatingSystem
Library           String

Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/API/common/api_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Order_History/keywords_order_history.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/keyword_order.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Email/keywords_email_sms.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Shop/keywords_shop.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/portal_page/portal_page_keywords.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Shop/keywords_policy.robot

*** Variables ***
${customer_email}   robotautomate03@gmail.com
${customer_password}   true1234
${customer_ref_id}   28951449

*** Test Cases ***
TC_iTM_01762 Correct format input
    [Tags]    TC_iTM_01762    ready    QCT      regression
    ${order_id}=    Prepare Order
    Set Test Variable    ${TV_order_id}    ${order_id}
    Open Browser    ${ITM_URL}    ${BROWSER}
    User Login From Header Bar   ${customer_email}   ${customer_password}
    Click Open Menu Order History
    ${image_path}=    Get Image From Item List
    ${count_image_path}=    Get Count    ${image_path}    //
    Should Be Equal    '${count_image_path}'    '1'
    #wrong path
    #[Teardown]    End Test Case

TC_iTM_01761 Incorrect format input
    [Tags]    TC_iTM_01761    ready    QCT      regression
    ${order_id}=    Prepare Order Wrong Image path
    Set Test Variable    ${TV_order_id}    ${order_id}
    Open Browser    ${ITM_URL}    ${BROWSER}
    User Login From Header Bar   ${customer_email}   ${customer_password}
    Click Open Menu Order History
    ${image_path}=    Get Image From Item List
    ${count_image_path}=    Get Count    ${image_path}    //
    Should Be Equal    '${count_image_path}'    '1'
    [Teardown]    End Test Case

TC_iTM_02210 Display delivery min / max and delivery text on order history page When Buy Product Fail Using CCW
    [Tags]    TC_iTM_02210    Ready     regression
    # 10 มิ.ย. 69 - 16 มิ.ย. 69
    Given Open iTrueMart Portal
    and DB Order - Prepare Clear Order
    AND Prepare CCW Order   ${customer_ref_id}    ${customer_email}
    And Prepare Product Which Has Two Delivery Dates
    Then Expect Delivery Text On Order History   ${customer_email}  ${customer_password}
    And Expect Delivery Date On Order History
    [Teardown]    Run keywords    Restore shop delivery day
     ...    AND    Delete prepared order
     ...    AND    Close All Browsers

TC_iTM_02211 Display delivery min / max and delivery text on order history page When Buy Product Success Using CS
    [Tags]    TC_iTM_02211    Ready     regression
    Given Open iTrueMart Portal
    and DB Order - Prepare Clear Order
    AND Prepare CS Order  ${customer_ref_id}   ${customer_email}
    And Prepare Product Which Has Only One Delivery Date
    Then Expect EN Delivery Text On Order History   ${customer_email}   ${customer_password}
    And Expect EN Delivery Date On Order History
    [Teardown]    Run keywords    Restore shop delivery day
    ...    AND    Delete prepared order
    ...    AND    Close All Browsers

TC_iTM_05360 Display Correct Delivery Text And Dates When Order Has 2 Items
    [Tags]    TC_iTM_05360    Ready    tc5      regression  deliverytime
    Given Prepare Two Shops
    AND Prepare Two Variants
    AND Prepare Order Which Has Two Items With Different Shop Id  ${customer_ref_id}   ${customer_email}
    AND Open iTrueMart Portal
    Then Expect Delivery Text On Order History   ${customer_email}  ${customer_password}
    And Expect Two Current Delivery Dates On Order History
    [Teardown]    Run Keywords    Delete 2 Shops
    ...    AND    Delete 2 Shop Policies
    ...    AND    Email Sms - Assign Backup Shop Id Back To Variant
    ...    AND    Remove Order
    ...    AND    Close All Browsers
