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
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/ThankYou_Page/Keywords_ThankYouPage.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Create_Product/Create_Product/Create_Product.robot    #Resource    ${CURDIR}/../../Keyword/Portal/iTrueMart/ThankYou_Page/Keywords_ThankYouPage_mobile.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Mini Cart/Keywords_MiniCart.robot
Resource          ${CURDIR}/../../Keyword/Database/PCMS/Orders/keywords_orders.robot
Resource          ../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Level_d_page/keywords_leveld_mobile.robot
Resource          ../../Keyword/Mobile/Mobile_iTrueMart/Mobile_checkout_1/keywords_checkout1_mobile.robot
Resource          ../../Keyword/Mobile/Mobile_iTrueMart/Mobile_checkout_2/keywords_checkout2_mobile.robot
Resource          ../../Keyword/Mobile/Mobile_iTrueMart/Mobile_checkout_3/keywords_checkout3_mobile.robot
Force Tags      Point_Redeem

*** Variable ***
${email}          Tureyou_point@test.com
${pcms_email}     admin@domain.com
${pcms_password}    12345
${trueyou_user}    runoinar@gmail.com
${trueyou_pass}    75103598
${inventoryID}    INAAC1113711
${inventoryID_Toey}    SAAAB1129211
${inventoryID_Cing}    SAAAB1129211
${inventoryID_Tam}    SAAAB1129211
${inventoryID_Tam_2}    MOAAD1111311
${inventoryID_Feel}    SAAAB1129211
${inventoryID_BEEEEEE}    SAAAB1129211
${inventoryID_Rut}    SAAAB1129211
${inventoryID_Rut2}    MOAAD1111311
${inventoryID_Men}    SAAAB1129211
${inventoryID_Men2}    MOAAD1111311
${inventoryID_Men3}    BEAAB1114111
${special_price_for_shipping_fee}    299
${normal_price_for_shipping_fee}    300
${Text_Email}     thor_robot@mail.com
${Text_Name}      thor_robot
${Text_Phone}     0900000000
${Text_Address}    addr 1234

*** Test Cases ***
TC_ITMWM_01382 Mobile - Mutiple Normal with point : amount > boundary
    [Tags]    regression    TC_ITMWM_01382    ready
    ${point}=    Set Variable    1
    Set Price From Inventory THOR    ${inventoryID_Cing}    500    800
    Add To Cart For Mobile    ${inventoryID_Cing}    2
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee For Mobile    0
    ${expected_point_discount}=    Apply Point For Mobile    ${point}
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee For Mobile    0
    ${order_id}=    Checkout 3 - Create Order For Mobile CCW
    Sleep    5s
    Display Summary Shipping Price On Thankyou As Free
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${customer_ref_id}=    Get Customer Ref Id Data    ${order_id}
    Point - Verify Point in DB - Cart Table    ${customer_ref_id[0]}    ${point}    ${expected_point_discount}    trueyou
    Verify Shipping Fee in DB - Order Table    ${order_id}    0
    Open PCMS And Sync Order Together
    Verify Shipping Fee in DB - Together Order DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_01385 Mobile - Mutiple Normal with point : amount < boundary
    [Tags]    regression    TC_ITMWM_01385    ready
    ${point}=    Set Variable    1
    Set Price From Inventory THOR    ${inventoryID_Cing}    100    200
    Add To Cart For Mobile    ${inventoryID_Cing}    2
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee For Mobile    45.00
    ${expected_point_discount}=    Apply Point For Mobile    ${point}    0.1
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee For Mobile    45.00
    ${order_id}=    Checkout 3 - Create Order For Mobile CCW
    Sleep    5s
    Display Summary Shipping Price On Thankyou As Not Free
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${customer_ref_id}=    Get Customer Ref Id Data    ${order_id}
    Point - Verify Point in DB - Cart Table    ${customer_ref_id[0]}    ${point}    ${expected_point_discount}    trueyou
    Verify Shipping Fee in DB - Order Table    ${order_id}    45
    Open PCMS And Sync Order Together
    Verify Shipping Fee in DB - Together Order DB    ${order_id}    45
    [Teardown]    Close All Browsers

