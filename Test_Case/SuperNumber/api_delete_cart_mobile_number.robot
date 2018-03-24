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
${mobile_number}     0000000011
${api_key}    2952505724
${api_secret}    13eda61450bac36b5a12
${SP_ENV_PCMS}    Y

*** Test Cases ***
TC_ITMWM_07586 To verify that api delete cart mobile number return true response and delete data if send api with correct url_key.
    [Tags]    TC_ITMWM_07586    regression    ready

    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot

    Clear Prepared Proposition and Price Plan    ${unique_id}    ${unique_id}
    SuperNumber - Delete Data With Import Lot And Company Code    ${unique_id}

    ${proposition_id}    ${price_plan_id}=    Prepare Proposition and Price Plan     ${unique_id}    ${unique_id}
    ${expired_date}=     Get Current Date    result_format=datetime    exclude_millis=true    increment=+3days
    SuperNumber - Insert Mobile Number     ${unique_id}    1    ${mobile_number}    4    1    ${proposition_id}    ${expired_date}

    SuperNumber - Send Api Prepare Cart   ${api_key}    ${api_secret}    ${mobile_number}    ${price_plan_id}
    ${response}=    Get Cart Mobile Number      ${mobile_number}       ${price_plan_id}
    ${url_key}=     Set Variable    ${response[0]}

    ${url_path}=    Set Variable    /api/v2/4904898372939/truemoveh/mobile/delete-cart-truemoveh?url_key=${url_key}
    ${result}=      SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_200}

    ${result_status}=      Get Json Value    ${result}    /status
    ${result_code}=        Get Json Value    ${result}    /code
    ${result_message}=     Get Json Value    ${result}    /message

    Should Be Equal AS Strings     ${result_status}           "success"
    Should Be Equal As Strings     ${result_code}             "200"
    Should Be Equal AS Strings     ${result_message}          "200 OK"

    ${url_path}=    Set Variable    /api/v2/45311375168544/truemoveh/mobile/get-cart-truemoveh?url_key=${url_key}
    ${result}=      SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_200}

    [Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_id}

TC_ITMWM_07587 To verify that api delete cart mobile number return false response and if send url_key that not exist in DB..
    [Tags]    TC_ITMWM_07587    regression    ready

    ${url_path}=    Set Variable    /api/v2/4904898372939/truemoveh/mobile/delete-cart-truemoveh?url_key=999
    ${result}=      SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_200}

    ${result_status}=      Get Json Value    ${result}    /status
    ${result_code}=        Get Json Value    ${result}    /code
    ${result_message}=     Get Json Value    ${result}    /message
    ${result_data}=        Get Json Value    ${result}    /data

    Should Be Equal AS Strings     ${result_status}           "success"
    Should Be Equal As Strings     ${result_code}             "200"
    Should Be Equal AS Strings     ${result_message}          "200 OK"
    Should Be Equal As Strings     ${result_data}             false

    ${url_path}=    Set Variable    /api/v2/4904898372939/truemoveh/mobile/delete-cart-truemoveh?url_key=NULL
    ${result}=      SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_200}

    ${result_status}=      Get Json Value    ${result}    /status
    ${result_code}=        Get Json Value    ${result}    /code
    ${result_message}=     Get Json Value    ${result}    /message
    ${result_data}=        Get Json Value    ${result}    /data

    Should Be Equal AS Strings     ${result_status}           "success"
    Should Be Equal As Strings     ${result_code}             "200"
    Should Be Equal AS Strings     ${result_message}          "200 OK"
    Should Be Equal As Strings     ${result_data}             false


TC_ITMWM_07588 To verify that api delete cart mobile number return error response if does not send url_key with API.
    [Tags]    TC_ITMWM_07588    regression    ready


    ${url_path}=    Set Variable    /api/v2/4904898372939/truemoveh/mobile/delete-cart-truemoveh?url_key=
    ${result}=      SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_200}

    ${result_status}=     Get Json Value    ${result}    /status
    ${result_code}=       Get Json Value    ${result}    /code
    ${result_message}=    Get Json Value    ${result}    /message

    Should Be Equal AS Strings     ${result_status}     "error"
    Should Be Equal As Strings     ${result_code}       ${RESULT_HEADER_400}
    Should Be Equal AS Strings     ${result_message}    "Url key is required"

