*** Settings ***
Suite Setup         Open Browser and Go to Specific URL    ${WEMALL_WEB}
Suite Teardown      Run Keywords    Close All Browsers
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/header/keywords_wemall_header.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/sticky_header/keywords_sticky_header.robot
Test Template       Show and Hide Sticky and Back to Top
Force Tags          WLS_Wemall_Stick_Header

*** Variables ***
${username}             robot01@mail.com
${user_display_name}    Robot01@mail.com
${password}             123456

*** Test Cases ***
TC_WMALL_01703 WeMall prtal page sticky header - Show/hide sticky and back to top    ${WEMALL_WEB}   .page-portal    .wm-floor-box .wm-title-floor-box    wm
    [tags]    regression    wemall_header

# TC_WMALL_01704 Level C category page sticky header - Show/hide sticky and back to top    ${WEMALL_WEB}/category/hulk-3302288514534.html    jquery=.iwm-header-portal    jquery=#menu-category    itm
TC_WMALL_01704 Level C category page sticky header - Show/hide sticky and back to top    ${WEMALL_WEB}/category/hulk-3302288514534.html    jquery=.iwm-header-portal    jquery=#menu-category    itm
    [tags]    regression    wemall_header

TC_WMALL_01705 Level C brand page sticky header - Show/hide sticky and back to top    ${WEMALL_WEB}/brand/samsung-6931849325692.html    jquery=.iwm-header-portal    jquery=.left_menu_lvb .box-list:eq(0)    itm
    [tags]    regression    wemall_header

TC_WMALL_01706 Search page sticky header - Show/hide sticky and back to top    ${WEMALL_WEB}/search2?q=Apple   jquery=.iwm-header-portal    jquery=#mi-productList .mi-product-card.col-xs-5.ng-scope:eq(0)    itm
    [tags]    regression    wemall_header

TC_WMALL_01707 Everyday Wow page sticky header - Show/hide sticky and back to top    ${WEMALL_WEB}/everyday-wow   jquery=.iwm-header-portal    jquery=#superdeal #everydaywow-product-list    itm
    [tags]    regression    wemall_header

TC_WMALL_01708 Level D page sticky header - Show/hide sticky and back to top    ${WEMALL_WEB}/products/casio-enticer-mtd-1066b-1a2vdf-2155655390889.html   jquery=.iwm-header-portal    jquery=.breadcrumb__inner_wrapper    itm
    [tags]    regression    wemall_header

# TC_ITMWM_04002 Verify Sticky Header on Lv.C for Merchant - Show/hide sticky and back to top        ${WEMALL_WEB}/m-${merchant_slug}-category-${CAT_SLUG_PKEY}.html    jquery=.iwm-header-portal    jquery=#menu-category    itm
#     [Tags]    TC_ITMWM_04002    regression    wemall_header    lyra

TC_ITMWM_05823 Everyday Wow page sticky header - Scroll to bottom and back to top    ${WEMALL_WEB}/everyday-wow   jquery=.iwm-header-portal    jquery=#footer    itm
    [tags]    regression    wemall_header

*** Keywords ***
Show and Hide Sticky and Back to Top
    [Arguments]    ${full_url}    ${hide_element}    ${show_element}    ${server}    ${protocol}=http
    Go to Specific URL    ${full_url}
    Check Location Contain    ${full_url}    ${protocol}
    Sticky Header Should Not Show
    Back To Top Button Not Show    ${server}

    Scroll Page To Element    ${server}    ${hide_element}
    Sticky Header Should Not Show
    Back To Top Button Not Show    ${server}

    Scroll Page To Element    ${server}    ${show_element}
    Sticky Header Should Show
    Back To Top Button Show    ${server}
    Verify Sticky WeMall Logo    ${protocol}

    Scroll Page To Element    ${server}    ${hide_element}
    Sticky Header Should Not Show

    # Scroll to footer
    Scroll Page To Footer    ${server}
    Sticky Header Should Show
    Back To Top Button Show    ${server}
    Verify Sticky WeMall Logo    ${protocol}
    # Scroll to header
    Scroll Page To Header    ${server}
    Sticky Header Should Not Show
    Back To Top Button Not Show    ${server}


