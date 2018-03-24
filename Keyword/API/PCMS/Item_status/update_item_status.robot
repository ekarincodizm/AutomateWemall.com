*** Settings ***
Library           Collections
Library           DateTime
Resource          ${CURDIR}/../../../../Resource/Config/${ENV}/env_config.robot
Library           RequestsLibrary
Library           HttpLibrary
Library           Selenium2Library
Library           DatabaseLibrary
Library           String
Library           OperatingSystem    #Resource    WebElement_Common.robot
Resource          ${CURDIR}/../../../../Resource/Config/${ENV}/database.robot
Library           ${CURDIR}/../../../../Python_Library/jsonLibrary.py

*** Keywords ***
Create Request Api update item status Pick&Pack with serial number for Multi-item
    [Arguments]    ${order_id}    ${order_shipment_data}    ${item_count}=2    ${stock_type}=RT
    ${all_node}=    Evaluate    ${item_count}*2
    ${body_pick_pack}=    Get Binary File    ${CURDIR}/../../../../Resource/TestData/update_${item_count}item_status_pick_pack_template.json
    : FOR    ${INDEX}    IN RANGE    1    ${all_node}+1
    \    ${node}=    Evaluate    ${INDEX}-1
    \    ${node}=    Run Keyword If    2 == ${INDEX}    Evaluate    ${INDEX}-2
    \    ...    ELSE    Set Variable    ${node}
    \    ${node}=    Run Keyword If    3 == ${INDEX}    Evaluate    ${INDEX}-2
    \    ...    ELSE    Set Variable    ${node}
    \    ${node}=    Run Keyword If    4 == ${INDEX}    Evaluate    ${INDEX}-3
    \    ...    ELSE    Set Variable    ${node}
    \    ${node}=    Run Keyword If    5 == ${INDEX}    Evaluate    ${INDEX}-3
    \    ...    ELSE    Set Variable    ${node}
    \    ${node}=    Run Keyword If    6 == ${INDEX}    Evaluate    ${INDEX}-4
    \    ...    ELSE    Set Variable    ${node}
    \    ${node}=    Run Keyword If    7 == ${INDEX}    Evaluate    ${INDEX}-4
    \    ...    ELSE    Set Variable    ${node}
    \    ${node}=    Run Keyword If    8 == ${INDEX}    Evaluate    ${INDEX}-5
    \    ...    ELSE    Set Variable    ${node}
    \    ${body_pick_pack}=    Set Json Value    ${body_pick_pack}    /${INDEX-1}/order_id    "${order_id}"
    \    ${body_pick_pack}=    Set Json Value    ${body_pick_pack}    /${INDEX-1}/order_shipment_item_id    "${order_shipment_data[${node}][0]}"
    \    ${body_pick_pack}=    Set Json Value    ${body_pick_pack}    /${INDEX-1}/stock_type    "${stock_type}"
    Return From Keyword    ${body_pick_pack}

Create Request Api update item status Pick&Pack with serial number No Stocktype for Multi-item
    [Arguments]    ${order_id}    ${order_shipment_data}    ${item_count}=2
    ${all_node}=    Evaluate    ${item_count}*2
    ${body_pick_pack}=    Get Binary File    ${CURDIR}/../../../../Resource/TestData/update_${item_count}item_status_pick_pack_template.json
    : FOR    ${INDEX}    IN RANGE    1    ${all_node}+1
    \    ${node}=    Evaluate    ${INDEX}-1
    \    ${node}=    Run Keyword If    2 == ${INDEX}    Evaluate    ${INDEX}-2
    \    ...    ELSE    Set Variable    ${node}
    \    ${node}=    Run Keyword If    3 == ${INDEX}    Evaluate    ${INDEX}-2
    \    ...    ELSE    Set Variable    ${node}
    \    ${node}=    Run Keyword If    4 == ${INDEX}    Evaluate    ${INDEX}-3
    \    ...    ELSE    Set Variable    ${node}
    \    ${node}=    Run Keyword If    5 == ${INDEX}    Evaluate    ${INDEX}-3
    \    ...    ELSE    Set Variable    ${node}
    \    ${node}=    Run Keyword If    6 == ${INDEX}    Evaluate    ${INDEX}-4
    \    ...    ELSE    Set Variable    ${node}
    \    ${node}=    Run Keyword If    7 == ${INDEX}    Evaluate    ${INDEX}-4
    \    ...    ELSE    Set Variable    ${node}
    \    ${node}=    Run Keyword If    8 == ${INDEX}    Evaluate    ${INDEX}-5
    \    ...    ELSE    Set Variable    ${node}
    \    ${body_pick_pack}=    Set Json Value    ${body_pick_pack}    /${INDEX-1}/order_id    "${order_id}"
    \    ${body_pick_pack}=    Set Json Value    ${body_pick_pack}    /${INDEX-1}/order_shipment_item_id    "${order_shipment_data[${node}][0]}"
    Return From Keyword    ${body_pick_pack}

