*** Settings ***
Force Tags        WLS_Supernumber     WLS_High
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           DateTime
Resource          ${CURDIR}/../../Resource/init.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/TruemoveH/keywords_super_number.robot
Library           ${CURDIR}/../../Python_Library/truemoveh_import_mobile_number.py
Resource          ${CURDIR}/../../Keyword/API/api_super_number/keyword_super_number_common.robot

*** Variable ***
${mobile_number}     0000000013
${SP_ENV_PCMS}    Y

*** Test Cases ***

TC_ITMWM_07552 To verify that API can create cart mobile number successful.
    [Tags]    TC_ITMWM_07552    regression    ready
    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot

    Clear Prepared Proposition and Price Plan    ${unique_id}    ${unique_id}
    SuperNumber - Delete Data With Import Lot And Company Code    ${unique_id}

    ${proposition_id}    ${price_plan_id}=    Prepare Proposition and Price Plan     ${unique_id}    ${unique_id}
    ${expired_date}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=+3days
    SuperNumber - Insert Mobile Number     ${unique_id}    1    ${mobile_number}    4    1    ${proposition_id}    ${expired_date}
    ${response}=    SuperNumber - Send Api Prepare Cart   2952505724  13eda61450bac36b5a12    ${mobile_number}   ${price_plan_id}
    ${mobile_number_response}=     Get Json Value  ${response}     /data/mobile_number
    ${package_id_response}=        Get Json Value  ${response}     /data/package_id
    ${redirect_url_response}=      Get Json Value  ${response}     /data/redirect_url
    ${status}=            Get Response Status
    ${cart_data}=         Get Cart Mobile Number      ${mobile_number}       ${price_plan_id}
    Should Be Equal     200 OK    ${status}
    Should Be Equal As Strings     "${cart_data[1]}"    ${mobile_number_response}
    Should Be Equal As Strings     "${cart_data[2]}"    ${package_id_response}
    Should Contain                  ${redirect_url_response}     ${cart_data[0]}
    [Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_id}

TC_ITMWM_07553 To verify that API return code = error when system sent key = invalid.
    [Tags]    TC_ITMWM_07553    regression    ready
    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot

    Clear Prepared Proposition and Price Plan    ${unique_id}    ${unique_id}
    SuperNumber - Delete Data With Import Lot And Company Code    ${unique_id}

    ${proposition_id}    ${price_plan_id}=    Prepare Proposition and Price Plan     ${unique_id}    ${unique_id}
    ${expired_date}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=+3days
    SuperNumber - Insert Mobile Number     ${unique_id}    1    ${mobile_number}    4    1    ${proposition_id}    ${expired_date}
    ${response}=    SuperNumber - Send Api Prepare Cart   xxxxxxxxxxx  13eda61450bac36b5a12    ${mobile_number}   ${price_plan_id}   http://www.google.com   400
    ${status}=            Get Response Status
    ${error_message}=     Get Json Value  ${response}     /errorMessage

    Should Be Equal     400 Bad Request    ${status}
    Should Be Equal As Strings     "invalid api_key_or_secret"    ${error_message}
    [Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_id}

TC_ITMWM_07554 To verify that API return code = error when system sent key = null.
    [Tags]    TC_ITMWM_07554    regression    ready
    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot

    Clear Prepared Proposition and Price Plan    ${unique_id}    ${unique_id}
    SuperNumber - Delete Data With Import Lot And Company Code    ${unique_id}

    ${proposition_id}    ${price_plan_id}=    Prepare Proposition and Price Plan     ${unique_id}    ${unique_id}
    ${expired_date}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=+3days
    SuperNumber - Insert Mobile Number     ${unique_id}    1    ${mobile_number}    4    1    ${proposition_id}    ${expired_date}
    ${response}=    SuperNumber - Send Api Prepare Cart   ${EMPTY}  13eda61450bac36b5a12    ${mobile_number}     ${price_plan_id}   http://www.google.com   400
    ${status}=            Get Response Status
    ${error_message}=           Get Json Value  ${response}     /errorMessage
    ${error_code_data}=         Get Json Value  ${response}     /data/0/errorCode
    ${error_message_data}=      Get Json Value  ${response}     /data/0/data
    Should Be Equal                400 Bad Request          ${status}
    Should Be Equal As Strings     "invalid input"          ${error_message}
    Should Be Equal As Strings     "WMM4007"                ${error_code_data}
    Should Be Equal As Strings     "api key not exist"      ${error_message_data}
    [Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_id}

