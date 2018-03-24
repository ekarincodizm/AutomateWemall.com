*** Settings ***
Force Tags    WLS_Bill_Cancelled
Library         Selenium2Library
Library         Collections
Library         String
Library         HttpLibrary.HTTP

Resource          ${CURDIR}/../../../Resource/Config/${ENV}/database.robot
Resource          ${CURDIR}/../../../Resource/Config/${ENV}/test_data/return_refund_config.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Track_order/Keywords_TrackOrder.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Track_order/WebElement_TrackOrder.robot
Resource          ${CURDIR}/../../../Keyword/Features/Create_Order/Create_order.txt
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Orders/Keywords_upload_operation_status.robot


#Freebie
Resource          ${CURDIR}/../../../Keyword/Features/Freebie/keywords_checkout.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Freebie/keywords_prepare_data_checkout.robot
Resource          ${CURDIR}/../../../Keyword/Portal/CAMP/CAMP_Freebie/keywords_freebie.robot
Resource          ${CURDIR}/../../../Keyword/Portal/AAD/AAD_common_keyword/Keywords_AAD_Common.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Orders/keywords_orders.robot

*** Variable ***
${pcms_email}     admin@domain.com
${pcms_pass}     12345

${pcms_callcenter}     callcenter-robot
${pcms_callcenter_email}     callcenter@robot-test.com
${pcms_callcenter_password}     12345

${pcms_scm}     scm-robot
${pcms_scm_email}     scm@robot-test.com
${pcms_scm_password}     12345

${role_fulfillment}    Fulfillment
${role_callcenter}    CallCenter

${guest_email}      guest@robot.ascend.co.th


# ${tc1_order_id}         3011863
# ${tc2_order_id}         20001064
# ${tc3_order_id}         20001064
# ${tc4_order_id}         20001064
# ${tc5_order_id}         32245
# ${tc6_order_id}         20001229
# ${tc7_order_id}         20001247
# ${tc7_inventory_id}     FUAAA1124111
# ${tc8_order_id}         20001635
# ${tc9_order_id}         20001637
# ${tc10_order_id}         3012652




*** Keywords ***
Change Order Payment Method to be Wallet
    [Arguments]     ${order_id}
    Connect DB ITM
    Execute Sql String    UPDATE orders SET payment_method = 11 , payment_channel = 'online' , payment_status = 'success' WHERE id = "${order_id}"

Change Order Payment Method to be COD
    [Arguments]     ${order_id}
    Connect DB ITM
    Execute Sql String    UPDATE orders SET payment_method = 7 , payment_channel = 'offline' , payment_status = 'waiting' , payment_source = 'wetrust' WHERE id = "${order_id}"

Change Order Payment Method to be CS
    [Arguments]     ${order_id}
    Connect DB ITM
    Execute Sql String    UPDATE orders SET payment_method = 8 , payment_channel = 'offline' , payment_status = 'success' WHERE id = "${order_id}"


Rollback Order Status
    [Arguments]     ${order_id}
    Connect DB ITM
    Execute Sql String      UPDATE orders SET order_status = 'new' WHERE id = "${order_id}"
    Execute Sql String      UPDATE order_shipment_items SET payment_status = 'success' , item_status = 'order_pending' , operation_status = 'none' , cancel_reason_id = NULL WHERE order_id = "${order_id}"

Rollback Order Status For COD
    [Arguments]     ${order_id}
    Connect DB ITM
    Execute Sql String      UPDATE orders SET order_status = 'draft' WHERE id = "${order_id}"
    Execute Sql String      UPDATE order_shipment_items SET payment_status = 'payment_pending' , item_status = 'order_pending' , operation_status = 'none' , cancel_reason_id = NULL WHERE order_id = "${order_id}"

Query Freebie Item From Order
    [Arguments]     ${order_id}
    Connect DB ITM
    ${order_shipment_item_id}=    Query    SELECT id FROM order_shipment_items WHERE order_id = '${order_id}' AND camp_type = 'freebie' AND camp_id IS NOT NULL LIMIT 0 , 1
    Disconnect From Database
    Return From Keyword    ${order_shipment_item_id[0][0]}

Query Bundle Device Item From Order
    [Arguments]     ${order_id}
    Connect DB ITM
    ${order_shipment_item_id}=    Query    SELECT id FROM order_shipment_items WHERE order_id = '${order_id}' AND Bundle = 'Y' ORDER BY total_price DESC LIMIT 0 , 1
    Disconnect From Database
    Return From Keyword    ${order_shipment_item_id[0][0]}

Query Bundle Sim Item From Order
    [Arguments]     ${order_id}
    Connect DB ITM
    ${order_shipment_item_id}=    Query    SELECT id FROM order_shipment_items WHERE order_id = '${order_id}' AND Bundle = 'Y' ORDER BY total_price ASC LIMIT 0 , 1
    Disconnect From Database
    Return From Keyword    ${order_shipment_item_id[0][0]}

Query Order
    [Arguments]     ${scope}=200
    Connect DB ITM
    ${number}=                Evaluate    random.randint(1, ${scope})    modules=random
    ${orders}=        Query           SELECT id FROM orders WHERE payment_status = 'success' AND payment_method = 1
    [Return]    ${orders[${number}][0]}


Query Freebie Order
    [Arguments]     ${scope}=5
    Connect DB ITM
    ${number}=                Evaluate    random.randint(1, ${scope})    modules=random
    ${orders}=        Query           SELECT id FROM orders WHERE payment_status = 'success' AND payment_method = 1 AND id IN ( SELECT order_id FROM order_shipment_items WHERE camp_id IS NOT NULL AND camp_type = 'freebie' )
    [Return]    ${orders[${number}][0]}


# Random One Inventory ID
#     [Arguments]     ${scope}=20
#     Connect DB ITM
#     ${number}=                Evaluate    random.randint(1, ${scope})    modules=random
#     ${inv_id}=    query    SELECT variants.inventory_id FROM variants, products, imported_materials, (SELECT product_style_type.product_id, sum(product_style_type.style_type_id) number FROM product_style_type GROUP BY product_style_type.product_id) style WHERE `products`.`id` = `variants`.`product_id` AND variants.deleted_at is null AND variants.status = 'active' AND variants.stock_type = 1 AND products.status = 'publish' AND products.active = 1 AND products.has_variants = 1 AND products.deleted_at is null AND style.product_id = products.id AND style.number = 1 AND variants.inventory_id = imported_materials.inventory_id ORDER BY products.id, variants.id desc
#     [Return]    ${inv_id[${number}][0]}


PCMS UI Order Page - Set All Item Status until to Return Received
    [Arguments]     ${order_shipment_item_id}
    TrackOrder - Set Item status    ${order_shipment_item_id}    ${item_status_db_pending_shipment}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${order_shipment_item_id}    ${item_status_db_shipped}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${order_shipment_item_id}    ${item_status_db_delivered}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${order_shipment_item_id}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${order_shipment_item_id}    5
    TrackOrder - Set Operation Status    ${order_shipment_item_id}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    TrackOrder - Set Item status    ${order_shipment_item_id}    ${item_status_db_return_received}
    TrackOrder - Click save all
    Sleep   3s
    TrackOrder - Check Item Status on DB       ${order_shipment_item_id}      ${item_status_db_return_received}

PCMS UI Order Page - Bundle Set All Item Status until to Return Received
    [Arguments]     ${order_shipment_item_id}
    TrackOrder - Set Item status    ${order_shipment_item_id}    ${item_status_db_pending_shipment}
    TrackOrder - Click save all
    Confirm Action
    TrackOrder - Set Item status    ${order_shipment_item_id}    ${item_status_db_shipped}
    TrackOrder - Click save all
    Confirm Action
    TrackOrder - Set Item status    ${order_shipment_item_id}    ${item_status_db_delivered}
    TrackOrder - Click save all
    Confirm Action
    TrackOrder - Set Item status    ${order_shipment_item_id}    ${item_status_db_customer_cancelled}
    TrackOrder - Set Cancel Reason    ${order_shipment_item_id}    5
    TrackOrder - Set Operation Status    ${order_shipment_item_id}    ${operation_db_return_refund_request}
    TrackOrder - Click save all
    Confirm Action
    TrackOrder - Set Item status    ${order_shipment_item_id}    ${item_status_db_return_received}
    TrackOrder - Click save all
    Confirm Action
    Sleep   3s
    TrackOrder - Check Item Status on DB       ${order_shipment_item_id}      ${item_status_db_return_received}

PCMS UI Order Page - Set All Item Status until to Return Completed
    [Arguments]     ${order_shipment_item_id}
    PCMS UI Order Page - Set All Item Status until to Return Received       ${order_shipment_item_id}
    TrackOrder - Set Item status    ${order_shipment_item_id}    ${item_status_db_return_completed}
    TrackOrder - Click save all


*** Test Cases ***


