*** Settings ***
Library             Selenium2Library
Library             ${CURDIR}/../../../../Python_Library/ExtendedSelenium/
Resource            ${CURDIR}/../../wemall/common/web_common_keywords.robot
Resource            ${CURDIR}/../../../API/common/api_keywords.robot
# Resource        ${CURDIR}/../api_merchant/css_api_merchant_keyword.robot
Resource            ${CURDIR}/../../../API/api_storefronts/storefront_keywords.robot
Resource            ${CURDIR}/../../../API/api_storefronts/api_shops_keywords.robot
Resource            ${CURDIR}/../shop_list_page/webelement_shop_list_page.robot
Resource            ${CURDIR}/webelement_shop_management_page.robot

*** Variables ***
${headerLinkText}               Header
${menuLinkText}                 Menu
${bannerLinkText}               Banner
${contentLinkText}              Content
${footerLinkText}               Footer

*** Keywords ***
Go to URL Storefront Management Page
    [Arguments]    ${shop_id}    ${module}    ${device}
    Go To    http://alpha-storefront-cms.wemall-dev.com/#/storefrontManagement/${shop_id}/${device}
    Wait Until Angular Ready    60s
    Wait Until Page Contains Element    jquery=a span.menu-text:contains(${module})    30s

Open Storefront Management Page
    Open Browser and Maximize Window    ${STOREFRONT_CMS}/#/storefrontManagement/${shop_id}/    ${BROWSER}

Click Link on Management Page
    [Arguments]    ${shopId}    ${module}    ${device}
    # click_element_and_wait_page_ready    jquery=a span.menu-text:contains(${module})
    Click Element and Wait Angular Ready    jquery=a span.menu-text:contains(${module})
    # Click Element and Wait Angular Ready    jquery=a span.menu-text:contains(${module})
    Wait Until Location Contains    editor/${module.lower()}/${shopId}/${device}        15s

Click Header Link on Management Page
    [Arguments]    ${shopId}    ${device}
    Click Link on Management Page    ${shopId}    ${headerLinkText}    ${device}
    Wait Until Angular Ready    60s

Click Menu Link on Management Page
    [Arguments]    ${shopId}    ${device}
    Click Link on Management Page    ${shopId}    ${menuLinkText}    ${device}
    Wait Until Angular Ready    60s

Click Banner Link on Management Page
    [Arguments]    ${shopId}    ${device}
    Wait Until Angular Ready    30s
    Click Link on Management Page    ${shopId}    ${bannerLinkText}    ${device}
    Wait Until Angular Ready    60s

Click Content Link on Management Page
    [Arguments]    ${shopId}    ${device}
    Click Link on Management Page    ${shopId}    ${contentLinkText}    ${device}
    Wait Until Angular Ready    60s

Click Footer Link on Management Page
    [Arguments]    ${shopId}    ${device}
    Click Link on Management Page    ${shopId}    ${footerLinkText}    ${device}
    Wait Until Angular Ready    60s

Click the Preview Button on the storefront Management Page
    Wait Until Element Is Enabled   ${tableButtonsId}    5s
    Click Element and Wait Angular Ready   jquery=#${previewButtonId}

Click the Publish Button on the storefront Management Page
    Wait Until Element Is Enabled   ${tableButtonsId}    5s
    Click Element and Wait Angular Ready   jquery=#${publishButtonId}

Click the Back Button on the storefront Management Page
    Wait Until Element Is Enabled   ${tableButtonsId}    5s
    Click Element and Wait Angular Ready   jquery=#${backButtonId}

Check Shop Name and Storefront View
    [Arguments]    ${shop_slug}    ${view}
    Check Shop Name    ${shop_slug}    ${view}
    Check Manage Storefront View    ${shop_slug}    ${view}

Check Shop Name
    [Arguments]    ${shop_slug}    ${view}
    ${shop_name_from_web}=    Get Text    ${tag_shop_name}
    ${shop_name_from_api}=    Get Shop Name from Shop Slug    ${shop_slug}
    Should Be Equal    "${shop_name_from_web}"    ${shop_name_from_api}    Shop name not matched

Check Merchant Name and Storefront View
    [Arguments]    ${shop_slug}    ${view}
    Check Merchant Name    ${shop_slug}    ${view}
    Check Manage Storefront View    ${shop_slug}    ${view}

Check Merchant Name
    [Arguments]    ${shop_slug}    ${view}
    ${merchant_name_from_web}=    Get Text    ${tag_shop_name}
    ${merchant_name_from_api}=    Get Merchant Name from Merchant Slug    ${shop_slug}
    Should Be Equal    "${merchant_name_from_web}"    ${merchant_name_from_api}    Merchant name not matched

Check Manage Storefront View
    [Arguments]    ${shop_slug}    ${view}
    ${storefront_view}=    Selenium2Library.Get Element Attribute    ${tag_shop_name} i@class
    Run Keyword If    '${view}'=='web'    Should Be Equal    ${storefront_view}    fa fa-desktop    View not matched
    ...    ELSE IF    '${view}'=='mobile'    Should Be Equal    ${storefront_view}    fa fa-mobile    View not matched
    ...    ELSE    Fail    Storefront View Input not matched

