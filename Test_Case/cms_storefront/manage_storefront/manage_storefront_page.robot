*** Settings ***
Force Tags    WLS_Manage_Shop
Suite Setup         Run Keywords    Prepare Storefront With Content for Storefront API    ${suite_shop_id}    ${shop_name}    ${shop_slug}    ${status}
    ...             AND    Open Storefront - Shop List Page
    ...             AND    Set Temp Suit Shop Id
Suite Teardown      Run Keywords    Close All Browsers
    ...             AND    Delete Shop and All Storefront Data    ${tmp_suite_shop_id}

Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_management_page/css_shop_management_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_list_page/css_shop_list_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/storefront_page/storefront_page_keywords.robot

*** Variables ***
${suite_shop_id}       SHARP0330954
${shop_name}           SHARP
${status}              active
${shop_slug}           sharp

${new_suite_shop_id}       PHILLIPS01000
${new_shop_name}           Phillips
${new_status}              active
${new_shop_slug}           phillips

${check_locator}           jquery=div.store-front-main-content h3[id="content-storefront-test"]

*** Test Cases ***
TC_WMALL_00004 Go to Manage Storefront page
    [Tags]    cms_storefront    storefront_management    Regression    WLS_High
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${tmp_suite_shop_id}    web
    Check Shop Name and Storefront View    ${shop_slug}    web
    Check All Manage Link
    Back to Shop List Page
    Go To Manage Storefront Page    ${tmp_suite_shop_id}    mobile
    Check Shop Name and Storefront View    ${shop_slug}    mobile
    Check All Manage Link

TC_WMALL_00005 Check link in Manage Storefront Web page
    [Tags]    cms_storefront    storefront_management    Regression    WLS_High
    Go to URL Shop List Page
    Go to Manage Storefront Page    ${tmp_suite_shop_id}    web
    Check Manage Storefront View    ${shop_slug}    web
    Click Header Link on Management Page    ${tmp_suite_shop_id}    Web
    Back to Storefront Management Page
    Check Manage Storefront View    ${shop_slug}    web
    Click Menu Link on Management Page    ${tmp_suite_shop_id}    Web
    Back to Storefront Management Page
    Check Manage Storefront View    ${shop_slug}    web
    Click Banner Link on Management Page    ${tmp_suite_shop_id}    Web
    Back to Storefront Management Page
    Check Manage Storefront View    ${shop_slug}    web
    Click Content Link on Management Page    ${tmp_suite_shop_id}    Web
    Back to Storefront Management Page
    Check Manage Storefront View    ${shop_slug}    web
    Click Footer Link on Management Page    ${tmp_suite_shop_id}    Web
    Back to Storefront Management Page
    Check Manage Storefront View    ${shop_slug}    web

TC_WMALL_01147 Check link in Manage Storefront Mobile page
    [Tags]    cms_storefront    storefront_management    Regression    WLS_High
    Go to URL Shop List Page
    Go to Manage Storefront Page    ${tmp_suite_shop_id}    mobile
    Check Manage Storefront View    ${shop_slug}    mobile
    Click Header Link on Management Page    ${tmp_suite_shop_id}    Mobile
    Back to Storefront Management Page
    Check Manage Storefront View    ${shop_slug}    mobile
    Click Menu Link on Management Page    ${tmp_suite_shop_id}    Mobile
    Back to Storefront Management Page
    Check Manage Storefront View    ${shop_slug}    mobile
    Click Banner Link on Management Page    ${tmp_suite_shop_id}    Mobile
    Back to Storefront Management Page
    Check Manage Storefront View    ${shop_slug}    mobile
    Click Content Link on Management Page    ${tmp_suite_shop_id}    Mobile
    Back to Storefront Management Page
    Check Manage Storefront View    ${shop_slug}    mobile
    Click Footer Link on Management Page    ${tmp_suite_shop_id}    Mobile
    Back to Storefront Management Page
    Check Manage Storefront View    ${shop_slug}    mobile

