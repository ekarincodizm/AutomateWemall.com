*** Settings ***
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
${email}          test_stocktype@domain.com
${inventory_id}    LOAAB1111111
#เมาส์พร้อมคีย์บอร์ด Logitech Wireless mouse MK240 (Black)

*** Test Cases ***
TC_1751_TC1 Verify stock type can be write in DB (Type RT)
    [Tags]    ITM_1751_TC1    ready
    ${set_stock_type}=    Set Variable    RT
    ${email}=    Set Variable    guest@email.com
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    # LOGIN PCMS
    # TrackOrder - Go To Order Detail Page    ${order_id}
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id}    -
    # Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    ${set_stock_type}
    Send Api update status    ${body}
    ${stock_type_db}=    get stock type    ${order_shipment_item_id}
    ${log_order_db}=    get log order shipment item    ${order_shipment_item_id}
    Should Be Equal As Strings    ${stock_type_db[0][0]}    ${set_stock_type}
    Should Be Equal As Strings    ${log_order_db[0][1]}    pending_shipment
    Should Be Equal As Strings    ${log_order_db[0][2]}    api
    # Close All Browsers
    # LOGIN PCMS
    # TrackOrder - Go To Order Detail Page    ${order_id}
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id}    ${set_stock_type}
    [Teardown]    Close All Browsers

TC_1751_TC2 Verify stock type can be write in DB (Type RD)
    [Tags]    ITM_1751_TC2    ready
    ${email}    Set Variable    guest@email.com
    ${set_stock_type}=    Set Variable    RD
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    # LOGIN PCMS
    # TrackOrder - Go To Order Detail Page    ${order_id}
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id}    -
    # Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    ${set_stock_type}
    Send Api update status    ${body}
    ${stock_type_db}=    get stock type    ${order_shipment_item_id}
    ${log_order_db}=    get log order shipment item    ${order_shipment_item_id}
    Should Be Equal As Strings    ${stock_type_db[0][0]}    ${set_stock_type}
    Should Be Equal As Strings    ${log_order_db[0][1]}    pending_shipment
    Should Be Equal As Strings    ${log_order_db[0][2]}    api
    # Close All Browsers
    # LOGIN PCMS
    # TrackOrder - Go To Order Detail Page    ${order_id}
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id}    ${set_stock_type}
    [Teardown]    Close All Browsers

TC_1751_TC3 Verify stock type can be write in DB (Type RX)
    [Tags]    ITM_1751_TC3    ready
    ${email}    Set Variable    guest@email.com
    ${set_stock_type}=    Set Variable    RX
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    # LOGIN PCMS
    # TrackOrder - Go To Order Detail Page    ${order_id}
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id}    -
    # Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    ${set_stock_type}
    Send Api update status    ${body}
    ${stock_type_db}=    get stock type    ${order_shipment_item_id}
    ${log_order_db}=    get log order shipment item    ${order_shipment_item_id}
    Should Be Equal As Strings    ${stock_type_db[0][0]}    ${set_stock_type}
    Should Be Equal As Strings    ${log_order_db[0][1]}    pending_shipment
    Should Be Equal As Strings    ${log_order_db[0][2]}    api
    # Close All Browsers
    # LOGIN PCMS
    # TrackOrder - Go To Order Detail Page    ${order_id}
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id}    ${set_stock_type}
    [Teardown]    Close All Browsers

TC_1751_TC4 Verify stock type can be write in DB (Type CT)
    [Tags]    ITM_1751_TC4    ready
    ${email}    Set Variable    guest@email.com
    ${set_stock_type}=    Set Variable    CT
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    # LOGIN PCMS
    # TrackOrder - Go To Order Detail Page    ${order_id}
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id}    -
    # Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    ${set_stock_type}
    Send Api update status    ${body}
    ${stock_type_db}=    get stock type    ${order_shipment_item_id}
    ${log_order_db}=    get log order shipment item    ${order_shipment_item_id}
    Should Be Equal As Strings    ${stock_type_db[0][0]}    ${set_stock_type}
    Should Be Equal As Strings    ${log_order_db[0][1]}    pending_shipment
    Should Be Equal As Strings    ${log_order_db[0][2]}    api
    # Close All Browsers
    # LOGIN PCMS
    # TrackOrder - Go To Order Detail Page    ${order_id}
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id}    ${set_stock_type}
    [Teardown]    Close All Browsers