Check Published Storefront Data Success
    Check Alert Message    Publish successfully

Check Published Storefront Data Failed Because No Draft Data
    [Arguments]    ${shop_id}
    Check Alert Message    The draft version storefront of the shopId '${shop_id}' does not exist

Check Alert Message
    [Arguments]    ${expected_message}
    Wait Until Element Is Visible    ${alert_storefront_management}    5s
    ${alert_message}=    Get Text    ${alert_storefront_management}
    Should Be Equal As Strings    ${expected_message}    ${alert_message}    Alert message not matched with '${expected_message}'

Check All Manage Link
    Element Should Contain    ${table_shop_management} tr:eq(1)    Header    Header link do not show
    Element Should Contain    ${table_shop_management} tr:eq(2)    Menu    Menu link do not show
    Element Should Contain    ${table_shop_management} tr:eq(3)    Banner    Banner link do not show
    Element Should Contain    ${table_shop_management} tr:eq(4)    Content    Content link do not show
    Element Should Contain    ${table_shop_management} tr:eq(5)    Footer    Footer link do not show

Prepare Storefront Data All Type All View
    [Arguments]    ${shopId}    ${shopName}    ${shopSlug}    ${status}
    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${shopId}    ${shopName}    ${shopSlug}    ${status}
    Update Storefront Data From Input File    ${suite_shop_id}    web    ${prepare_header}
    Update Storefront Data From Input File    ${suite_shop_id}    web    ${prepare_menu}
    Update Storefront Data From Input File    ${suite_shop_id}    web    ${prepare_banner}
    Update Storefront Data From Input File    ${suite_shop_id}    web    ${prepare_content}
    Update Storefront Data From Input File    ${suite_shop_id}    web    ${prepare_footer}
    Update Storefront Data From Input File    ${suite_shop_id}    mobile    ${prepare_header}
    Update Storefront Data From Input File    ${suite_shop_id}    mobile    ${prepare_menu}
    Update Storefront Data From Input File    ${suite_shop_id}    mobile    ${prepare_banner}
    Update Storefront Data From Input File    ${suite_shop_id}    mobile    ${prepare_content}
    Update Storefront Data From Input File    ${suite_shop_id}    mobile    ${prepare_footer}

Should Published Storefront Data All Type have data
    [Arguments]    ${shop_id}    ${view}
    # Header
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${shop_id}    ${view}    version=published
    Response Should Contain Data Like Expected    ${Response}    header    ${prepare_expected_header_raw}
    # Menu
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${shop_id}    ${view}    version=published
    Response Should Contain Data Like Expected    ${Response}    menu    ${prepare_expected_menu_raw}
    # Banner
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${shop_id}    ${view}    version=published
    Response Should Contain Data Like Expected    ${Response}    banner    ${prepare_expected_banner}
    # Content
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${shop_id}    ${view}    version=published
    Response Should Contain Data Like Expected    ${Response}    content    ${prepare_expected_content_raw}
    # Footer
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${shop_id}    ${view}    version=published
    Response Should Contain Data Like Expected    ${Response}    footer    ${prepare_expected_footer_raw}

Should Published Storefront Data All Type have Updated Content Data
    [Arguments]    ${shop_id}    ${view}
    # Header
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${shop_id}    ${view}    version=published
    Response Should Contain Data Like Expected    ${Response}    header    ${prepare_expected_header_raw}
    # Menu
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${shop_id}    ${view}    version=published
    Response Should Contain Data Like Expected    ${Response}    menu    ${prepare_expected_menu_raw}
    # Banner
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${shop_id}    ${view}    version=published
    Response Should Contain Data Like Expected    ${Response}    banner    ${prepare_expected_banner}
    # Content
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${shop_id}    ${view}    version=published
    Response Should Contain Data Like Expected    ${Response}    content    ${updated_expected_content}
    # Footer
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${shop_id}    ${view}    version=published
    Response Should Contain Data Like Expected    ${Response}    footer    ${prepare_expected_footer_raw}

Should Published Storefront Data All Type are Empty
    [Arguments]    ${shop_id}    ${view}
    # Header
    ${Response}=    Get Storefront Header    ${STOREFRONT-API}    ${shop_id}    ${view}    version=published
    Request Success But Response Data Should Empty    ${Response}
    # Menu
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${shop_id}    ${view}    version=published
    Request Success But Response Data Should Empty    ${Response}
    # Banner
    ${Response}=    Get Storefront Banner    ${STOREFRONT-API}    ${shop_id}    ${view}    version=published
    Request Success But Response Data Should Empty    ${Response}
    # Content
    ${Response}=    Get Storefront Content    ${STOREFRONT-API}    ${shop_id}    ${view}    version=published
    Request Success But Response Data Should Empty    ${Response}
    # Footer
    ${Response}=    Get Storefront Footer    ${STOREFRONT-API}    ${shop_id}    ${view}    version=published
    Request Success But Response Data Should Empty    ${Response}