TC_ITMWM_07555 To verify that API return code = error when system sent secret = invalid.
    [Tags]    TC_ITMWM_07555    regression    ready
    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot

    Clear Prepared Proposition and Price Plan    ${unique_id}    ${unique_id}
    SuperNumber - Delete Data With Import Lot And Company Code    ${unique_id}

    ${proposition_id}    ${price_plan_id}=    Prepare Proposition and Price Plan     ${unique_id}    ${unique_id}
    ${expired_date}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=+3days
    SuperNumber - Insert Mobile Number     ${unique_id}    1    ${mobile_number}    4    1    ${proposition_id}    ${expired_date}
    ${response}=    SuperNumber - Send Api Prepare Cart   2952505724  ccccccccccc    ${mobile_number}   ${price_plan_id}  http://www.google.com  400
    ${status}=            Get Response Status
    ${error_message}=     Get Json Value  ${response}     /errorMessage
    Should Be Equal     400 Bad Request    ${status}
    Should Be Equal As Strings     "invalid api_key_or_secret"    ${error_message}
    [Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_id}

TC_ITMWM_07556 To verify that API return code = error when system sent secret = null.
    [Tags]    TC_ITMWM_07556    regression    ready
    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot

    Clear Prepared Proposition and Price Plan    ${unique_id}    ${unique_id}
    SuperNumber - Delete Data With Import Lot And Company Code    ${unique_id}

    ${proposition_id}    ${price_plan_id}=    Prepare Proposition and Price Plan     ${unique_id}    ${unique_id}
    ${expired_date}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=+3days
    SuperNumber - Insert Mobile Number     ${unique_id}    1    ${mobile_number}    4    1    ${proposition_id}    ${expired_date}
    ${response}=    SuperNumber - Send Api Prepare Cart   2952505724     ${EMPTY}    ${mobile_number}     ${price_plan_id}   http://www.google.com   400
    ${status}=            Get Response Status
    ${error_message}=           Get Json Value  ${response}     /errorMessage
    ${error_code_data}=         Get Json Value  ${response}     /data/0/errorCode
    ${error_message_data}=      Get Json Value  ${response}     /data/0/data
    Should Be Equal                400 Bad Request              ${status}
    Should Be Equal As Strings     "invalid input"              ${error_message}
    Should Be Equal As Strings     "WMM4007"                    ${error_code_data}
    Should Be Equal As Strings     "api secret not exist"       ${error_message_data}
    [Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_id}

TC_ITMWM_07557 To verify that API return code = error when system sent mobile = invalid.
    [Tags]    TC_ITMWM_07557    regression    ready
    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot

    Clear Prepared Proposition and Price Plan    ${unique_id}    ${unique_id}
    SuperNumber - Delete Data With Import Lot And Company Code    ${unique_id}

    ${proposition_id}    ${price_plan_id}=    Prepare Proposition and Price Plan     ${unique_id}    ${unique_id}
    ${expired_date}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=+3days
    SuperNumber - Insert Mobile Number     ${unique_id}    1    ${mobile_number}    4    1    ${proposition_id}    ${expired_date}
    ${response}=    SuperNumber - Send Api Prepare Cart   2952505724  13eda61450bac36b5a12    xxxxxx     ${price_plan_id}   http://www.google.com   400
    ${status}=            Get Response Status
    ${error_message}=           Get Json Value  ${response}     /errorMessage
    ${error_code_data}=         Get Json Value  ${response}     /data/0/errorCode
    ${error_message_data}=      Get Json Value  ${response}     /data/0/data
    Should Be Equal                400 Bad Request              ${status}
    Should Be Equal As Strings     "invalid input"              ${error_message}
    Should Be Equal As Strings     "WMM4008"                    ${error_code_data}
    Should Be Equal As Strings     "mobile number invalid on digit pattern"       ${error_message_data}
    [Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_id}