TC_1751_TC5 Verify stock type can be write in DB (Type MF)
    [Tags]    ITM_1751_TC5    ready
    ${email}    Set Variable    guest@email.com
    ${set_stock_type}=    Set Variable    MF
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    # LOGIN PCMS
    # TrackOrder - Go To Order Detail Page    ${order_id}
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id}    -
    # Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    ${set_stock_type}
    Send Api update status    ${body}
    ${stock_type_db}=    get stock type    ${order_shipment_item_id}
    ${log_order_db}=    get log order shipment item    ${order_shipment_item_id}
    Should Be Equal As Strings    ${stock_type_db[0][0]}    ${set_stock_type}
    Should Be Equal As Strings    ${log_order_db[0][1]}    pending_shipment
    Should Be Equal As Strings    ${log_order_db[0][2]}    api
    # Close All Browsers
    # LOGIN PCMS
    # TrackOrder - Go To Order Detail Page    ${order_id}
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id}    ${set_stock_type}
    [Teardown]    Close All Browsers

TC_1751_TC6 Verify stock type can be write in DB (Type MX)
    [Tags]    ITM_1751_TC6    ready
    ${email}    Set Variable    guest@email.com
    ${set_stock_type}=    Set Variable    MX
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    # LOGIN PCMS
    # TrackOrder - Go To Order Detail Page    ${order_id}
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id}    -
    # Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    ${set_stock_type}
    Send Api update status    ${body}
    ${stock_type_db}=    get stock type    ${order_shipment_item_id}
    ${log_order_db}=    get log order shipment item    ${order_shipment_item_id}
    Should Be Equal As Strings    ${stock_type_db[0][0]}    ${set_stock_type}
    Should Be Equal As Strings    ${log_order_db[0][1]}    pending_shipment
    Should Be Equal As Strings    ${log_order_db[0][2]}    api
    # Close All Browsers
    # LOGIN PCMS
    # TrackOrder - Go To Order Detail Page    ${order_id}
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id}    ${set_stock_type}
    [Teardown]    Close All Browsers

TC_1751_TC7 Verify stock type can be write in DB (Type MD)
    [Tags]    ITM_1751_TC7    ready
    ${email}    Set Variable    guest@email.com
    ${set_stock_type}=    Set Variable    MD
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    # LOGIN PCMS
    # TrackOrder - Go To Order Detail Page    ${order_id}
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id}    -
    # Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    ${set_stock_type}
    Send Api update status    ${body}
    ${stock_type_db}=    get stock type    ${order_shipment_item_id}
    ${log_order_db}=    get log order shipment item    ${order_shipment_item_id}
    Should Be Equal As Strings    ${stock_type_db[0][0]}    ${set_stock_type}
    Should Be Equal As Strings    ${log_order_db[0][1]}    pending_shipment
    Should Be Equal As Strings    ${log_order_db[0][2]}    api
    # Close All Browsers
    # LOGIN PCMS
    # TrackOrder - Go To Order Detail Page    ${order_id}
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id}    ${set_stock_type}
    [Teardown]    Close All Browsers

ITM_1751_TC8 Verify stock Only PICK
    [Tags]    ITM_1751_TC8    ready
    ${email}    Set Variable    guest@email.com
    ${set_stock_type}=    Set Variable    RT
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    # LOGIN PCMS
    # TrackOrder - Go To Order Detail Page    ${order_id}
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id}    -
    # Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack One Json - no stocktype    ${order_id}    ${order_shipment_data}    picked    ${set_stock_type}    1
    Send Api update status    ${body}
    Log to console    ${body}
    ${stock_type_db}=    get stock type    ${order_shipment_item_id}
    ${log_order_db}=    get log order shipment item    ${order_shipment_item_id}
    Should Be Equal As Strings    ${stock_type_db[0][0]}    ${set_stock_type}
    Should Be Equal As Strings    ${log_order_db[0][1]}    pending_shipment
    Should Be Equal As Strings    ${log_order_db[0][2]}    api
    # Close All Browsers
    # LOGIN PCMS
    # TrackOrder - Go To Order Detail Page    ${order_id}
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id}    ${set_stock_type}
    [Teardown]    Close All Browsers

ITM_1751_TC9 Verify stock Only PACK
    [Tags]    ITM_1751_TC9    ready
    ${email}    Set Variable    guest@email.com
    ${set_stock_type}=    Set Variable    CT
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    # LOGIN PCMS
    # TrackOrder - Go To Order Detail Page    ${order_id}
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id}    -
    # Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack One Json - no stocktype    ${order_id}    ${order_shipment_data}    packed    ${set_stock_type}    1
    Send Api update status    ${body}
    ${stock_type_db}=    get stock type    ${order_shipment_item_id}
    ${log_order_db}=    get log order shipment item    ${order_shipment_item_id}
    Should Be Equal As Strings    ${stock_type_db[0][0]}    ${set_stock_type}
    Should Be Equal As Strings    ${log_order_db[0][1]}    pending_shipment
    Should Be Equal As Strings    ${log_order_db[0][2]}    api
    # Close All Browsers
    # LOGIN PCMS
    # TrackOrder - Go To Order Detail Page    ${order_id}
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id}    ${set_stock_type}
    [Teardown]    Close All Browsers

