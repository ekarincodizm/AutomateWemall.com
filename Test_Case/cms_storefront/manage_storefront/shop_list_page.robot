*** Settings ***
Force Tags    WLS_Manage_Shop
Suite Setup         Run Keywords    Open Storefront - Shop List Page
Suite Teardown      Run Keywords    Close All Browsers
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_management_page/css_shop_management_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_list_page/css_shop_list_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/storefront_page/storefront_page_keywords.robot
Resource            ${CURDIR}/../../../Keyword/API/api_storefronts/api_shops_keywords.robot

*** Variables ***
${merchant_id}            AURA00576
${shop_name}              Aura
${active}                 active
${inactive}               inactive
${shop_slug}              aura
${body_put_template}      ${CURDIR}/../../../Resource/TestData/storefronts/shops_data/post_shop_template.json
${img_src}                //sandbox-cdn.wemall-dev.com/th/Header/MTH10000_images/cover.png

*** Test Cases ***
TC_WMALL_00001 All Shop Show in Shop list Table
    [Tags]    cms_storefront   shop_list    Regression    WLS_High
    Go to URL Shop List Page
    Shop List Table Should Display
    Verify Data In Shop List Table

TC_WMALL_00002 Shop table sort by Shop Name
    [Tags]    cms_storefront   shop_list    Regression    WLS_Medium
   Go to URL Shop List Page
   Shop List Table Should Display
   # Should Shop Name Sort by Ascending
   Click on Shop Name Column
   Should Shop Name Sort by Ascending
   Click on Shop Name Column
   Should Shop Name Sort by Descending

TC_WMALL_00003 Shop table sort by Status
    [Tags]    cms_storefront   shop_list    Regression    WLS_Medium
   Go to URL Shop List Page
   Shop List Table Should Display
   Click on Shop Status Column
   Should Shop Status Sort by Ascending
   Click on Shop Status Column
   Should Shop Status Sort by Descending

TC_WMALL_01138 Separate web and mobile storefront page
    [Tags]    cms_storefront   shop_list    Regression    WLS_Medium
    Go to URL Shop List Page
    Shop List Table Should Display
    Verify Data In Shop List Table
    Check Shop Low 1 and 2 Must Be Web and Mobile

TC_WMALL_01139 Created, Modified and Published staus (Web View)
    [Tags]    cms_storefront   shop_list    Regression    WLS_Medium
    [Setup]   Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${shop_slug}    ${active}
    Go to URL Shop List Page
    Shop List Table Should Display
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Active    web    Waiting
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Active    mobile    Waiting
    Create Storefront Data From Input File    ${suite_shop_id}    web    ${prepare_content}
    Reload Page and Wait Page Ready
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Active    web    Draft
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Active    mobile    Waiting
    Publish Storefront Success    ${suite_shop_id}    content    published    web
    Reload Page and Wait Page Ready
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Active    web    Published
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Active    mobile    Waiting
    Update Storefront Data From Input File    ${suite_shop_id}    web    ${prepare_header}
    Reload Page and Wait Page Ready
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Active    web    Modified
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Active    mobile    Waiting
    [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}

TC_WMALL_01140 Created, Modified and Published staus (Mobile view)
    [Tags]    cms_storefront   shop_list    Regression    WLS_Medium
    [Setup]   Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${shop_slug}    ${inactive}
    Go to URL Shop List Page
    Shop List Table Should Display
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Inactive    mobile     Waiting
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Inactive    web     Waiting
    Create Storefront Data From Input File    ${suite_shop_id}    mobile    ${prepare_content}
    Reload Page and Wait Page Ready
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Inactive    mobile     Draft
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Inactive    web     Waiting
    Publish Storefront Success    ${suite_shop_id}    content    published    mobile
    Reload Page and Wait Page Ready
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Inactive    mobile     Published
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Inactive    web     Waiting
    Update Storefront Data From Input File    ${suite_shop_id}    mobile    ${prepare_header}
    Reload Page and Wait Page Ready
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Inactive    mobile     Modified
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Inactive    web     Waiting
    [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}

TC_WMALL_01141 Preview storefront Web Page
    [Tags]    cms_storefront   shop_list    Regression    WLS_Medium
    [Setup]    Prepare Data for Storefront API    ${merchant_id}    ${shop_name}    ${shop_slug}    ${active}
    Go to URL Shop List Page
    Shop List Table Should Display
    Click Preview Storefront Page    ${suite_shop_id}    web
    Verify Window Preview Storefront Web TH Contains    ${shop_slug}    div.store-header div.shop-header-test-class    ${img_src}
    [Teardown]    Run Keywords    Teardown Close Window
        ...       AND    Delete Shop and All Storefront Data    ${suite_shop_id}