Create Request Api update item status Pick&Pack One Json - no stocktype
    [Arguments]    ${order_id}    ${order_shipment_data}    ${item_status}=picked    ${stock_type}=RT    ${item_count}=1    ${expect_result}=success
    ${body_pick_pack}=    Get Binary File    ${CURDIR}/../../../../Resource/TestData/update_${item_count}item_status_pickorpack_template.json
    : FOR    ${INDEX}    IN RANGE    1    ${item_count}+1
    \    ${node}=    Evaluate    ${INDEX}-1
    \    ${body_pick_pack}=    Run Keyword If    '${expect_result}'=='success'    Set Json Value    ${body_pick_pack}    /${INDEX-1}/stock_type
    \    ...    "${stock_type}"
    \    ...    ELSE    Set Variable    ${body_pick_pack}
    \    ${body_pick_pack}=    Set Json Value    ${body_pick_pack}    /${INDEX-1}/order_id    "${order_id}"
    \    ${body_pick_pack}=    Set Json Value    ${body_pick_pack}    /${INDEX-1}/order_shipment_item_id    "${order_shipment_data[${node}][0]}"
    \    ${body_pick_pack}=    Set Json Value    ${body_pick_pack}    /${INDEX-1}/item_status    "${item_status}"
    Return From Keyword    ${body_pick_pack}

Create Request Api update item status Pick&Pack with serial number in case refund for Multi-item
    [Arguments]    ${order_id}    ${order_shipment_data}    ${item_count}=1    ${stock_type}=RT
    ${all_node}=    Evaluate    ${item_count}*2
    ${body_pick_pack}=    Get Binary File    ${CURDIR}/../../../../Resource/TestData/update_${item_count}item_status_pick_pack_template.json
    : FOR    ${INDEX}    IN RANGE    1    ${all_node}+1
    \    ${node}=    Evaluate    ${INDEX}-1
    \    ${node}=    Run Keyword If    2 == ${INDEX}    Evaluate    ${INDEX}-2
    \    ...    ELSE    Set Variable    ${node}
    \    ${node}=    Run Keyword If    3 == ${INDEX}    Evaluate    ${INDEX}-2
    \    ...    ELSE    Set Variable    ${node}
    \    ${node}=    Run Keyword If    4 == ${INDEX}    Evaluate    ${INDEX}-3
    \    ...    ELSE    Set Variable    ${node}
    \    ${node}=    Run Keyword If    5 == ${INDEX}    Evaluate    ${INDEX}-3
    \    ...    ELSE    Set Variable    ${node}
    \    ${node}=    Run Keyword If    6 == ${INDEX}    Evaluate    ${INDEX}-4
    \    ...    ELSE    Set Variable    ${node}
    \    ${node}=    Run Keyword If    7 == ${INDEX}    Evaluate    ${INDEX}-4
    \    ...    ELSE    Set Variable    ${node}
    \    ${node}=    Run Keyword If    8 == ${INDEX}    Evaluate    ${INDEX}-5
    \    ...    ELSE    Set Variable    ${node}
    \    ${body_pick_pack}=    Set Json Value    ${body_pick_pack}    /${INDEX-1}/order_id    "${order_id}"
    \    ${body_pick_pack}=    Set Json Value    ${body_pick_pack}    /${INDEX-1}/order_shipment_item_id    "${order_shipment_data[${node}][0]}"
    \    ${body_pick_pack}=    Set Json Value    ${body_pick_pack}    /${INDEX-1}/stock_type    "${stock_type}"
    Return From Keyword    ${body_pick_pack}

