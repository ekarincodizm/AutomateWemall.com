*** Settings ***
Library           Selenium2Library
Library           Collections
Library           OperatingSystem
Library           String
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Common/keywords_itruemart_common.robot
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Register_Page/Keywords_RegisterPage.robot

*** Variables ***
${reg_email}    robotautomate@xmail.com
${existing_email}    robotautomate@gmail.com
${reg_user}     test
${reg_pwd}      true1234
${reg_confirm_pwd}    true3456
${blank}


*** Keyword ***
Verify Error Message
    [Arguments]    ${element}    ${Expect_message}
    Wait Until Element Is Visible     ${element}   20s
    ${errorMessage}=    Get Text    ${element}
    Should be equal as Strings    ${errorMessage}    ${Expect_message}


*** Test Case ***

TC_iTM_02980 Leave every fields as blank
    [tags]    TC_iTM_02980    ITMA-3127    register   regression   validate_form    ready
    Open Browser    ${ITM_URL}/users/register           ${BROWSER}
    Maximize Browser Window
    Select Checkbox    ${Checkbox_accept}
    Select Checkbox    ${Checkbox_accept}
    Checkbox Should Be Selected    ${Checkbox_accept}
    Click submit registration
    Verify Error Message    ${register_alert}    Password Incorrect
    Click popup OK
    [teardown]    Run Keywords    Close Browser


TC_iTM_02981 Leave email as blank
    [tags]    TC_iTM_02981    ITMA-3127    register   regression   validate_form    ready
    Open Browser    ${ITM_URL}/users/register           ${BROWSER}
    Maximize Browser Window
    Enter register information    ${blank}    ${reg_user}    ${reg_pwd}    ${reg_pwd}
    Select Checkbox    ${Checkbox_accept}
    Select Checkbox    ${Checkbox_accept}
    Checkbox Should Be Selected    ${Checkbox_accept}
    Click submit registration
    Verify Error Message    ${register_alert}    กรุณาใส่ทรูไอดี (อีเมล์ / เบอร์มือถือ)
    Click popup OK
    [teardown]    Run Keywords    Close Browser

TC_iTM_02982 Leave displayname as blank
    [tags]    TC_iTM_02982    ITMA-3127    register   regression   validate_form    ready
    Open Browser    ${ITM_URL}/users/register           ${BROWSER}
    Maximize Browser Window
    Enter register information    ${reg_email}    ${blank}    ${reg_pwd}    ${reg_pwd}
    sleep    1s
    Select Checkbox    ${Checkbox_accept}
    Select Checkbox    ${Checkbox_accept}
    Checkbox Should Be Selected    ${Checkbox_accept}
    Click submit registration
    Verify Error Message    ${register_alert}    กรุณากรอกชื่อที่ใช้ในการแสดง
    Click popup OK
    [teardown]    Run Keywords    Close Browser

TC_iTM_02983 Leave password as blank
    [tags]    TC_iTM_02983    ITMA-3127    register   regression   validate_form    ready
    Open Browser    ${ITM_URL}/users/register           ${BROWSER}
    Maximize Browser Window
    Enter register information    ${reg_email}    ${reg_user}    ${blank}    ${reg_pwd}
    sleep    1s
    Select Checkbox    ${Checkbox_accept}
    Select Checkbox    ${Checkbox_accept}
    Checkbox Should Be Selected    ${Checkbox_accept}
    Click submit registration
    Verify Error Message    ${register_alert}    Password Incorrect
    Click popup OK
    [teardown]    Run Keywords    Close Browser

TC_iTM_02984 Leave repassword as blank
    [tags]    TC_iTM_02984    ITMA-3127    register   regression   validate_form    ready
    Open Browser    ${ITM_URL}/users/register           ${BROWSER}
    Maximize Browser Window
    Enter register information    ${reg_email}    ${reg_user}    ${reg_pwd}    ${blank}
    sleep    1s
    Select Checkbox    ${Checkbox_accept}
    Select Checkbox    ${Checkbox_accept}
    Checkbox Should Be Selected    ${Checkbox_accept}
    Click submit registration
    Verify Error Message    ${register_alert}    รหัสผ่านยืนยัน ไม่ถูกต้อง
    Click popup OK
    [teardown]    Run Keywords    Close Browser


