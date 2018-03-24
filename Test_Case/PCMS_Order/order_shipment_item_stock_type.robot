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
${email}          test_stocktype@domain.com
${inventory_id}    LOAAB1111111
#เมาส์พร้อมคีย์บอร์ด Logitech Wireless mouse MK240 (Black)

*** Test Cases ***
TC_ITMWM_01908 [Single item] To verify that system can receive stock type = RT from FMS when FMS send picked and packed status to PCMS.
    [Tags]    regression    ready    TC_ITMWM_01908    WLS_High
    ${set_stock_type}=    Set Variable    RT
    ${email}=    Set Variable    guest@email.com
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    id=display_stock_type_${order_shipment_item_id}    -
    Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    ${set_stock_type}
    Send Api update status    ${body}
    ${stock_type_db}=    get stock type    ${order_shipment_item_id}
    ${log_order_db}=    get log order shipment item    ${order_shipment_item_id}
    Should Be Equal As Strings    ${stock_type_db[0][0]}    ${set_stock_type}
    Should Be Equal As Strings    ${log_order_db[0][1]}    pending_shipment
    Should Be Equal As Strings    ${log_order_db[0][2]}    api
    Close All Browsers
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    id=display_stock_type_${order_shipment_item_id}    ${set_stock_type}
    [Teardown]    Close All Browsers

TC_ITMWM_01909 [Single item] To verify that system can receive stock type = RD from FMS when FMS send picked and packed status to PCMS.
    [Tags]    regression    ready    TC_ITMWM_01909    WLS_High
    ${email}    Set Variable    guest@email.com
    ${set_stock_type}=    Set Variable    RD
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    id=display_stock_type_${order_shipment_item_id}    -
    Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    ${set_stock_type}
    Send Api update status    ${body}
    ${stock_type_db}=    get stock type    ${order_shipment_item_id}
    ${log_order_db}=    get log order shipment item    ${order_shipment_item_id}
    Should Be Equal As Strings    ${stock_type_db[0][0]}    ${set_stock_type}
    Should Be Equal As Strings    ${log_order_db[0][1]}    pending_shipment
    Should Be Equal As Strings    ${log_order_db[0][2]}    api
    Close All Browsers
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    id=display_stock_type_${order_shipment_item_id}    ${set_stock_type}
    [Teardown]    Close All Browsers

TC_ITMWM_01910 [Single item] To verify that system can receive stock type = RX from FMS when FMS send picked and packed status to PCMS.
    [Tags]    regression    ready    TC_ITMWM_01910    WLS_High
    ${email}    Set Variable    guest@email.com
    ${set_stock_type}=    Set Variable    RX
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    id=display_stock_type_${order_shipment_item_id}    -
    Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    ${set_stock_type}
    Send Api update status    ${body}
    ${stock_type_db}=    get stock type    ${order_shipment_item_id}
    ${log_order_db}=    get log order shipment item    ${order_shipment_item_id}
    Should Be Equal As Strings    ${stock_type_db[0][0]}    ${set_stock_type}
    Should Be Equal As Strings    ${log_order_db[0][1]}    pending_shipment
    Should Be Equal As Strings    ${log_order_db[0][2]}    api
    Close All Browsers
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    id=display_stock_type_${order_shipment_item_id}    ${set_stock_type}
    [Teardown]    Close All Browsers

TC_ITMWM_01911 [Single item] To verify that system can receive stock type = CT from FMS when FMS send picked and packed status to PCMS.
    [Tags]    regression    ready    TC_ITMWM_01911    WLS_High
    ${email}    Set Variable    guest@email.com
    ${set_stock_type}=    Set Variable    CT
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    id=display_stock_type_${order_shipment_item_id}    -
    Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    ${set_stock_type}
    Send Api update status    ${body}
    ${stock_type_db}=    get stock type    ${order_shipment_item_id}
    ${log_order_db}=    get log order shipment item    ${order_shipment_item_id}
    Should Be Equal As Strings    ${stock_type_db[0][0]}    ${set_stock_type}
    Should Be Equal As Strings    ${log_order_db[0][1]}    pending_shipment
    Should Be Equal As Strings    ${log_order_db[0][2]}    api
    Close All Browsers
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    id=display_stock_type_${order_shipment_item_id}    ${set_stock_type}
    [Teardown]    Close All Browsers