Create Request Api update item status Shipped with serial number for Multi-item
    [Arguments]    ${order_id}    ${order_shipment_data}    ${serial_number}=SN12345    ${item_count}=1
    ${body_shipped}=    Get Binary File    ${CURDIR}/../../../../Resource/TestData/update_${item_count}item_status_shipped_template.json
    : FOR    ${INDEX}    IN RANGE    1    ${item_count}+1
    \    ${node}=    Evaluate    ${INDEX}-1
    \    ${body_shipped}=    Set Json Value    ${body_shipped}    /${INDEX-1}/order_id    "${order_id}"
    \    ${body_shipped}=    Set Json Value    ${body_shipped}    /${INDEX-1}/order_shipment_item_id    "${order_shipment_data[${INDEX-1}][0]}"
    \    ${body_shipped}=    Set Json Value    ${body_shipped}    /${INDEX-1}/serial_number    "${serial_number}"
    Return From Keyword    ${body_shipped}

Create Request Api update item status Shipped with tracking and 3PL for Multi-item
    [Arguments]    ${order_id}    ${order_shipment_data}    ${logistic_code}    ${tracking_number}    ${item_count}=1
    ${body_shipped}=    Get Binary File    ${CURDIR}/../../../../Resource/TestData/update_${item_count}item_status_shipped_template.json
    : FOR    ${INDEX}    IN RANGE    1    ${item_count}+1
    \    ${node}=    Evaluate    ${INDEX}-1
    \    ${body_shipped}=    Set Json Value    ${body_shipped}    /${INDEX-1}/order_id    "${order_id}"
    \    ${body_shipped}=    Set Json Value    ${body_shipped}    /${INDEX-1}/order_shipment_item_id    "${order_shipment_data[${INDEX-1}][0]}"
    \    ${body_shipped}=    Set Json Value    ${body_shipped}    /${INDEX-1}/logistic_code    "${logistic_code}"
    \    ${body_shipped}=    Set Json Value    ${body_shipped}    /${INDEX-1}/tracking_number    "${tracking_number}"
    Return From Keyword    ${body_shipped}

Create Request Api update item status Delivered Delivery with for Multi-item
    [Arguments]    ${order_id}    ${tracking_number}    ${item_count}=1
    ${body_shipped}=    Get Binary File    ${CURDIR}/../../../../Resource/TestData/update_${item_count}item_status_shipped_template.json
    : FOR    ${INDEX}    IN RANGE    1    ${item_count}+1
    \    ${node}=    Evaluate    ${INDEX}-1
    \    ${body_shipped}=    Set Json Value    ${body_shipped}    /${INDEX-1}/order_id    "${order_id}"
    \    ${body_shipped}=    Set Json Value    ${body_shipped}    /${INDEX-1}/order_shipment_item_id    "${order_shipment_data[${INDEX-1}][0]}"
    \    ${body_shipped}=    Set Json Value    ${body_shipped}    /${INDEX-1}/serial_number    "${serial_number}"
    Return From Keyword    ${body_shipped}

Create Request Api update item status Failed Delivery with for Multi-item
    [Arguments]    ${order_id}    ${order_shipment_data}    ${serial_number}=SN12345    ${item_count}=1
    ${body_shipped}=    Get Binary File    ${CURDIR}/../../../../Resource/TestData/update_${item_count}item_status_failed_delivery_template.json
    : FOR    ${INDEX}    IN RANGE    1    ${item_count}+1
    \    ${node}=    Evaluate    ${INDEX}-1
    \    ${body_shipped}=    Set Json Value    ${body_shipped}    /${INDEX-1}/order_id    "${order_id}"
    \    ${body_shipped}=    Set Json Value    ${body_shipped}    /${INDEX-1}/order_shipment_item_id    "${order_shipment_data[${INDEX-1}][0]}"
    \    ${body_shipped}=    Set Json Value    ${body_shipped}    /${INDEX-1}/serial_number    "${serial_number}"
    Return From Keyword    ${body_shipped}

