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
API Redeem Point_003 - To verify that API Redeem Point return error message when system send API_Token only
    [Tags]    Redeem_Point_03

    ${request_body}=    Point API - Request Token Success

    ${request_body}=    Set Variable    {"api_token" : "5e6ac3a9a64fd340eda1212ffb1add"}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body}   400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    request_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    total_point
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    keys

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API Redeem Point_004 - To verify that API Redeem Point return error message when system donot send Request_ID, User_ID and Total_Point node
    [Tags]    Redeem_Point_04

    ${request_body}=    Point API - Request Token Success

    ${token_user_id}=    Point API - Get Data From Json    ${request_body}   /user_id
    ${token_api_token}=    Point API - Get Data From Json    ${request_body}   /api_token
    ${request_body_key}=    Point API - Create Request Api Redeem Node Key    1    "100001"    100    1

    ${api_token}=    Set Variable    ${token_api_token}
    ${partner_id}=    Set Variable    1
    ${request_id}=    Set Variable    1
    ${user_id}=    Set Variable    ${token_user_id}
    ${total_point}=    Set Variable    1
    ${keys}=    Set Variable    ${request_body_key}

    ${request_body}=    Point API - Create Request Api Redeem    "${api_token}"    "${partner_id}"    "${request_id}"    "${user_id}"    "${total_point}"    [${keys}]

    ${remove_node} = 	Create List 	request_id    user_id    total_point
    ${request_body_with_remove_node}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body_with_remove_node}   400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    request_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    total_point

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API Redeem Point_005 - To verify that API Redeem Point return error message when system donot send User_ID and Total_Point node
    [Tags]    Redeem_Point_05

    ${request_body}=    Point API - Request Token Success

    ${token_user_id}=    Point API - Get Data From Json    ${request_body}   /user_id
    ${token_api_token}=    Point API - Get Data From Json    ${request_body}   /api_token
    ${request_body_key}=    Point API - Create Request Api Redeem Node Key    1    "100001"    100    1

    ${api_token}=    Set Variable    ${token_api_token}
    ${partner_id}=    Set Variable    1
    ${request_id}=    Set Variable    1
    ${user_id}=    Set Variable    ${token_user_id}
    ${total_point}=    Set Variable    1
    ${keys}=    Set Variable    ${request_body_key}

    ${request_body}=    Point API - Create Request Api Redeem    "${api_token}"    "${partner_id}"    "${request_id}"    "${user_id}"    "${total_point}"    [${keys}]

    ${remove_node} = 	Create List    user_id    total_point
    ${request_body_with_remove_node}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body_with_remove_node}   400

    ${json_error}=    Set Variable    {}

    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    total_point

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API Redeem Point_006 - To verify that API Redeem Point return error message when system send Total_Point node
    [Tags]    Redeem_Point_06

    ${request_body}=    Point API - Request Token Success

    ${request_body}=    Set Variable    {"total_point" : 100}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body}   400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    request_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    keys

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API Redeem Point_007 - To verify that API Redeem Point return error message when system send Partner_ID node only
    [Tags]    Redeem_Point_07

    ${request_body}=    Point API - Request Token Success

    ${request_body}=    Set Variable    {"partner_id" : 1}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body}   400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    request_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    total_point
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    keys

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API Redeem Point_008 - To verify that API Redeem Point return error message when system donot send API_Token, User_ID and Total_Point node
    [Tags]    Redeem_Point_08

    ${request_body}=    Point API - Request Token Success

    ${key}=    Point API - Create Request Api Redeem Node Key    1    "100001"    100    1
    ${request_body}=    Set Variable     {"partner_id":1, "request_id": 1, "keys": [${key}]}
    
    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body}   400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    total_point

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API Redeem Point_009 - To verify that API Redeem Point return error message when system donot send API_Token and Total_Point node
    [Tags]    Redeem_Point_09

    ${request_body}=    Point API - Request Token Success
    ${user_id}=    Point API - Get Data From Json    ${request_body}   /user_id

    ${key}=    Point API - Create Request Api Redeem Node Key    1    "100001"    100    1
    ${request}=    Set Variable     {"partner_id":1, "request_id": 1, "user_id": "${user_id}", "keys": [${key}]}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request}   400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    total_point

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API Redeem Point_011 - To verify that API Redeem Point return error message when system send Request_ID node only
    [Tags]    Redeem_Point_11

    ${request_body}=    Point API - Request Token Success

    ${request_body}=    Set Variable    {"request_id" : 1123}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body}   400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    total_point
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    keys

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API Redeem Point_012 - To verify that API Redeem Point return error message when system donot send API_Token, Partner_ID and Total_Point node
    [Tags]    Redeem_Point_012

    ${request_token}=    Point API - Request Token Success
    ${user_id}=    Point API - Get Data From Json    ${request_token}   /user_id

    ${key}=    Point API - Create Request Api Redeem Node Key    1    "100001"    100    1
    ${request_body}=    Set Variable     {"user_id": "${user_id}", "request_id": 1, "keys": [${key}]}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body}   400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    total_point

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API Redeem Point_013 - To verify that API Redeem Point return error message when system donot send API_Token and Partner_ID
    [Tags]    Redeem_Point_013

    ${request_token}=    Point API - Request Token Success
    ${user_id}=    Point API - Get Data From Json    ${request_token}   /user_id

    ${key}=    Point API - Create Request Api Redeem Node Key    1    "100001"    100    1
    ${request_body}=    Set Variable     {"user_id": "${user_id}", "request_id": 1, "total_point":100, "keys": [${key}]}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body}   400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API Redeem Point_016 - To verify that API Redeem Point return error message when system donot send API_Token, Partner_ID and Request_ID node
    [Tags]    Redeem_Point_016

    ${request_token}=    Point API - Request Token Success
    ${user_id}=    Point API - Get Data From Json    ${request_token}   /user_id

    ${key}=    Point API - Create Request Api Redeem Node Key    1    "100001"    100    1
    ${request_body}=    Set Variable     {"user_id": "${user_id}", "total_point": 1, "keys": [${key}]}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body}   400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    request_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API Redeem Point_017 - To verify that API Redeem Point return error message when system donot send Partner_ID and Request_ID node
    [Tags]    Redeem_Point_017

    ${request_token}=    Point API - Request Token Success
    ${user_id}=    Point API - Get Data From Json    ${request_token}   /user_id
    ${api_token}=    Point API - Get Data From Json    ${request_token}   /api_token

    ${key}=    Point API - Create Request Api Redeem Node Key    1    "100001"    100    1
    ${request_body}=    Set Variable     {"api_token":"${api_token}", "user_id": "${user_id}", "total_point": 1, "keys": [${key}]}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body}   400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    request_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}