TC_WMALL_00006 Preview storefront web page
    [Tags]    cms_storefront    storefront_management    Regression    WLS_Medium
    [Setup]    Create Storefront Data From Input File    ${tmp_suite_shop_id}    web    ${prepare_content}
    Go to URL Shop List Page
    Go to Manage Storefront Page    ${tmp_suite_shop_id}    web
    Check Manage Storefront View    ${shop_slug}    web
    Click the Preview Button on the storefront Management Page
    # Should Storefront Page Contains Storefront Data    ${WEMALL_WEB}/shop/${shop_slug}?${PRIVIEW_TOKEN}    ${check_locator}
    Should Contains Element in Storefront Page    ${WEMALL_WEB}/shop/${shop_slug}?${PRIVIEW_TOKEN}    ${check_locator}
    [Teardown]    Teardown Close Window    ${tmp_suite_shop_id}    Web

TC_WMALL_00007 Preview storefront mobile page
    [Tags]    cms_storefront    storefront_management    Regression    WLS_Medium
    [Setup]    Create Storefront Data From Input File    ${tmp_suite_shop_id}    mobile    ${prepare_content}
    Go to URL Shop List Page
    Go to Manage Storefront Page    ${tmp_suite_shop_id}    mobile
    Check Manage Storefront View    ${shop_slug}    mobile
    Click the Preview Button on the storefront Management Page
    # Should Storefront Page Contains Storefront Data    ${WEMALL_WEB}/shop/${shop_slug}?${PRIVIEW_TOKEN}&${MOBILE_TOKEN}    ${check_locator}
    Should Contains Element in Storefront Page    ${WEMALL_WEB}/shop/${shop_slug}?${PRIVIEW_TOKEN}&${MOBILE_TOKEN}    ${check_locator}
    [Teardown]    Teardown Close Window    ${tmp_suite_shop_id}    Mobile

TC_WMALL_00008 Publish button - add new row
    [Tags]    cms_storefront    storefront_management    Regression    WLS_Medium
    # Web
    Prepare Storefront Data All Type All View    ${new_suite_shop_id}    ${new_shop_name}    ${new_shop_slug}    ${new_status}
    Go to URL Shop List Page
    Go to Manage Storefront Page    ${suite_shop_id}    web
    Check Manage Storefront View    ${new_shop_slug}    web
    Should Published Storefront Data All Type are Empty    ${suite_shop_id}    web
    Should Published Storefront Data All Type are Empty    ${suite_shop_id}    mobile
    Click The Publish Button on The Storefront Management Page
    Check Published Storefront Data Success
    Should Published Storefront Data All Type have Data    ${suite_shop_id}    web
    Should Published Storefront Data All Type are Empty    ${suite_shop_id}    mobile
    Open Storefront Web Page    ${new_shop_slug}
    Verify All Content in Storefront Web Page    ${new_shop_slug}
    Switch Browser    1
    # Mobile
    Back to Shop List Page
    Go to Manage Storefront Page    ${suite_shop_id}    mobile
    Check Manage Storefront View    ${new_shop_slug}    mobile
    Click The Publish Button on The Storefront Management Page
    Check Published Storefront Data Success
    Should Published Storefront Data All Type have Data    ${suite_shop_id}    mobile
    Verify All Content in Storefront Mobile Page    ${new_shop_slug}
    [Teardown]    Run Keywords    Delete Shop and All Storefront Data    ${suite_shop_id}
    ...           AND    Close Window and Switch to Browser 1

