*** Settings ***
Library        Selenium2Library
Resource        ${CURDIR}/../../Keyword/Portal/Point_redeem_api/Keywords_point_api.robot
Resource        ${CURDIR}/../../Keyword/API/common/api_keywords.robot
Resource        ${CURDIR}/../../Resource/Config/${ENV}/Env_config.robot
Library         ${CURDIR}/../../Python_Library/DatabaseDataPoint.py

Library           Collections
Library           String
Library           OperatingSystem
Library           HttpLibrary.HTTP

*** Test Cases ***

API_Authen_001 - To verify that API Authen return correct token
    [Tags]    TC_ALL    API_Authen_001

    ${api_key_and_api_secret}=    Point API - Get api_key and api_secret

    ${request_api_key}=    Set Variable    ${api_key_and_api_secret[0]}
    ${request_api_secret}=    Set Variable    ${api_key_and_api_secret[1]}

    ${request_body}=    Point API - Create Request Api Authen    "${request_api_key}"    "${request_api_secret}"
    ${response_body}=    Point API - Send Http Post Request    ${POINT_API_URL_AUTHEN}    ${request_body}    200

    Authen API - Verify Response Success    ${response_body}    ${request_api_key}

API_Authen_002 - To verify that API Authen return error message when system send API_Key only
    [Tags]    TC_ALL    API_Authen_002

    ${api_key_and_api_secret}=    Point API - Get api_key and api_secret

    ${request_api_key}=    Set Variable    ${api_key_and_api_secret[0]}
    ${request_api_secret}=    Set Variable
    ${expect_error_msg}=    Set Variable    "The api_secret is required"

    ${request_body}=    Point API - Create Request Api Authen    "${request_api_key}"    "${request_api_secret}"
    ${remove_node}=    Create List    api_secret
    ${request_body}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response_body}=    Point API - Send Http Post Request    ${POINT_API_URL_AUTHEN}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_secret

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response_body}    ${json_error_expect}

API_Authen_003 - To verify that API Authen return error message when system send API_Secret only
    [Tags]    TC_ALL    API_Authen_003

    ${api_key_and_api_secret}=    Point API - Get api_key and api_secret

    ${request_api_key}=    Set Variable
    ${request_api_secret}=    Set Variable    ${api_key_and_api_secret[1]}
    ${expect_error_msg}=    Set Variable    "The api_key is required"

    ${request_body}=    Point API - Create Request Api Authen    "${request_api_key}"    "${request_api_secret}"
    ${remove_node}=    Create List    api_key
    ${request_body}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response_body}=    Point API - Send Http Post Request    ${POINT_API_URL_AUTHEN}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_key

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response_body}    ${json_error_expect}

API_Authen_004 - To verify that API Authen return error message when system donot send API_Key and API_Secret
    [Tags]    TC_ALL    API_Authen_004

    ${api_key_and_api_secret}=    Point API - Get api_key and api_secret

    ${request_api_key}=    Set Variable
    ${request_api_secret}=    Set Variable
    ${expect_error_msg}=    Set Variable    "The api_key is required, The api_secret is required"

    ${request_body}=    Point API - Create Request Api Authen    "${request_api_key}"    "${request_api_secret}"
    ${remove_node}=    Create List    api_key    api_secret
    ${request_body}=    Point API - Remove Node From Json Data    ${request_body}    ${remove_node}

    ${response_body}=    Point API - Send Http Post Request    ${POINT_API_URL_AUTHEN}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_key
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_secret

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response_body}    ${json_error_expect}

API_Authen_006 - To verify that API Authen return error message when system send incorrect Request URL
    [Tags]    TC_ALL    API_Authen_006

    ${api_key_and_api_secret}=    Point API - Get api_key and api_secret

    ${request_api_key}=    Set Variable    ${api_key_and_api_secret[0]}
    ${request_api_secret}=    Set Variable    ${api_key_and_api_secret[1]}
    ${expect_error_msg}=    Set Variable    "Service not found or unavailable"

    ${request_body}=    Point API - Create Request Api Authen    "${request_api_key}"    "${request_api_secret}"
    ${response_body}=    Point API - Send Http Post Request    ${POINT_API_URL_AUTHEN}/wrong-api    ${request_body}    404

    ${json_error}=    Set Variable    {}

    ${json_error_expect}=    Point API - Get Error For Expect Data    ${json_error}    server_not_found

    Point API - Verify Response Error    ${response_body}    ${json_error_expect}

API_Authen_007 - To verify that API Authen return error message when system send invalid API_Key
    [Tags]    TC_ALL    API_Authen_007

    ${api_key_and_api_secret}=    Point API - Get api_key and api_secret

    ${wrong_api_key}=    Set Variable    000
    ${request_api_key}=    Set Variable    ${api_key_and_api_secret[0]}${wrong_api_key}
    ${request_api_secret}=    Set Variable    ${api_key_and_api_secret[1]}
    ${expect_error_msg}=    Set Variable    "Invalid api_key or api_secret"

    ${request_body}=    Point API - Create Request Api Authen    "${request_api_key}"    "${request_api_secret}"
    ${response_body}=    Point API - Send Http Post Request    ${POINT_API_URL_AUTHEN}    ${request_body}    400

    ${json_error}=    Set Variable    {}

    ${json_error_expect}=    Point API - Get Error For Expect Data    ${json_error}    invalid_api_key_or_api_secret

    Point API - Verify Response Error    ${response_body}    ${json_error_expect}

