*** Settings ***
Force Tags    WLS_PCMS_Order
Resource          ${CURDIR}/../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../Keyword/Features/Create_Order/Create_order.txt
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Track_Order/Keywords_TrackOrder.robot
Resource          ${CURDIR}/../../Keyword/API/common/api_keywords.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Product/update_stock.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Item_status/update_item_status.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../Keyword/Features/Create_Order/WebElement_order.robot
Resource          ${CURDIR}/../../Keyword/API/FMS/FMS_ORDER.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Order_together/keywords_order_together.robot
Resource          ${CURDIR}/../../Keyword/Database/PCMS/Freebie/keywords_prepare_data_checkout.robot
Resource          ${CURDIR}/../../Keyword/Features/Freebie/keywords_checkout.robot
Resource          ${CURDIR}/../../Keyword/Portal/CAMP/CAMP_Freebie/keywords_freebie.robot
Resource          ${CURDIR}/../../Keyword/Portal/CAMP/CAMP_common/Keywords_CAMP_Common.robot
Resource          ${CURDIR}/../../Keyword/Portal/AAD/AAD_common/keywords_aad.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Promotion/Keywords_Promotion.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Campaign/Keywords_Campaign.robot
Resource          ${CURDIR}/../../Keyword/Database/PCMS/Cart/keywords_cart.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Full_cart/keywords_full_cart.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Checkout_1/Keywords_Checkout1.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Checkout_2/Keywords_Checkout2.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Login/keywords_login.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Logout/keywords_logout.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Create_Order_API/Create_Order_API.robot
Resource          ${CURDIR}/../../Keyword/Portal/wemall/cart/keywords_cart.robot

*** Variable ***
${email}          guest@email.com
${material_id}    robot_material_id_123
${serial_number}    123456
${pcms_email}     admin@domain.com
${pcms_password}    12345
${serial_number}    SN12345
${username_login}    robotautomate@gmail.com
${password_login}    true1234

*** Test Cases ***
TC_ITMWM_02206 To verify that system can receive Failed delivery status on COD order and it will be changed only item that specific in json file.
    [Tags]    regression     ready    TC_ITMWM_02206    WLS_High
    ${order_id}    Create Order API - Guest buy multi product success with COD
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    order_pending
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[1][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
    ${body}=    Create Request Api update item status Failed Delivery with for Multi-item    ${order_id}    ${order_shipment_data}
    Log To Console    ${body}
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Check Item Status on UI    ${order_shipment_data[1][0]}    Cancel Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[1][0]}    cancel_pending
    #FMS# Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    #FMS# Verify item status on FMS is not cancel    ${order_shipment_data[1][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[1][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02207 [1-item][Normal product] To verify that system can receive Failed delivery status from FMS in shipped status and return success without doing any action.
    [Tags]    regression     ready    TC_ITMWM_02207    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with COD
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    order_pending
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Shipped
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    shipped
    ${body}=    Create Request Api update item status Failed Delivery with for Multi-item    ${order_id}    ${order_shipment_data}
    Log To Console    ${body}
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Shipped
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    shipped
    #FMS# Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02208 [1-item][Normal product] To verify that system can receive 'Failed delivery' status from FMS in 'cancel pending' status. And system return success and do the cancel flow.
    [Tags]    regression     ready    TC_ITMWM_02208    WLS_High
    ${order_id}    Create Order API - Guest buy single product success with COD
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    order_pending
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
    ${body}=    Create Request Api update item status Failed Delivery with for Multi-item    ${order_id}    ${order_shipment_data}
    Log To Console    ${body}
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    customer_cancelled
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    customer_cancelled
    #FMS# Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    4
    Order - Together Check Order Status In DB    ${order_id}    1
    [Teardown]    Close All Browsers

