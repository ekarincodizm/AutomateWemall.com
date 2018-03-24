*** Settings ***
Library           Selenium2Library
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Full_cart/keywords_full_cart.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/wemall_portal/portal_page_keywords.robot
Suite Teardown    Close All Browsers

*** Variables ***
${username}       robot23@mail.com
${password}       123456

*** Test Cases ***
TC_ITMWM_05816 Given that user has not login, when login, then user should be redirected to the page in continue url parameter
    [tags]    regression
    Open Browser    ${WEMALL_URL}/auth/login?continue=${WEMALL_URL}/cart    ${BROWSER}
    Login Page - Display Login Page
    Login Page - User Enter Username    ${username}
    Login Page - User Enter Password    ${password}
    Login Page - User Click Login Button
    Display Full Cart Page

TC_ITMWM_05813 Given that user has already login, when visit login page, then user should be redirected to the page in continue url parameter
    [tags]    regression
    Open Browser    ${WEMALL_URL}/auth/login    ${BROWSER}
    Login Page - Display Login Page
    Login Page - User Enter Username    ${username}
    Login Page - User Enter Password    ${password}
    Login Page - User Click Login Button
    Display Wemall Portal Page
    Go To    ${WEMALL_URL}/auth/login?continue=${WEMALL_URL}/cart
    Display Full Cart Page

TC_ITMWM_05815 Given that user has logout, when login, then user should be redirected to the page in continue url parameter
    [tags]    regression
    Open Browser    ${WEMALL_URL}/auth/login    ${BROWSER}
    Login Page - Display Login Page
    Login Page - User Enter Username    ${username}
    Login Page - User Enter Password    ${password}
    Login Page - User Click Login Button
    Display Wemall Portal Page
    Go To    ${ITM_URL}/auth/logout
    Go To    ${WEMALL_URL}/auth/login?continue=${WEMALL_URL}/cart
    Login Page - Display Login Page
    Login Page - User Enter Username    ${username}
    Login Page - User Enter Password    ${password}
    Login Page - User Click Login Button
    Display Full Cart Page