API_Authen_008 - To verify that API Authen return error message when system send invalid API_Key
    [Tags]    TC_ALL    API_Authen_008

    ${api_key_and_api_secret}=    Point API - Get api_key and api_secret

    ${wrong_api_secret}=    Set Variable    000
    ${request_api_key}=    Set Variable    ${api_key_and_api_secret[0]}
    ${request_api_secret}=    Set Variable    ${api_key_and_api_secret[1]}${wrong_api_secret}
    ${expect_error_msg}=    Set Variable    "Invalid api_key or api_secret"

    ${request_body}=    Point API - Create Request Api Authen    "${request_api_key}"    "${request_api_secret}"
    ${response_body}=    Point API - Send Http Post Request    ${POINT_API_URL_AUTHEN}    ${request_body}    400

    ${json_error}=    Set Variable    {}

    ${json_error_expect}=    Point API - Get Error For Expect Data    ${json_error}    invalid_api_key_or_api_secret

    Point API - Verify Response Error    ${response_body}    ${json_error_expect}

API_Authen_009 - To verify that API Authen return error message when system donot send value of API_Key
    [Tags]    TC_ALL    API_Authen_009

    ${api_key_and_api_secret}=    Point API - Get api_key and api_secret

    ${request_api_key}=    Set Variable
    ${request_api_secret}=    Set Variable    ${api_key_and_api_secret[1]}
    ${expect_error_msg}=    Set Variable    "The api_key is required"

    ${request_body}=    Point API - Create Request Api Authen    "${request_api_key}"    "${request_api_secret}"
    ${response_body}=    Point API - Send Http Post Request    ${POINT_API_URL_AUTHEN}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_key

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response_body}    ${json_error_expect}

API_Authen_010 - To verify that API Authen return error message when system donot send value of API_Secrect
    [Tags]    TC_ALL    API_Authen_010

    ${api_key_and_api_secret}=    Point API - Get api_key and api_secret

    ${request_api_key}=    Set Variable    ${api_key_and_api_secret[0]}
    ${request_api_secret}=    Set Variable
    ${expect_error_msg}=    Set Variable    "The api_secret is required"

    ${request_body}=    Point API - Create Request Api Authen    "${request_api_key}"    "${request_api_secret}"
    ${response_body}=    Point API - Send Http Post Request    ${POINT_API_URL_AUTHEN}    ${request_body}    400

   ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_secret

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response_body}    ${json_error_expect}

API_Authen_011 - To verify that API Authen return error message when system donot send value of all nodes
    [Tags]    TC_ALL    API_Authen_011

    ${api_key_and_api_secret}=    Point API - Get api_key and api_secret

    ${request_api_key}=    Set Variable
    ${request_api_secret}=    Set Variable
    ${expect_error_msg}=    Set Variable    "The api_key is required, The api_secret is required"

    ${request_body}=    Point API - Create Request Api Authen    "${request_api_key}"    "${request_api_secret}"
    ${response_body}=    Point API - Send Http Post Request    ${POINT_API_URL_AUTHEN}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_key
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_secret

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response_body}    ${json_error_expect}

API_Authen_012 - To verify that API Authen return error message when system send value of API_Key = null
    [Tags]    TC_ALL    API_Authen_012

    ${api_key_and_api_secret}=    Point API - Get api_key and api_secret

    ${request_api_key}=    Set Variable    null
    ${request_api_secret}=    Set Variable    ${api_key_and_api_secret[1]}
    ${expect_error_msg}=    Set Variable    "Invalid api_key or api_secret"

    ${request_body}=    Point API - Create Request Api Authen    ${request_api_key}    "${request_api_secret}"

    ${response_body}=    Point API - Send Http Post Request    ${POINT_API_URL_AUTHEN}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_key

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response_body}    ${json_error_expect}

API_Authen_013 - To verify that API Authen return error message when system send value of API_Secret = null
    [Tags]    TC_ALL    API_Authen_013

    ${api_key_and_api_secret}=    Point API - Get api_key and api_secret

    ${request_api_key}=    Set Variable    ${api_key_and_api_secret[0]}
    ${request_api_secret}=    Set Variable    null
    ${expect_error_msg}=    Set Variable    "Invalid api_key or api_secret"

    ${request_body}=    Point API - Create Request Api Authen    "${request_api_key}"    ${request_api_secret}
    ${response_body}=    Point API - Send Http Post Request    ${POINT_API_URL_AUTHEN}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_secret

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response_body}    ${json_error_expect}

API_Authen_014 - To verify that API Authen return error message when system send value of all nodes = null
    [Tags]    TC_ALL    API_Authen_014

    ${api_key_and_api_secret}=    Point API - Get api_key and api_secret

    ${request_api_key}=    Set Variable    null
    ${request_api_secret}=    Set Variable    null
    ${expect_error_msg}=    Set Variable    "Invalid api_key or api_secret"

    ${request_body}=    Point API - Create Request Api Authen    ${request_api_key}    ${request_api_secret}
    ${response_body}=    Point API - Send Http Post Request    ${POINT_API_URL_AUTHEN}    ${request_body}    400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_key
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_secret

    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}

    Point API - Verify Response Error    ${response_body}    ${json_error_expect}