API_Redeem_Point_018 - To verify that API Redeem Point return error message when system donot send Request_ID node
    [Tags]    Redeem_Point_018

    ${request_body}=    Point API - Request Token Success

    ${token_user_id}=    Point API - Get Data From Json    ${request_body}   /user_id
    ${token_api_token}=    Point API - Get Data From Json    ${request_body}   /api_token
    ${request_body_key}=    Point API - Create Request Api Redeem Node Key    1    "100001"    100    1

    ${api_token}=    Set Variable    ${token_api_token}
    ${partner_id}=    Set Variable    1
    ${request_id}=    Set Variable    1
    ${user_id}=    Set Variable    ${token_user_id}
    ${total_point}=    Set Variable    1
    ${keys}=    Set Variable    ${request_body_key}

    ${request_body}=    Point API - Create Request Api Redeem    "${api_token}"    "${partner_id}"    "${request_id}"    "${user_id}"    "${total_point}"    [${keys}]

    ${remove_node} =    Create List     request_id
    ${request_body_with_remove_node}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body_with_remove_node}   400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    request_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Redeem_Point_019 - To verify that API Redeem Point return error message when system send Total_Point node only
    [Tags]    Redeem_Point_019

    ${request_body}=    Point API - Request Token Success

    ${request_body}=    Set Variable    {"total_point" : 100}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body}   400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    request_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    keys

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Redeem_Point_020 - To verify that API Redeem Point return error message when system donot send Partner_ID, Request_ID and User_ID node
    [Tags]    Redeem_Point_020

    ${request_body}=    Point API - Request Token Success

    ${token_user_id}=    Point API - Get Data From Json    ${request_body}   /user_id
    ${token_api_token}=    Point API - Get Data From Json    ${request_body}   /api_token
    ${request_body_key}=    Point API - Create Request Api Redeem Node Key    1    "100001"    100    1

    ${api_token}=    Set Variable    ${token_api_token}
    ${partner_id}=    Set Variable    1
    ${request_id}=    Set Variable    1
    ${user_id}=    Set Variable    ${token_user_id}
    ${total_point}=    Set Variable    1
    ${keys}=    Set Variable    ${request_body_key}

    ${request_body}=    Point API - Create Request Api Redeem    "${api_token}"    "${partner_id}"    "${request_id}"    "${user_id}"    "${total_point}"    [${keys}]

    ${remove_node} =    Create List     partner_id    request_id    user_id
    ${request_body_with_remove_node}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body_with_remove_node}   400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    request_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Redeem_Point_021 - To verify that API Redeem Point return error message when system donot send Request_ID and User_ID node
    [Tags]    Redeem_Point_021

    ${request_body}=    Point API - Request Token Success

    ${token_user_id}=    Point API - Get Data From Json    ${request_body}   /user_id
    ${token_api_token}=    Point API - Get Data From Json    ${request_body}   /api_token
    ${request_body_key}=    Point API - Create Request Api Redeem Node Key    1    "100001"    100    1

    ${api_token}=    Set Variable    ${token_api_token}
    ${partner_id}=    Set Variable    1
    ${request_id}=    Set Variable    1
    ${user_id}=    Set Variable    ${token_user_id}
    ${total_point}=    Set Variable    1
    ${keys}=    Set Variable    ${request_body_key}

    ${request_body}=    Point API - Create Request Api Redeem    "${api_token}"    "${partner_id}"    "${request_id}"    "${user_id}"    "${total_point}"    [${keys}]

    ${remove_node} =    Create List    request_id    user_id
    ${request_body_with_remove_node}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body_with_remove_node}   400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    request_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Redeem_Point_022 - To verify that API Redeem Point return error message when system donot send User_ID node
    [Tags]    Redeem_Point_022

    ${request_body}=    Point API - Request Token Success

    ${token_user_id}=    Point API - Get Data From Json    ${request_body}   /user_id
    ${token_api_token}=    Point API - Get Data From Json    ${request_body}   /api_token
    ${request_body_key}=    Point API - Create Request Api Redeem Node Key    1    "100001"    100    1

    ${api_token}=    Set Variable    ${token_api_token}
    ${partner_id}=    Set Variable    1
    ${request_id}=    Set Variable    1
    ${user_id}=    Set Variable    ${token_user_id}
    ${total_point}=    Set Variable    1
    ${keys}=    Set Variable    ${request_body_key}

    ${request_body}=    Point API - Create Request Api Redeem    "${api_token}"    "${partner_id}"    "${request_id}"    "${user_id}"    "${total_point}"    [${keys}]

    ${remove_node} =    Create List    user_id
    ${request_body_with_remove_node}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body_with_remove_node}   400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API Redeem Point_023 - To verify that API Redeem Point return error message when system donot send all nodes
    [Tags]    Redeem_Point_023

    ${request_body}=    Point API - Request Token Success

    ${token_user_id}=    Point API - Get Data From Json    ${request_body}   /user_id
    ${token_api_token}=    Point API - Get Data From Json    ${request_body}   /api_token
    ${request_body_key}=    Point API - Create Request Api Redeem Node Key    1    "100001"    100    1

    ${api_token}=    Set Variable    ${token_api_token}
    ${partner_id}=    Set Variable    1
    ${request_id}=    Set Variable    1
    ${user_id}=    Set Variable    ${token_user_id}
    ${total_point}=    Set Variable    1
    ${keys}=    Set Variable    ${request_body_key}

    ${request_body}=    Point API - Create Request Api Redeem    "${api_token}"    "${partner_id}"    "${request_id}"    "${user_id}"    "${total_point}"    [${keys}]

    ${remove_node} =    Create List    api_token    partner_id    request_id    user_id    total_point    keys
    ${request_body_with_remove_node}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body_with_remove_node}   400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    request_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    total_point
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    keys

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API Redeem Point_025 - To verify that API Redeem Point return error message when system send invalid API_Token node
    [Tags]    Redeem_Point_25

    ${request_body}=    Point API - Request Token Success

    ${token_user_id}=    Point API - Get Data From Json    ${request_body}   /user_id
    ${token_api_token}=    Point API - Get Data From Json    ${request_body}   /api_token
    ${request_body_key}=    Point API - Create Request Api Redeem Node Key    1    "100001"    100    1

    ${api_token}=    Set Variable    ${token_api_token}wrong
    ${partner_id}=    Set Variable    1
    ${request_id}=    Set Variable    1
    ${user_id}=    Set Variable    ${token_user_id}
    ${total_point}=    Set Variable    1
    ${keys}=    Set Variable    ${request_body_key}

    ${request_body}=    Point API - Create Request Api Redeem    "${api_token}"    "${partner_id}"    "${request_id}"    "${user_id}"    "${total_point}"    [${keys}]

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body}   400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    invalid_token

    Point API - Verify Response Error    ${response}    ${json_error}

