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
Resource          ${CURDIR}/../../Keyword/API/PCMS/Create_Product/Create_Product/Create_Product.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Mini Cart/Keywords_MiniCart.robot
Resource          ${CURDIR}/../../Keyword/Database/PCMS/Orders/keywords_orders.robot
Resource          ../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Level_d_page/keywords_leveld_mobile.robot
Force Tags      Point_Redeem

*** Variable ***
${email}          Tureyou_point@test.com
${pcms_email}     admin@domain.com
${pcms_password}    12345
${trueyou_user}    runoinar@gmail.com
${trueyou_pass}    75103598
${inventoryID}    INAAC1113711
${inventoryID_Toey}    INAAC1113711
${inventoryID_Cing}    INAAC1113711
${inventoryID_Tam}    INAAC1113711
${inventoryID_Tam_2}    GAAAA1114511
${inventoryID_Feel}    INAAC1113711
${inventoryID_BEEEEEE}    INAAC1113711
${inventoryID_Rut}    INAAC1113711
${inventoryID_Rut2}    GAAAA1114511
${inventoryID_Men}    INAAC1113711
${inventoryID_Men2}    GAAAA1114511
${inventoryID_Men3}    PAAAA1112911
${special_price_for_shipping_fee}    299
${normal_price_for_shipping_fee}    300
${Text_Email}     thor_robot@mail.com
${Text_Name}      thor_robot
${Text_Phone}     0900000000
${Text_Address}    addr 1234

*** Test Cases ***
TC_ITMWM_01368 Mutiple Normal with point : amount > boundary
    [Tags]    regression    TC_ITMWM_01368    ready
    ${point}=    Set Variable    1
    Set Price From Inventory THOR    ${inventoryID_Cing}    500    800
    Add To Cart    ${inventoryID_Cing}    2
    Display Full Cart And Verify Shipping Fee As Free
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee    0    0
    ${expected_point_discount}=    Apply Point    ${point}    0.1
    Display Full Cart And Verify Shipping Fee As Free
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee    0    1
    ${order_id}=    Checkout 3 - Create Order CCW
    Display Summary Shipping Price On Thankyou As Free
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${customer_ref_id}=    Get Customer Ref Id Data    ${order_id}
    Point - Verify Point in DB - Cart Table    ${customer_ref_id[0]}    ${point}    ${expected_point_discount}    trueyou
    Verify Shipping Fee in DB - Order Table    ${order_id}    0
    Open PCMS And Sync Order Together
    Verify Shipping Fee in DB - Together Order DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_01375 Mutiple Normal : amount > boundary
    [Tags]    regression    TC_ITMWM_01375    ready
    ${point}=    Set Variable    1
    Set Price From Inventory THOR    ${inventoryID_Cing}    500    800
    Add To Cart    ${inventoryID_Cing}    2
    Display Full Cart And Verify Shipping Fee As Free
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee    0    1
    ${order_id}=    Checkout 3 - Create Order CCW
    Display Summary Shipping Price On Thankyou As Free
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${customer_ref_id}=    Get Customer Ref Id Data    ${order_id}
    Verify Shipping Fee in DB - Order Table    ${order_id}    0
    Open PCMS And Sync Order Together
    Verify Shipping Fee in DB - Together Order DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_01365 Normal with point : amount = boundary
    [Tags]    regression    TC_ITMWM_01365
    ${special_price}=    Set Variable    300
    ${normal_price}=    Set Variable    349
    Set Price From Inventory THOR    ${inventoryID_Toey}    ${special_price}    ${normal_price}
    ${point}=    Set Variable    10
    Add To Cart    ${inventoryID_Toey}    1
    Display Full Cart And Verify Shipping Fee As Free
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee    0    0
    ${expected_point_discount}=    Apply Point    ${point}
    Display Full Cart And Verify Shipping Fee As Free
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee    0    1
    ${order_id}=    Checkout 3 - Create Order CCW
    Display Summary Shipping Price On Thankyou As Free
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${customer_ref_id}=    Get Customer Ref Id Data    ${order_id}
    Point - Verify Point in DB - Cart Table    ${customer_ref_id[0]}    ${point}    ${expected_point_discount}    trueyou
    Verify Shipping Fee in DB - Order Table    ${order_id}    0
    Open PCMS And Sync Order Together
    Verify Shipping Fee in DB - Together Order DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_01372 Normal : amount > boundary
    [Tags]    regression    TC_ITMWM_01372
    ${special_price}=    Set Variable    300
    ${normal_price}=    Set Variable    349
    Set Price From Inventory THOR    ${inventoryID_Toey}    ${special_price}    ${normal_price}
    Add To Cart    ${inventoryID_Toey}    1
    Display Full Cart And Verify Shipping Fee As Free
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee    0    0
    Display Full Cart And Verify Shipping Fee As Free
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee    0    1
    ${order_id}=    Checkout 3 - Create Order CCW
    Display Summary Shipping Price On Thankyou As Free
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${customer_ref_id}=    Get Customer Ref Id Data    ${order_id}
    Point - Verify Point in DB is None - Cart Table    ${customer_ref_id[0]}
    Verify Shipping Fee in DB - Order Table    ${order_id}    0
    Open PCMS And Sync Order Together
    Verify Shipping Fee in DB - Together Order DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_01367 Normal with point : before use point amount < boundary after use point amount < boundary
    [Tags]    regression    TC_ITMWM_01367    feel
    ${special_price}=    Set Variable    299
    ${normal_price}=    Set Variable    3499
    ${point}=    Set Variable    10
    Set Price From Inventory THOR    ${inventoryID_Feel}    ${special_price}    ${normal_price}
    Add To Cart    ${inventoryID_Feel}    1
    Display Full Cart And Verify Shipping Fee As Free
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee    0    0
    ${expected_point_discount}=    Apply Point    ${point}
    Display Full Cart And Verify Shipping Fee Not Free
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee    45.00    1
    ${order_id}=    Checkout 3 - Create Order CCW
    Display Summary Shipping Price On Thankyou As    45
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${customer_ref_id}=    Get Customer Ref Id Data    ${order_id}
    Point - Verify Point in DB - Cart Table    ${customer_ref_id[0]}    ${point}    ${expected_point_discount}    trueyou
    Verify Shipping Fee in DB - Order Table    ${order_id}    45
    Open PCMS And Sync Order Together
    Verify Shipping Fee in DB - Together Order DB    ${order_id}    45
    [Teardown]    Close All Browsers

