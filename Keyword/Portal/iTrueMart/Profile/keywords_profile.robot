*** Settings ***
Library             String
Library             Selenium2Library




*** Keywords ***

Should Display Avatar
    [Arguments]     ${src}
    Wait Until Element Is Visible  xpath=//*[@src=${src}]     10s      Display Avatar not found

Get Avatar
    [Arguments]     ${index}
    Go To   ${ITM_URL}/test/user
    Wait Until Element Is Visible   //i[1]
    ${av}=   Get Text   //i[${index}]
    # Log to console   ${av}
    [Return]   ${av}
    # ${idx}=   Set Variable If   ${group} == "guest"   2   3
    # ${user_type}=   Set Variable If   ${group} == "guest"   non-user   user
    # ${user_id}=   Get Text   //i[${idx}]
    # ${user_id}=   Remove String   ${user_id}   "
    # Set Test Variable   ${TV_user_type}   ${user_type}
    # Set Test Variable   ${TV_user_id}   ${user_id}
    # Set Test Variable   ${TV_user_group}   ${group}
    # Log to console   user_id=${TV_user_id}
