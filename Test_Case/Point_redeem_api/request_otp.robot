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

*** Variables ***
${url_request_OTP}    /v1/request-otp
${api_key}          1464942680
${api_secret}       95991a646701

${user_id}      robot-test-point
${partner_id}   2
${card_no}      1368
${mobile}       0869367518


*** Test Cases ***
API_Request_OTP_001 - To verify that API Request OTP return correct OTP message
    [Tags]    TC_ALL    API_Request_OTP_001

    ${api_token}=       Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${request_body}=    Point Request OTP - Create Request    ${api_token}    ${user_id}    ${partner_id}    ${card_no}    ${mobile}
    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}   ${request_body}

    Point Request OTP - Verify Response    ${response}    ${request_body}

API_Request_OTP_002 - To verify that API Request OTP of BAY return error message when system send API_Token node only
    [Tags]   TC_ALL    API_Request_OTP_002

    ${api_token}=       Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${request_body}=    Point Request OTP - Create Request      ${api_token}
    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400 Bad Request

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    card_no

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_003 - To verify that API Request OTP of BAY return error message when system donot send Partner_ID, Card_No and Mobile_No node
    [Tags]  TC_ALL    API_Request_OTP_003

    ${api_token}=       Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${request_body}=    Point Request OTP - Create Request      ${api_token}    ${user_id}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400 Bad Request

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    card_no

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_004 - To verify that API Request OTP of BAY return error message when system donot send Card_No and Mobile_No node
    [Tags]  TC_ALL    API_Request_OTP_004

    ${api_token}=       Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${request_body}=    Point Request OTP - Create Request      ${api_token}    ${user_id}    ${partner_id}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400 Bad Request

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    card_no

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_005 - To verify that API Request OTP of BAY return error message when system donot send Mobile_No node
    [Tags]  TC_ALL    API_Request_OTP_005

    ${api_token}=       Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${request_body}=    Point Request OTP - Create Request      ${api_token}    ${user_id}    ${partner_id}    ${card_no}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    500 Cannot connect partner

    ${error_code}=    Point API - Get Data From Json    ${response}     /errorCode
    ${error_message}=    Point API - Get Data From Json    ${response}     /errorMessage

    Should Be Equal    ${error_code}    POS5002
    Should Be Equal    ${error_message}    Cannot connect partner


