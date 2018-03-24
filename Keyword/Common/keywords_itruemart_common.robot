*** Settings ***
Library           DateTime
Library           String
Resource          ${CURDIR}/web_element_itruemart.robot    #Library    ${CURDIR}/../../../Python_Library/helper.py
Resource          ${CURDIR}/WebElement_Common.robot    #Resource    ${CURDIR}/../Resources/Page_objects/header/header_page_object.robot
Library           ${CURDIR}/../../Python_Library/helper.py
Library           Selenium2Library
Resource          ../../Resource/init.robot

*** Keywords ***
Go To Home Page
    Go To    ${HOST}

Helper Convert To String
    [Arguments]    ${data}
    ${data}=    helper.Py Convert To String    ${data}
    [Return]    ${data}

Helper Convert To Float
    [Arguments]    ${data}
    ${data}=    helper.Py Convert To Float    ${data}
    [Return]    ${data}

Helper Convert To Int
    [Arguments]    ${data}
    ${data}=    helper.Py Convert To INt    ${data}
    [Return]    ${data}

Convert Day Add Zero Prefix
    [Arguments]    ${number}
    ${number}=    Helper Convert To String    ${number}
    ${length_day}=    Get Length    ${number}
    ${return}=    Run Keyword If    '${length_day}' == '1'    Set Variable    0${number}
    ...    ELSE    Set Variable    ${number}
    Return From Keyword    ${return}

Convert Month Add Zero Prefix
    [Arguments]    ${number}
    ${number}=    Helper Convert To String    ${number}
    ${length_month}=    Get Length    ${number}
    ${return}=    Run Keyword If    '${length_month}' == '1'    Set Variable    0${number}
    ...    ELSE    Set Variable    ${number}
    Return From Keyword    ${return}

Get Date By Adding Days
    [Arguments]    ${add_day}=0
    ${current_date} =    Get Current Date
    ${date} =    Add Time To Date    ${current_date}    ${add_day} days
    Return From Keyword    ${date}

Get User ID
    Go To    ${ITM_URL}/test/user
    Wait Until Element Is Visible    //i[1]
    ${group}=    Get Text    //i[1]
    #Log to console    ${group}
    ${idx}=    Set Variable If    ${group} == "guest"    2    3
    ${user_type}=    Set Variable If    ${group} == "guest"    non-user    user
    ${user_id}=    Get Text    //i[${idx}]
    ${user_id}=    Remove String    ${user_id}    "
    Set Test Variable    ${TV_user_type}    ${user_type}
    Set Test Variable    ${TV_user_id}    ${user_id}
    Set Test Variable    ${TV_user_group}    ${group}
    #Log to console    user_id=${TV_user_id}
    [Return]    ${user_id}

Get User Type By User ID
    [Arguments]    ${user_id}=${TV_user_id}
    ${length} =    Get Length    ${user_id}
    ${user_type}=    Set Variable If    ${length} == "13"    non-user    user
    Set Test Variable    ${TV_user_type}    ${user_type}
    [Return]    ${user_type}

Go to level d url
    [Arguments]    ${product-pkey}
    Go to    ${HOST}/products/items-${product-pkey}.html

Go To Level D Url Mobile
    [Arguments]    ${product-pkey}
    Go to    ${MOBILE-HOME}/products/items-${product-pkey}.html

Go To Level D Normal Product
    ${inv_id}=    Get From Dictionary    ${TEST_VAR}    inv_id_normal
    ${product-pkey}=    Get Product Pkey    ${inv_id}
    Log to console    product-pkey=${product-pkey}
    Go To    ${HOST}/products/items-${product-pkey}.html

Wait Until Ajax Loading Is Not Visible
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${XPATH_COMMON.ajax_loading}    5s
    Wait Until Element Is Not Visible    ${XPATH_COMMON.ajax_loading}    60s

Mobile - Wait Until Ajax Loading Is Not Visible
    Log to console    ====xpath-ajax-loading-mobile=${XPATH_COMMON.ajax_loading}====
    Wait Until Element Is Not Visible    ${XPATH_COMMON.ajax_loading}    60s
    #ajaxloading-widget-icon-container

