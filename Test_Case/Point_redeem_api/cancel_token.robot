*** Settings ***
Library        Selenium2Library
Resource        ${CURDIR}/../../Resource/init.robot
Resource        ${CURDIR}/../../Keyword/Portal/Point_redeem_api/Keywords_point_api.robot
Resource        ${CURDIR}/../../Keyword/API/common/api_keywords.robot
Library         ${CURDIR}/../../Python_Library/DatabaseDataPoint.py

Library           Collections
Library           String
Library           OperatingSystem
Library           HttpLibrary.HTTP

*** Variable ***
${api_token}    a2603e7ab7cfba512c8e168640cf44
${user_id}    1234
${username}    j_atthapon@hotmail.com
${password}    99999999
${partner_id}    1

${api_key}    Test
${api_secret}    95991a646701

${header_error_code_400}    400

*** Test Cases ***
API Cancel Token_001 - To verify that API Cancel Token return correct User ID
    [Tags]    Cancel_Token_001

    ${request_body}=    Point API - Request Token Success

    ${remove_node} = 	Create List 	user_token    partner_id
    ${request_body_for_cancel}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Delete Request    ${POINT_API_URL_CANCEL_TOKEN}    ${request_body_for_cancel}

    Point API - Verify Response Cancel Token Success    ${response}    ${request_body}

API Cancel Token_002 - To verify that API Cancel Token return error message when system send API_Token node only
    [Tags]    Cancel_Token_002

    ${request_body}=    Point API - Request Token Success

    ${remove_node} = 	Create List 	user_id 	user_token    partner_id
    ${request_body_for_cancel}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Delete Request    ${POINT_API_URL_CANCEL_TOKEN}    ${request_body_for_cancel}    <Response [400]>

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Cancel Token Error    ${response}    ${json_error_expect}    ${request_body}

API Cancel Token_003 - To verify that API Cancel Token return error message when system send User_ID node only
    [Tags]    Cancel_Token_003

    ${request_body}=    Point API - Request Token Success

    ${remove_node} = 	Create List 	api_token 	user_token    partner_id
    ${request_body_for_cancel}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Delete Request    ${POINT_API_URL_CANCEL_TOKEN}    ${request_body_for_cancel}    <Response [400]>

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Cancel Token Error    ${response}    ${json_error_expect}    ${request_body}

API Cancel Token_004 - To verify that API Cancel Token return error message when system donot send all nodes
    [Tags]    Cancel_Token_004

    ${request_body}=    Point API - Request Token Success

    ${remove_node} = 	Create List 	api_token    user_id 	user_token    partner_id
    ${request_body_for_cancel}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Delete Request    ${POINT_API_URL_CANCEL_TOKEN}    ${request_body_for_cancel}    <Response [400]>

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Cancel Token Error    ${response}    ${json_error_expect}    ${request_body}

API Cancel Token_006 - To verify that API Cancel Token return error message when system send incorrect Request URL
    [Tags]    Cancel_Token_006

    ${request_body}=    Point API - Request Token Success

    ${remove_node} = 	Create List 	api_token    user_id 	user_token    partner_id
    ${request_body_for_cancel}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Delete Request    ${POINT_API_URL_CANCEL_TOKEN}/wrong    ${request_body_for_cancel}    <Response [404]>

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    server_not_found
    ${json_error_expect}=    Replace String    ${json_error}    "[]"    []

    Point API - Verify Response Cancel Token Error    ${response}    ${json_error_expect}    ${request_body}

API Cancel Token_007 - To verify that API Cancel Token return error message when system send invalid API_Token node
    [Tags]    Cancel_Token_007

    ${request_body}=    Point API - Request Token Success

    ${remove_node} = 	Create List 	user_token    partner_id    api_token
    ${request_body_for_cancel}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${request_body_for_cancel}=    Add Node to Json Body    ${request_body_for_cancel}    api_token    wrong_api_token1122233444

    ${response}=    Point API - Send Http Delete Request    ${POINT_API_URL_CANCEL_TOKEN}    ${request_body_for_cancel}    <Response [400]>

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    invalid_token
    ${json_error_expect}=    Replace String    ${json_error}    "[]"    []

    Point API - Verify Response Cancel Token Error    ${response}    ${json_error_expect}    ${request_body}