TC_ITMWM_02211 [1-item][Freebie product] To verify that system can receive 'Failed delivery' status from FMS in 'shipped' status and return success without doing any action.
    [Tags]    regression     ready    TC_ITMWM_02211    WLS_High
    Clear Cart By Customer Email    ${username_login}
    ${robot_campaign_ITMMZ_1211}    set variable    TestByThor
    Freebie Checkout - Get Product Same Collection
    Freebie Checkout - Get Free Product Status Inactive Content Draft No Collection
    Freebie Checkout - Get Main Product Same Collection A
    Freebie Checkout - Get Normal Product Same Collection B
    Freebie Checkout - Get Normal2 Product Same Collection c
    Freebie Checkout - Check Current Stock Main Product
    Freebie Checkout - Check Current Stock Free Product
    Freebie Checkout - Check Current Stock Normal Product
    Freebie Checkout - Check Current Stock Normal2 Product
    Freebie Checkout - Set Remaining Main Product    20
    Freebie Checkout - Set Remaining Free Product    20
    Freebie Checkout - Set Remaining Normal Product    20
    Freebie Checkout - Set Remaining Normal2 Product    20
    User Open Home page
    Freebie Checkout - Rebuild Stock More Than 1Variant
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_normal_same_collectionA}
    Freebie Checkout - Set Freebie On Camp    2    1
    Freebie Checkout - Add Main Product has Style 2 Qty To Cart And Success
    Full Cart - Display Normal Product First Item 2 Qty
    Full Cart - Display Free Product First Item 1 Qty
    Full Cart - Display Camp Short Description
    User Click Next Process On Full Cart
    Checkout1 - Click Have Member Radio Button
    Checkout1 - Input Email    ${username_login}
    Checkout1 - Input Password    ${password_login}
    Checkout1 - Click Next
    Checkout2 - Click Next Member
    Sleep    3s
    Checkout3 - Apply CCW    TEST    5555555555554444    111
    Checkout3 - Click Submit
    Checkout3 - Confirm CCW
    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID For Member
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    order_pending
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Shipped
    ${body}=    Create Request Api update item status Failed Delivery with for Multi-item    ${order_id}    ${order_shipment_data}
    Log To Console    ${body}
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Shipped
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    shipped
    Freebie Checkout - Restore Remaining And Promotion
    [Teardown]    Close All Browsers

TC_ITMWM_02212 [1-item][Freebie product] To verify that system can receive 'Failed delivery' status from FMS in 'cancel pending' status. And system return success and do the cancel flow.
    [Tags]    regression     ready    TC_ITMWM_02212    WLS_High
    Clear Cart By Customer Email    ${username_login}
    ${robot_campaign_ITMMZ_1211}    set variable    TestByThor
    Freebie Checkout - Get Product Same Collection
    Freebie Checkout - Get Free Product Status Inactive Content Draft No Collection
    Freebie Checkout - Get Main Product Same Collection A
    Freebie Checkout - Get Normal Product Same Collection B
    Freebie Checkout - Get Normal2 Product Same Collection c
    Freebie Checkout - Check Current Stock Main Product
    Freebie Checkout - Check Current Stock Free Product
    Freebie Checkout - Check Current Stock Normal Product
    Freebie Checkout - Check Current Stock Normal2 Product
    Freebie Checkout - Set Remaining Main Product    20
    Freebie Checkout - Set Remaining Free Product    20
    Freebie Checkout - Set Remaining Normal Product    20
    Freebie Checkout - Set Remaining Normal2 Product    20
    User Open Home page
    Freebie Checkout - Rebuild Stock More Than 1Variant
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_normal_same_collectionA}
    Freebie Checkout - Set Freebie On Camp    2    1
    Freebie Checkout - Add Main Product has Style 2 Qty To Cart And Success
    Full Cart - Display Normal Product First Item 2 Qty
    Full Cart - Display Free Product First Item 1 Qty
    Full Cart - Display Camp Short Description
    User Click Next Process On Full Cart
    Checkout1 - Click Have Member Radio Button
    Checkout1 - Input Email    ${username_login}
    Checkout1 - Input Password    ${password_login}
    Checkout1 - Click Next
    Checkout2 - Click Next Member
    Sleep    3s
    Checkout3 - Apply CCW    TEST    5555555555554444    111
    Checkout3 - Click Submit
    Checkout3 - Confirm CCW
    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID For Member
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    order_pending
    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${order_shipment_data[0][0]}
    TrackOrder - Check Available Item Status on UI    ${order_shipment_data[0][0]}    ${ui_item_status}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    pending_shipment
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    shipped
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
    ${body}=    Create Request Api update item status Failed Delivery with for Multi-item    ${order_id}    ${order_shipment_data}
    Log To Console    ${body}
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Customer Cancelled
    TrackOrder - Verify Log OrderShipment by Api    ${order_shipment_data[0][0]}    customer_cancelled
    #FMS# Verify item status on FMS    ${order_shipment_data[0][0]}    cancelled
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Freebie Checkout - Restore Remaining And Promotion
    [Teardown]    Close All Browsers