TC_ITMWM_01374 [Normal : amount < boundary] - To verify that system display and calculate shipping fee correctly.
    [Tags]    regression    TC_ITMWM_01374    feel
    ${special_price}=    Set Variable    222
    ${normal_price}=    Set Variable    349
    Set Price From Inventory THOR    ${inventoryID_Feel}    ${special_price}    ${normal_price}
    Add To Cart    ${inventoryID_Feel}    1
    Display Full Cart And Verify Shipping Fee Not Free
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee    45.00    0
    Display Full Cart And Verify Shipping Fee Not Free
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee    45.00    1
    ${order_id}=    Checkout 3 - Create Order CCW
    Display Summary Shipping Price On Thankyou As Not Free
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${customer_ref_id}=    Get Customer Ref Id Data    ${order_id}
    Point - Verify Point in DB is None - Cart Table    ${customer_ref_id[0]}
    Verify Shipping Fee in DB - Order Table    ${order_id}    45
    Open PCMS And Sync Order Together
    Verify Shipping Fee in DB - Together Order DB    ${order_id}    45
    [Teardown]    Close All Browsers

TC_ITMWM_01370 Mutiple Normal with point : amount < boundary
    [Tags]    regression    TC_ITMWM_01370    ready
    Set Price From Inventory THOR    ${inventoryID_Men3}    150    200
    Set Price From Inventory THOR    ${inventoryID_Men2}    149    200
    ${point}=    Set Variable    10
    ${inventoryID} =    Create List    ${inventoryID_Men3}    ${inventoryID_Men2}
    Add To Cart Multi Inventory    ${inventoryID}
    Display Full Cart And Verify Shipping Fee As Free
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee    0    0
    ${expected_point_discount}=    Apply Point    ${point}    0.1
    Display Full Cart And Verify Shipping Fee Not Free
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee    45.00    1
    ${order_id}=    Checkout 3 - Create Order CCW
    Display Summary Shipping Price On Thankyou As Not Free
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${customer_ref_id}=    Get Customer Ref Id Data    ${order_id}
    Point - Verify Point in DB - Cart Table    ${customer_ref_id[0]}    ${point}    ${expected_point_discount}    trueyou
    Verify Shipping Fee in DB - Order Table    ${order_id}    45
    Open PCMS And Sync Order Together
    Verify Shipping Fee in DB - Together Order DB    ${order_id}    45
    [Teardown]    Close All Browsers

