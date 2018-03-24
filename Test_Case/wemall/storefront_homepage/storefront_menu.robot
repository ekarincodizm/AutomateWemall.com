*** Settings ***
Force Tags    WLS_Wemall_storefront_homepage
Suite Setup         Run Keywords    Prepare Storefront With Content for Storefront API    ${merchant_id}    ${shop_name}    ${shop_slug}    ${status}
    ...             AND    Update Storefront and Published Storefront Data    ${suite_shop_id}    ${prepare_header}    header
    ...             AND    Open Storefront Web Page    ${shop_slug}
Suite Teardown      Run Keywords    Close All Browsers
  ...             AND    Delete Shop and All Storefront Data    ${suite_shop_id}
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/API/api_storefronts/api_shops_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/manage_shop_menu/css_manage_shop_menu_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/storefront_page/storefront_page_keywords.robot
Resource            ${CURDIR}/../../../Keyword/API/api_storefronts/storefront_keywords.robot
Library             ${CURDIR}/../../../Keyword/API/api_storefronts/storefront.py
Library             ${CURDIR}/../../../Keyword/Portal/wemall/storefront_page/storefront_page_keywords.py

*** Variables ***
# Setup
# ${merchant_id}         PAOLO4141
# ${merchant_id}         AM00938     #ENV:Alpha
${merchant_id}         TH3213      #ENV:Staging
${shop_name}           Paolo Hospital Store
${status}              active
${shop_slug}           paolo-hospital
${module}              Menu
${web}                 Web
${mobile}              Mobile
${merchant_data}       ${CURDIR}/../../../Resource/TestData/merchant/css_merchants_create_retail_merchant.json

${shop_paolo_menu_web_data}         ${CURDIR}/../../../Resource/TestData/storefronts/menu/paolo_menu_4levels_web.json
${shop_paolo_menu_mobile_data}      ${CURDIR}/../../../Resource/TestData/storefronts/menu/paolo_menu_4levels_mobile.json
${itm_menu_json_file}               ${CURDIR}/../../../Resource/TestData/storefronts/menu/itm_shop_menu.json

${web_view}                 web
${mobile_view}              mobile
${published}           published
${data}                     <p>data</p>

*** Test Cases ***
TC_WMALL_00138 Storefront page should not show menu if menu data does not exist
    [Tags]    Regression    cms_storefront    storefront_menu
    Go To Preview Web Shop Page    ${shop_slug}
    Verify Menus Not Contain Menu
    Update Storefront Data From Input File    ${suite_shop_id}    ${web_view}    ${put_published}
    Go To Web Shop Page    ${shop_slug}
    Verify Menus Not Contain Menu
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}

TC_WMALL_00139 Storefront page should not show menu if status is inactive
    [Tags]    Regression    cms_storefront    storefront_menu
    Update Storefront Menu Status    ${suite_shop_id}    ${web_view}    inactive    ${shop_paolo_menu_web_data}
    Go To Preview Web Shop Page    ${shop_slug}
    Verify Menus Not Contain Menu
    Publish Storefront Success    ${suite_shop_id}    ${module.lower()}    ${published}    ${web_view}    ${data}
    Go To Web Shop Page    ${shop_slug}
    Verify Menus Not Contain Menu
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}

TC_WMALL_00141 Storefront mobile page should not show menu if menu data does not exist
    [Tags]    Regression    cms_storefront    storefront_menu
    Go To Preview Web Shop Page    ${shop_slug}
    Verify Storefront Mobile Menu Data Does Not Exist
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${put_published}
    Go To Mobile Shop Page    ${shop_slug}
    Verify Storefront Mobile Menu Data Does Not Exist
    [Teardown]    Run Keywords    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}
    ...    AND    Delete Is Mobile Cookie

TC_WMALL_00142 Storefront mobile page should not show menu if status is inactive
    [Tags]    Regression    cms_storefront    storefront_menu
    Update Storefront Menu Status    ${suite_shop_id}    ${mobile_view}    inactive    ${shop_paolo_menu_web_data}
    Go To Preview Web Shop Page    ${shop_slug}
    Verify Storefront Mobile Menu Data Does Not Exist
    Update Storefront Data From Input File    ${suite_shop_id}    ${mobile_view}    ${put_published}
    Go To Mobile Shop Page    ${shop_slug}
    Verify Storefront Mobile Menu Data Does Not Exist
    [Teardown]    Run Keywords    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}
    ...    AND    Delete Is Mobile Cookie

TC_ITMWM_03958 Storefront page show multi level menu (3 level and 4 level)
    [Tags]    Regression    cms_storefront    storefront_menu
    Update Storefront Menu Status and Published Storefront Data    ${suite_shop_id}    ${web_view}    active    ${shop_paolo_menu_web_data}
    Go To Web Shop Page                ${shop_slug}
    Verify Menus with Expected Data    ${shop_paolo_menu_web_data}
    Go To Web Shop Page                ${shop_slug}    en
    Verify Menus with Expected Data    ${shop_paolo_menu_web_data}    lang=en
    [Teardown]    Delete Storefront Draft and Published Success Specific Type    ${suite_shop_id}    web    ${module.lower()}

