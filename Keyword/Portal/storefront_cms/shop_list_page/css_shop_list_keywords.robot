*** Settings ***
Resource        ${CURDIR}/../../../API/common/api_keywords.robot
Resource        ${CURDIR}/../../wemall/common/web_common_keywords.robot
Resource        ${CURDIR}/../common_page/css_common_page_keywords.robot
Resource        ${CURDIR}/../../../API/api_storefronts/storefront_keywords.robot
Library         ${CURDIR}/../../../API/api_storefronts/storefront.py
Resource        ${CURDIR}/../../wemall/storefront_page/storefront_page_keywords.robot
Resource        ${CURDIR}/webelement_shop_list_page.robot
Library         ${CURDIR}/../../../../Python_Library/requestapi.py
Library         ${CURDIR}/../../../../Python_Library/jsonLibrary.py
Library         ${CURDIR}/../../../../Python_Library/sortedlibrary.py
Library         Collections
Library         HttpLibrary.HTTP
Library         css_shop_list.py
Library         Selenium2Library
Library         ${CURDIR}/../../../../Python_Library/ExtendedSelenium/

*** Keywords ***
Click Preview Storefront Page
    [Arguments]    ${shopId}    ${view}
    Wait Until Element Is Visible    ${table_shop_list} tr[id='${shopId}-${view}'] td:eq(0)      2s
    Click Element and Wait Angular Ready    ${table_shop_list} tr[id='${shopId}-${view}'] td:eq(0)

Go To Manage Storefront Page
    [Arguments]    ${shopId}    ${view}
    Wait Until Element Is Visible    ${table_shop_list} tr[id='${shopId}-${view}'] td:eq(3) a      2s
    Click Element and Wait Angular Ready    ${table_shop_list} tr[id='${shopId}-${view}'] td:eq(3) a
    Wait Until Angular Ready    60s

Verify Updated and Published Date Status Waiting
    [Arguments]    ${shopId}    ${view}
    ${last_updated_date}=    Get Text    ${table_shop_list} tr[id='${shopId}-${view}'] td:eq(5)
    ${last_publish_date}=    Get Text    ${table_shop_list} tr[id='${shopId}-${view}'] td:eq(6)
    Should Be Equal     -     ${last_updated_date}    Last updated date have data
    Should Be Equal     -     ${last_publish_date}    Last published date have data

Verify Updated and Published Date Status Draft
    [Arguments]    ${shopId}    ${view}
    ${last_updated_date}=    Get Text    ${table_shop_list} tr[id='${shopId}-${view}'] td:eq(5)
    ${last_publish_date}=    Get Text    ${table_shop_list} tr[id='${shopId}-${view}'] td:eq(6)
    Should Not Be Equal     -     ${last_updated_date}    Last updated date do not have data
    Should Be Equal     -     ${last_publish_date}    Last published date have data

Verify Updated and Published Date Status Published
    [Arguments]    ${shopId}    ${view}
    ${last_updated_date}=    Get Text    ${table_shop_list} tr[id='${shopId}-${view}'] td:eq(5)
    ${last_publish_date}=    Get Text    ${table_shop_list} tr[id='${shopId}-${view}'] td:eq(6)
    Should Not Be Equal     -     ${last_updated_date}    Last updated date not have data
    Should Not Be Equal     -     ${last_publish_date}    Last published date not have data
    ${last_updated_attribute}=    Selenium2Library.Get Element Attribute    ${table_shop_list} tr[id='${shopId}-${view}'] td:eq(5) span@class
    ${last_publish_attribute}=    Selenium2Library.Get Element Attribute    ${table_shop_list} tr[id='${shopId}-${view}'] td:eq(6) span@class
    Should Be Equal    ng-binding ng-scope    ${last_updated_attribute}    Class attribute of last updated date not matched
    Should Be Equal    ng-binding ng-scope highlight-red    ${last_publish_attribute}    Class attribute of last published date not matched