TC_ITMWM_01912 [Single item] To verify that system can receive stock type = MF from FMS when FMS send picked and packed status to PCMS.
    [Tags]    regression    ready    TC_ITMWM_01912    WLS_High
    ${email}    Set Variable    guest@email.com
    ${set_stock_type}=    Set Variable    MF
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    id=display_stock_type_${order_shipment_item_id}    -
    Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    ${set_stock_type}
    Send Api update status    ${body}
    ${stock_type_db}=    get stock type    ${order_shipment_item_id}
    ${log_order_db}=    get log order shipment item    ${order_shipment_item_id}
    Should Be Equal As Strings    ${stock_type_db[0][0]}    ${set_stock_type}
    Should Be Equal As Strings    ${log_order_db[0][1]}    pending_shipment
    Should Be Equal As Strings    ${log_order_db[0][2]}    api
    Close All Browsers
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    id=display_stock_type_${order_shipment_item_id}    ${set_stock_type}
    [Teardown]    Close All Browsers

TC_ITMWM_01913 [Single item] To verify that system can receive stock type = MX from FMS when FMS send picked and packed status to PCMS.
    [Tags]    regression    ready    TC_ITMWM_01913    WLS_High
    ${email}    Set Variable    guest@email.com
    ${set_stock_type}=    Set Variable    MX
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    id=display_stock_type_${order_shipment_item_id}    -
    Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    ${set_stock_type}
    Send Api update status    ${body}
    ${stock_type_db}=    get stock type    ${order_shipment_item_id}
    ${log_order_db}=    get log order shipment item    ${order_shipment_item_id}
    Should Be Equal As Strings    ${stock_type_db[0][0]}    ${set_stock_type}
    Should Be Equal As Strings    ${log_order_db[0][1]}    pending_shipment
    Should Be Equal As Strings    ${log_order_db[0][2]}    api
    Close All Browsers
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    id=display_stock_type_${order_shipment_item_id}    ${set_stock_type}
    [Teardown]    Close All Browsers

TC_ITMWM_01914 [Single item] To verify that system can receive stock type = MD from FMS when FMS send picked and packed status to PCMS.
    [Tags]    regression    ready    TC_ITMWM_01914    WLS_High
    ${email}    Set Variable    guest@email.com
    ${set_stock_type}=    Set Variable    MD
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    id=display_stock_type_${order_shipment_item_id}    -
    Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    ${set_stock_type}
    Send Api update status    ${body}
    ${stock_type_db}=    get stock type    ${order_shipment_item_id}
    ${log_order_db}=    get log order shipment item    ${order_shipment_item_id}
    Should Be Equal As Strings    ${stock_type_db[0][0]}    ${set_stock_type}
    Should Be Equal As Strings    ${log_order_db[0][1]}    pending_shipment
    Should Be Equal As Strings    ${log_order_db[0][2]}    api
    Close All Browsers
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    id=display_stock_type_${order_shipment_item_id}    ${set_stock_type}
    [Teardown]    Close All Browsers

TC_ITMWM_01915 [Single item] To verify that system can receive stock type = RT from FMS when FMS send only picked status to PCMS.
    [Tags]    regression    ready    TC_ITMWM_01915    WLS_High
    ${email}    Set Variable    guest@email.com
    ${set_stock_type}=    Set Variable    RT
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    id=display_stock_type_${order_shipment_item_id}    -
    Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack One Json - no stocktype    ${order_id}    ${order_shipment_data}    picked    ${set_stock_type}    1
    Send Api update status    ${body}
    Log to console    ${body}
    ${stock_type_db}=    get stock type    ${order_shipment_item_id}
    ${log_order_db}=    get log order shipment item    ${order_shipment_item_id}
    Should Be Equal As Strings    ${stock_type_db[0][0]}    ${set_stock_type}
    Should Be Equal As Strings    ${log_order_db[0][1]}    pending_shipment
    Should Be Equal As Strings    ${log_order_db[0][2]}    api
    Close All Browsers
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    id=display_stock_type_${order_shipment_item_id}    ${set_stock_type}
    [Teardown]    Close All Browsers

