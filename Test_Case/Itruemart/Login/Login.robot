*** Settings ***
Library           Selenium2Library
Library           Collections
Library           OperatingSystem
Library           String
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Common/keywords_itruemart_common.robot
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Log-in/Keywords_LoginPage.robot
Resource          ${CURDIR}/../../../Keyword/Features/User_login/User_login.robot

*** Variables ***

*** Keyword ***
Verify Login Error Message
    [Arguments]    ${element}    ${Expect_message}
    Wait Until Element Is Visible     ${element}   20s
    ${errorMessage}=    Get Text    ${element}
    Should be equal as Strings    ${errorMessage}    ${Expect_message}


*** Test Case ***

TC_iTM_03739 Display error message required email after lost focus
    [tags]    TC_iTM_03739    ITMA-3128    login   regression   validate_form    ready
    Open Browser    ${ITM_URL}/auth/login           ${BROWSER}
    # Maximize Browser Window
    # Go To Login Page
    Wait Until Element is ready and type    name=username   asdad   10
    Press Key    name=username    \\9
    Verify Login Error Message    //*[@for="login_username"][@class="error-message"]    อีเมล์ของท่านหรือทรูไอดีไม่ถูกต้อง กรุณาตรวจสอบอีกครั้ง

    #[teardown]    Run Keywords    Close Browser


TC_iTM_03740 Display error message required password after lost focus
    [tags]    TC_iTM_03740    ITMA-3128    login   regression   validate_form    ready
    # Open Browser    ${ITM_URL}           ${BROWSER}
    Open Browser    ${ITM_URL}/auth/login           ${BROWSER}
    # Maximize Browser Window
    # Go To Login Page
    Press Key    name=password    \\9
    Verify Login Error Message    //*[@for="login_password"][@class="error-message"]    กรุณาใส่รหัสผ่าน
    [teardown]    Run Keywords    Close Browser


TC_iTM_03741 Display error message required email and password both
    [tags]    TC_iTM_03741    ITMA-3128    login   regression   validate_form    ready
    # Open Browser    ${ITM_URL}           ${BROWSER}
    Open Browser    ${ITM_URL}           ${BROWSER}
    Maximize Browser Window
    Go To Login Page
    Login_with_TrueID    ${EMPTY}    ${EMPTY}
    Verify Login Error Message    //*[@for="login_username"][@class="error-message"]    กรุณาใส่อีเมล์หรือทรูไอดีของคุณ
    Verify Login Error Message    //*[@for="login_password"][@class="error-message"]    กรุณาใส่รหัสผ่าน
    # Verify TrueID User Login Error Message    กรุณาใส่ทรูไอดี (อีเมล์ / เบอร์มือถือ / เบอร์ทรูการ์ด)

    [teardown]    Close Browser


TC_iTM_03742 Display error message required email after click login
    [tags]    TC_iTM_03742    ITMA-3128    login   regression   validate_form    ready
    # Open Browser    ${ITM_URL}           ${BROWSER}
    Open Browser    ${ITM_URL}           ${BROWSER}
    Maximize Browser Window
    Go To Login Page
    Login_with_TrueID    robotautomate@gmail.com    ${EMPTY}
    Verify Login Error Message    //*[@for="login_password"][@class="error-message"]    กรุณาใส่รหัสผ่าน

    [teardown]    Close Browser


TC_iTM_03743 Display error message required password after click login
    [tags]    TC_iTM_03743    ITMA-3128    login   regression   validate_form    ready
    # Open Browser    ${ITM_URL}           ${BROWSER}
    Open Browser    ${ITM_URL}           ${BROWSER}
    Maximize Browser Window
    Go To Login Page
    Login_with_TrueID    ${EMPTY}    true1234
    Verify Login Error Message    //*[@for="login_username"][@class="error-message"]    กรุณาใส่อีเมล์หรือทรูไอดีของคุณ

    [teardown]    Close Browser