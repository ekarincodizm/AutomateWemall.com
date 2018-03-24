*** Settings ***
Force Tags        WLS_API_CAMP
Resource          ../../Resource/Config/stark/camps_libs_resources.robot

*** Test Cases ***
TC_CAMPS_01030 When get Flash sale image policy number 1, it should return json correctly
    [Tags]    TC_CAMPS_01030    ready    Regression    WLS_High
    ${policy_number}=    Convert To String    1
    ${status}    ${body}=    Get Flashsale Policy images By Number via API    ${policy_number}
    Response Status Code Should Equal    200
    ${policy}=    Get Json Value    ${body}    /data/policy_number
    Should Be Equal    ${policy}    ${policy_number}

TC_CAMPS_01031 When get non existing Flashsale image policy, it should return http status 404
    [Tags]    TC_CAMPS_01031    ready    Regression    WLS_High
    ${policy_number}=    Convert To String    999
    ${status}    ${body}=    Get Flashsale Policy images By Number via API    ${policy_number}
    Response Status Code Should Equal    404

TC_CAMPS_01032 When get Flash sale image policy with number in string format, it should return http status 400
    [Tags]    TC_CAMPS_01032    ready    Regression    WLS_Medium
    ${policy_number}=    Convert To String    "999"
    ${status}    ${body}=    Get Flashsale Policy images By Number via API    ${policy_number}
    Response Status Code Should Equal    400

TC_CAMPS_01033 When get Flash sale image policy with string, it should return http status 400
    [Tags]    TC_CAMPS_01033    ready    Regression    WLS_Medium
    ${policy_number}=    Convert To String    abc
    ${status}    ${body}=    Get Flashsale Policy images By Number via API    ${policy_number}
    Response Status Code Should Equal    400
