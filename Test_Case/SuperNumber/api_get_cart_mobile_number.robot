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
Resource    ${CURDIR}/../../Keyword/Portal/PCMS/TruemoveH/keywords_super_number.robot


*** Variable ***
${mobile_number}     0000000010
${api_key}    2952505724
${api_secret}    13eda61450bac36b5a12
${back_url}      http://www.google.com
${SP_ENV_PCMS}    Y

*** Test Cases ***
TC_ITMWM_07583 To verify that api get cart mobile number return mobile number and package from DB correctly.
    [Tags]    TC_ITMWM_07583    regression    ready

    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot

    Clear Prepared Proposition and Price Plan    ${unique_id}    ${unique_id}
    SuperNumber - Delete Data With Import Lot And Company Code    ${unique_id}

    ${proposition_id}    ${price_plan_id}=    Prepare Proposition and Price Plan     ${unique_id}    ${unique_id}
    ${expired_date}=     Get Current Date    result_format=datetime    exclude_millis=true    increment=+3days
    SuperNumber - Insert Mobile Number     ${unique_id}    1    ${mobile_number}    4    1    ${proposition_id}    ${expired_date}

    SuperNumber - Send Api Prepare Cart   ${api_key}    ${api_secret}    ${mobile_number}    ${price_plan_id}    ${back_url}
    ${response}=    Get Cart Mobile Number      ${mobile_number}       ${price_plan_id}
    ${url_key}=     Set Variable    ${response[0]}

    ${mobile_id}=     SuperNumber - Get Mobile Id By Mobile Number     ${mobile_number}

    ${url_path}=    Set Variable    /api/v2/45311375168544/truemoveh/mobile/get-cart-truemoveh?url_key=${url_key}
    ${result}=      SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_200}

    ${result_status}=           Get Json Value    ${result}    /status
    ${result_code}=             Get Json Value    ${result}    /code
    ${result_message}=          Get Json Value    ${result}    /message
    ${result_mobile_id}=    Get Json Value    ${result}    /data/mobile_id
    ${result_mobile_number}=    Get Json Value    ${result}    /data/mobile_number
    ${result_price_plan_id}=    Get Json Value    ${result}    /data/price_plan_id

    Should Be Equal AS Strings     ${result_status}           "success"
    Should Be Equal As Strings     ${result_code}             "200"
    Should Be Equal AS Strings     ${result_message}          "200 OK"
    Should Be Equal As Strings     ${result_mobile_id}        ${mobile_id}
    Should Be Equal As Strings     ${result_mobile_number}    "${mobile_number}"
    Should Be Equal As Strings     ${result_price_plan_id}    ${price_plan_id}

    [Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_id}

TC_ITMWM_07584 To verify that api get cart mobile number return empty array when send url_key that not exist in DB.
    [Tags]    TC_ITMWM_07584    regression    ready

    ${url_path}=    Set Variable    /api/v2/45311375168544/truemoveh/mobile/get-cart-truemoveh?url_key=999
    ${result}=      SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_200}

    ${result_status}=     Get Json Value    ${result}    /status
    ${result_code}=       Get Json Value    ${result}    /code
    ${result_message}=    Get Json Value    ${result}    /message

    Should Be Equal AS Strings     ${result_status}     "error"
    Should Be Equal As Strings     ${result_code}       "${RESULT_HEADER_400}"
    Should Be Equal AS Strings     ${result_message}    "Url key not found"

TC_ITMWM_07585 To verify that api get cart mobile number return error response if does not send url_key with API.
    [Tags]    TC_ITMWM_07585    regression    ready


    ${url_path}=    Set Variable    /api/v2/45311375168544/truemoveh/mobile/get-cart-truemoveh?url_key=
    ${result}=      SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_200}

    ${result_status}=     Get Json Value    ${result}    /status
    ${result_code}=       Get Json Value    ${result}    /code
    ${result_message}=    Get Json Value    ${result}    /message

    Should Be Equal AS Strings     ${result_status}     "error"
    Should Be Equal As Strings     ${result_code}       ${RESULT_HEADER_400}
    Should Be Equal AS Strings     ${result_message}    "Url key is required"

TC_ITMWM_07585 To verify that api get cart mobile number return error response if doesn't have Mobile Number with API.
    [Tags]    TC_ITMWM_07585    regression    ready

    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot

    Clear Prepared Proposition and Price Plan    ${unique_id}    ${unique_id}
    SuperNumber - Delete Data With Import Lot And Company Code    ${unique_id}

    ${proposition_id}    ${price_plan_id}=    Prepare Proposition and Price Plan     ${unique_id}    ${unique_id}
    ${expired_date}=     Get Current Date    result_format=datetime    exclude_millis=true    increment=+3days
    SuperNumber - Insert Mobile Number     ${unique_id}    1    ${mobile_number}    4    1    ${proposition_id}    ${expired_date}

    SuperNumber - Send Api Prepare Cart   ${api_key}    ${api_secret}    ${mobile_number}    ${price_plan_id}    ${back_url}
    ${response}=    Get Cart Mobile Number      ${mobile_number}       ${price_plan_id}
    ${url_key}=     Set Variable    ${response[0]}

    Supernumber - Change Mobile Number Data In Cart With Url Key    111    ${url_key}

    ${url_path}=    Set Variable    /api/v2/45311375168544/truemoveh/mobile/get-cart-truemoveh?url_key=${url_key}
    ${result}=      SuperNumber - Send Http Get Request    ${url_path}

    ${result_status}=     Get Json Value    ${result}    /status
    ${result_code}=       Get Json Value    ${result}    /code
    ${result_message}=    Get Json Value    ${result}    /message

    Should Be Equal AS Strings     ${result_status}     "error"
    Should Be Equal As Strings     ${result_code}       "${RESULT_HEADER_400}"
    Should Be Equal AS Strings     ${result_message}    "Mobile not found in table TruemovehMobile"

    [Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_id}

