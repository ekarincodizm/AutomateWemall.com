*** Settings ***
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/Features/Create_Order/Create_order.txt
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Track_Order/Keywords_TrackOrder.robot
Resource          ${CURDIR}/../../../Keyword/API/common/api_keywords.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Product/update_stock.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Item_status/update_item_status.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Features/Create_Order/WebElement_order.robot
Resource          ${CURDIR}/../../../Keyword/Features/point_redeemtion/apply_point.robot
Resource          ${CURDIR}/../../../Keyword/Features/point_redeemtion/WebElement_apply_point.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Cart\keywords_cart.robot


*** Variable ***
${email}    Tureyou_point@test.com
${pcms_email}     admin@domain.com
${pcms_password}    12345
${trueyou_user}    runoinar@gmail.com
${trueyou_pass}    75103598
${inventoryID}    INAAC1112611
${campaign_name}=    Set Variable    Poin-test-campaign

${show_point_redemption_log}        1
${not_show_point_redemption_log}    0

${merchant_id}    1
${partner_id_trueyou}    1

*** Test Cases ***
TC_ITMWM_05597 : To verify that system show all data but does not display additional discount on point redemption log if customer buy single product in default rate and use point
    [Tags]    TC_ITMWM_05597    TEST
    ${point}=    Set Variable    1
    ${partner}=    Set Variable    TrueYou
    ${normal_discount}=    Set Variable    0.10
    ${additional_discount}=    Set Variable    0
    ${total_discount}=     Set Variable    0.10
    ${expected_point_discount}=    Set Variable    0.1

    Guest Buy Product Until Checkout3 Thor    ${email}    ${inventoryID}
    Point - Verify Point Redeem Tab is Shown
    Point - Click on Redeem Point Tab
    Point - Choose Trueyou channel
    Point - Input Trueyou Account     ${trueyou_user}    ${trueyou_pass}
    Point - Choose Discount and Click Next
    Point - Verify Point and Discount are displayed     ${point}     ${expected_point_discount}
    ${order_id}=    Checkout 3 - Create Order CCW

    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    Track Order - Check Point Redemption Log    ${show_point_redemption_log}
    Track Order - Verify Point Redemption Log   ${partner}     ${point}    ${normal_discount}     ${additional_discount}   ${total_discount}

    [Teardown]    Close all browsers

TC_ITMWM_01459 : To verify that system display all data in point redemption log when customer buy product but payment unsuccessfully
    [Tags]    TC_ITMWM_01459
    ${point}=    Set Variable    1
    ${partner}=    Set Variable    TrueYou
    ${normal_discount}=    Set Variable    0.10
    ${additional_discount}=    Set Variable    0
    ${total_discount}=     Set Variable    0.10
    ${expected_point_discount}=    Set Variable    0.1

    ${Customer_ref_id}=     Guest add multiple products until checkout3    ${email}    ${default_inventoryID}    ${default_inventoryID}
    Point - Verify Point Redeem Tab is Shown
    Point - Click on Redeem Point Tab
    Point - Choose Trueyou channel
    Point - Input Trueyou Account     ${trueyou_user}    ${trueyou_pass}
    Point - Choose Discount and Click Next
    Point - Verify Point and Discount are displayed     ${point}     ${expected_point_discount}
    ${order_id}=    Submit order With CCW Payment Failed

    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    Track Order - Check Point Redemption Log    ${show_point_redemption_log}
    Track Order - Verify Point Redemption Log   ${partner}     ${point}    ${normal_discount}     ${additional_discount}   ${total_discount}

    [Teardown]    Close all browsers

TC_ITMWM_01458 To verify that system display point redemption log and show discount from campaign rate correctly when customer buy multiple product in campaign rate
    [Tags]    TC_ITMWM_01458    TEST
    ${point}=    Set Variable    1
    ${ratio}=    Set Variable    0.50
    ${partner}=    Set Variable    TrueYou
    ${normal_discount}=    Set Variable    0.10
    ${additional_discount}=    Set Variable    0.40
    ${total_discount}=     Set Variable    0.50
    ${expected_point_discount}=    Set Variable    0.50

    ${campaign_id}=    Point - Perpare Point Campaign Rate       ${default_inventoryID}        ${ratio}

    ${Customer_ref_id}=     Guest add multiple products until checkout3    ${email}    ${default_inventoryID}    ${default_inventoryID}
    Point - Verify Point Redeem Tab is Shown
    Point - Click on Redeem Point Tab
    Point - Choose Trueyou channel
    Point - Input Trueyou Account     ${trueyou_user}    ${trueyou_pass}
    Point - Choose Discount and Click Next
    Point - Verify Point and Discount are displayed     ${point}     ${expected_point_discount}
    ${order_id}=    Checkout 3 - Create Order CCW
    Log To console  ${order_id}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    TrackOrder - Go To Order Detail Page    ${order_id}
    Track Order - Check Point Redemption Log    ${show_point_redemption_log}
    Track Order - Verify Point Redemption Log   ${partner}     ${point}    ${normal_discount}     ${additional_discount}   ${total_discount}

    Point - Delete Point Campaign       ${campaign_id}
    Point - Delete Point Campaign Key   ${campaign_id}
    [Teardown]        Close all browsers

