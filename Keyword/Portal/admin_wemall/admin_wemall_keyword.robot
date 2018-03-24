*** Settings ***


*** Variables ***

*** Keywords ***

Admin Wemall - Open Admin Wemall Page And Login
    [Arguments]     ${username}    ${password}
    Open Browser    ${ADMIN_WEMALL}    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    ${button_login_admin_wemall}
    Input Text    ${input_username_login}       ${username}
    Input Password    ${input_password_login}       ${password}
    Click Element    ${button_login_admin_wemall}

Admin Wemall - Input Username
    [Arguments]    ${username}
    Input Text      ${input_username_user_create}       ${username}
    Wait Until Page Contains Element    jquery=a:contains("User Information")
    CLick Element       jquery=a:contains("User Information")

Admin Wemall - Input Password
    [Arguments]     ${password}
    Input Password      ${input_password_user_create}       ${password}
    Wait Until Page Contains Element    jquery=a:contains("User Information")
    CLick Element       jquery=a:contains("User Information")

Admin Wemall - Input RePassword
    [Arguments]     ${re_password}
    Input Password      ${input_repassword_user_create}       ${re_password}
    Wait Until Page Contains Element    jquery=a:contains("User Information")
    CLick Element       jquery=a:contains("User Information")

Admin Wemall - Input Email
    [Arguments]    ${email}
    Input Text     ${input_email_user_create}       ${email}
    Wait Until Page Contains Element    jquery=a:contains("User Information")
    CLick Element       jquery=a:contains("User Information")

Admin Wemall - Input First Name
    [Arguments]    ${first_name}
    Input Text     ${input_first_name_user_create}       ${first_name}
    Wait Until Page Contains Element    jquery=a:contains("User Information")
    CLick Element       jquery=a:contains("User Information")

Admin Wemall - Input Lastname Name
    [Arguments]    ${last_name}
    Input Text     ${input_last_name_user_create}       ${last_name}
    Wait Until Page Contains Element    jquery=a:contains("User Information")
    CLick Element       jquery=a:contains("User Information")

Admin Wemall - Input Search Username
    [Arguments]    ${username}
    Input Text     ${input_username}       ${username}
    Wait Until Page Contains Element        jquery=#searchBtn
    CLick Element       jquery=#searchBtn

Admin Wemall - Add New User
    [Arguments]         ${username}    ${password}    ${repassword}   ${firstname}    ${lastname}     ${email}
    Wait Until Page Contains Element            ${button_create_user}
    Wait Until Element Is Not Visible    ${user_list_loading}    30
    Wait Until Element Is Visible    ${button_create_user}
    Click Element       ${button_create_user}
    Wait Until Element Is Visible    ${tab_userinfo_active}
    Admin Wemall - Input Username       ${username}
    Admin Wemall - Input First Name     ${firstname}
    Admin Wemall - Input Lastname Name     ${lastname}
    Admin Wemall - Input Email         ${email}
    Admin Wemall - Input Password       ${password}
    Admin Wemall - Input RePassword     ${repassword}
    CLick Element       jquery=a:contains("User Information")

Admin Wemall - Save User Information
    Wait Until Element Is Visible    ${button_save_and_next}    30
    Click Element       ${button_save_and_next}

Admin Wemall - Verify Add User Success
    [Arguments]         ${date_time}
    Wait Until Page Contains Element    ${role_search_button}
    ${active_class}=        Selenium2Library.Get Element Attribute       ${role_tab}
    Should Be Equal	     ${active_class}    active
    Admin Wemall - Click User List Menu
    Wait Until Page Contains Element            ${button_create_user}
    sleep  5s
    Page Should Contain Element             jquery=td:contains("${date_time}")

Admin Wemall - Click User List Menu
    Click Element    ${user_list_menu_button}

Admin Wemall - Validate Text
    [Arguments]         ${text_expect}
    sleep   5s
    ${validate_text}=       Get Text      ${invalid_text}
    Should Be Equal      ${validate_text}       ${text_expect}

