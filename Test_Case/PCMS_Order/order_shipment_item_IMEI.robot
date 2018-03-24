*** Settings ***
Force Tags    WLS_PCMS_Order
Library           OperatingSystem
Resource          ${CURDIR}/../../Resource/init.robot
Library           ${CURDIR}/../../Python_Library/DatabaseData.py
Resource          ${CURDIR}/../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../Keyword/Features/Create_Order/Create_order.txt
Resource          ${CURDIR}/../../Keyword/API/common/api_keywords.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Product/update_stock.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Item_status/update_item_status.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ../../Keyword/API/PCMS/Create_Order_API/Create_Order_API.robot

*** Variables ***
${email}          test_IMEI@domain.com
${inventory_id}    LOAAB1111111
#เมาส์พร้อมคีย์บอร์ด Logitech Wireless mouse MK240 (Black)

*** Test Cases ***
TC_ITMWM_01857 Verify that system update serial/EMI on DB and display serial/EMI on PCMS when FMS update item status to shipped
    [Tags]    regression     ready    TC_ITMWM_01857    WLS_High
    ${email}    Set Variable    guest@email.com
    ${sap_material_code}    Set Variable    robot_sap_code_123
    ${material_id}    Set Variable    robot_material_id_123
    ${serial_number}    Set Variable    123456
    # ITM buy item payment success
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    Close All Browsers
    # DB get order shipment item id
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${serial_number_after_create_new_order}    Set Variable    ${order_shipment_data[0][5]}
    Should Be Equal As Strings    ${serial_number_after_create_new_order}    None
    # FMS update status picked packed
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1
    Send Api update status    ${body}
    # FMS update status shipped
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    1
    Send Api update status    ${body}
    # Verify serial number store and display properly
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    jquery=td.serial_number_${order_shipment_item_id}    ${serial_number}
    Element Should Contain    id=current_item_status${order_shipment_item_id}    Shipped
    # DB get serial number
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${serial_number_after_create_new_order}    Set Variable    ${order_shipment_data[0][5]}
    Should Be Equal As Strings    ${serial_number_after_create_new_order}    ${serial_number}
    [Teardown]    Close All Browsers

TC_ITMWM_01858 [Multi items] Verify that system update serial/IMEI on DB and display serial/IMEI on PCMS when FMS update item status to shipped
    [Tags]    regression     ready    TC_ITMWM_01858    WLS_High
    ${email}    Set Variable    guest@email.com
    ${sap_material_code}    Set Variable    robot_sap_code_123
    ${material_id}    Set Variable    robot_material_id_123
    ${serial_number}    Set Variable    123456
    # ITM buy item payment success
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    Close All Browsers
    # DB get order shipment item id
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${serial_number_after_create_new_order}    Set Variable    ${order_shipment_data[0][5]}
    Should Be Equal As Strings    ${serial_number_after_create_new_order}    None
    # FMS update status picked packed
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    2
    Send Api update status    ${body}
    # FMS update status shipped
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    2
    Send Api update status    ${body}
    # Verify serial number store and display properly
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    jquery=td.serial_number_${order_shipment_item_id}    ${serial_number}
    # DB get serial number
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${serial_number_after_create_new_order}    Set Variable    ${order_shipment_data[0][5]}
    Should Be Equal As Strings    ${serial_number_after_create_new_order}    ${serial_number}
    [Teardown]    Close All Browsers

TC_ITMWM_01859 Verify that system can update item status to shipped when FMS update item status to shipped without serial/IMEI
    [Tags]    regression     ready    TC_ITMWM_01859    WLS_Medium
    ${email}    Set Variable    guest@email.com
    ${sap_material_code}    Set Variable    robot_sap_code_123
    ${material_id}    Set Variable    robot_material_id_123
    ${serial_number}    Set Variable    ${EMPTY}
    # ITM buy item payment success
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    Close All Browsers
    # DB get order shipment item id
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${serial_number_after_create_new_order}    Set Variable    ${order_shipment_data[0][5]}
    Should Be Equal As Strings    ${serial_number_after_create_new_order}    None
    # FMS update status picked packed
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1
    Send Api update status    ${body}
    # FMS update status shipped
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    1
    Send Api update status    ${body}
    # Verify status changed properly
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    jquery=td.serial_number_${order_shipment_item_id}    -
    Element Should Contain    id=current_item_status${order_shipment_item_id}    Shipped
    # DB get serial number
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${serial_number_after_create_new_order}    Set Variable    ${order_shipment_data[0][5]}
    Should Be Equal As Strings    ${serial_number_after_create_new_order}    None
    [Teardown]    Close All Browsers
