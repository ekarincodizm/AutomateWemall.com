*** Settings ***
Library    DateTime

Resource    web_element_super_number_common.robot

Library                 Selenium2Library
Library                 Collections
Library                 String
Library                 ${CURDIR}/../../../Python_Library/truemoveh_library.py
Library                 ${CURDIR}/../../../Python_Library/mnp_util.py
Library                 ${CURDIR}/../../../Python_Library/DatabaseData.py

*** Keywords ***

SuperNumber - Insert Mobile Number
    [Arguments]    ${import_lot}=1    ${zone_id}=1    ${mobile}=0    ${mobile_type}=1    ${mobile_pattern_id}=1    ${proposition_id}=1    ${expired_date}=    ${hold_expired_date}=    ${company_code}=ROBOT    ${used}=N    ${status}=Y
#    Log To Console    ****************
#    Log To Console    import_lot : ${import_lot}
#    Log To Console    mobile : ${mobile}
#    Log To Console    mobile_type : ${mobile_type}
#    Log To Console    company_code : ${company_code}
#    Log To Console    used : ${used}
#    Log To Console    expired_date : ${expired_date}
#    Log To Console    hold_expired_date : ${hold_expired_date}
#    Log To Console    status : ${status}

    py_insert_truemoveh_mobile_full    ${import_lot}    ${zone_id}    ${mobile}    ${mobile_type}    ${mobile_pattern_id}    ${proposition_id}    ${company_code}    ${used}    ${status}    ${expired_date}    ${hold_expired_date}

    Return From Keyword    ${mobile}

SuperNumber - Delete Data With Import Lot And Company Code
    [Arguments]    ${import_lot}    ${company_code}=ROBOT
    Log to console     delete : ${import_lot}
    py_delete_truemoveh_mobile_with_lot_and_company_code    ${import_lot}    ${company_code}

SuperNumber - Prepare Data Random Mobile Number
    ${Digit_1}=    Evaluate    random.randint(1, 8)    random
    ${Digit_2}=    Evaluate    random.randint(0, 9)    random
    ${Digit_3}=    Evaluate    random.randint(0, 9)    random
    ${Digit_4}=    Evaluate    random.randint(0, 9)    random
    ${Digit_5}=    Evaluate    random.randint(0, 9)    random

    Return From Keyword    0${Digit_1}${Digit_2}${Digit_3}${Digit_4}${Digit_5}0000

SuperNumber - Prepare Data Get Import Lot
    ${hold_expired}=    Get Current Date    result_format=datetime    exclude_millis=true
    ${epoch_datetime}=    Convert Date    ${hold_expired}    epoch
    ${import_lot}=    Convert To String    ${epoch_datetime}
    ${import_lot}=    Get Substring    ${import_lot}    0    10

    Return From Keyword    ${import_lot}

SuperNumber - Prepare Data Insert Mobile Number
    [Arguments]    ${total_number}    ${total_use}=0    ${total_permanent}=0    ${total_inactive}=0   ${total_hold}=0    ${total_expired}=0
    ${total_all_condition}=    Evaluate    ${total_use}+${total_permanent}+${total_inactive}+${total_hold}+${total_expired}

#    Log To Console    Total Number : ${total_number} === Total Condition : ${total_all_condition}

    Run Keyword If    ${total_number} < ${total_all_condition}    FAIL

    ${total_number}=    Convert To Integer    ${total_number}
    ${total_use}=    Convert To Integer    ${total_use}
    ${total_permanent}=    Convert To Integer    ${total_permanent}
    ${total_inactive}=    Convert To Integer    ${total_inactive}
    ${total_hold}=    Convert To Integer    ${total_hold}
    ${total_expired}=    Convert To Integer    ${total_expired}

    ${total_real}=    Evaluate    ${total_number}-${total_all_condition}
    ${hold_expired}=    Get Current Date    result_format=datetime    exclude_millis=true
    ${epoch_datetime}=    Convert Date    ${hold_expired}    epoch
    ${mobile_random}=    SuperNumber - Prepare Data Random Mobile Number
    ${mobile}=    Convert To Integer    ${mobile_random}
    ${import_lot}=    SuperNumber - Prepare Data Get Import Lot
    ${mobile_type}=    Set Variable    4

    ${hold_permanance}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=+10d
    ${hold_temp}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=+5h
    ${expired}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=-5h

    ${mobile_use}=    Run Keyword If    ${total_use} > 0    Create List    0${mobile+1}
    :FOR    ${x_use}    IN RANGE    ${total_use}
    \    ${mobile}=    Convert To Integer    ${mobile}
    \    ${mobile}=    Run Keyword If    ${total_use} > 0    SuperNumber - Insert Mobile Number    import_lot=${import_lot}    mobile=0${mobile+1}    mobile_type=${mobile_type}    used=Y    expired_date=${hold_permanance}
    \    ...    ELSE    Set Variable    ${mobile}
    \    Append To List    ${mobile_use}    ${mobile}