TC_1751_TC10 Verify no have stock type picked
    [Tags]    ITM_1751_TC10    ready
    ${email}    Set Variable    guest@email.com
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${body}=    Create Request Api update item status Pick&Pack One Json - no stocktype    ${order_id}    ${order_shipment_data}    picked    MMM    1
    ...    fail
    ${response}=    Send Api update status fail    ${body}
    Should Be Equal As Strings    ${response['code']}    400
    Should Be Equal As Strings    ${response['status']}    error
    Should Be Equal As Strings    ${response['message']}    Missing Required Fields
    [Teardown]    Close All Browsers

TC_1751_TC11 Verify no have stock type packed
    [Tags]    ITM_1751_TC11    ready
    ${email}    Set Variable    guest@email.com
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${body}=    Create Request Api update item status Pick&Pack One Json - no stocktype    ${order_id}    ${order_shipment_data}    packed    MMM    1
    ...    fail
    ${response}=    Send Api update status fail    ${body}
    Log to console    ${response}
    Should Be Equal As Strings    ${response['code']}    400
    Should Be Equal As Strings    ${response['status']}    error
    Should Be Equal As Strings    ${response['message']}    Missing Required Fields
    [Teardown]    Close All Browsers

TC_1751_TC12 Verify no have stock type picked invalid
    [Tags]    ITM_1751_TC12    ready
    ${email}    Set Variable    guest@email.com
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${body}=    Create Request Api update item status Pick&Pack One Json - no stocktype    ${order_id}    ${order_shipment_data}    picked    MMM    1
    ${response}=    Send Api update status fail    ${body}
    Log to console    ${response}
    Should Be Equal As Strings    ${response['code']}    400
    Should Be Equal As Strings    ${response['status']}    error
    Should Be Equal As Strings    ${response['data']}    {u'stock_type_not_found': [u'${order_shipment_item_id}']}
    [Teardown]    Close All Browsers

TC_1751_TC13 Verify no have stock type packed invalid
    [Tags]    ITM_1751_TC13    ready
    ${email}    Set Variable    guest@email.com
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${body}=    Create Request Api update item status Pick&Pack One Json - no stocktype    ${order_id}    ${order_shipment_data}    packed    MMM    1
    ${response}=    Send Api update status fail    ${body}
    Should Be Equal As Strings    ${response['code']}    400
    Should Be Equal As Strings    ${response['status']}    error
    Should Be Equal As Strings    ${response['data']}    {u'stock_type_not_found': [u'${order_shipment_item_id}']}
    [Teardown]    Close All Browsers

TC_1751_TC14 Verify no stock type node - error - picked(no node)&packed(no node)
    [Tags]    ITM_1751_TC14    ready
    ${email}    Set Variable    guest@email.com
    ${set_stock_type}=    Set Variable    RT
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${body}=    Create Request Api update item status Pick&Pack with serial number No Stocktype for Multi-item    ${order_id}    ${order_shipment_data}    1
    ${response}=    Send Api update status fail    ${body}
    Should Be Equal As Strings    ${response['code']}    400
    Should Be Equal As Strings    ${response['status']}    error
    Should Be Equal As Strings    ${response['data']}    [u'0 : stock_type field not found', u'1 : stock_type field not found']
    [Teardown]    Close All Browsers

TC_1751_TC15 Verify no stock type node - error - picked(no value)&packed(no value)
    [Tags]    ITM_1751_TC15    ready
    ${email}    Set Variable    guest@email.com
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    AA
    ${body}=    Set Json Value    ${body}    /0/stock_type    ""
    ${body}=    Set Json Value    ${body}    /1/stock_type    ""
    Log to console    ${body}
    ${response}=    Send Api update status fail    ${body}
    Should Be Equal As Strings    ${response['code']}    400
    Should Be Equal As Strings    ${response['status']}    error
    Should Be Equal As Strings    ${response['data']}    [u'0 : stock_type cannot be null', u'1 : stock_type cannot be null']
    [Teardown]    Close All Browsers

TC_1751_TC16 Verify no stock type node - error - picked(no node)&packed(no value)
    [Tags]    ITM_1751_TC16    ready
    ${email}    Set Variable    guest@email.com
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${body}=    Create Request Api update item status Pick&Pack with serial number No Stocktype for Multi-item    ${order_id}    ${order_shipment_data}    1
    ${body}=    Set Json Value    ${body}    /1/stock_type    ""
    ${response}=    Send Api update status fail    ${body}
    Should Be Equal As Strings    ${response['code']}    400
    Should Be Equal As Strings    ${response['status']}    error
    Should Be Equal As Strings    ${response['data']}    [u'0 : stock_type field not found', u'1 : stock_type cannot be null']
    [Teardown]    Close All Browsers