Verify Updated and Published Date Status Modified
    [Arguments]    ${shopId}    ${view}
    ${last_updated_date}=    Get Text    ${table_shop_list} tr[id='${shopId}-${view}'] td:eq(5)
    ${last_publish_date}=    Get Text    ${table_shop_list} tr[id='${shopId}-${view}'] td:eq(6)
    Should Not Be Equal     -     ${last_updated_date}    Last updated date not have data
    Should Not Be Equal     -     ${last_publish_date}    Last published date not have data
    ${last_updated_attribute}=    Selenium2Library.Get Element Attribute    ${table_shop_list} tr[id='${shopId}-${view}'] td:eq(5) span@class
    ${last_publish_attribute}=    Selenium2Library.Get Element Attribute    ${table_shop_list} tr[id='${shopId}-${view}'] td:eq(6) span@class
    Should Be Equal    ng-binding ng-scope highlight-red    ${last_updated_attribute}    Class attribute of last updated date not matched
    Should Be Equal    ng-binding ng-scope    ${last_publish_attribute}    Class attribute of last published date not matched

Open Storefront - Shop List Page
    Open Browser and Maximize Window    ${STOREFRONT_CMS}    ${BROWSER}
    Wait Until Angular Ready    60s
    Wait Until Element Is Not Visible    jquery=table tr td:contains(Loading)

Click on Shop Name Column
    Wait Until Element Is Visible     ${column_shop_name}      2s
    Click Element and Wait Angular Ready    ${column_shop_name}

Click on Shop Status Column
    Wait Until Element Is Visible     ${column_shop_status}      2s
    Click Element and Wait Angular Ready    ${column_shop_status}

Go to URL Shop List Page
    Go To    ${STOREFRONT_CMS}
    Wait Until Angular Ready    60s
    Wait Until Element Is Not Visible    jquery=table tr td:contains(Loading)

Check Shop Data on Table
    [Arguments]    ${shopId}    ${shopName}    ${statusshop}    ${view}    ${expected_content_status}
    ${shop_name}=    Get Text    ${table_shop_list} tr[id='${shopId}-${view}'] td:eq(1)
    ${shop_status}=    Get Text    ${table_shop_list} tr[id='${shopId}-${view}'] td:eq(2)
    Should Be Equal    ${shop_name}      ${shopName}
    Should Be Equal    ${shop_status}    ${statusshop}
    ${content_status}=    Get Text    ${table_shop_list} tr[id='${shopId}-${view}'] td:eq(3)
    Should Be Equal    ${expected_content_status}    ${content_status}    Merchant Status '${shopId}-${view}' Not Matched
    Run Keyword If    '${expected_content_status}'=='Waiting'    Verify Updated and Published Date Status Waiting    ${shopId}    ${view}
    ...    ELSE IF    '${expected_content_status}'=='Draft'    Verify Updated and Published Date Status Draft    ${shopId}    ${view}
    ...    ELSE IF    '${expected_content_status}'=='Published'    Verify Updated and Published Date Status Published    ${shopId}    ${view}
    ...    ELSE IF    '${expected_content_status}'=='Modified'    Verify Updated and Published Date Status Modified    ${shopId}    ${view}
    ...    ELSE    Fail    Merchant Status Input not matched

Go To Shop Status Inactive And Content Status Draft
    Go To       ${WEMALL_WEB}/shop/${shop_id_status_inactive_content_status_draft}

Go To Shop Status Inactive And Content Status Modified
    Go To       ${WEMALL_WEB}/shop/${shop_id_status_inactive_content_status_modified}

Go To Shop Status Inactive And Content Status Waiting
    Go To       ${WEMALL_WEB}/shop/${shop_id_status_inactive_content_status_waiting}

Go To Shop Status Active And Content Status Draft
    Go To       ${WEMALL_WEB}/shop/${shop_id_status_active_content_status_draft}

Go To Shop Status Active And Content Status Waiting
    Go To       ${WEMALL_WEB}/shop/${shop_id_status_active_content_status_waiting}

Go To Shop Status Active And Content Status Modified
    Go To       ${WEMALL_WEB}/shop/${shop_id_status_active_content_status_modified}