TC_WMALL_01142 Preview storefront Mobile Page
    [Tags]    cms_storefront   shop_list    Regression    WLS_Medium
    [Setup]    Prepare Data for Storefront API    ${merchant_id}    ${shop_name}    ${shop_slug}    ${active}
    Go to URL Shop List Page
    Shop List Table Should Display
    Click Preview Storefront Page    ${suite_shop_id}    mobile
    Verify Window Preview Storefront Mobile TH Contains    ${shop_slug}    div.storefront-header div.shop-header-test-class    ${img_src}
    [Teardown]    Run Keywords    Teardown Close Window
        ...       AND    Delete Shop and All Storefront Data    ${suite_shop_id}

TC_WMALL_01143 New shop status
    [Tags]    cms_storefront   shop_list    Regression    WLS_Medium
    [Setup]    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${shop_slug}    ${active}
    Go to URL Shop List Page
    Shop List Table Should Display
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Active    web    Waiting
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Active    mobile    Waiting
    [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}

TC_WMALL_01144 Drafted storefront status
   [Tags]    cms_storefront   shop_list    Regression    WLS_Medium
   [Setup]    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${shop_slug}    ${active}
   Create Storefront Data From Input File    ${suite_shop_id}    web    ${prepare_content}
   Create Storefront Data From Input File    ${suite_shop_id}    mobile    ${prepare_content}
   Go to URL Shop List Page
   Shop List Table Should Display
   Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Active    web    Draft
   Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Active    mobile    Draft
   [Teardown]    Delete Storefront Web and Mobile All Type and All Version    ${suite_shop_id}

TC_WMALL_01145 Published storefront status
   [Tags]    cms_storefront   shop_list    Regression    WLS_Medium
   [Setup]    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${shop_slug}    ${active}
   Create Storefront Data From Input File    ${suite_shop_id}    web    ${prepare_content}
   Create Storefront Data From Input File    ${suite_shop_id}    mobile    ${prepare_content}
   Sleep    2s
   Publish Storefront Success    ${suite_shop_id}    content    published    web
   Publish Storefront Success    ${suite_shop_id}    content    published    mobile
   Go to URL Shop List Page
   Shop List Table Should Display
   Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Active    web    Published
   Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Active    mobile    Published
   [Teardown]    Delete Storefront Web and Mobile All Type and All Version    ${suite_shop_id}

TC_WMALL_01146 Modified storefront published data
   [Tags]    cms_storefront   shop_list    Regression    WLS_Medium
   [Setup]    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${shop_slug}    ${active}
   Create Storefront Data From Input File    ${suite_shop_id}    web    ${prepare_content}
   Create Storefront Data From Input File    ${suite_shop_id}    mobile    ${prepare_content}
   Sleep    2s
   Publish Storefront Success    ${suite_shop_id}    content    published    web
   Publish Storefront Success    ${suite_shop_id}    content    published    mobile
   Sleep    2s
   Update Storefront Data From Input File    ${suite_shop_id}    web    ${prepare_header}
   Update Storefront Data From Input File    ${suite_shop_id}    mobile    ${prepare_header}
   Go to URL Shop List Page
   Shop List Table Should Display
   Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Active    web    Modified
   Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Active    mobile    Modified
   [Teardown]    Delete Storefront Web and Mobile All Type and All Version    ${suite_shop_id}

TC_WMALL_01292 Filter Shop Name
    [Tags]    cms_storefront   shop_list    Regression    WLS_Medium
    [Setup]   Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${shop_slug}    ${inactive}
    Go to URL Shop List Page
    Filter Shop Name    ${shop_name}
    ${expected_list_01}=     Create List    ${shop_name}    ${shop_name}
    Check Shop Name List in Table Equal with Expected    ${expected_list_01}
    [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}

TC_WMALL_01293 Filter Shop Status
   [Tags]    cms_storefront   shop_list    Regression    WLS_Medium
    [Setup]   Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${shop_slug}    ${inactive}
    Go to URL Shop List Page
    Filter Shop Status    Inactive
    Check Shop Status List in Table Equal with Expected Status    Inactive
    Update Shop Success    ${suite_shop_id}    ${body_put_template}    ${merchant_id}    ${shop_name}    ${shop_slug}    ${active}
    Go to URL Shop List Page
    Filter Shop Status    Active
    Check Shop Status List in Table Equal with Expected Status    Active
    [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}