TC_1751_TC17 Verify no stock type node - error - picked(no value)&packed(RD)
    [Tags]    ITM_1751_TC17    ready
    ${email}    Set Variable    guest@email.com
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    RD
    ${body}=    Set Json Value    ${body}    /0/stock_type    ""
    ${response}=    Send Api update status fail    ${body}
    Should Be Equal As Strings    ${response['code']}    400
    Should Be Equal As Strings    ${response['status']}    error
    Should Be Equal As Strings    ${response['data']}    [u'0 : stock_type cannot be null']
    [Teardown]    Close All Browsers

TC_1751_TC18 Verify no stock type node - error - picked(MF)&packed(no value)
    [Tags]    ITM_1751_TC18    ready
    ${email}    Set Variable    guest@email.com
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    MF
    ${body}=    Set Json Value    ${body}    /1/stock_type    ""
    ${response}=    Send Api update status fail    ${body}
    Should Be Equal As Strings    ${response['code']}    400
    Should Be Equal As Strings    ${response['status']}    error
    Should Be Equal As Strings    ${response['data']}    [u'1 : stock_type cannot be null']
    [Teardown]    Close All Browsers

ITM_1751_TC19 Verify incorrect stock type (RA) - error - picked
    [Tags]    ITM_1751_TC19    ready
    ${email}    Set Variable    guest@email.com
    ${set_stock_type}=    Set Variable    RA
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${body}=    Create Request Api update item status Pick&Pack One Json - no stocktype    ${order_id}    ${order_shipment_data}    picked    ${set_stock_type}    1
    ${response}=    Send Api update status fail    ${body}
    Should Be Equal As Strings    ${response['code']}    400
    Should Be Equal As Strings    ${response['status']}    error
    Should Be Equal As Strings    ${response['data']}    {u'stock_type_not_found': [u'${order_shipment_item_id}']}
    [Teardown]    Close All Browsers

ITM_1751_TC20 Verify incorrect stock type (MZ) - error - packed
    [Tags]    ITM_1751_TC20    ready
    ${email}    Set Variable    guest@email.com
    ${set_stock_type}=    Set Variable    MZ
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${body}=    Create Request Api update item status Pick&Pack One Json - no stocktype    ${order_id}    ${order_shipment_data}    picked    ${set_stock_type}    1
    ${response}=    Send Api update status fail    ${body}
    Should Be Equal As Strings    ${response['code']}    400
    Should Be Equal As Strings    ${response['status']}    error
    Should Be Equal As Strings    ${response['data']}    {u'stock_type_not_found': [u'${order_shipment_item_id}']}
    [Teardown]    Close All Browsers

TC_1751_TC21 Verify incorrect stock type - error - picked(XX)&packed(YY)
    [Tags]    ITM_1751_TC21    ready
    ${email}    Set Variable    guest@email.com
    ${set_stock_type}=    Set Variable    XX
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    ${set_stock_type}
    ${body}=    Set Json Value    ${body}    /1/stock_type    "YY"
    ${response}=    Send Api update status fail    ${body}
    Should Be Equal As Strings    ${response['code']}    400
    Should Be Equal As Strings    ${response['status']}    error
    Should Be Equal As Strings    ${response['data']}    {u'stock_type_not_found': [u'${order_shipment_item_id}', u'${order_shipment_item_id}']}
    [Teardown]    Close All Browsers

TC_1751_TC22 Verify incorrect stock type - error - picked(AA)&packed(RX)
    [Tags]    ITM_1751_TC22    ready
    ${email}    Set Variable    guest@email.com
    ${set_stock_type}=    Set Variable    AA
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    ${set_stock_type}
    ${body}=    Set Json Value    ${body}    /1/stock_type    "RX"
    ${response}=    Send Api update status fail    ${body}
    Should Be Equal As Strings    ${response['code']}    400
    Should Be Equal As Strings    ${response['status']}    error
    Should Be Equal As Strings    ${response['data']}    {u'stock_type_not_found': [u'${order_shipment_item_id}']}
    [Teardown]    Close All Browsers

TC_1751_TC23 Verify incorrect stock type - error - picked(MD)&packed(BB)
    [Tags]    ITM_1751_TC23    ready
    ${email}=    Set Variable    guest@email.com
    ${set_stock_type}=    Set Variable    MD
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    ${set_stock_type}
    ${body}=    Set Json Value    ${body}    /1/stock_type    "BB"
    ${response}=    Send Api update status fail    ${body}
    Should Be Equal As Strings    ${response['code']}    400
    Should Be Equal As Strings    ${response['status']}    error
    Should Be Equal As Strings    ${response['data']}    {u'stock_type_not_found': [u'${order_shipment_item_id}']}
    [Teardown]    Close All Browsers