TC_ITMWM_03959 Storefront mobile page show multi level menu (3 level and 4 level)
    [Tags]    Regression    cms_storefront    storefront_menu
    Update Storefront Menu Status and Published Storefront Data    ${suite_shop_id}    ${mobile_view}    active    ${shop_paolo_menu_mobile_data}
    Go To Mobile Shop Page    ${shop_slug}
    Click Element    jquery=.icon-menu-hamburger-dots
    Verify Shop Menu Mobile With Json Data File    ${shop_paolo_menu_mobile_data}
    Go To Mobile Shop Page    ${shop_slug}    en
    Click Element    jquery=.icon-menu-hamburger-dots
    Verify Shop Menu Mobile With Json Data File    ${shop_paolo_menu_mobile_data}    lang=en
    [Teardown]    Run Keywords    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}
    ...    AND    Delete Is Mobile Cookie

TC_ITMWM_04126 Level D page show multi level menu (3 level and 4 level)
    [Tags]    Regression    cms_storefront    storefront_menu
    Update Storefront Menu Status and Published Storefront Data    ${suite_shop_id}    ${web_view}    active    ${shop_paolo_menu_web_data}
    # Go to    ${WEMALL_WEB}/products/item-2747755683240.html    #ENV:alpha
    Go to    ${WEMALL_WEB}/products/item-2133364748298.html    #ENV:staging
    Wait Until Angular Ready    60s
    Verify Menus with Expected Data    ${shop_paolo_menu_web_data}
    [Teardown]    Delete Storefront Draft and Published Success Specific Type    ${suite_shop_id}    web    ${module.lower()}

TC_ITMWM_04127 iTruemart page show multi level menu (3 level and 4 level)
    [Tags]    Regression    cms_storefront    storefront_menu
    Get Shop by Merchant ID    ITM
    ${ITM_shop_id}    Get Shop ID from Response Body Data
    Update Storefront Menu Status and Published Storefront Data    ${ITM_shop_id}    ${web_view}    active    ${shop_paolo_menu_web_data}
    Go to    ${WEMALL_WEB}/itruemart
    Wait Until Angular Ready    60s
    Verify Menus with Expected Data    ${shop_paolo_menu_web_data}
    [Teardown]    Update Storefront Menu Status and Published Storefront Data    ${ITM_shop_id}    ${web_view}    active    ${itm_menu_json_file}

TC_ITMWM_04128 iTruemart mobile page show multi level menu (3 level and 4 level)
    [Tags]    Regression    cms_storefront    storefront_menu
    Get Shop by Merchant ID    ITM
    ${ITM_shop_id}    Get Shop ID from Response Body Data
    Update Storefront Menu Status and Published Storefront Data    ${ITM_shop_id}    ${mobile_view}    active    ${shop_paolo_menu_mobile_data}
    Go to    ${WEMALL_MOBILE}/itruemart
    Wait Until Angular Ready    60s
    Click Element    jquery=.icon-menu-hamburger-dots
    Verify Shop Menu Mobile With Json Data File    ${shop_paolo_menu_mobile_data}
    [Teardown]    Run Keywords    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}
    ...    AND    Delete Is Mobile Cookie

*** Keywords ***
Update Storefront Menu Status
    [Arguments]    ${shop_id}    ${view}    ${status}    ${json_data_file}
    ${json_data}=    Get File    ${json_data_file}
    #Get data node from json but it's dict
    ${dict_menu_data}=    Convert json to Dict    ${json_data}
    ${menu_data}=    Get From Dictionary    ${dict_menu_data}    data
    Set To Dictionary    ${menu_data}    status    ${status}
    Set To Dictionary    ${dict_menu_data}    data    ${menu_data}
    #Convert data to json
    ${menu_data_json}=    Convert Dict to json    ${dict_menu_data}
    Send Put Success    ${shop_id}    ${view}    ${menu_data_json}

Update Storefront Menu Status and Published Storefront Data
    [Arguments]    ${shop_id}    ${view}    ${status}    ${json_data_file}
    Update Storefront Menu Status    ${shop_id}    ${view}    ${status}    ${json_data_file}
    Publish Storefront Success    ${shop_id}    ${module.lower()}    ${published}    ${view}    ${data}
    Sleep    3s

Update Storefront and Published Storefront Data
    [Arguments]    ${shop_id}    ${json_data_file}    ${contentType}
    Update Storefront Data From Input File    ${shop_id}    web    ${json_data_file}
    Update Storefront Data From Input File    ${shop_id}    mobile    ${json_data_file}
    Publish Storefront Success    ${shop_id}    ${contentType.lower()}    ${published}    web    ${data}
    Publish Storefront Success    ${shop_id}    ${contentType.lower()}    ${published}    mobile    ${data}
    Sleep    3s


