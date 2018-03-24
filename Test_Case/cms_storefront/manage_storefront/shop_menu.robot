*** Settings ***
Force Tags    WLS_Manage_Shop
Suite Setup         Run Keywords    Prepare Storefront With Content for Storefront API    ${merchant_id}    ${shop_name}    ${shop_slug}    ${status}
    ...             AND    Update Storefront and Published Storefront Data    ${suite_shop_id}    ${prepare_header}    header
    ...             AND    Open Storefront - Shop List Page
Suite Teardown      Run Keywords    Close All Browsers
    ...             AND    Delete Shop and All Storefront Data    ${suite_shop_id}
Resource            ${CURDIR}/../../../Resource/init.robot
# Resource            ${CURDIR}/../../../Keywords/api_merchant/css_api_merchant_keyword.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_list_page/css_shop_list_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_management_page/css_shop_management_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/manage_shop_menu/css_manage_shop_menu_keywords.robot
Resource            ${CURDIR}/../../../Keyword/API/api_storefronts/storefront_keywords.robot
Library             ${CURDIR}/../../../Keyword/API/api_storefronts/storefront.py

*** Variables ***
# Setup
${merchant_id}         SONY01995
${shop_name}           Sony Store
${status}              active
${shop_slug}           sony
${module}              Menu
${web}                 Web
${mobile}              Mobile
${merchant_data}       ${CURDIR}/../../Resource/TestData/merchant/css_merchants_create_retail_merchant.json

#############################################################
#
#                 Test Data Visualization
#
#############################################################
#
#  1-1 ----- 2-1-1 [img]
#        |
#        |-- 2-1-2 [img] ----- 3-1-2-1 ----- 4-1-2-1-1
#        |
#        |-- 2-1-3 ----------- 3-1-3-1
#                          |
#                          |-- 3-1-3-2
#                          |
#                          |-- 3-1-3-3
#
#  1-2 ----- 2-2-1 [img] ----- 3-2-1-1
#        |                 |
#        |                 |-- 3-2-1-2 ----- 4-2-1-2-1
#        |                               |
#        |                               |-- 4-2-1-2-2
#        |
#        |-- 2-2-2
#
#  1-3 ----- 2-3-1
#
#############################################################

# Menu Level 1 - 1
${menuLevel11NameTh}    เมนูเลเวล 1-1
${menuLevel11NameEn}    Menu Level 1-1
${menuLevel11LinkTh}    http://www.itruemart.com/
${menuLevel11LinkEn}    http://www.itruemart.com/en
${menuLevel11NewTab}    ${TRUE}
@{menuLevel11}          ${menuLevel11NameTh}    ${menuLevel11NameEn}     ${menuLevel11LinkTh}    ${menuLevel11LinkEn}    ${menuLevel11NewTab}
# Menu Level 1 - 2
${menuLevel12NameTh}    เมนูเลเวล 1-2
${menuLevel12NameEn}    Menu Level 1-2
${menuLevel12LinkTh}    ${EMPTY}
${menuLevel12LinkEn}    ${EMPTY}
${menuLevel12NewTab}    ${FALSE}
@{menuLevel12}          ${menuLevel12NameTh}    ${menuLevel12NameEn}     ${menuLevel12LinkTh}    ${menuLevel12LinkEn}    ${menuLevel12NewTab}
# Menu Level 1 - 3
${menuLevel13NameTh}    เมนูเลเวล 1-3
${menuLevel13NameEn}    Menu Level 1-3
${menuLevel13LinkTh}    http://www.itruemart.com/
${menuLevel13LinkEn}    http://www.itruemart.com/en
${menuLevel13NewTab}    ${TRUE}
@{menuLevel13}          ${menuLevel13NameTh}    ${menuLevel13NameEn}     ${menuLevel13LinkTh}    ${menuLevel13LinkEn}    ${menuLevel13NewTab}
# Menu Level 2 - 1 - 1
${menuLevel211NameTh}       เมนูเลเวล 2-1-1
${menuLevel211NameEn}       Menu Level 2-1-1
${menuLevel211LinkTh}       http://www.itruemart.com/
${menuLevel211LinkEn}       http://www.itruemart.com/en
${menuLevel211NewTab}       ${TRUE}
${menuLevel211ImgPathTh}    ${CURDIR}/../../../Resource/TestData/storefronts/menu/img211th.jpg
${menuLevel211ImgAltTh}     เมนูเลเวล 2-1-1
${menuLevel211ImgLinkTh}    http://www.wemall.com
${menuLevel211ImgPathEn}    ${CURDIR}/../../../Resource/TestData/storefronts/menu/img211en.jpg
${menuLevel211ImgAltEn}     Menu Level 2-1-1
${menuLevel211ImgLinkEn}    http://www.wemall.com/en
${menuLevel211ImgNewTab}    ${TRUE}
@{menuLevel211}             ${menuLevel211NameTh}       ${menuLevel211NameEn}      ${menuLevel211LinkTh}    ${menuLevel211LinkEn}    ${menuLevel211NewTab}
...                         ${menuLevel211ImgPathTh}    ${menuLevel211ImgAltTh}    ${menuLevel211ImgLinkTh}
...                         ${menuLevel211ImgPathEn}    ${menuLevel211ImgAltEn}    ${menuLevel211ImgLinkEn}
...                         ${menuLevel211ImgNewTab}
# Menu Level 2 - 1 - 2
${menuLevel212NameTh}       เมนูเลเวล 2-1-2
${menuLevel212NameEn}       Menu Level 2-1-2
${menuLevel212LinkTh}       http://www.itruemart.com/
${menuLevel212LinkEn}       http://www.itruemart.com/en
${menuLevel212NewTab}       ${TRUE}
${menuLevel212ImgPathTh}    ${CURDIR}/../../../Resource/TestData/storefronts/menu/img212th.jpg
${menuLevel212ImgAltTh}     เมนูเลเวล 2-1-2
${menuLevel212ImgLinkTh}    http://www.wemall.com
${menuLevel212ImgPathEn}    ${CURDIR}/../../../Resource/TestData/storefronts/menu/img212en.jpg
${menuLevel212ImgAltEn}     Menu Level 2-1-2
${menuLevel212ImgLinkEn}    http://www.wemall.com/en
${menuLevel212ImgNewTab}    ${FALSE}
@{menuLevel212}             ${menuLevel212NameTh}       ${menuLevel212NameEn}      ${menuLevel212LinkTh}    ${menuLevel212LinkEn}    ${menuLevel212NewTab}
...                         ${menuLevel212ImgPathTh}    ${menuLevel212ImgAltTh}    ${menuLevel212ImgLinkTh}
...                         ${menuLevel212ImgPathEn}    ${menuLevel212ImgAltEn}    ${menuLevel212ImgLinkEn}
...                         ${menuLevel212ImgNewTab}
@{menuLevel212_no_image}    ${menuLevel212NameTh}       ${menuLevel212NameEn}      ${menuLevel212LinkTh}    ${menuLevel212LinkEn}    ${menuLevel212NewTab}
# Menu Level 2 - 1 - 3
${menuLevel213NameTh}    เมนูเลเวล 2-1-3
${menuLevel213NameEn}    Menu Level 2-1-3
${menuLevel213LinkTh}    http://www.itruemart.com/
${menuLevel213LinkEn}    http://www.itruemart.com/en
${menuLevel213NewTab}    ${TRUE}
@{menuLevel213}          ${menuLevel213NameTh}    ${menuLevel213NameEn}     ${menuLevel213LinkTh}    ${menuLevel213LinkEn}    ${menuLevel213NewTab}
# Menu Level 2 - 2 - 1
${menuLevel221NameTh}       เมนูเลเวล 2-2-1
${menuLevel221NameEn}       Menu Level 2-2-1
${menuLevel221LinkTh}       http://www.itruemart.com/
${menuLevel221LinkEn}       http://www.itruemart.com/en
${menuLevel221NewTab}       ${TRUE}
${menuLevel221ImgPathTh}    ${CURDIR}/../../../Resource/TestData/storefronts/menu/img221th.jpg
${menuLevel221ImgAltTh}     เมนูเลเวล 2-2-1
${menuLevel221ImgLinkTh}    http://www.wemall.com/
${menuLevel221ImgPathEn}    ${CURDIR}/../../../Resource/TestData/storefronts/menu/img221en.jpg
${menuLevel221ImgAltEn}     Menu Level 2-2-1
${menuLevel221ImgLinkEn}    http://www.wemall.com/en
${menuLevel221ImgNewTab}    ${TRUE}
@{menuLevel221}             ${menuLevel221NameTh}    ${menuLevel221NameEn}     ${menuLevel221LinkTh}    ${menuLevel221LinkEn}    ${menuLevel221NewTab}
...                         ${menuLevel212ImgPathTh}    ${menuLevel212ImgAltTh}    ${menuLevel212ImgLinkTh}
...                         ${menuLevel212ImgPathEn}    ${menuLevel212ImgAltEn}    ${menuLevel212ImgLinkEn}
...                         ${menuLevel212ImgNewTab}
@{menuLevel221_no_image}    ${menuLevel221NameTh}    ${menuLevel221NameEn}     ${menuLevel221LinkTh}    ${menuLevel221LinkEn}    ${menuLevel221NewTab}
# Menu Level 2 - 2 - 2
${menuLevel222NameTh}    เมนูเลเวล 2-2-2
${menuLevel222NameEn}    Menu Level 2-2-2
${menuLevel222LinkTh}    http://www.itruemart.com/
${menuLevel222LinkEn}    http://www.itruemart.com/en
${menuLevel222NewTab}    ${TRUE}
@{menuLevel222}          ${menuLevel222NameTh}    ${menuLevel222NameEn}     ${menuLevel222LinkTh}    ${menuLevel222LinkEn}    ${menuLevel222NewTab}
# Menu Level 2 - 3 - 1
${menuLevel231NameTh}    เมนูเลเวล 2-3-1
${menuLevel231NameEn}    Menu Level 2-3-1
${menuLevel231LinkTh}    http://www.itruemart.com/
${menuLevel231LinkEn}    http://www.itruemart.com/en
${menuLevel231NewTab}    ${TRUE}
@{menuLevel231}          ${menuLevel231NameTh}    ${menuLevel231NameEn}     ${menuLevel231LinkTh}    ${menuLevel231LinkEn}    ${menuLevel231NewTab}
# Modified Menu Level 2 - 2 -2
${newMenuLevel222NameTh}    เมนูเลเวล 2-2-2 ใหม่
${newMenuLevel222NameEn}    Menu Level 2-2-2 NEW
${newMenuLevel222LinkTh}    http://www.itruemart.com/new
${newMenuLevel222LinkEn}    http://www.itruemart.com/en/new
${newMenuLevel222NewTab}    ${FALSE}
@{newMenuLevel222}          ${newMenuLevel222NameTh}    ${newMenuLevel222NameEn}     ${newMenuLevel222LinkTh}    ${newMenuLevel222LinkEn}    ${newMenuLevel222NewTab}
# Menu Level 3 - 1 - 2 - 1
${menuLevel3121NameTh}    เมนูเลเวล 3-1-2-1
${menuLevel3121NameEn}    Menu Level 3-1-2-1
${menuLevel3121LinkTh}    http://www.itruemart.com/
${menuLevel3121LinkEn}    http://www.itruemart.com/en
${menuLevel3121NewTab}    ${TRUE}
@{menuLevel3121}          ${menuLevel3121NameTh}    ${menuLevel3121NameEn}     ${menuLevel3121LinkTh}    ${menuLevel3121LinkEn}    ${menuLevel3121NewTab}
# Menu Level 3 - 1 - 3 - 1
${menuLevel3131NameTh}    เมนูเลเวล 3-1-3-1
${menuLevel3131NameEn}    Menu Level 3-1-3-1
${menuLevel3131LinkTh}    http://www.itruemart.com/
${menuLevel3131LinkEn}    http://www.itruemart.com/en
${menuLevel3131NewTab}    ${TRUE}
@{menuLevel3131}          ${menuLevel3131NameTh}    ${menuLevel3131NameEn}     ${menuLevel3131LinkTh}    ${menuLevel3131LinkEn}    ${menuLevel3131NewTab}
# Menu Level 3 - 1 - 3 - 2
${menuLevel3132NameTh}    เมนูเลเวล 3-1-3-2
${menuLevel3132NameEn}    Menu Level 3-1-3-2
${menuLevel3132LinkTh}    http://www.itruemart.com/
${menuLevel3132LinkEn}    http://www.itruemart.com/en
${menuLevel3132NewTab}    ${TRUE}
@{menuLevel3132}          ${menuLevel3132NameTh}    ${menuLevel3132NameEn}     ${menuLevel3132LinkTh}    ${menuLevel3132LinkEn}    ${menuLevel3132NewTab}
# Menu Level 3 - 1 - 3 - 3
${menuLevel3133NameTh}    เมนูเลเวล 3-1-3-3
${menuLevel3133NameEn}    Menu Level 3-1-3-3
${menuLevel3133LinkTh}    http://www.itruemart.com/
${menuLevel3133LinkEn}    http://www.itruemart.com/en
${menuLevel3133NewTab}    ${TRUE}
@{menuLevel3133}          ${menuLevel3133NameTh}    ${menuLevel3133NameEn}     ${menuLevel3133LinkTh}    ${menuLevel3133LinkEn}    ${menuLevel3133NewTab}
# Menu Level 3 - 2 - 1 - 1
${menuLevel3211NameTh}    เมนูเลเวล 3-2-1-1
${menuLevel3211NameEn}    Menu Level 3-2-1-1
${menuLevel3211LinkTh}    http://www.itruemart.com/
${menuLevel3211LinkEn}    http://www.itruemart.com/en
${menuLevel3211NewTab}    ${TRUE}
@{menuLevel3211}          ${menuLevel3211NameTh}    ${menuLevel3211NameEn}     ${menuLevel3211LinkTh}    ${menuLevel3211LinkEn}    ${menuLevel3211NewTab}
# Menu Level 3 - 2 - 1 - 2
${menuLevel3212NameTh}    เมนูเลเวล 3-2-1-2
${menuLevel3212NameEn}    Menu Level 3-2-1-2
${menuLevel3212LinkTh}    http://www.itruemart.com/
${menuLevel3212LinkEn}    http://www.itruemart.com/en
${menuLevel3212NewTab}    ${TRUE}
@{menuLevel3212}          ${menuLevel3212NameTh}    ${menuLevel3212NameEn}     ${menuLevel3212LinkTh}    ${menuLevel3212LinkEn}    ${menuLevel3212NewTab}