TC_ITMWM_07558 To verify that API return code = error when system sent mobile = null.
    [Tags]    TC_ITMWM_07558    regression    ready
    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot

    Clear Prepared Proposition and Price Plan    ${unique_id}    ${unique_id}
    SuperNumber - Delete Data With Import Lot And Company Code    ${unique_id}

    ${proposition_id}    ${price_plan_id}=    Prepare Proposition and Price Plan     ${unique_id}    ${unique_id}
    ${expired_date}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=+3days
    SuperNumber - Insert Mobile Number     ${unique_id}    1    ${mobile_number}    4    1    ${proposition_id}    ${expired_date}
    ${response}=    SuperNumber - Send Api Prepare Cart   2952505724  13eda61450bac36b5a12    ${EMPTY}   ${price_plan_id}   http://www.google.com   400
    ${status}=            Get Response Status
    ${error_message}=           Get Json Value  ${response}     /errorMessage
    ${error_code_data}=         Get Json Value  ${response}     /data/0/errorCode
    ${error_message_data}=      Get Json Value  ${response}     /data/0/data
    Should Be Equal                400 Bad Request              ${status}
    Should Be Equal As Strings     "invalid input"              ${error_message}
    Should Be Equal As Strings     "WMM4007"                    ${error_code_data}
    Should Be Equal As Strings     "mobile number not exist"       ${error_message_data}
    [Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_id}

TC_ITMWM_07559 To verify that API return code = error when system sent package = invalid.
    [Tags]    TC_ITMWM_07559    regression    ready
    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot

    Clear Prepared Proposition and Price Plan    ${unique_id}    ${unique_id}
    SuperNumber - Delete Data With Import Lot And Company Code    ${unique_id}

    ${proposition_id}    ${price_plan_id}=    Prepare Proposition and Price Plan     ${unique_id}    ${unique_id}
    ${expired_date}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=+3days
    SuperNumber - Insert Mobile Number     ${unique_id}    1    ${mobile_number}    4    1    ${proposition_id}    ${expired_date}
    ${response}=    SuperNumber - Send Api Prepare Cart   2952505724  13eda61450bac36b5a12    ${mobile_number}   xxxxxxx  http://www.google.com  400
    ${status}=            Get Response Status
    ${error_message}=     Get Json Value  ${response}     /errorMessage
    Should Be Equal     400 Bad Request    ${status}
    Should Be Equal As Strings     "package not match with mobile number"    ${error_message}
    [Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_id}

TC_ITMWM_07560 To verify that API return code = error when system sent package = null.
    [Tags]    TC_ITMWM_07560    regression    ready
    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot

    Clear Prepared Proposition and Price Plan    ${unique_id}    ${unique_id}
    SuperNumber - Delete Data With Import Lot And Company Code    ${unique_id}

    ${proposition_id}    ${price_plan_id}=    Prepare Proposition and Price Plan     ${unique_id}    ${unique_id}
    ${expired_date}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=+3days
    SuperNumber - Insert Mobile Number     ${unique_id}    1    ${mobile_number}    4    1    ${proposition_id}    ${expired_date}
    ${response}=    SuperNumber - Send Api Prepare Cart   2952505724  13eda61450bac36b5a12    ${mobile_number}   ${EMPTY}  http://www.google.com  400
    ${status}=            Get Response Status
    ${error_message}=           Get Json Value  ${response}     /errorMessage
    ${error_code_data}=         Get Json Value  ${response}     /data/0/errorCode
    ${error_message_data}=      Get Json Value  ${response}     /data/0/data
    Should Be Equal                400 Bad Request              ${status}
    Should Be Equal As Strings     "invalid input"              ${error_message}
    Should Be Equal As Strings     "WMM4007"                    ${error_code_data}
    Should Be Equal As Strings     "package id not exist"       ${error_message_data}
    [Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_id}

TC_ITMWM_07561 To verify that API return code = error when system sent the mobile number that not match with the key.
    [Tags]    TC_ITMWM_07561    regression    ready
    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot

    Clear Prepared Proposition and Price Plan    ${unique_id}    ${unique_id}
    SuperNumber - Delete Data With Import Lot And Company Code    ${unique_id}

    ${proposition_id}    ${price_plan_id}=    Prepare Proposition and Price Plan     ${unique_id}    ${unique_id}
    ${expired_date}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=+3days
    SuperNumber - Insert Mobile Number     ${unique_id}    1    ${mobile_number}    4    1    ${proposition_id}    ${expired_date}
    ${response}=    SuperNumber - Send Api Prepare Cart   2952505724  13eda61450bac36b5a12    0000000014   ${price_plan_id}  http://www.google.com  400
    ${status}=            Get Response Status
    ${error_message}=     Get Json Value  ${response}     /errorMessage
    Should Be Equal     400 Bad Request    ${status}
    Should Be Equal As Strings     "mobile number not match with key"    ${error_message}
    [Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_id}

