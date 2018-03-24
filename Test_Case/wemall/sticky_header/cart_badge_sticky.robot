*** Settings ***
Test Setup         Open Browser and Go to Specific URL    ${WEMALL_WEB}
Test Teardown      Run Keywords    Close All Browsers
Suite Teardown      Run Keywords    Close All Browsers
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/header/keywords_wemall_header.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/sticky_header/keywords_sticky_header.robot
Library             ${CURDIR}/../../../Python_Library/common/web_element_library.py
Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/Full_cart/keywords_full_cart.robot
# Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_d_page/WebElement_LevelD.robot
Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/Cart_light_box/WebElement_CartLightBox.robot
Test Template       Sticky Cart Badge Icon
Force Tags          WLS_Wemall_Stick_Header

*** Variables ***
${username}             robot01@mail.com
${user_display_name}    Robot01@mail.com
${password}             123456

*** Test Cases ***
TC_WMALL_01679 WeMall prtal page sticky header - Cart Badge Logo    ${WEMALL_WEB}    yes   .content-portal    wm
    [tags]    regression    wemall_header

TC_WMALL_01680 Level C category page sticky header - Cart Badge Logo    ${WEMALL_WEB}/category/hulk-3302288514534.html    yes   jquery=#menu-category    itm
    [tags]    regression    wemall_header

TC_WMALL_01681 Level C brand page sticky header - Cart Badge Logo    ${WEMALL_WEB}/brand/samsung-6931849325692.html    yes   jquery=.left_menu_lvb .box-list:eq(0)    itm
    [tags]    regression    wemall_header

TC_WMALL_01682 Search page sticky header - Cart Badge Logo    ${WEMALL_WEB}/search2?q=Apple    yes    jquery=#mi-productList .mi-product-card.col-xs-5.ng-scope:eq(0)    itm
    [tags]    regression    wemall_header

TC_WMALL_01683 Everyday Wow page sticky header - Cart Badge Logo    ${WEMALL_WEB}/everyday-wow    yes    jquery=#superdeal #everydaywow-product-list    itm
    [tags]    regression    wemall_header

TC_WMALL_01684 Level D page sticky header - Cart Badge Logo    ${WEMALL_WEB}/products/casio-enticer-mtd-1066b-1a2vdf-2155655390889.html   yes    jquery=.breadcrumb__inner_wrapper    itm
    [tags]    regression    wemall_header

TC_ITMWM_04002 Verify Sticky Header on Lv.C for Merchant - Cart Badge Logo         ${WEMALL_WEB}/m-${merchant_slug}-category-${CAT_SLUG_PKEY}.html    yes   jquery=#menu-category    itm
    [Tags]    TC_ITMWM_04002    regression    wemall_header    lyra

*** Keywords ***
Sticky Cart Badge Icon
    [Arguments]    ${full_url}    ${mode}    ${point_element}    ${server}    ${protocol}=http
    Run Keyword If     '${mode}' == 'yes'    Have Cart Light Box    ${full_url}    ${point_element}    ${server}    ${protocol}
    Run Keyword If     '${mode}' == 'no'    Do Not Have Cart Light Box    ${full_url}    ${protocol}

Have Cart Light Box
    [Arguments]    ${full_url}    ${point_element}    ${server}    ${protocol}=http
    keywords_wemall_header.Go to Specific URL    ${full_url}
    keywords_wemall_header.Check Location Contain    ${full_url}    ${protocol}
    Sticky Header Should Not Show
    Scroll Page To Element    ${server}    ${point_element}
    Sticky Header Should Show
    Check Sticky Cart Badge Quantity    0
    Click Sticky Cart Box Button
    keywords_wemall_header.Check Location Contain    ${WEMALL_WEB}/cart    ${protocol}
    Verify Cart Light Box is Empty
    Add Product to Cart    2143121994478
    keywords_wemall_header.Go to Specific URL    ${full_url}
    Sleep    5s
    Sticky Header Should Not Show
    Scroll Page To Element    ${server}    ${point_element}
    Sticky Header Should Show
    Check Sticky Cart Badge Quantity    1
    Add Product to Cart    2895992581809
    keywords_wemall_header.Go to Specific URL    ${full_url}
    Sleep    5s
    Sticky Header Should Not Show
    Scroll Page To Element    ${server}    ${point_element}
    Sticky Header Should Show
    Check Sticky Cart Badge Quantity    2
    Click Sticky Cart Box Button
    keywords_wemall_header.Check Location Contain    ${WEMALL_WEB}/cart    ${protocol}
    Verify Cart Light Box is Not Empty

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