# Inactive case
# TC_WMALL_01363 - Filter Shop Content Status
#     [Tags]    cms_storefront   shop_list    Regression
#     [Setup]   Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${shop_slug}    ${inactive}
#     Go to URL Shop List Page
#     Filter Shop Content Status    Waiting
#     Check Shop Content Status List in Table Equal with Expected Content Status    Waiting
#     Go to URL Shop List Page
#     Filter Shop Content Status    Draft
#     Check Shop Content Status List in Table Equal with Expected Content Status    Draft
#     [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}

TC_WMALL_01294 Filter Both of Shop Name and Shop Content Status
    [Tags]    cms_storefront   shop_list    Regression    WLS_Medium
    [Setup]   Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${shop_slug}    ${inactive}
    Go to URL Shop List Page
    Filter Shop Name    ${shop_name}
    ${expected_list_01}=     Create List    ${shop_name}    ${shop_name}
    Check Shop Name List in Table Equal with Expected    ${expected_list_01}
    Filter Shop Content Status    Waiting
    Check Shop Content Status List In Table Equal With Expected Content Status    Waiting
    Check Shop Name List in Table Equal with Expected    ${expected_list_01}
    [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}

TC_WMALL_01335 Shop status is inactive, shop storefront redirect to page not found.
    [Tags]    cms_storefront   shop_list    Regression    WLS_High
    [Setup]   Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${shop_slug}    ${inactive}
    Go to URL Shop List Page
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Inactive    web    Waiting
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Inactive    mobile    Waiting
    Go To Shop    ${shop_slug}
    Should Go To Page Not Found
    Go to URL Shop List Page
    Create Storefront Data From Input File    ${suite_shop_id}    web    ${prepare_content}
    Reload Page and Wait Page Ready
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Inactive    web    Draft
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Inactive    mobile    Waiting
    Go To Shop    ${shop_slug}
    Should Go To Page Not Found
    Go to URL Shop List Page
    Publish Storefront Success    ${suite_shop_id}    content    published    web
    Reload Page and Wait Page Ready
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Inactive    web    Published
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Inactive    mobile    Waiting
    Go To Shop    ${shop_slug}
    Should Go To Page Not Found
    Go to URL Shop List Page
    Update Storefront Data From Input File    ${suite_shop_id}    web    ${prepare_header}
    Reload Page and Wait Page Ready
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Inactive    web    Modified
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Inactive    mobile    Waiting
    Go To Shop    ${shop_slug}
    Should Go To Page Not Found
    [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}

TC_WMALL_01336 Shop status active and content status waiting, shop storefront redirect to page not found.
    [Tags]    cms_storefront   shop_list    Regression    WLS_High
    [Setup]   Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${shop_slug}    ${active}
    Go to URL Shop List Page
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Active    web    Waiting
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Active    mobile    Waiting
    Go To Shop    ${shop_slug}
    Should Go To Page Not Found
    [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}

TC_WMALL_01338 Shop status active and content status modified, shop storefront redirect to storefont is correctly.
    [Tags]    cms_storefront   shop_list    Regression    WLS_High
    [Setup]   Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${shop_slug}    ${active}
    Go to URL Shop List Page
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Active    web    Waiting
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Active    mobile    Waiting
    Create Storefront Data From Input File    ${suite_shop_id}    web    ${prepare_content}
    Reload Page and Wait Page Ready
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Active    web    Draft
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Active    mobile    Waiting
    Publish Storefront Success    ${suite_shop_id}    content    published    web
    Reload Page and Wait Page Ready
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Active    web    Published
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Active    mobile    Waiting
    Update Storefront Data From Input File    ${suite_shop_id}    web    ${prepare_header}
    Reload Page and Wait Page Ready
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Active    web    Modified
    Check Shop Data on Table    ${suite_shop_id}    ${shop_name}    Active    mobile    Waiting
    Go To Shop    ${shop_slug}
    Should Go To Shop          ${shop_slug}
    [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}

TC_WMALL_01339 Shop status active and content status publish, shop storefront redirect to storefont is correctly.
    [Tags]    cms_storefront   shop_list    Regression    WLS_High
    [Setup]   Prepare Storefront Web Data With Content for Storefront API    ${merchant_id}    ${shop_name}    ${shop_slug}    ${active}
    Go To Shop    ${shop_slug}
    Should Go To Shop     ${shop_slug}
    [Teardown]    Delete Shop and All Storefront Data    ${suite_shop_id}

*** Keywords ***
Teardown Close Window
    Close Window
    Select Window    url=${STOREFRONT_CMS}/#/merchantList