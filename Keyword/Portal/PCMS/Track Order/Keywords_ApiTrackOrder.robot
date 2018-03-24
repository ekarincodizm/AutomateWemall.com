*** Keyword ***
API Receive Status
    [Arguments]    ${tracking_id}    ${token}
    Create Http Context    ${PCMS_URL_API}    ${PROTOCOL}
    Set Request Header    Content-Type    application/json
    Set Request Body    {"tracking_id":"${tracking_id}","token":"${token}"}
    HttpLibrary.HTTP.POST    ${ORDER-TRACKING}
    ${response}=    Get Response Body
    Log to console    ${response}
    Set Test Variable    ${Variable_Response_Order_Tracking}     ${response}

Tracking - Expected Response From Api
    [Arguments]    ${status}    ${code}    ${message}

    Expected Status    ${status}
    Expected Code      ${code}
    Expected Message   ${message}

Tracking - Get Retry Queues Tracking Number In DB
    [Arguments]    ${Variable_Tracking_Number}
    ${result}=    get_data_tracking_receive_queues    ${Variable_Tracking_Number}
    Log To Console    ${result}
    [return]  ${result}

Tracking - Verify Retry Queues Tracking Number In DB
    [Arguments]    ${result}    ${third_pl_id}    ${tracking_number}    ${alert_count}    ${error_type}    ${status}
#    0 = third_pl_id, 1 = tracking_number, 2 = alert_count, 3 = error_type, 4 = status, 5 = created_at, 6 = updated_at
	Should Be Equal As Strings    ${result[0]}    ${third_pl_id}
	Should Be Equal As Strings    ${result[1]}    ${tracking_number}
	Should Be Equal As Strings    ${result[2]}    ${alert_count}
	Should Be Equal As Strings    ${result[3]}    ${error_type}
	Should Be Equal As Strings    ${result[4]}    ${status}

	Log To Console    ${result}

Tracking - Add New Third PL
    [Arguments]    ${third_pl_name}    ${third_pl_fullname}    ${access_token}
    ${result}=    insert_new_third_pl    ${third_pl_name}    ${third_pl_fullname}    ${access_token}
    Log To Console    ${result}

Tracking - Del New Third PL
    [Arguments]    ${third_pl_name}    ${third_pl_fullname}    ${access_token}
    ${result}=    delete_third_pl    ${third_pl_name}    ${third_pl_fullname}    ${access_token}
    Log To Console    ${result}

Tracking - Count Tracking Receive Log
    [Arguments]    ${tracking_number}
    ${result}=    get_count_tracking_receive_log    ${tracking_number}
    [return]    ${result}

Tracking - Count Tracking Receive Queues
    [Arguments]    ${tracking_number}
    ${result}=    get_count_tracking_receive_queues    ${tracking_number}
    [return]    ${result}