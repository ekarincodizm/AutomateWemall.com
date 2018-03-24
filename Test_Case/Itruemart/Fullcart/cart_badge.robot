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

##hulk
#${PKEY}         jergens-650--2606503661929
#${INVENT_ID}    JEAAC1111111

${username}                     robot22@mail.com
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

TC_iTM_03537, TC_iTM_03538, TC_iTM_03539 - Full cart - Guest increased, decrease and delete product.
    [Tags]    regression    TC_iTM_03537    TC_iTM_03538    TC_iTM_03539    WLS_High
    Comment    TC_iTM_03537 - Full cart - Guest increased the number of products
    Comment    TC_iTM_03538 - Full cart - Guest decreased the number of products
    Comment    TC_iTM_03539 - Full cart - Guest delete of product
	Go To    ${ITM_URL}/cart
	Full Cart - Select Quantity Product Normal By Inventory Id    ${INVENT_ID}    5
	keywords_wemall_header.Check Cart Badge Quantity    5
    Full Cart - Select Quantity Product Normal By Inventory Id    ${INVENT_ID}    2
    keywords_wemall_header.Check Cart Badge Quantity    2
    Sleep    5
    Click Element    jquery=.delete-item
    Sleep    5
    Confirm Action
    Sleep    5s
	keywords_wemall_header.Check Cart Badge Quantity    0


TC_iTM_03540, TC_iTM_03541, TC_iTM_03542 - Full cart - Member increased, decrease and delete product.
    [Tags]    regression    TC_iTM_03540    TC_iTM_03541    TC_iTM_03542    WLS_High
    Comment    TC_iTM_03540 - Full cart - Member increased the number of products
    Comment    TC_iTM_03541 - Full cart - Member decreased the number of products
    Comment    TC_iTM_03542 - Full cart - Member delect of product
    Login User to WeMall    ${username}     ${password}

	Go To    ${ITM_URL}/cart
    Sleep    5s
	Full Cart - Select Quantity Product Normal By Inventory Id    ${INVENT_ID}    5
	keywords_wemall_header.Check Cart Badge Quantity    5
    Full Cart - Select Quantity Product Normal By Inventory Id    ${INVENT_ID}    2
    keywords_wemall_header.Check Cart Badge Quantity    2
    Click Element    jquery=.delete-item
    Confirm Action
    Sleep    5s
	keywords_wemall_header.Check Cart Badge Quantity    0
	keywords_wemall_header.Click Log Out Link