Admin Wemall - Verify Username
    [Arguments]         ${text_expect}
    ${username_return}=  Get Value    ${input_username_user_create}
    Should Be Equal      ${username_return}       ${text_expect}

Admin Wemall - Verify Password
    [Arguments]         ${text_expect}
    ${password_return}=  Get Value    ${input_password_user_create}
    Should Be Equal      ${password_return}       ${text_expect}

Admin Wemall - Assign Shop Role
    [Arguments]    ${shop}    ${role}
    Input Text    ${role_input_shopName}    ${shop}
    Focus    ${role_search_btn}
    Click Element    ${role_search_btn}
    Wait Until Element Is Visible    xpath=//span/a[text()='${role}']/../../../../..//div[@class='checkbox']//span
    Click Element    xpath=//span/a[text()='${role}']/../../../../..//div[@class='checkbox']//span
    Click Element    ${role_assign_btn}

Admin Wemall - Verify Assign Role Success
    Wait Until Element Is Visible    ${role_msgbox}
    Selenium2Library.Element Text Should Be    ${role_msgbox_header}    Assign user to roles
    Selenium2Library.Element Text Should Be    ${role_msgbox_body}    Successfully

Admin Wemall - Create User And Assign Shop Role
    [Arguments]    ${username_create}    ${password_create}    ${repassword_create}    ${firstname_create}    ${lastname_create}    ${email_create}    ${shop}    ${role}
    Admin Wemall - Add New User    ${username_create}    ${password_create}    ${repassword_create}    ${firstname_create}    ${lastname_create}    ${email_create}
    Admin Wemall - Save User Information
    Wait Until Element Is Visible    ${role_input_shopName}
    Admin Wemall - Assign Shop Role        ${shop}    ${role}
    Admin Wemall - Verify Assign Role Success

Admin Wemall List - Search User by Shop
    [Arguments]    ${shop}
    Input Text    ${user_list_input_shop}    ${shop}
    Focus    ${user_list_search_btn}
    Click Element    ${user_list_search_btn}

Admin Wemall List - Find User By Username Shop In List
    [Arguments]    ${username}    ${shop}
    Element Should Be Visible    xpath=//td[2][text()='${username}']/../td[7][text()='${shop}']

Admin Wemall - Open Manage User And Select Role
    [Arguments]     ${username}
    Wait Until Element Is Not Visible    ${user_list_loading}    30
    Wait Until Element Is Visible    ${button_create_user}
    Admin Wemall - Input Search Username    ${username}
    sleep    5s
    Wait Until Element Is Visible        ${edit_butom_0}
    Click Element    ${edit_butom_0}
    Wait Until Element Is Visible        ${tab_userinfo_active}    30

Admin Wemall - Verify User Information And Role Header
    Wait Until Element Is Visible        ${tab_userinfo_active}    30
    ${user_info}=  Get text    ${username_info}
    ${input_username}=  Get Value    ${input_username_info}
    Should Be Equal      ${user_info}       ${input_username}'s information
    Click Element    ${manage_role_tab}
    Wait Until Element Is Visible        ${tab_role_active}
    ${user_role_info}=  Get text    ${username_info}
    Should Be Equal      ${user_role_info}       ${input_username}'s role

Admin Wemall - Verify Shop List On Manage Role
    Click Element    ${manage_role_tab}
    Wait Until Element Is Visible        ${tab_role_active}
    Click Element      jquery=.search
    ${shop_code_1}     Selenium2Library.Get Element Attribute    jquery=.menu.transition div:eq(0)@data-value
    ${shop_name_1}=    Get Text    jquery=.menu.transition div:eq(0)
    Click Element     jquery=md-autocomplete
    ${shop_code_name}=    Get Text    jquery=md-autocomplete-parent-scope :eq(0)
    Should Be Equal    ${shop_code_name}    ${shop_name_1} (${shop_code_1})


