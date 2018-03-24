*** Settings ***
Force Tags    WLS_Level_D
Suite Teardown     Close All Browsers

Library           Selenium2Library
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/portal_page/portal_page_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
# Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Header/keywords_header.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Full_cart/keywords_full_cart.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Cart_light_box/Keywords_CartLightBox.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Common/keywords_common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/common/web_common_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/cart/keywords_cart.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/header/keywords_wemall_header.robot
*** Variables ***
${product_pkey}    2787537870208
${invent_ID}	   ELAAB1118411
${is_login}        1
${username}        robot21@mail.com
${password}        123456

*** Test Cases ***
TC_iTM_03531,TC_iTM_03532, TC_iTM_03533 - Cart light box - Guest increased, decrease and delete product.
    [Tags]      Notification        desktop     regression    WLS_Medium
    [Setup]    Run Keywords    Open Browser and Maximize Window    ${WEMALL_WEB}    ${BROWSER}    AND    Set Window Size    ${1440}    ${900}
    Comment    TC_iTM_03531 - Cart light box - Guest increased the number of products
    Comment    TC_iTM_03532 - Cart light box - Guest decreased the number of products
    Comment    TC_iTM_03533 - Cart light box - Guest delete of product
    Level D Go to level D with Product No Cache    ${product_pkey}
    Level D Click Add To Cart success case
    Get Selected Item Quantity
    Wait Until Element Is Visible    ${LOADING-TITLE-LIST}
    Sleep    3s
    CartLightBox - Select Quantity Product Normal By Inventory Id    ${invent_ID}    3
    Sleep    3s
    Get Selected Item Quantity
    Sleep    3s
    CartLightBox - Select Quantity Product Normal By Inventory Id    ${invent_ID}    2
    Sleep    3s
    Get Selected Item Quantity
    Sleep    3s
    ${res}=    Run Keyword And Return Status    Click Element    jquery=.delete-item[data-inventory-id='${invent_ID}']
    Run Keyword If     ${res}==${FALSE}    Confirm Action
    [Teardown]    Close All Browsers

TC_iTM_03534, TC_iTM_03535, TC_iTM_03536 - Cart light box - Member increased, decrease and delete product.
    [Tags]      Notification        desktop     regression    WLS_High
    [Setup]    Run Keywords    Open Browser and Maximize Window    ${WEMALL_WEB}    ${BROWSER}    AND    Set Window Size    ${1440}    ${900}
    Comment    TC_iTM_03534 - Cart light box - Member increased the number of products
    Comment    TC_iTM_03535 - Cart light box - Member  Decreased the number of products
    Comment    TC_iTM_03536 - Cart light box - Member Delete of product
    Login User to WeMall    ${username}     ${password}
    Level D Go to level D with Product No Cache    ${product_pkey}
    Level D Click Add To Cart success case
    Sleep    3s
    Get Selected Item Quantity
    Wait Until Element Is Visible    ${LOADING-TITLE-LIST}
    Sleep    3s
    CartLightBox - Select Quantity Product Normal By Inventory Id    ${invent_ID}    3
    Sleep    3s
    Get Selected Item Quantity
    Sleep    3s
    CartLightBox - Select Quantity Product Normal By Inventory Id    ${invent_ID}    2
    Sleep    3s
    Get Selected Item Quantity
    Sleep    3s
    #${res}=    Run Keyword And Return Status    Click Element    jquery=.delete-item[data-inventory-id='${invent_ID}']
    #Run Keyword If     ${res}==${FALSE}    Confirm Action
    Click Element    jquery=.delete-item[data-inventory-id='${invent_ID}']
    Confirm Action
    Sleep    3s
    Close Cart Light Box
    [Teardown]    Close All Browsers