TC_iTM_02985 Enter invalid email format
    [tags]    TC_iTM_02985    ITMA-3127    register   regression   validate_form    ready
    Open Browser    ${ITM_URL}/users/register           ${BROWSER}
    Maximize Browser Window
    Enter register information    robot.com    ${reg_user}    ${reg_pwd}    ${reg_confirm_pwd}
    sleep    1s
    Select Checkbox    ${Checkbox_accept}
    Select Checkbox    ${Checkbox_accept}
    Checkbox Should Be Selected    ${Checkbox_accept}
    Click submit registration
    Verify Error Message    ${register_alert}    Username Must Be Email.
    Click popup OK
    [teardown]    Run Keywords    Close Browser

TC_iTM_02986 Enter unmatch password
    [tags]    TC_iTM_02986    ITMA-3127    register   regression   validate_form    ready
    Open Browser    ${ITM_URL}/users/register           ${BROWSER}
    Maximize Browser Window
    Enter register information    ${reg_email}    ${reg_user}    ${reg_pwd}    ${reg_confirm_pwd}
    sleep    1s
    Select Checkbox    ${Checkbox_accept}
    Select Checkbox    ${Checkbox_accept}
    Checkbox Should Be Selected    ${Checkbox_accept}
    Click submit registration
    Verify Error Message    ${register_alert}    รหัสผ่านยืนยัน ไม่ถูกต้อง
    Click popup OK
    [teardown]    Run Keywords    Close Browser

TC_iTM_02987 Enter an existing email
    [tags]    TC_iTM_02987    ITMA-3127    register   regression   validate_form    ready
    Open Browser    ${ITM_URL}/users/register           ${BROWSER}
    Maximize Browser Window
    Enter register information    ${existing_email}    ${reg_user}    ${reg_pwd}    ${reg_pwd}
    sleep    1s
    Select Checkbox    ${Checkbox_accept}
    Select Checkbox    ${Checkbox_accept}
    Checkbox Should Be Selected    ${Checkbox_accept}
    Click submit registration
    Verify Error Message    ${register_alert}    อีเมล์นี้มีอยู่ในระบบแล้ว กรุณาระบุใหม่ (3003)
    Click popup OK
    [teardown]    Run Keywords    Close Browser

TC_iTM_02988 Enter thai as password
    [tags]    TC_iTM_02988    ITMA-3127    register   regression   validate_form    ready
    Open Browser    ${ITM_URL}/users/register           ${BROWSER}
    Maximize Browser Window
    Enter register information    ${reg_email}    ${reg_user}    รหัสผ่าน    รหัสผ่าน
    sleep    1s
    Select Checkbox    ${Checkbox_accept}
    Select Checkbox    ${Checkbox_accept}
    Checkbox Should Be Selected    ${Checkbox_accept}
    Click submit registration
    Verify Error Message    ${register_alert}    Password Incorrect
    Click popup OK
    [teardown]    Run Keywords    Close Browser

TC_iTM_02989 Enter password as 3 character
    [tags]    TC_iTM_02989    ITMA-3127    register   regression   validate_form    ready
    Open Browser    ${ITM_URL}/users/register           ${BROWSER}
    Maximize Browser Window
    Enter register information    ${reg_email}    ${reg_user}    123    123
    sleep    1s
    Select Checkbox    ${Checkbox_accept}
    Select Checkbox    ${Checkbox_accept}
    Checkbox Should Be Selected    ${Checkbox_accept}
    Click submit registration
    Verify Error Message    ${register_alert}    Password Incorrect
    Click popup OK
    [teardown]    Run Keywords    Close Browser

TC_iTM_02990 Enter password as 17 character
    [tags]    TC_iTM_02990    ITMA-3127    register   regression   validate_form    ready
    Open Browser    ${ITM_URL}/users/register           ${BROWSER}
    Maximize Browser Window
    Enter register information    ${reg_email}    ${reg_user}    12345678901234567    12345678901234567
    ${maxlength}=    Get Element Attribute    ${Input_password_regisPge}@maxlength
    ${value}=    Get Element Attribute    ${Input_password_regisPge}@value
    Should Be Equal    ${maxlength}    16
    Should Be Equal    ${value}     1234567890123456
    [teardown]    Run Keywords    Close Browser

TC_iTM_02991 User not accept term and condition
    [tags]    TC_iTM_02991    ITMA-3127    register   regression   validate_form    ready
    Open Browser    ${ITM_URL}/users/register           ${BROWSER}
    Wait Until Element Is Not Visible    ${Submit_register_regisPge}    20s
    Select Checkbox    ${Checkbox_accept}
    Select Checkbox    ${Checkbox_accept}
    Wait Until Element Is Visible    ${Submit_register_regisPge}    20s
    [teardown]    Run Keywords    Close Browser