TC_ITMWM_01379 Mobile - Normal with point : amount = boundary
    [Tags]    regression    TC_ITMWM_01379
    ${special_price}=    Set Variable    300
    ${normal_price}=    Set Variable    349
    Set Price From Inventory THOR    ${inventoryID_Toey}    ${special_price}    ${normal_price}
    ${point}=    Set Variable    10
    Add To Cart For Mobile    ${inventoryID_Toey}    1
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee For Mobile    0
    ${expected_point_discount}=    Apply Point For Mobile    ${point}
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee For Mobile    0
    ${order_id}=    Checkout 3 - Create Order For Mobile CCW
    Sleep    5s
    Display Summary Shipping Price On Thankyou As Free
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${customer_ref_id}=    Get Customer Ref Id Data    ${order_id}
    Point - Verify Point in DB - Cart Table    ${customer_ref_id[0]}    ${point}    ${expected_point_discount}    trueyou
    Verify Shipping Fee in DB - Order Table    ${order_id}    0
    Open PCMS And Sync Order Together
    Verify Shipping Fee in DB - Together Order DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_01388 Mobile - Mutiple Normal : amount < boundary
    [Tags]    regression    TC_ITMWM_01388
    ${special_price}=    Set Variable    100
    ${normal_price}=    Set Variable    350
    Set Price From Inventory THOR    ${inventoryID_Toey}    ${special_price}    ${normal_price}
    Add To Cart For Mobile    ${inventoryID_Toey}    2
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee For Mobile    45.00
    ${order_id}=    Checkout 3 - Create Order For Mobile CCW
    Sleep    5s
    Display Summary Shipping Price On Thankyou As Not Free
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${customer_ref_id}=    Get Customer Ref Id Data    ${order_id}
    Point - Verify Point in DB is None - Cart Table    ${customer_ref_id[0]}
    Verify Shipping Fee in DB - Order Table    ${order_id}    45
    Open PCMS And Sync Order Together
    Verify Shipping Fee in DB - Together Order DB    ${order_id}    45
    [Teardown]    Close All Browsers

TC_ITMWM_01384 Mobile - Mutiple Normal with point : amount < boundary
    [Tags]    regression    TC_ITMWM_01384    ready
    ${point}=    Set Variable    10
    Set Price From Inventory THOR    ${inventoryID_Men3}    150    200
    Set Price From Inventory THOR    ${inventoryID_Men2}    149    200
    ${inventoryID} =    Create List    ${inventoryID_Men3}    ${inventoryID_Men2}
    Add To Cart Multi Inventory For Mobile    ${inventoryID}
    Mobile - Wait Until Ajax Loading Is Not Visible
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee For Mobile    0
    Mobile - Wait Until Ajax Loading Is Not Visible
    ${expected_point_discount}=    Apply Point For Mobile    ${point}    0.1
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee For Mobile    45.00
    ${order_id}=    Checkout 3 - Create Order For Mobile CCW
    Sleep    5s
    Display Summary Shipping Price On Thankyou As Not Free
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${customer_ref_id}=    Get Customer Ref Id Data    ${order_id}
    Point - Verify Point in DB - Cart Table    ${customer_ref_id[0]}    ${point}    ${expected_point_discount}    trueyou
    Verify Shipping Fee in DB - Order Table    ${order_id}    45
    Open PCMS And Sync Order Together
    Verify Shipping Fee in DB - Together Order DB    ${order_id}    45
    [Teardown]    Close All Browsers

TC_ITMWM_01387 Mobile - Mutiple Normal : amount = boundary
    [Tags]    regression    TC_ITMWM_01387    ready
    ${point}=    Set Variable    10
    Set Price From Inventory THOR    ${inventoryID_Men3}    150    200
    Set Price From Inventory THOR    ${inventoryID_Men2}    149    200
    ${inventoryID} =    Create List    ${inventoryID_Men3}    ${inventoryID_Men2}
    Add To Cart Multi Inventory For Mobile    ${inventoryID}
    Mobile - Wait Until Ajax Loading Is Not Visible
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee For Mobile    0
    ${order_id}=    Checkout 3 - Create Order For Mobile CCW
    Sleep    5s
    Display Summary Shipping Price On Thankyou As Free
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${customer_ref_id}=    Get Customer Ref Id Data    ${order_id}
    Verify Shipping Fee in DB - Order Table    ${order_id}    0
    Open PCMS And Sync Order Together
    Verify Shipping Fee in DB - Together Order DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_01381 Mobile - Normal with point : amount < boundary
    [Tags]    regression    TC_ITMWM_01381
    ${special_price}=    Set Variable    100
    ${normal_price}=    Set Variable    349
    Set Price From Inventory THOR    ${inventoryID_Feel}    ${special_price}    ${normal_price}
    ${point}=    Set Variable    10
    Add To Cart For Mobile    ${inventoryID_Feel}    1
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee For Mobile    45.00
    ${expected_point_discount}=    Apply Point For Mobile    ${point}
    ${order_id}=    Checkout 3 - Create Order For Mobile CCW
    Sleep    5s
    Display Summary Shipping Price On Thankyou As Not Free
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${customer_ref_id}=    Get Customer Ref Id Data    ${order_id}
    Point - Verify Point in DB - Cart Table    ${customer_ref_id[0]}    ${point}    ${expected_point_discount}    trueyou
    Verify Shipping Fee in DB - Order Table    ${order_id}    45
    Open PCMS And Sync Order Together
    Verify Shipping Fee in DB - Together Order DB    ${order_id}    45
    [Teardown]    Close All Browsers

