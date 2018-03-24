*** Settings ***
Library             Selenium2Library
Library             ${CURDIR}/../../../../Python_Library/ExtendedSelenium/
Resource            ${CURDIR}/../../wemall/common/web_common_keywords.robot
# Resource        ${CURDIR}/../api_merchant/css_api_merchant_keyword.robot
Resource            ${CURDIR}/../../../API/api_storefronts/storefront_keywords.robot
Resource            ${CURDIR}/../../../API/api_storefronts/api_shops_keywords.robot
Resource            ${CURDIR}/../../../API/api_storefronts/api_pages_keywords.robot
Resource            ${CURDIR}/../shop_list_page/webelement_shop_list_page.robot
Resource            ${CURDIR}/webelement_shop_management_page.robot
Library             ${CURDIR}/css_pages_list.py

*** Keywords ***
Pages List Table - Click Preview Specific Pages
    [Arguments]    ${page_id}
    Wait Until Element Is Enabled    ${table_pages_list} tr[id='${page_id}'] #btnPreviewPage    10s
    Wait Until Element Is Visible    ${table_pages_list} tr[id='${page_id}'] #btnPreviewPage    10s
    Click Element    ${table_pages_list} tr[id='${page_id}'] #btnPreviewPage

Pages List Table - Click Published Specific Pages
    [Arguments]    ${page_id}
    Wait Until Element Is Enabled    ${table_pages_list} tr[id='${page_id}'] #btnPublishPage    10s
    Wait Until Element Is Visible    ${table_pages_list} tr[id='${page_id}'] #btnPublishPage    10s
    #Click Element and Wait Angular Ready    ${table_pages_list} tr[id='${page_id}'] #btnPublishPage
    Click Element    ${table_pages_list} tr[id='${page_id}'] #btnPublishPage

Pages List Table - Click Collapse Storefront Page Layout
    Wait Until Element Is Enabled    ${collapse_storefront_page_layout}    10s
    Wait Until Element Is Visible    ${collapse_storefront_page_layout}    10s
    Click Element and Wait Angular Ready    ${collapse_storefront_page_layout}

Pages List Table - Verify Data In Pages List Table
    [Arguments]    ${shop_id}    ${view}
    ${pages_name_list_from_service}=    Pages List Table - Get All Pages Data from Pages API    ${shop_id}    ${view}
    ${pages_name_list_from_table}=    Pages List Table - Get All Pages Data From Pages List Table
    compare_list    ${pages_name_list_from_table}    ${pages_name_list_from_service}

Pages List Table - Pages List Table Should Display
    Wait Until Element Is Visible    ${table_pages_list}   15s

Pages List Table - Get All Pages Data from Pages API
    [Arguments]    ${shop_id}    ${view}
    Get Pages Detail List by Shop ID    ${shop_id}
    ${response_body}=    Get Response Body
    ${pages_list}    Get Pages List Data from Response    ${response_body}    ${view}
    [Return]    ${pages_list}

Pages List Table - Get All Pages Data From Pages List Table
    Pages List Table - Pages List Table Should Display
    ${pages_list}=    Create List
    ${status}=      Run Keyword and Return Status           Element Should be Visible       ${table_pages_list} tbody tr.ng-scope
    Run Keyword And Return If       '${status}'=='False'            Return From Keyword         ${pages_list}
    ${list} =   Get Webelements    ${table_pages_list} tbody tr.ng-scope
    ${rows} =   Get Length    ${list}
    : FOR    ${index}    IN RANGE    0    ${rows}
    \    ${pages_name}=    Get Text    ${table_pages_list} tr.ng-scope:eq(${index}) td:eq(0)
    \    ${pages_status}=    Get Text    ${table_pages_list} tr.ng-scope:eq(${index}) td:eq(1)
    \    ${content_status}=    Get Text    ${table_pages_list} tr.ng-scope:eq(${index}) td:eq(2)
    \    ${live}=    Run Keyword And Return Status    Page Should Contain Element    ${table_pages_list} tr.ng-scope:eq(${index}) td:eq(3) .highlight-green
    # \    ${live}=    Get Text    ${table_pages_list} tr.ng-scope:eq(${index}) td:eq(3)
    \    ${last_updated}=    Get Text    ${table_pages_list} tr.ng-scope:eq(${index}) td:eq(4)
    \    ${last_published}=    Get Text    ${table_pages_list} tr.ng-scope:eq(${index}) td:eq(5)
    \    ${modified_by}=    Get Text    ${table_pages_list} tr.ng-scope:eq(${index}) td:eq(6)
    \    ${pages_data}=    Create Dictionary    page_name=${pages_name}
         ...    page_status=${pages_status}    content_status=${content_status}
         ...    live=${live}    last_updated=${last_updated}
         ...    last_published=${last_published}    modified_by=${modified_by}
    \    Append To List    ${pages_list}    ${pages_data}
    [Return]    ${pages_list}

