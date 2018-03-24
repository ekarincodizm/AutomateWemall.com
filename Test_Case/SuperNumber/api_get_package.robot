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
${sub_description_1}=    Robot Sub_Desc ITMB-2110_1
${description_1}=    Robot Long_Desc ITMB-2110_1
${sub_description_2}=    Robot Sub_Desc ITMB-2110_2
${description_2}=    Robot Long_Desc ITMB-2110_2
${recommend_y}=    Y
${recommend_n}=    N

*** Test Cases ***

TC_ITMWM_07573 To verify that api get package by mobile number return error response if send api without mobile number.
    [Tags]  TC_ITMWM_07573  regression    ready

    ${value} =  Get Variable Value  ${SP_ENV_PCMS}
    Log To Console    value = ${value}
    ${RESULT_HEADER}=    Run Keyword If    '${value}' == 'None'    Set Variable    403
    ...    ELSE    Set Variable    ${RESULT_HEADER_404}
    ${message}=    Run Keyword If    '${value}' == 'None'    Set Variable    Missing Authentication Token
    ...    ELSE    Set Variable    404 NOT FOUND

    ${result}=    SuperNumber - Send Http Get Request     /mobile-number/package/${API_KEY}/       ${RESULT_HEADER}

    Should Contain    ${result}    ${message}

TC_ITMWM_07574 To verify that api get package by mobile number return error response if send api without api key.
    [Tags]  TC_ITMWM_07574  regression    ready

    ${value} =  Get Variable Value  ${SP_ENV_PCMS}
    Log To Console    value = ${value}

    ${result}=    SuperNumber - Send Http Get Request     /mobile-number/package//${MOBILE_NUMBER}     ${RESULT_HEADER_404}

    ${message}=    Run Keyword If    '${value}' == 'None'    SuperNumber - Verify Response Fail   ${result}    ${ERROR_CODE_WMM4001}    ${ERROR_MESSAGE_WMM4001}
    ...    ELSE    Should Contain    ${result}    404 NOT FOUND

TC_ITMWM_07575 To verify that api get package by mobile number return error response if send api with invalid api key.
    [Tags]  TC_ITMWM_07575  regression    ready
    ${invalid_api_key}=     Set Variable    0000000000
    ${response}=    SuperNumber - Send Http Get Request     /mobile-number/package/${invalid_api_key}/${MOBILE_NUMBER}      ${RESULT_HEADER_404}
    SuperNumber - Verify Response Fail   ${response}    ${ERROR_CODE_WMM4001}    ${ERROR_MESSAGE_WMM4001}


TC_ITMWM_07576 To verify that api get package by mobile number return error response if send api with invalid mobile number.
    [Tags]  TC_ITMWM_07576  regression    ready
    ${invalid_mobile_number}=     Set Variable    abc0000010101
    ${response}=    SuperNumber - Send Http Get Request     /mobile-number/package/${API_KEY}/${invalid_mobile_number}      ${RESULT_HEADER_404}
    SuperNumber - Verify Response Fail   ${response}    ${ERROR_CODE_WMM4002}    ${ERROR_MESSAGE_WMM4002}

TC_ITMWM_07577 To verify that api get package by mobile number return error response if send api with mobile number that not exist in system.
    [Tags]  TC_ITMWM_07577  regression    ready
    ${mobile_number}=    Set Variable    0177777779
    ${response}=    SuperNumber - Send Http Get Request     /mobile-number/package/${API_KEY}/${mobile_number}      ${RESULT_HEADER_404}
    SuperNumber - Verify Response Fail   ${response}    ${ERROR_CODE_WMM4003}    ${ERROR_MESSAGE_WMM4003}

TC_ITMWM_07578 To verify that api get package by mobile number return error response if send api with mobile number that exist in system but does not match with api key.
    [Tags]    TC_ITMWM_07578    regression    ready
    ${mobile_number}=    Set Variable    0100070009
    ${mobile_type}=    Set Variable    1
    ${merchant_key}=    Set Variable    2952505724
    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot

    Clear Prepared Proposition and Price Plan    ${unique_id}    ${unique_id}
    SuperNumber - Delete Data With Import Lot And Company Code    ${unique_id}

    ${proposition_id}    ${price_plan_id}=    Prepare Proposition and Price Plan     ${unique_id}    ${unique_id}
    ${expired_date}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=+3days
    SuperNumber - Insert Mobile Number     ${unique_id}    1    ${mobile_number}    ${mobile_type}    1    ${proposition_id}    ${expired_date}

    ${url_path}=    Set Variable    /mobile-number/package/${merchant_key}/${mobile_number}
    ${result}=    SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_404}
    SuperNumber - Verify Response Fail   ${result}    ${ERROR_CODE_WMM4003}    ${ERROR_MESSAGE_WMM4003}

    [Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_id}

TC_ITMWM_07579 To verify that api get package by mobile number return empty data if no package for the mobile number.
    [Tags]    TC_ITMWM_07579    regression    ready
    ${mobile_number}=    Set Variable    0100070009
    ${mobile_type}=    Set Variable    4
    ${merchant_key}=    Set Variable    2952505724
    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot

    Clear Prepared Proposition and Price Plan    ${unique_id}    ${unique_id}
    SuperNumber - Delete Data With Import Lot And Company Code    ${unique_id}


    ${proposition_id}=    Prepare Proposition    ${unique_id}
    ${expired_date}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=+3days
    SuperNumber - Insert Mobile Number     ${unique_id}    1    ${mobile_number}    ${mobile_type}    1    ${proposition_id}    ${expired_date}
    ${url_path}=    Set Variable    /mobile-number/package/${merchant_key}/${mobile_number}
    ${result}=    SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_200}
    ${result}=    Get Json Value    ${result}    /data
    Should Be Equal As Strings     ${result}    ${DATA_NULL}

    [Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_id}

TC_ITMWM_07580 To verify that api get package by mobile number return correct data and response code when send api with correct api key and mobile number.
    [Tags]   TC_ITMWM_07580    regression    ready
    ${mobile_number}=    SuperNumber - Prepare Data Random Mobile Number
    ${unique_num}=    SuperNumber - Prepare Data Get Import Lot
    Clear Prepared Proposition and Price Plan    ${unique_num}    ${unique_num}
    SuperNumber - Delete Data With Import Lot And Company Code    ${unique_num}

    ${proposition_id}    ${price_plan_id_1}=    Prepare Proposition and Price Plan     ${unique_num}    ${unique_num}    ${sub_description_1}    ${description_1}    ${recommend_y}
    ${price_plan_id_2}=     Prepare Price Plan    ${unique_num}    ${sub_description_2}    ${description_2}    ${recommend_n}
    ${response}=    Run Keyword If    ${proposition_id} > 0 and ${price_plan_id_2} > 0    add_proposition_maps    ${proposition_id}    ${price_plan_id_2}

    ${expired_date}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=+3days
    SuperNumber - Insert Mobile Number     ${unique_num}    1    ${mobile_number}    4    1    ${proposition_id}    ${expired_date}

    ${url_path}=    Set Variable    /mobile-number/package/${API_KEY}/${mobile_number}
    ${result}=    SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_200}

    SuperNumber - Vefiry Response Get Package    ${result}    0    ${price_plan_id_1}    ${sub_description_1}    ${description_1}    ${recommend_y}
    SuperNumber - Vefiry Response Get Package    ${result}    1    ${price_plan_id_2}    ${sub_description_2}    ${description_2}    ${recommend_n}

    [Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_num}