TC_ITMWM_07562 To verify that API return code = error when system sent the mobile number that not match with the package.
    [Tags]    TC_ITMWM_07562    regression    ready
    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot

    Clear Prepared Proposition and Price Plan    ${unique_id}    ${unique_id}
    SuperNumber - Delete Data With Import Lot And Company Code    ${unique_id}

    ${proposition_id}    ${price_plan_id}=    Prepare Proposition and Price Plan     ${unique_id}    ${unique_id}
    ${expired_date}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=+3days
    SuperNumber - Insert Mobile Number     ${unique_id}    1    ${mobile_number}    4    1    ${proposition_id}    ${expired_date}
    ${response}=    SuperNumber - Send Api Prepare Cart   2952505724  13eda61450bac36b5a12    ${mobile_number}    xxx  http://www.google.com  400
    ${status}=            Get Response Status
    ${error_message}=     Get Json Value  ${response}     /errorMessage
    Should Be Equal     400 Bad Request    ${status}
    Should Be Equal As Strings     "package not match with mobile number"    ${error_message}
    [Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_id}

TC_ITMWM_07608 To verify that API return error response when system sent key that does not match with secret.
    [Tags]    TC_ITMWM_07608    regression    ready
    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot

    Clear Prepared Proposition and Price Plan    ${unique_id}    ${unique_id}
    SuperNumber - Delete Data With Import Lot And Company Code    ${unique_id}

    ${proposition_id}    ${price_plan_id}=    Prepare Proposition and Price Plan     ${unique_id}    ${unique_id}
    ${expired_date}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=+3days
    SuperNumber - Insert Mobile Number     ${unique_id}    1    ${mobile_number}    4    1    ${proposition_id}    ${expired_date}
    ${response}=    SuperNumber - Send Api Prepare Cart   295250572  13eda61450bac36b5a12    ${mobile_number}   ${price_plan_id}   http://www.robottest.com   400
    ${status}=            Get Response Status
    ${error_code}=        Get Json Value  ${response}   /errorCode
    ${error_message}=     Get Json Value  ${response}   /errorMessage
    Should Be Equal     400 Bad Request    ${status}
    Should Be Equal As Strings     "WMM4010"        ${error_code}
    Should Be Equal As Strings     "invalid api_key_or_secret"    ${error_message}
    [Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_id}

TC_ITMWM_07609 To verify that API return error response when system sent invalid back_url.
    [Tags]    TC_ITMWM_07609    regression    ready
    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot

    Clear Prepared Proposition and Price Plan    ${unique_id}    ${unique_id}
    SuperNumber - Delete Data With Import Lot And Company Code    ${unique_id}

    ${proposition_id}    ${price_plan_id}=    Prepare Proposition and Price Plan     ${unique_id}    ${unique_id}
    ${expired_date}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=+3days
    SuperNumber - Insert Mobile Number     ${unique_id}    1    ${mobile_number}    4    1    ${proposition_id}    ${expired_date}
    ${response}=    SuperNumber - Send Api Prepare Cart   2952505724  13eda61450bac36b5a12    ${mobile_number}   ${price_plan_id}   www.robottest.com   400
    ${status}=            Get Response Status
    ${error_code}=        Get Json Value  ${response}   /data/0/errorCode
    ${error_message}=     Get Json Value  ${response}   /data/0/errorMessage
    Should Be Equal     400 Bad Request    ${status}
    Should Be Equal As Strings     "WMM4009"        ${error_code}
    Should Be Equal As Strings     "field should be http://url or https://url"    ${error_message}
    [Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_id}

