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
Resource            ${CURDIR}/css_pages_list_table_keywords.robot

*** Variables ***
${headerLinkText}               Header
${menuLinkText}                 Menu
${bannerLinkText}               Banner
${contentLinkText}              Content
${footerLinkText}               Footer

*** Keywords ***
Storefront CMS Page Management - Click Add New Page
    Click Element           ${createPageButton}

Storefront CMS Page Management - Click Save On Page From
    Wait Until Angular Ready    30s
    Click Element           ${savePageButton}
    Wait Until Angular Ready    30s
    sleep       2s

Storefront CMS Page Management - Click Cancel On Page From
    Click Element           ${cancelPageButton}
    sleep       1s

Storefront CMS Page Management - Fill On Page From
    [Arguments]     ${name}     ${slug}     ${banner_display}       ${status}
    Storefront CMS Page Management - Fill Page Name         ${name}
    Storefront CMS Page Management - Fill Page Slug         ${slug}
    Storefront CMS Page Management - Fill Page Banner Display       ${banner_display}
    Storefront CMS Page Management - Fill Page Status               ${status}

Storefront CMS Page Management - Fill Page Name
    [Arguments]     ${name}
    Input Text      ${pageNameInput}        ${name}
    sleep       1s

Storefront CMS Page Management - Fill Page Slug
    [Arguments]     ${slug}
    Input Text      ${pageSlugInput}        ${slug}
    sleep       1s

Storefront CMS Page Management - Verify Page Slug With From
    [Arguments]     ${expectSlug}
    ${slug}=      Get Value       ${pageSlugInput}
    Should Be Equal         ${expectSlug}       ${slug}

Storefront CMS Page Management - Fill Page Banner Display
    [Arguments]     ${display}=off
    sleep   1s
    Run Keyword if      '${display}'=='on'       Select Checkbox        ${onOffBanner}
    Run Keyword if      '${display}'=='off'      UnSelect Checkbox      ${onOffBanner}

Storefront CMS Page Management - Fill Page Status
    [Arguments]     ${display}=inactive
    sleep     1s
    Run Keyword if      '${display}'=='active'        Select Checkbox        ${activePage}
    Run Keyword if      '${display}'=='inactive'      UnSelect Checkbox      ${activePage}
    Storefront CMS Page Management - Click Confirm Ok

Storefront CMS Page Management - Click Confirm Ok
    Wait Until Angular Ready    30s
    ${status}       Run Keyword And Return Status           Element Should Be Visible        ${confirmDialog}
    Run Keyword if      '${status}'=='True'         Click Element           jquery=.modal-footer button:not('#pageSave'):contains('OK')
    sleep   1s

Storefront CMS Page Management - Click Confirm Cancel
    Wait Until Angular Ready    30s
    ${status}       Run Keyword And Return Status           Element Should Be Visible        ${confirmDialog}
    Run Keyword if      '${status}'=='True'         Click Element           jquery=.modal-footer button:not('#pageCancel'):contains('Cancel')
    sleep   1s

Storefront CMS Page Management - Verify Page Name Duplicate error
    Wait Until Element Is Visible       jquery=.has-error:contains('Page name already exists')          3s

Storefront CMS Page Management - Verify Page Slug Duplicate error
    Wait Until Element Is Visible       jquery=.has-error:contains('Page url already exists')          3s

Storefront CMS Page Management - To Verify Tool Tip Slug Show
    sleep                                   1s
    Wait Until Element Is Visible           ${toolTipInfoIcon}
    Mouse Over                              ${toolTipInfoIcon}
    Wait Until Element Is Visible           ${toolTipInfo}

Storefront CMS Page Management - Verify Page Slug
    [Arguments]         ${shop_id}      ${page_name}     ${expect_page_slug}
    ${page_slug}=     Storefront CMS Page Management - Get Page Slug From Page Name     ${shop_id}      ${page_name}
    Should Be Equal     ${expect_page_slug}       ${page_slug}

Storefront CMS Page Management - Get Page Slug From Page Name
    [Arguments]         ${shop_id}      ${page_name}
    Get Shop by Shop ID         ${shop_id}
    ${response_body}=    Get Response Body
    ${pages}=            Get Json Value    ${response_body}    /data/pages
    ${pages}=             Convert json to Dict        ${pages}
    ${items}=            Get Dictionary Items       ${pages}
    :FOR     ${page_id}     ${page}     IN    @{items}
    \       ${name}=        Get From Dictionary        ${page}          name
    \       ${temp_slug}=        Get From Dictionary        ${page}          slug
    \       Run Keyword and Return if       '${name}'=='${page_name}'         Return From Keyword         ${temp_slug}
    Return From Keyword         False

