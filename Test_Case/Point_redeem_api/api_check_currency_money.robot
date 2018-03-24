*** Settings ***
Library         Selenium2Library
Library         Collections
Library         String
Library         OperatingSystem
Library         HttpLibrary.HTTP

Resource        ${CURDIR}/../../Keyword/Portal/Point_redeem_api/Keywords_point_api.robot
Resource        ${CURDIR}/../../Keyword/API/common/api_keywords.robot
Resource        ${CURDIR}/../../Resource/Config/${ENV}/Env_config.robot


*** Variables ***
${api_key}    1464942680
${api_secret}    95991a646701
${converter_url}     /v1/converter/money

${partner_id}   1
${total_point}   100

*** Test Cases ***

API_Check_Currecy_Money_001 - To verify that API Check Currency Money return correct money
    [Tags]      TC_ALL      API_Check_Currecy_Money_001
    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${request}=    Point API - Create Request Api Check Currency Money    "${api_token}"    "${partner_id}"    "${total_point}"
    ${response}=    Point API - Send Http Post Request    ${converter_url}    ${request}
    Point API - Compare Json Value      ${request}      /partner_id            ${response}        /data/partner_id
    Point API - Compare Json Value      ${request}      /total_point           ${response}        /data/total_point

    Point API - Compare Json Value      ${request}      /keys/0/sequence       ${response}        /data/keys/0/sequence
    Point API - Compare Json Value      ${request}      /keys/0/key            ${response}        /data/keys/0/key
    Point API - Compare Json Value      ${request}      /keys/0/price          ${response}        /data/keys/0/price

    Point API - Compare Json Value      ${request}      /keys/1/sequence       ${response}        /data/keys/1/sequence
    Point API - Compare Json Value      ${request}      /keys/1/key            ${response}        /data/keys/1/key
    Point API - Compare Json Value      ${request}      /keys/1/price          ${response}        /data/keys/1/price


API_Check_Currecy_Money_002 - To verify that API Check Currency Money return return error message when system donot send Partner_ID and Total_Point node
    [Tags]      TC_ALL      API_Check_Currecy_Money_002
    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${request}=     Point API - Create Request Api Check Currency Money    "${api_token}"    "${partner_id}"    "${total_point}"
    ${remove_node}=    Create List     partner_id          total_point
    ${request}=     Point API - Remove Node From Json Data          ${request}          ${remove_node}
    ${response}=    Point API - Send Http Post Request    ${converter_url}    ${request}        400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    total_point
    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}
    Point API - Verify Response Error    ${response}    ${json_error_expect}


API_Check_Currecy_Money_003 - To verify that API Check Currency Money return return error message when system donot send Total_Point node
    [Tags]      TC_ALL      API_Check_Currecy_Money_003
    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${request}=     Point API - Create Request Api Check Currency Money    "${api_token}"    "${partner_id}"    "${total_point}"
    ${remove_node}=    Create List      total_point
    ${request}=     Point API - Remove Node From Json Data          ${request}          ${remove_node}
    ${response}=    Point API - Send Http Post Request    ${converter_url}    ${request}        400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    total_point
    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}
    Point API - Verify Response Error    ${response}    ${json_error_expect}


API_Check_Currecy_Money_004 - To verify that API Check Currency Money return return error message when system donot send API_Token and Total_Point node
    [Tags]      TC_ALL      API_Check_Currecy_Money_004
    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${request}=     Point API - Create Request Api Check Currency Money    "${api_token}"    "${partner_id}"    "${total_point}"
    ${remove_node}=    Create List      api_token               total_point
    ${request}=     Point API - Remove Node From Json Data          ${request}          ${remove_node}
    ${response}=    Point API - Send Http Post Request    ${converter_url}    ${request}        400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    total_point
    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}
    Point API - Verify Response Error    ${response}    ${json_error_expect}