Go To Shop Status Active And Content Status Published
    Go To       ${WEMALL_WEB}/shop/${shop_id_status_active_content_status_published}

Should Go To Shop
    [Arguments]    ${shop_id}
    Location Should Contain     ${WEMALL_WEB}/shop/${shop_id}

Should Go To Page Not Found
    Location Should Contain    ${WEMALL_WEB}/${page_not_found}

Shop List Table Should Display
    Wait Until Element Is Visible    ${table_shop_list}
    sleep      3s

Get All Shop Name From Shop List Table
    Shop List Table Should Display
    ${shop_name}=    Create List
    ${list} =   Get Webelements    ${table_shop_list} tr.ng-scope
    ${rows} =   Get Length    ${list}
    : FOR    ${index}    IN RANGE    0    ${rows}
    \    ${shop}=    Get Text    ${table_shop_list} tr.ng-scope:eq(${index}) td:eq(1)
    \    Append To List    ${shop_name}    ${shop}
    [Return]    ${shop_name}

Get All Shop Status From Shop List Table
    Shop List Table Should Display
    ${shop_status_list}=    Create List
    ${list} =   Get Webelements    ${table_shop_list} tr.ng-scope
    ${rows} =   Get Length    ${list}
    : FOR    ${index}    IN RANGE    0    ${rows}
    \    ${shop}=    Get Text    ${table_shop_list} tr.ng-scope:eq(${index}) td:eq(2)
    \    Append To List    ${shop_status_list}    ${shop}
    [Return]    ${shop_status_list}

Get All Shop Content Status From Shop List Table
    Shop List Table Should Display
    ${shop_status_list}=    Create List
    ${list} =   Get Webelements    ${table_shop_list} tr.ng-scope
    ${rows} =   Get Length    ${list}
    : FOR    ${index}    IN RANGE    0    ${rows}
    \    ${shop}=    Get Text    ${table_shop_list} tr.ng-scope:eq(${index}) td:eq(3)
    \    Append To List    ${shop_status_list}    ${shop}
    [Return]    ${shop_status_list}

Get All Shop Name From Shop Service
    ${shop_url}=    Set Variable
    ${shop_name}=    Get Shop List    http://${STOREFRONT-API-httpLib}${CSS_SHOP}
    ${shop_name}=    Combine Lists    ${shop_name}    ${shop_name}
    Log List    ${shop_name}
    [Return]    ${shop_name}

Get All Shop Name From Merchant Service
    ${shop_url}=    Set Variable    http://${MERCHANT_API}${MERCHANT}
    ${shop_name}=    Get Merchant List    ${shop_url}
    ${shop_name}=    Combine Lists    ${shop_name}    ${shop_name}
    Log List    ${mechat_name}
    [Return]    ${mechat_name}

Filter Shop Name
    [Arguments]    ${shop_name}
    Page Should Contain Element    ${filter_shop_name}
    Input Text    ${textbox_filter_shop_name}    ${shop_name}
    Press Key    ${textbox_filter_shop_name}    \\13
    Press Key    ${textbox_filter_shop_name}    \\9
    Wait Until Angular Ready    5s

Filter Shop Content Status
    [Arguments]    ${shop_content_status}
    Page Should Contain Element    ${filter_shop_content_status}
    Input Text    ${textbox_filter_shop_content_status}    ${shop_content_status}
    Press Key    ${textbox_filter_shop_content_status}    \\13
    Press Key    ${textbox_filter_shop_content_status}    \\9
    Wait Until Angular Ready    5s

Filter Shop Status
    [Arguments]    ${shop_status}
    Page Should Contain Element    ${filter_shop_status}
    Input Text    ${textbox_filter_shop_status}    ${shop_status}
    Press Key    ${textbox_filter_shop_status}    \\13
    Press Key    ${textbox_filter_shop_status}    \\9
    Wait Until Angular Ready    5s

Verify Data In Shop List Table
    ${shop_name_list_from_service}=    Get All Shop Name From Shop Service
    ${shop_name_list_from_table}=    Get All Shop Name From Shop List Table
    Check List Should Be Equal    ${shop_name_list_from_table}    ${shop_name_list_from_service}