# Menu Level 4 - 1 - 2 - 1 - 1
${menuLevel41211NameTh}    เมนูเลเวล 4-1-2-1-1
${menuLevel41211NameEn}    Menu Level 4-1-2-1-1
${menuLevel41211LinkTh}    http://www.itruemart.com/
${menuLevel41211LinkEn}    http://www.itruemart.com/en
${menuLevel41211NewTab}    ${TRUE}
@{menuLevel41211}          ${menuLevel41211NameTh}    ${menuLevel41211NameEn}     ${menuLevel41211LinkTh}    ${menuLevel41211LinkEn}    ${menuLevel41211NewTab}

# Modified Menu Level 4 - 1 - 2 - 1 - 1
${newMenuLevel41211NameTh}    เมนูเลเวล  4 - 1 - 2 - 1 - 1 ใหม่
${newMenuLevel41211NameEn}    Menu Level  4 - 1 - 2 - 1 - 1 NEW
${newMenuLevel41211LinkTh}    http://www.itruemart.com/new
${newMenuLevel41211LinkEn}    http://www.itruemart.com/en/new
${newMenuLevel41211NewTab}    ${FALSE}
@{newMenuLevel41211}          ${newMenuLevel41211NameTh}    ${newMenuLevel41211NameEn}     ${newMenuLevel41211LinkTh}    ${newMenuLevel41211LinkEn}    ${newMenuLevel41211NewTab}

# Menu Level 4 - 2 - 1 - 2 - 1
${menuLevel42121NameTh}    เมนูเลเวล 4-2-1-2-1
${menuLevel42121NameEn}    Menu Level 4-2-1-2-1
${menuLevel42121LinkTh}    http://www.itruemart.com/
${menuLevel42121LinkEn}    http://www.itruemart.com/en
${menuLevel42121NewTab}    ${TRUE}
@{menuLevel42121}          ${menuLevel42121NameTh}    ${menuLevel42121NameEn}     ${menuLevel42121LinkTh}    ${menuLevel42121LinkEn}    ${menuLevel42121NewTab}

# Menu Level 4 - 2 - 1 - 2 - 2
${menuLevel42122NameTh}    เมนูเลเวล 4-2-1-2-2
${menuLevel42122NameEn}    Menu Level 4-2-1-2-2
${menuLevel42122LinkTh}    http://www.itruemart.com/
${menuLevel42122LinkEn}    http://www.itruemart.com/en
${menuLevel42122NewTab}    ${TRUE}
@{menuLevel42122}          ${menuLevel42122NameTh}    ${menuLevel42122NameEn}     ${menuLevel42122LinkTh}    ${menuLevel42122LinkEn}    ${menuLevel42122NewTab}

# Menu Level 4 - 2 - 1 - 2 - 3
${menuLevel42123NameTh}    เมนูเลเวล 4-2-1-2-3
${menuLevel42123NameEn}    Menu Level 4-2-1-2-3
${menuLevel42123LinkTh}    http://www.itruemart.com/
${menuLevel42123LinkEn}    http://www.itruemart.com/en
${menuLevel42123NewTab}    ${TRUE}
@{menuLevel42123}          ${menuLevel42123NameTh}    ${menuLevel42123NameEn}     ${menuLevel42123LinkTh}    ${menuLevel42123LinkEn}    ${menuLevel42123NewTab}

# Logo
${menuLogoImgThFileName}    toshiba.png
${menuLogoImgEnFileName}    panasonic.png
${menuLogoImgThPath}        ${CURDIR}/../../../Resource/TestData/storefronts/menu/toshiba.png
${menuLogoImgEnPath}        ${CURDIR}/../../../Resource/TestData/storefronts/menu/panasonic.png
${menuLogoLinkTh}           http://www.itruemart.com/
${menuLogoLinkEn}           http://www.itruemart.com/en
${menuLogoOpenNewTab}       ${TRUE}
@{menuLogoShopSony}       ${menuLogoImgThPath}    ${menuLogoLinkTh}    ${menuLogoImgEnPath}    ${menuLogoLinkEn}    ${menuLogoOpenNewTab}

*** Test Cases ***
TC_WMALL_00122 Menu cms will show detail for web only
    [Tags]    Regression    cms_storefront    storefront_menu    WLS_High
    Go To Menu Editor Page For Web    ${suite_shop_id}
    Status Should Be Inactive
    Menu Panel List Is Empty    level=1
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}

TC_WMALL_00123 Click add menu level 1 will show add menu level 1 popup
    [Tags]    Regression    cms_storefront    storefront_menu    WLS_High
    Go To Menu Editor Page For Web    ${suite_shop_id}
    Click Add Menu Button    level=1
    Verify Add Menu Popup Appears    level=1
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}

TC_WMALL_00124 Don't fill required field when add menu level 1 will show error message
    [Tags]    Regression    cms_storefront    storefront_menu    WLS_High
    Go To Menu Editor Page For Web    ${suite_shop_id}
    Click Add Menu Button    level=1
    Click Ok Button on Modal Dialog
    Verify Modal Dialog Alert Appears    ${PLEASE_ENTER_ALL_FIELDS_MSG}
    Click Cancel Button on Modal Dialog
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    version=draft
    Verify Menu from API Storefront Menus is Empty    ${Response}
    Verify Menu Status from API Storefront Menus    ${Response}    inactive
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}

TC_WMALL_00125 Add level 1 menu items then the items will be listed on level 1 panel
    [Tags]    Regression    cms_storefront    storefront_menu    WLS_High
    Go To Menu Editor Page For Web    ${suite_shop_id}
    Click Add Menu Button    level=1
    Fill In Menu Data    @{menuLevel11}
    Click Ok Button on Modal Dialog
    Menu Panel List Should Contain    1    ${menuLevel11NameTh}
    Click Add Menu Button    level=1
    Fill In Menu Data    @{menuLevel12}
    Click Ok Button on Modal Dialog
    Menu Panel List Should Contain    1    ${menuLevel11NameTh}     ${menuLevel12NameTh}
    Click Add Menu Button    level=1
    Fill In Menu Data    @{menuLevel13}
    Click Cancel Button on Modal Dialog
    Menu Panel List Should Contain    1    ${menuLevel11NameTh}     ${menuLevel12NameTh}
    Set Status To Active
    Click Save Button
    Verify Status Message Appears    ${SAVE_DRAFT_SUCCESS_MSG}
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=1
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/1    expected=@{menuLevel12}    max_level=1
    Verify Menu Status from API Storefront Menus    ${Response}    active
    Click Preview Button
    Verify Preview Storefront with Storefront Menu from Response    ${shop_slug}    ${suite_shop_id}
    Close Preview Storefront Window    ${shop_slug}
    Click Publish Button
    Verify Published Storefront with Storefront Menu from Response    ${shop_slug}    ${suite_shop_id}
    Close Storefront Window    ${shop_slug}
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}

