*** Settings ***
Force Tags        WLS_Full_Cart
Library    Selenium2Library
Resource   ${CURDIR}/../../../Keyword/Portal/wemall/Header/keywords_wemall_header.robot
Resource   ${CURDIR}/../../../Resource/Config/app_config.robot
Resource   ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource   ${CURDIR}/../../../Keyword/Portal/iTrueMart/Full_cart/keywords_full_cart.robot



Test Setup       Prepare Item In Cart
Test Teardown    Close Browser

*** Variables ***
${PKEY}         2787537870208
${INVENT_ID}    ELAAB1118411
${PRODUCT_NAME}    products/electrolux-eje3000-2787537870208.html

##hulk
#${PKEY}         jergens-650--2606503661929
#${INVENT_ID}    JEAAC1111111

${username}                     robot23@mail.com
${password}                     123456
*** Keywords ***
Prepare Item In Cart
    Open Browser    ${ITM_URL}    chrome
    Set Window Position    ${0}    ${0}
    Set Window Size    ${1440}    ${900}
	Add Product to Cart    ${PKEY}
	Close Cart Light Box
	keywords_wemall_header.Check Cart Badge Quantity    1


*** Test Cases ***

TC_iTM_04065 - Full cart -[TH] Guest click to level D.
    [Tags]    regression    fullcart    Cart    TC_iTM_04065    WLS_High
	Go To    ${ITM_URL}/cart
    Sleep    5s
    Click Element    jquery=.dt-image
    Sleep    5s
    Select Window    url=${WEMALL_URL}/${PRODUCT_NAME}

TC_iTM_04066 - Full cart -[EN] Guest click to level D.
    [Tags]    regression    fullcart    Cart    TC_iTM_04066    WLS_Medium
    Go To    ${ITM_URL}/en/cart
    Sleep    5s
    Click Element    jquery=.dt-image
    Sleep    5s
    Select Window    url=${WEMALL_URL}/en/${PRODUCT_NAME}

TC_iTM_04067 - Full cart -[TH] Member click to level D.
    [Tags]    regression    fullcart    Cart    TC_iTM_04067    WLS_Medium
    Login User to WeMall    ${username}     ${password}

    Go To    ${ITM_URL}/en/cart
    Sleep    5s
    Click Element    jquery=.dt-image
    Sleep    5s
    Select Window    url=${WEMALL_URL}/en/${PRODUCT_NAME}
    keywords_wemall_header.Click Log Out Link

TC_iTM_04068 - Full cart -[EN] Member click to level D.
    [Tags]    regression    fullcart    Cart    TC_iTM_04068    WLS_High
    Login User to WeMall    ${username}     ${password}

	Go To    ${ITM_URL}/en/cart
    Sleep    5s
    Click Element    jquery=.dt-image
    Sleep    5s
    Select Window    url=${WEMALL_URL}/en/${PRODUCT_NAME}
	keywords_wemall_header.Click Log Out Link