#    \    Log To Console    ${mobile}

#    Log To Console    mobile_use : ${mobile_use}

    ${mobile}=    Convert To Integer    ${mobile}
    ${mobile_permanent}=    Run Keyword If    ${total_permanent} > 0    Create List    0${mobile+1}
    :FOR    ${x_permanent}    IN RANGE    ${total_permanent}
    \    ${mobile}=    Convert To Integer    ${mobile}
    \    ${mobile}=    Run Keyword If    ${total_permanent} > 0    SuperNumber - Insert Mobile Number    import_lot=${import_lot}    mobile=0${mobile+1}    mobile_type=${mobile_type}    hold_expired_date=${hold_permanance}    expired_date=${hold_permanance}
    \    ...    ELSE    Set Variable    ${mobile}
    \    Append To List    ${mobile_permanent}    ${mobile}
#    \    Log To Console    ${mobile}

#    Log To Console    mobile_permanent : ${mobile_permanent}

    ${mobile}=    Convert To Integer    ${mobile}
    ${mobile_inactive}=    Run Keyword If    ${total_inactive} > 0    Create List    0${mobile+1}
    :FOR    ${x_inactive}    IN RANGE    ${total_inactive}
    \    ${mobile}=    Convert To Integer    ${mobile}
    \    ${mobile}=    Run Keyword If    ${total_inactive} > 0   SuperNumber - Insert Mobile Number    import_lot=${import_lot}    mobile=0${mobile+1}    mobile_type=${mobile_type}    status=N    expired_date=${hold_permanance}
    \    ...    ELSE    Set Variable    ${mobile}
    \    Append To List    ${mobile_inactive}    ${mobile}
#    \    Log To Console    ${mobile}

#    Log To Console    mobile_inactive : ${mobile_inactive}

    ${mobile}=    Convert To Integer    ${mobile}
    ${mobile_hold}=    Run Keyword If    ${total_hold} > 0    Create List    0${mobile+1}
    :FOR    ${x_hold}    IN RANGE    ${total_hold}
    \    ${mobile}=    Convert To Integer    ${mobile}
    \    ${mobile}=    Run Keyword If    ${total_hold} > 0    SuperNumber - Insert Mobile Number    import_lot=${import_lot}    mobile=0${mobile+1}    mobile_type=${mobile_type}    hold_expired_date=${hold_temp}    expired_date=${hold_permanance}
    \    ...    ELSE    Set Variable    ${mobile}
    \    Append To List    ${mobile_hold}    ${mobile}
#    \    Log To Console    ${mobile}

#    Log To Console    mobile_hold : ${mobile_hold}

    ${mobile}=    Convert To Integer    ${mobile}
    ${mobile_expire}=    Run Keyword If    ${total_expired} > 0    Create List    0${mobile+1}
    :FOR    ${x_expire}    IN RANGE    ${total_expired}
    \    ${mobile}=    Convert To Integer    ${mobile}
    \    ${mobile}=    Run Keyword If    ${total_expired} > 0    SuperNumber - Insert Mobile Number    import_lot=${import_lot}    mobile=0${mobile+1}    mobile_type=${mobile_type}    expired_date=${expired}
    \    ...    ELSE    Set Variable    ${mobile}
    \    Append To List    ${mobile_expire}    ${mobile}
#    \    Log To Console    ${mobile}

#    Log To Console    mobile_expire : ${mobile_expire}

    ${mobile}=    Convert To Integer    ${mobile}
    ${mobile_active}=    Run Keyword If    ${total_real} > 0    Create List    0${mobile+1}
    :FOR    ${x}  IN RANGE   ${total_real}
#    \    Log To Console    ${x}
    \    ${mobile}=    Convert To Integer    ${mobile}
    \    ${mobile}=    Convert To Integer    ${mobile}
    \    ${mobile}=    Run Keyword If    ${total_real} > 0     SuperNumber - Insert Mobile Number    import_lot=${import_lot}    mobile=0${mobile+1}    mobile_type=${mobile_type}    expired_date=${hold_permanance}
    \    Append To List    ${mobile_active}    ${mobile}