ITM_1751_TC24 Verify stock 2 item success (RT,RD) - picked
    [Tags]    ITM_1751_TC24    ready
    ${set_stock_type}=    Set Variable    RT
    ${set_stock_type_item2}=    Set Variable    RD
    ${email}=    Set Variable    guest@email.com
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${order_shipment_item_id_item2}    Set Variable    ${order_shipment_data[1][0]}
    # LOGIN PCMS
    # TrackOrder - Go To Order Detail Page    ${order_id}
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id}    -
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id_item2}    -
    # Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack One Json - no stocktype    ${order_id}    ${order_shipment_data}    picked    ${set_stock_type}    2
    ${body}=    Set Json Value    ${body}    /1/stock_type    "${set_stock_type_item2}"
    Send Api update status    ${body}
    ${stock_type_db}=    get stock type    ${order_shipment_item_id}
    ${stock_type_db_item2}=    get stock type    ${order_shipment_item_id_item2}
    ${log_order_db}=    get log order shipment item    ${order_shipment_item_id}
    ${log_order_db_item2}=    get log order shipment item    ${order_shipment_item_id_item2}
    Should Be Equal As Strings    ${stock_type_db[0][0]}    ${set_stock_type}
    Should Be Equal As Strings    ${stock_type_db_item2[0][0]}    ${set_stock_type_item2}
    Should Be Equal As Strings    ${log_order_db[0][1]}    pending_shipment
    Should Be Equal As Strings    ${log_order_db[0][2]}    api
    Should Be Equal As Strings    ${log_order_db_item2[0][1]}    pending_shipment
    Should Be Equal As Strings    ${log_order_db_item2[0][2]}    api
    # Close All Browsers
    # LOGIN PCMS
    # TrackOrder - Go To Order Detail Page    ${order_id}
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id}    ${set_stock_type}
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id_item2}    ${set_stock_type_item2}
    [Teardown]    Close All Browsers

ITM_1751_TC25 Verify stock 2 item success (RX,CT) - packed
    [Tags]    ITM_1751_TC25    ready
    ${email}=    Set Variable    guest@email.com
    ${set_stock_type}=    Set Variable    RX
    ${set_stock_type_item2}=    Set Variable    CT
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${order_shipment_item_id_item2}    Set Variable    ${order_shipment_data[1][0]}
    # LOGIN PCMS
    # TrackOrder - Go To Order Detail Page    ${order_id}
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id}    -
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id_item2}    -
    # Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack One Json - no stocktype    ${order_id}    ${order_shipment_data}    packed    ${set_stock_type}    2
    ${body}=    Set Json Value    ${body}    /1/stock_type    "${set_stock_type_item2}"
    Send Api update status    ${body}
    ${stock_type_db}=    get stock type    ${order_shipment_item_id}
    ${stock_type_db_item2}=    get stock type    ${order_shipment_item_id_item2}
    ${log_order_db}=    get log order shipment item    ${order_shipment_item_id}
    ${log_order_db_item2}=    get log order shipment item    ${order_shipment_item_id_item2}
    Should Be Equal As Strings    ${stock_type_db[0][0]}    ${set_stock_type}
    Should Be Equal As Strings    ${stock_type_db_item2[0][0]}    ${set_stock_type_item2}
    Should Be Equal As Strings    ${log_order_db[0][1]}    pending_shipment
    Should Be Equal As Strings    ${log_order_db[0][2]}    api
    Should Be Equal As Strings    ${log_order_db_item2[0][1]}    pending_shipment
    Should Be Equal As Strings    ${log_order_db_item2[0][2]}    api
    # Close All Browsers
    # LOGIN PCMS
    # TrackOrder - Go To Order Detail Page    ${order_id}
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id}    ${set_stock_type}
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id_item2}    ${set_stock_type_item2}
    [Teardown]    Close All Browsers