TC_iTM_02992 Enter Mobile number as user ID
    [tags]    TC_iTM_02992    ITMA-3127    register   regression   validate_form    ready
    Open Browser    ${ITM_URL}/users/register           ${BROWSER}
    Maximize Browser Window
    Enter register information    0889944556    ${reg_user}    ${reg_pwd}    ${reg_pwd}
    sleep    1s
    Select Checkbox    ${Checkbox_accept}
    Select Checkbox    ${Checkbox_accept}
    Checkbox Should Be Selected    ${Checkbox_accept}
    Click submit registration
    Verify Error Message    ${register_alert}    Username Must Be Email.
    Click popup OK
    [teardown]    Run Keywords    Close Browser

TC_iTM_02993 Verify if user enter comma into password
    [tags]    TC_iTM_02993    ITMA-3127    register   regression   validate_form    ready
    Open Browser    ${ITM_URL}/users/register           ${BROWSER}
    Maximize Browser Window
    Enter register information    ${reg_email}    ${reg_user}    123,456    123,456
    sleep    1s
    Select Checkbox    ${Checkbox_accept}
    Select Checkbox    ${Checkbox_accept}
    Checkbox Should Be Selected    ${Checkbox_accept}
    Click submit registration
    Verify Error Message    ${register_alert}    Password Incorrect
    Click popup OK
    [teardown]    Run Keywords    Close Browser

TC_iTM_04060 Display error message when field is lost focus
    [tags]    TC_iTM_04060    ITMA-3127    register   regression   validate_form    ready
    Open Browser    ${ITM_URL}/users/register           ${BROWSER}
    Maximize Browser Window
    Enter register information    ${blank}    ${blank}    ${blank}    ${blank}
    sleep    1s
    Select Checkbox    ${Checkbox_accept}
    Select Checkbox    ${Checkbox_accept}
    Verify Error Message    ${err_msg_username}    กรุณาใส่อีเมล์หรือทรูไอดีของคุณ
    Verify Error Message    ${err_msg_display_name}    กรุณาใส่ชื่อที่ใช้ในการแสดง
    Verify Error Message    ${err_msg_password}    กรุณาใส่รหัสผ่าน
    Verify Error Message    ${err_msg_confirm_password}    กรุณายืนยันรหัสผ่าน

    [teardown]    Run Keywords    Close Browser

TC_iTM_04061 Onblur invalid email format
    [tags]    TC_iTM_04061    ITMA-3127    register   regression   validate_form    ready
    Open Browser    ${ITM_URL}/users/register           ${BROWSER}
    Wait Until Element is ready and type    ${Input_username_regisPge}   asdad   10
    Press Key    ${Input_username_regisPge}    \\9
    Verify Error Message    ${err_msg_username}    อีเมล์ของท่านหรือทรูไอดีไม่ถูกต้อง กรุณาตรวจสอบอีกครั้ง

    [teardown]    Run Keywords    Close Browser

TC_iTM_04062 Onblur password as range 1 - 3 character
    [tags]    TC_iTM_04062    ITMA-3127    register   regression   validate_form    ready
    Open Browser    ${ITM_URL}/users/register           ${BROWSER}
    Wait Until Element is ready and type    ${Input_password_regisPge}   123   10
    Press Key    ${Input_password_regisPge}    \\9
    Verify Error Message    ${err_msg_password}    รหัสผ่านต้องมีความยาว 4 - 16 ตัวอักษร

    [teardown]    Run Keywords    Close Browser

TC_iTM_04063 Onblur enter comma(,) into password
    [tags]    TC_iTM_04063    ITMA-3127    register   regression   validate_form    ready
    Open Browser    ${ITM_URL}/users/register           ${BROWSER}
    Wait Until Element is ready and type    ${Input_password_regisPge}   123,456   10
    Press Key    ${Input_password_regisPge}    \\9
    Verify Error Message    ${err_msg_password}    password incorrect

    [teardown]    Run Keywords    Close Browser

TC_iTM_04064 Onblur unmatch password
    [tags]    TC_iTM_04064    ITMA-3127    register   regression   validate_form    ready
    Open Browser    ${ITM_URL}/users/register           ${BROWSER}
    Wait Until Element is ready and type    ${Input_username_regisPge}   123456   10
    Wait Until Element is ready and type    ${Input_confirmpassword_regisPge}   111222   10
    Press Key    ${Input_confirmpassword_regisPge}    \\9
    Verify Error Message    ${err_msg_confirm_password}    รหัสผ่านยืนยันไม่ถูกต้อง

    [teardown]    Run Keywords    Close Browser