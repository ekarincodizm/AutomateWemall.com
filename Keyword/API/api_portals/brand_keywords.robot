*** Settings ***
Library         HttpLibrary.HTTP
Resource        ${CURDIR}/../common/api_keywords.robot
Resource        ${CURDIR}/showrooms_keywords.robot

*** Keywords ***
############ Prepare Data ############
Prepare Brand Data For Suite Get
    [Arguments]    ${showroomId}
    Put Brands Showroom Data    ${showroomId}    ${DRAFT}
    Response Status Code Should Equal    200 OK
    Put Brands Showroom Data    ${showroomId}    ${PUBLISHED}
    Response Status Code Should Equal    200 OK

############ Get ############
Get Brands Showroom Data
    [Arguments]    ${showroomId}    ${version}
    HTTP Get Request    ${PORTAL_API}    http    ${SHOWROOMS}${showroomId}/brand/${version}

Send Wrong GET Request
    HTTP Get Request Failed    ${PORTAL_API}    http    ${SHOWROOMS}wrong_URL

############ Put ############
Send Put with Empty Body Data
    [Arguments]    ${showroomId}    ${version}
    HTTP Put Request Failed    ${PORTAL_API}    http    ${SHOWROOMS}${showroomId}/brand/${version}    ${EMPTY}

Put Brands Showroom Data
    [Arguments]    ${showroomId}    ${version}
    HTTP Put Request    ${PORTAL_API}    http    ${SHOWROOMS}${showroomId}/brand/${version}    ${REQUEST-BODY}

############ Verify ############
Check Response Body For Brands Showroom Data
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




