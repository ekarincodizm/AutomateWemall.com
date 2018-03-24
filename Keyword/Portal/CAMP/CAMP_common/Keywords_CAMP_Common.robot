*** Settings ***
Library           Collections
Library           RequestsLibrary
Library           DateTime
Resource          ../../../../Resource/Env_config.robot
Library           DatabaseLibrary
Resource          ../../../Common/Keywords_Common.robot
Resource          WebElement_CAMP_Common.robot

*** Variables ***

*** Keywords ***
Delete Campaign
    [Arguments]    ${campaign_id}
    ${tokens}=    Get access token
    ${access_token}    Get From List    ${tokens}    0
    ${refresh_token}    Get From List    ${tokens}    1
    ${response}    CAMP DELETE /cmp/v1/itm/campaigns/campaign_id    ${campaign_id}    ${access_token}    ${refresh_token}
    Verify return code and return message    ${response}    ${200}    success

CAMP DELETE /cmp/v1/itm/campaigns/campaign_id
    [Arguments]    ${campaign_id}    ${access_token}    ${refresh_token}
    ${header}=    Create Dictionary    x-wm-accessToken=${access_token}
    Set To Dictionary    ${header}    x-wm-refreshToken    ${refresh_token}
    Create Session    Http DELETE    ${API_GATEWAY}    headers=${header}
    ${response}=    Delete Request    Http DELETE    /cmp/v1/itm/campaigns/${campaign_id}
    [Return]    ${response}

Input Date Time Information
    [Arguments]    ${start_date}    ${end_date}
    Click Element    ${PERIOD-FIELD}
    Wait Until Element Is Visible    ${DATETIME-MENU}
    Input Date Time for Period    ${start_date}    0    00    ${end_date}    0    00
    Click button    ${DATETIME-APPLY}

Live Status Should Be Equal
    [Arguments]    ${table}    ${expected_live}    ${col}    ${row}=1
    ${live_status}=    Get Live Status    ${table}    ${col}    ${row}
    List Should Contain Value    ${expected_live}    ${live_status}

Live Status Should Not Be Equal
    [Arguments]    ${table}    ${expected_live}    ${col}    ${row}=1
    ${live_status}=    Get Live Status    ${table}    ${col}    ${row}
    List Should Not Contain Value    ${expected_live}    ${live_status}

Live Staus on Current page should be Equal
    [Arguments]    ${table_name}    ${col}    ${expected_status}
    ${row_count}=    Get Row Count    ${table_name}
    : FOR    ${index}    IN RANGE    1    ${row_count}+1
    \    Live Status Should Be Equal    ${table_name}    ${expected_status}    ${col}    ${index}

Live Staus on Current page should not be Equal
    [Arguments]    ${table_name}    ${col}    ${expected_status}
    ${row_count}=    Get Row Count    ${table_name}
    : FOR    ${index}    IN RANGE    1    ${row_count}+1
    \    Live Status Should Not Be Equal    ${table_name}    ${expected_status}    ${col}    ${index}

Get Live Status
    [Arguments]    ${table}    ${col}    ${row}=1
    ${color}=    Selenium2Library.Get Element Attribute    //table[@id='${table}']/tbody/tr[${row}]/td[${col}]/div/i@style
    ${is_green}=    Run Keyword And Return Status    Should Contain    ${color}    color: green
    ${is_orange}=    Run Keyword And Return Status    Should Contain    ${color}    color: orange
    ${is_red}=    Run Keyword And Return Status    Should Contain    ${color}    color: red
    ${is_grey}=    Run Keyword And Return Status    Should Contain    ${color}    color: grey
    ${live_status}    Set Variable If    ${is_green}    LIVE    ${is_orange}    ENABLED    ${is_red}
    ...    DISABLED    ${is_grey}    EXPIRED
    Return From Keyword    ${live_status}
