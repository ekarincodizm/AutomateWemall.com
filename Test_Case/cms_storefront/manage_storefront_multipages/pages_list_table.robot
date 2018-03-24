*** Settings ***
Force Tags    WLS_Manage_Shop
Suite Setup         Run Keywords    Open Storefront - Shop List Page
                    ...    AND      Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${shop_slug}    ${active}    ${prepare_shoppages}
Suite Teardown      Run Keywords    Close All Browsers
    ...             AND    Delete Shop and All Storefront Data    ${suite_shop_id}
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_management_page/css_shop_management_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_management_page/css_pages_list_table_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_list_page/css_shop_list_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/storefront_page/storefront_page_keywords.robot
Resource            ${CURDIR}/../../../Keyword/API/api_storefronts/api_shops_keywords.robot

*** Variables ***
${merchant_id}            YMH37127
${shop_name}              Yamaha
${active}                 active
${shop_slug}              yamaha-shop
${body_put_template}      ${CURDIR}/../../../Resource/TestData/storefronts/shops_data/post_shop_template.json
${prepare_shoppages}      ${CURDIR}/../../../Resource/TestData/storefronts/shops_data/prepare_shop_pages.json
${body_pages_template}    ${CURDIR}/../../../Resource/TestData/storefronts/shops_data/pages/pages_template.json
${pages_name}             Scoopy i
${pages_slug}             scoopy-i
${banner_display}         on
${pages_status}           inactive

*** Test Cases ***
TC_ITMWM_05194 All page of shop show in pages list table
    [Tags]    cms_storefront    storefront_management    storefront_page_management    Regression    WLS_High
    ### Pages Web ###
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Pages List Table - Verify Data In Pages List Table    ${suite_shop_id}    web
    ### Pages Mobile ###
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Pages List Table - Verify Data In Pages List Table    ${suite_shop_id}    mobile

TC_ITMWM_05195 
    [Documentation]    Check pages status including Page Status, Content Status, Live, Last Updated, Last Published and Modified By - web
    [Tags]    cms_storefront    storefront_management    storefront_page_management    Regression    WLS_High
    ${pages_id}=    Create Pages Success    ${body_pages_template}    ${suite_shop_id}    ${pages_name}    ${pages_slug}    ${banner_display}    inactive
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Pages List Table - Verify Data In Pages List Table    ${suite_shop_id}    web
    # Waiting
    Pages List Table - Check Pages Data on Table    ${pages_id}    ${pages_name}    Inactive     Waiting    ${FALSE}    hulk_robot
    # Draft
    Create Pages Content Data From Input File    ${suite_shop_id}    ${pages_id}    web    ${prepare_content}
    Reload Page and Wait Page Ready
    Pages List Table - Check Pages Data on Table    ${pages_id}    ${pages_name}    Inactive     Draft    ${FALSE}    hulk_robot
    # Published
    Publish Pages Content Success    ${suite_shop_id}   ${pages_id}    content    web
    Reload Page and Wait Page Ready
    Pages List Table - Check Pages Data on Table    ${pages_id}    ${pages_name}    Inactive     Published    ${FALSE}    hulk_robot
    # Modified
    Update Pages Data From Input File    ${suite_shop_id}    ${pages_id}    web    ${prepare_header}
    Reload Page and Wait Page Ready
    Pages List Table - Check Pages Data on Table    ${pages_id}    ${pages_name}    Inactive     Modified    ${FALSE}    hulk_robot
    # Published
    Publish Pages Content Success    ${suite_shop_id}   ${pages_id}    content    web
    Reload Page and Wait Page Ready
    Pages List Table - Check Pages Data on Table    ${pages_id}    ${pages_name}    Inactive     Published    ${FALSE}    hulk_robot
    Delete Pages and Delete Pages Content Data by Specific Pages id    ${suite_shop_id}    ${pages_id}
    #### Mobile ####
    ${pages_id}=    Create Pages Success    ${body_pages_template}    ${suite_shop_id}    ${pages_name}    ${pages_slug}    ${banner_display}    ${pages_status}
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Pages List Table - Verify Data In Pages List Table    ${suite_shop_id}    mobile
    # Waiting
    Pages List Table - Check Pages Data on Table    ${pages_id}    ${pages_name}    Inactive     Waiting    ${FALSE}    hulk_robot
    # Draft
    Create Pages Content Data From Input File    ${suite_shop_id}    ${pages_id}    mobile    ${prepare_content}
    Reload Page and Wait Page Ready
    Pages List Table - Check Pages Data on Table    ${pages_id}    ${pages_name}    Inactive     Draft    ${FALSE}    hulk_robot
    # Published
    Publish Pages Content Success    ${suite_shop_id}   ${pages_id}    content    mobile
    Reload Page and Wait Page Ready
    Pages List Table - Check Pages Data on Table    ${pages_id}    ${pages_name}    Inactive     Published    ${FALSE}    hulk_robot
    # Modified
    Update Pages Data From Input File    ${suite_shop_id}    ${pages_id}    mobile    ${prepare_header}
    Reload Page and Wait Page Ready
    Pages List Table - Check Pages Data on Table    ${pages_id}    ${pages_name}    Inactive     Modified    ${FALSE}    hulk_robot
    # Published
    Publish Pages Content Success    ${suite_shop_id}   ${pages_id}    content    mobile
    Reload Page and Wait Page Ready
    Pages List Table - Check Pages Data on Table    ${pages_id}    ${pages_name}    Inactive     Published    ${FALSE}    hulk_robot
    [Teardown]    Delete Pages and Delete Pages Content Data by Specific Pages id    ${suite_shop_id}    ${pages_id}