API_Request_OTP_006 - To verify that API Request OTP of BAY return error message when system send User_ID only
    [Tags]  TC_ALL    API_Request_OTP_006

    ${api_token}=    Set Variable
    ${request_body}=    Point Request OTP - Create Request      ${api_token}    ${user_id}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    card_no

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_007 - To verify that API Request OTP of BAY return error message when system donot send API_Token, Card_No and Mobile_No
    [Tags]  TC_ALL    API_Request_OTP_007

    ${api_token}=    Set Variable
    ${request_body}=    Point Request OTP - Create Request      ${api_token}    ${user_id}    ${partner_id}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    card_no

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_008 - To verify that API Request OTP of BAY return error message when system donot send API_Token and Mobile_No
    [Tags]  TC_ALL    API_Request_OTP_008

    ${api_token}=    Set Variable
    ${request_body}=    Point Request OTP - Create Request      ${api_token}    ${user_id}    ${partner_id}    ${card_no}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_009 - To verify that API Request OTP of BAY return error message when system donot send API_Token
    [Tags]  TC_ALL    API_Request_OTP_009

    ${api_token}=    Set Variable
    ${request_body}=    Point Request OTP - Create Request      ${api_token}    ${user_id}    ${partner_id}    ${card_no}   ${mobile}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_010 - To verify that API Request OTP of BAY return error message when system send Partner_ID only
    [Tags]  TC_ALL    API_Request_OTP_010

    ${api_token}=    Set Variable
    ${user_id}=     Set Variable
    ${request_body}=    Point Request OTP - Create Request      ${api_token}    ${user_id}    ${partner_id}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    card_no

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_011 - To verify that API Request OTP of BAY return error message when system donot send API_Token, User_ID and Mobile_No
    [Tags]  TC_ALL    API_Request_OTP_011

    ${api_token}=    Set Variable
    ${user_id}=     Set Variable
    ${request_body}=    Point Request OTP - Create Request      ${api_token}    ${user_id}    ${partner_id}    ${card_no}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_012 - To verify that API Request OTP of BAY return error message when system donot send API_Token and User_ID
    [Tags]  TC_ALL    API_Request_OTP_012

    ${api_token}=    Set Variable
    ${user_id}=     Set Variable
    ${request_body}=    Point Request OTP - Create Request      ${api_token}    ${user_id}    ${partner_id}    ${card_no}    ${mobile}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_013 - To verify that API Request OTP of BAY return error message when system donot send User_ID
    [Tags]  TC_ALL    API_Request_OTP_013

    ${api_token}=       Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${user_id}=     Set Variable
    ${request_body}=    Point Request OTP - Create Request      ${api_token}    ${user_id}    ${partner_id}    ${card_no}    ${mobile}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_014 - To verify that API Request OTP of BAY return error message when system send Card_No node only
    [Tags]  TC_ALL    API_Request_OTP_014

    ${api_token}=       Set Variable
    ${user_id}=     Set Variable
    ${partner_id}=     Set Variable
    ${mobile}=     Set Variable
    ${request_body}=    Point Request OTP - Create Request      ${api_token}    ${user_id}    ${partner_id}    ${card_no}    ${mobile}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_015 - To verify that API Request OTP of BAY return error message when system donot send API_Token, User_ID and Partner_ID
    [Tags]  TC_ALL    API_Request_OTP_015

    ${api_token}=       Set Variable
    ${user_id}=     Set Variable
    ${partner_id}=     Set Variable
    ${request_body}=    Point Request OTP - Create Request      ${api_token}    ${user_id}    ${partner_id}    ${card_no}    ${mobile}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_016 - To verify that API Request OTP of BAY return error message when system donot send User_ID and Partner_ID
    [Tags]  TC_ALL    API_Request_OTP_016

    ${api_token}=       Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${user_id}=     Set Variable
    ${partner_id}=     Set Variable
    ${request_body}=    Point Request OTP - Create Request      ${api_token}    ${user_id}    ${partner_id}    ${card_no}    ${mobile}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_017 - To verify that API Request OTP of BAY return error message when system donot send Partner_ID
    [Tags]  TC_ALL    API_Request_OTP_017

    ${api_token}=       Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${partner_id}=     Set Variable
    ${request_body}=    Point Request OTP - Create Request      ${api_token}    ${user_id}    ${partner_id}    ${card_no}    ${mobile}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_018 - To verify that API Request OTP of BAY return error message when system send Mobile_No only
    [Tags]  TC_ALL    API_Request_OTP_018

    ${api_token}=       Set Variable
    ${user_id}=       Set Variable
    ${partner_id}=     Set Variable
    ${card_no}=     Set Variable
    ${request_body}=    Point Request OTP - Create Request      ${api_token}    ${user_id}    ${partner_id}    ${card_no}    ${mobile}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    card_no

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_019 - To verify that API Request OTP of BAY return error message when system donot send User_ID, Partner_ID and Card_No
    [Tags]  TC_ALL    API_Request_OTP_019

    ${api_token}=       Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${user_id}=       Set Variable
    ${partner_id}=     Set Variable
    ${card_no}=     Set Variable
    ${request_body}=    Point Request OTP - Create Request      ${api_token}    ${user_id}    ${partner_id}    ${card_no}    ${mobile}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    card_no

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_020 - To verify that API Request OTP of BAY return error message when system donot send Partner_ID and Card_No
    [Tags]  TC_ALL    API_Request_OTP_020

    ${api_token}=       Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${partner_id}=     Set Variable
    ${card_no}=     Set Variable
    ${request_body}=    Point Request OTP - Create Request      ${api_token}    ${user_id}    ${partner_id}    ${card_no}    ${mobile}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    card_no

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_021 - To verify that API Request OTP of BAY return error message when system donot send Card_No
    [Tags]  TC_ALL    API_Request_OTP_021

    ${api_token}=       Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${card_no}=     Set Variable
    ${request_body}=    Point Request OTP - Create Request      ${api_token}    ${user_id}    ${partner_id}    ${card_no}    ${mobile}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    card_no

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_022 - To verify that API Request OTP of BAY return error message when system donot send all nodes
    [Tags]  TC_ALL    API_Request_OTP_022

    ${request_body}=    Point Request OTP - Create Request

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    card_no

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_024 - To verify that API Request OTP of BAY return error message when system send invalid API_Token node
    [Tags]  TC_ALL    API_Request_OTP_024

    ${request_body}=    Point Request OTP - Create Request    invalid_token    ${user_id}    ${partner_id}    ${card_no}    ${mobile}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400

    ${error_code}=    Point API - Get Data From Json    ${response}    /errorCode
    ${error_message}=    Point API - Get Data From Json    ${response}    /errorMessage

    Should Be Equal    ${error_code}    POS4013
    Should Be Equal    ${error_message}    Invalid Token

