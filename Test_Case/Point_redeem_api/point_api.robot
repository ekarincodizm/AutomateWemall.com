*** Settings ***
#Library        Selenium2Library
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

${api_key}    1464942680
${api_secret}    95991a646701

${header_error_code_400}    400

*** Test Cases ***

API_Request Token_001 - To verify that API Request Token return correct username and password of partner
    [Tags]    TC_ALL    Token_001

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body}

    Point API - Verify Node API In API Request Token Success    ${request_body}    ${response}

API_Request Token_002 - To verify that API Request Token return error message when system send API_Token node only
    [Tags]    TC_ALL    Token_002

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${remove_node} = 	Create List 	username 	user_id 	password    partner_id

    ${request_body_with_remove_node}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body_with_remove_node}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    username
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    password

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_003 - To verify that API Request Token return error message when system donot send Partner_ID, Username and Password node
    [Tags]    TC_ALL    Token_003

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${remove_node} = 	Create List 	username 	password    partner_id

    ${request_body_with_remove_node}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body_with_remove_node}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    username
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    password

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_004 - To verify that API Request Token return error message when system donot send Username and Password node
    [Tags]    TC_ALL    Token_004

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${remove_node} = 	Create List 	username 	password

    ${request_body_with_remove_node}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body_with_remove_node}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    username
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    password

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_005 - To verify that API Request Token return error message when system donot send Password node
    [Tags]    TC_ALL    Token_005

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${remove_node} = 	Create List 	password

    ${request_body_with_remove_node}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body_with_remove_node}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    password

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_006 - To verify that API Request Token return error message when system send User_ID only
    [Tags]    TC_ALL    Token_006

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${remove_node} = 	Create List 	username 	api_token 	password    partner_id

    ${request_body_with_remove_node}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body_with_remove_node}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    username
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    password

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_007 - To verify that API Request Token return error message when system donot send API_Token, Username and Password node
    [Tags]    TC_ALL    Token_007

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${remove_node} = 	Create List 	username 	api_token 	password

    ${request_body_with_remove_node}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body_with_remove_node}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    username
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    password

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_008 - To verify that API Request Token return error message when system donot send API_Token and Password node
    [Tags]    TC_ALL    Token_008

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${remove_node} = 	Create List 	api_token 	password

    ${request_body_with_remove_node}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body_with_remove_node}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    password

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_009 - To verify that API Request Token return error message when system donot send API_Token node
    [Tags]    TC_ALL    Token_009

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${remove_node} = 	Create List 	api_token

    ${request_body_with_remove_node}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body_with_remove_node}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_010 - To verify that API Request Token return error message when system send Partner_ID node only
    [Tags]    TC_ALL    Token_010

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${remove_node} = 	Create List 	username 	api_token 	password    user_id

    ${request_body_with_remove_node}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body_with_remove_node}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    username
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    password

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_011 - To verify that API Request Token return error message when system donot send API_Token, Partner_ID and Password nodes
    [Tags]    TC_ALL    Token_011

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${remove_node} = 	Create List 	api_token 	password    partner_id

    ${request_body_with_remove_node}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body_with_remove_node}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    password

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_012 - To verify that API Request Token return error message when system donot send API_Token and User_ID nodes
    [Tags]    TC_ALL    Token_012

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${remove_node} = 	Create List 	api_token 	user_id

    ${request_body_with_remove_node}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body_with_remove_node}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_013 - To verify that API Request Token return error message when system donot send User_ID nodes
    [Tags]    TC_ALL    Token_013

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${remove_node} = 	Create List 	user_id

    ${request_body_with_remove_node}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body_with_remove_node}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_014 - To verify that API Request Token return error message when system send Username node only
    [Tags]    TC_ALL    Token_014

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${remove_node} = 	Create List 	partner_id 	api_token 	password    user_id

    ${request_body_with_remove_node}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body_with_remove_node}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    password

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_015 - To verify that API Request Token return error message when system donot send API_Token, User_ID and Partner_ID nodes
    [Tags]    TC_ALL    Token_015

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${remove_node} = 	Create List 	partner_id 	api_token    user_id

    ${request_body_with_remove_node}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body_with_remove_node}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_016 - To verify that API Request Token return error message when system donot send API_Token, and Partner_ID node
    [Tags]    TC_ALL    Token_016

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${remove_node} = 	Create List 	partner_id 	api_token

    ${request_body_with_remove_node}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body_with_remove_node}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_017 - To verify that API Request Token return error message when system donot send Partner_ID nodes
    [Tags]    TC_ALL    Token_017

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${remove_node} = 	Create List 	partner_id

    ${request_body_with_remove_node}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body_with_remove_node}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_018 - To verify that API Request Token return error message when system send Password node only
    [Tags]    TC_ALL    Token_018

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${remove_node} = 	Create List 	username 	user_id 	api_token    partner_id

    ${request_body_with_remove_node}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body_with_remove_node}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    username

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_019 - To verify that API Request Token return error message when system donot send User_ID, Partner_ID and Username nodes
    [Tags]    TC_ALL    Token_019

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${remove_node} = 	Create List 	username 	user_id    partner_id

    ${request_body_with_remove_node}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body_with_remove_node}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    username

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_020 - To verify that API Request Token return error message when system donot send Partner_ID and Username node
    [Tags]    TC_ALL    Token_020

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${remove_node} = 	Create List 	username    partner_id

    ${request_body_with_remove_node}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body_with_remove_node}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    username

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_021 - To verify that API Request Token return error message when system donot send Username nodes
    [Tags]    TC_ALL    Token_021

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${remove_node} = 	Create List 	username

    ${request_body_with_remove_node}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body_with_remove_node}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    username

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_022 - To verify that API Request Token return error message when system donot send all nodes
    [Tags]    TC_ALL    Token_022

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${remove_node} = 	Create List 	api_token    username 	user_id 	password    partner_id

    ${request_body_with_remove_node}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body_with_remove_node}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    username
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    password

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_024 - To verify that API Request Token return error message when system send incorrect Request URL
    [Tags]    TC_ALL    Token_024

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}/wrong-api    ${request_body}    404

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    server_not_found

    Point API - Verify Response Error    ${response}    ${json_error}