#    \    Log To Console    ${mobile}

#    Log To Console    mobile_active : ${mobile_active}

    ${mobile_use}=    Run Keyword If    ${mobile_use} != None    Remove Duplicates    ${mobile_use}
    ${mobile_permanent}=    Run Keyword If    ${mobile_permanent} != None    Remove Duplicates    ${mobile_permanent}
    ${mobile_inactive}=    Run Keyword If    ${mobile_inactive} != None    Remove Duplicates    ${mobile_inactive}
    ${mobile_hold}=    Run Keyword If    ${mobile_hold} != None    Remove Duplicates    ${mobile_hold}
    ${mobile_expire}=    Run Keyword If    ${mobile_expire} != None    Remove Duplicates    ${mobile_expire}
    ${mobile_active}=    Run Keyword If    ${mobile_active} != None    Remove Duplicates    ${mobile_active}

    ${return}=    Create Dictionary    import_lot=${import_lot}    mobile_use=${mobile_use}    mobile_permanent=${mobile_permanent}    mobile_inactive=${mobile_inactive}    mobile_hold=${mobile_hold}    mobile_expire=${mobile_expire}    mobile_active=${mobile_active}

    Return From Keyword    ${return}

SuperNumber - Verify Api List Mobile Response Success
    [Arguments]    ${expect_data}    ${page}=1

    Log To Console    ********* Start Keyword ***********
    ${url_path}=    Set Variable    /mobile-number/list/${API_KEY}?page=${page}
    ${response}=    SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_200}

    Log To Console    ********* Data From API ***********

    ${result_status}=    Get Json Value    ${response}    /data
    ${last_page}=    Get Json Value    ${response}    /last_page
    ${current_page}=    Get Json Value    ${response}    /current_page

    ${remaining_page}=    Evaluate    ${last_page}-${current_page}
    ${next_page}=    Evaluate    ${current_page}+1

    Log To Console    remaining_page : ${remaining_page}

    ${mobile_use}=    Get From Dictionary    ${expect_data}    mobile_use
    ${mobile_permanent}=    Get From Dictionary    ${expect_data}    mobile_permanent
    ${mobile_inactive}=    Get From Dictionary    ${expect_data}    mobile_inactive
    ${mobile_hold}=    Get From Dictionary    ${expect_data}    mobile_hold
    ${mobile_expire}=    Get From Dictionary    ${expect_data}    mobile_expire
    ${mobile_active}=    Get From Dictionary    ${expect_data}    mobile_active

    ${result_status_data}=    Parse Json    ${result_status}

    Log To Console    result_status_data : ${result_status_data}
#    Log To Console    mobile_use : ${mobile_use}
#    Log To Console    mobile_permanent : ${mobile_permanent}
#    Log To Console    mobile_inactive : ${mobile_inactive}
#    Log To Console    mobile_hold : ${mobile_hold}
#    Log To Console    mobile_expire : ${mobile_expire}
#    Log To Console    mobile_active : ${mobile_active}

    :FOR    ${ELEMENT}    IN    @{result_status_data}
    \    ${mobile}=    Get From Dictionary    ${ELEMENT}    mobile_number
    \    ${status}=    Get From Dictionary    ${ELEMENT}    status

    \    Log To Console    match: ${mobile} status : ${status}
    \    ${mobile_use}=    Run Keyword If    '${status}' == 'sold' and ${mobile_use} != None    SuperNumber - Remove Mobile Number From List    ${mobile}    ${mobile_use}    ${status}
    \    ...    ELSE    Set Variable    ${mobile_use}
    \    ${mobile_permanent}=    Run Keyword If    '${status}' == 'sold' and ${mobile_permanent} != None    SuperNumber - Remove Mobile Number From List    ${mobile}    ${mobile_permanent}    ${status}
    \    ...    ELSE    Set Variable    ${mobile_permanent}
    \    ${mobile_inactive}=    Run Keyword If    '${status}' == 'inactive' and ${mobile_inactive} != None    SuperNumber - Remove Mobile Number From List    ${mobile}    ${mobile_inactive}    ${status}
    \    ...    ELSE    Set Variable    ${mobile_inactive}
    \    ${mobile_hold}=    Run Keyword If    '${status}' == 'hold' and ${mobile_hold} != None    SuperNumber - Remove Mobile Number From List    ${mobile}    ${mobile_hold}    ${status}
    \    ...    ELSE    Set Variable    ${mobile_hold}
    \    ${mobile_expire}=    Run Keyword If    '${status}' == 'inactive' and ${mobile_expire} != None    SuperNumber - Remove Mobile Number From List    ${mobile}    ${mobile_expire}    ${status}
    \    ...    ELSE    Set Variable    ${mobile_expire}
    \    ${mobile_active}=    Run Keyword If    '${status}' == 'active' and ${mobile_active} != None    SuperNumber - Remove Mobile Number From List    ${mobile}    ${mobile_active}    ${status}
    \    ...    ELSE    Set Variable    ${mobile_active}