TC_1751_TC26 Verify stock type 2 item success (MF,MX) - picked&packed
    [Tags]    ITM_1751_TC26    ready
    ${email}    Set Variable    guest@email.com
    ${set_stock_type}=    Set Variable    MF
    ${set_stock_type_item2}=    Set Variable    MX
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${order_shipment_item_id_item2}    Set Variable    ${order_shipment_data[1][0]}
    # LOGIN PCMS
    # TrackOrder - Go To Order Detail Page    ${order_id}
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id}    -
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id_item2}    -
    # Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    2    ${set_stock_type}
    ${body}=    Set Json Value    ${body}    /2/stock_type    "${set_stock_type_item2}"
    ${body}=    Set Json Value    ${body}    /3/stock_type    "${set_stock_type_item2}"
    Send Api update status    ${body}
    ${stock_type_db}=    get stock type    ${order_shipment_item_id}
    ${stock_type_db_item2}=    get stock type    ${order_shipment_item_id_item2}
    ${log_order_db}=    get log order shipment item    ${order_shipment_item_id}
    ${log_order_db_item2}=    get log order shipment item    ${order_shipment_item_id_item2}
    Should Be Equal As Strings    ${stock_type_db[0][0]}    ${set_stock_type}
    Should Be Equal As Strings    ${stock_type_db_item2[0][0]}    ${set_stock_type_item2}
    Should Be Equal As Strings    ${log_order_db[0][1]}    pending_shipment
    Should Be Equal As Strings    ${log_order_db[0][2]}    api
    Should Be Equal As Strings    ${log_order_db_item2[0][1]}    pending_shipment
    Should Be Equal As Strings    ${log_order_db_item2[0][2]}    api
    # Close All Browsers
    # LOGIN PCMS
    # TrackOrder - Go To Order Detail Page    ${order_id}
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id}    ${set_stock_type}
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id_item2}    ${set_stock_type_item2}
    [Teardown]    Close All Browsers

TC_1751_TC27 Verify 2 items - no stock type (no node,no value) - error - picked
    [Tags]    ITM_1751_TC27    ready
    ${email}    Set Variable    guest@email.com
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${order_shipment_item_id_item2}    Set Variable    ${order_shipment_data[1][0]}
    ${body}=    Create Request Api update item status Pick&Pack One Json - no stocktype    ${order_id}    ${order_shipment_data}    picked    xxx    2
    ...    fail
    ${body}=    Set Json Value    ${body}    /1/stock_type    ""
    ${response}=    Send Api update status fail    ${body}
    Should Be Equal As Strings    ${response['code']}    400
    Should Be Equal As Strings    ${response['status']}    error
    Should Be Equal As Strings    ${response['data']}    [u'0 : stock_type field not found', u'1 : stock_type cannot be null']
    [Teardown]    Close All Browsers

TC_1751_TC28 Verify 2 items - no stock type (no node,no value) - error - packed
    [Tags]    ITM_1751_TC28    ready
    ${email}    Set Variable    guest@email.com
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${order_shipment_item_id_item2}    Set Variable    ${order_shipment_data[1][0]}
    ${body}=    Create Request Api update item status Pick&Pack One Json - no stocktype    ${order_id}    ${order_shipment_data}    picked    xxx    2
    ...    fail
    ${response}=    Send Api update status fail    ${body}
    Should Be Equal As Strings    ${response['code']}    400
    Should Be Equal As Strings    ${response['status']}    error
    Should Be Equal As Strings    ${response['data']}    [u'0 : stock_type field not found', u'1 : stock_type field not found']
    [Teardown]    Close All Browsers

TC_1751_TC29 Verify no stock type (no node,no node,no value,no value) - error -picked&packed
    [Tags]    ITM_1751_TC29    ready
    ${email}    Set Variable    guest@email.com
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${order_shipment_item_id_item2}    Set Variable    ${order_shipment_data[1][0]}
    ${body}=    Create Request Api update item status Pick&Pack with serial number No Stocktype for Multi-item    ${order_id}    ${order_shipment_data}    2
    ${body}=    Set Json Value    ${body}    /2/stock_type    ""
    ${body}=    Set Json Value    ${body}    /3/stock_type    ""
    ${response}=    Send Api update status fail    ${body}
    Should Be Equal As Strings    ${response['code']}    400
    Should Be Equal As Strings    ${response['status']}    error
    Should Be Equal As Strings    ${response['data']}    [u'0 : stock_type field not found', u'1 : stock_type field not found', u'2 : stock_type cannot be null', u'3 : stock_type cannot be null']
    [Teardown]    Close All Browsers

TC_1751_TC30 Verify 2 items incorrect stock type (MD,DD) - error - picked
    [Tags]    ITM_1751_TC30    ready
    ${email}    Set Variable    guest@email.com
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${order_shipment_item_id_item2}    Set Variable    ${order_shipment_data[1][0]}
    ${body}=    Create Request Api update item status Pick&Pack One Json - no stocktype    ${order_id}    ${order_shipment_data}    picked    xxx    2
    ...    fail
    ${body}=    Set Json Value    ${body}    /0/stock_type    "MD"
    ${body}=    Set Json Value    ${body}    /1/stock_type    "DD"
    ${response}=    Send Api update status fail    ${body}
    Should Be Equal As Strings    ${response['code']}    400
    Should Be Equal As Strings    ${response['status']}    error
    Should Be Equal As Strings    ${response['data']}    {u'stock_type_not_found': [u'${order_shipment_item_id_item2}']}
    [Teardown]    Close All Browsers