API_Request Token_025 - To verify that API Request Token return error message when system send invalid API_Token
    [Tags]    TC_ALL    Token_025

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}/wrong"    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    invalid_token

    Point API - Verify Response Error    ${response}    ${json_error}

API_Request Token_027 - To verify that API Request Token return error message when system send invalid Partner_ID
    [Tags]    TC_ALL    Token_027    Token_test

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    "${partner_id}112233344555"

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body}    ${header_error_code_400}
#

    ${remove_node} = 	Create List 	api_token    password

    ${request_body_with_remove_node}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    partner_id_wrong
    ${json_error}=    Replace String    ${json_error}    "[]"    ${request_body_with_remove_node}

    Point API - Verify Response Error    ${response}    ${json_error}

API_Request Token_030 - To verify that API Authen return error message when system donot send value of API_Token node
    [Tags]    TC_ALL    Token_030

    ${api_token}=    Set Variable    ${empty}

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_031 - To verify that API Authen return error message when system donot send value of User_ID node
    [Tags]    TC_ALL    Token_031

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${user_id}=    Set Variable    ${empty}

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_032 - To verify that API Authen return error message when system donot send value of Partner_ID node
    [Tags]    TC_ALL    Token_032

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${partner_id}=    Set Variable    ${empty}

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_033 - To verify that API Authen return error message when system donot send value of Username node
    [Tags]    TC_ALL    Token_033

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${username}=    Set Variable    ${empty}

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    username

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_034 - To verify that API Authen return error message when system donot send value of Password node
    [Tags]    TC_ALL    Token_034

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${password}=    Set Variable    ${empty}

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    password

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_035 - To verify that API Authen return error message when system donot send value of all nodes
    [Tags]    TC_ALL    Token_035

    ${api_token}=    Set Variable    ${empty}
    ${user_id}=    Set Variable    ${empty}
    ${username}=    Set Variable    ${empty}
    ${password}=    Set Variable    ${empty}
    ${partner_id}=    Set Variable    ${empty}

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    username
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    password

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_036 - To verify that API Authen return error message when system send value of API_Key = null
    [Tags]    TC_ALL    Token_036

    ${api_token}=    Set Variable    null

    ${request_body}=    Point API - Create Request Api Request Token    ${api_token}    "${user_id}"    "${username}"    "${password}"    "${partner_id}"

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_037 - To verify that API Authen return error message when system send value of User_ID = null
    [Tags]    TC_ALL    Token_037

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${user_id}=    Set Variable    null

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    ${user_id}    "${username}"    "${password}"    "${partner_id}"

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_038 - To verify that API Authen return error message when system send value of Partner_ID = null
    [Tags]    TC_ALL    Token_038

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${partner_id}=    Set Variable    null

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    "${password}"    ${partner_id}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_039 - To verify that API Authen return error message when system send value of Uername= null
    [Tags]    TC_ALL    Token_039

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${username}=    Set Variable    null

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    ${username}    "${password}"    "${partner_id}"

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    username

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_040 - To verify that API Authen return error message when system send value of Password = null
    [Tags]    TC_ALL    Token_040

    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${password}=    Set Variable    null

    ${request_body}=    Point API - Create Request Api Request Token    "${api_token}"    "${user_id}"    "${username}"    ${password}    "${partner_id}"

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    password

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request Token_041 - To verify that API Authen return error message when system send value of all nodes = null
    [Tags]    TC_ALL    Token_041

    ${api_token}=    Set Variable    null
    ${user_id}=    Set Variable    null
    ${username}=    Set Variable    null
    ${password}=    Set Variable    null
    ${partner_id}=    Set Variable    null

    ${request_body}=    Point API - Create Request Api Request Token    ${api_token}    ${user_id}    ${username}    ${password}    ${partner_id}

    ${response}=    Point API - Send Http Post Request    ${POINT_API_URL_REQUEST_TOKEN}    ${request_body}    ${header_error_code_400}

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    username
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    password

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}