TC_WMALL_00126 Edit level 1 menu
    [Tags]    Regression    cms_storefront    storefront_menu    WLS_High
    Go To Menu Editor Page For Web    ${suite_shop_id}
#   Add Menu Level 1
    Create Menu    1    @{menuLevel11}
    Menu Panel List Should Contain    1    ${menuLevel11NameTh}
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=1
    Verify Menu Status from API Storefront Menus    ${Response}    inactive
#   Edit Menu Level 1
    Click Edit Menu Button    level=1    menu_name=${menuLevel11NameTh}
    Verify Edit Menu Popup Appears    level=1
    Fill In Menu Data    @{menuLevel12}
    Click Ok Button on Modal Dialog
    Menu Panel List Should Contain    1    ${menuLevel12NameTh}
    Click Edit Menu Button    level=1    menu_name=${menuLevel12NameTh}
    Verify Menu Data    @{menuLevel12}
    Click Ok Button on Modal Dialog
    Set Status To Active
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel12}    max_level=1
    Verify Menu Status from API Storefront Menus    ${Response}    active
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}

TC_WMALL_00127 Add level 2 menu
    [Tags]    Regression    cms_storefront    storefront_menu    WLS_High
    Go To Menu Editor Page For Web    ${suite_shop_id}
#   Create Level 1 Menus
    Create Menu                        1    @{menuLevel11}
    Create Menu                        1    @{menuLevel12}
#   Create Level 2 Menus
    Select Menu                        1    ${menuLevel11NameTh}
    Click Add Menu Button              2
    Verify Add Menu Popup Appears      2
    Fill In Menu Data                  @{menuLevel211}
    Click Ok Button on Modal Dialog
    Click Add Menu Button              2
    Fill In Menu Data                  @{menuLevel212}
    Click Ok Button on Modal Dialog
    Click Add Menu Button              2
    Fill In Menu Data                  @{menuLevel213}
    Click Ok Button on Modal Dialog
    Menu Panel List Should Contain     2    ${menuLevel211NameTh}    ${menuLevel212NameTh}    ${menuLevel213NameTh}
#   Create another Level 2 Menus
    Select Menu                        1    ${menuLevel12NameTh}
    Click Add Menu Button              2
    Fill In Menu Data                  @{menuLevel221}
    Click Ok Button on Modal Dialog
    Click Add Menu Button              2
    Fill In Menu Data                  @{menuLevel222}
    Click Ok Button on Modal Dialog
    Menu Panel List Should Contain     2    ${menuLevel221NameTh}    ${menuLevel222NameTh}
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=2
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel211}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/1    expected=@{menuLevel212}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/2    expected=@{menuLevel213}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/1    expected=@{menuLevel12}    max_level=2
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/1/children/0    expected=@{menuLevel221}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/1/children/1    expected=@{menuLevel222}
    Verify Menu Status from API Storefront Menus    ${Response}    inactive
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}

TC_WMALL_01788 Delete image in menu level 2
    [Tags]    Regression    cms_storefront    storefront_menu    WLS_High
    Go To Menu Editor Page For Web    ${suite_shop_id}
#   Create Level 1 Menus
    Create Menu                        1    @{menuLevel11}
    Create Menu                        1    @{menuLevel12}
#   Create Level 2 Menus
    Select Menu                        1    ${menuLevel11NameTh}
    Click Add Menu Button              2
    Verify Add Menu Popup Appears      2
    Fill In Menu Data                  @{menuLevel211}
    Click Ok Button on Modal Dialog
    Click Add Menu Button              2
    Fill In Menu Data                  @{menuLevel212}
    Click Ok Button on Modal Dialog
    Click Add Menu Button              2
    Fill In Menu Data                  @{menuLevel213}
    Click Ok Button on Modal Dialog
    Menu Panel List Should Contain     2    ${menuLevel211NameTh}    ${menuLevel212NameTh}    ${menuLevel213NameTh}
#   Create another Level 2 Menus
    Select Menu                        1    ${menuLevel12NameTh}
    Click Add Menu Button              2
    Fill In Menu Data                  @{menuLevel221}
    Click Ok Button on Modal Dialog
    Click Add Menu Button              2
    Fill In Menu Data                  @{menuLevel222}
    Click Ok Button on Modal Dialog
    Menu Panel List Should Contain     2    ${menuLevel221NameTh}    ${menuLevel222NameTh}
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=2
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel211}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/1    expected=@{menuLevel212}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/2    expected=@{menuLevel213}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/1    expected=@{menuLevel12}    max_level=2
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/1/children/0    expected=@{menuLevel221}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/1/children/1    expected=@{menuLevel222}
    Verify Menu Status from API Storefront Menus    ${Response}    inactive

# Delete image from menu level 2
    Select Menu                        1    ${menuLevel11NameTh}
    Click Edit Menu Button             2    ${menuLevel211NameTh}
    Click Delete Image Menu Data Button
    Click Cancel on the Delete Image Menu Data Confirmation Dialog
    Click Ok Button on Modal Dialog

    Click Edit Menu Button             2    ${menuLevel212NameTh}
    Click Delete Image Menu Data Button
    Click Confirm on the Delete Image Menu Data Confirmation Dialog
    Click Ok Button on Modal Dialog

    Select Menu                        1    ${menuLevel12NameTh}
    Click Edit Menu Button             2    ${menuLevel221NameTh}
    Click Delete Image Menu Data Button
    Click Confirm on the Delete Image Menu Data Confirmation Dialog
    Click Ok Button on Modal Dialog
    Click Save Button

    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=2
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel211}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/1    expected=@{menuLevel212_no_image}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/2    expected=@{menuLevel213}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/1    expected=@{menuLevel12}    max_level=2
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/1/children/0    expected=@{menuLevel221_no_image}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/1/children/1    expected=@{menuLevel222}
    Verify Menu Status from API Storefront Menus    ${Response}    inactive
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}

TC_WMALL_00128 Don't fill required field when add menu level 2 will show error message
    [Tags]    Regression    cms_storefront    storefront_menu    WLS_High
    Go To Menu Editor Page For Web       ${suite_shop_id}
#   Create Level 1 Menus
    Create Menu                          1           @{menuLevel11}
#   Try to create level 2 menus
    Select Menu                          1           ${menuLevel11NameTh}
    Click Add Menu Button                2
    Fill In Menu Data                    ${EMPTY}    NameEN    LinkTH    LinkEN    ${FALSE}
    Click Ok Button on Modal Dialog
    Verify Modal Dialog Alert Appears    ${PLEASE_ENTER_ALL_FIELDS_MSG}
    Click Cancel Button on Modal Dialog
    Set Status To Active
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=1
    Verify Menu Status from API Storefront Menus    ${Response}    active
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}

TC_WMALL_00129 Edit level 2 menu
    [Tags]    Regression    cms_storefront    storefront_menu    WLS_High
    Go To Menu Editor Page For Web    ${suite_shop_id}
#   Create Level 1 Menus
    Create Menu                       1    @{menuLevel11}
#   Create Level 2 Menus
    Select Menu                       1    ${menuLevel11NameTh}
    Create Menu                       2    @{menuLevel211}
    Menu Panel List Should Contain    2    ${menuLevel211NameTh}
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=2
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel211}
    Verify Menu Status from API Storefront Menus    ${Response}    inactive
#   Edit Level 2 Menus
    Click Edit Menu Button            2    ${menuLevel211NameTh}
    Verify Edit Menu Popup Appears    2
    Verify Menu Data                  @{menuLevel211}
    Fill In Menu Data                 @{menuLevel212}
    Click Ok Button on Modal Dialog
    Menu Panel List Should Contain    2    ${menuLevel212NameTh}
    Click Edit Menu Button            2    ${menuLevel212NameTh}
    Verify Menu Data                  @{menuLevel212}
    Click Ok Button on Modal Dialog
    Set Status To Active
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=2
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel212}
    Verify Menu Status from API Storefront Menus    ${Response}    active
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}

TC_WMALL_01770 Add level 3 menu
    [Tags]    Regression    cms_storefront    storefront_menu    WLS_High
    Go To Menu Editor Page For Web    ${suite_shop_id}
#   Create Level 1 Menus
    Create Menu                       1                  @{menuLevel11}
    Create Menu                       1                  @{menuLevel12}
#   Create Level 2 Menus
    Select Menu                       level=1            menu_name=${menuLevel11NameTh}
    Create Menu                       2                  @{menuLevel213}
    Select Menu                       level=1            menu_name=${menuLevel12NameTh}
    Create Menu                       2                  @{menuLevel221}
    Create Menu                       2                  @{menuLevel222}
#   Create Level 3 Menus
    Select Menu                       level=1            menu_name=${menuLevel12NameTh}
    Select Menu                       level=2            menu_name=${menuLevel221NameTh}
    Click Add Menu Button             level=3
    Verify Add Menu Popup Appears     level=3
    Fill In Menu Data                 @{menuLevel3211}
    Click Ok Button on Modal Dialog
    Click Add Menu Button             level=3
    Fill In Menu Data                 @{menuLevel3212}
    Click Ok Button on Modal Dialog
    Menu Panel List Should Contain    3    ${menuLevel3211NameTh}    ${menuLevel3212NameTh}
#   Create Another Level 3 Menus
    Select Menu                       level=1            menu_name=${menuLevel11NameTh}
    Select Menu                       level=2            menu_name=${menuLevel213NameTh}
    Click Add Menu Button             level=3
    Verify Add Menu Popup Appears     level=3
    Fill In Menu Data                 @{menuLevel3131}
    Click Ok Button on Modal Dialog
    Click Add Menu Button             level=3
    Fill In Menu Data                 @{menuLevel3132}
    Click Ok Button on Modal Dialog
    Menu Panel List Should Contain    3    ${menuLevel3131NameTh}    ${menuLevel3132NameTh}
    Set Status To Inactive
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=3
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel213}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0    expected=@{menuLevel3131}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/1    expected=@{menuLevel3132}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/1    expected=@{menuLevel12}    max_level=3
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/1/children/0    expected=@{menuLevel221}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/1/children/0/children/0    expected=@{menuLevel3211}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/1/children/0/children/1    expected=@{menuLevel3212}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/1/children/1    expected=@{menuLevel222}
    Verify Menu Status from API Storefront Menus    ${Response}    inactive
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}

TC_WMALL_01771 Don't fill required field when add menu level 3 will show error message
    [Tags]    Regression    cms_storefront    storefront_menu    WLS_High
    Go To Menu Editor Page For Web    ${suite_shop_id}
#   Create Level 1 Menus
    Create Menu                          1          @{menuLevel11}
#   Create Level 2 Menus
    Select Menu                          1          ${menuLevel11NameTh}
    Create Menu                          2          @{menuLevel212}
