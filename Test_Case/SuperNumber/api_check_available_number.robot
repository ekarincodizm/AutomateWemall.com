*** Settings ***
Force Tags     WLS_Supernumber     WLS_High
Library     Selenium2Library
Library     HttpLibrary.HTTP
Library     Collections
Library     requests
Library     String

Resource    ${CURDIR}/../../Resource/init.robot
Resource    ${CURDIR}/../../Keyword/API/api_super_number/keyword_super_number_common.robot
Resource    ${CURDIR}/../../Keyword/Database/PCMS/Truemove_h/keywords_truemove_h.robot


*** Test Cases ***

TC_ITMWM_07493 To verify that api check available number return correct data(active) and response code if status of mobile number is available.
    [Tags]    TC_ITMWM_07493    regression    ready
    ${hold_expired}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=-5hours

    Add TruemoveH Mobile    ${MOBILE_NUMBER}    4    ${hold_expired}    ${USED_N}    ${STATUS_Y}

    ${url_path}=    Set Variable    /mobile-number/check/${API_KEY}/${MOBILE_NUMBER}
    ${result}=    SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_200}

    SuperNumber - Verify Response Check Available Number Success    ${result}    ${STATUS_ACTIVE}    ${hold_expired}

    [Teardown]      Delete TruemoveH Mobile    ${MOBILE_NUMBER}

TC_ITMWM_07494 To verify that api check available number return correct data(inactive) and response code if status of mobile number is available but inactive
    [Tags]    ITMB-2099-3    ready
    ${hold_expired}=    Set Variable    null

    Add TruemoveH Mobile    ${MOBILE_NUMBER}    4    ${hold_expired}    ${USED_N}    ${STATUS_N}

    ${url_path}=    Set Variable    /mobile-number/check/${API_KEY}/${MOBILE_NUMBER}
    ${result}=    SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_200}

    SuperNumber - Verify Response Check Available Number Success Expired is null   ${result}    ${STATUS_INACTIVE}    ${hold_expired}

    ${hold_expired}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=+5hours

    Add TruemoveH Mobile    ${MOBILE_NUMBER}    4    ${hold_expired}    ${USED_N}    ${STATUS_N}

    ${url_path}=    Set Variable    /mobile-number/check/${API_KEY}/${MOBILE_NUMBER}
    ${result}=    SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_200}

    SuperNumber - Verify Response Check Available Number Success   ${result}    ${STATUS_INACTIVE}    ${hold_expired}

    [Teardown]      Delete TruemoveH Mobile    ${MOBILE_NUMBER}


TC_ITMWM_07495 To verify that api check available number return correct status(hold) and correct expired date if status of mobile number is in holding state.
    [Tags]    TC_ITMWM_07495     regression    ready
    ${hold_expired}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=+5hours

    Add TruemoveH Mobile    ${MOBILE_NUMBER}    4    ${hold_expired}    ${USED_N}    ${STATUS_Y}

    ${url_path}=    Set Variable    /mobile-number/check/${API_KEY}/${MOBILE_NUMBER}
    ${result}=    SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_200}

    SuperNumber - Verify Response Check Available Number Success    ${result}    ${STATUS_HOLD}    ${hold_expired}

    [Teardown]      Delete TruemoveH Mobile    ${MOBILE_NUMBER}

TC_ITMWM_07496 To verify that api check available number return sold status if mobile number is marked used = Y and hold expired date is more than now = 1 day.
    [Tags]    TC_ITMWM_07496    regression    ready
    ${hold_expired}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=-5days

    Add TruemoveH Mobile    ${MOBILE_NUMBER}    4    ${hold_expired}    ${USED_Y}    ${STATUS_Y}

    ${url_path}=    Set Variable    /mobile-number/check/${API_KEY}/${MOBILE_NUMBER}
    ${result}=    SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_200}

    SuperNumber - Verify Response Check Available Number Success    ${result}    ${STATUS_SOLD}    ${hold_expired}

    [Teardown]      Delete TruemoveH Mobile    ${MOBILE_NUMBER}