API Redeem Point_026 - To verify that API Redeem Point return error message when system send invalid Partner_ID node
    [Tags]    Redeem_Point_26    Token_test

    ${request_body}=    Point API - Request Token Success

    ${token_user_id}=    Point API - Get Data From Json    ${request_body}   /user_id
    ${token_api_token}=    Point API - Get Data From Json    ${request_body}   /api_token
    ${request_body_key}=    Point API - Create Request Api Redeem Node Key    1    "100001"    100    1

    ${api_token}=    Set Variable    ${token_api_token}
    ${partner_id}=    Set Variable    12345
    ${request_id}=    Set Variable    1
    ${user_id}=    Set Variable    ${token_user_id}
    ${total_point}=    Set Variable    1
    ${keys}=    Set Variable    ${request_body_key}

    ${request_body}=    Point API - Create Request Api Redeem    "${api_token}"    "${partner_id}"    "${request_id}"    "${user_id}"    "${total_point}"    [${keys}]

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body}   400

    ${remove_node} = 	Create List 	api_token
    ${request_body_with_remove_node}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    partner_id_wrong
    ${json_error}=    Replace String    ${json_error}    "[]"    ${request_body_with_remove_node}

    Log To Console    *****${response}
    Log To Console    +++++${json_error}

    Point API - Verify Response Error For Redeem    ${response}    ${json_error}