#   Create Level 3 Menus
    Select Menu                          2          ${menuLevel212NameTh}
    Click Add Menu Button                3
    Fill In Menu Data                    NameTH     ${EMPTY}    LinkTH    LinkEN    ${FALSE}
    Click Ok Button on Modal Dialog
    Verify Modal Dialog Alert Appears    ${PLEASE_ENTER_ALL_FIELDS_MSG}
    Click Cancel Button on Modal Dialog
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=2
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel212}
    Verify Menu Status from API Storefront Menus    ${Response}    inactive
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}

TC_WMALL_01772 Edit level 3 menu
    [Tags]    Regression    cms_storefront    storefront_menu    WLS_High
    Go To Menu Editor Page For Web    ${suite_shop_id}
#   Create Level 1 Menus
    Create Menu                       1          @{menuLevel11}
#   Create Level 2 Menus
    Select Menu                       level=1    menu_name=${menuLevel11NameTh}
    Create Menu                       2          @{menuLevel213}
    Menu Panel List Should Contain    2          ${menuLevel213NameTh}
#   Create Level 3 Menus
    Select Menu                       level=1    menu_name=${menuLevel11NameTh}
    Select Menu                       level=2    menu_name=${menuLevel213NameTh}
    Create Menu                       3          @{menuLevel3131}
    Menu Panel List Should Contain    3          ${menuLevel3131NameTh}
    Set Status To Active
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=3
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel213}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0    expected=@{menuLevel3131}
    Verify Menu Status from API Storefront Menus    ${Response}    active
#   Edit Level 3 Menus
    Click Edit Menu Button            level=3    menu_name=${menuLevel3131NameTh}
    Verify Edit Menu Popup Appears    level=3
    Fill In Menu Data                 @{menuLevel3132}
    Click Ok Button on Modal Dialog
    Menu Panel List Should Contain    3          ${menuLevel3132NameTh}
    Click Edit Menu Button            level=3    menu_name=${menuLevel3132NameTh}
    Verify Menu Data                  @{menuLevel3132}
    Click Ok Button on Modal Dialog
    Set Status To Inactive
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=3
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel213}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0    expected=@{menuLevel3132}
    Verify Menu Status from API Storefront Menus    ${Response}    inactive
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}

TC_WMALL_01773 Add level 4 menu
    [Tags]    Regression    cms_storefront    storefront_menu    WLS_High
    Go To Menu Editor Page For Web    ${suite_shop_id}
#   Create Level 1 Menus
    Create Menu                       1                  @{menuLevel11}
    Create Menu                       1                  @{menuLevel12}
#   Create Level 2 Menus
    Select Menu                       level=1            menu_name=${menuLevel11NameTh}
    Create Menu                       2                  @{menuLevel212}
    Create Menu                       2                  @{menuLevel213}
    Select Menu                       level=1            menu_name=${menuLevel12NameTh}
    Create Menu                       2                  @{menuLevel221}
    Create Menu                       2                  @{menuLevel222}
#   Create Level 3 Menus
    Select Menu                       level=1            menu_name=${menuLevel12NameTh}
    Select Menu                       level=2            menu_name=${menuLevel221NameTh}
    Create Menu                       3                  @{menuLevel3211}
    Create Menu                       3                  @{menuLevel3212}
    Select Menu                       level=1            menu_name=${menuLevel12NameTh}
    Select Menu                       level=2            menu_name=${menuLevel221NameTh}
    Select Menu                       level=1            menu_name=${menuLevel11NameTh}
    Select Menu                       level=2            menu_name=${menuLevel212NameTh}
    Create Menu                       3                  @{menuLevel3121}
#   Create Level 4 Menus
    Select Menu                       level=1            menu_name=${menuLevel12NameTh}
    Select Menu                       level=2            menu_name=${menuLevel221NameTh}
    Select Menu                       level=3            menu_name=${menuLevel3212NameTh}
    Click Add Menu Button             level=4
    Verify Add Menu Popup Appears     level=4
    Fill In Menu Data                 @{menuLevel42121}
    Click Ok Button on Modal Dialog
    Click Add Menu Button             level=4
    Fill In Menu Data                 @{menuLevel42122}
    Click Ok Button on Modal Dialog
    Menu Panel List Should Contain    4    ${menuLevel42121NameTh}    ${menuLevel42122NameTh}
#   Create Another Level 4 Menus
    Select Menu                       level=1            menu_name=${menuLevel11NameTh}
    Select Menu                       level=2            menu_name=${menuLevel212NameTh}
    Select Menu                       level=3            menu_name=${menuLevel3121NameTh}
    Click Add Menu Button             level=4
    Verify Add Menu Popup Appears     level=4
    Fill In Menu Data                 @{menuLevel41211}
    Click Ok Button on Modal Dialog
    Menu Panel List Should Contain    4    ${menuLevel41211NameTh}
    Set Status To Inactive
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=4
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel212}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0    expected=@{menuLevel3121}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0/children/0    expected=@{menuLevel41211}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/1    expected=@{menuLevel213}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/1    expected=@{menuLevel12}    max_level=4
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/1/children/0    expected=@{menuLevel221}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/1/children/0/children/0    expected=@{menuLevel3211}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/1/children/0/children/1    expected=@{menuLevel3212}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/1/children/0/children/1/children/0    expected=@{menuLevel42121}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/1/children/0/children/1/children/1    expected=@{menuLevel42122}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/1/children/1    expected=@{menuLevel222}
    Verify Menu Status from API Storefront Menus    ${Response}    inactive
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}

TC_WMALL_01774 Don't fill required field when add menu level 4 will show error message
    [Tags]    Regression    cms_storefront    storefront_menu    WLS_High
    Go To Menu Editor Page For Web    ${suite_shop_id}
#   Create Level 1 Menus
    Create Menu                          1          @{menuLevel11}
#   Create Level 2 Menus
    Select Menu                          1          ${menuLevel11NameTh}
    Create Menu                          2          @{menuLevel211}
    Create Menu                          2          @{menuLevel212}
#   Create Level 3 Menus
    Select Menu                          2          ${menuLevel212NameTh}
    Create Menu                          3          @{menuLevel3121}
#   Create Level 4 Menus
    Select Menu                          3          ${menuLevel3121NameTh}
    Click Add Menu Button                level=4
    Fill In Menu Data                    NameTH     ${EMPTY}    LinkTH    LinkEN    ${FALSE}
    Click Ok Button on Modal Dialog
    Verify Modal Dialog Alert Appears    ${PLEASE_ENTER_ALL_FIELDS_MSG}
    Click Cancel Button on Modal Dialog
    Set Status To Active
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=3
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel211}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/1    expected=@{menuLevel212}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/1/children/0    expected=@{menuLevel3121}
    Verify Menu Status from API Storefront Menus    ${Response}    active
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}

TC_WMALL_01775 Edit level 4 menu
    [Tags]    Regression    cms_storefront    storefront_menu    WLS_High
    Go To Menu Editor Page For Web    ${suite_shop_id}
#   Create Level 1 Menus
    Create Menu                          1          @{menuLevel11}
#   Create Level 2 Menus
    Select Menu                          1          ${menuLevel11NameTh}
    Create Menu                          2          @{menuLevel211}
    Create Menu                          2          @{menuLevel212}
#   Create Level 3 Menus
    Select Menu                          2          ${menuLevel212NameTh}
    Create Menu                          3          @{menuLevel3121}
#   Create Level 4 Menus
    Select Menu                          3          ${menuLevel3121NameTh}
    Create Menu                          4          @{menuLevel41211}
    Set Status To Inactive
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=4
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel211}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/1    expected=@{menuLevel212}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/1/children/0    expected=@{menuLevel3121}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/1/children/0/children/0    expected=@{menuLevel41211}
    Verify Menu Status from API Storefront Menus    ${Response}    inactive
#   Edit Level 4 Menus
    Click Edit Menu Button            level=4    menu_name=${menuLevel41211NameTh}
    Verify Edit Menu Popup Appears    level=4
    Fill In Menu Data                 @{newMenuLevel41211}
    Click Ok Button on Modal Dialog
    Menu Panel List Should Contain    4          ${newMenuLevel41211NameTh}
    Set Status To Active
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=4
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel211}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/1    expected=@{menuLevel212}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/1/children/0    expected=@{menuLevel3121}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/1/children/0/children/0    expected=@{newMenuLevel41211}
    Verify Menu Status from API Storefront Menus    ${Response}    active
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}

TC_WMALL_01776 Delete level 4 menu
    [Tags]    Regression    cms_storefront    storefront_menu    WLS_High
    Go To Menu Editor Page For Web    ${suite_shop_id}
#   Create Level 1 Menus
    Create Menu            1          @{menuLevel11}
#   Create Level 2 Menus
    Select Menu            level=1    menu_name=${menuLevel11NameTh}
    Create Menu            2          @{menuLevel213}
#   Create LEvel 3 Menus
    Select Menu            level=1    menu_name=${menuLevel11NameTh}
    Select Menu            level=2    menu_name=${menuLevel213NameTh}
    Create Menu            3          @{menuLevel3131}
    Create Menu            3          @{menuLevel3132}
    Create Menu            3          @{menuLevel3133}
#   Create LEvel 4 Menus
    Select Menu            level=1    menu_name=${menuLevel11NameTh}
    Select Menu            level=2    menu_name=${menuLevel213NameTh}
    Select Menu            level=3    menu_name=${menuLevel3131NameTh}
    Create Menu            4          @{menuLevel42121}
    Create Menu            4          @{menuLevel42122}
    Create Menu            4          @{menuLevel42123}
    Menu Panel List Should Contain    4    ${menuLevel42121NameTh}    ${menuLevel42122NameTh}    ${menuLevel42123NameTh}
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=4
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel213}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0    expected=@{menuLevel3131}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0/children/0    expected=@{menuLevel42121}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0/children/1    expected=@{menuLevel42122}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0/children/2    expected=@{menuLevel42123}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/1    expected=@{menuLevel3132}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/2    expected=@{menuLevel3133}
    Verify Menu Status from API Storefront Menus    ${Response}    inactive
#   Delete 1 menu of Menus Level 4
    Click Delete Menu Button    level=4    menu_name=${menuLevel42121NameTh}
    Verify Delete Menu Confirmation Dialog Appears    ${menuLevel42121NameTh}
    Click Cancel on the Delete Menu Confirmation Dialog
    Menu Panel List Should Contain    4    ${menuLevel42121NameTh}    ${menuLevel42122NameTh}    ${menuLevel42123NameTh}
    Click Delete Menu Button    level=4    menu_name=${menuLevel42121NameTh}
    Click Confirm on the Delete Menu Confirmation Dialog
    Menu Panel List Should Contain    4    ${menuLevel42122NameTh}    ${menuLevel42123NameTh}
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=4
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel213}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0    expected=@{menuLevel3131}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0/children/0    expected=@{menuLevel42122}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0/children/1    expected=@{menuLevel42123}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/1    expected=@{menuLevel3132}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/2    expected=@{menuLevel3133}
    Verify Menu Status from API Storefront Menus    ${Response}    inactive