Pages List Table - Check Pages Data on Table
    [Arguments]    ${page_id}    ${page_name}    ${page_status}    ${expected_content_status}    ${live}    ${modifiedBy}
    Pages List Table - Pages List Table Should Display
    Wait Until Element Is Visible    ${table_pages_list} tr[id='${page_id}']    30s
    ${actual_pages_name}=    Get Text    ${table_pages_list} tr[id='${page_id}'] td:eq(0)
    ${actual_pages_status}=    Get Text    ${table_pages_list} tr[id='${page_id}'] td:eq(1)
    ${actual_content_status}=    Get Text    ${table_pages_list} tr[id='${page_id}'] td:eq(2)
    ${actual_live}=    Run Keyword And Return Status    Page Should Contain Element    ${table_pages_list} tr[id='${page_id}'] td:eq(3) .highlight-green
    # ${actual_modified_by}=    Get Text    ${table_pages_list} tr[id='${page_id}'] td:eq(6)

    Should Be Equal As Strings    ${actual_pages_name}    ${page_name}    Pages Name not matched
    Should Be Equal As Strings    ${actual_pages_status}    ${page_status}    Pages Status not matched
    Should Be Equal As Strings    ${actual_content_status}    ${expected_content_status}    Content Pages Status not matched
    Should Be Equal As Strings    ${actual_live}    ${live}    Pages Live not matched
    # Should Be Equal As Strings    ${actual_modified_by}    ${modifiedBy}    Modified By not matched

    Run Keyword If    '${expected_content_status}'=='Waiting'    Pages List Table - Verify Updated and Published Date when Pages Status is Waiting    ${page_id}
    ...    ELSE IF    '${expected_content_status}'=='Draft'    Pages List Table - Verify Updated and Published Date when Pages Status is Draft    ${page_id}
    ...    ELSE IF    '${expected_content_status}'=='Published'    Pages List Table - Verify Updated and Published Date when Pages Status is Published    ${page_id}
    ...    ELSE IF    '${expected_content_status}'=='Modified'    Pages List Table - Verify Updated and Published Date when Pages Status is Modified    ${page_id}
    ...    ELSE    Fail    Pages Status Input not matched

Pages List Table - Check Preview Link for Web
    [Arguments]    ${page_id}   ${shop_slug}    ${page_slug}
    Wait Until Element Is Visible    ${table_pages_list} tr[id='${page_id}']    30s
    ${link_preview_button}=    Selenium2Library.Get Element Attribute    ${table_pages_list} tr[id='${page_id}'] td:eq(7) #btnPreviewPage@href
    Should Be Equal As Strings    ${link_preview_button}   ${WEMALL_WEB}/shop/${shop_slug}/${page_slug}?preview=678e45fa792c0a865d0eaee1b19e834d

Pages List Table - Check Preview Link for Mobile
    [Arguments]    ${page_id}   ${shop_slug}    ${page_slug}
    Wait Until Element Is Visible    ${table_pages_list} tr[id='${page_id}']    30s
    ${link_preview_button}=    Selenium2Library.Get Element Attribute    ${table_pages_list} tr[id='${page_id}'] td:eq(7) #btnPreviewPage@href
    Should Be Equal As Strings    ${link_preview_button}   ${WEMALL_WEB}/shop/${shop_slug}/${page_slug}?preview=678e45fa792c0a865d0eaee1b19e834d&is_mobile=1

