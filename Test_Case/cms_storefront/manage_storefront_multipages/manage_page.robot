*** Settings ***
Force Tags    WLS_Manage_Shop
#Suite Setup         Run Keywords    Prepare Storefront With Content for Storefront API    ${suite_shop_id}    ${shop_name}    ${shop_slug}    ${status}
Suite Setup         Run Keywords    Prepare Shop For Suite And If Shop Exist will Delete and Create New         ${suite_shop_id}    ${shop_name}    ${shop_slug}    ${status}
    ...             AND    Prepare Shop And If Shop Exist will Delete and Create New         ${suite_shop_id_2}    ${shop_name_2}    ${shop_slug_2}    ${status}
    ...             AND    Open Storefront - Shop List Page

Suite Teardown      Run Keywords    Close All Browsers
    ...             AND    Delete Shop and All Storefront Data    ${suite_shop_id}
    ...             AND    Delete Shop and All Storefront Data    ${suite_shop_id_2}

Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_management_page/css_shop_management_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_management_page/css_pages_list_table_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_management_page/css_page_management_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_list_page/css_shop_list_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/storefront_page/storefront_page_keywords.robot
Resource            ${CURDIR}/../../../Keyword/API/api_storefronts/api_shops_keywords.robot

*** Variables ***
${suite_shop_id}       HULK-TEST-PAGE-0001
${shop_name}           HULK-TEST-PAGE-0001
${status}              active
${shop_slug}           hulk-test-page-0001

${suite_shop_id_2}       HULK-TEST-PAGE-0002
${shop_name_2}           HULK-TEST-PAGE-0002
${shop_slug_2}           hulk-test-page-0002
${check_locator}           jquery=div.store-front-main-content h3[id="content-storefront-test"]

*** Test Cases ***
TC_ITMWM_05198 Create new pages in shop success then show on pages list
    [Tags]    cms_storefront    storefront_management    storefront_page_management    Regression    WLS_High
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Check Shop Name and Storefront View    ${shop_slug}    web
    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill On Page From    Page 05198    page-05198      on          active
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Page Name       ${suite_shop_id}        Page 05198
    ${pages}=               Pages List Table - Get All Pages Data From Pages List Table
    ${pageCount}=           Get Length      ${pages}
    Should Be Equal         '1'           '${pageCount}'

TC_ITMWM_05199 Create new pages - cancel button
    [Tags]    cms_storefront    storefront_management    storefront_page_management    Regression    WLS_Medium
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Check Shop Name and Storefront View    ${shop_slug}    web
    ${pages}=               Pages List Table - Get All Pages Data From Pages List Table
    ${pageCount}=           Get Length      ${pages}
    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill On Page From    Page 05199     page-05199      on          active
    Storefront CMS Page Management - Click Cancel On Page From
    ${pages}=               Pages List Table - Get All Pages Data From Pages List Table
    ${newPageCount}=        Get Length      ${pages}
    Should Be Equal         ${pageCount}           ${newPageCount}

TC_ITMWM_05200 Create duplicate pages name in same shop
    [Tags]    cms_storefront    storefront_management    storefront_page_management    Regression    WLS_High
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Check Shop Name and Storefront View    ${shop_slug}    web

    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill On Page From    Page 05200    page-05200      on          active
    Storefront CMS Page Management - Click Save On Page From

    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill On Page From    Page 05200    page-05200.1      on          active
    Storefront CMS Page Management - Verify Page Name Duplicate error

TC_ITMWM_05201
    [Documentation]    Create duplicate pages name in different shop/Create duplicate pages slug in different shop
    [Tags]    cms_storefront    storefront_management    storefront_page_management    Regression    WLS_High
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Check Shop Name and Storefront View    ${shop_slug}    web


    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill On Page From    Page 05201    page-05201      on          active
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Page Name       ${suite_shop_id}            Page 05201

    #different shop
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id_2}    web
    Check Shop Name and Storefront View    ${shop_slug_2}    web

    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill On Page From    Page 05201    page-05201      on          active
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Page Name       ${suite_shop_id_2}            Page 05201

TC_ITMWM_05202 Create duplicate pages slug under same shop
    [Tags]    cms_storefront    storefront_management    storefront_page_management    Regression    WLS_High
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Check Shop Name and Storefront View    ${shop_slug}    web

    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill On Page From    Page 05202    page-05202      on          active
    Storefront CMS Page Management - Click Save On Page From

    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill On Page From    Page 05202.1    page-05202     on          active
    Storefront CMS Page Management - Verify Page Slug Duplicate error