#    \    Log To Console    mobile_use_loop : ${mobile_use}
    \    ${check}=    Run Keyword If    ${mobile_use} == None and ${mobile_permanent} == None and ${mobile_inactive} == None and ${mobile_hold} == None and ${mobile_expire} == None and ${mobile_active} == None    Set Variable    0
    \    ...    ELSE    Set Variable     1
    \    Run Keyword If    ${mobile_use} == None and ${mobile_permanent} == None and ${mobile_inactive} == None and ${mobile_hold} == None and ${mobile_expire} == None and ${mobile_active} == None    Exit For Loop

    Log To Console    mobile_use : ${mobile_use}
    Log To Console    mobile_permanent : ${mobile_permanent}
    Log To Console    mobile_inactive : ${mobile_inactive}
    Log To Console    mobile_hold : ${mobile_hold}
    Log To Console    mobile_expire : ${mobile_expire}
    Log To Console    mobile_active : ${mobile_active}

    Log to console    check = ${check}
    Log to console    remaining_page = ${remaining_page}

    ${total_data}=    Create Dictionary    mobile_use=${mobile_use}    mobile_permanent=${mobile_permanent}    mobile_inactive=${mobile_inactive}    mobile_hold=${mobile_hold}    mobile_expire=${mobile_expire}    mobile_active=${mobile_active}

    ${check_all_page}=    Set Variable    fail
#    Log To Console    ${total_data}
    ${check_all_page}=    Run Keyword If    ${remaining_page} > 0 and ${check} == 1    SuperNumber - Verify Api List Mobile Response Success    ${total_data}    ${next_page}
    ...    ELSE IF    ${remaining_page} == 0 and ${check} == 1    Set Variable    fail
    ...    ELSE    Set Variable    success
    Log To Console    ********* End Keyword ***********
    Return From Keyword    ${check_all_page}

SuperNumber - Remove Mobile Number From List
    [Arguments]    ${data}    ${mobile}    ${status}
    Log To Console    *********************
    Log To Console    ${data}
    Log To Console    ${status}
    Log To Console    ${mobile}
    Log To Console    *********************
    Remove Values From List    ${mobile}    ${data}
    Log To Console    mobile_remaning : ${mobile}
    Log To Console    =====================
    ${count}=    Get Length    ${mobile}
    ${return_mobile}=    Run Keyword If    ${count} < 1    Set Variable    None
    ...    ELSE    Set Variable    ${mobile}

    Return From Keyword    ${return_mobile}

SuperNumber - Set Http for API gateway
    Create Http Context    ${SUPERNUMBER_API_GATEWAY}    https
    Set Request Header    x-api-key    ${SP_API_KEY}
    Set Request Header    content-Type    application/json

SuperNumber - Set Http
    Create Http Context    ${PCMS_URL_HTTP}    http
    Set Request Header    x-api-key    ${SP_API_KEY}
    Set Request Header    content-Type    application/json

SuperNumber - Send Http Get Request
    [Arguments]    ${path}    ${status_code}=200
    ${value} =  Get Variable Value  ${SP_ENV_PCMS}
    Log To Console    value = ${value}
    ${url_http}=    Run Keyword If    '${value}' == 'None'    SuperNumber - Set Http for API gateway
    ...    ELSE    SuperNumber - Set Http
    Next Request Should Have Status Code    ${status_code}
    HttpLibrary.HTTP.GET    ${path}
    ${response}=    Get Response Body
    Return From Keyword    ${response}

SuperNumber - Verify Response Check Available Number Success Expired is null
    [Arguments]    ${result}    ${status}    ${hold_expired}
    ${result_status}=    Get Json Value    ${result}    /data/status
    ${result_hold_expired}=    Get Json Value    ${result}    /data/hold_expired

    Should Be Equal As Strings    ${result_hold_expired}    false
    Should Be Equal AS Strings     ${result_status}    ${status}