TC_ITMWM_01916 [Single item] To verify that system can receive stock type = CT from FMS when FMS send only packed status to PCMS.
    [Tags]    regression    ready    TC_ITMWM_01916    WLS_High
    ${email}    Set Variable    guest@email.com
    ${set_stock_type}=    Set Variable    CT
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    id=display_stock_type_${order_shipment_item_id}    -
    Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack One Json - no stocktype    ${order_id}    ${order_shipment_data}    packed    ${set_stock_type}    1
    Send Api update status    ${body}
    ${stock_type_db}=    get stock type    ${order_shipment_item_id}
    ${log_order_db}=    get log order shipment item    ${order_shipment_item_id}
    Should Be Equal As Strings    ${stock_type_db[0][0]}    ${set_stock_type}
    Should Be Equal As Strings    ${log_order_db[0][1]}    pending_shipment
    Should Be Equal As Strings    ${log_order_db[0][2]}    api
    Close All Browsers
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    id=display_stock_type_${order_shipment_item_id}    ${set_stock_type}
    [Teardown]    Close All Browsers

TC_ITMWM_01917 [Single item] To verify that system return error if send picked status by sending without stock type node
    [Tags]    regression    ready    TC_ITMWM_01917    WLS_Medium
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

TC_ITMWM_01918 [Single item] To verify that system return error if send packed status by sending without stock type node
    [Tags]    regression    ready    TC_ITMWM_01918    WLS_Medium
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

TC_ITMWM_01919 [Single item] To verify that system return error if send picked status by sending without stock type value
    [Tags]    regression    ready    TC_ITMWM_01919    WLS_Medium
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

TC_ITMWM_01920 [Single item] To verify that system return error if send packed status by sending without stock type value
    [Tags]    regression    ready    TC_ITMWM_01920    WLS_Medium
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

TC_ITMWM_01921 [Single item] To verify that system return error if send picked&packed status by sending without stock type node
    [Tags]    regression    ready    TC_ITMWM_01921    WLS_Medium
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

TC_ITMWM_01922 [Single item] To verify that system return error if send picked&packed status by sending without stock type value
    [Tags]    regression    ready    TC_ITMWM_01922    WLS_Medium
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

TC_ITMWM_01923 [Single item] To verify that system return error if send picked&packed status by sending without stock type node on picked and without stock type value on packed
    [Tags]    regression    ready    TC_ITMWM_01923    WLS_Medium
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

TC_ITMWM_01924 [Single item] To verify that system return error if send picked&packed status by sending without stock type value on picked but have stock type value on packed
    [Tags]    regression    ready    TC_ITMWM_01924    WLS_Medium
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

TC_ITMWM_01925 [Single item] To verify that system return error if send picked&packed status by sending without stock type value on packed but have stock type value on picked
    [Tags]    regression    ready    TC_ITMWM_01925    WLS_Medium
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

TC_ITMWM_01926 [Single item] To verify that system return error if send picked status by sending invalid stock type
    [Tags]    regression    ready    TC_ITMWM_01926    WLS_Medium
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

TC_ITMWM_01927 [Single item] To verify that system return error if send packed status by sending invalid stock type
    [Tags]    regression    ready    TC_ITMWM_01927    WLS_Medium
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

TC_ITMWM_01928 [Single item] To verify that system return error if send picked&packed status by sending invalid stock type
    [Tags]    regression    ready    TC_ITMWM_01928    WLS_Medium
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

TC_ITMWM_01929 [Single item] To verify that system return error if send picked&packed status by sending invalid stock type on picked but valid stock type on packed
    [Tags]    regression    ready    TC_ITMWM_01929    WLS_Medium
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

TC_ITMWM_01930 [Single item] To verify that system return error if send picked&packed status by sending invalid stock type on packed but valid stock type on picked
    [Tags]    regression    ready    TC_ITMWM_01930    WLS_Medium
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