TC_ITMWM_05204 Create new pages in shop - Auto suggest by slugify pages name
    [Tags]    cms_storefront    storefront_management    storefront_page_management    Regression    WLS_Medium
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Check Shop Name and Storefront View    ${shop_slug}    web

    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill Page Name         Page 1
    Storefront CMS Page Management - Verify Page Slug With From       page-1
    Storefront CMS Page Management - Fill Page Name         Page@123
    Storefront CMS Page Management - Verify Page Slug With From       page-123
    Storefront CMS Page Management - Fill Page Name       Page@กาญ!2
    Storefront CMS Page Management - Verify Page Slug WIth From      page-กาญ-2

TC_ITMWM_05205 Create new pages in shop - Check allowed input text on pages slug text box
    [Tags]    cms_storefront    storefront_management    storefront_page_management    Regression    WLS_High
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Check Shop Name and Storefront View    ${shop_slug}    web

    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill Page Slug         Page 1 05205
    Storefront CMS Page Management - Verify Page Slug With From      page105205
    Storefront CMS Page Management - Fill Page Slug         Page@123 05205
    Storefront CMS Page Management - Verify Page Slug With From     page12305205
    Storefront CMS Page Management - Fill Page Slug         Page@กาญ!2 05205
    Storefront CMS Page Management - Verify Page Slug With From      pageกาญ205205

TC_ITMWM_05206 Create new pages in shop - tool tip pages slug
    [Tags]    cms_storefront    storefront_management    storefront_page_management    Regression    WLS_Low
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Check Shop Name and Storefront View    ${shop_slug}    web

    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - To Verify Tool Tip Slug Show

TC_ITMWM_05207 Create new pages - active/inactive pages
    [Tags]    cms_storefront    storefront_management    storefront_page_management    Regression    WLS_High
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Check Shop Name and Storefront View    ${shop_slug}    web

    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill Page Name         05207.1
    Storefront CMS Page Management - Fill Page Slug         05207.1
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Page Status     ${suite_shop_id}    05207.1        inactive

    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill Page Name         05207.2
    Storefront CMS Page Management - Fill Page Slug         05207.2
    Storefront CMS Page Management - Fill Page Status       active
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Page Status     ${suite_shop_id}    05207.2        active

TC_ITMWM_05208 Create new pages - turn on/off shop banner
    [Tags]    cms_storefront    storefront_management    storefront_page_management    Regression    WLS_High
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Check Shop Name and Storefront View    ${shop_slug}    web

    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill Page Name         05208.1
    Storefront CMS Page Management - Fill Page Slug         05208.1
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Banner Display     ${suite_shop_id}    05208.1        off

    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill Page Name         05208.2
    Storefront CMS Page Management - Fill Page Slug         05208.2
    Storefront CMS Page Management - Fill Page Banner Display       on
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Banner Display     ${suite_shop_id}    05208.2        on

TC_ITMWM_05209 Edit pages data - pages name then pages list data change
    [Tags]    cms_storefront    storefront_management    storefront_page_management    Regression    WLS_High
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Check Shop Name and Storefront View    ${shop_slug}    web

    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill Page Name         05209
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Page Name       ${suite_shop_id}       05209

    Storefront CMS Page Management - Click Edit Page By Page Name    ${suite_shop_id}       05209
    Storefront CMS Page Management - Fill Page Name         05209.Change
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Page Name       ${suite_shop_id}        05209.Change

TC_ITMWM_05210 Edit pages data - cancel button
    [Tags]    cms_storefront    storefront_management    storefront_page_management    Regression    WLS_Medium
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Check Shop Name and Storefront View    ${shop_slug}    web

    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill Page Name         05210
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Page Name       ${suite_shop_id}       05210

    Storefront CMS Page Management - Click Edit Page By Page Name    ${suite_shop_id}       05210
    Storefront CMS Page Management - Fill Page Name         05210.Change
    Storefront CMS Page Management - Fill Page Banner Display       on
    Storefront CMS Page Management - Fill Page Status               active
    Storefront CMS Page Management - Click Cancel On Page From

    Storefront CMS Page Management - Verify Page Name      ${suite_shop_id}    05210
    Storefront CMS Page Management - Verify Banner Display          ${suite_shop_id}    05210        off
    Storefront CMS Page Management - Verify Page Status             ${suite_shop_id}    05210        inactive
    Storefront CMS Page Management - Verify Page Slug               ${suite_shop_id}    05210        05210