TC_ITMWM_04032 [CCW - Bundle - Save] To verify that if only device of bundle is cancelled (after delivered), operation status 'Refund Request' is displayed as text.
#    Comment    Tag Duplicate
#    [Tags]    TC_ITMWM_04032    TC_ITMWM_04033    ITMA-3221    itm-a-sprint 2016s15    regression    ready
    [Tags]    TC_ITMWM_04032    regression    WLS_Low    itm-a-sprint 2016s15    ready

    # Order - Get Random Bundle Order With Payment Status Success

#### Prerequisite
# 1. Buy the bundle item successfully via CCW
# 2. Change the items status of bundle from 'Order Pending' to 'Pending Shipment'
# 3. Change the items status of bundle from 'Pending Shipment' to 'Shipped'
# 4. Change the items status of bundle from 'Shipped' to 'Delivered'
# 5. Change the items status of Mobile (bundle) from 'Delivered' to 'Customer Cancelled', Choose 'Cancel Reason' and Operation status = 'Return Refund Request'
# 6. Change the items status of bundle from 'Return Pending' to 'Return Received'"

    # ${tc1_order_id}=    Guest Buy Product Success with CS    ${guest_email}    ${default_inventoryID}
    Log To Console      ${tc1_order_id}
    Rollback Order Status    ${tc1_order_id}
    Login Pcms

    # http://alpha-pcms.itruemart-dev.com/truemoveh/verify?pcms_order_id=3011863

    TrackOrder - Go To Order Detail Page    ${tc1_order_id}
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${tc1_order_id}
    PCMS UI Order Page - Set All Item Status until to Return Received           ${order_shipment_data[0][0]}
    Close All Browsers


#### Test Steps
# 1. Login PCMS by SCM role
# 2. Go to PCMS > Order -> Track Orders
# 3. Go to shipment detail
# 4. Change one item status of bundle (mobile) from 'Return Received' to 'Return Completed'
    Login Pcms      ${pcms_scm_email}    ${pcms_scm_password}
    TrackOrder - Go To Order Detail Page    ${tc1_order_id}
    ${bundle_item_id}=      Query Bundle Device Item From Order         ${tc1_order_id}
    TrackOrder - Set Item status    ${bundle_item_id}    ${item_status_db_return_completed}
    TrackOrder - Click Save         ${bundle_item_id}
    Confirm Action
    Sleep   3s

#### TestSteps
#4. The selected item -> Item status is 'Return complete' and Operation status is 'Refund Request'.  "
    TrackOrder - Check Item Status on UI       ${bundle_item_id}      ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB       ${bundle_item_id}      ${item_status_db_return_completed}
    TrackOrder - Check Operation Status on UI       ${bundle_item_id}      ${operation_ui_return_refund_request}
    TrackOrder - Check Operation Status on DB       ${bundle_item_id}      ${operation_db_return_refund_request}
    Element Should Not Be Visible     //*[@id="status_operation_${bundle_item_id}"]

    ${bundle_sim_item_id}=      Query Bundle Sim Item From Order         ${tc1_order_id}
    Log to Console    ${bundle_sim_item_id}
    TrackOrder - Set Item Status    ${bundle_sim_item_id}    ${item_status_db_return_received}
    TrackOrder - Click save All
    TrackOrder - Set Item status    ${bundle_sim_item_id}    ${item_status_db_return_completed}
    # TrackOrder - Set Operation Status    ${order_shipment_item_id}    ${operation_db_pending_tmn}
    TrackOrder - Click save all
    Sleep   3s
#### Expected
# "5. Item status =  'Return complete'  /
# Operation status = Refund Request (default in dropdown) with Pending TMN shown in the dropdown list
    TrackOrder - Check Item Status on UI    ${bundle_item_id}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${bundle_item_id}    ${item_status_db_return_completed}
    TrackOrder - Check Operation Status on UI       ${bundle_item_id}      ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB       ${bundle_item_id}      ${operation_db_refund_request}
    Wait Until Page Contains Element     //*[@id="status_operation_${bundle_item_id}"]/option[@value="pending_tmn"]

    TrackOrder - Check Item Status on UI    ${bundle_sim_item_id}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${bundle_sim_item_id}    ${item_status_db_return_completed}
    TrackOrder - Check Operation Status on UI       ${bundle_sim_item_id}      ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB       ${bundle_sim_item_id}      ${operation_db_refund_request}
    Wait Until Page Contains Element     //*[@id="status_operation_${bundle_sim_item_id}"]/option[@value="pending_tmn"]


    TrackOrder - Set Operation Status    ${bundle_sim_item_id}    ${operation_db_pending_tmn}
    TrackOrder - Click save All
    Sleep   3s
    TrackOrder - Check Operation Status on UI       ${bundle_sim_item_id}      ${operation_ui_pending_tmn}
    TrackOrder - Check Operation Status on DB       ${bundle_sim_item_id}      ${operation_db_pending_tmn}
    #[Teardown]    Close All Browsers

# TC2 - [CCW - Bundle - Save All] To verify that if both items of bundle are Return Completed (Customer cancelled after delivered), the operation status will show drop-down lists and can change from 'Refund Request' to 'Pending TMN'
#     [Tags]  TC2

# #### Prerequisite
# # 1. Buy the bundle item successfully via CCW
# # 2. Change the items status of bundle from 'Order Pending' to 'Pending Shipment'
# # 3. Change the items status of bundle from 'Pending Shipment' to 'Shipped'
# # 4. Change the items status of bundle from 'Shipped' to 'Delivered'
# # 5. Change the items status of bundle from 'Delivered' to 'Customer Cancelled', Choose 'Cancel Reason' and Operation status = 'Return Refund Request'
# # 6. Change the items status of bundle from 'Return Pending' to 'Return Received'

#     # ${tc2_order_id}=    Guest Buy Product Success with CS    ${guest_email}    ${default_inventoryID}
#     Log To Console      ${tc2_order_id}
#     Login Pcms
#     TrackOrder - Go To Order Detail Page    ${tc2_order_id}
#     ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${tc2_order_id}
#     PCMS UI Order Page - Set All Item Status until to Return Received           ${order_shipment_data[0][0]}
#     Close All Browsers


# #### Test Steps
# # 1. Login by SCM role
# # 2. Go to PCMS > Order -> Track Orders
# # 3. Go to shipment detail
# # 4. Change the items status of bundle from 'Return Received' to 'Return Completed'
# # 5. Click 'Save All'
# # 6. Change operation status (4) from 'Refund Request' to 'Pending TMN'
# # 7. Click 'Save All'
# # 8. Go to PCMS > Order and select Operation Status = Pending TMN and then click Search

#     Login Pcms      ${pcms_scm_email}    ${pcms_scm_password}
#     TrackOrder - Go To Order Detail Page    ${tc2_order_id}
#     ${bundle_sim_item_id}=      Query Bundle Sim Item From Order         ${tc2_order_id}
#     PCMS UI Order Page - Set All Item Status until to Return Completed           ${bundle_sim_item_id}

# #### Expected
# # "5. Item status =  'Return complete'  /
# # Operation status = Refund Request (default in dropdown) with Pending TMN shown in the dropdown list
#     TrackOrder - Check Item Status on UI    ${bundle_sim_item_id}    ${item_status_ui_return_completed}
#     TrackOrder - Check Item Status on DB    ${bundle_sim_item_id}    ${item_status_db_return_completed}
#     TrackOrder - Check Operation Status on UI       ${bundle_sim_item_id}      ${operation_ui_refund_request}
#     TrackOrder - Check Operation Status on DB       ${bundle_sim_item_id}      ${operation_db_refund_request}
#     Element Should Be Visible     //*[@id="status_operation_${bundle_sim_item_id}"]/option[value="pending_tmn"]


#     TrackOrder - Set Operation Status    ${bundle_sim_item_id}    ${operation_db_pending_tmn}
#     TrackOrder - Click save All

# #### Expected
# # 7.1 Pending TMN is saved.
# # 7.2 Can see history in 'view last update' to see who changed to Pending TMN and when
# # 8. Search results and Export excel to see that order ID"

#     TrackOrder - Check Operation Status on UI       ${bundle_sim_item_id}      ${operation_ui_pending_tmn}
#     TrackOrder - Check Operation Status on DB       ${bundle_sim_item_id}      ${operation_db_pending_tmn}
#     TrackOrder - Verify View Last Update Button for Operation Status is Visible       ${bundle_sim_item_id}

#     Order - Go to Order Page
    #??????????????

#=====================================================================


TC_ITMWM_04034 [Installment - Normal - Save All] To verify that if FMS send item status to change from Return Received to Return Completed (Customer cancelled after delivered), The operation station will show drop-down lists and can selectable from Refund Request to Pending TMN
    [Tags]  TC_ITMWM_04034    regression    WLS_High    ITMA-3221    itm-a-sprint 2016s15    ready