API_Request_OTP_025 - To verify that API Request OTP of BAY return error message when system send invalid User_ID node
    [Tags]  TC_ALL    API_Request_OTP_025

    ${request_body}=    Point Request OTP - Create Request

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    card_no

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_026 - To verify that API Request OTPof BAY return error message when system send invalid Partner_ID node
    [Tags]  TC_ALL    API_Request_OTP_026

    ${api_token}=       Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${partner_id}=    Set Variable    3
    ${request_body}=    Point Request OTP - Create Request    ${api_token}     ${user_id}    ${partner_id}    ${card_no}    ${mobile}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400

    ${error_code}=    Point API - Get Data From Json    ${response}    /errorCode
    ${error_message}=    Point API - Get Data From Json    ${response}    /errorMessage

    Should Be Equal    ${error_code}    POS4003
    Should Be Equal    ${error_message}    Your partner is not support in this api

API_Request_OTP_027 - To verify that API Request OTP of BAY return error message when system send invalid Card_Number node
    [Tags]  TC_ALL    API_Request_OTP_027

    ${api_token}=       Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${card_no}=    Set Variable    invalid card no
    ${partner_id}=    Set Variable    2
    ${request_body}=    Point Request OTP - Create Request    ${api_token}     ${user_id}    ${partner_id}    ${card_no}    ${mobile}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    numeric    card_no

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_028 - To verify that API Request OTP of BAY return error message when system send invalid Mobile_Number node
    [Tags]  TC_ALL    API_Request_OTP_028

    ${api_token}=       Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${mobile}=    Set Variable    invalid mobile
    ${request_body}=    Point Request OTP - Create Request    ${api_token}     ${user_id}    ${partner_id}    ${card_no}    ${mobile}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    numeric    mobile

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_029 - To verify that API Request OTP of BAY return error message when system donot send value of API_Token node
    [Tags]  TC_ALL    API_Request_OTP_029

    ${api_token}=       Set Variable
    ${request_body}=    Point Request OTP - Create Request    ${api_token}     ${user_id}    ${partner_id}    ${card_no}    ${mobile}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_030 - To verify that API Request OTP of BAY return error message when system donot send value of User_ID node
    [Tags]  TC_ALL    API_Request_OTP_030

    ${api_token}=       Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${user_id}=    Set Variable
    ${request_body}=    Point Request OTP - Create Request    ${api_token}     ${user_id}    ${partner_id}    ${card_no}    ${mobile}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_031 - To verify that API Request OTP of BAY return error message when system donot send value of Partner_ID node
    [Tags]  TC_ALL    API_Request_OTP_031

    ${api_token}=       Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${partner_id}=    Set Variable
    ${request_body}=    Point Request OTP - Create Request    ${api_token}     ${user_id}    ${partner_id}    ${card_no}    ${mobile}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_032 - To verify that API Request OTP of BAY return error message when system donot send value of Card_Number node
    [Tags]  TC_ALL    API_Request_OTP_032

    ${api_token}=       Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${card_no}=    Set Variable
    ${request_body}=    Point Request OTP - Create Request    ${api_token}     ${user_id}    ${partner_id}    ${card_no}    ${mobile}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    card_no

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_033 - To verify that API Request OTP of BAY return error message when system donot send value of Mobile_Number node
    [Tags]  TC_ALL    API_Request_OTP_033

    ${api_token}=       Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${mobile}=    Set Variable
    ${request_body}=    Point Request OTP - Create Request    ${api_token}     ${user_id}    ${partner_id}    ${card_no}    ${mobile}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    500

    ${error_code}=    Point API - Get Data From Json    ${response}     /errorCode
    ${error_message}=    Point API - Get Data From Json    ${response}     /errorMessage

    Should Be Equal    ${error_code}    POS5002
    Should Be Equal    ${error_message}    Cannot connect partner