TC_1751_TC31 Verify 2 items incorrect stock type (MD,DD) - error - picked
    [Tags]    ITM_1751_TC31    ready
    ${email}    Set Variable    guest@email.com
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${order_shipment_item_id_item2}    Set Variable    ${order_shipment_data[1][0]}
    ${body}=    Create Request Api update item status Pick&Pack One Json - no stocktype    ${order_id}    ${order_shipment_data}    picked    xxx    2
    ...    fail
    ${body}=    Set Json Value    ${body}    /0/stock_type    "CC"
    ${body}=    Set Json Value    ${body}    /1/stock_type    "DD"
    ${response}=    Send Api update status fail    ${body}
    Should Be Equal As Strings    ${response['code']}    400
    Should Be Equal As Strings    ${response['status']}    error
    Should Be Equal As Strings    ${response['data']}    {u'stock_type_not_found': [u'${order_shipment_item_id}', u'${order_shipment_item_id_item2}']}
    [Teardown]    Close All Browsers

TC_1751_TC32 Verify 2 items incorrect stock type (EE,MF) - error - packed
    [Tags]    ITM_1751_TC32    ready
    ${email}    Set Variable    guest@email.com
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${order_shipment_item_id_item2}    Set Variable    ${order_shipment_data[1][0]}
    ${body}=    Create Request Api update item status Pick&Pack One Json - no stocktype    ${order_id}    ${order_shipment_data}    packed    xxx    2
    ...    fail
    ${body}=    Set Json Value    ${body}    /0/stock_type    "EE"
    ${body}=    Set Json Value    ${body}    /1/stock_type    "MF"
    ${response}=    Send Api update status fail    ${body}
    Should Be Equal As Strings    ${response['code']}    400
    Should Be Equal As Strings    ${response['status']}    error
    Should Be Equal As Strings    ${response['data']}    {u'stock_type_not_found': [u'${order_shipment_item_id}']}
    [Teardown]    Close All Browsers

TC_1751_TC33 Verify 2 items incorrect stock type (EE,FF) - error - packed
    [Tags]    ITM_1751_TC33    ready
    ${email}    Set Variable    guest@email.com
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${order_shipment_item_id_item2}    Set Variable    ${order_shipment_data[1][0]}
    ${body}=    Create Request Api update item status Pick&Pack One Json - no stocktype    ${order_id}    ${order_shipment_data}    picked    xxx    2
    ...    fail
    ${body}=    Set Json Value    ${body}    /0/stock_type    "EE"
    ${body}=    Set Json Value    ${body}    /1/stock_type    "FF"
    ${response}=    Send Api update status fail    ${body}
    Should Be Equal As Strings    ${response['code']}    400
    Should Be Equal As Strings    ${response['status']}    error
    Should Be Equal As Strings    ${response['data']}    {u'stock_type_not_found': [u'${order_shipment_item_id}', u'${order_shipment_item_id_item2}']}
    [Teardown]    Close All Browsers

TC_1751_TC34 Verify 2 items incorrect stock type (MD,HH,no node,no value) - error - picked&packed
    [Tags]    ITM_1751_TC34    ready
    ${email}    Set Variable    guest@email.com
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${order_shipment_item_id_item2}    Set Variable    ${order_shipment_data[1][0]}
    ${body}=    Create Request Api update item status Pick&Pack with serial number No Stocktype for Multi-item    ${order_id}    ${order_shipment_data}    2
    ${body}=    Set Json Value    ${body}    /0/stock_type    "MD"
    ${body}=    Set Json Value    ${body}    /1/stock_type    "HH"
    ${body}=    Set Json Value    ${body}    /3/stock_type    ""
    ${response}=    Send Api update status fail    ${body}
    Should Be Equal As Strings    ${response['code']}    400
    Should Be Equal As Strings    ${response['status']}    error
    Should Be Equal As Strings    ${response['data']}    [u'2 : stock_type field not found', u'3 : stock_type cannot be null']
    [Teardown]    Close All Browsers

TC_1751_TC35 Verify 2 items incorrect stock type (GG,HH,II,JJ) - error - picked&packed
    [Tags]    ITM_1751_TC35    ready
    ${email}    Set Variable    guest@email.com
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${order_shipment_item_id_item2}    Set Variable    ${order_shipment_data[1][0]}
    ${body}=    Create Request Api update item status Pick&Pack with serial number No Stocktype for Multi-item    ${order_id}    ${order_shipment_data}    2
    ${body}=    Set Json Value    ${body}    /0/stock_type    "GG"
    ${body}=    Set Json Value    ${body}    /1/stock_type    "HH"
    ${body}=    Set Json Value    ${body}    /2/stock_type    "II"
    ${body}=    Set Json Value    ${body}    /3/stock_type    "JJ"
    ${response}=    Send Api update status fail    ${body}
    Should Be Equal As Strings    ${response['code']}    400
    Should Be Equal As Strings    ${response['status']}    error
    Should Be Equal As Strings    ${response['data']}    {u'stock_type_not_found': [u'${order_shipment_item_id}', u'${order_shipment_item_id}', u'${order_shipment_item_id_item2}', u'${order_shipment_item_id_item2}']}
    [Teardown]    Close All Browsers