#### Prerequisite
# 1. Buy multiple item [MNP Device + Normal] successfully via Installment
# 2. Change the items status from 'Order Pending' to 'Pending Shipment'
# 3. Change the items status from 'Pending Shipment' to 'Shipped'
# 4. Change the items status from 'Shipped' to 'Delivered'
# 5. Change the items status from 'Delivered' to 'Customer Cancelled', Choose 'Cancel Reason' and Operation status = 'Return Refund Request'
# 6. Change the items status from 'Return Pending' to 'Return Received'

    ${tc3_order_id}=    Create Order - Guest buy single product success with Installment Kbank    ${default_inventoryID}   ${guest_email}
    Log To Console      ${tc3_order_id}
    Login Pcms
    TrackOrder - Go To Order Detail Page    ${tc3_order_id}
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${tc3_order_id}
    PCMS UI Order Page - Set All Item Status until to Return Received           ${order_shipment_data[0][0]}
    Sleep   3s
    Close All Browsers

#### Test Steps
# 1. Login by SCM role
# 2. Go to PCMS > Order -> Track Orders
# 3. Go to shipment detail
# 4. FMS sends items status to PCMS = 'Return Completed' by Postman
# 5. From PCMS UI, change operation status (4) from 'Refund Request' to 'Pending TMN'
# 6. Click 'Save All'

    # ${body}=    Create Request Api update item status Return Completed with for Multi-item    ${tc3_order_id}    ${order_shipment_data}
    # Send Api update status    ${body}

    Login Pcms      ${pcms_scm_email}    ${pcms_scm_password}
    TrackOrder - Go To Order Detail Page    ${tc3_order_id}
    # TrackOrder - Set Item status    ${order_shipment_data[0][0]}    ${item_status_db_return_received}
    # TrackOrder - Click save all
    TrackOrder - Set Item status    ${order_shipment_data[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Click save all

#### Expected
# 4. Item status =  'Return complete'  /
# Operation status = Refund Request (default in dropdown) with Pending TMN shown in the dropdown list
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Operation Status on UI       ${order_shipment_data[0][0]}      ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB       ${order_shipment_data[0][0]}      ${operation_db_refund_request}
    Element Should Be Visible     //*[@id="status_operation_${order_shipment_data[0][0]}"]/option[@value="pending_tmn"]

    TrackOrder - Set Operation Status    ${order_shipment_data[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save All
#### Expected
# 6.1 Pending TMN is saved. /  Item status =  'Return complete'
# 6.2 Can see history in 'view last update' to see who changed to Pending TMN and when

    TrackOrder - Check Operation Status on UI       ${order_shipment_data[0][0]}      ${operation_ui_pending_tmn}
    TrackOrder - Check Operation Status on DB       ${order_shipment_data[0][0]}      ${operation_db_pending_tmn}
    TrackOrder - Verify View Last Update Button for Operation Status is Visible       ${order_shipment_data[0][0]}

    [Teardown]    Close All Browsers

#===========================================

TC_ITMWM_04035 COD - Freebie + Normal - Save All To verify that if items status is Return Completed (Customer cancelled after delivered), the operation status will show drop-down lists and can change from Refund Request to CLT Doc Uploaded
    [Tags]  TC_ITMWM_04035    regression    WLS_High    ITMA-3221    itm-a-sprint 2016s15    ready


    ${tc4_order_id}=    Query Freebie Order
    Rollback Order Status For COD             ${tc4_order_id}
    Change Order Payment Method to be COD        ${tc4_order_id}
    Log to Console      ${tc4_order_id}

#### Prerequisite
# 1. Buy multiple item [Freebie + Normal] successfully via Wallet
# 2. Change the items status from 'Order Pending' to 'Pending Shipment'
# 3. Change the items status from 'Pending Shipment' to 'Shipped'
# 4. Change the items status from 'Shipped' to 'Delivered'
# 5. Change the items status of main product (freebie) from 'Delivered' to 'Customer Cancelled', Choose 'Cancel Reason' and Operation status = 'Return Refund Request'
# 6. Change the items status from 'Return Pending' to 'Return Received'"

    Login Pcms
    TrackOrder - Go To Order Detail Page    ${tc4_order_id}
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${tc4_order_id}
    ${freebie_item_id}=      Query Freebie Item From Order         ${tc4_order_id}
    PCMS UI Order Page - Set All Item Status until to Return Received           ${freebie_item_id}
    Sleep   3s
    Close All Browsers

# #### Test Step
# # 1. Login by CLT role
# # 2. Go to PCMS > Order -> Track Orders
# # 3. Go to shipment detail
# # 4. Change the items status of main product (freebie) from 'Return Received' to 'Return Completed' -> Click Save All
# # 5. Change operation status (4) from 'Refund Request' to 'CLT Doc Uploaded'
# # 6. Click 'Save'

    Login Pcms      ${pcms_callcenter_email}    ${pcms_callcenter_password}
    TrackOrder - Go To Order Detail Page    ${tc4_order_id}
    # TrackOrder - Set Item status    ${freebie_item_id}    ${item_status_db_return_received}
    # TrackOrder - Click save all
    TrackOrder - Set Item status    ${freebie_item_id}    ${item_status_db_return_completed}
    TrackOrder - Click save all
#### Expects
# 4. Item status =  'Return complete'  /  Operation status = Refund Request (default in dropdown) with CLT Doc Uploaded shown in the dropdown list
    TrackOrder - Check Item Status on UI    ${freebie_item_id}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${freebie_item_id}    ${item_status_db_return_completed}
    TrackOrder - Check Operation Status on UI       ${freebie_item_id}      ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB       ${freebie_item_id}      ${operation_db_refund_request}

    TrackOrder - Set Operation Status    ${freebie_item_id}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save         ${freebie_item_id}
# #### Expects
# # 6.1 CLT Doc Uploaded is saved. /  Item status =  'Return complete'
# # 6.2 Can see history in 'view last update' to see who changed to CLT Doc Uploaded and when
    TrackOrder - Check Item Status on UI    ${freebie_item_id}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${freebie_item_id}    ${item_status_db_return_completed}
    TrackOrder - Check Operation Status on UI       ${freebie_item_id}      ${operation_ui_clt_doc_uploaded}
    TrackOrder - Check Operation Status on DB       ${freebie_item_id}      ${operation_db_clt_doc_uploaded}
    TrackOrder - Verify View Last Update Button for Operation Status is Visible       ${freebie_item_id}


    [Teardown]    Run Keywords    Rollback Order Status For COD             ${tc4_order_id}
    ...    AND    Close All Browsers

#==================================


TC_ITMWM_04036 CS - Normal + Normal - Save All To verify that the operation station will show drop-down lists and can selectable from Refund Request to Pending TMN after getting request from FMS to change item status from Return Received to Return Completed (Customer cancelled after delivered),
    [Tags]  TC_ITMWM_04036    regression    WLS_High    ITMA-3221    itm-a-sprint 2016s15    ready
    # ${tc5_order_id}=    Query Order
    Rollback Order Status            ${tc5_order_id}
    Change Order Payment Method to be CS        ${tc5_order_id}
    Log To Console      ${tc5_order_id}

#### Prerequisite
# 1. Buy multiple item [Normal + Normal] successfully via CS
# 2. Change the items status from 'Order Pending' to 'Pending Shipment'
# 3. Change the items status from 'Pending Shipment' to 'Shipped'
# 4. Change the items status from 'Shipped' to 'Delivered'
# 5. Change the item status of both items from 'Delivered' to 'Customer Cancelled', Choose 'Cancel Reason' and Operation status = 'Return Refund Request'
# 6. Change the items status from 'Return Pending' to 'Return Received'"

    Login Pcms
    TrackOrder - Go To Order Detail Page    ${tc5_order_id}
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${tc5_order_id}
    PCMS UI Order Page - Set All Item Status until to Return Received           ${order_shipment_data[0][0]}
    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    ${item_status_ui_return_received}
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    ${item_status_db_return_received}
    Close All Browsers

# #### Test Step
# 1. Login by CLT role
# 2. Go to PCMS > Order -> Track Orders
# 3. Go to shipment detail
# 4. FMS send items status 'Return Completed' by Postman


    ${body}=    Create Request Api update item status Return Completed with for Multi-item    ${tc5_order_id}    ${order_shipment_data}
    Send Api update status    ${body}
    Login Pcms      ${pcms_callcenter_email}    ${pcms_callcenter_password}
    TrackOrder - Go To Order Detail Page    ${tc5_order_id}
    # TrackOrder - Set Item status    ${order_shipment_data[0][0]}    ${item_status_db_return_completed}
    # TrackOrder - Click save all

    Login Pcms      ${pcms_callcenter_email}    ${pcms_callcenter_password}
    TrackOrder - Go To Order Detail Page    ${tc5_order_id}


# #### Expects
# 4. Item status =  'Return complete'  /  Operation status = Refund Request (default in dropdown) with CLT Doc Uploaded shown in the dropdown list

    TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    ${item_status_db_return_completed}
    TrackOrder - Check Operation Status on UI       ${order_shipment_data[0][0]}      ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB       ${order_shipment_data[0][0]}      ${operation_db_refund_request}

# #### Test Step
# 5. Change operation status (4) from 'Refund Request' to 'CLT Doc Uploaded'
# 6. Click 'Save All'
    TrackOrder - Set Operation Status    ${order_shipment_data[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save all

# #### Expects
# 6.1 CLT Doc Uploaded is saved. /  Item status =  'Return complete'
# 6.2 Can see history in 'view last update' to see who changed to CLT Doc Uploaded and when
    TrackOrder - Check Operation Status on UI       ${order_shipment_data[0][0]}      ${operation_ui_clt_doc_uploaded}
    TrackOrder - Check Operation Status on DB       ${order_shipment_data[0][0]}      ${operation_db_clt_doc_uploaded}
    TrackOrder - Verify View Last Update Button for Operation Status is Visible       ${order_shipment_data[0][0]}

#===================================


TC_ITMWM_04037 Wallet - Freebie + Normal - Save To verify that if items status are Return Completed (Customer cancelled after delivered), the operation status will show as drop-down lists and can change from 'Refund Request' to 'CLT Doc Uploaded'
    [Tags]  TC_ITMWM_04037    regression    WLS_Medium   ITMA-3221    itm-a-sprint 2016s15    ready

    ${tc6_order_id}=    Query Freebie Order
    Rollback Order Status             ${tc6_order_id}
    Change Order Payment Method to be Wallet        ${tc6_order_id}
    Log to Console      ${tc6_order_id}

#### Prerequisite
# 1. Buy multiple item [Freebie + Normal] successfully via Wallet
# 2. Change the items status from 'Order Pending' to 'Pending Shipment'
# 3. Change the items status from 'Pending Shipment' to 'Shipped'
# 4. Change the items status from 'Shipped' to 'Delivered'
# 5. Change the items status of main product (freebie) from 'Delivered' to 'Customer Cancelled', Choose 'Cancel Reason' and Operation status = 'Return Refund Request'
# 6. Change the items status from 'Return Pending' to 'Return Received'"

    Login Pcms
    TrackOrder - Go To Order Detail Page    ${tc6_order_id}
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${tc6_order_id}
    ${freebie_item_id}=      Query Freebie Item From Order         ${tc6_order_id}
    PCMS UI Order Page - Set All Item Status until to Return Received           ${freebie_item_id}
    Sleep   3s
    Close All Browsers

# #### Test Step
# # 1. Login by CLT role
# # 2. Go to PCMS > Order -> Track Orders
# # 3. Go to shipment detail
# # 4. Change the items status of main product (freebie) from 'Return Received' to 'Return Completed' -> Click Save All
# # 5. Change operation status (4) from 'Refund Request' to 'CLT Doc Uploaded'
# # 6. Click 'Save'

    Login Pcms      ${pcms_callcenter_email}    ${pcms_callcenter_password}
    TrackOrder - Go To Order Detail Page    ${tc6_order_id}
    # TrackOrder - Set Item status    ${freebie_item_id}    ${item_status_db_return_received}
    # TrackOrder - Click save all
    TrackOrder - Set Item status    ${freebie_item_id}    ${item_status_db_return_completed}
    TrackOrder - Click save all

#### Expects
# 4. Item status =  'Return complete'  /  Operation status = Refund Request (default in dropdown) with CLT Doc Uploaded shown in the dropdown list
    TrackOrder - Check Item Status on UI    ${freebie_item_id}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${freebie_item_id}    ${item_status_db_return_completed}
    TrackOrder - Check Operation Status on UI       ${freebie_item_id}      ${operation_ui_refund_request}
    TrackOrder - Check Operation Status on DB       ${freebie_item_id}      ${operation_db_refund_request}

    TrackOrder - Set Operation Status    ${freebie_item_id}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save         ${freebie_item_id}

# #### Expects
# # 6.1 CLT Doc Uploaded is saved. /  Item status =  'Return complete'
# # 6.2 Can see history in 'view last update' to see who changed to CLT Doc Uploaded and when
    TrackOrder - Check Item Status on UI    ${freebie_item_id}    ${item_status_ui_return_completed}
    TrackOrder - Check Item Status on DB    ${freebie_item_id}    ${item_status_db_return_completed}
    TrackOrder - Check Operation Status on UI       ${freebie_item_id}      ${operation_ui_clt_doc_uploaded}
    TrackOrder - Check Operation Status on DB       ${freebie_item_id}      ${operation_db_clt_doc_uploaded}
    TrackOrder - Verify View Last Update Button for Operation Status is Visible       ${freebie_item_id}


    [Teardown]    Run Keywords    Rollback Order Status             ${tc6_order_id}
    ...    AND    Close All Browsers

#==================================================


TC_ITMWM_04040 To verify that a user can use mass upload to change operation status from 'Refund Request' to 'Pending TMN' when Item status = Return Completed [CCW]
    [Tags]  TC_ITMWM_04040    regression    WLS_Medium    ITMA-3221    itm-a-sprint 2016s15    ready

#### Prerequisite
    # 1. Buy single item [Normal] successfully via CCW
    # 2. Change the item status from 'Order Pending' to 'Pending Shipment'
    # 3. Change the item status from 'Pending Shipment' to 'Shipped'
    # 4. Change the item status from 'Shipped' to 'Delivered'
    # 5. Change the item status from 'Delivered' to 'Customer Cancelled', Choose 'Cancel Reason' and Operation status = 'Return Refund Request'
    # 6. Change the item status from 'Return Pending' to 'Return Received'
    # 7. Change the item status from 'Return Received' to 'Return Completed'

    ${tc9_order_id}=    Guest Buy Product Success with CCW    ${guest_email}    ${default_inventoryID}
    Log to Console      ${tc9_order_id}
    Close All Browsers

    ## Set Item Status
    Login Pcms
    TrackOrder - Go To Order Detail Page    ${tc9_order_id}
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${tc9_order_id}
    PCMS UI Order Page - Set All Item Status until to Return Completed       ${order_shipment_data[0][0]}

#### Teststep
    # 1. Go to PCMS > order
    # 2. Go to Upload Operation Status
    # 3. Click Browse under 'Refund Request To Pending TMN' and choose the excel file
    # 4. Click upload

#### Expects
### Operation status can be changed from Refund Request To Pending TMN correctly

    ${content}=    Refund Request To Pending TMN - Append Header To List
    Refund Request To Pending TMN - Append Data    ${order_shipment_data}    ${tc9_order_id}    ${content}
    Refund Request To Pending TMN - Create Excel File    ${content}
    Go to Upload Operation Status menu
    Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
    Refund Request To Pending TMN - Click Upload Button
    TrackOrder - Check Multiple items Operation Status on DB    ${order_shipment_data}    ${operation_db_pending_tmn}
    [Teardown]    Run Keywords    Close All Browsers

#==================================================================


TC_ITMWM_04041 To verify that a user can use mass upload to change operation status from 'Refund Request' to 'CLT Doc Uploaded'' when Item status = Return Completed (CS)
    [Tags]  TC_ITMWM_04041    regression    WLS_Medium     ITMA-3221    itm-a-sprint 2016s15    ready

#### Prerequisite
# 1. Buy single item [Normal] successfully via CS
# 2. Change the item status from 'Order Pending' to 'Pending Shipment'
# 3. Change the item status from 'Pending Shipment' to 'Shipped'
# 4. Change the item status from 'Shipped' to 'Delivered'
# 5. Change the item status from 'Delivered' to 'Customer Cancelled', Choose 'Cancel Reason' and Operation status = 'Return Refund Request'
# 6. Change the item status from 'Return Pending' to 'Return Received'
# 7. Change the item status from 'Return Received' to 'Return Completed'
# 8. Change the operation status from 'Refund Request' to 'Pending TMN'"

    ${tc10_order_id}=    Guest Buy Product Success with CS    ${guest_email}    ${default_inventoryID}
    Log To Console      ${tc10_order_id}
    # Rollback Order Status       ${tc10_order_id}
    Close All Browsers

    ## Set Item Status
    Login Pcms
    TrackOrder - Go To Order Detail Page    ${tc10_order_id}
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${tc10_order_id}


    PCMS UI Order Page - Set All Item Status until to Return Completed       ${order_shipment_data[0][0]}
    TrackOrder - Set Operation Status    ${order_shipment_data[0][0]}    ${operation_db_clt_doc_uploaded}
    TrackOrder - Click save all
    TrackOrder - Set Operation Status    ${order_shipment_data[0][0]}    ${operation_db_scm_verified}
    TrackOrder - Click save all
    TrackOrder - Set Operation Status    ${order_shipment_data[0][0]}    ${operation_db_pending_tmn}
    TrackOrder - Click save all

#### Teststep
    # 1. Go to PCMS > order
    # 2. Go to Upload Operation Status
    # 3. Click Browse under 'Pending TMN to Refund Complete' and choose the excel file
    # 4. Click upload

    ${content}=    Pending TMN To Refund Complete - Append Header To List
    Pending TMN To Refund Complete - Append Data    ${order_shipment_data}    ${tc10_order_id}    ${content}
    Pending TMN To Refund Complete - Create Excel File    ${content}
    Go to Upload Operation Status menu
    Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
    Pending TMN To Refund Complete - Click Upload Button

#### Expects
##Operation status can be changed from Pending TMN to Refund Complete correctly
    TrackOrder - Check Multiple items Operation Status on DB    ${order_shipment_data}    ${operation_db_refund_complete}
    [Teardown]    Run Keywords    Close All Browsers

#====================================================

# TC_ITMWM_04032 CCW - Bundle - Save] To verify that if only device of bundle is cancelled (after delivered), operation status 'Refund Request' is displayed as text.
#     [Tags]  TC_ITMWM_04032    TC_ITMWM_04033    ITMA-3221    itm-a-sprint 2016s15    regression    ready
#     # Order - Get Random Bundle Order With Payment Status Success

# #### Prerequisite
# # 1. Buy the bundle item successfully via CCW
# # 2. Change the items status of bundle from 'Order Pending' to 'Pending Shipment'
# # 3. Change the items status of bundle from 'Pending Shipment' to 'Shipped'
# # 4. Change the items status of bundle from 'Shipped' to 'Delivered'
# # 5. Change the items status of Mobile (bundle) from 'Delivered' to 'Customer Cancelled', Choose 'Cancel Reason' and Operation status = 'Return Refund Request'
# # 6. Change the items status of bundle from 'Return Pending' to 'Return Received'"

#     # ${tc1_order_id}=    Guest Buy Product Success with CS    ${guest_email}    ${default_inventoryID}
#     Log To Console      ${tc1_order_id}
#     Rollback Order Status    ${tc1_order_id}
#     Login Pcms

#     # http://alpha-pcms.itruemart-dev.com/truemoveh/verify?pcms_order_id=3011863

#     TrackOrder - Go To Order Detail Page    ${tc1_order_id}
#     ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${tc1_order_id}
#     PCMS UI Order Page - Set All Item Status until to Return Received           ${order_shipment_data[0][0]}
#     Close All Browsers


# #### Test Steps
# # 1. Login PCMS by SCM role
# # 2. Go to PCMS > Order -> Track Orders
# # 3. Go to shipment detail
# # 4. Change one item status of bundle (mobile) from 'Return Received' to 'Return Completed'
#     Login Pcms      ${pcms_scm_email}    ${pcms_scm_password}
#     TrackOrder - Go To Order Detail Page    ${tc1_order_id}
#     ${bundle_item_id}=      Query Bundle Device Item From Order         ${tc1_order_id}
#     TrackOrder - Set Item status    ${bundle_item_id}    ${item_status_db_return_completed}
#     TrackOrder - Click Save         ${bundle_item_id}
#     Confirm Action
#     Sleep   3s

# #### TestSteps
# #4. The selected item -> Item status is 'Return complete' and Operation status is 'Refund Request'.  "
#     TrackOrder - Check Item Status on UI       ${bundle_item_id}      ${item_status_ui_return_completed}
#     TrackOrder - Check Item Status on DB       ${bundle_item_id}      ${item_status_db_return_completed}
#     TrackOrder - Check Operation Status on UI       ${bundle_item_id}      ${operation_ui_return_refund_request}
#     TrackOrder - Check Operation Status on DB       ${bundle_item_id}      ${operation_db_return_refund_request}
#     Element Should Not Be Visible     //*[@id="status_operation_${bundle_item_id}"]

#     ${bundle_sim_item_id}=      Query Bundle Sim Item From Order         ${tc1_order_id}
#     Log to Console    ${bundle_sim_item_id}
#     TrackOrder - Set Item Status    ${bundle_sim_item_id}    ${item_status_db_return_received}
#     TrackOrder - Click save All
#     TrackOrder - Set Item status    ${bundle_sim_item_id}    ${item_status_db_return_completed}
#     # TrackOrder - Set Operation Status    ${order_shipment_item_id}    ${operation_db_pending_tmn}
#     TrackOrder - Click save all
#     Sleep   3s
# #### Expected
# # "5. Item status =  'Return complete'  /
# # Operation status = Refund Request (default in dropdown) with Pending TMN shown in the dropdown list
#     TrackOrder - Check Item Status on UI    ${bundle_item_id}    ${item_status_ui_return_completed}
#     TrackOrder - Check Item Status on DB    ${bundle_item_id}    ${item_status_db_return_completed}
#     TrackOrder - Check Operation Status on UI       ${bundle_item_id}      ${operation_ui_refund_request}
#     TrackOrder - Check Operation Status on DB       ${bundle_item_id}      ${operation_db_refund_request}
#     Wait Until Page Contains Element     //*[@id="status_operation_${bundle_item_id}"]/option[@value="pending_tmn"]

#     TrackOrder - Check Item Status on UI    ${bundle_sim_item_id}    ${item_status_ui_return_completed}
#     TrackOrder - Check Item Status on DB    ${bundle_sim_item_id}    ${item_status_db_return_completed}
#     TrackOrder - Check Operation Status on UI       ${bundle_sim_item_id}      ${operation_ui_refund_request}
#     TrackOrder - Check Operation Status on DB       ${bundle_sim_item_id}      ${operation_db_refund_request}
#     Wait Until Page Contains Element     //*[@id="status_operation_${bundle_sim_item_id}"]/option[@value="pending_tmn"]


#     TrackOrder - Set Operation Status    ${bundle_sim_item_id}    ${operation_db_pending_tmn}
#     TrackOrder - Click save All
#     Sleep   3s
#     TrackOrder - Check Operation Status on UI       ${bundle_sim_item_id}      ${operation_ui_pending_tmn}
#     TrackOrder - Check Operation Status on DB       ${bundle_sim_item_id}      ${operation_db_pending_tmn}
#     [Teardown]    Close All Browsers

# TC2 - [CCW - Bundle - Save All] To verify that if both items of bundle are Return Completed (Customer cancelled after delivered), the operation status will show drop-down lists and can change from 'Refund Request' to 'Pending TMN'
#     [Tags]  TC2

# #### Prerequisite
# # 1. Buy the bundle item successfully via CCW
# # 2. Change the items status of bundle from 'Order Pending' to 'Pending Shipment'
# # 3. Change the items status of bundle from 'Pending Shipment' to 'Shipped'
# # 4. Change the items status of bundle from 'Shipped' to 'Delivered'
# # 5. Change the items status of bundle from 'Delivered' to 'Customer Cancelled', Choose 'Cancel Reason' and Operation status = 'Return Refund Request'
# # 6. Change the items status of bundle from 'Return Pending' to 'Return Received'

#     # ${tc2_order_id}=    Guest Buy Product Success with CS    ${guest_email}    ${default_inventoryID}
#     Log To Console      ${tc2_order_id}
#     Login Pcms
#     TrackOrder - Go To Order Detail Page    ${tc2_order_id}
#     ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${tc2_order_id}
#     PCMS UI Order Page - Set All Item Status until to Return Received           ${order_shipment_data[0][0]}
#     Close All Browsers


# #### Test Steps
# # 1. Login by SCM role
# # 2. Go to PCMS > Order -> Track Orders
# # 3. Go to shipment detail
# # 4. Change the items status of bundle from 'Return Received' to 'Return Completed'
# # 5. Click 'Save All'
# # 6. Change operation status (4) from 'Refund Request' to 'Pending TMN'
# # 7. Click 'Save All'
# # 8. Go to PCMS > Order and select Operation Status = Pending TMN and then click Search

#     Login Pcms      ${pcms_scm_email}    ${pcms_scm_password}
#     TrackOrder - Go To Order Detail Page    ${tc2_order_id}
#     ${bundle_sim_item_id}=      Query Bundle Sim Item From Order         ${tc2_order_id}
#     PCMS UI Order Page - Set All Item Status until to Return Completed           ${bundle_sim_item_id}

# #### Expected
# # "5. Item status =  'Return complete'  /
# # Operation status = Refund Request (default in dropdown) with Pending TMN shown in the dropdown list
#     TrackOrder - Check Item Status on UI    ${bundle_sim_item_id}    ${item_status_ui_return_completed}
#     TrackOrder - Check Item Status on DB    ${bundle_sim_item_id}    ${item_status_db_return_completed}
#     TrackOrder - Check Operation Status on UI       ${bundle_sim_item_id}      ${operation_ui_refund_request}
#     TrackOrder - Check Operation Status on DB       ${bundle_sim_item_id}      ${operation_db_refund_request}
#     Element Should Be Visible     //*[@id="status_operation_${bundle_sim_item_id}"]/option[value="pending_tmn"]


#     TrackOrder - Set Operation Status    ${bundle_sim_item_id}    ${operation_db_pending_tmn}
#     TrackOrder - Click save All

# #### Expected
# # 7.1 Pending TMN is saved.
# # 7.2 Can see history in 'view last update' to see who changed to Pending TMN and when
# # 8. Search results and Export excel to see that order ID"

#     TrackOrder - Check Operation Status on UI       ${bundle_sim_item_id}      ${operation_ui_pending_tmn}
#     TrackOrder - Check Operation Status on DB       ${bundle_sim_item_id}      ${operation_db_pending_tmn}
#     TrackOrder - Verify View Last Update Button for Operation Status is Visible       ${bundle_sim_item_id}

#     Order - Go to Order Page
    #??????????????

# TC_ITMWM_04034 Installment - Normal - Save All] To verify that if FMS send item status to change from Return Received to Return Completed (Customer cancelled after delivered), The operation station will show drop-down lists and can selectable from Refund Request to Pending TMN
#     [Tags]  TC_ITMWM_04034    ITMA-3221    itm-a-sprint 2016s15    regression    ready

# #### Prerequisite
# # 1. Buy multiple item [MNP Device + Normal] successfully via Installment
# # 2. Change the items status from 'Order Pending' to 'Pending Shipment'
# # 3. Change the items status from 'Pending Shipment' to 'Shipped'
# # 4. Change the items status from 'Shipped' to 'Delivered'
# # 5. Change the items status from 'Delivered' to 'Customer Cancelled', Choose 'Cancel Reason' and Operation status = 'Return Refund Request'
# # 6. Change the items status from 'Return Pending' to 'Return Received'

#     ${tc3_order_id}=    Create Order - Guest buy single product success with Installment Kbank    ${default_inventoryID}   ${guest_email}
#     Log To Console      ${tc3_order_id}
#     Login Pcms
#     TrackOrder - Go To Order Detail Page    ${tc3_order_id}
#     ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${tc3_order_id}
#     PCMS UI Order Page - Set All Item Status until to Return Received           ${order_shipment_data[0][0]}
#     Sleep   3s
#     Close All Browsers

# #### Test Steps
# # 1. Login by SCM role
# # 2. Go to PCMS > Order -> Track Orders
# # 3. Go to shipment detail
# # 4. FMS sends items status to PCMS = 'Return Completed' by Postman
# # 5. From PCMS UI, change operation status (4) from 'Refund Request' to 'Pending TMN'
# # 6. Click 'Save All'

#     # ${body}=    Create Request Api update item status Return Completed with for Multi-item    ${tc3_order_id}    ${order_shipment_data}
#     # Send Api update status    ${body}

#     Login Pcms      ${pcms_scm_email}    ${pcms_scm_password}
#     TrackOrder - Go To Order Detail Page    ${tc3_order_id}
#     # TrackOrder - Set Item status    ${order_shipment_data[0][0]}    ${item_status_db_return_received}
#     # TrackOrder - Click save all
#     TrackOrder - Set Item status    ${order_shipment_data[0][0]}    ${item_status_db_return_completed}
#     TrackOrder - Click save all

# #### Expected
# # 4. Item status =  'Return complete'  /
# # Operation status = Refund Request (default in dropdown) with Pending TMN shown in the dropdown list
#     TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    ${item_status_ui_return_completed}
#     TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    ${item_status_db_return_completed}
#     TrackOrder - Check Operation Status on UI       ${order_shipment_data[0][0]}      ${operation_ui_refund_request}
#     TrackOrder - Check Operation Status on DB       ${order_shipment_data[0][0]}      ${operation_db_refund_request}
#     Element Should Be Visible     //*[@id="status_operation_${order_shipment_data[0][0]}"]/option[@value="pending_tmn"]

#     TrackOrder - Set Operation Status    ${order_shipment_data[0][0]}    ${operation_db_pending_tmn}
#     TrackOrder - Click save All
# #### Expected
# # 6.1 Pending TMN is saved. /  Item status =  'Return complete'
# # 6.2 Can see history in 'view last update' to see who changed to Pending TMN and when

#     TrackOrder - Check Operation Status on UI       ${order_shipment_data[0][0]}      ${operation_ui_pending_tmn}
#     TrackOrder - Check Operation Status on DB       ${order_shipment_data[0][0]}      ${operation_db_pending_tmn}
#     TrackOrder - Verify View Last Update Button for Operation Status is Visible       ${order_shipment_data[0][0]}

#     [Teardown]    Close All Browsers

#    update test case mapping Robot to TMT
#TC4 - [COD - Freebie + Normal - Save All] To verify that if items status is Return Completed (Customer cancelled after delivered), the operation status will show drop-down lists and can change from Refund Request to CLT Doc Uploaded
# TC_ITMWM_04035 COD - Freebie + Normal - Save All To verify that if items status is Return Completed (Customer cancelled after delivered), the operation status will show drop-down lists and can change from Refund Request to CLT Doc Uploaded
#     [Tags]  TC_ITMWM_04035    TC4    ITMA-3221    itm-a-sprint 2016s15    regression    ready


#     ${tc4_order_id}=    Query Freebie Order
#     Rollback Order Status For COD             ${tc4_order_id}
#     Change Order Payment Method to be COD        ${tc4_order_id}
#     Log to Console      ${tc4_order_id}

# #### Prerequisite
# # 1. Buy multiple item [Freebie + Normal] successfully via Wallet
# # 2. Change the items status from 'Order Pending' to 'Pending Shipment'
# # 3. Change the items status from 'Pending Shipment' to 'Shipped'
# # 4. Change the items status from 'Shipped' to 'Delivered'
# # 5. Change the items status of main product (freebie) from 'Delivered' to 'Customer Cancelled', Choose 'Cancel Reason' and Operation status = 'Return Refund Request'
# # 6. Change the items status from 'Return Pending' to 'Return Received'"

#     Login Pcms
#     TrackOrder - Go To Order Detail Page    ${tc4_order_id}
#     ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${tc4_order_id}
#     ${freebie_item_id}=      Query Freebie Item From Order         ${tc4_order_id}
#     PCMS UI Order Page - Set All Item Status until to Return Received           ${freebie_item_id}
#     Sleep   3s
#     Close All Browsers

# # #### Test Step
# # # 1. Login by CLT role
# # # 2. Go to PCMS > Order -> Track Orders
# # # 3. Go to shipment detail
# # # 4. Change the items status of main product (freebie) from 'Return Received' to 'Return Completed' -> Click Save All
# # # 5. Change operation status (4) from 'Refund Request' to 'CLT Doc Uploaded'
# # # 6. Click 'Save'

#     Login Pcms      ${pcms_callcenter_email}    ${pcms_callcenter_password}
#     TrackOrder - Go To Order Detail Page    ${tc4_order_id}
#     # TrackOrder - Set Item status    ${freebie_item_id}    ${item_status_db_return_received}
#     # TrackOrder - Click save all
#     TrackOrder - Set Item status    ${freebie_item_id}    ${item_status_db_return_completed}
#     TrackOrder - Click save all
# #### Expects
# # 4. Item status =  'Return complete'  /  Operation status = Refund Request (default in dropdown) with CLT Doc Uploaded shown in the dropdown list
#     TrackOrder - Check Item Status on UI    ${freebie_item_id}    ${item_status_ui_return_completed}
#     TrackOrder - Check Item Status on DB    ${freebie_item_id}    ${item_status_db_return_completed}
#     TrackOrder - Check Operation Status on UI       ${freebie_item_id}      ${operation_ui_refund_request}
#     TrackOrder - Check Operation Status on DB       ${freebie_item_id}      ${operation_db_refund_request}

#     TrackOrder - Set Operation Status    ${freebie_item_id}    ${operation_db_clt_doc_uploaded}
#     TrackOrder - Click save         ${freebie_item_id}
# # #### Expects
# # # 6.1 CLT Doc Uploaded is saved. /  Item status =  'Return complete'
# # # 6.2 Can see history in 'view last update' to see who changed to CLT Doc Uploaded and when
#     TrackOrder - Check Item Status on UI    ${freebie_item_id}    ${item_status_ui_return_completed}
#     TrackOrder - Check Item Status on DB    ${freebie_item_id}    ${item_status_db_return_completed}
#     TrackOrder - Check Operation Status on UI       ${freebie_item_id}      ${operation_ui_clt_doc_uploaded}
#     TrackOrder - Check Operation Status on DB       ${freebie_item_id}      ${operation_db_clt_doc_uploaded}
#     TrackOrder - Verify View Last Update Button for Operation Status is Visible       ${freebie_item_id}


#     [Teardown]    Run Keywords    Rollback Order Status For COD             ${tc4_order_id}
#     ...    AND    Close All Browsers



#TC5 - [CS - Normal + Normal - Save All] To verify that the operation station will show drop-down lists and can selectable from Refund Request to Pending TMN after getting request from FMS to change item status from Return Received to Return Completed (Customer cancelled after delivered),
# TC_ITMWM_04036 CS - Normal + Normal - Save All To verify that the operation status displays as dropdown with CLT Doc Uploaded after getting request from FMS to change item status from Return Received to Return Completed (cancelled after delivered)
#     [Tags]  TC_ITMWM_04036    TC5     ITMA-3221    itm-a-sprint 2016s15    regression    ready
#     # ${tc5_order_id}=    Query Order
#     Rollback Order Status            ${tc5_order_id}
#     Change Order Payment Method to be CS        ${tc5_order_id}
#     Log To Console      ${tc5_order_id}

# #### Prerequisite
# # 1. Buy multiple item [Normal + Normal] successfully via CS
# # 2. Change the items status from 'Order Pending' to 'Pending Shipment'
# # 3. Change the items status from 'Pending Shipment' to 'Shipped'
# # 4. Change the items status from 'Shipped' to 'Delivered'
# # 5. Change the item status of both items from 'Delivered' to 'Customer Cancelled', Choose 'Cancel Reason' and Operation status = 'Return Refund Request'
# # 6. Change the items status from 'Return Pending' to 'Return Received'"

#     Login Pcms
#     TrackOrder - Go To Order Detail Page    ${tc5_order_id}
#     ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${tc5_order_id}
#     PCMS UI Order Page - Set All Item Status until to Return Received           ${order_shipment_data[0][0]}
#     TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    ${item_status_ui_return_received}
#     TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    ${item_status_db_return_received}
#     Close All Browsers

# # #### Test Step
# # 1. Login by CLT role
# # 2. Go to PCMS > Order -> Track Orders
# # 3. Go to shipment detail
# # 4. FMS send items status 'Return Completed' by Postman


#     ${body}=    Create Request Api update item status Return Completed with for Multi-item    ${tc5_order_id}    ${order_shipment_data}
#     Send Api update status    ${body}
#     Login Pcms      ${pcms_callcenter_email}    ${pcms_callcenter_password}
#     TrackOrder - Go To Order Detail Page    ${tc5_order_id}
#     # TrackOrder - Set Item status    ${order_shipment_data[0][0]}    ${item_status_db_return_completed}
#     # TrackOrder - Click save all

#     Login Pcms      ${pcms_callcenter_email}    ${pcms_callcenter_password}
#     TrackOrder - Go To Order Detail Page    ${tc5_order_id}


# # #### Expects
# # 4. Item status =  'Return complete'  /  Operation status = Refund Request (default in dropdown) with CLT Doc Uploaded shown in the dropdown list

#     TrackOrder - Check Item Status on UI    ${order_shipment_data[0][0]}    ${item_status_ui_return_completed}
#     TrackOrder - Check Item Status on DB    ${order_shipment_data[0][0]}    ${item_status_db_return_completed}
#     TrackOrder - Check Operation Status on UI       ${order_shipment_data[0][0]}      ${operation_ui_refund_request}
#     TrackOrder - Check Operation Status on DB       ${order_shipment_data[0][0]}      ${operation_db_refund_request}

# # #### Test Step
# # 5. Change operation status (4) from 'Refund Request' to 'CLT Doc Uploaded'
# # 6. Click 'Save All'
#     TrackOrder - Set Operation Status    ${order_shipment_data[0][0]}    ${operation_db_clt_doc_uploaded}
#     TrackOrder - Click save all

# # #### Expects
# # 6.1 CLT Doc Uploaded is saved. /  Item status =  'Return complete'
# # 6.2 Can see history in 'view last update' to see who changed to CLT Doc Uploaded and when
#     TrackOrder - Check Operation Status on UI       ${order_shipment_data[0][0]}      ${operation_ui_clt_doc_uploaded}
#     TrackOrder - Check Operation Status on DB       ${order_shipment_data[0][0]}      ${operation_db_clt_doc_uploaded}
#     TrackOrder - Verify View Last Update Button for Operation Status is Visible       ${order_shipment_data[0][0]}


# #TC6 - [Wallet - Freebie + Normal - Save] To verify that if items status are Return Completed (Customer cancelled after delivered), the operation status will show as drop-down lists and can change from 'Refund Request' to 'CLT Doc Uploaded'
# TC_ITMWM_04037 Wallet - Freebie + Normal - Save To verify that if items status are Return Completed (cancelled after delivered),the operation status will show drop-down lists and can change from Refund Request to CLT Doc Uploaded
#     [Tags]    TC_ITMWM_04037    TC6     ITMA-3221    itm-a-sprint 2016s15    regression    ready

#     ${tc6_order_id}=    Query Freebie Order
#     Rollback Order Status             ${tc6_order_id}
#     Change Order Payment Method to be Wallet        ${tc6_order_id}
#     Log to Console      ${tc6_order_id}

# #### Prerequisite
# # 1. Buy multiple item [Freebie + Normal] successfully via Wallet
# # 2. Change the items status from 'Order Pending' to 'Pending Shipment'
# # 3. Change the items status from 'Pending Shipment' to 'Shipped'
# # 4. Change the items status from 'Shipped' to 'Delivered'
# # 5. Change the items status of main product (freebie) from 'Delivered' to 'Customer Cancelled', Choose 'Cancel Reason' and Operation status = 'Return Refund Request'
# # 6. Change the items status from 'Return Pending' to 'Return Received'"

#     Login Pcms
#     TrackOrder - Go To Order Detail Page    ${tc6_order_id}
#     ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${tc6_order_id}
#     ${freebie_item_id}=      Query Freebie Item From Order         ${tc6_order_id}
#     PCMS UI Order Page - Set All Item Status until to Return Received           ${freebie_item_id}
#     Sleep   3s
#     Close All Browsers

# # #### Test Step
# # # 1. Login by CLT role
# # # 2. Go to PCMS > Order -> Track Orders
# # # 3. Go to shipment detail
# # # 4. Change the items status of main product (freebie) from 'Return Received' to 'Return Completed' -> Click Save All
# # # 5. Change operation status (4) from 'Refund Request' to 'CLT Doc Uploaded'
# # # 6. Click 'Save'

#     Login Pcms      ${pcms_callcenter_email}    ${pcms_callcenter_password}
#     TrackOrder - Go To Order Detail Page    ${tc6_order_id}
#     # TrackOrder - Set Item status    ${freebie_item_id}    ${item_status_db_return_received}
#     # TrackOrder - Click save all
#     TrackOrder - Set Item status    ${freebie_item_id}    ${item_status_db_return_completed}
#     TrackOrder - Click save all

# #### Expects
# # 4. Item status =  'Return complete'  /  Operation status = Refund Request (default in dropdown) with CLT Doc Uploaded shown in the dropdown list
#     TrackOrder - Check Item Status on UI    ${freebie_item_id}    ${item_status_ui_return_completed}
#     TrackOrder - Check Item Status on DB    ${freebie_item_id}    ${item_status_db_return_completed}
#     TrackOrder - Check Operation Status on UI       ${freebie_item_id}      ${operation_ui_refund_request}
#     TrackOrder - Check Operation Status on DB       ${freebie_item_id}      ${operation_db_refund_request}

#     TrackOrder - Set Operation Status    ${freebie_item_id}    ${operation_db_clt_doc_uploaded}
#     TrackOrder - Click save         ${freebie_item_id}

# # #### Expects
# # # 6.1 CLT Doc Uploaded is saved. /  Item status =  'Return complete'
# # # 6.2 Can see history in 'view last update' to see who changed to CLT Doc Uploaded and when
#     TrackOrder - Check Item Status on UI    ${freebie_item_id}    ${item_status_ui_return_completed}
#     TrackOrder - Check Item Status on DB    ${freebie_item_id}    ${item_status_db_return_completed}
#     TrackOrder - Check Operation Status on UI       ${freebie_item_id}      ${operation_ui_clt_doc_uploaded}
#     TrackOrder - Check Operation Status on DB       ${freebie_item_id}      ${operation_db_clt_doc_uploaded}
#     TrackOrder - Verify View Last Update Button for Operation Status is Visible       ${freebie_item_id}


#     [Teardown]    Run Keywords    Rollback Order Status             ${tc6_order_id}
#     ...    AND    Close All Browsers


#TC7 - To verify that person who is not in SCM role cannot change operation from 'Refund Request' to 'Pending TMN'
TC_ITMWM_04038 To verify that person who is not in SCM role cannot change operation from 'Refund Request' to 'Pending TMN'
#    Comment Tag Duplicate
#    [Tags]    TC_ITMWM_04038    TC7     ITMA-3221    itm-a-sprint 2016s15    regression    ready
    [Tags]    TC_ITMWM_04038    regression    WLS_Medium    ITMA-3221    itm-a-sprint 2016s15    ready

#### Prerequisite
# 1. Buy single item [Normal] successfully via CCW
# 2. Change the item status from 'Order Pending' to 'Pending Shipment'
# 3. Change the item status from 'Pending Shipment' to 'Shipped'
# 4. Change the item status from 'Shipped' to 'Delivered'
# 5. Change the item status from 'Delivered' to 'Customer Cancelled', Choose 'Cancel Reason' and Operation status = 'Return Refund Request'
# 6. Change the item status from 'Return Pending' to 'Return Received'
# 7. Change the item status from 'Return Received' to 'Return Completed'

    ## Create Order
    ${tc7_order_id}=    Guest Buy Product Success with CCW    ${guest_email}    ${default_inventoryID}

    Close All Browsers

    ## Set Item Status
    Login Pcms
    TrackOrder - Go To Order Detail Page    ${tc7_order_id}
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${tc7_order_id}
    PCMS UI Order Page - Set All Item Status until to Return Completed       ${order_shipment_data[0][0]}


#### Teststep
# 1. Login by CLT role
# 2. Go to PCMS > Order -> Track Orders -> Find an order (paid by CCW) where item status = Return Complete / Operation status = Refund Request
# 3. Go to shipment detail "

    Login Pcms      ${pcms_scm_email}    ${pcms_scm_password}
    TrackOrder - Go To Order Detail Page    ${tc7_order_id}
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${tc7_order_id}
    Element Should Not Be Visible     //*[@id="status_operation_${order_shipment_data}"]/option[@value="pending_tmn"]


#### Expects
# 4. At operation status, there is no dropdown list with Pending TMN value displayed.
# Operation status = Refund Request and it is displayed as text."

    [Teardown]    Run Keywords    Close All Browsers


#TC8 - To verify that person who is not in CLT role cannot change operation from 'Refund Request' to 'CLT Doc Upload'
TC_ITMWM_04039 To verify that person who is not in CLT role cannot change operation from 'Refund Request' to 'CLT Doc Upload'
#    Comment Tag Duplicate
#    [Tags]    TC_ITMWM_04039    TC8     ITMA-3221    itm-a-sprint 2016s15    regression    ready
    [Tags]    TC_ITMWM_04039    regression    WLS_Medium    ITMA-3221    itm-a-sprint 2016s15    ready


#### Prerequisite
# 1. Buy single item [Normal] successfully via Wallet
# 2. Change the item status from 'Order Pending' to 'Pending Shipment'
# 3. Change the item status from 'Pending Shipment' to 'Shipped'
# 4. Change the item status from 'Shipped' to 'Delivered'
# 5. Change the item status from 'Delivered' to 'Customer Cancelled', Choose 'Cancel Reason' and Operation status = 'Return Refund Request'
# 6. Change the item status from 'Return Pending' to 'Return Received'
# 7. Change the item status from 'Return Received' to 'Return Completed'

    ${tc8_order_id}=    Guest Buy Product Success with CCW    ${guest_email}    ${default_inventoryID}
    Login Pcms
    Change Order Payment Method to be Wallet        ${tc8_order_id}
    TrackOrder - Go To Order Detail Page    ${tc8_order_id}
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${tc8_order_id}
    PCMS UI Order Page - Set All Item Status until to Return Completed       ${order_shipment_data[0][0]}
    Sleep   3s
    Close All Browsers

# #### Teststep
# # 1. Login by SCM role
# # 2. Go to PCMS > Order -> Track Orders
# # 3. Go to shipment detail
# # 4. SCM role can't change operation status and view operation status 'refund request' as text

    Login Pcms      ${pcms_scm_email}    ${pcms_scm_password}
    TrackOrder - Go To Order Detail Page    ${tc8_order_id}
    Element Should Not Be Visible     //*[@id="status_operation_${order_shipment_data[0][0]}"]/option[@value="refund_request"]

# # 4. At operation status, there is no dropdown list with CLT Doc Uploaded value displayed.
# # Operation status = Refund Request and it is displayed as text."
    [Teardown]    Run Keywords    Rollback Order Status             ${tc8_order_id}
    ...    AND    Close All Browsers

#TC9 - To verify that a user can use mass upload to change operation status from 'Refund Request' to 'Pending TMN' when Item status = Return Completed [CCW]
# TC_ITMWM_04040 To verify that a user can use mass upload to change operation status from 'Refund Request' to 'Pending TMN' when Item status = Return Completed CCW
#     [Tags]    TC_ITMWM_04040    TC9     ITMA-3221    itm-a-sprint 2016s15    regression    ready

# #### Prerequisite
#     # 1. Buy single item [Normal] successfully via CCW
#     # 2. Change the item status from 'Order Pending' to 'Pending Shipment'
#     # 3. Change the item status from 'Pending Shipment' to 'Shipped'
#     # 4. Change the item status from 'Shipped' to 'Delivered'
#     # 5. Change the item status from 'Delivered' to 'Customer Cancelled', Choose 'Cancel Reason' and Operation status = 'Return Refund Request'
#     # 6. Change the item status from 'Return Pending' to 'Return Received'
#     # 7. Change the item status from 'Return Received' to 'Return Completed'

#     ${tc9_order_id}=    Guest Buy Product Success with CCW    ${guest_email}    ${default_inventoryID}
#     Log to Console      ${tc9_order_id}
#     Close All Browsers

#     ## Set Item Status
#     Login Pcms
#     TrackOrder - Go To Order Detail Page    ${tc9_order_id}
#     ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${tc9_order_id}
#     PCMS UI Order Page - Set All Item Status until to Return Completed       ${order_shipment_data[0][0]}

# #### Teststep
#     # 1. Go to PCMS > order
#     # 2. Go to Upload Operation Status
#     # 3. Click Browse under 'Refund Request To Pending TMN' and choose the excel file
#     # 4. Click upload

# #### Expects
# ### Operation status can be changed from Refund Request To Pending TMN correctly

#     ${content}=    Refund Request To Pending TMN - Append Header To List
#     Refund Request To Pending TMN - Append Data    ${order_shipment_data}    ${tc9_order_id}    ${content}
#     Refund Request To Pending TMN - Create Excel File    ${content}
#     Go to Upload Operation Status menu
#     Refund Request To Pending TMN - Upload excel file    ${refund_request_to_pending_tmn_excel_file_name}
#     Refund Request To Pending TMN - Click Upload Button
#     TrackOrder - Check Multiple items Operation Status on DB    ${order_shipment_data}    ${operation_db_pending_tmn}
#     [Teardown]    Run Keywords    Close All Browsers

#TC10 - To verify that a user can use mass upload to change operation status from 'Refund Request' to 'CLT Doc Uploaded'' when Item status = Return Completed (CS)
# TC_ITMWM_04041 To verify that a user can use mass upload to change operation status from 'Refund Request' to 'CLT Doc Uploaded' when Item status = Return Completed  [CS]
#     [Tags]    TC_ITMWM_04041    TC10     ITMA-3221    itm-a-sprint 2016s15    regression    ready

# #### Prerequisite
# # 1. Buy single item [Normal] successfully via CS
# # 2. Change the item status from 'Order Pending' to 'Pending Shipment'
# # 3. Change the item status from 'Pending Shipment' to 'Shipped'
# # 4. Change the item status from 'Shipped' to 'Delivered'
# # 5. Change the item status from 'Delivered' to 'Customer Cancelled', Choose 'Cancel Reason' and Operation status = 'Return Refund Request'
# # 6. Change the item status from 'Return Pending' to 'Return Received'
# # 7. Change the item status from 'Return Received' to 'Return Completed'
# # 8. Change the operation status from 'Refund Request' to 'Pending TMN'"

#     ${tc10_order_id}=    Guest Buy Product Success with CS    ${guest_email}    ${default_inventoryID}
#     Log To Console      ${tc10_order_id}
#     # Rollback Order Status       ${tc10_order_id}
#     Close All Browsers

#     ## Set Item Status
#     Login Pcms
#     TrackOrder - Go To Order Detail Page    ${tc10_order_id}
#     ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${tc10_order_id}


#     PCMS UI Order Page - Set All Item Status until to Return Completed       ${order_shipment_data[0][0]}
#     TrackOrder - Set Operation Status    ${order_shipment_data[0][0]}    ${operation_db_clt_doc_uploaded}
#     TrackOrder - Click save all
#     TrackOrder - Set Operation Status    ${order_shipment_data[0][0]}    ${operation_db_scm_verified}
#     TrackOrder - Click save all
#     TrackOrder - Set Operation Status    ${order_shipment_data[0][0]}    ${operation_db_pending_tmn}
#     TrackOrder - Click save all

# #### Teststep
#     # 1. Go to PCMS > order
#     # 2. Go to Upload Operation Status
#     # 3. Click Browse under 'Pending TMN to Refund Complete' and choose the excel file
#     # 4. Click upload

#     ${content}=    Pending TMN To Refund Complete - Append Header To List
#     Pending TMN To Refund Complete - Append Data    ${order_shipment_data}    ${tc10_order_id}    ${content}
#     Pending TMN To Refund Complete - Create Excel File    ${content}
#     Go to Upload Operation Status menu
#     Pending TMN To Refund Complete - Upload excel file    ${pending_tmn_to_refund_complete_excel_file_name}
#     Pending TMN To Refund Complete - Click Upload Button

# #### Expects
# ##Operation status can be changed from Pending TMN to Refund Complete correctly
#     TrackOrder - Check Multiple items Operation Status on DB    ${order_shipment_data}    ${operation_db_refund_complete}
#     [Teardown]    Run Keywords    Close All Browsers