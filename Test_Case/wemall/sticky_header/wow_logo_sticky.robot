*** Settings ***
Suite Setup         Open Browser and Go to Specific URL    ${WEMALL_WEB}
Suite Teardown      Run Keywords    Close All Browsers
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/header/keywords_wemall_header.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/sticky_header/keywords_sticky_header.robot
Library             ${CURDIR}/../../../Python_Library/common/web_element_library.py
Test Template       Sticky Header WoW Logo
Force Tags          WLS_Wemall_Stick_Header

*** Variables ***
${username}             robot01@mail.com
${user_display_name}    Robot01@mail.com
${password}             123456

*** Test Cases ***
TC_WMALL_01697 WeMall prtal page sticky header - Everday Wow Logo    ${WEMALL_WEB}   .content-portal    wm
    [tags]    regression    wemall_header

TC_WMALL_01698 Level C category page sticky header - Everday Wow Logo    ${WEMALL_WEB}/category/hulk-3302288514534.html   jquery=#menu-category    itm
    [tags]    regression    wemall_header

TC_WMALL_01699 Level C brand page sticky header - Everday Wow Logo    ${WEMALL_WEB}/brand/samsung-6931849325692.html   jquery=.left_menu_lvb .box-list:eq(0)    itm
    [tags]    regression    wemall_header

TC_WMALL_01700 Search page sticky header - Everday Wow Logo    ${WEMALL_WEB}/search2?q=Apple   jquery=#mi-productList .mi-product-card.col-xs-5.ng-scope:eq(0)    itm
    [tags]    regression    wemall_header

TC_WMALL_01701 Everyday Wow page sticky header - Everday Wow Logo    ${WEMALL_WEB}/everyday-wow   jquery=#superdeal #everydaywow-product-list    itm
    [tags]    regression    wemall_header    TC_WMALL_01701

TC_WMALL_01702 Level D page sticky header - Everday Wow Logo    ${WEMALL_WEB}/products/casio-enticer-mtd-1066b-1a2vdf-2155655390889.html   jquery=.breadcrumb__inner_wrapper    itm
    [tags]    regression    wemall_header    TC_WMALL_01702

TC_ITMWM_04002 Verify Sticky Header on Lv.C for Merchant - Everday Wow Logo        ${WEMALL_WEB}/m-${merchant_slug}-category-${CAT_SLUG_PKEY}.html    jquery=#menu-category    itm
    [Tags]    TC_ITMWM_04002    regression    wemall_header    lyra

*** Keywords ***
Sticky Header WoW Logo
    [Arguments]    ${full_url}    ${point_element}    ${server}    ${protocol}=http
    Go to Specific URL    ${full_url}
    Check Location Contain    ${full_url}    ${protocol}
    Sticky Header Should Not Show
    Scroll Page To Element    ${server}    ${point_element}
    Sticky Header Should Show
    Verify Sticky WoW Logo    ${protocol}
    ${result}    Run Keyword And Return Status    Click Sticky WoW Logo
    Run Keyword If    '${result}' == 'False'    Execute Javascript    $('#portal-sticky-header .go-to-everyday-wow')[0].click()
    Location Should Be    ${WEMALL_WEB}/everyday-wow