TC_ITMWM_05211 Edit pages data - pages name duplicate in same shop
    [Tags]    cms_storefront    storefront_management    storefront_page_management    Regression    WLS_High
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Check Shop Name and Storefront View    ${shop_slug}    web

    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill Page Name         05211
    Storefront CMS Page Management - Click Save On Page From

    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill Page Name         05211.2
    Storefront CMS Page Management - Click Save On Page From

    Storefront CMS Page Management - Click Edit Page By Page Name    ${suite_shop_id}       05211.2
    Storefront CMS Page Management - Fill Page Name         05211
    Storefront CMS Page Management - Verify Page Name Duplicate error


TC_ITMWM_05212 Edit pages data - pages name duplicate in different shop
    [Tags]    cms_storefront    storefront_management    storefront_page_management    Regression    WLS_High
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Check Shop Name and Storefront View    ${shop_slug}    web

    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill On Page From    Page 05212    page-05212      on          active
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Page Name      ${suite_shop_id}    Page 05212

    #different shop
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id_2}    web
    Check Shop Name and Storefront View    ${shop_slug_2}    web
    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill On Page From    Page 05212.Before    page-05212before      on          active
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Page Name      ${suite_shop_id_2}    Page 05212.Before

    Storefront CMS Page Management - Click Edit Page By Page Name    ${suite_shop_id_2}       Page 05212.Before
    Storefront CMS Page Management - Fill Page Name         Page 05212
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Page Name      ${suite_shop_id_2}    Page 05212

TC_ITMWM_05213 Not allowed edit pages slug
    [Tags]    cms_storefront    storefront_management    storefront_page_management    Regression    WLS_High
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Check Shop Name and Storefront View    ${shop_slug}    web

    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill On Page From    05213    05213      on          active
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Page Name      ${suite_shop_id}    05213

    Storefront CMS Page Management - Click Edit Page By Page Name    ${suite_shop_id}       05213
    ${status}=      Run Keyword and return status        Storefront CMS Page Management - Fill Page Slug     05213
    Should Be Equal         '${status}'        'False'


TC_ITMWM_05214 Edit pages data - active/inactive pages then pages list data change
    [Tags]    cms_storefront    storefront_management    storefront_page_management    Regression    WLS_High
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Check Shop Name and Storefront View    ${shop_slug}    web

    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill On Page From    05214    05214      on          active
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Page Name      ${suite_shop_id}    05214

    Storefront CMS Page Management - Click Edit Page By Page Name    ${suite_shop_id}       05214
    Storefront CMS Page Management - Fill Page Status       inactive
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Page Status             ${suite_shop_id}    05214        inactive

    Storefront CMS Page Management - Click Edit Page By Page Name    ${suite_shop_id}       05214
    Storefront CMS Page Management - Fill Page Status       active
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Page Status             ${suite_shop_id}    05214        active

TC_ITMWM_05215 Edit pages data - turn on/off shop banner then pages list data change
    [Tags]    cms_storefront    storefront_management    storefront_page_management    Regression    WLS_High
    Go to URL Shop List Page
    Shop List Table Should Display
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Check Shop Name and Storefront View    ${shop_slug}    web

    Storefront CMS Page Management - Click Add New Page
    Storefront CMS Page Management - Fill On Page From    05215    05215      on          active
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Page Name      ${suite_shop_id}    05215

    Storefront CMS Page Management - Click Edit Page By Page Name    ${suite_shop_id}       05215
    Storefront CMS Page Management - Fill Page Banner Display       off
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Banner Display              ${suite_shop_id}    05215        off

    Storefront CMS Page Management - Click Edit Page By Page Name    ${suite_shop_id}       05215
    Storefront CMS Page Management - Fill Page Banner Display       on
    Storefront CMS Page Management - Click Save On Page From
    Storefront CMS Page Management - Verify Banner Display              ${suite_shop_id}    05215        on

*** Keywords ***
Teardown Close Window
    [Arguments]    ${suite_shop_id}    ${view}
    Close Window
    Select Window    url=${STOREFRONT_CMS}/#/storefrontManagement/${suite_shop_id}/${view}



