TC_ITMWM_07497 To verify that api check available number return error response if send api with invalid api key
    [Tags]    TC_ITMWM_07497    regression    ready
    ${hold_expired}=    Set Variable    null

    Add TruemoveH Mobile    ${MOBILE_NUMBER}    4    ${hold_expired}    ${USED_N}    ${STATUS_Y}

    ${url_path}=    Set Variable    /mobile-number/check/${API_KEY_INVALID}/${MOBILE_NUMBER}
    ${result}=    SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_404}

    SuperNumber - Verify Response Fail   ${result}    ${ERROR_CODE_WMM4001}    ${ERROR_MESSAGE_WMM4001}

    ${url_path}=    Set Variable    /mobile-number/check/${API_KEY_NOT_EXIST}/${MOBILE_NUMBER}
    ${result}=    SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_404}

    SuperNumber - Verify Response Fail   ${result}    ${ERROR_CODE_WMM4001}    ${ERROR_MESSAGE_WMM4001}

    [Teardown]      Delete TruemoveH Mobile    ${MOBILE_NUMBER}

TC_ITMWM_07498 To verify that api check available number return error response if send api with invalid mobile number
    [Tags]    TC_ITMWM_07498     regression   ready
    ${hold_expired}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=-5hours

    Add TruemoveH Mobile    ${MOBILE_NUMBER}    4    ${hold_expired}    ${USED_N}    ${STATUS_Y}

    ${url_path}=    Set Variable    /mobile-number/check/${API_KEY}/${MOBILE_NUMBER_INVALID}
    ${result}=    SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_404}

    SuperNumber - Verify Response Fail   ${result}    ${ERROR_CODE_WMM4002}    ${ERROR_MESSAGE_WMM4002}

    [Teardown]      Delete TruemoveH Mobile    ${MOBILE_NUMBER}

TC_ITMWM_07499 To verify that api check available number return error response if send api with mobile number that not exist in system
    [Tags]    TC_ITMWM_07499    regression    ready

    Delete TruemoveH Mobile    ${MOBILE_NUMBER}

    ${url_path}=    Set Variable    /mobile-number/check/${API_KEY}/${MOBILE_NUMBER}
    ${result}=    SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_404}

    SuperNumber - Verify Response Fail   ${result}    ${ERROR_CODE_WMM4003}    ${ERROR_MESSAGE_WMM4003}

    [Teardown]      Delete TruemoveH Mobile    ${MOBILE_NUMBER}

TC_ITMWM_07500 To verify that api check available number return error response if send api without mobile number
    [Tags]    TC_ITMWM_07500    regression    ready
    ${hold_expired}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=-5days

    Add TruemoveH Mobile    ${MOBILE_NUMBER}    4    ${hold_expired}    ${USED_Y}    ${STATUS_N}

    ${value} =  Get Variable Value  ${SP_ENV_PCMS}
    Log To Console    value = ${value}
    ${RESULT_HEADER}=    Run Keyword If    '${value}' == 'None'    Set Variable    403
    ...    ELSE    Set Variable    ${RESULT_HEADER_404}
    ${message}=    Run Keyword If    '${value}' == 'None'    Set Variable    Missing Authentication Token
    ...    ELSE    Set Variable    404 NOT FOUND

    ${url_path}=    Set Variable    /mobile-number/check/${API_KEY}
    ${result}=    SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER}

    Should Contain    ${result}    ${message}

    [Teardown]      Delete TruemoveH Mobile    ${MOBILE_NUMBER}

TC_ITMWM_07502 To verify that if status of mobile number = W, api check available number will return as not found
    [Tags]    TC_ITMWM_07502    regression    ready
    ${hold_expired}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=-5days

    Add TruemoveH Mobile    ${MOBILE_NUMBER}    4    ${hold_expired}    ${USED_Y}    ${STATUS_W}

    ${url_path}=    Set Variable    /mobile-number/check/${API_KEY}/${MOBILE_NUMBER}
    ${result}=    SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_404}

    SuperNumber - Verify Response Fail   ${result}    ${ERROR_CODE_WMM4003}    ${ERROR_MESSAGE_WMM4003}

    [Teardown]      Delete TruemoveH Mobile    ${MOBILE_NUMBER}