API Redeem Point_029 - To verify that API Redeem Point return error message when system send invalid Total_Point node
    [Tags]    Redeem_Point_29

    ${request_body}=    Point API - Request Token Success

    ${token_user_id}=    Point API - Get Data From Json    ${request_body}   /user_id
    ${token_api_token}=    Point API - Get Data From Json    ${request_body}   /api_token
    ${request_body_key}=    Point API - Create Request Api Redeem Node Key    1    "100001"    100    1

    ${api_token}=    Set Variable    ${token_api_token}
    ${partner_id}=    Set Variable    1
    ${request_id}=    Set Variable    1
    ${user_id}=    Set Variable    ${token_user_id}
    ${total_point}=    Set Variable    Wrong
    ${keys}=    Set Variable    ${request_body_key}

    ${request_body}=    Point API - Create Request Api Redeem    "${api_token}"    "${partner_id}"    "${request_id}"    "${user_id}"    "${total_point}"    [${keys}]

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body}   400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    numeric    total_point

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API Redeem Point_030 - To verify that API Redeem Point return error message when system donot send value of API_Token node
    [Tags]    Redeem_Point_30

    ${request_body}=    Point API - Request Token Success

    ${token_user_id}=    Point API - Get Data From Json    ${request_body}   /user_id
    ${token_api_token}=    Point API - Get Data From Json    ${request_body}   /api_token
    ${request_body_key}=    Point API - Create Request Api Redeem Node Key    1    "100001"    100    1

    ${api_token}=    Set Variable
    ${partner_id}=    Set Variable    1
    ${request_id}=    Set Variable    1
    ${user_id}=    Set Variable    ${token_user_id}
    ${total_point}=    Set Variable    1
    ${keys}=    Set Variable    ${request_body_key}

    ${request_body}=    Point API - Create Request Api Redeem    "${api_token}"    "${partner_id}"    "${request_id}"    "${user_id}"    "${total_point}"    [${keys}]

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body}   400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API Redeem Point_031 - To verify that API Redeem Point return error message when system donot send value of Partner_ID node
    [Tags]    Redeem_Point_31

    ${request_body}=    Point API - Request Token Success

    ${token_user_id}=    Point API - Get Data From Json    ${request_body}   /user_id
    ${token_api_token}=    Point API - Get Data From Json    ${request_body}   /api_token
    ${request_body_key}=    Point API - Create Request Api Redeem Node Key    1    "100001"    100    1

    ${api_token}=    Set Variable    ${api_token}
    ${partner_id}=    Set Variable
    ${request_id}=    Set Variable    1
    ${user_id}=    Set Variable    ${token_user_id}
    ${total_point}=    Set Variable    1
    ${keys}=    Set Variable    ${request_body_key}

    ${request_body}=    Point API - Create Request Api Redeem    "${api_token}"    "${partner_id}"    "${request_id}"    "${user_id}"    "${total_point}"    [${keys}]

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body}   400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API Redeem Point_032 - To verify that API Redeem Point return error message when system donot send value of Request_ID node
    [Tags]    Redeem_Point_32

    ${request_body}=    Point API - Request Token Success

    ${token_user_id}=    Point API - Get Data From Json    ${request_body}   /user_id
    ${token_api_token}=    Point API - Get Data From Json    ${request_body}   /api_token
    ${request_body_key}=    Point API - Create Request Api Redeem Node Key    1    "100001"    100    1

    ${api_token}=    Set Variable    ${api_token}
    ${partner_id}=    Set Variable    1
    ${request_id}=    Set Variable
    ${user_id}=    Set Variable    ${token_user_id}
    ${total_point}=    Set Variable    1
    ${keys}=    Set Variable    ${request_body_key}

    ${request_body}=    Point API - Create Request Api Redeem    "${api_token}"    "${partner_id}"    "${request_id}"    "${user_id}"    "${total_point}"    [${keys}]

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body}   400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    request_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API Redeem Point_033 - To verify that API Redeem Point return error message when system donot send value of User_id node
    [Tags]    Redeem_Point_33

    ${request_body}=    Point API - Request Token Success

    ${token_user_id}=    Point API - Get Data From Json    ${request_body}   /user_id
    ${token_api_token}=    Point API - Get Data From Json    ${request_body}   /api_token
    ${request_body_key}=    Point API - Create Request Api Redeem Node Key    1    "100001"    100    1

    ${api_token}=    Set Variable    ${api_token}
    ${partner_id}=    Set Variable    1
    ${request_id}=    Set Variable    1
    ${user_id}=    Set Variable
    ${total_point}=    Set Variable    1
    ${keys}=    Set Variable    ${request_body_key}

    ${request_body}=    Point API - Create Request Api Redeem    "${api_token}"    "${partner_id}"    "${request_id}"    "${user_id}"    "${total_point}"    [${keys}]

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body}   400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API Redeem Point_034 - To verify that API Redeem Point return error message when system donot send value of Total_Point node
    [Tags]    Redeem_Point_34

    ${request_body}=    Point API - Request Token Success

    ${token_user_id}=    Point API - Get Data From Json    ${request_body}   /user_id
    ${token_api_token}=    Point API - Get Data From Json    ${request_body}   /api_token
    ${request_body_key}=    Point API - Create Request Api Redeem Node Key    1    "100001"    100    1

    ${api_token}=    Set Variable    ${api_token}
    ${partner_id}=    Set Variable    1
    ${request_id}=    Set Variable    1
    ${user_id}=    Set Variable    ${token_user_id}
    ${total_point}=    Set Variable
    ${keys}=    Set Variable    ${request_body_key}

    ${request_body}=    Point API - Create Request Api Redeem    "${api_token}"    "${partner_id}"    "${request_id}"    "${user_id}"    "${total_point}"    [${keys}]

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body}   400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    total_point

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Redeem_Point_035 - To verify that API Redeem Point return error message when system donot send value of all nodes
    [Tags]    Redeem_Point_035

    ${request_body}=    Point API - Request Token Success

    ${request_body}=    Set Variable    {}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body}   400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    request_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    total_point
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    keys

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Redeem_Point_036 - To verify that API Redeem Point return error message when system donot send value of API_Token node = null
    [Tags]    Redeem_Point_036

    ${request_body}=    Point API - Request Token Success

    ${token_user_id}=    Point API - Get Data From Json    ${request_body}   /user_id
    ${token_api_token}=    Point API - Get Data From Json    ${request_body}   /api_token
    ${request_body_key}=    Point API - Create Request Api Redeem Node Key    1    "100001"    100    1

    ${api_token}=    Set Variable    null
    ${partner_id}=    Set Variable    1
    ${request_id}=    Set Variable    1
    ${user_id}=    Set Variable    ${token_user_id}
    ${total_point}=    Set Variable    1
    ${keys}=    Set Variable    ${request_body_key}

    ${request_body}=    Point API - Create Request Api Redeem    ${api_token}    "${partner_id}"    "${request_id}"    "${user_id}"    "${total_point}"    [${keys}]

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body}   400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Redeem_Point_037 - To verify that API Redeem Point return error message when system donot send value of Partner_ID node = null
    [Tags]    Redeem_Point_037

    ${request_body}=    Point API - Request Token Success

    ${token_user_id}=    Point API - Get Data From Json    ${request_body}   /user_id
    ${token_api_token}=    Point API - Get Data From Json    ${request_body}   /api_token
    ${request_body_key}=    Point API - Create Request Api Redeem Node Key    1    "100001"    100    1

    ${api_token}=    Set Variable    ${api_token}
    ${partner_id}=    Set Variable    null
    ${request_id}=    Set Variable    1
    ${user_id}=    Set Variable    ${token_user_id}
    ${total_point}=    Set Variable    1
    ${keys}=    Set Variable    ${request_body_key}

    ${request_body}=    Point API - Create Request Api Redeem    "${api_token}"    ${partner_id}    "${request_id}"    "${user_id}"    "${total_point}"    [${keys}]

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body}   400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Redeem_Point_038 - To verify that API Redeem Point return error message when system donot send value of Request_ID node = null
    [Tags]    Redeem_Point_038

    ${request_body}=    Point API - Request Token Success

    ${token_user_id}=    Point API - Get Data From Json    ${request_body}   /user_id
    ${token_api_token}=    Point API - Get Data From Json    ${request_body}   /api_token
    ${request_body_key}=    Point API - Create Request Api Redeem Node Key    1    "100001"    100    1

    ${api_token}=    Set Variable    ${api_token}
    ${partner_id}=    Set Variable    1
    ${request_id}=    Set Variable    null
    ${user_id}=    Set Variable    ${token_user_id}
    ${total_point}=    Set Variable    1
    ${keys}=    Set Variable    ${request_body_key}

    ${request_body}=    Point API - Create Request Api Redeem    "${api_token}"    "${partner_id}"    ${request_id}    "${user_id}"    "${total_point}"    [${keys}]

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body}   400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    request_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Redeem_Point_039 - To verify that API Redeem Point return error message when system donot send value of User_ID node = null
    [Tags]    Redeem_Point_039

    ${request_body}=    Point API - Request Token Success

    ${token_user_id}=    Point API - Get Data From Json    ${request_body}   /user_id
    ${token_api_token}=    Point API - Get Data From Json    ${request_body}   /api_token
    ${request_body_key}=    Point API - Create Request Api Redeem Node Key    1    "100001"    100    1

    ${api_token}=    Set Variable    ${api_token}
    ${partner_id}=    Set Variable    1
    ${request_id}=    Set Variable    1
    ${user_id}=    Set Variable    null
    ${total_point}=    Set Variable    1
    ${keys}=    Set Variable    ${request_body_key}

    ${request_body}=    Point API - Create Request Api Redeem    "${api_token}"    "${partner_id}"    "${request_id}"    ${user_id}    "${total_point}"    [${keys}]

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body}   400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Redeem_Point_040 - To verify that API Redeem Point return error message when system donot send value of Total_Point node = null
    [Tags]    Redeem_Point_040

    ${request_body}=    Point API - Request Token Success

    ${token_user_id}=    Point API - Get Data From Json    ${request_body}   /user_id
    ${token_api_token}=    Point API - Get Data From Json    ${request_body}   /api_token
    ${request_body_key}=    Point API - Create Request Api Redeem Node Key    1    "100001"    100    1

    ${api_token}=    Set Variable    ${api_token}
    ${partner_id}=    Set Variable    1
    ${request_id}=    Set Variable    1
    ${user_id}=    Set Variable    ${token_user_id}
    ${total_point}=    Set Variable    null
    ${keys}=    Set Variable    ${request_body_key}

    ${request_body}=    Point API - Create Request Api Redeem    "${api_token}"    "${partner_id}"    "${request_id}"    "${user_id}"    ${total_point}    [${keys}]

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body}   400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    total_point

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Redeem_Point_041 - To verify that API Redeem Point return error message when system donot send value of all nodes = null
    [Tags]    Redeem_Point_041

    ${request_body}=    Point API - Request Token Success

    ${request_body}=    Set Variable    {"api_token" : null, "partner_id" : null, "request_id" : null, "user_id" : null, "total_point" : null, "keys" : null}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_GET_REDEEM}    ${request_body}   400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    request_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    total_point
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    keys

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