#   Delete All menu in Menus Level 4
    Click Delete Menu Button    level=4    menu_name=${menuLevel42122NameTh}
    Click Confirm on the Delete Menu Confirmation Dialog
    Menu Panel List Should Contain    4    ${menuLevel42123NameTh}
    Click Save Button
    Click Delete Menu Button    level=4    menu_name=${menuLevel42123NameTh}
    Click Confirm on the Delete Menu Confirmation Dialog
    Menu Panel List Is Empty    level=4
    Set Status To Active
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=3
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel213}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0    expected=@{menuLevel3131}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/1    expected=@{menuLevel3132}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/2    expected=@{menuLevel3133}
    Verify Menu Status from API Storefront Menus    ${Response}    active
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}

TC_WMALL_01777 Delete level 3 menu
    [Tags]    Regression    cms_storefront    storefront_menu    WLS_High
    Go To Menu Editor Page For Web    ${suite_shop_id}
#   Create Level 1 Menus
    Create Menu            1          @{menuLevel11}
#   Create Level 2 Menus
    Select Menu            level=1    menu_name=${menuLevel11NameTh}
    Create Menu            2          @{menuLevel213}
#   Create LEvel 3 Menus
    Select Menu            level=1    menu_name=${menuLevel11NameTh}
    Select Menu            level=2    menu_name=${menuLevel213NameTh}
    Create Menu            3          @{menuLevel3131}
    Create Menu            3          @{menuLevel3132}
    Create Menu            3          @{menuLevel3133}
    Menu Panel List Should Contain    3    ${menuLevel3131NameTh}    ${menuLevel3132NameTh}    ${menuLevel3133NameTh}
    #   Create LEvel 4 Menus
    Select Menu            level=1    menu_name=${menuLevel11NameTh}
    Select Menu            level=2    menu_name=${menuLevel213NameTh}
    Select Menu            level=3    menu_name=${menuLevel3131NameTh}
    Create Menu            4          @{menuLevel42121}
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=4
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel213}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0    expected=@{menuLevel3131}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0/children/0    expected=@{menuLevel42121}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/1    expected=@{menuLevel3132}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/2    expected=@{menuLevel3133}
    Verify Menu Status from API Storefront Menus    ${Response}    inactive
#   Delete Level 3 Menus
    Click Delete Menu Button    level=3    menu_name=${menuLevel3132NameTh}
    Verify Delete Menu Confirmation Dialog Appears    ${menuLevel3132NameTh}
    Click Cancel on the Delete Menu Confirmation Dialog
    Menu Panel List Should Contain    3    ${menuLevel3131NameTh}    ${menuLevel3132NameTh}    ${menuLevel3133NameTh}
    Click Delete Menu Button    level=3    menu_name=${menuLevel3132NameTh}
    Click Confirm on the Delete Menu Confirmation Dialog
    Menu Panel List Should Contain    3    ${menuLevel3131NameTh}    ${menuLevel3133NameTh}
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=4
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel213}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0    expected=@{menuLevel3131}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0/children/0    expected=@{menuLevel42121}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/1    expected=@{menuLevel3133}
    Verify Menu Status from API Storefront Menus    ${Response}    inactive
#   Delete All menu in Menus Level 3
    Click Delete Menu Button    level=3    menu_name=${menuLevel3131NameTh}
    Click Confirm on the Delete Menu Confirmation Dialog
    Menu Panel List Should Contain    3    ${menuLevel3133NameTh}
    Click Delete Menu Button    level=3    menu_name=${menuLevel3133NameTh}
    Click Confirm on the Delete Menu Confirmation Dialog
    Menu Panel List Is Empty    level=3
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=2
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel213}
    Verify Menu Status from API Storefront Menus    ${Response}    inactive
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}

TC_WMALL_00130 Delete level 2 menu
    [Tags]    Regression    cms_storefront    storefront_menu    WLS_High
    Go To Menu Editor Page For Web    ${suite_shop_id}
#   Create Level 1 Menus
    Create Menu            1          @{menuLevel11}
#   Create Level 2 Menus
    Select Menu            level=1    menu_name=${menuLevel11NameTh}
    Create Menu            2          @{menuLevel211}
    Create Menu            2          @{menuLevel212}
    Create Menu            2          @{menuLevel213}
    Menu Panel List Should Contain    2    ${menuLevel211NameTh}    ${menuLevel212NameTh}    ${menuLevel213NameTh}
    #   Create LEvel 3 Menus
    Select Menu            level=1    menu_name=${menuLevel11NameTh}
    Select Menu            level=2    menu_name=${menuLevel211NameTh}
    Create Menu            3          @{menuLevel3131}
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=3
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel211}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0    expected=@{menuLevel3131}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/1    expected=@{menuLevel212}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/2    expected=@{menuLevel213}
    Verify Menu Status from API Storefront Menus    ${Response}    inactive
#   Delete Level 2 Menus
    Click Delete Menu Button    level=2    menu_name=${menuLevel212NameTh}
    Verify Delete Menu Confirmation Dialog Appears    ${menuLevel212NameTh}
    Click Cancel on the Delete Menu Confirmation Dialog
    Menu Panel List Should Contain    2    ${menuLevel211NameTh}    ${menuLevel212NameTh}    ${menuLevel213NameTh}
    Click Delete Menu Button    level=2    menu_name=${menuLevel211NameTh}
    Click Confirm on the Delete Menu Confirmation Dialog
    Menu Panel List Should Contain    2    ${menuLevel212NameTh}    ${menuLevel213NameTh}
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=2
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel212}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/1    expected=@{menuLevel213}
    Verify Menu Status from API Storefront Menus    ${Response}    inactive
#   Delete All menu in Menus Level 2
    Click Delete Menu Button    level=2    menu_name=${menuLevel213NameTh}
    Click Confirm on the Delete Menu Confirmation Dialog
    Menu Panel List Should Contain    2    ${menuLevel212NameTh}
    Click Delete Menu Button    level=2    menu_name=${menuLevel212NameTh}
    Click Confirm on the Delete Menu Confirmation Dialog
    Menu Panel List Is Empty    level=2
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=1
    Verify Menu Status from API Storefront Menus    ${Response}    inactive
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}

TC_WMALL_00131 Delete level 1 menu
    [Tags]    Regression    cms_storefront    storefront_menu    WLS_High
    Go To Menu Editor Page For Web    ${suite_shop_id}
#   Create Level 1 Menus
    Create Menu             1         @{menuLevel11}
    Create Menu             1         @{menuLevel12}
    Create Menu             1         @{menuLevel13}
    Menu Panel List Should Contain    1    ${menuLevel11NameTh}    ${menuLevel12NameTh}    ${menuLevel13NameTh}
#   Create Level 2 Menus
    Select Menu             level=1    menu_name=${menuLevel11NameTh}
    Create Menu             2    @{menuLevel211}
    Create Menu             2    @{menuLevel212}
    Select Menu            level=1    menu_name=${menuLevel12NameTh}
    Create Menu             2         @{menuLevel221}
    Create Menu             2         @{menuLevel222}
#   Create LEvel 3 Menus
    Select Menu            level=1    menu_name=${menuLevel11NameTh}
    Select Menu            level=2    menu_name=${menuLevel212NameTh}
    Create Menu            3          @{menuLevel3131}
    Set Status To Active
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=3
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel211}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/1    expected=@{menuLevel212}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/1/children/0    expected=@{menuLevel3131}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/1    expected=@{menuLevel12}    max_level=2
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/1/children/0    expected=@{menuLevel221}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/1/children/1    expected=@{menuLevel222}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/2    expected=@{menuLevel13}    max_level=1
    Verify Menu Status from API Storefront Menus    ${Response}    active
#   Delete Level 1 Menus
    Click Delete Menu Button    level=1    menu_name=${menuLevel12NameTh}
    Verify Delete Menu Confirmation Dialog Appears    ${menuLevel12NameTh}
    Click Cancel on the Delete Menu Confirmation Dialog
    Click Delete Menu Button    level=1    menu_name=${menuLevel12NameTh}
    Click Confirm on the Delete Menu Confirmation Dialog
    Menu Panel List Should Contain    1    ${menuLevel11NameTh}    ${menuLevel13NameTh}
    Select Menu            level=1    menu_name=${menuLevel11NameTh}
    Menu Panel List Should Contain    2    ${menuLevel211NameTh}    ${menuLevel212NameTh}
    Select Menu            level=1    menu_name=${menuLevel13NameTh}
    Menu Panel List Is Empty    level=2
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=3
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel211}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/1    expected=@{menuLevel212}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/1/children/0    expected=@{menuLevel3131}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/1    expected=@{menuLevel13}    max_level=1
    Verify Menu Status from API Storefront Menus    ${Response}    active
#   Delete All menu in Menus Level 1
    Click Delete Menu Button    level=1    menu_name=${menuLevel11NameTh}
    Click Confirm on the Delete Menu Confirmation Dialog
    Menu Panel List Should Contain    1    ${menuLevel13NameTh}
    Click Delete Menu Button    level=1    menu_name=${menuLevel13NameTh}
    Click Confirm on the Delete Menu Confirmation Dialog
    Menu Panel List Is Empty    level=1
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Menu from API Storefront Menus is Empty    ${Response}
    Verify Menu Status from API Storefront Menus    ${Response}    active
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}

TC_WMALL_01778 Change order of level 4 menu
    [Tags]    Regression    cms_storefront    storefront_menu    WLS_High
    Go To Menu Editor Page For Web    ${suite_shop_id}
#   Create Level 1 Menus
    Create Menu            1          @{menuLevel11}
#   Create Level 2 Menus
    Select Menu            level=1    menu_name=${menuLevel11NameTh}
    Create Menu            2          @{menuLevel213}
#   Create LEvel 3 Menus
    Select Menu            level=1    menu_name=${menuLevel11NameTh}
    Select Menu            level=2    menu_name=${menuLevel213NameTh}
    Create Menu            3          @{menuLevel3131}
    Create Menu            3          @{menuLevel3132}
    Create Menu            3          @{menuLevel3133}
