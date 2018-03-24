*** Settings ***
Force Tags        WLS_Full_Cart
Library    Selenium2Library
Resource   ${CURDIR}/../../../Resource/init.robot
Resource   ${CURDIR}/../../../Keyword/Portal/wemall/Header/keywords_wemall_header.robot
Resource   ${CURDIR}/../../../Keyword/Database/PCMS/Cart/keywords_cart.robot
Resource   ${CURDIR}/../../../Resource/Config/app_config.robot
Resource   ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource   ${CURDIR}/../../../Keyword/Portal/iTrueMart/Full_cart/keywords_full_cart.robot
Resource   ${CURDIR}/../../../Keyword/API/PCMS/Stock/keywords_stock.robot
Suite Setup       Setup Browser
Suite Teardown    Close All Browsers

*** Variables ***
${PKEY}         2787537870208
${INVENT_ID}    ELAAB1118411

${LOADING_BACKGROUND_ELEMENT}    ._iwm_ .ajaxloading-widget-background
${LOADING_ICON_ELEMENT}          ._iwm_ .ajaxloading-widget-icon-container
${CART_CONTENT_ELEMENT}          ${EMPTY}#cart-box-info div
${CART_QUALTITY_ELEMENT}         ${EMPTY}#cartbox-item-quantity

${username}                     robot24@mail.com
${password}                     123456

*** Keywords ***
Setup Browser
    Open Browser    ${ITM_URL}    chrome
    Set Window Position    ${0}    ${0}
    Set Window Size    ${1440}    ${900}

Prepare Item In Cart Guest
	Add Product to Cart    ${PKEY}
	Close Cart Light Box
	keywords_wemall_header.Check Cart Badge Quantity    1

Prepare Item In Cart Member
    Open Browser    ${ITM_URL}    chrome
    Set Window Position    ${0}    ${0}
    Set Window Size    ${1440}    ${900}
    Login User to WeMall    ${username}     ${password}
	Add Product to Cart    ${PKEY}
	Close Cart Light Box
	keywords_wemall_header.Check Cart Badge Quantity    1

Clear cart and Logout
     Clear Cart Current User
     keywords_wemall_header.Click Log Out Link

Test Loading full cart sequence
    [Arguments]    ${expectAmount}    ${expectedLoadingText}    ${expectedLastText}     ${lang}

	Go To    ${ITM_URL}${lang}/cart

	comment    before loading
	${actualLoadingText}=    Execute Javascript	return $('${CART_CONTENT_ELEMENT}').html();
    Should Contain    ${actualLoadingText}    ${expectedLoadingText}
	Selenium2Library.Element Text Should Be          jquery=${CART_QUALTITY_ELEMENT}     0

	Wait Until Element Is Visible    jquery=${LOADING_BACKGROUND_ELEMENT}    10
	Wait Until Element Is Visible    jquery=${LOADING_ICON_ELEMENT}          10

    comment    after loading
    Wait Until Element Is Not Visible     jquery=${LOADING_BACKGROUND_ELEMENT}
	Wait Until Element Is Not Visible     jquery=${LOADING_ICON_ELEMENT}

    ${actualInnerText}=    Execute Javascript	return $('${CART_CONTENT_ELEMENT}').html();
    Should Contain	${actualInnerText}    ${expectedLastText}

    Selenium2Library.Element Text Should Be          jquery=${CART_QUALTITY_ELEMENT}       ${expectAmount}
    keywords_wemall_header.Check Cart Badge Quantity     ${expectAmount}

*** Test Cases ***
TC_ITMWM_05817 [Web] Action full cart when no items in cart by guest.
    [Tags]              full_cart_loading    regression    TC_ITMWM_05817    WLS_High
    [Template]          Test Loading full cart sequence
# # expectAmount          expectLoading        expectLastText     lang
    0                     กำลังโหลดรายการ...    ไม่พบสินค้าในตะกร้า    ${empty}
    0                     Loading...           There are no items in this cart    /en


TC_ITMWM_05818 [Web] Action full cart when on items in cart by member.
    [Tags]              full_cart    regression    TC_ITMWM_05818    WLS_Medium
    [Template]          Test Loading full cart sequence
    [Setup]             Login User to WeMall    ${username}     ${password}
    [Teardown]          Clear Cart Current User
# # expectAmount          expectLoading        expectLastText     lang
    0                     กำลังโหลดรายการ...    ไม่พบสินค้าในตะกร้า    ${empty}
    0                     Loading...           There are no items in this cart    /en

TC_ITMWM_05819 [Web] Action full cart when have items in cart by guest.
    [Tags]              full_cart_loading    regression    TC_ITMWM_05819    WLS_Medium
    [Template]          Test Loading full cart sequence
    [Setup]             Run Keywords     Stock - Increase Stock By Inventory Id    ELAAB1118411    AND    Prepare Item In Cart Guest
    [Teardown]          Clear Cart Current User
# # expectAmount          expectLoading        expectLastText     lang
    1                     กำลังโหลดรายการ...    data-product-key="${PKEY}"    ${empty}
    1                     Loading...           data-product-key="${PKEY}"    /en


TC_ITMWM_05820 [Web] Action full cart when have items in cart by member.
    [Tags]              full_cart_loading    regression    TC_ITMWM_05820    WLS_High
    [Template]          Test Loading full cart sequence
    [Setup]             Run Keywords    Stock - Increase Stock By Inventory Id    ELAAB1118411    AND    Prepare Item In Cart Member
    [Teardown]          Clear Cart Current User
# # expectAmount          expectLoading        expectLastText     lang
    1                     กำลังโหลดรายการ...    data-product-key="${PKEY}"    ${empty}
    1                     Loading...           data-product-key="${PKEY}"    /en