TC_ITMWM_07503 To verify that api check available number return as not found if send api with api key that exist in system but does not match with mobile type
    [Tags]    TC_ITMWM_07503    regression    ready
    ${hold_expired}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=-5days

    Add TruemoveH Mobile    ${MOBILE_NUMBER}    100000    ${hold_expired}    ${USED_N}    ${STATUS_Y}

    ${url_path}=    Set Variable    /mobile-number/check/${API_KEY}/${MOBILE_NUMBER}
    ${result}=    SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_404}

    SuperNumber - Verify Response Fail   ${result}    ${ERROR_CODE_WMM4003}    ${ERROR_MESSAGE_WMM4003}

    [Teardown]      Delete TruemoveH Mobile    ${MOBILE_NUMBER}

TC_ITMWM_07504 To verify that api check available number return sold status if mobile number is marked used = N but hold expired date is more than now = 1 day.
    [Tags]    TC_ITMWM_07504     regression    ready
    ${hold_expired}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=+2days

    Add TruemoveH Mobile    ${MOBILE_NUMBER}    4    ${hold_expired}    ${USED_N}    ${STATUS_Y}

    ${url_path}=    Set Variable    /mobile-number/check/${API_KEY}/${MOBILE_NUMBER}
    ${result}=    SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_200}

    SuperNumber - Verify Response Check Available Number Success    ${result}    ${STATUS_SOLD}    ${hold_expired}

    [Teardown]      Delete TruemoveH Mobile    ${MOBILE_NUMBER}

TC_ITMWM_07505 To verify that api check available number return inactive status if mobile number is not sold but expired
    [Tags]    TC_ITMWM_07505     regression    ready
    ${hold_expired}=    Set Variable    null
    ${expired_date}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=-5days

    Add TruemoveH Mobile    ${MOBILE_NUMBER}    4    ${hold_expired}    ${USED_N}    ${STATUS_Y}    ${expired_date}

    ${url_path}=    Set Variable    /mobile-number/check/${API_KEY}/${MOBILE_NUMBER}
    ${result}=    SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_200}

    SuperNumber - Verify Response Check Available Number Success Expired is null   ${result}    ${STATUS_INACTIVE}    ${hold_expired}

    [Teardown]      Delete TruemoveH Mobile    ${MOBILE_NUMBER}

TC_ITMWM_07506 To verify that api check available number return sold status if mobile number is already sold but expired date is less than now.
    [Tags]    TC_ITMWM_07506     regression    ready
    ${hold_expired}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=+2days
    ${expired_date}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=-5days

    Add TruemoveH Mobile    ${MOBILE_NUMBER}    4    ${hold_expired}    ${USED_N}    ${STATUS_Y}    ${expired_date}

    ${url_path}=    Set Variable    /mobile-number/check/${API_KEY}/${MOBILE_NUMBER}
    ${result}=    SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_200}

    SuperNumber - Verify Response Check Available Number Success    ${result}    ${STATUS_SOLD}    ${hold_expired}

    Delete TruemoveH Mobile    ${MOBILE_NUMBER}

    Add TruemoveH Mobile    ${MOBILE_NUMBER}    4    ${hold_expired}    ${USED_N}    ${STATUS_N}    ${expired_date}

    ${result}=    SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_200}

    SuperNumber - Verify Response Check Available Number Success    ${result}    ${STATUS_SOLD}    ${hold_expired}

    [Teardown]      Delete TruemoveH Mobile    ${MOBILE_NUMBER}

TC_ITMWM_07507 To verify that api check available number return hold status if mobile number is held but expired date is less than now.
    [Tags]    TC_ITMWM_07507    regression    ready
    ${hold_expired}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=+5hours
    ${expired_date}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=-5days

    Add TruemoveH Mobile    ${MOBILE_NUMBER}    4    ${hold_expired}    ${USED_N}    ${STATUS_Y}    ${expired_date}

    ${url_path}=    Set Variable    /mobile-number/check/${API_KEY}/${MOBILE_NUMBER}
    ${result}=    SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_200}

    SuperNumber - Verify Response Check Available Number Success    ${result}    ${STATUS_HOLD}    ${hold_expired}

    [Teardown]      Delete TruemoveH Mobile    ${MOBILE_NUMBER}

