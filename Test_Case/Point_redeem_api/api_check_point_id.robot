*** Settings ***
Library         Selenium2Library
Library         Collections
Library         String
Library         OperatingSystem
Library         HttpLibrary.HTTP

Resource        ${CURDIR}/../../Keyword/Portal/Point_redeem_api/Keywords_point_api.robot
Resource        ${CURDIR}/../../Keyword/API/common/api_keywords.robot
Resource        ${CURDIR}/../../Resource/Config/${ENV}/Env_config.robot
Library         ${CURDIR}/../../Python_Library/DatabaseDataPoint.py

*** Variables ***
${API_KEY}      1464942680
${USER_ID}      5aa4918ceb2d0d3baf9923547582283afc54ae9c6af4cd7e6c6284546ca1faf8
${PARTNER_ID}   1
${api_secret}    95991a646701


*** Test Cases ***
API_Check_Point_ID_001 - To verify that API Check Point by Partner ID return correct point
    [Tags]      TC_ALL          API_Check_Point_ID_001
    Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    HTTP Get Request            ${POINT_API_URL}       http    /v1/point/${API_KEY}/${USER_ID}/${PARTNER_ID}
    ${response}=                Get Response Body
    ${node_data}=    Get Json Value    ${response}    /data
    ${node_data_name}    Point API - Get Data From Json    ${node_data}    /name
    ${node_data_point}    Point API - Get Data From Json    ${node_data}    /point
    Response Status Code Should Equal    200 success
    Should Not Be Empty   ${node_data_name}
    Should Not Be Empty   ${node_data_point}


API_Check_Point_ID_002 - To verify that API Check Point by Partner ID return error message when system send API_Key only
    [Tags]      TC_ALL          API_Check_Point_ID_002
    HTTP Get Request Failed     ${POINT_API_URL}       http    /v1/point/${API_KEY}
    Response Status Code Should Equal    404 Not Found
    ${response}=                Get Response Body
    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    server_not_found
    Point API - Verify Response Error Invalid Input    ${response}    ${json_error}



API_Check_Point_ID_003 - To verify that API Check Point by Partner ID return error message when system send User_ID only
    [Tags]      TC_ALL          API_Check_Point_ID_003
    HTTP Get Request Failed     ${POINT_API_URL}       http    /v1/point/${USER_ID}
    Response Status Code Should Equal    404 Not Found
    ${response}=                Get Response Body
    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    server_not_found
    Point API - Verify Response Error Invalid Input    ${response}    ${json_error}



API_Check_Point_ID_004 - To verify that API Check Point by Partner ID return error message when system send Partner_ID only
    [Tags]      TC_ALL          API_Check_Point_ID_004
    HTTP Get Request Failed     ${POINT_API_URL}       http    /v1/point/${Partner_ID}
    Response Status Code Should Equal    404 Not Found
    ${response}=                Get Response Body
    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    server_not_found
    Point API - Verify Response Error Invalid Input    ${response}    ${json_error}



API_Check_Point_ID_005 - To verify that API Check Point by Partner ID return error message when system donot send API_Key
    [Tags]      TC_ALL          API_Check_Point_ID_005
    HTTP Get Request Failed     ${POINT_API_URL}       http    /v1/point/${USER_ID}/${PARTNER_ID}
    Response Status Code Should Equal    404 Not Found
    ${response}=                Get Response Body
    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    server_not_found
    Point API - Verify Response Error Invalid Input    ${response}    ${json_error}



API_Check_Point_ID_006 - To verify that API Check Point by Partner ID return error message when system donot send User_ID
    [Tags]      TC_ALL          API_Check_Point_ID_006
    HTTP Get Request Failed     ${POINT_API_URL}       http    /v1/point/${USER_ID}/${PARTNER_ID}
    Response Status Code Should Equal    404 Not Found
    ${response}=                Get Response Body
    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    server_not_found
    Point API - Verify Response Error Invalid Input    ${response}    ${json_error}


API_Check_Point_ID_007 - To verify that API Check Point by Partner ID return error message when system send Partner_ID
    [Tags]      TC_ALL          API_Check_Point_ID_007
    HTTP Get Request Failed     ${POINT_API_URL}       http    /v1/point/${API_KEY}/${USER_ID}
    Response Status Code Should Equal    404 Not Found
    ${response}=                Get Response Body
    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    server_not_found
    Point API - Verify Response Error Invalid Input    ${response}    ${json_error}


# Fail
API_Check_Point_ID_008 - To verify that API Check Point by Partner ID return error message when system donot send API_Key, Uer_ID and Partner_ID
    [Tags]      TC_ALL          API_Check_Point_ID_008
    HTTP Get Request Failed     ${POINT_API_URL}       http    /v1/point
    ${response}=                Get Response Body
    Response Status Code Should Equal    404 Not Found
    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    server_not_found
    Point API - Verify Response Error Invalid Input    ${response}    ${json_error}

# fail
API_Check_Point_ID_010 - To verify that API Check Point by Partner ID return error message when system send incorrect request url format
    [Tags]      TC_ALL          API_Check_Point_ID_010
    HTTP Get Request Failed     ${POINT_API_URL}       http    /v1/point/wrong-api/${API_KEY}/${USER_ID}/${PARTNER_ID}
    Response Status Code Should Equal    404 Not Found
    ${response}=                Get Response Body
    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    server_not_found
    Point API - Verify Response Error Invalid Input    ${response}    ${json_error}


API_Check_Point_ID_011 - To verify that API Check Point by Partner ID return error message when system send incorrect API_Key
    [Tags]      TC_ALL          API_Check_Point_ID_011
    HTTP Get Request Failed     ${POINT_API_URL}       http    /v1/point/-1/${USER_ID}/${PARTNER_ID}
    Response Status Code Should Equal    400
    ${response}=                Get Response Body
    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    invalid_api_key
    Point API - Verify Response Error Invalid Input    ${response}    ${json_error}


API_Check_Point_ID_012 - To verify that API Check Point by Partner ID return error message when system send incorrect User_ID
    [Tags]      TC_ALL          API_Check_Point_ID_012
    HTTP Get Request Failed     ${POINT_API_URL}       http    /v1/point/${API_KEY}/-1/${PARTNER_ID}
    Response Status Code Should Equal    400
    ${response}=                Get Response Body
    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    token_expired
    Point API - Verify Response Error Invalid Input    ${response}    ${json_error}


API_Check_Point_ID_013 - To verify that API Check Point by Partner ID return error message when system send incorrect Partner_ID
    [Tags]      TC_ALL          API_Check_Point_ID_013
    HTTP Get Request Failed     ${POINT_API_URL}       http    /v1/point/${API_KEY}/${USER_ID}/9999
    Response Status Code Should Equal    400
    ${response}=                Get Response Body
    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    token_expired
    Point API - Verify Response Error Invalid Input    ${response}    ${json_error}