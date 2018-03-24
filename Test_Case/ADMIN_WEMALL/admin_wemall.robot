*** Settings ***
Library           Selenium2Library
Library           DateTime
Library           BuiltIn
Library           ${CURDIR}/../../Python_Library/ExtendedSelenium/
Resource          ${CURDIR}/../../Resource/init.robot
Resource          ${CURDIR}/../../Keyword/Portal/admin_wemall/admin_wemall_keyword.robot
Resource          ${CURDIR}/../../Keyword/Portal/admin_wemall/admin_wemall_web_element.robot
Suite Teardown    Close All Browsers

*** Variables ***
${username_login}        test
${password_login}        password
${username_create}       hulk_test_username
${username_create_spacebar}     hulk _test_ username
${username_create_incen}        HULK_TEST_USERNAME
${username_create_not_valid}        a
${firstname_create_not_valid}       a
${lastname_create_not_valid}        a
${email_create_not_valid}           a
${password_create_not_valid}        a
${password_create_not_valid2}        a b c d \ e  ] f g [ h i j
${repassword_create_not_valid}      aaaa
${password_create}       hulktestpassword
${repassword_create}     hulktestpassword
${firstname_create}      hulk_test_firstname
${lastname_create}       hulk_test_lastname
${email_create}          hulk_test_email@email.com
${password_expect}          abcdefghij
${validate_text_expect}     Username length should be between 4 - 64
${validate_text_expect2}    Username already exists
${validate_text_expect3}    First Name length should be between 4 - 64
${validate_text_expect4}    Last Name length should be between 4 - 64
${validate_text_expect5}    Email pattern is incorrect
${validate_text_expect6}    Password is too short
${validate_text_expect7}    Re-Enter Password not match

&{hulk01InAllRobot}
...    username=hulk01
...    firstname=hulk01
...    lastname=hulk01
...    email=hulk01@mail.com
...    password=password
...    passwordconfirm=password
...    shop=All Shop
...    role=all

&{hulk02InHulkRobot}
...    username=hulk02
...    firstname=hulk02
...    lastname=hulk02
...    email=hulk02@mail.com
...    password=password
...    passwordconfirm=password
...    shop=Hulk_Robot
...    role=all

&{pngpingInAllRobot}
...    username=png_ping
...    firstname=png_ping
...    lastname=hulkpng_ping01
...    email=png_ping@mail.com
...    password=1234
...    passwordconfirm=1234
...    shop=All Shop
...    role=report

*** Test Cases ***
TC_ITMWM_05181 Manage merchant user - Create user - Create new user from User list page
    [Tags]    add    TC_ITMWM_05181
    ${current_date}=        Get Current Date
    Admin Wemall - Open Admin Wemall Page And Login    test    password
    Admin Wemall - Add New User    ${username_create}${current_date}    ${password_create}${current_date}    ${repassword_create}${current_date}    ${firstname_create}${current_date}    ${lastname_create}${current_date}    ${email_create}
    Admin Wemall - Save User Information
    Admin Wemall - Verify Add User Success      ${current_date}
    [Teardown]    Close Browser

TC_ITMWM_05182 Manage merchant user - Create user - Username more than 4 characters and cannot put space in username
    [Tags]    add    TC_ITMWM_05182
    ${current_date}=        Get Time            epoch
    Admin Wemall - Open Admin Wemall Page And Login    test    password
    Admin Wemall - Add New User    ${username_create_not_valid}    ${password_create}${current_date}    ${repassword_create}${current_date}    ${firstname_create}${current_date}    ${lastname_create}${current_date}    ${email_create}
    Admin Wemall - Validate Text       ${validate_text_expect}
    Admin Wemall - Input Username       ${username_create_spacebar}${current_date}
    Admin Wemall - Verify Username              ${username_create}${current_date}
    Admin Wemall - Save User Information
    Admin Wemall - Verify Add User Success      ${current_date}
    [Teardown]    Close Browser

TC_ITMWM_05183 Manage merchant user - Create user - Username must unique and case insensitive
    [Tags]    add    TC_ITMWM_05183
    ${current_date}=        Get Current Date
    Admin Wemall - Open Admin Wemall Page And Login    test    password
    Admin Wemall - Add New User    ${username_create}${current_date}    ${password_create}${current_date}    ${repassword_create}${current_date}    ${firstname_create}${current_date}    ${lastname_create}${current_date}    ${email_create}
    Admin Wemall - Save User Information
    Admin Wemall - Verify Add User Success          ${current_date}
    Admin Wemall - Click User List Menu
    Admin Wemall - Add New User    ${username_create}${current_date}    ${password_create}${current_date}    ${repassword_create}${current_date}    ${firstname_create}${current_date}    ${lastname_create}${current_date}    ${email_create}
    Admin Wemall - Save User Information
    Admin Wemall - Validate Text    ${validate_text_expect2}
    Admin Wemall - Input Username       ${username_create_incen}${current_date}
    Admin Wemall - Save User Information
    Admin Wemall - Validate Text    ${validate_text_expect2}
    Admin Wemall - Click User List Menu
    Wait Until Page Contains Element            ${button_create_user}    30
    sleep    5s
    Page Should Contain Element             jquery=td:contains("${current_date}")
    [Teardown]    Close Browser

TC_ITMWM_05184 Manage merchant user - Create user - First name more than 4 characters
    [Tags]    add    TC_ITMWM_05184
    ${current_date}=        Get Current Date
    Admin Wemall - Open Admin Wemall Page And Login    test    password
    Admin Wemall - Add New User    ${username_create}${current_date}    ${password_create}${current_date}    ${repassword_create}${current_date}    ${firstname_create_not_valid}    ${lastname_create}${current_date}    ${email_create}
    Admin Wemall - Validate Text       ${validate_text_expect3}
    Admin Wemall - Input First Name     ${firstname_create}${current_date}
    Admin Wemall - Save User Information
    Admin Wemall - Verify Add User Success      ${current_date}
    [Teardown]    Close Browser

TC_ITMWM_05185 Manage merchant user - Create user - Last name more than 4 characters
    [Tags]    add    TC_ITMWM_05185
    ${current_date}=        Get Current Date
    Admin Wemall - Open Admin Wemall Page And Login    test    password
    Admin Wemall - Add New User    ${username_create}${current_date}    ${password_create}${current_date}    ${repassword_create}${current_date}    ${firstname_create}${current_date}    ${lastname_create_not_valid}    ${email_create}
    Admin Wemall - Validate Text       ${validate_text_expect4}
    Admin Wemall - Input Lastname Name      ${lastname_create}${current_date}
    Admin Wemall - Save User Information
    Admin Wemall - Verify Add User Success      ${current_date}
    [Teardown]    Close Browser

TC_ITMWM_05186 Manage merchant user - Create user - E-mail check compat with e-mail format
    [Tags]    add    TC_ITMWM_05186
    ${current_date}=        Get Current Date
    Admin Wemall - Open Admin Wemall Page And Login    test    password
    Admin Wemall - Add New User    ${username_create}${current_date}    ${password_create}${current_date}    ${repassword_create}${current_date}    ${firstname_create}${current_date}    ${lastname_create}${current_date}    ${email_create_not_valid}
    Admin Wemall - Validate Text       ${validate_text_expect5}
    Admin Wemall - Input Email          ${email_create}
    Admin Wemall - Save User Information
    Admin Wemall - Verify Add User Success      ${current_date}
    [Teardown]    Close Browser

TC_ITMWM_05187 Manage merchant user - Create user - Password format ([a-zA-Z0-9!@#$%^&*()_+|=}{?><.-]){4,64} and cannot have space
    [Tags]    add    TC_ITMWM_05187
    ${current_date}=        Get Current Date
    Admin Wemall - Open Admin Wemall Page And Login    test    password
    Admin Wemall - Add New User    ${username_create}${current_date}    ${password_create_not_valid}    ${repassword_create}${current_date}    ${firstname_create}${current_date}    ${lastname_create}${current_date}    ${email_create}
    Admin Wemall - Validate Text       ${validate_text_expect6}
    Admin Wemall - Input Password       ${password_create_not_valid2}
    Admin Wemall - Verify Password              ${password_expect}
    Admin Wemall - Input Password       ${password_create}${current_date}
    Admin Wemall - Save User Information
    Admin Wemall - Verify Add User Success      ${current_date}
    [Teardown]    Close Browser

TC_ITMWM_05188 Manage merchant user - Create user - Re-enter password match exactly characters with password
    [Tags]    manage    TC_ITMWM_05188
    ${current_date}=        Get Current Date
    Admin Wemall - Open Admin Wemall Page And Login    test    password
    Admin Wemall - Add New User    ${username_create}${current_date}    ${password_create}    ${repassword_create_not_valid}${current_date}    ${firstname_create}${current_date}    ${lastname_create}${current_date}    ${email_create}
    Admin Wemall - Validate Text       ${validate_text_expect7}
    Admin Wemall - Input Password       ${password_create}
    Admin Wemall - Input RePassword       ${repassword_create}
    Admin Wemall - Save User Information
    Admin Wemall - Verify Add User Success      ${current_date}
    [Teardown]    Close Browser

TC_ITMWM_05189 Manage merchant user - Create user - Admin don't have privilege to create user
    [Tags]    manage    TC_ITMWM_05189
    [Setup]    Admin Wemall - Create Prepare Data
    Admin Wemall - Open Admin Wemall Page And Login    png_ping    1234
    Wait Until Element Is Not Visible    ${user_list_loading}
    Wait Until Element Is Visible    ${button_create_user}
    ${active_class}=        Get Element Attribute       ${button_add_user_enable}
    Should Be Equal        true       ${active_class}
    Close Browser
#have privilege
    Admin Wemall - Open Admin Wemall Page And Login    test    password
    Wait Until Element Is Not Visible    ${user_list_loading}
    Wait Until Element Is Visible    ${button_create_user}
    ${active_class}=        Get Element Attribute       ${button_add_user_enable}
    Should Be Equal        "None"       "${active_class}"
    Close Browser

TC_ITMWM_05190 Manage merchant role - manage role - Show username on manage user role tab
    [Tags]    manage    TC_ITMWM_05190
    [Setup]    Admin Wemall - Create Prepare Data
    Admin Wemall - Open Admin Wemall Page And Login    test    password
    Set Window Size    ${1440}    ${900}
    Admin Wemall - Open Manage User And Select Role    png
    Admin Wemall - Verify User Information And Role Header
    [Teardown]    Close Browser

TC_ITMWM_05191 Manage merchant role - manage role - Dropdown List Show Merchant Code After Merchant Name
    [Tags]    manage    TC_ITMWM_05191
    [Setup]    Admin Wemall - Create Prepare Data
    Admin Wemall - Open Admin Wemall Page And Login    test    password
    Set Window Size    ${1440}    ${900}
    Admin Wemall - Open Manage User And Select Role    png
    Admin Wemall - Verify Shop List On Manage Role
    [Teardown]    Close Browser

TC_ITMWM_05192 Manage merchant user - User list page - User list page show shop merchant name column
    [Tags]    manageuser    TC_ITMWM_05192
    [Setup]    Admin Wemall - Create Prepare Data
    Admin Wemall - Open Admin Wemall Page And Login    test    password
    Wait Until Element Is Visible            ${button_create_user}    30s
    Wait Until Element Is Visible            jquery=#userDatatable tbody

    ${alreadyExists}=    Run Keyword And Return Status    Admin Wemall List - Find User By Username Shop In List    ${hulk01InAllRobot.username}    ${hulk01InAllRobot.shop}
    Should Be True    ${alreadyExists}

    ${alreadyExists}=    Run Keyword And Return Status    Admin Wemall List - Find User By Username Shop In List    ${hulk02InHulkRobot.username}    ${hulk02InHulkRobot.shop}
    Should Be True    ${alreadyExists}
    [Teardown]    Close Browser

TC_ITMWM_05193 Manage merchant user - User list page - User list page filter user by merchant name
    [Tags]    manageuser    TC_ITMWM_05193
    [Setup]    Admin Wemall - Create Prepare Data
    Admin Wemall - Open Admin Wemall Page And Login    test    password
    Wait Until Element Is Visible            ${button_create_user}    30s
    Wait Until Element Is Visible            jquery=#userDatatable tbody

    Admin Wemall List - Search User by Shop    ${hulk02InHulkRobot.shop}
    Sleep    10s
    Admin Wemall List - Find User By Username Shop In List    ${hulk02InHulkRobot.username}    ${hulk02InHulkRobot.shop}

    Admin Wemall List - Search User by Shop    ${hulk01InAllRobot.shop}
    Sleep    10s
    Admin Wemall List - Find User By Username Shop In List    ${hulk01InAllRobot.username}    ${hulk01InAllRobot.shop}
    [Teardown]    Close Browser

*** Keywords ***
Admin Wemall - Create Prepare Data
    Admin Wemall - Open Admin Wemall Page And Login    test    password
    Wait Until Element Is Visible            ${button_create_user}    30s
    Wait Until Element Is Visible            jquery=#userDatatable tbody

    ${alreadyExists}=    Run Keyword And Return Status    Admin Wemall List - Find User By Username Shop In List    ${hulk01InAllRobot.username}    ${hulk01InAllRobot.shop}
    Run Keyword If    '${alreadyExists}'=='${FALSE}'    Admin Wemall - Create User And Assign Shop Role    ${hulk01InAllRobot.username}    ${hulk01InAllRobot.password}    ${hulk01InAllRobot.passwordconfirm}    ${hulk01InAllRobot.firstname}    ${hulk01InAllRobot.lastname}    ${hulk01InAllRobot.email}    ${hulk01InAllRobot.shop}    ${hulk01InAllRobot.role}

    ${alreadyExists}=    Run Keyword And Return Status    Admin Wemall List - Find User By Username Shop In List    ${hulk02InHulkRobot.username}    ${hulk02InHulkRobot.shop}
    Run Keyword If    '${alreadyExists}'=='${FALSE}'    Admin Wemall - Create User And Assign Shop Role    ${hulk02InHulkRobot.username}    ${hulk02InHulkRobot.password}    ${hulk02InHulkRobot.passwordconfirm}    ${hulk02InHulkRobot.firstname}    ${hulk02InHulkRobot.lastname}    ${hulk02InHulkRobot.email}    ${hulk02InHulkRobot.shop}    ${hulk02InHulkRobot.role}

    ${alreadyExists}=    Run Keyword And Return Status    Admin Wemall List - Find User By Username Shop In List    ${pngpingInAllRobot.username}    ${pngpingInAllRobot.shop}
    Run Keyword If    '${alreadyExists}'=='${FALSE}'    Admin Wemall - Create User And Assign Shop Role    ${pngpingInAllRobot.username}    ${pngpingInAllRobot.password}    ${pngpingInAllRobot.passwordconfirm}    ${pngpingInAllRobot.firstname}    ${pngpingInAllRobot.lastname}    ${pngpingInAllRobot.email}    ${pngpingInAllRobot.shop}    ${pngpingInAllRobot.role}

    Close Browser