TC_1751_TC36 Verify can receive small letters and convert to capital lettes and insert to DB correctly. (rt)
    [Tags]    ITM_1751_TC36    ready
    ${set_stock_type}=    Set Variable    rt
    ${DB_stock_type}=    Set Variable    RT
    ${email}=    Set Variable    guest@email.com
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    # LOGIN PCMS
    # TrackOrder - Go To Order Detail Page    ${order_id}
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id}    -
    # Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    ${set_stock_type}
    Send Api update status    ${body}
    ${stock_type_db}=    get stock type    ${order_shipment_item_id}
    ${log_order_db}=    get log order shipment item    ${order_shipment_item_id}
    Should Be Equal As Strings    ${stock_type_db[0][0]}    ${DB_stock_type}
    Should Be Equal As Strings    ${log_order_db[0][1]}    pending_shipment
    Should Be Equal As Strings    ${log_order_db[0][2]}    api
    # Close All Browsers
    # LOGIN PCMS
    # TrackOrder - Go To Order Detail Page    ${order_id}
    # Element Should Contain    id=display_stock_type_${order_shipment_item_id}    ${DB_stock_type}
    # TC_1830 Verify stock type display "-" when no stock type in db
    #    [Tags]    ITM_1830_TC01
    #    [Teardown]    Close All Browsers
    #    ${order_id}=    Guest Buy Multiple-item Success with COD    ${email}    ${inventory_id}
    #    ${order_shipment_data}=    get order shipment item data    ${order_id}
    #    Close All Browsers
    #
    #    LOGIN PCMS
    #    TrackOrder - Go To Order Detail Page    ${order_id}
    #    Element Should Contain    id=display_stock_type_${order_shipment_data[0][0]}    -
    #    Element Should Contain    id=display_stock_type_${order_shipment_data[1][0]}    -
    # TC_1830 Verify item display stock type properly
    #    [Tags]    ITM_1830_TC02
    #    [Teardown]    Close All Browsers
    #    ${order_id}=    Guest Buy Multiple-item Success with COD    ${email}    ${inventory_id}
    #    ${order_shipment_data}=    get order shipment item data    ${order_id}
    #    LOGIN PCMS
    #    TrackOrder - Go To Order Detail Page    ${order_id}
    #    Element Should Contain    id=display_stock_type_${order_shipment_data[0][0]}    -
    #    Element Should Contain    id=display_stock_type_${order_shipment_data[1][0]}    -
    #    Close All Browsers
    #    ${stock_type}=    Set Variable    MX
    #    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    ${stock_type}
    #    Send Api update status    ${body}
    #    LOGIN PCMS
    #    TrackOrder - Go To Order Detail Page    ${order_id}
    #    Element Should Contain    id=display_stock_type_${order_shipment_data[0][0]}    ${stock_type}
    #    Element Should Contain    id=display_stock_type_${order_shipment_data[1][0]}    -
    # TC_1830 Verify all items display stock type properly
    #    [Tags]    ITM_1830_TC03
    #    [Teardown]    Close All Browsers
    #    ${order_id}=    Guest Buy Multiple-item Success with COD    ${email}    ${inventory_id}
    #    ${order_shipment_data}=    get order shipment item data    ${order_id}
    #    LOGIN PCMS
    #    TrackOrder - Go To Order Detail Page    ${order_id}
    #    Element Should Contain    id=display_stock_type_${order_shipment_data[0][0]}    -
    #    Element Should Contain    id=display_stock_type_${order_shipment_data[1][0]}    -
    #    Close All Browsers
    #    ${stock_type_1}=    Set Variable    MX
    #    ${stock_type_2}=    Set Variable    MD
    #    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    2    ${stock_type_1}
    #    ${body}=    Set Json Value    ${body}    /2/stock_type    "${stock_type_2}"
    #    ${body}=    Set Json Value    ${body}    /3/stock_type    "${stock_type_2}"
    #    Send Api update status    ${body}
    #    LOGIN PCMS
    #    TrackOrder - Go To Order Detail Page    ${order_id}
    #    Element Should Contain    id=display_stock_type_${order_shipment_data[0][0]}    ${stock_type_1}
    #    Element Should Contain    id=display_stock_type_${order_shipment_data[1][0]}    ${stock_type_2}
    [Teardown]    Close All Browsers