TC_ITMWM_01377 Mutiple Normal : amount < boundary
    [Tags]    regression    TC_ITMWM_01377    ready
    ${point}=    Set Variable    10
    Set Price From Inventory THOR    ${inventoryID_Men}    100    200
    Add To Cart    ${inventoryID_Men}    2
    Display Full Cart And Verify Shipping Fee Not Free
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee    45.00    1
    ${order_id}=    Checkout 3 - Create Order CCW
    Display Summary Shipping Price On Thankyou As Not Free
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${customer_ref_id}=    Get Customer Ref Id Data    ${order_id}
    Verify Shipping Fee in DB - Order Table    ${order_id}    45
    Open PCMS And Sync Order Together
    Verify Shipping Fee in DB - Together Order DB    ${order_id}    45
    [Teardown]    Close All Browsers

TC_ITMWM_01369 Normal with point : amount > boundary
    [Tags]    regression    TC_ITMWM_01369    ready    TAM
    ${point}=    Set Variable    10
    ${normal_price_for_shipping_fee}=    Set Variable    250
    ${special_price_for_shipping_fee}=    Set Variable    150
    Set Price From Inventory THOR    ${inventoryID_Tam}    ${special_price_for_shipping_fee}    ${normal_price_for_shipping_fee}
    Add To Cart    ${inventoryID_Tam}    3
    Display Full Cart And Verify Shipping Fee As Free
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee    0    0
    ${expected_point_discount}=    Apply Point    ${point}
    # Display Full Cart And Verify Shipping Fee As Free
    Display Full Cart And Verify Shipping Fee Not Free
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee    0    1
    ${order_id}=    Checkout 3 - Create Order CCW
    Display Summary Shipping Price On Thankyou As Free
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${customer_ref_id}=    Get Customer Ref Id Data    ${order_id}
    Point - Verify Point in DB - Cart Table    ${customer_ref_id[0]}    ${point}    ${expected_point_discount}    trueyou
    Verify Shipping Fee in DB - Order Table    ${order_id}    0
    Open PCMS And Sync Order Together
    Verify Shipping Fee in DB - Together Order DB    ${order_id}    0
    #[Teardown]    Close All Browsers

TC_ITMWM_01376 Mutiple Normal : amount = boundary
    [Tags]    regression    TC_ITMWM_01376    ready    TAM
    ${special_price_for_shipping_fee_1}=    Set Variable    150
    ${normal_price_for_shipping_fee_1}=    Set Variable    250
    ${special_price_for_shipping_fee_2}=    Set Variable    149
    ${normal_price_for_shipping_fee_2}=    Set Variable    250
    Set Price From Inventory THOR    ${inventoryID_Tam}    ${special_price_for_shipping_fee_1}    ${normal_price_for_shipping_fee_1}
    Set Price From Inventory THOR    ${inventoryID_Tam_2}    ${special_price_for_shipping_fee_2}    ${normal_price_for_shipping_fee_2}
    ${inventoryID} =    Create List    ${inventoryID_Tam}    ${inventoryID_Tam_2}
    Add To Cart Multi Inventory    ${inventoryID}
    Display Full Cart And Verify Shipping Fee As Free
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee    0    1
    ${order_id}=    Checkout 3 - Create Order CCW
    Display Summary Shipping Price On Thankyou As Free
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${customer_ref_id}=    Get Customer Ref Id Data    ${order_id}
    #    Point - Verify Point in DB - Cart Table    ${customer_ref_id[0]}    ${point}    ${expected_point_discount}    trueyou
    Verify Shipping Fee in DB - Order Table    ${order_id}    0
    Open PCMS And Sync Order Together
    Verify Shipping Fee in DB - Together Order DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_01366 Normal with point : before use point amount > boundary after use point amount < boundary
    [Tags]    regression    TC_ITMWM_01366    ready    bee
    ${point}=    Set Variable    10
    Set Price From Inventory THOR    ${inventoryID_BEEEEEE}    ${special_price_for_shipping_fee}    ${normal_price_for_shipping_fee}
    Add To Cart    ${inventoryID_BEEEEEE}    1
    Display Full Cart And Verify Shipping Fee As Free
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee    0    0
    ${expected_point_discount}=    Apply Point    ${point}
    Display Full Cart And Verify Shipping Fee Not Free
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee    45.00    1
    ${order_id}=    Checkout 3 - Create Order CCW
    Display Summary Shipping Price On Thankyou As    45.00
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${customer_ref_id}=    Get Customer Ref Id Data    ${order_id}
    Point - Verify Point in DB - Cart Table    ${customer_ref_id[0]}    ${point}    ${expected_point_discount}    trueyou
    Verify Shipping Fee in DB - Order Table    ${order_id}    45
    Open PCMS And Sync Order Together
    Verify Shipping Fee in DB - Together Order DB    ${order_id}    45
    [Teardown]    Close All Browsers

