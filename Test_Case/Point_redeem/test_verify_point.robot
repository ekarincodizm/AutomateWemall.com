*** Settings ***
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
Resource          ${CURDIR}/../../Keyword/API/FMS/FMS_ORDER.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/Order_together/keywords_order_together.robot
Resource          ${CURDIR}/../../Keyword/Features/User_login/User_login.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Cart/keywords_cart.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/ThankYou_Page/Keywords_ThankYouPage.robot


*** Variable ***
${TrueID}        robotautomate01@gmail.com
${TruePWD}       true1234
${inv_id}        CIAAA1111711
${pcms_email}     admin@domain.com
${pcms_password}    12345
${trueyou_user}    j_atthapon@hotmail.com
${trueyou_pass}    99999999
${inventoryID}    INAAC1112611
${ref}    21956309

*** Test Cases ***
Test
    [Tags]    test
    Point - Verify Point in DB - Cart Table    13912046    1.00    2.00    3

Test 2
    [Tags]    test2
    ${rs2}=    Member Buy Product Until Checkout3     ${TrueID}    ${TruePWD}    ${ref}    ${inv_id}

    ${point}=    Set Variable    1
    ${rate}=    Create List    0.1    1
    ${expected_point_discount}=     Point - Calculate Point Discount    @{rate}

    Point - Verify Point Redeem Tab is Shown
    Point - Click on Redeem Point Tab
    Point - Choose Trueyou channel
    Point - Input Trueyou Account     ${trueyou_user}    ${trueyou_pass}
    Point - Choose Discount and Click Next
    Point - Verify Point and Discount are displayed     ${point}     ${expected_point_discount}

    Verify Total Discount on Mini Cart    0.1

Test 2
    [Tags]    test3
    Open Browser   https://www.wemall-dev.com/checkout/thank-you?method=CCW&order_id=100020578&code=TEWhdgiIerfib6yBmm-iESo2aPm-Gpk8GseeiIqpGVDjuYDCinBX-MVwc7_woKXiIBQh5-Lq4dETbi0s8imJqA     Chrome
    Verify discount on thank you page    0.00