# TC_ITMWM_05195 Check pages status including Page Status, Content Status, Live, Last Updated, Last Published and Modified By - mobile
#     [Tags]    cms_storefront    storefront_management    storefront_page_management    Regression
#     ${pages_id}=    Create Pages Success    ${body_pages_template}    ${suite_shop_id}    ${pages_name}    ${pages_slug}    ${banner_display}    ${pages_status}
#     Go to URL Shop List Page
#     Go To Manage Storefront Page    ${suite_shop_id}    mobile
#     Pages List Table - Verify Data In Pages List Table    ${suite_shop_id}    mobile
#     # Waiting
#     Pages List Table - Check Pages Data on Table    ${pages_id}    ${pages_name}    Inactive     Waiting    ${FALSE}    hulk_robot
#     # Draft
#     Create Pages Content Data From Input File    ${suite_shop_id}    ${pages_id}    mobile    ${prepare_content}
#     Reload Page and Wait Page Ready
#     Pages List Table - Check Pages Data on Table    ${pages_id}    ${pages_name}    Inactive     Draft    ${FALSE}    hulk_robot
#     # Published
#     Publish Pages Content Success    ${suite_shop_id}   ${pages_id}    content    mobile
#     Reload Page and Wait Page Ready
#     Pages List Table - Check Pages Data on Table    ${pages_id}    ${pages_name}    Inactive     Published    ${FALSE}    hulk_robot
#     # Modified
#     Update Pages Data From Input File    ${suite_shop_id}    ${pages_id}    mobile    ${prepare_header}
#     Reload Page and Wait Page Ready
#     Pages List Table - Check Pages Data on Table    ${pages_id}    ${pages_name}    Inactive     Modified    ${FALSE}    hulk_robot
#     # Published
#     Publish Pages Content Success    ${suite_shop_id}   ${pages_id}    content    mobile
#     Reload Page and Wait Page Ready
#     Pages List Table - Check Pages Data on Table    ${pages_id}    ${pages_name}    Inactive     Published    ${FALSE}    hulk_robot
#     [Teardown]    Delete Pages and Delete Pages Content Data by Specific Pages id    ${suite_shop_id}    ${pages_id}

TC_ITMWM_05196 Preview shop pages button
    [Tags]    cms_storefront    storefront_management    storefront_page_management    Regression    WLS_High
    ### Pages Web ###
    ${pages_id}=    Create Pages Success    ${body_pages_template}    ${suite_shop_id}    ${pages_name}    ${pages_slug}    ${banner_display}    ${pages_status}
    Go to URL Shop List Page
    # Prepare shop and page content    web
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Pages List Table - Check Preview Link for Web    ${pages_id}   ${shop_slug}   ${pages_slug}
    # Pages List Table - Click Preview Specific Pages    ${pages_id}
    # Check Preview Web
    # Prepare shop and page content    mobile
    ### Pages Mobile ###
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Pages List Table - Check Preview Link for Mobile    ${pages_id}   ${shop_slug}   ${pages_slug}
    # Pages List Table - Click Preview Specific Pages    ${pages_id}
    # Check Preview Mobile
    [Teardown]    Delete Pages and Delete Pages Content Data by Specific Pages id    ${suite_shop_id}    ${pages_id}

TC_ITMWM_05197 Published pages data button
    [Tags]    cms_storefront    storefront_management    storefront_page_management    Regression    WLS_High
    ${pages_id}=    Create Pages Success    ${body_pages_template}    ${suite_shop_id}    ${pages_name}    ${pages_slug}    ${banner_display}    ${pages_status}
    Create Pages Content Data From Input File    ${suite_shop_id}    ${pages_id}    web    ${prepare_content}
    Go to URL Shop List Page
    # Prepare shop and page content    web
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Pages List Table - Click Collapse Storefront Page Layout
    Pages List Table - Check Pages Data on Table    ${pages_id}    ${pages_name}    Inactive     Draft    ${FALSE}    hulk_robot
    Pages List Table - Click Published Specific Pages    ${pages_id}
    Pages List Table - Check Published Page Success
    Reload Page and Wait Page Ready
    Pages List Table - Check Pages Data on Table    ${pages_id}    ${pages_name}    Inactive     Published    ${FALSE}    hulk_robot
    # Check Published Web
    ### Pages Mobile ###
    Create Pages Content Data From Input File    ${suite_shop_id}    ${pages_id}    mobile    ${prepare_content}
    Go to URL Shop List Page
    # Prepare shop and page content    mobile
    Go To Manage Storefront Page    ${suite_shop_id}    mobile
    Pages List Table - Click Collapse Storefront Page Layout
    Pages List Table - Check Pages Data on Table    ${pages_id}    ${pages_name}    Inactive     Draft    ${FALSE}    hulk_robot
    Pages List Table - Click Published Specific Pages    ${pages_id}
    Pages List Table - Check Published Page Success
    Reload Page and Wait Page Ready
    Pages List Table - Check Pages Data on Table    ${pages_id}    ${pages_name}    Inactive     Published    ${FALSE}    hulk_robot
    # Check Published Mobile
    [Teardown]    Delete Pages and Delete Pages Content Data by Specific Pages id    ${suite_shop_id}    ${pages_id}