API Cancel Token_008 - To verify that API Cancel Token return error message when system send invalid User_ID node
    [Tags]    Cancel_Token_008

    ${request_body}=    Point API - Request Token Success

    ${remove_node} = 	Create List 	user_token    partner_id    user_id
    ${request_body_for_cancel}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${request_body_for_cancel}=    Add Node to Json Body    ${request_body_for_cancel}    user_id    wrong_user_id_1122233444

    ${response}=    Point API - Send Http Delete Request    ${POINT_API_URL_CANCEL_TOKEN}    ${request_body_for_cancel}

    ${remove_node} = 	Create List 	user_id
    ${request_body}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${request_body}=    Add Node to Json Body    ${request_body}    user_id    wrong_user_id_1122233444

    Point API - Verify Response Cancel Token Success    ${response}    ${request_body}

API Cancel Token_009 - To verify that API Cancel Token return error message when system donot send value of API_Token node
    [Tags]    Cancel_Token_009    Token_test

    ${request_body}=    Point API - Request Token Success

    ${remove_node} = 	Create List 	user_token    partner_id    api_token
    ${request_body_for_cancel}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}
    ${api_token}=    Set Variable

    ${request_body_for_cancel}=    Add Node to Json Body    ${request_body_for_cancel}    api_token    ${api_token}

    ${response}=    Point API - Send Http Delete Request    ${POINT_API_URL_CANCEL_TOKEN}    ${request_body_for_cancel}    <Response [400]>

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Cancel Token Error    ${response}    ${json_error_expect}    ${request_body}

API Cancel Token_010 - To verify that API Cancel Token return error message when system donot send value of User_ID node
    [Tags]    Cancel_Token_010

    ${request_body}=    Point API - Request Token Success

    ${remove_node} = 	Create List 	user_token    partner_id    user_id
    ${request_body_for_cancel}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}
    ${user_id}=    Set Variable

    ${request_body_for_cancel}=    Add Node to Json Body    ${request_body_for_cancel}    user_id    ${user_id}

    ${response}=    Point API - Send Http Delete Request    ${POINT_API_URL_CANCEL_TOKEN}    ${request_body_for_cancel}    <Response [400]>

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Cancel Token Error    ${response}    ${json_error_expect}    ${request_body}

API Cancel Token_011 - To verify that API Cancel Token return error message when system donot send value of all nodes
    [Tags]    Cancel_Token_011

    ${request_body}=    Point API - Request Token Success

    ${remove_node} = 	Create List 	api_token    user_token    partner_id    user_id
    ${request_body_for_cancel}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}
    ${api_token}=    Set Variable
    ${user_id}=    Set Variable

    ${request_body_for_cancel}=    Add Node to Json Body    ${request_body_for_cancel}    api_token    ${user_id}
    ${request_body_for_cancel}=    Add Node to Json Body    ${request_body_for_cancel}    user_id    ${user_id}

    ${response}=    Point API - Send Http Delete Request    ${POINT_API_URL_CANCEL_TOKEN}    ${request_body_for_cancel}    <Response [400]>

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Cancel Token Error    ${response}    ${json_error_expect}    ${request_body}

API Cancel Token_012 - To verify that API Cancel Token return error message when system send value of API_Token node = null
    [Tags]    Cancel_Token_012

    ${request_body}=    Point API - Request Token Success
    ${token_user_id}=    Point API - Get Data From Json    ${request_body}   /user_id

    ${request_body_for_cancel}=    Set Variable    {"api_token" : null, "user_id" : "${token_user_id}"}
    ${response}=    Point API - Send Http Delete Request    ${POINT_API_URL_CANCEL_TOKEN}    ${request_body_for_cancel}    <Response [400]>

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Cancel Token Error    ${response}    ${json_error_expect}    ${request_body}

API Cancel Token_013 - To verify that API Cancel Token return error message when system send value of User_ID node = null
    [Tags]    Cancel_Token_013

    ${request_body}=    Point API - Request Token Success
    ${token_api_token}=    Point API - Get Data From Json    ${request_body}   /api_token

    ${request_body_for_cancel}=    Set Variable    {"api_token" : "${token_api_token}", "user_id" : ""}
    ${response}=    Point API - Send Http Delete Request    ${POINT_API_URL_CANCEL_TOKEN}    ${request_body_for_cancel}    <Response [400]>

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Cancel Token Error    ${response}    ${json_error_expect}    ${request_body}

API Cancel Token_014 - To verify that API Cancel Token return error message when system send value of User_ID node = null
    [Tags]    Cancel_Token_014

    ${request_body}=    Point API - Request Token Success
    ${token_api_token}=    Point API - Get Data From Json    ${request_body}   /api_token

    ${request_body_for_cancel}=    Set Variable    {"api_token" : "", "user_id" : ""}
    ${response}=    Point API - Send Http Delete Request    ${POINT_API_URL_CANCEL_TOKEN}    ${request_body_for_cancel}    <Response [400]>

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Cancel Token Error    ${response}    ${json_error_expect}    ${request_body}