Pages List Table - Verify Updated and Published Date when Pages Status is Waiting
    [Arguments]    ${page_id}
    ${last_updated_date}=    Get Text    ${table_pages_list} tr[id='${page_id}'] td:eq(4)
    ${last_publish_date}=    Get Text    ${table_pages_list} tr[id='${page_id}'] td:eq(5)
    Should Be Equal     -     ${last_updated_date}    Last updated date have data
    Should Be Equal     -     ${last_publish_date}    Last published date have data

Pages List Table - Verify Updated and Published Date when Pages Status is Draft
    [Arguments]    ${page_id}
    ${last_updated_date}=    Get Text    ${table_pages_list} tr[id='${page_id}'] td:eq(4)
    ${last_publish_date}=    Get Text    ${table_pages_list} tr[id='${page_id}'] td:eq(5)
    Should Not Be Equal     -     ${last_updated_date}    Last updated date do not have data
    Should Be Equal     -     ${last_publish_date}    Last published date have data

Pages List Table - Verify Updated and Published Date when Pages Status is Published
    [Arguments]    ${page_id}
    ${last_updated_date}=    Get Text    ${table_pages_list} tr[id='${page_id}'] td:eq(4)
    ${last_publish_date}=    Get Text    ${table_pages_list} tr[id='${page_id}'] td:eq(5)
    Should Not Be Equal     -     ${last_updated_date}    Last updated date not have data
    Should Not Be Equal     -     ${last_publish_date}    Last published date not have data
    Should More Than As String    ${last_publish_date}    ${last_updated_date}    Last Published Not More Than Last Updated
    ${last_updated_attribute}=    Selenium2Library.Get Element Attribute    ${table_pages_list} tr[id='${page_id}'] td:eq(4) span@class
    ${last_publish_attribute}=    Selenium2Library.Get Element Attribute    ${table_pages_list} tr[id='${page_id}'] td:eq(5) span@class
    Should Be Equal    ng-binding ng-scope    ${last_updated_attribute}    Class attribute of last updated date not matched
    Should Be Equal    ng-binding ng-scope highlight-red    ${last_publish_attribute}    Class attribute of last published date not matched

Pages List Table - Verify Updated and Published Date when Pages Status is Modified
    [Arguments]    ${page_id}
    ${last_updated_date}=    Get Text    ${table_pages_list} tr[id='${page_id}'] td:eq(4)
    ${last_publish_date}=    Get Text    ${table_pages_list} tr[id='${page_id}'] td:eq(5)
    Should Not Be Equal     -     ${last_updated_date}    Last updated date not have data
    Should Not Be Equal     -     ${last_publish_date}    Last published date not have data
    Should More Than As String    ${last_updated_date}    ${last_publish_date}    Last Updated Not More Than Last Published
    ${last_updated_attribute}=    Selenium2Library.Get Element Attribute    ${table_pages_list} tr[id='${page_id}'] td:eq(4) span@class
    ${last_publish_attribute}=    Selenium2Library.Get Element Attribute    ${table_pages_list} tr[id='${page_id}'] td:eq(5) span@class
    Should Be Equal    ng-binding ng-scope highlight-red    ${last_updated_attribute}    Class attribute of last updated date not matched
    Should Be Equal    ng-binding ng-scope    ${last_publish_attribute}    Class attribute of last published date not matched

Pages List Table - Check Published Page Success
    Wait Until Element Is Visible    ${page_manage_alert}    3s
    Wait Until Element Is Visible    ${page_manage_alert}:contains('Publish successfully')    5s
    ${message_alert}=    Get Text    ${page_manage_alert}
    Should Be Equal As Strings    Publish successfully    ${message_alert}    Message 'Published Success Not Show'














