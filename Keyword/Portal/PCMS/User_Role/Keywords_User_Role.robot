*** Settings ***
Library           Selenium2Library
Library           ${CURDIR}/../../../../Python_Library/DatabaseData.py

*** Variables ***
${element_search}    //input[@aria-controls="datatables_admin_default"]
${element_user_email}    //input[@name="email"]
${element_user_display_name}    //input[@name="display_name"]
${element_user_password}    //input[@name="password"]
${element_user_password2}    //input[@name="password2"]
${element_user_role}    //select[@name="group"]
${element_check_role_group}    //td[@class="sorting_1 center"]
${element_sorting_1_table_center}    //td[@class="sorting_1 table-center"]
${element_check_role_group_name}    //input[@name="name"]
${element_alert_error}    //div[@class="alert error"]
${element_alert_success}    //div[@class="alert success"]

*** Keywords ***
PCMS Check User
    [Arguments]    ${email}
    GO TO    ${PCMS_URL}/users/index
    Wait Until Element Is Visible    ${element_search}    30s
    Input Text    ${element_search}    ${email}
    ${count_status}=    Get Matching Xpath Count    ${element_sorting_1_table_center}
    Log To Console    ${count_status}

PCMS Created User
    [Arguments]    ${email}    ${display_name}    ${password}    ${group_name}
    Clear User By Email    ${email}
    GO TO    ${PCMS_URL}/users/create
    Wait Until Element Is Visible    ${element_user_email}    30s
    ${group_element}=    Set Variable    ${element_user_role}/option
    ${count_group_list}=    Get Matching Xpath Count    ${group_element}
    ${count}=    Convert To Integer    ${count_group_list}
    Input Text    ${element_user_email}    ${email}
    Input Text    ${element_user_display_name}    ${display_name}
    Input Text    ${element_user_password}    ${password}
    Input Text    ${element_user_password2}    ${password}
    Select From List By Label    ${element_user_role}    ${group_name}
    Click Element    //*[@type="submit"]
    Wait Until Element Is Visible    ${element_alert_success}    30s

PCMS Created User Role
    [Arguments]    ${group_name}
    Clear User Role By Name    ${group_name}
    Go To    ${PCMS_URL}/roles/index
    Wait Until Element Is Visible    ${element_search}    30s
    Input Text    ${element_search}    ${group_name}
    ${count_role_group}=    Get Matching Xpath Count    ${element_check_role_group}
    Run Keyword If    ${count_role_group} == 0    Run Keywords    Go To    ${PCMS_URL}/roles/create
    ...    AND    Wait Until Element Is Visible    ${element_check_role_group_name}    30s
    ...    AND    Input Text    ${element_check_role_group_name}    ${group_name}
    ...    AND    Click Element    //*[@type="submit"]
    Sleep    5
    Wait Until Element Is Visible    ${element_alert_success}    30s

PCMS Set Permission In Role
    [Arguments]    ${group_name}    @{role_permission}
    Go To    ${PCMS_URL}/roles/index
    Wait Until Element Is Visible    ${element_search}    30s
    Input Text    ${element_search}    ${group_name}
    ${count_role_group}=    Get Matching Xpath Count    ${element_check_role_group}
    Run Keyword If    ${count_role_group} == 1    Run Keywords    Click Element    //a[@class="btn btn-warning btn-small"]
    ...    AND    Wait Until Element Is Visible    ${element_check_role_group_name}    30s
    : FOR    ${PERMISSION}    IN    @{role_permission}
    \    Log To Console    Round ${PERMISSION}
    \    Wait Until Element Is Visible    //select[@name="${PERMISSION}"]    30s
    \    Select From List By Value    //select[@name="${PERMISSION}"]    1
    Click Element    //*[@type="submit"]
    Wait Until Element Is Visible    ${element_alert_success}    30s

PCMS Unset Permission In Role
    [Arguments]    ${group_name}    @{role_permission}
    Go To    ${PCMS_URL}/roles/index
    Wait Until Element Is Visible    ${element_search}    30s
    Input Text    ${element_search}    ${group_name}
    ${count_role_group}=    Get Matching Xpath Count    ${element_check_role_group}
    Run Keyword If    ${count_role_group} == 1    Run Keywords    Click Element    //a[@class="btn btn-warning btn-small"]
    ...    AND    Wait Until Element Is Visible    ${element_check_role_group_name}    30s
    : FOR    ${PERMISSION}    IN    @{role_permission}
    \    Log To Console    Round ${PERMISSION}
    \    Wait Until Element Is Visible    //select[@name="${PERMISSION}"]    30s
    \    Select From List By Value    //select[@name="${PERMISSION}"]    0
    Click Element    //*[@type="submit"]
    Wait Until Element Is Visible    ${element_alert_success}    30s

PCMS Set Permission For User
    [Arguments]    ${email}    @{role_permission}
    Go To    ${PCMS_URL}/users/index
    Wait Until Element Is Visible    ${element_search}    30s
    Input Text    ${element_search}    ${email}
    ${count_user}=    Get Matching Xpath Count    ${element_sorting_1_table_center}
    Wait Until Element Is Visible    //a[@class="btn btn-info btn-small"]    30s
    Run Keyword If    ${count_user} == 1    Run Keywords    Click Element    //a[@class="btn btn-info btn-small"]
    ...    AND    Wait Until Element Is Visible    ${element_user_email}    30s
    : FOR    ${PERMISSION}    IN    @{role_permission}
    \    Log To Console    Round ${PERMISSION}
    \    Wait Until Element Is Visible    //select[@name="${PERMISSION}"]    30s
    \    Select From List By Value    //select[@name="${PERMISSION}"]    1
    Click Element    //*[@type="submit"]
    Wait Until Element Is Visible    ${element_alert_success}    30s

PCMS Unset Permission For User
    [Arguments]    ${email}    @{role_permission}
    Go To    ${PCMS_URL}/users/index
    Wait Until Element Is Visible    ${element_search}    30s
    Input Text    ${element_search}    ${email}
    ${count_user}=    Get Matching Xpath Count    ${element_sorting_1_table_center}
    Wait Until Element Is Visible    //a[@class="btn btn-info btn-small"]    30s
    Run Keyword If    ${count_user} == 1    Run Keywords    Click Element    //a[@class="btn btn-info btn-small"]
    ...    AND    Wait Until Element Is Visible    ${element_user_email}    30s
    : FOR    ${PERMISSION}    IN    @{role_permission}
    \    Log To Console    Round ${PERMISSION}
    \    Wait Until Element Is Visible    //select[@name="${PERMISSION}"]    30s
    \    Select From List By Value    //select[@name="${PERMISSION}"]    -1
    Click Element    //*[@type="submit"]
    Wait Until Element Is Visible    ${element_alert_success}    30s

Clear User By Email
    [Arguments]    ${email}
    Delete User By Email    ${email}

Clear User Role By Name
    [Arguments]    ${role_group}
    Delete User Role By Name    ${role_group}

Get Id User by Email
    [Arguments]    ${email}
    ${id}=    Get User Id By Email    ${email}
    Should Not Be Empty    ${id}
    [Return]    ${id[0]}