Create Request Api update item status Return Received with for Multi-item
    [Arguments]    ${order_id}    ${order_shipment_data}    ${serial_number}=SN12345    ${item_count}=1
    ${body_shipped}=    Get Binary File    ${CURDIR}/../../../../Resource/TestData/update_${item_count}item_status_return_received_template.json
    : FOR    ${INDEX}    IN RANGE    1    ${item_count}+1
    \    ${node}=    Evaluate    ${INDEX}-1
    \    ${body_shipped}=    Set Json Value    ${body_shipped}    /${INDEX-1}/order_id    "${order_id}"
    \    ${body_shipped}=    Set Json Value    ${body_shipped}    /${INDEX-1}/order_shipment_item_id    "${order_shipment_data[${INDEX-1}][0]}"
    \    ${body_shipped}=    Set Json Value    ${body_shipped}    /${INDEX-1}/serial_number    "${serial_number}"
    Return From Keyword    ${body_shipped}

Create Request Api update item status Return Completed with for Multi-item
    [Arguments]    ${order_id}    ${order_shipment_data}    ${serial_number}=SN12345    ${item_count}=1
    ${body_shipped}=    Get Binary File    ${CURDIR}/../../../../Resource/TestData/update_${item_count}item_status_return_completed_template.json
    : FOR    ${INDEX}    IN RANGE    1    ${item_count}+1
    \    ${node}=    Evaluate    ${INDEX}-1
    \    ${body_shipped}=    Set Json Value    ${body_shipped}    /${INDEX-1}/order_id    "${order_id}"
    \    ${body_shipped}=    Set Json Value    ${body_shipped}    /${INDEX-1}/order_shipment_item_id    "${order_shipment_data[${INDEX-1}][0]}"
    \    ${body_shipped}=    Set Json Value    ${body_shipped}    /${INDEX-1}/serial_number    "${serial_number}"
    Return From Keyword    ${body_shipped}

Create Request Api update item status Return Rejected with for Multi-item
    [Arguments]    ${order_id}    ${order_shipment_data}    ${serial_number}=SN12345    ${item_count}=1
    ${body_shipped}=    Get Binary File    ${CURDIR}/../../../../Resource/TestData/update_${item_count}item_status_return_rejected_template.json
    : FOR    ${INDEX}    IN RANGE    1    ${item_count}+1
    \    ${node}=    Evaluate    ${INDEX}-1
    \    ${body_shipped}=    Set Json Value    ${body_shipped}    /${INDEX-1}/order_id    "${order_id}"
    \    ${body_shipped}=    Set Json Value    ${body_shipped}    /${INDEX-1}/order_shipment_item_id    "${order_shipment_data[${INDEX-1}][0]}"
    \    ${body_shipped}=    Set Json Value    ${body_shipped}    /${INDEX-1}/serial_number    "${serial_number}"
    Return From Keyword    ${body_shipped}

Send Api update status
    [Arguments]    ${body}
    Create Session    Http Post    ${PCMS_URL}
    Create Http Context    ${PCMS_API_URL}   http
    Set Request Header   content-Type    application/json
    Set Request Body     ${body}
    Next Request Should Succeed
    HttpLibrary.HTTP.POST   /api/v4/orders/update-status
    ${body}=   Get Response Body

Send Api update status fail
    [Arguments]    ${body}    ${error_code}=400
    # Create Session    Http Post    ${PCMS_URL}
    # ${header}=    Create Dictionary    Content-Type=application/json
    # ${response}=    Post Request    Http Post    /api/v4/orders/update-status    ${body}    ${header}
    # Should Be Equal As Strings    ${response.json()['code']}    ${error_code}
    # Return From Keyword    ${response.json()}
    Create Http Context    ${PCMS_API_URL}   http
    Set Request Header   content-Type    application/json
    Set Request Body     ${body}
    Next Request Should Succeed
    HttpLibrary.HTTP.POST   /api/v4/orders/update-status
    ${body}=   Get Response Body
    ${body}=   Convert Json To Dict    ${body}
    Return From Keyword    ${body}