TC_ITMWM_01380 Mobile - Normal with point : before use point amount > boundary after use point amount < boundary
    [Tags]    regression    TC_ITMWM_01380    ready    bee
    Set Price From Inventory THOR    ${inventoryID_BEEEEEE}    ${special_price_for_shipping_fee}    ${normal_price_for_shipping_fee}
    Add To Cart For Mobile    ${inventoryID_BEEEEEE}    1
    Mobile - Wait Until Ajax Loading Is Not Visible
    Display Full Cart And Verify Shipping Fee For Mobile As Free
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee For Mobile
    Mobile - Wait Until Ajax Loading Is Not Visible
    ${order_id}=    Checkout 3 - Create Order For Mobile CCW
    Sleep    5s
    Display Summary Shipping Price On Thankyou As Free
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    Verify Shipping Fee in DB - Order Table    ${order_id}    0
    Open PCMS And Sync Order Together
    Verify Shipping Fee in DB - Together Order DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_01378 Mobile - Normal with point : amount > boundary
    [Tags]    regression    TC_ITMWM_01378    ready
    ${point}=    Set Variable    10
    ${special_price_for_shipping_fee}=    Set Variable    500
    ${normal_price_for_shipping_fee}=    Set Variable    600
    Set Price From Inventory THOR    ${inventoryID_Rut}    ${special_price_for_shipping_fee}    ${normal_price_for_shipping_fee}
    ${point}=    Set Variable    10
    Add To Cart For Mobile    ${inventoryID_Rut}    1
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee For Mobile    0
    ${expected_point_discount}=    Apply Point For Mobile    ${point}
    ${order_id}=    Checkout 3 - Create Order For Mobile CCW
    Sleep    5s
    Display Summary Shipping Price On Thankyou As Free
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${customer_ref_id}=    Get Customer Ref Id Data    ${order_id}
    Point - Verify Point in DB - Cart Table    ${customer_ref_id[0]}    ${point}    ${expected_point_discount}    trueyou
    Verify Shipping Fee in DB - Order Table    ${order_id}    0
    Open PCMS And Sync Order Together
    Verify Shipping Fee in DB - Together Order DB    ${order_id}    0

TC_ITMWM_01383 - Mobile - Mutiple Normal with point : amount = boundary
    [Tags]    regression    TC_ITMWM_01383    ready
    ${point}=    Set Variable    10
    ${special_price_for_shipping_fee}=    Set Variable    150
    ${normal_price_for_shipping_fee}=    Set Variable    250
    Set Price From Inventory THOR    ${inventoryID_Tam}    ${special_price_for_shipping_fee}    ${normal_price_for_shipping_fee}
    Add To Cart For Mobile    ${inventoryID_Tam}    2
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee For Mobile    0
    ${expected_point_discount}=    Apply Point For Mobile    ${point}
    Display Full Cart And Verify Shipping Fee For Mobile As Free
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee For Mobile    0
    ${order_id}=    Checkout 3 - Create Order For Mobile CCW
    Display Summary Shipping Price On Thankyou As Free
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${customer_ref_id}=    Get Customer Ref Id Data    ${order_id}
    Point - Verify Point in DB - Cart Table    ${customer_ref_id[0]}    ${point}    ${expected_point_discount}    trueyou
    Verify Shipping Fee in DB - Order Table    ${order_id}    0
    Open PCMS And Sync Order Together
    Verify Shipping Fee in DB - Together Order DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_01386 Mobile - Normal : amount > boundary
    [Tags]    regression    TC_ITMWM_01386    ready
    ${point}=    Set Variable    10
    ${special_price_for_shipping_fee}=    Set Variable    300
    ${normal_price_for_shipping_fee}=    Set Variable    450
    Set Price From Inventory THOR    ${inventoryID_Tam_2}    ${special_price_for_shipping_fee}    ${normal_price_for_shipping_fee}
    Add To Cart For Mobile    ${inventoryID_Tam_2}    1
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee For Mobile    0
    ${order_id}=    Checkout 3 - Create Order For Mobile CCW
    Display Summary Shipping Price On Thankyou As Free
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${customer_ref_id}=    Get Customer Ref Id Data    ${order_id}
    Verify Shipping Fee in DB - Order Table    ${order_id}    0
    Open PCMS And Sync Order Together
    Verify Shipping Fee in DB - Together Order DB    ${order_id}    0
    [Teardown]    Close All Browsers
