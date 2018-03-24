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
Resource          ${CURDIR}/../../Keyword/Database/PCMS/Orders/keywords_orders.robot
#Library           ${CURDIR}/../../Python_Library/DatabaseDataPoint.py
Force Tags      Point_Redeem


*** Variable ***
${email}            Tureyou_point@test.com
${pcms_email}       admin@domain.com
${pcms_password}    12345
${trueyou_user}     runoinar@gmail.com
${trueyou_pass}     75103598
${inventoryID}      INAAC1112611

${merchant_id}          1
${partner_id_trueyou}   1
${installment_plan}     @value="3"

*** Test Cases ***

TC_ITMWM_05604 Single item - TMN Wallet - To verify that system return Trueyou point after create order with Trueyou point and payment status = expired.
    [Tags]    regression     ready    TC_ITMWM_05604    ITMB-2002    trueyou
    [Teardown]    close all browsers

    ${point}=       Set Variable    1
    ${has_data}=    Set Variable    1
    ${status}=      Set Variable    done
    ${expected_point_discount}=     Set Variable    0.1

    # 1. Buy products, then apply Trueyou Point.
    LOGIN PCMS
    SET ALLOW TM    ${inventoryID}
    Close All Browsers

    ${Customer_ref_id}=     Guest add single product until checkout3 return Customer Ref Id    ${email}    ${default_inventoryID}
    Point - Verify Point Redeem Tab is Shown
    Point - Click on Redeem Point Tab
    Point - Choose Trueyou channel
    Point - Input Trueyou Account     ${trueyou_user}    ${trueyou_pass}
    Point - Choose Discount and Click Next
    Point - Verify Point and Discount are displayed     ${point}     ${expected_point_discount}

    # 2. Make payment pending via wallet. (verify Payment status = pending.)
    Submit order With TMN Wallet Payment Pending
    ${order}=    Orders - Get Lasted Order By Customer Ref Id    ${Customer_ref_id}
    ${order_id}=    Set Variable    ${order[0][0]}
    Log To Console    ${order_id}
    Close All Browsers

    Login Pcms
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending

    # 3. Update db tbl=orders:expired_at Run cron expired (verify Payment status = expired.)
    Orders - Update Order Expired    ${order_id}
    Orders - Clear Expired Order
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    expired

    # 4. Verify reference transaction in redeem table. (verify Reference transaction in not null)
    Point - Verify Ref Transaction Data In DB    ${Customer_ref_id}    ${order_id}    ${has_data}

    # 5. Check data in return_point table. (verify All data is correct)
    Point - Verify Point And Status From Return Point In DB    ${Customer_ref_id}    ${order_id}    ${merchant_id}    ${partner_id_trueyou}    ${point}    ${status}

TC_ITMWM_05605 Multiple items - TMN Wallet - To verify that system return Trueyou point after create order with Trueyou point and payment status = expired.
    [Tags]    regression     ready    TC_ITMWM_05605    ITMB-2002    trueyou
    [Teardown]    close all browsers

    ${point}=       Set Variable    1
    ${has_data}=    Set Variable    1
    ${status}=      Set Variable    done
    ${expected_point_discount}=     Set Variable    0.1

    # 1. Buy products, then apply Trueyou Point.
    LOGIN PCMS
    SET ALLOW TM    ${inventoryID}
    Close All Browsers

    ${Customer_ref_id}=     Guest add multiple products until checkout3    ${email}    ${default_inventoryID}    ${default_inventoryID}
    Point - Verify Point Redeem Tab is Shown
    Point - Click on Redeem Point Tab
    Point - Choose Trueyou channel
    Point - Input Trueyou Account     ${trueyou_user}    ${trueyou_pass}
    Point - Choose Discount and Click Next
    Point - Verify Point and Discount are displayed     ${point}     ${expected_point_discount}

    # 2. Make payment pending via wallet. (verify Payment status = pending.)
    Submit order With TMN Wallet Payment Pending
    ${order}=    Orders - Get Lasted Order By Customer Ref Id    ${Customer_ref_id}
    ${order_id}=    Set Variable    ${order[0][0]}
    Log To Console    ${order_id}
    Close All Browsers

    Login Pcms
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    payment_pending
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    payment_pending

    # 3. Update db tbl=orders:expired_at Run cron expired (verify Payment status = expired.)
    Orders - Update Order Expired    ${order_id}
    Orders - Clear Expired Order
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    expired
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[1][0]}    expired

    # 4. Verify reference transaction in redeem table. (verify Reference transaction in not null)
    Point - Verify Ref Transaction Data In DB    ${Customer_ref_id}    ${order_id}    ${has_data}

    # 5. Check data in return_point table. (verify All data is correct)
    Point - Verify Point And Status From Return Point In DB    ${Customer_ref_id}    ${order_id}    ${merchant_id}    ${partner_id_trueyou}    ${point}    ${status}

