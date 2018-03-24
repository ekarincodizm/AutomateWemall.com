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
Resource          ${CURDIR}/../../Keyword/API/PCMS/Cart/keywords_cart.robot
Resource          ../../Keyword/Mobile/Mobile_iTrueMart/Mobile_checkout_1/keywords_checkout1_mobile.robot
Resource          ../../Keyword/Mobile/Mobile_iTrueMart/Mobile_checkout_2/keywords_checkout2_mobile.robot
Resource          ../../Keyword/Mobile/Mobile_iTrueMart/Mobile_checkout_3/keywords_checkout3_mobile.robot
Resource          ../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Full_cart/keywords_full_cart_mobile.robot
Force Tags      Point_Redeem

*** Variable ***
${email}          Tureyou_point@test.com
${pcms_email}     admin@domain.com
${pcms_password}    12345
${trueyou_user}    runoinar@gmail.com
${trueyou_pass}    75103598
${inventoryID}    OKAAA1112711
${inventoryID_Toey}    OKAAA1112711
${inventoryID_Cing}    OKAAA1112711
${inventoryID_Tam}    OKAAA1112711
${inventoryID_Tam_2}    OKAAA1112511
${inventoryID_Feel}    OKAAA1112711
${inventoryID_BEEEEEE}    OKAAA1112711
${inventoryID_Rut}    OKAAA1112711
${inventoryID_Rut2}    OKAAA1112511
${inventoryID_Men}    OKAAA1112711
${inventoryID_Men2}    OKAAA1112511
${inventoryID_Men3}    KIAAC1113211
${special_price_for_shipping_fee}    299
${normal_price_for_shipping_fee}    300
${Text_Email}     thor_robot@mail.com
${Text_Name}      thor_robot
${Text_Phone}     0900000000
${Text_Address}    addr 1234

*** Test Cases ***
TC_ITMWM_01410 [Mobile][Single item][CCW] To verify that after edited quantity point will be remove, point is removed on UI and stamped to DB correctly.
    [Tags]    regression    TC_ITMWM_01410    ready
    #--Cing
    Guest Buy Product Until Checkout3 Thor For Mobile    ${Text_Email}    ${inventoryID_Cing}
    ${point}=    Set Variable    10
    ${expected_point_discount}=    Apply Point For Mobile    ${point}
    ${customer_ref_id}=    Point - Get Customer ref id
    Point - Update Product Qty In Cart For Mobile    ${inventoryID_Cing}    2
    ${expected_point_discount}=    Apply Point For Mobile    ${point}
    ${point_discount}=    Point - Get Discount from Point
    Point - Verify Point in DB - Cart Table    ${customer_ref_id}    ${point}    ${expected_point_discount}    trueyou
    ${discount_after}=    Checkout3 - mini cart - Get All Discount Price For Mobile
    ${order_id}=    Checkout 3 - Create Order For Mobile CCW
    Verify discount on thank you page for mobile    ${discount_after}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Point - Verify Point in DB - Cart Table    ${customer_ref_id}    ${point}    ${expected_point_discount}    trueyou
    Verify Point Reference Id on Order DB Not None    ${order_id}
    Point - Verify Point in DB is Not None - Order Shipment Item Table    ${item_id[0]}
    [Teardown]    Close All Browsers

TC_ITMWM_01416 [Mobile][Multiple item][CCW] To verify that after removed item point will be remove, point is removed on UI and stamped to DB correctly.
    [Tags]    regression    TC_ITMWM_01416    ready
    ${inventoryID} =    Create List    ${inventoryID_Men3}    ${inventoryID_Men2}
    Guest Buy Multi Product Until Checkout3 Thor For Mobile    ${Text_Email}    ${inventoryID}
    ${point}=    Set Variable    10
    ${expected_point_discount}=    Apply Point For Mobile    ${point}
    ${customer_ref_id}=    Point - Get Customer ref id
    Click Element    //*[@id="form-payment"]/div[3]/h2/span/a
    Full Cart Mobile - Delete Specific Item in Cart    ${inventoryID_Men3}
    Click Element    //*[@id="proceed_to_checkout_button"]
    Point - Verify Point in DB is None - Cart Table    ${customer_ref_id}
    ${discount_after}=    Checkout3 - mini cart - Get All Discount Price For Mobile
    ${order_id}=    Checkout 3 - Create Order For Mobile CCW
    Verify discount on thank you page for mobile    ${discount_after}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${customer_ref_id}=    Get Customer Ref Id Data    ${order_id}
    Point - Verify Point in DB is None - Cart Table    ${customer_ref_id[0]}
    Verify Point Reference Id on Order DB None    ${order_id}
    Point - Verify Point in DB is None - Order Shipment Item Table    ${item_id[0]}
    #--Toey
    #--Feel
    [Teardown]    Close All Browsers