TC_WMALL_00009 Publish button - updated
    [Tags]    cms_storefront    storefront_management    Regression    WLS_Medium
    # Web
    Prepare Storefront Data All Type All View    ${new_suite_shop_id}    ${new_shop_name}    ${new_shop_slug}    ${new_status}
    Go to URL Shop List Page
    Go to Manage Storefront Page    ${suite_shop_id}    web
    Check Manage Storefront View    ${new_shop_slug}    web
    Should Published Storefront Data All Type are Empty    ${suite_shop_id}    web
    Should Published Storefront Data All Type are Empty    ${suite_shop_id}    mobile
    Click The Publish Button on The Storefront Management Page
    Check Published Storefront Data Success
    Should Published Storefront Data All Type have Data    ${suite_shop_id}    web
    Should Published Storefront Data All Type are Empty    ${suite_shop_id}    mobile
    Open Storefront Web Page    ${new_shop_slug}
    Verify All Content in Storefront Web Page    ${new_shop_slug}
    Switch Browser    1
    # Updated draft content on web
    Update Storefront Data From Input File    ${suite_shop_id}    web    ${updated_content}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    web    version=draft
    Response Should Contain Data Like Expected    ${Response}    content    ${updated_expected_content}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    web    version=published
    Response Should Contain Data Like Expected    ${Response}    content    ${prepare_expected_content_raw}
    Click The Publish Button on The Storefront Management Page
    Check Published Storefront Data Success
    Should Published Storefront Data All Type have Updated Content Data    ${suite_shop_id}    web
    Verify Content Type in Storefront Web Page are Updated    ${new_shop_slug}
    Switch Browser    1
    # Check Publish web not effected mobile
    Should Published Storefront Data All Type are Empty    ${suite_shop_id}    mobile

    # Mobile
    Back to Shop List Page
    Go to Manage Storefront Page    ${suite_shop_id}    mobile
    Check Manage Storefront View    ${new_shop_slug}    mobile
    Click The Publish Button on The Storefront Management Page
    Check Published Storefront Data Success
    Should Published Storefront Data All Type have data    ${suite_shop_id}    mobile
    Verify All Content in Storefront Mobile Page    ${new_shop_slug}
    Switch Browser    1
    # Updated draft content on mobile
    Update Storefront Data From Input File    ${suite_shop_id}    mobile    ${updated_content}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    mobile    version=draft
    Response Should Contain Data Like Expected    ${Response}    content    ${updated_expected_content}
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${suite_shop_id}    mobile    version=published
    Response Should Contain Data Like Expected    ${Response}    content    ${prepare_expected_content_raw}
    Click The Publish Button on The Storefront Management Page
    Check Published Storefront Data Success
    Should Published Storefront Data All Type have Updated Content Data    ${suite_shop_id}    mobile
    Sleep    5s
    Verify Content Type in Storefront Mobile Page are Updated    ${new_shop_slug}
    [Teardown]    Run Keywords    Delete Storefront Web and Mobile All Type and All Version    ${suite_shop_id}
    ...           AND    Close Window and Switch to Browser 1

TC_WMALL_01298 Publish Storefront That Not Have Draft Data
    [Tags]    cms_storefront    storefront_management    Regression    WLS_Medium
    [Setup]    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${new_suite_shop_id}    ${new_shop_name}    ${new_shop_slug}    ${new_status}
    # Web
    Go to URL Shop List Page
    Go to Manage Storefront Page    ${suite_shop_id}    web
    Check Manage Storefront View    ${shop_slug}    web
    Click The Publish Button on The Storefront Management Page
    Check Published Storefront Data Failed Because No Draft Data    ${suite_shop_id}

    # Mobile
    Back to Shop List Page
    Go to Manage Storefront Page    ${suite_shop_id}    mobile
    Check Manage Storefront View    ${shop_slug}    mobile
    Click The Publish Button on The Storefront Management Page
    Check Published Storefront Data Failed Because No Draft Data    ${suite_shop_id}
    [Teardown]    Delete Storefront Web and Mobile All Type and All Version    ${suite_shop_id}

*** Keywords ***
Teardown Close Window
    [Arguments]    ${suite_shop_id}    ${view}
    Close Window
    Select Window    url=${STOREFRONT_CMS}/#/storefrontManagement/${suite_shop_id}/${view}

Set Temp Suit Shop Id
    Set Suite Variable    ${tmp_suite_shop_id}    ${suite_shop_id}
    Log to Console    Temp Suite Shop ID : ${tmp_suite_shop_id}



