TC_ITMWM_01931 [Multiple items] To verify that system can receive stock type when FMS send multipul items in picked status to PCMS.
    [Tags]    regression    ready    TC_ITMWM_01931    WLS_High
    ${set_stock_type}=    Set Variable    RT
    ${set_stock_type_item2}=    Set Variable    RD
    ${email}=    Set Variable    guest@email.com
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${order_shipment_item_id_item2}    Set Variable    ${order_shipment_data[1][0]}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    id=display_stock_type_${order_shipment_item_id}    -
    Element Should Contain    id=display_stock_type_${order_shipment_item_id_item2}    -
    Close All Browsers
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
    Close All Browsers
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    id=display_stock_type_${order_shipment_item_id}    ${set_stock_type}
    Element Should Contain    id=display_stock_type_${order_shipment_item_id_item2}    ${set_stock_type_item2}
    [Teardown]    Close All Browsers

TC_ITMWM_01932 [Multiple items] To verify that system can receive stock type when FMS send multipul items in packed status to PCMS.
    [Tags]    regression    ready    TC_ITMWM_01932    WLS_High
    ${email}=    Set Variable    guest@email.com
    ${set_stock_type}=    Set Variable    RX
    ${set_stock_type_item2}=    Set Variable    CT
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${order_shipment_item_id_item2}    Set Variable    ${order_shipment_data[1][0]}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    id=display_stock_type_${order_shipment_item_id}    -
    Element Should Contain    id=display_stock_type_${order_shipment_item_id_item2}    -
    Close All Browsers
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
    Close All Browsers
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    id=display_stock_type_${order_shipment_item_id}    ${set_stock_type}
    Element Should Contain    id=display_stock_type_${order_shipment_item_id_item2}    ${set_stock_type_item2}
    [Teardown]    Close All Browsers

TC_ITMWM_01933 [Multiple items] To verify that system can receive stock type when FMS send multipul items in picked&packed status to PCMS.
    [Tags]    regression    ready    TC_ITMWM_01933    WLS_High
    ${email}    Set Variable    guest@email.com
    ${set_stock_type}=    Set Variable    MF
    ${set_stock_type_item2}=    Set Variable    MX
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${inventory_id}    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    ${order_shipment_item_id_item2}    Set Variable    ${order_shipment_data[1][0]}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    id=display_stock_type_${order_shipment_item_id}    -
    Element Should Contain    id=display_stock_type_${order_shipment_item_id_item2}    -
    Close All Browsers
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
    Close All Browsers
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    id=display_stock_type_${order_shipment_item_id}    ${set_stock_type}
    Element Should Contain    id=display_stock_type_${order_shipment_item_id_item2}    ${set_stock_type_item2}
    [Teardown]    Close All Browsers

TC_ITMWM_01934 [Multiple items] To verify that system return error if send picked status by not sending stock type node.
    [Tags]    regression    ready    TC_ITMWM_01934    WLS_Medium
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

TC_ITMWM_01935 [Multiple items] To verify that system return error if send packed status by not sending stock type node.
    [Tags]    regression    ready    TC_ITMWM_01935    WLS_Medium
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

TC_ITMWM_01936 [Multiple items] To verify that system can receive stock type when send multipul items from FMS when FMS send picked&packed status to PCMS. (no node on pick and no value on packed)
    [Tags]    regression    ready    TC_ITMWM_01936    WLS_Medium
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

TC_ITMWM_01937 [Multiple items] To verify that system return error if send picked status by sending invalid and valid stock type.
    [Tags]    regression    ready    TC_ITMWM_01937    WLS_Medium
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

TC_ITMWM_01938 [Multiple items] To verify that system return error if send picked status by sending invalid stock type.
    [Tags]    regression    ready    TC_ITMWM_01938    WLS_Medium
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

TC_ITMWM_01939 [Multiple items] To verify that system return error if send packed status by sending invalid and valid stock type.
    [Tags]    regression    ready    TC_ITMWM_01939    WLS_Medium
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