#   Create LEvel 4 Menus
    Select Menu            level=1    menu_name=${menuLevel11NameTh}
    Select Menu            level=2    menu_name=${menuLevel213NameTh}
    Select Menu            level=3    menu_name=${menuLevel3131NameTh}
    Create Menu            4          @{menuLevel42121}
    Create Menu            4          @{menuLevel42123}
    Create Menu            4          @{menuLevel42122}
    Menu Panel List Should Contain    4    ${menuLevel42121NameTh}    ${menuLevel42123NameTh}    ${menuLevel42122NameTh}
    Drag Menu And Drop After Another Menu    4    ${menuLevel42123NameTh}    ${menuLevel42122NameTh}
    Menu Panel List Should Contain    4    ${menuLevel42121NameTh}    ${menuLevel42122NameTh}    ${menuLevel42123NameTh}
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=4
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel213}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0    expected=@{menuLevel3131}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0/children/0    expected=@{menuLevel42121}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0/children/1    expected=@{menuLevel42122}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0/children/2    expected=@{menuLevel42123}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/1    expected=@{menuLevel3132}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/2    expected=@{menuLevel3133}
    Verify Menu Status from API Storefront Menus    ${Response}    inactive
# Drag menu order level 4
    Drag Menu And Drop After Another Menu    4    ${menuLevel42121NameTh}    ${menuLevel42123NameTh}
    Drag Menu And Drop After Another Menu    4    ${menuLevel42122NameTh}    ${menuLevel42123NameTh}
    Menu Panel List Should Contain    4    ${menuLevel42123NameTh}    ${menuLevel42122NameTh}    ${menuLevel42121NameTh}
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=4
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel213}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0    expected=@{menuLevel3131}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0/children/0    expected=@{menuLevel42123}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0/children/1    expected=@{menuLevel42122}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0/children/2    expected=@{menuLevel42121}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/1    expected=@{menuLevel3132}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/2    expected=@{menuLevel3133}
    Verify Menu Status from API Storefront Menus    ${Response}    inactive
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}

TC_WMALL_01779 Change order of level 3 menu
    [Tags]    Regression    cms_storefront    storefront_menu    WLS_High
    Go To Menu Editor Page For Web    ${suite_shop_id}
#   Create Level 1 Menus
    Create Menu            1          @{menuLevel11}
#   Create Level 2 Menus
    Select Menu            level=1    menu_name=${menuLevel11NameTh}
    Create Menu            2          @{menuLevel213}
#   Create LEvel 3 Menus
    Select Menu            level=1    menu_name=${menuLevel11NameTh}
    Select Menu            level=2    menu_name=${menuLevel213NameTh}
    Create Menu            3          @{menuLevel3131}
    Create Menu            3          @{menuLevel3133}
    Create Menu            3          @{menuLevel3132}
#   Create LEvel 4 Menus
    Select Menu            level=1    menu_name=${menuLevel11NameTh}
    Select Menu            level=2    menu_name=${menuLevel213NameTh}
    Select Menu            level=3    menu_name=${menuLevel3131NameTh}
    Create Menu            4          @{menuLevel42121}
    Create Menu            4          @{menuLevel42122}
    Create Menu            4          @{menuLevel42123}

    Select Menu            level=1    menu_name=${menuLevel11NameTh}
    Select Menu            level=2    menu_name=${menuLevel213NameTh}

    Menu Panel List Should Contain            3    ${menuLevel3131NameTh}    ${menuLevel3133NameTh}    ${menuLevel3132NameTh}
    Drag Menu And Drop After Another Menu     3    ${menuLevel3133NameTh}    ${menuLevel3132NameTh}
    Menu Panel List Should Contain            3    ${menuLevel3131NameTh}    ${menuLevel3132NameTh}    ${menuLevel3133NameTh}
    Click Save Button

    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=4
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel213}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0    expected=@{menuLevel3131}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0/children/0    expected=@{menuLevel42121}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0/children/1    expected=@{menuLevel42122}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0/children/2    expected=@{menuLevel42123}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/1    expected=@{menuLevel3132}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/2    expected=@{menuLevel3133}
    Verify Menu Status from API Storefront Menus    ${Response}    inactive

# Drag menu order level 3
    Drag Menu And Drop After Another Menu     3    ${menuLevel3131NameTh}    ${menuLevel3133NameTh}
    Drag Menu And Drop After Another Menu     3    ${menuLevel3132NameTh}    ${menuLevel3131NameTh}
    Menu Panel List Should Contain            3    ${menuLevel3133NameTh}    ${menuLevel3131NameTh}    ${menuLevel3132NameTh}
    Click Save Button

    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=4
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel213}

    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0    expected=@{menuLevel3133}


    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/1    expected=@{menuLevel3131}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/1/children/0    expected=@{menuLevel42121}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/1/children/1    expected=@{menuLevel42122}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/1/children/2    expected=@{menuLevel42123}

    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/2    expected=@{menuLevel3132}
    Verify Menu Status from API Storefront Menus    ${Response}    inactive
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}

TC_WMALL_00132 Change order of level 2 menu
    [Tags]    Regression    cms_storefront    storefront_menu    WLS_High
    Go To Menu Editor Page For Web    ${suite_shop_id}
#   Create Level 1 Menus
    Create Menu            1          @{menuLevel11}
#   Create Level 2 Menus
    Select Menu            level=1    menu_name=${menuLevel11NameTh}
    Create Menu            2          @{menuLevel213}
    Create Menu            2          @{menuLevel212}
    Create Menu            2          @{menuLevel211}
#   Create LEvel 3 Menus
    Select Menu            level=1    menu_name=${menuLevel11NameTh}
    Select Menu            level=2    menu_name=${menuLevel213NameTh}
    Create Menu            3          @{menuLevel3131}
    Create Menu            3          @{menuLevel3132}
    Create Menu            3          @{menuLevel3133}
#   Create LEvel 4 Menus
    Select Menu            level=1    menu_name=${menuLevel11NameTh}
    Select Menu            level=2    menu_name=${menuLevel213NameTh}
    Select Menu            level=3    menu_name=${menuLevel3131NameTh}
    Create Menu            4          @{menuLevel42121}
    Create Menu            4          @{menuLevel42122}
    Create Menu            4          @{menuLevel42123}

    Select Menu            level=1    menu_name=${menuLevel11NameTh}
    Menu Panel List Should Contain    2    ${menuLevel213NameTh}    ${menuLevel212NameTh}    ${menuLevel211NameTh}
    Drag Menu And Drop After Another Menu    2    ${menuLevel213NameTh}    ${menuLevel211NameTh}
    Drag Menu And Drop After Another Menu    2    ${menuLevel212NameTh}    ${menuLevel211NameTh}
    Menu Panel List Should Contain    2    ${menuLevel211NameTh}    ${menuLevel212NameTh}    ${menuLevel213NameTh}
    Click Save Button

    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=4
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel211}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/1    expected=@{menuLevel212}

    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/2    expected=@{menuLevel213}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/2/children/0    expected=@{menuLevel3131}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/2/children/0/children/0    expected=@{menuLevel42121}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/2/children/0/children/1    expected=@{menuLevel42122}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/2/children/0/children/2    expected=@{menuLevel42123}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/2/children/1    expected=@{menuLevel3132}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/2/children/2    expected=@{menuLevel3133}
    Verify Menu Status from API Storefront Menus    ${Response}    inactive

# Drag menu order level 2
    Drag Menu And Drop After Another Menu    2    ${menuLevel211NameTh}    ${menuLevel213NameTh}
    Drag Menu And Drop After Another Menu    2    ${menuLevel212NameTh}    ${menuLevel213NameTh}
    Menu Panel List Should Contain    2    ${menuLevel213NameTh}    ${menuLevel212NameTh}    ${menuLevel211NameTh}
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=4
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel213}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0    expected=@{menuLevel3131}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0/children/0    expected=@{menuLevel42121}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0/children/1    expected=@{menuLevel42122}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0/children/2    expected=@{menuLevel42123}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/1    expected=@{menuLevel3132}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/2    expected=@{menuLevel3133}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/1    expected=@{menuLevel212}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/2    expected=@{menuLevel211}
    Verify Menu Status from API Storefront Menus    ${Response}    inactive

    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}

TC_WMALL_00133 Change order of level 1 menu
    [Tags]    Regression    cms_storefront    storefront_menu    WLS_High
    Go To Menu Editor Page For Web    ${suite_shop_id}
#   Create Level 1 Menus
    Create Menu            1          @{menuLevel13}
    Create Menu            1          @{menuLevel12}
    Create Menu            1          @{menuLevel11}
#   Create Level 2 Menus
    Select Menu            level=1    menu_name=${menuLevel11NameTh}
    Create Menu            2          @{menuLevel211}
    Create Menu            2          @{menuLevel212}
    Create Menu            2          @{menuLevel213}
#   Create LEvel 3 Menus
    Select Menu            level=1    menu_name=${menuLevel11NameTh}
    Select Menu            level=2    menu_name=${menuLevel213NameTh}
    Create Menu            3          @{menuLevel3131}
    Create Menu            3          @{menuLevel3132}
    Create Menu            3          @{menuLevel3133}
#   Create LEvel 4 Menus
    Select Menu            level=1    menu_name=${menuLevel11NameTh}
    Select Menu            level=2    menu_name=${menuLevel213NameTh}
    Select Menu            level=3    menu_name=${menuLevel3131NameTh}
    Create Menu            4          @{menuLevel42121}
    Create Menu            4          @{menuLevel42122}
    Create Menu            4          @{menuLevel42123}

    Menu Panel List Should Contain    1    ${menuLevel13NameTh}    ${menuLevel12NameTh}    ${menuLevel11NameTh}
    Drag Menu And Drop After Another Menu    1    ${menuLevel13NameTh}    ${menuLevel11NameTh}
    Drag Menu And Drop After Another Menu    1    ${menuLevel12NameTh}    ${menuLevel11NameTh}
    Menu Panel List Should Contain    1    ${menuLevel11NameTh}    ${menuLevel12NameTh}    ${menuLevel13NameTh}
    Click Save Button

    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=4
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel211}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/1    expected=@{menuLevel212}

    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/2    expected=@{menuLevel213}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/2/children/0    expected=@{menuLevel3131}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/2/children/0/children/0    expected=@{menuLevel42121}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/2/children/0/children/1    expected=@{menuLevel42122}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/2/children/0/children/2    expected=@{menuLevel42123}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/2/children/1    expected=@{menuLevel3132}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/2/children/2    expected=@{menuLevel3133}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/1    expected=@{menuLevel12}    max_level=1
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/2    expected=@{menuLevel13}    max_level=1
    Verify Menu Status from API Storefront Menus    ${Response}    inactive

