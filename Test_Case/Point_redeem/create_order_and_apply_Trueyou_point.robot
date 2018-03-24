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


*** Variable ***
${email}    Tureyou_point@test.com
${pcms_email}     admin@domain.com
${pcms_password}    12345
${trueyou_user}    runoinar@gmail.com
${trueyou_pass}    75103598
${inventoryID}    INAAC1112611

*** Test Cases ***
Test
    [Tags]    test
    ${num}=    Convert To Number    0.1
    ${test}=    testtest    ${num}    ${num}
    Log To Console    ${test}


Default ratio - Single item - CCW - Create order and apply Trueyou point by Guest
    [Tags]    TC_1

    ${ratio}=    Set Variable    0.1
    ${point}=    Set Variable    1
    ${rate}=    Create List    0.1    1
    ${expected_point_discount}=     Point - Calculate Point Discount    @{rate}
    Create Order - Apply point and Verify discount - Guest - CCW    ${email}    ${inventoryID}    ${trueyou_user}    ${trueyou_pass}    ${point}     ${expected_point_discount}
    [Teardown]     Close All Browsers

Default ratio - Single item - Installment - Create order and apply Trueyou point by Guest
    [Tags]    TC_2

    ${ratio}=    Set Variable    0.1
    ${point}=    Set Variable    1
    ${expected_point_discount}=     Point - Calculate Point Discount    ${ratio}    ${point}
    Create Order - Apply point and Verify discount - Guest - Installment    ${email}    ${inventoryID}    ${trueyou_user}    ${trueyou_pass}    ${point}     ${expected_point_discount}
    #[Teardown]     Close All Browsers

Default ratio - Single item - CS - Create order and apply Trueyou point by Guest
    [Tags]    TC_3

    ${ratio}=    Set Variable    0.1
    ${point}=    Set Variable    1
    ${expected_point_discount}=     Point - Calculate Point Discount    ${ratio}    ${point}
    ${order_id}=    Guest - Buy Product Until Checkout3   ${email}    ${inventoryID}
    Point - Verify Point Redeem Tab is Shown
    Point - Click on Redeem Point Tab
    Point - Choose Trueyou channel
    Point - Input Trueyou Account     ${trueyou_user}    ${trueyou_pass}
    Point - Choose Discount and Click Next
    Point - Verify Point and Discount are displayed     ${point}     ${expected_point_discount}
    Checkout3 - Select payment channal    ${Payment_Channal_CounterService}
    Point - Verify Message - Cannot use point via offline payment
    [Teardown]     Close All Browsers

Default ratio - Single item - COD - Create order and apply Trueyou point by Guest
    [Tags]    TC_4

    ${ratio}=    Set Variable    0.1
    ${point}=    Set Variable    1
    ${expected_point_discount}=     Point - Calculate Point Discount    ${ratio}    ${point}
    ${order_id}=    Guest - Buy Product Until Checkout3   ${email}    ${inventoryID}
    Point - Verify Point Redeem Tab is Shown
    Point - Click on Redeem Point Tab
    Point - Choose Trueyou channel
    Point - Input Trueyou Account     ${trueyou_user}    ${trueyou_pass}
    Point - Choose Discount and Click Next
    Point - Verify Point and Discount are displayed     ${point}     ${expected_point_discount}
    Checkout3 - Select payment channal    ${Payment_Channal_COD}
    Point - Verify Message - Cannot use point via offline payment
    [Teardown]     Close All Browsers