User Click Logout Button
    Mouse Over    id=user
    Element Should Be Visible    //a[@id="user"]/following-sibling::ul/li[4]/a
    Click Element    //a[@id="user"]/following-sibling::ul/li[4]/a

Convert String To Float
    [Arguments]    ${data}
    ${type}=    helper.Get Type    ${data}
    Run Keyword If    '${data}' == '0.00'    Return From Keyword    ${data}
    #Run Keyword If    "${type}" == "<type 'unicode'>"    Return From Keysword    ${data}
    ${data}=    Replace String    ${data}    ,    ${EMPTY}
    ${data}=    helper.Py Convert To Float    ${data}
    Return From Keyword    ${data}

Convert String To Integer
    [Arguments]    ${data}
    ${data}=    Replace String    ${data}    ,    ${EMPTY}
    ${data}=    helper.Py Convert To Integer    ${data}
    Return From Keyword    ${data}

Initialize Suite Variable
    [Arguments]    ${page}
    ${dict}=    Create Dictionary    page=${page}
    Set Test Variable    ${TEST_VAR}    ${dict}

User Click Login Link On Top Bar
    Wait Until Element Is Visible    ${XPATH_HEADER.lnk_login}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_HEADER.lnk_login}

User Click Login Link On Top Bar Mobile
    Wait Until Element Is Visible    ${XPATH_HEADER_MOBILE.lnk_login}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_HEADER_MOBILE.lnk_login}

Go To Login Page
    Go To    ${ITM_URL}/auth/login

Go To Logout
    Go To    ${ITM_URL}/auth/logout

User Open Home page
    Open Browser    ${ITM_URL}    ${BROWSER}
    Maximize Browser Window

User Open Home page Mobile
    Open Browser    ${MOBILE-HOME}    ${BROWSER}
    Maximize Browser Window

User Click iTruemart Logo
    Wait Until Element Is Visible    ${XPATH_HEADER.img_itm_logo}    ${TIMEOUT}
    Click Element    ${XPATH_HEADER.img_itm_logo}

User Click iTruemart Logo On Checkout
    Wait Until Element Is Visible    ${XPATH_HEADER.img_itm_logo_checkout}    ${TIMEOUT}
    Click Element    ${XPATH_HEADER.img_itm_logo_checkout}

User Click Cart Icon On Top Right
    Wait Until Element Is Visible    ${XPATH_HEADER.ico_cart}    ${TIMEOUT}
    Click Element    ${XPATH_HEADER.ico_cart}

User Click Display Name On Header
    Wait Until Element Is Visible    ${XPATH_HEADER.display_name}    ${TIMEOUT}
    Click Element    ${XPATH_HEADER.display_name}

User Click Sub Menu Order Tracking
    Wait Until Element Is Visible    ${XPATH_HEADER.profile_sub_menu}    ${TIMEOUT}
    Click Element    ${XPATH_HEADER.profile_sub_menu}

Display Logo iTrueMart
    Wait Until Element Is Visible    //a[@title="iTruemart"]    ${TIMEOUT}

Check Type And Convert String To Float
    [Arguments]    ${val}
    ${type}=    Get Type    ${val}
    ${status}    ${msg}=    Run Keyword And Ignore Error    Should Not Contain    ${type}    float
    ${val} =    Run Keyword If    "${status}" == "FAIL"    Set Variable    ${val}
    ...    ELSE    Convert String To Float    ${val}
    [Return]    ${val}

Count product LvC
    [Arguments]    ${URL}    ${Count_expected}
    Open Browser    ${URL}    chrome
    ${Count}    Get Matching Xpath Count    //*[@class="over_lvb"]
    Should Be Equal    ${Count}    ${Count_expected}

Get Product Name From List
    [Arguments]    ${URL}
    Open Browser    ${URL}    chrome
    ${Count}=    Get Matching Xpath Count    //*[@class="over_lvb"]
    ${All_Product}=    Create List
    :FOR    ${INDEX}    IN RANGE    1    ${Count}+1
    \    ${Product_Name}=    Get Text    //*[@class="over_lvb"][${INDEX}]//*[@class="name-display p-box-slide"]
    \    Append To List    ${All_Product}    ${Product_Name}
    Log    ${All_Product}
    [Return]    ${All_Product}