SuperNumber - Verify Response Check Available Number Success
    [Arguments]    ${result}    ${status}    ${hold_expired}
    ${result_status}=    Get Json Value    ${result}    /data/status
    ${result_hold_expired}=    Get Json Value    ${result}    /data/hold_expired

    ${epoch_datetime}=    Convert Date    ${hold_expired}    epoch
    Should Be Equal As Integers    ${result_hold_expired}    ${epoch_datetime}
    Should Be Equal AS Strings    ${result_status}    ${status}

SuperNumber - Verify Response Fail
    [Arguments]    ${result}    ${error_code}    ${error_message}
    ${result_error_code}=    Get Json Value    ${result}    /errorCode
    ${result_error_message}=    Get Json Value    ${result}    /errorMessage

    Should Be Equal As Strings    ${result_error_code}    ${error_code}
    Should Be Equal AS Strings    ${result_error_message}    ${error_message}

SuperNumber - Verify Response Check Available list Fail
    [Arguments]    ${result}    ${error_data_null}    ${error_code}    ${error_message}
    ${result_null}=    Get Json Value    ${result}    /data
    ${result_error_code}=    Get Json Value    ${result}    /errorCode
    ${result_error_message}=    Get Json Value    ${result}    /errorMessage

    Should Be Equal As Strings    ${result_null}    ${error_data_null}
    Should Be Equal As Strings    ${result_error_code}    ${error_code}
    Should Be Equal AS Strings    ${result_error_message}    ${error_message}

SuperNumber - Verify Response Check Available list page invalid
    [Arguments]    ${result}    ${result_current_page}    ${error_data_null}
    ${list_result_current_page}=    Get Json Value    ${result}    /current_page
    ${list_result_null}=    Get Json Value    ${result}    /data
    Should Be Equal As Strings    ${list_result_current_page}    ${result_current_page}
    Should Be Equal As Strings    ${list_result_null}    ${error_data_null}

SuperNumber - Verify Response Check Default page
    [Arguments]    ${result}    ${default_page}
    ${default_current_page}=    Get Json Value    ${result}    /current_page

    Should Be Equal As Strings    ${default_current_page}    ${default_page}

SuperNumber - Vefiry Response Get Package
    [Arguments]    ${result}    ${index}    ${price_plan_id}    ${sub_description}    ${description}    ${recommend}
    ${list_result_id}=    Get Json Value    ${result}    /data/${index}/id
    ${list_result_sub_description}=    Get Json Value    ${result}    /data/${index}/sub_description
    ${list_result_description}=    Get Json Value    ${result}    /data/${index}/description
    ${list_result_recommend}=    Get Json Value    ${result}    /data/${index}/recommend
    Should Be Equal As Strings    ${list_result_id}    ${price_plan_id}
    Should Be Equal As Strings    ${list_result_sub_description}    "${sub_description}"
    Should Be Equal As Strings    ${list_result_description}    "${description}"
    Should Be Equal As Strings    ${list_result_recommend}    "${recommend}"

SuperNumber - Send Api Prepare Cart
    [Arguments]    ${api_key}  ${api_secret}  ${mobile_number}  ${package_id}  ${back_url}=http://www.google.com  ${status_code}=200
    Create Http Context    ${PCMS_API_URL}    http
    Set Request Body    api_key=${api_key}&api_secret=${api_secret}&mobile_number=${mobile_number}&package_id=${package_id}&back_url=${back_url}
    Log to console   Api Prepare Cart URL: ${PCMS_API_URL}/mobile-number/prepare-cart
    Next Request Should Have Status Code    ${status_code}
    HttpLibrary.HTTP.POST    /mobile-number/prepare-cart
    ${body}=    Get Response Body
    [Return]    ${body}

SuperNumber - Verify Response Get Price Plan
    [Arguments]    ${result}    ${expect_value}    ${success}=true

    ${result_check_value}=    Run Keyword If    "${success}"=="true"        Get Json Value    ${result}    /data/pp_code
    ...      ELSE   Get Json Value    ${result}    /message

    Should Be Equal As Strings    ${result_check_value}    ${expect_value}

SuperNumber - Get Mobile Id By Mobile Number
   [Arguments]    ${mobile_number}
   ${response}=     get_mobile_id_by_mobile_number      ${mobile_number}
   Return From Keyword    ${response['mobile_id']}

Supernumber - Change Mobile Number Data In Cart With Url Key
   [Arguments]    ${new_mobile_number}     ${url_key}
    update_mobile_number_in_cart     ${new_mobile_number}     ${url_key}
