*** Settings ***
Force Tags        WLS_API_CAMP
Resource          ../../Resource/Config/stark/camps_libs_resources.robot

*** Test Cases ***
TC_CAMPS_00112 When Get AppId should return AppId list correctly
    [Tags]    TC_CAMPS_00112    ready    Regression    WLS_High
    ${response}=    Get AppID via API
    Status Code and Message Should Be Equal    ${response}    200    success
    Verify AppID Data    ${response}