Storefront CMS Page Management - Verify Page Status
    [Arguments]         ${shop_id}      ${page_name}            ${expect_page_status}
    ${page_status}=     Storefront CMS Page Management - Get Page Status From Page Name     ${shop_id}      ${page_name}
    Should Be Equal     ${expect_page_status}       ${page_status}

Storefront CMS Page Management - Get Page Status From Page Name
    [Arguments]         ${shop_id}      ${page_name}
    Get Shop by Shop ID         ${shop_id}
    ${response_body}=    Get Response Body
    ${pages}=            Get Json Value    ${response_body}    /data/pages
    ${pages}=             Convert json to Dict        ${pages}
    ${items}=            Get Dictionary Items       ${pages}
    :FOR     ${page_id}     ${page}     IN    @{items}
    \       ${name}=        Get From Dictionary        ${page}          name
    \       ${temp_status}=        Get From Dictionary        ${page}          page_status
    \       Run Keyword and Return if       '${name}'=='${page_name}'         Return From Keyword         ${temp_status}
    Return From Keyword         False

Storefront CMS Page Management - Verify Banner Display
    [Arguments]         ${shop_id}      ${page_name}            ${expected}
    ${banner_display}=     Storefront CMS Page Management - Get Page Banner Display From Page Name      ${shop_id}      ${page_name}
    Should Be Equal     ${expected}       ${banner_display}

Storefront CMS Page Management - Get Page Banner Display From Page Name
    [Arguments]         ${shop_id}      ${page_name}
    Get Shop by Shop ID         ${shop_id}
    ${response_body}=    Get Response Body
    ${pages}=            Get Json Value    ${response_body}    /data/pages
    ${pages}=             Convert json to Dict        ${pages}
    ${items}=            Get Dictionary Items       ${pages}
    :FOR     ${page_id}     ${page}     IN    @{items}
    \       ${name}=        Get From Dictionary        ${page}          name
    \       ${temp_banner_display}=        Get From Dictionary        ${page}         banner_display
    \       Run Keyword and Return if       '${name}'=='${page_name}'         Return From Keyword         ${temp_banner_display}
    Return From Keyword         False

Storefront CMS Page Management - Verify Page Name
    [Arguments]         ${shop_id}      ${page_name}
    Get Shop by Shop ID         ${shop_id}
    ${response_body}=    Get Response Body
    ${pages}=            Get Json Value    ${response_body}    /data/pages
    ${pages}=             Convert json to Dict        ${pages}
    ${items}=            Get Dictionary Items       ${pages}
    :FOR     ${page_id}     ${page}     IN    @{items}
    \       ${name}=        Get From Dictionary        ${page}          name
    \       Run Keyword and Return if       '${name}'=='${page_name}'         Return From Keyword         PASS
    Should Be Equal     Fail         ${page_name}

Storefront CMS Page Management - Get Page Id From Page Name
    [Arguments]         ${shop_id}      ${page_name}
    Get Shop by Shop ID         ${shop_id}
    ${response_body}=    Get Response Body
    ${pages}=            Get Json Value    ${response_body}    /data/pages
    ${pages}=             Convert json to Dict        ${pages}
    ${items}=            Get Dictionary Items       ${pages}
    :FOR     ${page_id}     ${page}     IN    @{items}
    \       ${name}=        Get From Dictionary        ${page}          name
    \       Run Keyword and Return if       '${name}'=='${page_name}'         Return From Keyword         ${page_id}
    Return From Keyword         False

Storefront CMS Page Management - Click Edit Page By Page Name
    [Arguments]     ${shop_id}      ${page_name}
    ${page_id}=     Storefront CMS Page Management - Get Page Id From Page Name          ${shop_id}      ${page_name}
    Storefront CMS Page Management - Click Edit Page By Page ID          ${page_id}

Storefront CMS Page Management - Click Edit Page By Page ID
    [Arguments]         ${page_id}
    Click Element       jquery=#${page_id} td a
    sleep   1s

Storefront CMS Page Management - Click Edit Page Content By Page Name
    [Arguments]     ${shop_id}      ${page_name}
    ${page_id}=     Storefront CMS Page Management - Get Page Id From Page Name          ${shop_id}      ${page_name}
    Storefront CMS Page Management - Click Edit Page Content By Page ID          ${page_id}

Storefront CMS Page Management - Click Edit Page Content By Page ID
    [Arguments]         ${page_id}
    Click Element       jquery=#${page_id} td:eq(2) a
    sleep   1s

