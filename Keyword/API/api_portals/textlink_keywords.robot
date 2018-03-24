*** Settings ***
Library        HttpLibrary.HTTP
Resource        ${CURDIR}/../common/api_keywords.robot
Resource        ${CURDIR}/showrooms_keywords.robot

*** Variables ***
${DRAFT}            draft
${PUBLISHED}        published

*** Keywords ***
############ Prepare Data ############
Prepare Text Link Data For Suite Get
    [Arguments]    ${showroomId}
    Put Text Links Showroom Data    ${showroomId}    ${DRAFT}
    Response Status Code Should Equal    200 OK
    Put Text Links Showroom Data    ${showroomId}    ${PUBLISHED}
    Response Status Code Should Equal    200 OK

############ Get ############
Get Text Links Showroom Data
    [Arguments]    ${showroomId}    ${version}
    HTTP Get Request    ${PORTAL_API}    http    ${SHOWROOMS}${showroomId}/text-link/${version}

Send Wrong GET Request
    HTTP Get Request Failed    ${PORTAL_API}    http    ${SHOWROOMS}wrong_URL

############ Put ############
Put Text Links Showroom Data
    [Arguments]    ${showroomId}    ${version}
    HTTP Put Request    ${PORTAL_API}    http    ${SHOWROOMS}${showroomId}/text-link/${version}    ${REQUEST-BODY}

Send PUT with Empty Body Data
    [Arguments]    ${showroomId}    ${version}
    HTTP Put Request Failed    ${PORTAL_API}    http    ${SHOWROOMS}${showroomId}/text-link/${version}    ${EMPTY}

############ Verify ############
Check Response Body For Text Links Showroom Data
    Response Status Code Should Equal    200 OK
    ${response_body}=    Get Response Body
    Verify Data is Not Empty    ${response_body}
    Verify Message in Response    ${response_body}    OK

Check Response Success But Data Null
    Verify Response Success but Data Empty    null

Check Update Failed Because Empty Body Data
    Response Status Code Should Equal    400 Bad Request
    ${response_body}=     Get Response Body
    Verify Message in Response    ${response_body}    require json-input


