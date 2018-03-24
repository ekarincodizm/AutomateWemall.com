*** Settings ***
Force Tags    WLS_Content_Wemall    wemall_header
Test Setup         Open Browser and Go to Specific URL    ${WEMALL_WEB}
Suite Teardown      Run Keywords    Close All Browsers
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/wemall_portal/portal_page_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/header/keywords_wemall_header.robot
# Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/Cart Light Box/Keywords_CartLightBox.robot
Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/Full_cart/keywords_full_cart.robot
# Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_d_page/WebElement_LevelD.robot
Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/Cart_light_box/WebElement_CartLightBox.robot
Library             ${CURDIR}/../../../Python_Library/common/web_element_library.py
Test Template       Cart Badge Icon

*** Variables ***
${username}             robot10@mail.com
${user_display_name}    Robot10@mail.com
${password}             123456

*** Test Cases ***
TC_WMALL_01429 Level C brand page header - Cart Badge Icon (WeMall_version)    ${WEMALL_WEB}/brand/samsung-6931849325692.html    yes
    [tags]    regression    TC_WMALL_01429    WLS_Medium

TC_WMALL_01439 Level C category page header - Cart Badge Icon (WeMall_version)    ${WEMALL_WEB}/category/hulk-3302288514534.html    yes
    [tags]    regression    TC_WMALL_01439    WLS_Medium

TC_ITMWM_03996 Header on Lv.C for Merchant page - Cart Badge Icon (WeMall_version)    ${WEMALL_WEB}/m-${SHOP_LYRA_ROBOT}-category-${CAT_SLUG_PKEY}.html    yes
    [tags]    lyra

TC_WMALL_01449 Search page header - Cart Badge Icon (WeMall_version)    ${WEMALL_WEB}/search2?q=Apple    yes
    [tags]    regression    TC_WMALL_01449    WLS_Medium

TC_WMALL_01459 Everyday Wow page header - Cart Badge Icon (WeMall_version)    ${WEMALL_WEB}/everyday-wow    yes
    [tags]    regression    TC_WMALL_01459    WLS_Medium

TC_WMALL_01506 Login header - Cart Badge Icon (WeMall_version)   ${WEMALL_WEB}/auth/login    yes    https
   [tags]    regression    TC_WMALL_01506    WLS_Medium

TC_WMALL_01507 Register header - Cart Badge Icon (WeMall_version)   ${WEMALL_WEB}/users/register    yes    https
   [tags]    regression    TC_WMALL_01507    WLS_Medium

TC_WMALL_01508 Level D header - Cart Badge Icon (WeMall_version)   ${WEMALL_WEB}/products/casio-enticer-mtd-1066b-1a2vdf-2155655390889.html    yes
   [tags]    regression    TC_WMALL_01508    WLS_Medium

TC_WMALL_01650 Wemall Portal page header - Cart Badge Icon (WeMall_version)    ${WEMALL_WEB}    yes
    [tags]    regression    TC_WMALL_01650    WLS_Medium

TC_WMALL_01651 Wemall Stronfront page header - Cart Badge Icon (WeMall_version)    ${WEMALL_WEB}/shop/canon    yes
    [tags]    regression    TC_WMALL_01651    WLS_Medium

TC_WMALL_01670 Forgot Password page header - Cart Badge Icon (WeMall_version)     ${WEMALL_WEB}/forgot_password    yes    https
    [tags]    regression    TC_WMALL_01670    WLS_Medium

*** Keywords ***
Cart Badge Icon
    [Arguments]    ${full_url}    ${mode}    ${protocol}=http
    Run Keyword If     '${mode}' == 'yes'    Have Cart Light Box    ${full_url}    ${protocol}
    Run Keyword If     '${mode}' == 'no'    Do Not Have Cart Light Box    ${full_url}    ${protocol}

Have Cart Light Box
    [Arguments]    ${full_url}    ${protocol}=http
    keywords_wemall_header.Go to Specific URL    ${full_url}
    Check Location Contain    ${full_url}    ${protocol}
    Check Cart Badge Quantity    0
    Click Cart Box Button
    Sleep    3s
    Check Location Contain    ${WEMALL_WEB}/cart    http
    Verify Cart Light Box is Empty
    Add Product to Cart    2143121994478
    keywords_wemall_header.Go to Specific URL    ${full_url}
    Sleep    5s
    Check Cart Badge Quantity    1
    # Login User to iTrueMart    ${username}    ${password}
    Add Product to Cart    2895992581809
    keywords_wemall_header.Go to Specific URL    ${full_url}
    Sleep    5s
    Check Cart Badge Quantity    2
    Click Cart Box Button
    Sleep    3s
    Check Location Contain    ${WEMALL_WEB}/cart    http
    Verify Cart Light Box is Not Empty

Do Not Have Cart Light Box
    [Arguments]    ${full_url}    ${protocol}=http
    keywords_wemall_header.Go to Specific URL    ${full_url}
    Sleep    5s
    Check Location Contain    ${full_url}    ${protocol}
    Verify Cart icon Do Not Show

Add Product to Cart
    [Arguments]    ${product_pkey}
    Go to Level D by Pkey    ${product_pkey}
    Wait Until Element is Visible    ${LvD_Add_to_Cart}    30s
    Click Add to Cart
    # Verify Cart Light Box is Not Empty

Go to Level D by Pkey
    [Arguments]    ${product_pkey}
    Go to    ${WEMALL_WEB}/products/${product_pkey}.html

Click Add to Cart
    Wait Until Element is Visible    jquery=.box_status.active.box-status-has-stock    30s
    Scroll Page To Element    itm    jquery=.breadcrumb__inner_wrapper
    Wait Until Page Does Not Contain Element    ${LvD_Add_to_Cart}.disabled    20s
    Sleep    5s
    Wait Until Element is Visible    ${LvD_Add_to_Cart}    30s
    Click Element and Wait Angular Ready    ${LvD_Add_to_Cart}

Verify Cart Light Box is Not Empty
    Wait Until Element Is Visible    ${cart_light_box_popup}    15s
    Wait Until Page Does Not Contain Element    ${cart_light_box_popup}:contains("กำลังโหลดรายการ...")    30s
    Wait Until Element Is Visible    ${product_in_cart_list}    15s

Scroll Page To Element
    [Arguments]    ${server}    ${element}
    Run Keyword If    '${server}' == 'wm'    Scroll Page To Element For WeMall    ${element}
    Run Keyword If    '${server}' == 'itm'    Scroll Page To Element For iTM    ${element}

Scroll Page To Element For iTM
    [Arguments]    ${point_element}
    ${element}=    Get Webelement    ${point_element}
    Scroll To Element    ${element}    0    0