TC_ITMWM_01373 [Normal : amount = boundary] - To verify that system display and calculate shipping fee correctly.
    [Tags]    regression    TC_ITMWM_01373    ready    bee
    Set Price From Inventory THOR    ${inventoryID_BEEEEEE}    ${special_price_for_shipping_fee}    ${normal_price_for_shipping_fee}
    Add To Cart    ${inventoryID_BEEEEEE}    1
    Display Full Cart And Verify Shipping Fee As Free
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee    0    1
    ${order_id}=    Checkout 3 - Create Order CCW
    Display Summary Shipping Price On Thankyou As Free
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${customer_ref_id}=    Get Customer Ref Id Data    ${order_id}
    Verify Shipping Fee in DB - Order Table    ${order_id}    0
    Open PCMS And Sync Order Together
    Verify Shipping Fee in DB - Together Order DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_01364 Normal with point : amount > boundary
    [Tags]    regression    TC_ITMWM_01364    ready
    ${point}=    Set Variable    10
    ${special_price_for_shipping_fee}=    Set Variable    500
    ${normal_price_for_shipping_fee}=    Set Variable    600
    Set Price From Inventory THOR    ${inventoryID_Rut}    ${special_price_for_shipping_fee}    ${normal_price_for_shipping_fee}
    Add To Cart    ${inventoryID_Rut}    1
    Verify Shipping Fee on Cart-light-box As Free    th
    Display Full Cart And Verify Shipping Fee As Free
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee    0    0
    ${expected_point_discount}=    Apply Point    ${point}
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee    0    1
    ${order_id}=    Checkout 3 - Create Order CCW
    Display Summary Shipping Price On Thankyou As Free
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${customer_ref_id}=    Get Customer Ref Id Data    ${order_id}
    Point - Verify Point in DB - Cart Table    ${customer_ref_id[0]}    ${point}    ${expected_point_discount}    trueyou
    Verify Shipping Fee in DB - Order Table    ${order_id}    0
    Open PCMS And Sync Order Together
    Verify Shipping Fee in DB - Together Order DB    ${order_id}    0
    [Teardown]    Close All Browsers

TC_ITMWM_01371 Mutiple Normal with point : amount < boundary
    [Tags]    regression    TC_ITMWM_01371    ready
    ${point}=    Set Variable    10
    ${special_price_for_shipping_fee_1}=    Set Variable    150
    ${normal_price_for_shipping_fee_1}=    Set Variable    500
    ${special_price_for_shipping_fee_2}=    Set Variable    149
    ${normal_price_for_shipping_fee_2}=    Set Variable    500
    Set Price From Inventory THOR    ${inventoryID_Rut}    ${special_price_for_shipping_fee_1}    ${normal_price_for_shipping_fee_1}
    Set Price From Inventory THOR    ${inventoryID_Rut2}    ${special_price_for_shipping_fee_2}    ${normal_price_for_shipping_fee_2}
    ${inventoryID} =    Create List    ${inventoryID_Rut}    ${inventoryID_Rut2}
    Add To Cart Multi Inventory    ${inventoryID}
    Display Full Cart And Verify Shipping Fee As Free
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee    0    0
    ${expected_point_discount}=    Apply Point    ${point}
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee    45.00    1
    ${order_id}=    Checkout 3 - Create Order CCW
    Display Summary Shipping Price On Thankyou As Not Free
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${customer_ref_id}=    Get Customer Ref Id Data    ${order_id}
    Point - Verify Point in DB - Cart Table    ${customer_ref_id[0]}    ${point}    ${expected_point_discount}    trueyou
    Verify Shipping Fee in DB - Order Table    ${order_id}    45
    Open PCMS And Sync Order Together
    Verify Shipping Fee in DB - Together Order DB    ${order_id}    45
    [Teardown]    Close All Browsers
