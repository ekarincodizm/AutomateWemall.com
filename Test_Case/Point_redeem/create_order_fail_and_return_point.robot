*** Settings ***
#Resource          ${CURDIR}/../../Resource/init.robot
Resource          ${CURDIR}/../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../Keyword/Features/Create_Order/Create_order.txt
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Track_Order/Keywords_TrackOrder.robot
Resource          ${CURDIR}/../../Keyword/API/common/api_keywords.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Product/update_stock.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Item_status/update_item_status.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../Keyword/Features/Create_Order/WebElement_order.robot
Resource          ${CURDIR}/../../Keyword/Features/point_redeemtion/apply_point.robot
Resource          ${CURDIR}/../../Keyword/Features/point_redeemtion/WebElement_apply_point.robot
#Library           ${CURDIR}/../../Python_Library/DatabaseDataPoint.py
Force Tags      Point_Redeem


*** Variable ***
${email}    Tureyou_point@test.com
${pcms_email}     admin@domain.com
${pcms_password}    12345
${trueyou_user}    runoinar@gmail.com
${trueyou_pass}    75103598
${inventoryID}    INAAC1112611

${merchant_id}    1
${partner_id_trueyou}    1

*** Test Cases ***

TC_ITMWM_05355 Multiple items - CCW - To verify that system return Trueyou point after create order with Trueyou point but get payment fail
    [Tags]    regression    ready    TC_ITMWM_05355
    ${point}=    Set Variable    1
    ${has_data}=    Set Variable    1
    ${status}=    Set Variable    done
    ${expected_point_discount}=    Set Variable    0.1

    ${Customer_ref_id}=     Guest add multiple products until checkout3    ${email}    ${default_inventoryID}    ${default_inventoryID}
    Point - Verify Point Redeem Tab is Shown
    Point - Click on Redeem Point Tab
    Point - Choose Trueyou channel
    Point - Input Trueyou Account     ${trueyou_user}    ${trueyou_pass}
    Point - Choose Discount and Click Next
    Point - Verify Point and Discount are displayed     ${point}     ${expected_point_discount}
    ${order_id}=    Submit order With CCW Payment Failed

    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    failed

    Point - Verify Ref Transaction Data In DB    ${Customer_ref_id}    ${order_id}    ${has_data}
    Point - Verify Point And Status From Return Point In DB    ${Customer_ref_id}    ${order_id}    ${merchant_id}    ${partner_id_trueyou}    ${point}    ${status}

    [Teardown]    close all browsers

TC_ITMWM_05356 Multiple items - CCW - To verify that system will not return Trueyou point after create order with Trueyou point and get payment success.
    [Tags]    regression    ready    TC_ITMWM_05356
    ${point}=    Set Variable    1
    ${has_data}=    Set Variable    1
    ${status}=    Set Variable    done
    ${expected_point_discount}=    Set Variable    0.1

    ${Customer_ref_id}=     Guest add multiple products until checkout3    ${email}    ${default_inventoryID}    ${default_inventoryID}
    Point - Verify Point Redeem Tab is Shown
    Point - Click on Redeem Point Tab
    Point - Choose Trueyou channel
    Point - Input Trueyou Account     ${trueyou_user}    ${trueyou_pass}
    Point - Choose Discount and Click Next
    Point - Verify Point and Discount are displayed     ${point}     ${expected_point_discount}
    ${order_id}=    Checkout 3 - Create Order CCW

    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    success

    Point - Verify Ref Transaction Data In DB    ${Customer_ref_id}    ${order_id}    ${has_data}
    Point - Verify Point And Status From Return Point In DB    ${Customer_ref_id}    ${order_id}    ${merchant_id}    ${partner_id_trueyou}

    [Teardown]    close all browsers

TC_ITMWM_05361 Multiple items - Installment - To verify that system return Trueyou point after create order with Trueyou point but get payment fail.
    [Tags]    regression    ready    TC_ITMWM_05361
    ${point}=    Set Variable    1
    ${has_data}=    Set Variable    1
    ${status}=    Set Variable    done
    ${expected_point_discount}=    Set Variable    0.1
    ${installment_provider}=    Set Variable    กรุงเทพ
    ${installment_plan}=    Set Variable    @value="6"
    LOGIN PCMS
    Go To Edit Payment Channel Page    ${inventoryID_inst_fail}
    Set bangkok bank Installment Payment

    ${Customer_ref_id}=     Guest add multiple products until checkout3    ${email}    ${inventoryID_inst_fail}    ${inventoryID_inst_fail}
    Point - Verify Point Redeem Tab is Shown
    Point - Click on Redeem Point Tab
    Point - Choose Trueyou channel
    Point - Input Trueyou Account     ${trueyou_user}    ${trueyou_pass}
    Point - Choose Discount and Click Next
    Point - Verify Point and Discount are displayed     ${point}     ${expected_point_discount}
    ${order_id}=    Submit order With Installment Payment Failed    ${installment_provider}    ${installment_plan}
    Log To Console    ${order_id}

    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    failed

    Point - Verify Ref Transaction Data In DB    ${Customer_ref_id}    ${order_id}    ${has_data}
    Point - Verify Point And Status From Return Point In DB    ${Customer_ref_id}    ${order_id}    ${merchant_id}    ${partner_id_trueyou}    ${point}    ${status}

    [Teardown]    close all browsers

TC_ITMWM_05363 Multiple items - TMN Wallet - To verify that system return Trueyou point after create order with Trueyou point but get payment fail.
    [Tags]    regression    ready    TC_ITMWM_05363
    ${point}=    Set Variable    1
    ${has_data}=    Set Variable    1
    ${status}=    Set Variable    done
    ${expected_point_discount}=    Set Variable    0.1
    LOGIN PCMS
    SET ALLOW TM    ${inventoryID_inst_fail}
    close all browsers
    ${Customer_ref_id}=     Guest add multiple products until checkout3    ${email}    ${inventoryID_inst_fail}    ${inventoryID_inst_fail}
    Point - Verify Point Redeem Tab is Shown
    Point - Click on Redeem Point Tab
    Point - Choose Trueyou channel
    Point - Input Trueyou Account     ${trueyou_user}    ${trueyou_pass}
    Point - Choose Discount and Click Next
    Point - Verify Point and Discount are displayed     ${point}     ${expected_point_discount}
    ${order_id}=    Submit order With TMN Wallet Payment Failed

    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    failed

    Point - Verify Ref Transaction Data In DB    ${Customer_ref_id}    ${order_id}    ${has_data}
    Point - Verify Point And Status From Return Point In DB    ${Customer_ref_id}    ${order_id}    ${merchant_id}    ${partner_id_trueyou}    ${point}    ${status}

    [Teardown]    close all browsers