Should Shop Name Sort by Ascending
    ${shop_list}=    Get All Shop Name From Shop List Table
    ${expected_sorted}=    Human Sorted    ${shop_list}
    Log    ${shop_list}
    Log     ${expected_sorted}
    Should Be Equal    ${expected_sorted}    ${shop_list}

Should Shop Name Sort by Descending
    ${shop_list}=    Get All Merchant Name From Merchant List Table
    ${expected_sorted}=    Reverse Human Sorted    ${shop_list}
    Lists Should Be Equal    ${expected_sorted}    ${shop_list}    List Sorted Not Equal

Should Shop Status Sort by Ascending
    ${shop_status_list}=    Get All Shop Status From Shop List Table
    ${expected_sorted}=    Human Sorted    ${shop_status_list}
    Lists Should Be Equal    ${expected_sorted}    ${shop_status_list}    List Sorted Not Equal

Should Shop Status Sort by Descending
    ${shop_status_list}=    Get All Shop Status From Shop List Table
    ${expected_sorted}=    Reverse Human Sorted    ${shop_status_list}
    Lists Should Be Equal    ${expected_sorted}    ${shop_status_list}    List Sorted Not Equal

Check Shop Low 1 and 2 Must Be Web and Mobile
    ${shop_1}=    Get Text    ${table_shop_list} tr.ng-scope:eq(0) td:eq(0)
    ${shop_2}=    Get Text    ${table_shop_list} tr.ng-scope:eq(2) td:eq(0)
    Should Be Equal    ${shop_1}    ${shop_2}    Merchant name row 1 and 2 not equeal
    ${shop_1_web}=    Get Text    ${table_shop_list} tr.ng-scope:eq(0) td:eq(0)
    ${shop_2_mobile}=    Get Text    ${table_shop_list} tr.ng-scope:eq(1) td:eq(0)
    ${shop_wm_expected}=    Create List    web    mobile
    ${shop_wm_actual}=    Create List    ${shop_1_web}    ${shop_2_mobile}
    Check List Should Be Equal    ${shop_wm_expected}     ${shop_wm_actual}

Check Shop Name List in Table Equal with Expected
    [Arguments]    ${expected_shop_name_list}
    ${shop_name_list_from_table}=    Get All Shop Name From Shop List Table
    ${length}=    Get Length    ${shop_name_list_from_table}
    Should Not Be Equal As Numbers    0    ${length}
    Log List    ${expected_shop_name_list}
    Log List    ${shop_name_list_from_table}
    Lists Should Be Equal    ${expected_shop_name_list}    ${shop_name_list_from_table}    List Shop Name Not Equal

Check Shop Content Status List in Table Equal with Expected Content Status
    [Arguments]    ${expected_status}
    ${shop_status_list_from_table}=    Get All Shop Content Status From Shop List Table
    ${length}=    Get Length    ${shop_status_list_from_table}
    Should Not Be Equal As Numbers    0    ${length}
    ${expected_status_list}=    Create List
    : FOR    ${index}    IN RANGE    0    ${length}
    \    Append To List    ${expected_status_list}    ${expected_status}
    Lists Should Be Equal    ${expected_status_list}    ${shop_status_list_from_table}    List Merchant Name Not Equal

Check Shop Status List in Table Equal with Expected Status
    [Arguments]    ${expected_status}
    ${shop_status_list_from_table}=    Get All Shop Status From Shop List Table
    ${length}=    Get Length    ${shop_status_list_from_table}
    Should Not Be Equal As Numbers    0    ${length}
    ${expected_status_list}=    Create List
    : FOR    ${index}    IN RANGE    0    ${length}
    \    Append To List    ${expected_status_list}    ${expected_status}
    Lists Should Be Equal    ${expected_status_list}    ${shop_status_list_from_table}    List Shop Name Not Equal

Go To Shop
    [Arguments]     ${shop_slug}
    Go To           ${WEMALL_WEB}/shop/${shop_slug}