TC_ITMWM_02217 [1-item] To verify that system will return error if get 'Failed delivery' status when item status is not 'shipped' or 'cancel pending'. System return error without doing any action.
    [Tags]    regression     ready    TC_ITMWM_02217    WLS_High
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    order_pending
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    order_pending    ${pcms_email}
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[0][0]}    permanent
    # Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    ${body}=    Create Request Api update item status Failed Delivery with for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    1
    ${response}=    Send Api update status fail    ${body}    401
    Variable Should Exist    ${response['data']['incorrect_status']}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Order Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    order_pending
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    order_pending    ${pcms_email}
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[0][0]}    permanent
    # Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    Open PCMS And Sync Order Together
    Order - Together Check Item Status In DB    ${order_id}    ${order_shipment_data[0][0]}    None
    Order - Together Check Order Status In DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_02218 [multi-items][Normal & Wow] To verify that system can receive 'Failed delivery' status from FMS in 'shipped' status and return success without doing any action.
    [Tags]    regression     ready    TC_ITMWM_02218    WLS_High
    ${order_id}=    Guest Buy Product WOW & Product Normal Success with CCW    ${email}    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    2
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    2
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Shipped
    \    TrackOrder - Check Item Status on DB    ${item[0]}    shipped
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Check Payment Status on UI    ${item[0]}    Success
    \    TrackOrder - Verify Log OrderShipment by Api    ${item[0]}    shipped
    \    Verify status in stock hold table    ${item[0]}    cutstock
    # \    Verify item status on FMS is not cancel    ${item[0]}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    ${body}=    Create Request Api update item status Failed Delivery with for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    2
    ${response}=    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Shipped
    \    TrackOrder - Check Item Status on DB    ${item[0]}    shipped
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Check Payment Status on UI    ${item[0]}    Success
    \    TrackOrder - Verify Log OrderShipment by Api    ${item[0]}    shipped
    \    Verify status in stock hold table    ${item[0]}    cutstock
    # \    Verify item status on FMS is not cancel    ${item[0]}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02219 [multi-items][Normal & Wow] To verify that system can receive 'Failed delivery' status from FMS in 'cancel pending' status. And system return success and do the cancel flow.
    [Tags]    regression     ready    TC_ITMWM_02219    WLS_High
    ${order_id}=    Guest Buy Product WOW & Product Normal Success with CCW    ${email}    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    2
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    2
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Set Item status    ${order_shipment_data[1][0]}    cancel_pending
    TrackOrder - Click save all
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Cancel Pending
    \    TrackOrder - Check Item Status on DB    ${item[0]}    cancel_pending
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Check Payment Status on UI    ${item[0]}    Success
    \    TrackOrder - Verify Log OrderShipment by User    ${item[0]}    cancel_pending    ${pcms_email}
    \    Verify status in stock hold table    ${item[0]}    cutstock
    # \    Verify item status on FMS is not cancel    ${item[0]}
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    ${body}=    Create Request Api update item status Failed Delivery with for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    2
    Send Api update status    ${body}
    TrackOrder - Go To Order Detail Page    ${order_id}
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Customer Cancelled
    \    TrackOrder - Check Item Status on DB    ${item[0]}    customer_cancelled
    \    TrackOrder - Check Payment Status on UI    ${item[0]}    Success
    \    TrackOrder - Verify Log OrderShipment by Api    ${item[0]}    customer_cancelled
    \    Verify status in stock hold table    ${item[0]}    cutstock
    \    # \    Verify item status on FMS    ${item[0]}    cancelled
    \    TrackOrder - Check Operation Status on UI    ${item[0]}    Refund Request
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02224 [multi-items] To verify that system will return error if get 'Failed delivery' status when item status is not 'shipped' or 'cancel pending'. System return error without doing any action.
    [Tags]    regression     ready    TC_ITMWM_02224    WLS_High
    ${order_id}=    Create Order API - Guest buy multi product success with CCW    ${default_inventoryID}    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Order Pending
    \    TrackOrder - Check Item Status on DB    ${item[0]}    order_pending
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Check Payment Status on UI    ${item[0]}    Success
    \    TrackOrder - Verify Log OrderShipment by User    ${item[0]}    order_pending    ${pcms_email}
    \    Verify status in stock hold table    ${item[0]}    permanent
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    ${body}=    Create Request Api update item status Failed Delivery with for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    2
    ${response}=    Send Api update status fail    ${body}    401
    Variable Should Exist    ${response['data']['incorrect_status']}
    TrackOrder - Go To Order Detail Page    ${order_id}
    : FOR    ${item}    IN    @{order_shipment_data}
    \    TrackOrder - Check Item Status on UI    ${item[0]}    Order Pending
    \    TrackOrder - Check Item Status on DB    ${item[0]}    order_pending
    \    ${ui_item_status}=    TrackerOrder - Get Available Item Status List    ${item[0]}
    \    TrackOrder - Check Available Item Status on UI    ${item[0]}    ${ui_item_status}
    \    TrackOrder - Check Payment Status on UI    ${item[0]}    Success
    \    TrackOrder - Verify Log OrderShipment by User    ${item[0]}    order_pending    ${pcms_email}
    \    Verify status in stock hold table    ${item[0]}    permanent
    Open PCMS And Sync Order Together
    Order - Together Check Order Status In DB    ${order_id}    0
    : FOR    ${item}    IN    @{order_shipment_data}
    \    Order - Together Check Item Status In DB    ${order_id}    ${item[0]}    None
    [Teardown]    Close All Browsers