TC_ITMWM_01940 [Multiple items] To verify that system return error if send packed status by sending invalid stock type.
    [Tags]    regression    ready    TC_ITMWM_01940    WLS_Medium
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

TC_ITMWM_01941 [Multiple items] To verify that system return error if send picked&packed status by sending valid, invalid, no node, no value stock type.
    [Tags]    regression    ready    TC_ITMWM_01941    WLS_Medium
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

TC_ITMWM_01942 [Multiple items] To verify that system return error if send picked&packed status by sending invalid stock type on all items.
    [Tags]    regression    ready    TC_ITMWM_01942    WLS_Medium
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

TC_ITMWM_01943 Verify can receive small letters and convert to capital lettes and insert to DB correctly. (rt)
    [Tags]    regression    ready    TC_ITMWM_01943    WLS_Medium
    ${set_stock_type}=    Set Variable    rt
    ${DB_stock_type}=    Set Variable    RT
    ${email}=    Set Variable    guest@email.com
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    ${order_shipment_item_id}    Set Variable    ${order_shipment_data[0][0]}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    id=display_stock_type_${order_shipment_item_id}    -
    Close All Browsers
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    ${set_stock_type}
    Send Api update status    ${body}
    ${stock_type_db}=    get stock type    ${order_shipment_item_id}
    ${log_order_db}=    get log order shipment item    ${order_shipment_item_id}
    Should Be Equal As Strings    ${stock_type_db[0][0]}    ${DB_stock_type}
    Should Be Equal As Strings    ${log_order_db[0][1]}    pending_shipment
    Should Be Equal As Strings    ${log_order_db[0][2]}    api
    Close All Browsers
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    id=display_stock_type_${order_shipment_item_id}    ${DB_stock_type}
    [Teardown]    Close All Browsers

TC_ITMWM_02008 To verify that system will display stock type as "-" after order is created.
    [Tags]    regression    TC_ITMWM_02008    ready    WLS_Medium
    ${order_id}=    Guest Buy Multiple-item Success with COD    ${email}    ${inventory_id}
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    Close All Browsers
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    id=display_stock_type_${order_shipment_data[0][0]}    -
    Element Should Contain    id=display_stock_type_${order_shipment_data[1][0]}    -
    [Teardown]    Close All Browsers

TC_ITMWM_02009 To verify that system can display stock type when send partial item with stock type.
    [Tags]    regression    TC_ITMWM_02009    ready    WLS_Medium
    ${order_id}    Create Order API - Guest buy multi product success with COD
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    id=display_stock_type_${order_shipment_data[0][0]}    -
    Element Should Contain    id=display_stock_type_${order_shipment_data[1][0]}    -
    Close All Browsers
    ${stock_type}=    Set Variable    MX
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1    ${stock_type}
    Send Api update status    ${body}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    id=display_stock_type_${order_shipment_data[0][0]}    ${stock_type}
    Element Should Contain    id=display_stock_type_${order_shipment_data[1][0]}    -
    [Teardown]    Close All Browsers

TC_1830 Verify all items display stock type properly
    ${order_id}    Create Order API - Guest buy multi product success with COD
    ${order_shipment_data}=    get order shipment item data    ${order_id}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    id=display_stock_type_${order_shipment_data[0][0]}    -
    Element Should Contain    id=display_stock_type_${order_shipment_data[1][0]}    -
    Close All Browsers
    ${stock_type_1}=    Set Variable    MX
    ${stock_type_2}=    Set Variable    MD
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    2    ${stock_type_1}
    ${body}=    Set Json Value    ${body}    /2/stock_type    "${stock_type_2}"
    ${body}=    Set Json Value    ${body}    /3/stock_type    "${stock_type_2}"
    Send Api update status    ${body}
    LOGIN PCMS
    TrackOrder - Go To Order Detail Page    ${order_id}
    Element Should Contain    id=display_stock_type_${order_shipment_data[0][0]}    ${stock_type_1}
    Element Should Contain    id=display_stock_type_${order_shipment_data[1][0]}    ${stock_type_2}
    [Teardown]    Close All Browsers