TC_ITMWM_07610 To verify that API return error response when system sent back_url = null.
    [Tags]    TC_ITMWM_07610    regression    ready
    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot

    Clear Prepared Proposition and Price Plan    ${unique_id}    ${unique_id}
    SuperNumber - Delete Data With Import Lot And Company Code    ${unique_id}

    ${proposition_id}    ${price_plan_id}=    Prepare Proposition and Price Plan     ${unique_id}    ${unique_id}
    ${expired_date}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=+3days
    SuperNumber - Insert Mobile Number     ${unique_id}    1    ${mobile_number}    4    1    ${proposition_id}    ${expired_date}
    ${response}=    SuperNumber - Send Api Prepare Cart   2952505724  13eda61450bac36b5a12    ${mobile_number}   ${price_plan_id}   ${EMPTY}   400
    ${status}=            Get Response Status
    ${error_code}=        Get Json Value  ${response}   /data/0/errorCode
    ${error_message}=     Get Json Value  ${response}   /data/0/errorMessage
    Should Be Equal     400 Bad Request    ${status}
    Should Be Equal As Strings     "WMM4007"        ${error_code}
    Should Be Equal As Strings     "field is required"    ${error_message}
    [Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_id}

TC_ITMWM_07618 To verify that API return error response when system didn't send any node.
    [Tags]    TC_ITMWM_07618    regression    ready
    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot

    Clear Prepared Proposition and Price Plan    ${unique_id}    ${unique_id}
    SuperNumber - Delete Data With Import Lot And Company Code    ${unique_id}

    ${proposition_id}    ${price_plan_id}=    Prepare Proposition and Price Plan     ${unique_id}    ${unique_id}
    ${expired_date}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=+3days
    SuperNumber - Insert Mobile Number     ${unique_id}    1    ${mobile_number}    4    1    ${proposition_id}    ${expired_date}
    ${response}=    SuperNumber - Send Api Prepare Cart   ${EMPTY}  ${EMPTY}    ${EMPTY}   ${EMPTY}   ${EMPTY}   400
    ${status}=            Get Response Status
    Log To Console   ${response}
    ${data_api_key}=                    Get Json Value  ${response}   /data/0/data
    ${data_api_secret}=                 Get Json Value  ${response}   /data/1/data
    ${data_mobile_number}=              Get Json Value  ${response}   /data/2/data
    ${data_package_id}=                 Get Json Value  ${response}   /data/3/data
    ${data_back_url}=                   Get Json Value  ${response}   /data/4/data
    ${error_code_api_key}=              Get Json Value  ${response}   /data/0/errorCode
    ${error_code_api_secret}=           Get Json Value  ${response}   /data/1/errorCode
    ${error_code_mobile_number}=        Get Json Value  ${response}   /data/2/errorCode
    ${error_code_package_id}=           Get Json Value  ${response}   /data/3/errorCode
    ${error_code_back_url}=             Get Json Value  ${response}   /data/4/errorCode
    ${error_message_api_key}=           Get Json Value  ${response}   /data/0/errorMessage
    ${error_message_api_secret}=        Get Json Value  ${response}   /data/1/errorMessage
    ${error_message_mobile_number}=     Get Json Value  ${response}   /data/2/errorMessage
    ${error_message_package_id}=        Get Json Value  ${response}   /data/3/errorMessage
    ${error_message_back_url}=          Get Json Value  ${response}   /data/4/errorMessage
    Should Be Equal     400 Bad Request    ${status}
    Should Be Equal As Strings     "api key not exist"          ${data_api_key}
    Should Be Equal As Strings     "api secret not exist"       ${data_api_secret}
    Should Be Equal As Strings     "mobile number not exist"    ${data_mobile_number}
    Should Be Equal As Strings     "package id not exist"       ${data_package_id}
    Should Be Equal As Strings     "back url not exist"         ${data_back_url}
    Should Be Equal As Strings     "WMM4007"        ${error_code_api_key}
    Should Be Equal As Strings     "WMM4007"        ${error_code_api_secret}
    Should Be Equal As Strings     "WMM4007"        ${error_code_mobile_number}
    Should Be Equal As Strings     "WMM4007"        ${error_code_package_id}
    Should Be Equal As Strings     "WMM4007"        ${error_code_back_url}
    Should Be Equal As Strings     "field is required"    ${error_message_api_key}
    Should Be Equal As Strings     "field is required"    ${error_message_api_secret}
    Should Be Equal As Strings     "field is required"    ${error_message_mobile_number}
    Should Be Equal As Strings     "field is required"    ${error_message_package_id}
    Should Be Equal As Strings     "field is required"    ${error_message_back_url}
    [Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_id}