TC_ITMWM_02225 To verify that system return error if send api update status to failed delivery by sending without item shipment id
    [Tags]    regression     ready    TC_ITMWM_02225    WLS_Medium
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    1
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    cancel_pending    ${pcms_email}
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    # Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    ${body}=    Create Request Api update item status Failed Delivery with for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    1
    ${body}=    Set Json Value    ${body}    /0/order_shipment_item_id    "${EMPTY}"
    ${response}=    Send Api update status fail    ${body}    400
    Variable Should Exist    ${response['data']['order_item_id_not_found']}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    cancel_pending    ${pcms_email}
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    # Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    [Teardown]    Close All Browsers

TC_ITMWM_02226 To verify that system return error if send api update status to failed delivery by sending without order id
    [Tags]    regression     ready    TC_ITMWM_02226    WLS_Medium
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    1
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    cancel_pending    ${pcms_email}
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    # Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    ${body}=    Create Request Api update item status Failed Delivery with for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    1
    ${body}=    Set Json Value    ${body}    /0/order_id    "${EMPTY}"
    ${response}=    Send Api update status fail    ${body}    400
    Variable Should Exist    ${response['data']['order_item_id_not_found']}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    cancel_pending    ${pcms_email}
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    # Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    [Teardown]    Close All Browsers

TC_ITMWM_02227 To verify that system return error if send api update status with incorrect status
    [Tags]    regression     ready    TC_ITMWM_02227    WLS_Medium
    ${order_id}=    Create Order API - Guest buy single product success with CCW    ${default_inventoryID}
    Close All Browsers
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${order_id}    ${order_shipment_data}    1
    Send Api update status    ${body}
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    1
    Send Api update status    ${body}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Click save    ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    cancel_pending    ${pcms_email}
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    # Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    ${body}=    Create Request Api update item status Failed Delivery with for Multi-item    ${order_id}    ${order_shipment_data}    ${serial_number}    1
    ${body}=    Set Json Value    ${body}    /0/item_status    "incorrect_status"
    ${response}=    Send Api update status fail    ${body}    401
    Variable Should Exist    ${response['data']['incorrect_status']}
    TrackOrder - Go To Order Detail Page    ${order_id}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    Cancel Pending
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    cancel_pending
    TrackOrder - Verify Log OrderShipment by User    ${order_shipment_data[0][0]}    cancel_pending    ${pcms_email}
    TrackOrder - Check Payment Status on UI    ${order_shipment_data[0][0]}    Success
    Verify status in stock hold table    ${order_shipment_data[0][0]}    cutstock
    # Verify item status on FMS is not cancel    ${order_shipment_data[0][0]}
    [Teardown]    Close All Browsers
