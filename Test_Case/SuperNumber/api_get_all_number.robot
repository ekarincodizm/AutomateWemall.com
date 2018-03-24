*** Settings ***
Force Tags        WLS_Supernumber     WLS_High
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           DateTime
Resource          ${CURDIR}/../../Resource/init.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/TruemoveH/keywords_super_number.robot
Resource          ${CURDIR}/../../Keyword/API/api_super_number/keyword_super_number_common.robot

*** Variable ***
${path_excel}     ${CURDIR}/../../Resource/TestData/SuperNumber
&{mobile_list}    Gold=0000000001    Silver=0000000002     Lucky=0000000003    Seer_nitikit=0000000004

*** Test Cases ***
TC_ITMWM_07540 API list number SIM only - To verify that system return mobile number list type = 1 and 2 when sent API with type_number = 1
    [Tags]    TC_ITMWM_07540    regression    ready

    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot
    Clear Prepared Proposition and Price Plan    ${unique_id}    ${unique_id}
    SuperNumber - Delete Data With Import Lot And Company Code    ${unique_id}
    Clear Imported Mobile Number    ${mobile_list}

    Prepare Proposition and Price Plan     ${unique_id}    ${unique_id}
    Create Truemoveh Excel import mobile    4    ${mobile_list}    ${unique_id}    mobile_import1.xlsx

    Login Pcms
    Truemoveh - Go To Import Mobile Number By Excel
    Upload Mobile Import Excel     mobile_import1.xlsx    ${unique_id}
    Upload Mobile Import Excel - Click Upload Button
    Upload Mobile Import Excel - Click Confirm Upload Button

    ${response}=    Truemoveh - Send Api All Mobile     1       1       1       1
    ${response_mobile_one}=    Get Json Value  ${response}     /data/0/mobile
    ${response_mobile_two}=    Get Json Value  ${response}     /data/1/mobile
    ${status}=             Get Response Status
    Should Be Equal     200 OK    ${status}
    Should Be Equal As Strings     "0000000001"    ${response_mobile_one}
    Should Be Equal As Strings     "0000000002"    ${response_mobile_two}

    [Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_id}

TC_ITMWM_07541 API list number SIM only - To verify that system return mobile number list that type_number match with type_number that input on API
    [Tags]    TC_ITMWM_07541    regression    ready

    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot
    Clear Prepared Proposition and Price Plan    ${unique_id}    ${unique_id}
    SuperNumber - Delete Data With Import Lot And Company Code    ${unique_id}
    Clear Imported Mobile Number    ${mobile_list}

    Prepare Proposition and Price Plan     ${unique_id}    ${unique_id}
    Create Truemoveh Excel import mobile    4    ${mobile_list}    ${unique_id}    mobile_import1.xlsx

    Login Pcms
    Truemoveh - Go To Import Mobile Number By Excel
    Upload Mobile Import Excel     mobile_import1.xlsx    ${unique_id}
    Upload Mobile Import Excel - Click Upload Button
    Upload Mobile Import Excel - Click Confirm Upload Button

    ${response_type_two}=    Truemoveh - Send Api All Mobile     1       2       1       1
    ${response_mobile_type_two}=    Get Json Value  ${response_type_two}     /data/0/mobile
    ${status}=             Get Response Status
    Should Be Equal     200 OK    ${status}
    Should Be Equal As Strings     "0000000002"    ${response_mobile_type_two}

    ${response_type_three}=    Truemoveh - Send Api All Mobile     1       3       3       1
    ${response_mobile_type_three}=    Get Json Value  ${response_type_three}     /data/0/mobile
    ${status}=             Get Response Status
    Should Be Equal     200 OK    ${status}
    Should Be Equal As Strings     "0000000003"    ${response_mobile_type_three}

    ${response}=    Truemoveh - Send Api All Mobile     1       4       3       1
    ${status}=             Get Response Status
    Should Be Equal     200 OK    ${status}
    ${response_mobile_type_four}=    Get Json Value  ${response}     /data/0/mobile
    Should Be Equal As Strings     "0000000004"    ${response_mobile_type_four}

    [Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_id}


*** Keywords ***
Truemoveh - Send Api All Mobile
    [Arguments]    ${province_id}=1  ${type_number}=1  ${type_value}=1   ${page}=1
    Create Http Context    ${PCMS_API_URL}    http
    Set Request Header    Content-Type    application/json
    HttpLibrary.HTTP.GET    /api/45311375168544/truemoveh/mobile/all-mobile?province_id=${province_id}&type_number=${type_number}&type_value=${type_value}&page=${page}
    ${response}=    Get Response Body
    # Log to console   Api Get Order=${response}
    [Return]    ${response}

