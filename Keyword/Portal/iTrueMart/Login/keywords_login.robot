*** Settings ***
Resource          ${CURDIR}/web_element_login.robot
Resource          ${CURDIR}/../Header/keywords_header.robot
Resource          ${CURDIR}/../../wemall/header/keywords_wemall_header.robot
Resource          ../../../Common/Keywords_Common.robot

*** Variables ***
${username_login}    robotautomate@gmail.com
${password_login}    true1234
${freebie_username_login}             freebieautomate@gmail.com
${freebie_password_login}             @true1234
${freebie_checkout_username_login}    freebieautomate.checkout@gmail.com
${freebie_checkout_password_login}    @true1234


############## DO NOT MOVE SELENIUM2LIBRARY  ############################

*** Keywords ***
Login Page - User Enter Username
    [Arguments]    ${email_login}=${username_login}
    Selenium2Library.Wait Until Element Is Visible    ${XPATH_LOGIN.txt_username}    15s
    Selenium2Library.Input Text    ${XPATH_LOGIN.txt_username}    ${email_login}

Login Page - User Enter Password
    [Arguments]   ${password}=${password_login}
    Selenium2Library.Wait Until Element Is Visible    ${XPATH_LOGIN.txt_password}    15s
    Selenium2Library.Input Text    ${XPATH_LOGIN.txt_password}    ${password}

Login Page - User Click Login Button
    Selenium2Library.Wait Until Element Is Visible    ${XPATH_LOGIN.btn_login}    15s
    Selenium2Library.Click Element    ${XPATH_LOGIN.btn_login}

Login Page - Display Login Page
    Selenium2Library.Wait Until Element Is Visible    ${XPATH_LOGIN.txt_username}    ${CHECKOUT_TIMEOUT}
    Selenium2Library.Location Should Contain    /auth/login

User Enter Username On Login Page As Robot Automate Checkout
    Selenium2Library.Wait Until Element Is Visible    ${XPATH_LOGIN.txt_username}    ${CHECKOUT_TIMEOUT}
    Selenium2Library.Input Text    ${XPATH_LOGIN.txt_username}    ${DATA_CHECKOUT.valid_username_checkout}

User Enter Username On Login Page Mobile As Robot Automate Checkout
    Wait Until Element Is Visible    ${XPATH_LOGIN_MOBILE.txt_username}    ${CHECKOUT_TIMEOUT}
    Input Text    ${XPATH_LOGIN_MOBILE.txt_username}    ${DATA_CHECKOUT.valid_username_checkout}

User Enter Password On Login Page As Robot Automate Checkout
    Wait Until Element Is Visible    ${XPATH_LOGIN.txt_password}    ${CHECKOUT_TIMEOUT}
    Input Text    ${XPATH_LOGIN.txt_password}    ${DATA_CHECKOUT.valid_password_checkout}

User Enter Password On Login Page Mobile As Robot Automate Checkout
    Wait Until Element Is Visible    ${XPATH_LOGIN_MOBILE.txt_password}    ${CHECKOUT_TIMEOUT}
    Input Text    ${XPATH_LOGIN_MOBILE.txt_password}    ${DATA_CHECKOUT.valid_password_checkout}

User Enter Username On Login Page Mobile
    Wait Until Element Is Visible    ${XPATH_LOGIN_MOBILE.txt_username}    ${CHECKOUT_TIMEOUT}
    Input Text    ${XPATH_LOGIN_MOBILE.txt_username}    ${DATA_CHECKOUT.valid_username}

User Enter Password On Login Page Mobile
    Wait Until Element Is Visible    ${XPATH_LOGIN_MOBILE.txt_password}    ${CHECKOUT_TIMEOUT}
    Input Text    ${XPATH_LOGIN_MOBILE.txt_password}    ${DATA_CHECKOUT.valid_password}

User Click Login Button On Login Page
    Wait Until Element Is Visible    ${XPATH_LOGIN.btn_login}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_LOGIN.btn_login}

User Click Login Button On Login Page Mobile
    Wait Until Element Is Visible    ${XPATH_LOGIN_MOBILE.btn_login}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_LOGIN_MOBILE.btn_login}

User Click Register Button
    Wait Until Element Is Visible    ${Btn_register}    ${CHECKOUT_TIMEOUT}
    Click Element    ${Btn_register}

User Login From Header Bar
    [Arguments]   ${customer_email}=robotautomate@gmail.com   ${customer_password}=true1234
    #Header - User Click Login Link On Web
    Header - User Click Login Link
    Login Page - Display Login Page
    Login Page - User Enter Username  ${customer_email}
    Login Page - User Enter Password  ${customer_password}
    Login Page - User Click Login Button

User Login From Header Bar Mobile
    User Click Login Link On Top Bar Mobile
    Run Keyword If    '${ENV}' == 'antman'    User Enter Username On Login Page Mobile As Robot Automate Checkout
    ...    ELSE    User Enter Username On Login Page Mobile
    User Enter Password On Login Page Mobile As Robot Automate Checkout
    User Click Login Button On Login Page Mobile

User Login From Header Bar As Robot Automate
    User Click Login Link On Top Bar
    #User Enter Username On Login Page
    Run Keyword If    '${ENV}' == 'antman'    User Enter Username On Login Page As Robot Automate Checkout
    ...    ELSE    User Enter Username On Login Page
    User Enter Password On Login Page
    User Click Login Button On Login Page

Login User to iTrueMart
    [Arguments]    ${username}=robotautomate@gmail.com    ${password}=true1234
    Header - User Click Login Link On Web
    Login Page - Display Login Page
    Wait Until Element Is Visible    ${XPATH_LOGIN.txt_username}    15s
    Input Text    ${XPATH_LOGIN.txt_username}    ${username}
    Wait Until Element Is Visible    ${XPATH_LOGIN.txt_password}    15s
    Input Text    ${XPATH_LOGIN.txt_password}    ${password}
    Login Page - User Click Login Button
    Sleep    1s

User Login From login page
    [Arguments]    ${Text_Email}    ${Text_Pass}
    Open Browser    ${ITM_URL}/auth/login           ${BROWSER}
    Maximize Browser Window
    Wait Until Element is ready and type    ${Input_username}    ${Text_Email}    60s
    Wait Until Element is ready and type    ${Input_password}    ${Text_Pass}    60s
    Wait Until Element is ready and click    ${Btn_login}    60s
    Wait Until Element Is Not Visible    ${img_loading}    60s

Login User to iTrueMart With User Freebie
    # Login User to iTrueMart         ${freebie_username_login}             ${freebie_password_login}
    User Login From login page         ${freebie_username_login}             ${freebie_password_login}

Login User to iTrueMart With User Freebie Checkout
    # Login User to iTrueMart         ${freebie_checkout_username_login}             ${freebie_checkout_password_login}
    User Login From login page         ${freebie_username_login}             ${freebie_password_login}