API_Request_OTP_034 - To verify that API Request OTP of BAY return error message when system donot send value of all nodes
    [Tags]  TC_ALL    API_Request_OTP_034

    ${api_token}=       Set Variable
    ${user_id}=       Set Variable
    ${partner_id}=       Set Variable
    ${card_no}=       Set Variable
    ${mobile}=    Set Variable
    ${request_body}=    Point Request OTP - Create Request    ${api_token}     ${user_id}    ${partner_id}    ${card_no}    ${mobile}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400


    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    card_no

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_035 - To verify that API Request OTP of BAY return error message when system donot send value of API_Token node = null
    [Tags]  TC_ALL    API_Request_OTP_035

    ${api_token}=       Set Variable
    ${request_body}=    Point Request OTP - Create Request    ${api_token}     ${user_id}    ${partner_id}    ${card_no}    ${mobile}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_036 - To verify that API Request OTP of BAY return error message when system donot send value of User_ID node = null
    [Tags]  TC_ALL    API_Request_OTP_036

    ${api_token}=       Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${user_id}=    Set Variable
    ${request_body}=    Point Request OTP - Create Request    ${api_token}     ${user_id}    ${partner_id}    ${card_no}    ${mobile}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_037 - To verify that API Request OTP of BAY return error message when system donot send value of Partner_ID node = null
    [Tags]  TC_ALL    API_Request_OTP_037

    ${api_token}=       Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${partner_id}=    Set Variable
    ${request_body}=    Point Request OTP - Create Request    ${api_token}     ${user_id}    ${partner_id}    ${card_no}    ${mobile}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400


    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_038 - To verify that API Request OTP of BAY return error message when system donot send value of Card_Number node = null
    [Tags]  TC_ALL    API_Request_OTP_038

    ${api_token}=       Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${card_no}=    Set Variable
    ${request_body}=    Point Request OTP - Create Request    ${api_token}     ${user_id}    ${partner_id}    ${card_no}    ${mobile}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    card_no

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Request_OTP_039 - To verify that API Request OTP of BAY return error message when system donot send value of Mobile_Number node = null
    [Tags]  TC_ALL    API_Request_OTP_039

    ${api_token}=       Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${request_body}=    Point Request OTP - Create Request    ${api_token}     ${user_id}    ${partner_id}    ${card_no}

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    500

    ${error_code}=    Point API - Get Data From Json    ${response}    /errorCode
    ${error_message}=    Point API - Get Data From Json    ${response}    /errorMessage

    Should Be Equal    ${error_code}    POS5002
    Should Be Equal    ${error_message}    Cannot connect partner

API_Request_OTP_040 - To verify that API Request OTP of BAY return error message when system donot send value of Mobile_Number node = null
    [Tags]  TC_ALL    API_Request_OTP_040

    ${request_body}=    Point Request OTP - Create Request

    ${response}=        Point API - Send Http Post Request    ${url_request_OTP}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    user_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    card_no

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response}    ${json_error_expect}