# Drag menu order level 1
    Drag Menu And Drop After Another Menu    1    ${menuLevel11NameTh}    ${menuLevel13NameTh}
    Drag Menu And Drop After Another Menu    1    ${menuLevel12NameTh}    ${menuLevel13NameTh}
    Menu Panel List Should Contain    1    ${menuLevel13NameTh}    ${menuLevel12NameTh}    ${menuLevel11NameTh}
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel13}    max_level=1
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/1    expected=@{menuLevel12}    max_level=1
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/2    expected=@{menuLevel11}    max_level=4
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/2/children/0    expected=@{menuLevel211}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/2/children/1    expected=@{menuLevel212}

    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/2/children/2    expected=@{menuLevel213}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/2/children/2/children/0    expected=@{menuLevel3131}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/2/children/2/children/0/children/0    expected=@{menuLevel42121}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/2/children/2/children/0/children/1    expected=@{menuLevel42122}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/2/children/2/children/0/children/2    expected=@{menuLevel42123}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/2/children/2/children/1    expected=@{menuLevel3132}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/2/children/2/children/2    expected=@{menuLevel3133}
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}

TC_WMALL_00134 Edit logo
    [Tags]    Regression    cms_storefront    storefront_menu    WLS_High
    Go To Menu Editor Page For Web    ${suite_shop_id}
    Click Edit Logo
    Verify Edit Logo Popup Appears
    Set Logo Image Th    ${menuLogoImgThPath}
    Click Ok Button on Modal Dialog
    Verify Modal Dialog Alert Appears    ${PLEASE_ENTER_ALL_FIELDS_MSG}
    Set Logo Image En    ${menuLogoImgEnPath}
    Set Logo Link Th    ${menuLogoLinkTh}
    Set Logo Link En    ${menuLogoLinkEn}
    Click Cancel Button on Modal Dialog
    Logo Image Should Not Appear
    Click Edit Logo
    Set Logo Image Th    ${menuLogoImgThPath}
    Set Logo Image En    ${menuLogoImgEnPath}
    Set Logo Link Th    ${menuLogoLinkTh}
    Set Logo Link En    ${menuLogoLinkEn}
    Click Ok Button on Modal Dialog
    Logo Image Should Appear    ${menuLogoImgThFileName}
    Click Save Button
    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Menu Logo from API Storefront Menus    ${Response}    @{menuLogoShopSony}
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}

TC_WMALL_00135 Delete logo
    [Tags]    Regression    cms_storefront    storefront_menu    WLS_High
    Go To Menu Editor Page For Web    ${suite_shop_id}
#   Create Level 1 Menus
    Create Menu            1          @{menuLevel11}
#   Create Level 2 Menus
    Select Menu            level=1    menu_name=${menuLevel11NameTh}
    Create Menu            2          @{menuLevel213}
#   Create LEvel 3 Menus
    Select Menu            level=1    menu_name=${menuLevel11NameTh}
    Select Menu            level=2    menu_name=${menuLevel213NameTh}
    Create Menu            3          @{menuLevel3131}
    Create Menu            3          @{menuLevel3132}
    Create Menu            3          @{menuLevel3133}
#   Create LEvel 4 Menus
    Select Menu            level=1    menu_name=${menuLevel11NameTh}
    Select Menu            level=2    menu_name=${menuLevel213NameTh}
    Select Menu            level=3    menu_name=${menuLevel3131NameTh}
    Create Menu            4          @{menuLevel42121}
    Create Menu            4          @{menuLevel42122}
    Create Menu            4          @{menuLevel42123}

    Click Edit Logo
    Set Logo Image Th    ${menuLogoImgThPath}
    Set Logo Image En    ${menuLogoImgEnPath}
    Set Logo Link Th    ${menuLogoLinkTh}
    Set Logo Link En    ${menuLogoLinkEn}
    Click Ok Button on Modal Dialog
    Logo Image Should Appear    ${menuLogoImgThFileName}
    Click Save Button

    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Menu Logo from API Storefront Menus    ${Response}    @{menuLogoShopSony}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=4
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel213}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0    expected=@{menuLevel3131}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0/children/0    expected=@{menuLevel42121}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0/children/1    expected=@{menuLevel42122}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0/children/2    expected=@{menuLevel42123}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/1    expected=@{menuLevel3132}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/2    expected=@{menuLevel3133}
    Verify Menu Status from API Storefront Menus    ${Response}    inactive

#   Delete logo image data
    Click Delete Logo
    Verify Delete Logo Confirmation Dialog Appears
    Click Cancel on the Delete Logo Confirmation Dialog
    Logo Image Should Appear    ${menuLogoImgThFileName}
    Click Delete Logo
    Click Confirm on the Delete Logo Confirmation Dialog
    Logo Image Should Not Appear
    Set Status To Active
    Click Save Button

    ${Response}=    Get Storefront Menu    ${STOREFRONT-API}    ${suite_shop_id}    web    mode=raw    version=draft
    Verify Menu Logo from API Storefront Menus is Null    ${Response}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0    expected=@{menuLevel11}    max_level=4
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0    expected=@{menuLevel213}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0    expected=@{menuLevel3131}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0/children/0    expected=@{menuLevel42121}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0/children/1    expected=@{menuLevel42122}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/0/children/2    expected=@{menuLevel42123}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/1    expected=@{menuLevel3132}
    Verify Storefront Menu from API Response with Expected Data    ${Response}    data/menu/data/menus/0/children/0/children/2    expected=@{menuLevel3133}
    Verify Menu Status from API Storefront Menus    ${Response}    active
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}

TC_WMALL_00136 Preview and Publish
    [Tags]    Regression    cms_storefront    storefront_menu    WLS_High
    Go To Menu Editor Page For Web    ${suite_shop_id}
    ${allMenuData}    ${logo}=    Add Default Menu Data
#   Save Draft
    Set Status To Active
    Click Save Button
    Verify Status Message Appears    ${SAVE_DRAFT_SUCCESS_MSG}
    Click Preview Button
    Verify Preview Storefront with Storefront Menu from Response    ${shop_slug}    ${suite_shop_id}
    Close Preview Storefront Window    ${shop_slug}
    Click Publish Button
    Verify Published Storefront with Storefront Menu from Response    ${shop_slug}    ${suite_shop_id}
    Close Storefront Window    ${shop_slug}
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}

TC_WMALL_00137 Save draft should not affect published data
    [Tags]    Regression    cms_storefront    storefront_menu    WLS_High
    Go To Menu Editor Page For Web    ${suite_shop_id}
    ${allMenuData}    ${logo}=    Add Default Menu Data
#   Save Draft
    Set Status To Active
    Click Save Button
    Verify Status Message Appears    ${SAVE_DRAFT_SUCCESS_MSG}
    Click Preview Button
#   Verify Preview and Publish
    Verify Preview Storefront with Storefront Menu from Response    ${shop_slug}    ${suite_shop_id}
    Close Preview Storefront Window    ${shop_slug}
    Click Publish Button
    Verify Published Storefront with Storefront Menu from Response    ${shop_slug}    ${suite_shop_id}
    Close Storefront Window    ${shop_slug}
#   Add new menu
    Select Menu            level=1    menu_name=${menuLevel13NameTh}
    Create Menu            2          @{menuLevel231}
#   Edit old menu
    Select Menu            level=1    menu_name=${menuLevel12NameTh}
    Click Edit Menu Button    level=2    menu_name=${menuLevel222NameTh}
    Fill In Menu Data    @{newMenuLevel222}
    Click Ok Button on Modal Dialog
#   Delete old menu
    Select Menu            level=1    menu_name=${menuLevel11NameTh}
    Click Delete Menu Button    level=2    menu_name=${menuLevel212NameTh}
    Click Confirm on the Delete Menu Confirmation Dialog
#   Delete logo
    Click Delete Logo
    Click Confirm on the Delete Logo Confirmation Dialog
    Logo Image Should Not Appear
#   Save Draft and Verify that published data should not be changed
    Click Save Button
    Verify Status Message Appears    ${SAVE_DRAFT_SUCCESS_MSG}
    Verify Published Storefront with Storefront Menu from Response    ${shop_slug}    ${suite_shop_id}
    Close Storefront Window    ${shop_slug}
#   Create tree menu structure
    &{menu211}=    Create Dictionary    nameTh=@{menuLevel211}[0]    nameEn=@{menuLevel211}[1]    linkTh=@{menuLevel211}[2]    linkEn=@{menuLevel211}[3]    newTab=@{menuLevel211}[4]    children=${None}
    &{menu213}=    Create Dictionary    nameTh=@{menuLevel213}[0]    nameEn=@{menuLevel213}[1]    linkTh=@{menuLevel213}[2]    linkEn=@{menuLevel213}[3]    newTab=@{menuLevel213}[4]    children=${None}
    @{menu21}=     Create List          ${menu211}                   ${menu213}
    &{menu221}=    Create Dictionary    nameTh=@{menuLevel221}[0]    nameEn=@{menuLevel221}[1]    linkTh=@{menuLevel221}[2]    linkEn=@{menuLevel221}[3]    newTab=@{menuLevel221}[4]    children=${None}
    &{menu222}=    Create Dictionary    nameTh=@{newMenuLevel222}[0]    nameEn=@{newMenuLevel222}[1]    linkTh=@{newMenuLevel222}[2]    linkEn=@{newMenuLevel222}[3]    newTab=@{newMenuLevel222}[4]    children=${None}
    @{menu22}=     Create List          ${menu221}                   ${menu222}
    &{menu231}=    Create Dictionary    nameTh=@{menuLevel231}[0]    nameEn=@{menuLevel231}[1]    linkTh=@{menuLevel231}[2]    linkEn=@{menuLevel231}[3]    newTab=@{menuLevel231}[4]    children=${None}
    @{menu23}=     Create List    ${menu231}
    &{menu11}=     Create Dictionary    nameTh=@{menuLevel11}[0]     nameEn=@{menuLevel11}[1]    linkTh=@{menuLevel11}[2]    linkEn=@{menuLevel11}[3]    newTab=@{menuLevel11}[4]    children=${menu21}
    &{menu12}=     Create Dictionary    nameTh=@{menuLevel12}[0]     nameEn=@{menuLevel12}[1]    linkTh=@{menuLevel12}[2]    linkEn=@{menuLevel12}[3]    newTab=@{menuLevel12}[4]    children=${menu22}
    &{menu13}=     Create Dictionary    nameTh=@{menuLevel13}[0]     nameEn=@{menuLevel13}[1]    linkTh=@{menuLevel13}[2]    linkEn=@{menuLevel13}[3]    newTab=@{menuLevel13}[4]    children=${menu23}
    @{allMenuData}=    Create List    ${menu11}    ${menu12}    ${menu13}
    &{logo}=       Create Dictionary    fileNameTh=${menuLogoImgThFileName}    fileNameEn=${menuLogoImgEnFileName}    linkTh=${menuLogoLinkTh}    linkEn=${menuLogoLinkEn}
#   Verify that the draft version has changed
    Click Preview Button
    Verify Preview Storefront with Storefront Menu from Response    ${shop_slug}    ${suite_shop_id}
    Close Preview Storefront Window    ${shop_slug}
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}

