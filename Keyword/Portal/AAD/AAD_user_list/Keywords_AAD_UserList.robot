*** Settings ***
Library           Selenium2Library
Library           String
Resource          ../../../../Resource/Env_config.robot
Resource          ../../../../Resource/WebElement/ADD/User_List.robot
Resource          ../../../Common/Keywords_Common.robot
Resource          WebElement_AAD_UserList.robot

*** Keywords ***
AAD User list - select user to edit by User ID
    [Arguments]    ${user_id}
    ${user_id}=    Convert To String    ${user_id}
    ${element_edit_bttn_by_UseID}=    Replace String    ${edit_bttn_by_UseID}    REPLACE_ME    ${user_id}
    Sleep    5
    Wait Until Page Contains Element    ${element_edit_bttn_by_UseID}    30
    Focus    ${element_edit_bttn_by_UseID}
    Wait Until Element is ready and click    ${element_edit_bttn_by_UseID}    30
