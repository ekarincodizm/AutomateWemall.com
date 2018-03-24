*** Settings ***
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Register_Page/Keywords_RegisterPage.robot

*** Keywords ***
Register TrueID
    [Arguments]    ${Text_Username}    ${Text_Displayname}    ${Text_Password}    ${Text_ConfirmPassword}
    Go to register page
    Click Register TrueID user on LoginPage
    Enter Register information    ${Text_Username}    ${Text_Displayname}    ${Text_Password}    ${Text_ConfirmPassword}
    Check on aeccept criteria checkbok
    Click submit registration