TC_WMALL_00140 Preview and Publish Mobile
    [Tags]    Regression    cms_storefront    storefront_menu    WLS_High
    Go To Menu Editor Page For Mobile    ${suite_shop_id}
    #   Create Level 1 Menus
    Create Menu            1    @{menuLevel11}
    Create Menu            1    @{menuLevel12}
    Create Menu            1    @{menuLevel13}
#   Create Level 2 Menus
    Select Menu            1    ${menuLevel11NameTh}
    Create Menu            2    @{menuLevel213}
    Select Menu            1    ${menuLevel12NameTh}
    Create Menu            2    @{menuLevel222}
#   Create Level 3 Menus
    Select Menu            1    ${menuLevel11NameTh}
    Select Menu            2    ${menuLevel213NameTh}
    Create Menu            3    @{menuLevel3121}
    Create Menu            3    @{menuLevel3131}
    Create Menu            3    @{menuLevel3132}
    Create Menu            3    @{menuLevel3133}
    Select Menu            1    ${menuLevel12NameTh}
    Select Menu            2    ${menuLevel222NameTh}
    Create Menu            3    @{menuLevel3211}
    Create Menu            3    @{menuLevel3212}
#   Create Level 4 Menus
    Select Menu            1    ${menuLevel11NameTh}
    Select Menu            2    ${menuLevel213NameTh}
    Select Menu            3    ${menuLevel3121NameTh}
    Create Menu            4    @{menuLevel41211}
    Select Menu            1    ${menuLevel12NameTh}
    Select Menu            2    ${menuLevel222NameTh}
    Select Menu            3    ${menuLevel3212NameTh}
    Create Menu            4    @{menuLevel42121}
    Create Menu            4    @{menuLevel42122}
#   Save Draft
    Set Status To Active
    Click Save Button
    Verify Status Message Appears    ${SAVE_DRAFT_SUCCESS_MSG}
    Click Preview Button
    Verify Preview Storefront Mobile with Storefront Menu from Response    ${shop_slug}    ${suite_shop_id}
    Close Window
    Go To CMS Storefront
    Click Publish Button
    Verify Published Storefront Mobile with Storefront Menu from Response    ${shop_slug}    ${suite_shop_id}
    Go To Menu Editor Page For Mobile    ${suite_shop_id}
    [Teardown]    Delete Storefront Draft and Published Success Specific type    ${suite_shop_id}    web    ${module.lower()}

*** Keywords ***
Add Default Menu Data
#   Create Level 1 Menus
    Create Menu            1    @{menuLevel11}
    Create Menu            1    @{menuLevel12}
    Create Menu            1    @{menuLevel13}
#   Create Level 2 Menus
    Select Menu            1    ${menuLevel11NameTh}
    Create Menu            2    @{menuLevel211}
    Create Menu            2    @{menuLevel212}
    Create Menu            2    @{menuLevel213}
    Select Menu            1    ${menuLevel12NameTh}
    Create Menu            2    @{menuLevel221}
    Create Menu            2    @{menuLevel222}
#   Create Level 3 Menus
    Select Menu            1    ${menuLevel11NameTh}
    Select Menu            2    ${menuLevel212NameTh}
    Create Menu            3    @{menuLevel3121}
    Select Menu            1    ${menuLevel11NameTh}
    Select Menu            2    ${menuLevel213NameTh}
    Create Menu            3    @{menuLevel3131}
    Create Menu            3    @{menuLevel3132}
    Create Menu            3    @{menuLevel3133}
    Select Menu            1    ${menuLevel12NameTh}
    Select Menu            2    ${menuLevel221NameTh}
    Create Menu            3    @{menuLevel3211}
    Create Menu            3    @{menuLevel3212}
#   Create Level 4 Menus
    Select Menu            1    ${menuLevel11NameTh}
    Select Menu            2    ${menuLevel212NameTh}
    Select Menu            3    ${menuLevel3121NameTh}
    Create Menu            4    @{menuLevel41211}
    Select Menu            1    ${menuLevel12NameTh}
    Select Menu            2    ${menuLevel221NameTh}
    Select Menu            3    ${menuLevel3212NameTh}
    Create Menu            4    @{menuLevel42121}
    Create Menu            4    @{menuLevel42122}
#   Add Logo
    Click Edit Logo
    Set Logo Image Th     ${menuLogoImgThPath}
    Set Logo Image En     ${menuLogoImgEnPath}
    Set Logo Link Th      ${menuLogoLinkTh}
    Set Logo Link En      ${menuLogoLinkEn}
    Click Ok Button on Modal Dialog
#   Create the menu tree structure
    &{menu41211}=    Create Dictionary    nameTh=@{menuLevel41211}[0]    nameEn=@{menuLevel41211}[1]
    ...                                   linkTh=@{menuLevel41211}[2]    linkEn=@{menuLevel41211}[3]
    ...                                   newTab=@{menuLevel41211}[4]    children=${None}
    @{menu4121}=     Create List          ${menu41211}
    &{menu42121}=    Create Dictionary    nameTh=@{menuLevel42121}[0]    nameEn=@{menuLevel42121}[1]
    ...                                   linkTh=@{menuLevel42121}[2]    linkEn=@{menuLevel42121}[3]
    ...                                   newTab=@{menuLevel42121}[4]    children=${None}
    &{menu42122}=    Create Dictionary    nameTh=@{menuLevel42122}[0]    nameEn=@{menuLevel42122}[1]
    ...                                   linkTh=@{menuLevel42122}[2]    linkEn=@{menuLevel42122}[3]
    ...                                   newTab=@{menuLevel42122}[4]    children=${None}
    @{menu4212}=     Create List          ${menu42121}                   ${menu42122}
    &{menu3121}=     Create Dictionary    nameTh=@{menuLevel3121}[0]     nameEn=@{menuLevel3121}[1]
    ...                                   linkTh=@{menuLevel3121}[2]     linkEn=@{menuLevel3121}[3]
    ...                                   newTab=@{menuLevel3121}[4]     children=${menu4121}
    @{menu312}=      Create List          ${menu3121}
    &{menu3131}=     Create Dictionary    nameTh=@{menuLevel3131}[0]     nameEn=@{menuLevel3131}[1]
    ...                                   linkTh=@{menuLevel3131}[2]     linkEn=@{menuLevel3131}[3]
    ...                                   newTab=@{menuLevel3131}[4]     children=${None}
    &{menu3132}=     Create Dictionary    nameTh=@{menuLevel3132}[0]     nameEn=@{menuLevel3132}[1]
    ...                                   linkTh=@{menuLevel3132}[2]     linkEn=@{menuLevel3132}[3]
    ...                                   newTab=@{menuLevel3132}[4]     children=${None}
    &{menu3133}=     Create Dictionary    nameTh=@{menuLevel3133}[0]     nameEn=@{menuLevel3133}[1]
    ...                                   linkTh=@{menuLevel3133}[2]     linkEn=@{menuLevel3133}[3]
    ...                                   newTab=@{menuLevel3133}[4]     children=${None}
    @{menu313}=      Create List          ${menu3131}                    ${menu3132}                     ${menu3133}
    &{menu3211}=     Create Dictionary    nameTh=@{menuLevel3211}[0]     nameEn=@{menuLevel3211}[1]
    ...                                   linkTh=@{menuLevel3211}[2]     linkEn=@{menuLevel3211}[3]
    ...                                   newTab=@{menuLevel3211}[4]     children=${None}
    &{menu3212}=     Create Dictionary    nameTh=@{menuLevel3212}[0]     nameEn=@{menuLevel3212}[1]
    ...                                   linkTh=@{menuLevel3212}[2]     linkEn=@{menuLevel3212}[3]
    ...                                   newTab=@{menuLevel3212}[4]     children=${menu4212}
    @{menu321}=      Create List          ${menu3211}                    ${menu3212}
    &{menu211}=      Create Dictionary    nameTh=@{menuLevel211}[0]      nameEn=@{menuLevel211}[1]
    ...                                   linkTh=@{menuLevel211}[2]      linkEn=@{menuLevel211}[3]
    ...                                   newTab=@{menuLevel211}[4]      children=${None}
    &{menu212}=      Create Dictionary    nameTh=@{menuLevel212}[0]      nameEn=@{menuLevel212}[1]
    ...                                   linkTh=@{menuLevel212}[2]      linkEn=@{menuLevel212}[3]
    ...                                   newTab=@{menuLevel212}[4]      children=${menu312}
    &{menu213}=      Create Dictionary    nameTh=@{menuLevel213}[0]      nameEn=@{menuLevel213}[1]
    ...                                   linkTh=@{menuLevel213}[2]      linkEn=@{menuLevel213}[3]
    ...                                   newTab=@{menuLevel213}[4]      children=${menu313}
    @{menu21}=       Create List          ${menu211}                     ${menu212}                     ${menu213}
    &{menu221}=      Create Dictionary    nameTh=@{menuLevel221}[0]      nameEn=@{menuLevel221}[1]
    ...                                   linkTh=@{menuLevel221}[2]      linkEn=@{menuLevel221}[3]
    ...                                   newTab=@{menuLevel221}[4]      children=${menu321}
    &{menu222}=      Create Dictionary    nameTh=@{menuLevel222}[0]      nameEn=@{menuLevel222}[1]
    ...                                   linkTh=@{menuLevel222}[2]      linkEn=@{menuLevel222}[3]
    ...                                   newTab=@{menuLevel222}[4]      children=${None}
    @{menu22}=       Create List          ${menu221}                     ${menu222}
    &{menu11}=       Create Dictionary    nameTh=@{menuLevel11}[0]       nameEn=@{menuLevel11}[1]
    ...                                   linkTh=@{menuLevel11}[2]       linkEn=@{menuLevel11}[3]
    ...                                   newTab=@{menuLevel11}[4]       children=${menu21}
    &{menu12}=       Create Dictionary    nameTh=@{menuLevel12}[0]       nameEn=@{menuLevel12}[1]
    ...                                   linkTh=@{menuLevel12}[2]       linkEn=@{menuLevel12}[3]
    ...                                   newTab=@{menuLevel12}[4]       children=${menu22}
    &{menu13}=       Create Dictionary    nameTh=@{menuLevel13}[0]       nameEn=@{menuLevel13}[1]
    ...                                   linkTh=@{menuLevel13}[2]       linkEn=@{menuLevel13}[3]
    ...                                   newTab=@{menuLevel13}[4]       children=${None}
    @{allMenuData}=    Create List    ${menu11}    ${menu12}    ${menu13}
    &{logo}=           Create Dictionary    fileNameTh=${menuLogoImgThFileName}    fileNameEn=${menuLogoImgEnFileName}
    ...                                     linkTh=${menuLogoLinkTh}               linkEn=${menuLogoLinkEn}
    [Return]    ${allMenuData}    ${logo}