API_Check_Currecy_Money_005 - To verify that API Check Currency Money return return error message when system donot send API_Token node
    [Tags]      TC_ALL      API_Check_Currecy_Money_005
    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${request}=     Point API - Create Request Api Check Currency Money    "${api_token}"    "${partner_id}"    "${total_point}"
    ${remove_node}=    Create List      api_token
    ${request}=     Point API - Remove Node From Json Data          ${request}          ${remove_node}
    ${response}=    Point API - Send Http Post Request    ${converter_url}    ${request}        400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}
    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Check_Currecy_Money_006 - To verify that API Check Currency Money return return error message when system donot send API_Token and Partner_ID node
    [Tags]      TC_ALL      API_Check_Currecy_Money_006
    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${request}=     Point API - Create Request Api Check Currency Money    "${api_token}"    "${partner_id}"    "${total_point}"
    ${remove_node}=    Create List      api_token           partner_id
    ${request}=     Point API - Remove Node From Json Data          ${request}          ${remove_node}
    ${response}=    Point API - Send Http Post Request    ${converter_url}    ${request}        400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}
    Point API - Verify Response Error    ${response}    ${json_error_expect}


API_Check_Currecy_Money_007 - To verify that API Check Currency Money return return error message when system donot send Partner_ID node
    [Tags]      TC_ALL      API_Check_Currecy_Money_007
    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${request}=     Point API - Create Request Api Check Currency Money    "${api_token}"    "${partner_id}"    "${total_point}"
    ${remove_node}=    Create List      partner_id
    ${request}=     Point API - Remove Node From Json Data          ${request}          ${remove_node}
    ${response}=    Point API - Send Http Post Request    ${converter_url}    ${request}        400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require    partner_id
    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}
    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Check_Currecy_Money_008 - To verify that API Check Currency Money return return error message when system donot send all node
    [Tags]      TC_ALL      API_Check_Currecy_Money_008
    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${request}=     Point API - Create Request Api Check Currency Money    "${api_token}"    "${partner_id}"    "${total_point}"
    ${response}=    Point API - Send Http Post Request    ${converter_url}    {}        400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require     api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require     partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require     total_point
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require     keys
    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}
    Point API - Verify Response Error    ${response}    ${json_error_expect}

# API_Check_Currecy_Money_009 - To verify that API Check Currency Money return return error message when system cannot connect database
#     [Tags]      TC_ALL      API_Check_Currecy_Money_009


API_Check_Currecy_Money_010 - To verify that API Check Currency Money return return error message when system send invalid API_Token node
    [Tags]      TC_ALL      API_Check_Currecy_Money_010
    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${request}=     Point API - Create Request Api Check Currency Money    "${api_token}"    "${partner_id}"    "${total_point}"
    ${request}=    Set Json Value       ${request}    /api_token    "Hello world"
    ${response}=    Point API - Send Http Post Request    ${converter_url}    ${request}        400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    invalid_token
    Point API - Verify Response Error       ${response}    ${json_error}


API_Check_Currecy_Money_011 - To verify that API Check Currency Money return return error message when system send invalid Partner_ID node
    [Tags]      TC_ALL      API_Check_Currecy_Money_011
    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${request}=     Point API - Create Request Api Check Currency Money    "${api_token}"    "${partner_id}"    "${total_point}"
    ${request}=    Set Json Value       ${request}    /partner_id    "12345"
    ${response}=    Point API - Send Http Post Request    ${converter_url}    ${request}        400
    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    partner_id_wrong
    Point API - Verify Response Error Without Data Node     ${response}         ${json_error}

API_Check_Currecy_Money_012 - To verify that API Check Currency Money return return error message when system send invalid Total_Point node
    [Tags]      TC_ALL      API_Check_Currecy_Money_012
    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${request}=     Point API - Create Request Api Check Currency Money    "${api_token}"    "${partner_id}"    "${total_point}"
    ${request}=    Set Json Value       ${request}    /total_point    "Hello"
    ${response}=    Point API - Send Http Post Request    ${converter_url}    ${request}        400
    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    invalid_input
    Point API - Verify Response Error Without Data Node     ${response}         ${json_error}