TC_ITMWM_05606 Single item - Installment - To verify that system return Trueyou point after create order with Trueyou point and payment status = expired.
    [Tags]    regression     ready    TC_ITMWM_05606
    [Teardown]    close all browsers
    ${point}=    Set Variable    1
    ${has_data}=    Set Variable    1
    ${status}=    Set Variable    done
    ${expected_point_discount}=    Set Variable    0.1

    LOGIN PCMS
    Go To Edit Payment Channel Page    ${default_inventoryID}
    Set ktc Installment Payment

    ${Customer_ref_id}=     Guest add single product until checkout3 return Customer Ref Id     ${email}    ${default_inventoryID}
    Point - Verify Point Redeem Tab is Shown
    Point - Click on Redeem Point Tab
    Point - Choose Trueyou channel
    Point - Input Trueyou Account     ${trueyou_user}    ${trueyou_pass}
    Point - Choose Discount and Click Next
    Point - Verify Point and Discount are displayed     ${point}     ${expected_point_discount}

    # installment
    ${order_id}=    Submit order With Installment Payment Pending KTC    ${installment_plan}

    Log to console      ${order_id}
    Close All Browsers
    Login Pcms
    Orders - Update Order Expired    ${order_id}
    Orders - Clear Expired Order
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    expired

    Log to console      ${Customer_ref_id}
    Point - Verify Ref Transaction Data In DB    ${Customer_ref_id}    ${order_id}    ${has_data}
    Point - Verify Point And Status From Return Point In DB    ${Customer_ref_id}    ${order_id}    ${merchant_id}    ${partner_id_trueyou}    ${point}    ${status}

TC_ITMWM_05607 Multiple items - Installment - To verify that system return Trueyou point after create order with Trueyou point and payment status = expired.
    [Tags]    regression     ready    TC_ITMWM_05607
    [Teardown]    close all browsers
    ${point}=    Set Variable    1
    ${has_data}=    Set Variable    1
    ${status}=    Set Variable    done
    ${expected_point_discount}=    Set Variable    0.1

    LOGIN PCMS
    Go To Edit Payment Channel Page    ${default_inventoryID}
    Set ktc Installment Payment

    ${Customer_ref_id}=     Guest add multiple products until checkout3    ${email}    ${default_inventoryID}    ${default_inventoryID}
    Point - Verify Point Redeem Tab is Shown
    Point - Click on Redeem Point Tab
    Point - Choose Trueyou channel
    Point - Input Trueyou Account     ${trueyou_user}    ${trueyou_pass}
    Point - Choose Discount and Click Next
    Point - Verify Point and Discount are displayed     ${point}     ${expected_point_discount}

    # installment
    ${order_id}=    Submit order With Installment Payment Pending KTC    ${installment_plan}

    Close All Browsers
    Login Pcms
    Orders - Update Order Expired    ${order_id}
    Orders - Clear Expired Order
    ${order_shipment_data}=    TrackOrder - Get Order Shipment id    ${order_id}
    TrackOrder - Check Payment Status on DB    ${order_shipment_data[0][0]}    expired

    Point - Verify Ref Transaction Data In DB    ${Customer_ref_id}    ${order_id}    ${has_data}
    Point - Verify Point And Status From Return Point In DB    ${Customer_ref_id}    ${order_id}    ${merchant_id}    ${partner_id_trueyou}    ${point}    ${status}