TC_ITMWM_01413 [Mobile][Single item][CCW] To verify that add new point after added item, the new point is shown on UI and stamped to DB correctly.
    [Tags]    regression    TC_ITMWM_01413    ready
    #1. Add 1 item to cart
    Guest Buy Product Until Checkout3 Thor For Mobile    ${Text_Email}    ${inventoryID_Feel}
    # 2. Add point on check out 3.
    ${point}=    Set Variable    1
    ${expected_point_discount_before}=    Apply Point For Mobile    ${point}
    # 3. Add 1 item to cart
    ${customer_ref_id}=    Point - Get Customer ref id
    Point - Update Product Qty In Cart For Mobile    ${inventoryID_Feel}    2
    # 4. Add new point (diff point) on check out 3.
    ${point_two}=    Set Variable    10
    ${discount_before}=    Checkout3 - mini cart - Get All Discount Price For Mobile
    ${expected_point_discount}=    Apply Point For Mobile    ${point_two}
    ${point_discount}=    Point - Get Discount from Point
    ${discount_after}=    Checkout3 - mini cart - Get All Discount Price For Mobile
    # 5. Go to check out 3 and then verify point
    Point - Verify Discount After Apply Point    ${discount_before}    ${discount_after}    ${point_discount}
    # 6. Verify db:cart.
    Point - Verify Point in DB - Cart Table    ${customer_ref_id}    ${point_two}    ${expected_point_discount}    trueyou
    # 7. Place order.
    ${discount_after}=    Checkout3 - mini cart - Get All Discount Price For Mobile
    ${order_id}=    Checkout 3 - Create Order For Mobile CCW
    # 8. Verify discount on thank you page.
    Verify discount on thank you page for mobile    ${discount_after}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Point - Verify Point in DB - Cart Table    ${customer_ref_id}    ${point_two}    ${expected_point_discount}    trueyou
    Verify Point Reference Id on Order DB Not None    ${order_id}
    Point - Verify Point in DB is Not None - Order Shipment Item Table    ${item_id[0]}
    Point - Verify Point in DB is Not None - Order Shipment Item Table    ${item_id[1]}
    #--P'Men
    [Teardown]    Close All Browsers

TC_ITMWM_01412 [Mobile][Single item][CCW] To verify that add new point after added item, the new point is shown on UI and stamped to DB correctly.
    [Tags]    regression    TC_ITMWM_01412    TC_49
    ${point}=    Set Variable    1
    Guest Buy Product Until Checkout3 Thor For Mobile    ${Text_Email}    ${inventoryID_Men2}
    ${customer_ref_id}=    Point - Get Customer ref id
    Apply Point For Mobile    ${point}
    Guest Buy Product Until Checkout3 Thor For Mobile    ${Text_Email}    ${inventoryID_Men3}    false
    # Point - Update Product Qty In Cart For Mobile    ${inventoryID_Men2}    2
    ${point}=    Set Variable    10
    ${discount_before}=    Checkout3 - mini cart - Get All Discount Price For Mobile
    ${expected_point_discount}=    Apply Point For Mobile    ${point}
    ${point_discount}=    Point - Get Discount from Point
    ${discount_after}=    Checkout3 - mini cart - Get All Discount Price For Mobile
    Point - Verify Discount After Apply Point    ${discount_before}    ${discount_after}    ${point_discount}
    Point - Verify Point in DB - Cart Table    ${customer_ref_id}    ${point}    ${expected_point_discount}    trueyou
    ${order_id}=    Checkout 3 - Create Order For Mobile CCW
    Verify discount on thank you page for mobile    ${discount_after}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Point - Verify Point in DB - Cart Table    ${customer_ref_id}    ${point}    ${expected_point_discount}    trueyou
    Verify Point Reference Id on Order DB Not None    ${order_id}
    Point - Verify Point in DB is Not None - Order Shipment Item Table    ${item_id[0]}
    Point - Verify Point in DB is Not None - Order Shipment Item Table    ${item_id[1]}
    #--Tam
    #--Rut
    [Teardown]    Close All Browsers

TC_ITMWM_01407 : [Mobile][Single item][CCW] To verify that after add point, point is shown on UI and stamped to DB correctly.
    [Tags]    regression    TC_ITMWM_01407    ready
    Add To Cart For Mobile    ${inventoryID_Rut}    1
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee For Mobile    0
    ${customer_ref_id}=    Point - Get Customer ref id
    ${sub_total_price}=    Checkout3 - mini cart - Get Sub Total Price For Mobile
    ${discount}=    Checkout3 - mini cart - Get All Discount Price For Mobile
    ${total_price}=    Checkout3 - mini cart - Get Total Price For Mobile
    ${point}=    Set Variable    10
    ${expected_point_discount}=    Apply Point For Mobile    ${point}
    Go To Checkout2 And Verify Discount For Mobile    ${sub_total_price}    ${discount}    ${expected_point_discount}
    Point - Verify Point in DB - Cart Table    ${customer_ref_id}    ${point}    ${expected_point_discount}    trueyou
    Checkout 2 Mobile - Click Next
    ${discount_after}=    Checkout3 - mini cart - Get All Discount Price For Mobile
    ${order_id}=    Checkout 3 - Create Order For Mobile CCW
    Verify discount on thank you page for mobile    ${discount_after}
    Verify Point Reference Id on Order DB Not None    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Point - Verify Point in DB is Not None - Order Shipment Item Table    ${item_id[0]}
    [Teardown]    Close All Browsers