API_Check_Currecy_Money_013 - To verify that API Check Currency Money return return error message when system donot send value of API_Token node
    [Tags]      TC_ALL      API_Check_Currecy_Money_013
    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${request}=     Point API - Create Request Api Check Currency Money    ""    "${partner_id}"    "${total_point}"
    ${response}=    Point API - Send Http Post Request    ${converter_url}    ${request}        400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require     api_token
    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}
    Point API - Verify Response Error    ${response}    ${json_error_expect}


API_Check_Currecy_Money_014 - To verify that API Check Currency Money return return error message when system donot send value of Partner_ID node
    [Tags]      TC_ALL      API_Check_Currecy_Money_014
    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${request}=     Point API - Create Request Api Check Currency Money    "${api_token}"    ""    "${total_point}"
    ${response}=    Point API - Send Http Post Request    ${converter_url}    ${request}        400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require     partner_id
    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}
    Point API - Verify Response Error    ${response}    ${json_error_expect}


API_Check_Currecy_Money_015 - To verify that API Check Currency Money return return error message when system donot send value of Total_Point node
    [Tags]      TC_ALL      API_Check_Currecy_Money_015
    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${request}=     Point API - Create Request Api Check Currency Money    "${api_token}"    "${partner_id}"    ""
    ${response}=    Point API - Send Http Post Request    ${converter_url}    ${request}        400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require     total_point
    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}
    Point API - Verify Response Error    ${response}    ${json_error_expect}


API_Check_Currecy_Money_016 - To verify that API Check Currency Money return return error message when system donot send value of all nodes
    [Tags]      TC_ALL      API_Check_Currecy_Money_016
    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${request}=     Point API - Create Request Api Check Currency Money    ""    ""    ""
    ${response}=    Point API - Send Http Post Request    ${converter_url}    ${request}        400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require     api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require     partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require     total_point
    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}
    Point API - Verify Response Error    ${response}    ${json_error_expect}


API_Check_Currecy_Money_017 - To verify that API Check Currency Money return return error message when system donot send value of API_Token node = null
    [Tags]      TC_ALL      API_Check_Currecy_Money_017
    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${request}=     Point API - Create Request Api Check Currency Money    null    "${partner_id}"    "${total_point}"
    ${response}=    Point API - Send Http Post Request    ${converter_url}    ${request}        400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require     api_token
    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}
    Point API - Verify Response Error    ${response}    ${json_error_expect}

API_Check_Currecy_Money_018 - To verify that API Check Currency Money return return error message when system donot send value of Partner_ID node = null
    [Tags]      TC_ALL      API_Check_Currecy_Money_018
    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${request}=     Point API - Create Request Api Check Currency Money    "${api_token}"    null    "${total_point}"
    ${response}=    Point API - Send Http Post Request    ${converter_url}    ${request}        400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require     partner_id
    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}
    Point API - Verify Response Error    ${response}    ${json_error_expect}


API_Check_Currecy_Money_019 - To verify that API Check Currency Money return return error message when system donot send value of Total_Point node = null
    [Tags]      TC_ALL      API_Check_Currecy_Money_019
    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${request}=     Point API - Create Request Api Check Currency Money    "${api_token}"    "${partner_id}"    null
    ${response}=    Point API - Send Http Post Request    ${converter_url}    ${request}        400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require     total_point
    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}
    Point API - Verify Response Error    ${response}    ${json_error_expect}


API_Check_Currecy_Money_020 - To verify that API Check Currency Money return return error message when system donot send value of all nodes = null
    [Tags]      TC_ALL      API_Check_Currecy_Money_020
    ${api_token}=    Point API - Get API Token From Authen    ${api_key}    ${api_secret}
    ${request}=     Point API - Create Request Api Check Currency Money    null    null    null
    ${response}=    Point API - Send Http Post Request    ${converter_url}    ${request}        400

    ${json_error}=    Set Variable    {}
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require     api_token
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require     partner_id
    ${json_error}=    Point API - Get Error For Expect Data    ${json_error}    require     total_point
    ${json_error_expect}=    Point API - Get Multiple Error Invalid Input    ${json_error}
    Point API - Verify Response Error    ${response}    ${json_error_expect}