TC_ITMWM_01419 [Mobile][Multiple item][CCW] To verify that add new point after removed item, the new point is shown on UI and stamped to DB correctly.
    [Tags]    regression    TC_ITMWM_01419    ready
    Add To Cart For Mobile    ${inventoryID_Rut}    2
    Go To Checkout1 Until Checkout3 And Verify Shipping Fee For Mobile    0
    Point - Update Product Qty In Cart For Mobile    ${inventoryID_Rut}    1
    ${point}=    Set Variable    10
    ${expected_point_discount}=    Apply Point For Mobile    ${point}
    ${customer_ref_id}=    Point - Get Customer ref id
    Point - Verify Point in DB - Cart Table    ${customer_ref_id}    ${point}    ${expected_point_discount}    trueyou
    ${discount_after}=    Checkout3 - mini cart - Get All Discount Price For Mobile
    ${order_id}=    Checkout 3 - Create Order For Mobile CCW
    Verify discount on thank you page for mobile    ${discount_after}
    Verify Point Reference Id on Order DB Not None    ${order_id}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Point - Verify Point in DB is Not None - Order Shipment Item Table    ${item_id[0]}
    #--Bee
    [Teardown]    Close All Browsers

TC_ITMWM_01409 [Mobile][Single item][CCW] To verify that after added item point will be remove, point is removed on UI and stamped to DB correctly.
    [Tags]    regression    TC_ITMWM_01409    ready    bee
    Set Price From Inventory THOR    ${inventoryID_BEEEEEE}    299    600
    Guest Buy Product Until Checkout3 Thor For Mobile    ${Text_Email}    ${inventoryID_BEEEEEE}
    ${point}=    Set Variable    10
    ${expected_point_discount}=    Apply Point For Mobile    ${point}
    Add To Cart For Mobile    ${inventoryID_BEEEEEE}    1    false
    Mobile - Wait Until Ajax Loading Is Not Visible
    Go To    ${ITM_MOBILE_URL}/checkout/step2
    Sleep    3
    ${total_discount}=    Get Text    jquery=#total_discount p
    Should Be Equal    ${total_discount}    0.00
    ${total_price}=    Checkout3 - mini cart - Get Sub Total Price For Mobile
    Should Be Equal    ${total_price}    598.00
    ${sub_total}=    Get Text    jquery=#sub_total h3
    Should Be Equal    ${sub_total}    598.00
    Go To    ${ITM_MOBILE_URL}/checkout/step3
    ${customer_ref_id}=    Point - Get Customer ref id
    Point - Verify Point in DB is None - Cart Table    ${customer_ref_id}
    ${order_id}=    Checkout 3 - Create Order For Mobile CCW
    Verify discount on thank you page for mobile    0.00
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Point - Verify Point in DB is None - Cart Table    ${customer_ref_id}
    Verify Point Reference Id on Order DB None    ${order_id}
    Point - Verify Point in DB is None - Order Shipment Item Table    ${item_id[0]}
    [Teardown]    Close All Browsers

# TC_iTM_04996 - [Mobile][Single item][CCW] To verify that after edited point - confirm, the new point is shown on UI and stamped to DB correctly.
#     [Tags]    TC_iTM_04996    not-ready    bee
#     #    [Teardown]    Close All Browsers
#     Set Price From Inventory THOR    ${inventoryID_BEEEEEE}    299    600
#     Guest Buy Product Until Checkout3 Thor For Mobile    ${Text_Email}    ${inventoryID_BEEEEEE}
#     ${discount_before}=    Checkout3 - mini cart - Get All Discount Price For Mobile
#     Log To Console    Discount Before ${discount_before}
#     ${point}=    Set Variable    10
#     ${expected_point_discount}=    Apply Point For Mobile    ${point}
#     ${customer_ref_id}=    Point - Get Customer ref id
#     ${point}=    Set Variable    1
#     ${expected_point_discount}=    Apply Point For Mobile    ${point}
#     ${point_discount}=    Point - Get Discount from Point
#     ${discount_after}=    Checkout3 - mini cart - Get All Discount Price For Mobile
#     Log To Console    discount_before ${discount_before}
#     Log To Console    discount_after ${discount_after}
#     Log To Console    expected_point_discount ${expected_point_discount}
#     Point - Verify Discount After Apply Point    ${discount_before}    ${discount_after}    ${expected_point_discount}
#     Point - Verify Point in DB - Cart Table    ${customer_ref_id}    ${point}    ${expected_point_discount}    trueyou
#     ${order_id}=    Checkout 3 - Create Order For Mobile CCW
#     Verify discount on thank you page for mobile    0.00
#     LOGIN PCMS    ${pcms_email}    ${pcms_password}
#     ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
#     Point - Verify Point in DB - Cart Table    ${customer_ref_id}    ${point}    ${expected_point_discount}    trueyou
#     Verify Point Reference Id on Order DB Not None    ${order_id}
#     Point - Verify Point in DB is Not None - Order Shipment Item Table    ${item_id[0]}
