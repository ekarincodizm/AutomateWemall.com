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
Force Tags      Point_Redeem

*** Variable ***
${email}          Tureyou_point@test.com
${pcms_email}     admin@domain.com
${pcms_password}    12345
${trueyou_user}    runoinar@gmail.com
${trueyou_pass}    75103598
${inventoryID}    INAAC1112611
${inventoryID_Toey}    INAAC1112611
${inventoryID_Cing}    INAAC1112611
${inventoryID_Tam}    INAAC1112611
${inventoryID_Tam_2}    OKAAA1112711
${inventoryID_Feel}    INAAC1112611
${inventoryID_BEEEEEE}    INAAC1112611
${inventoryID_Rut}    INAAC1112611
${inventoryID_Rut2}    OKAAA1112711
${inventoryID_Men}    INAAC1112611
${inventoryID_Men2}    OKAAA1112711
${inventoryID_Men3}    OKAAA1112511
${special_price_for_shipping_fee}    299
${normal_price_for_shipping_fee}    300
${Text_Email}     thor_robot@mail.com
${Text_Name}      thor_robot
${Text_Phone}     0900000000
${Text_Address}    addr 1234

*** Test Cases ***
TC_ITMWM_01389 [Single item][CCW] To verify that after add point, point is shown on UI and stamped to DB correctly.
    [Tags]    regression    TC_ITMWM_01389    ready
    #--Cing
    Guest Buy Product Until Checkout3 Thor    ${Text_Email}    ${inventoryID_Cing}
    ${sub_total_price_before}=    Checkout3 - mini cart - Get Sub Total Price
    ${discount_before}=    Checkout3 - mini cart - Get All Discount Price
    ${total_price_before}=    Checkout3 - mini cart - Get Total Price
    ${point}=    Set Variable    10
    ${expected_point_discount}=    Apply Point    ${point}
    ${point_discount}=    Point - Get Discount from Point
    ${customer_ref_id}=    Point - Get Customer ref id
    Point - Verify Point in DB - Cart Table    ${customer_ref_id}    ${point}    ${expected_point_discount}    trueyou
    Go To Checkout1 Until Checkout3 And Verify Discount    ${sub_total_price_before}    ${discount_before}    ${total_price_before}    ${point_discount}
    ${discount_after}=    Checkout3 - mini cart - Get All Discount Price
    ${order_id}=    Checkout 3 - Create Order CCW
    Verify discount on thank you page    ${discount_after}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Point - Verify Point in DB - Cart Table    ${customer_ref_id}    ${point}    ${expected_point_discount}    trueyou
    Verify Point Reference Id on Order DB Not None    ${order_id}
    Point - Verify Point in DB is Not None - Order Shipment Item Table    ${item_id[0]}
    [Teardown]    Close All Browsers

TC_ITMWM_01396 [Single item][CCW] To verify that add new point after edited quantity, the new point is shown on UI and stamped to DB correctly.
    [Tags]    regression    TC_ITMWM_01396    ready
    Guest Buy Product Until Checkout3 Thor    ${Text_Email}    ${inventoryID_Cing}
    ${sub_total_price_before}=    Checkout3 - mini cart - Get Sub Total Price
    ${discount_before}=    Checkout3 - mini cart - Get All Discount Price
    ${total_price_before}=    Checkout3 - mini cart - Get Total Price
    ${point}=    Set Variable    10
    ${expected_point_discount}=    Apply Point    ${point}
    ${customer_ref_id}=    Point - Get Customer ref id
    Point - Update Product Qty In Cart    ${inventoryID_Cing}    2
    ${expected_point_discount}=    Apply Point    ${point}
    ${point_discount}=    Point - Get Discount from Point
    Point - Verify Point in DB - Cart Table    ${customer_ref_id}    ${point}    ${expected_point_discount}    trueyou
    ${discount_after}=    Checkout3 - mini cart - Get All Discount Price
    ${order_id}=    Checkout 3 - Create Order CCW
    Verify discount on thank you page    ${discount_after}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Point - Verify Point in DB - Cart Table    ${customer_ref_id}    ${point}    ${expected_point_discount}    trueyou
    Verify Point Reference Id on Order DB Not None    ${order_id}
    Point - Verify Point in DB is Not None - Order Shipment Item Table    ${item_id[0]}
    #--Toey
    [Teardown]    Close All Browsers

TC_ITMWM_01390 [Single item][CCW] To verify that after remove point, point is removed on UI and stamped to DB correctly.
    [Tags]    regression    TC_ITMWM_01390    ready
    ${point}=    Set Variable    10
    # 1. Add 1 item to cart
    Add To Cart    ${inventoryID_Toey}    1
    # 2. Add and then removed point on check out 3.
    Go To Checkout1 Until Checkout3
    ${sub_total_price_before}=    Checkout3 - mini cart - Get Sub Total Price
    ${discount_before}=    Checkout3 - mini cart - Get All Discount Price
    ${total_price_before}=    Checkout3 - mini cart - Get Total Price
    ${expected_point_discount}=    Apply Point    ${point}
    Point - Remove Point
    # 3. Go to check out 1,2 and verify discount.
    Go To Checkout1 Until Checkout3 And Verify Discount    ${sub_total_price_before}    ${discount_before}    ${total_price_before}    0
    # 4. Verify db:cart.
    ${customer_ref_id}=    Point - Get Customer ref id
    Point - Verify Point in DB is None - Cart Table    ${customer_ref_id}
    # 5. Place order.
    ${discount_after}=    Checkout3 - mini cart - Get All Discount Price
    ${order_id}=    Checkout 3 - Create Order CCW
    # 6. Verify discount on thank you page.
    Verify discount on thank you page    ${discount_after}
    # 7. Verify point on db: cart.
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${customer_ref_id}=    Get Customer Ref Id Data    ${order_id}
    Point - Verify Point in DB is None - Cart Table    ${customer_ref_id[0]}
    Point - Verify Point in DB is None - Order Shipment Item Table    ${item_id[0]}
    # 8. Verify point on db: orders.
    Verify Point Reference Id on Order DB None    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_01395 [Single item][CCW] To verify that add new point after added item, the new point is shown on UI and stamped to DB correctly.
    [Tags]    regression    TC_ITMWM_01395    ready
    ${point}=    Set Variable    10
    # 1. Add 1 item to cart
    Add To Cart    ${inventoryID_Toey}    1
    # 2. Add point on check out 3.
    Go To Checkout1 Until Checkout3
    ${expected_point_discount}=    Apply Point    ${point}
    Log To Console    ${expected_point_discount}
    # 3. Add 1 item to cart
    Add To Cart    ${inventoryID_Cing}    1    false
    Go To Checkout1 Until Checkout3
    ${sub_total_price}=    Checkout3 - mini cart - Get Sub Total Price
    ${discount}=    Checkout3 - mini cart - Get All Discount Price
    ${total_price}=    Checkout3 - mini cart - Get Total Price
    # 4. Add new point (diff point) on check out 3.
    ${expected_point_discount}=    Apply Point    ${point}
    ${point_discount}=    Point - Get Discount from Point
    Log To Console    ${expected_point_discount}
    # 5. Go to check out 1 and then verify discount
    # 5. Go to check out 2 and then verify discount
    Go To Checkout1 Until Checkout3 And Verify Discount    ${sub_total_price}    ${discount}    ${total_price}    ${point_discount}
    # 6. Go to check out 3 and then verify point
    Point - Verify Point and Discount are displayed    ${point}    ${expected_point_discount}
    # 7. Verify db:cart.
    ${customer_ref_id}=    Point - Get Customer ref id
    Point - Verify Point in DB - Cart Table    ${customer_ref_id}    ${point}    ${expected_point_discount}    trueyou
    # 8. Place order.
    ${discount_after}=    Checkout3 - mini cart - Get All Discount Price
    ${order_id}=    Checkout 3 - Create Order CCW
    # 9. Verify discount on thank you page.
    Verify discount on thank you page    ${discount_after}
    # 10. Verify point and mark delete flag on db: cart. (Robot will check point in DB but delete flag will be tested manually)
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${customer_ref_id}=    Get Customer Ref Id Data    ${order_id}
    Point - Verify Point in DB - Cart Table    ${customer_ref_id[0]}    ${point}    ${expected_point_discount}    trueyou
    # 11. Verify point on db: orders.
    Verify Point Reference Id on Order DB Not None    ${order_id}
    # 12. Verify point on db: order_shipment_items.
    Point - Verify Point in DB is Not None - Order Shipment Item Table    ${item_id[0]}
    # 13. Verify remaining point. (Manual this step)
    #--Feel
    #Example Checkout
    #    [Tags]    regression    feel
    #    ${special_price}=    Set Variable    222
    #    ${normal_price}=    Set Variable    349
    #
    #    Set Price From Inventory THOR    ${inventoryID_Feel}    ${special_price}    ${normal_price}
    #
    #    Guest Buy Product Until Checkout3 Thor    ${Text_Email}    ${inventoryID_Feel}
    #    ${sub_total_price_before}=    Checkout3 - mini cart - Get Sub Total Price
    #    ${discount_before}=    Checkout3 - mini cart - Get All Discount Price
    #    ${total_price_before}=    Checkout3 - mini cart - Get Total Price
    #    ${expected_point_discount}=    Apply Point    10
    #    ${point_discount}=    Point - Get Discount from Point
    #
    #    Go To Checkout1 Until Checkout3 And Verify Discount    ${sub_total_price_before}    ${discount_before}    ${total_price_before}    ${point_discount}
    [Teardown]    Close All Browsers

TC_ITMWM_01391 [Single item][CCW] To verify that after added item point will be remove, point is removed on UI and stamped to DB correctly.
    [Tags]    regression    TC_ITMWM_01391
    ${point}=    Set Variable    10
    #1. Add 1 item to cart
    Add To Cart    ${inventoryID_Feel}    1
    # 2. Add point on check out 3.
    Go To Checkout1 Until Checkout3
    ${expected_point_discount}=    Apply Point    ${point}
    # 3. Add single item
    Add To Cart    ${inventoryID_Toey}    1    0
    Go To    ${ITM_URL}/checkout/step3
    ${sub_total_price_before}=    Checkout3 - mini cart - Get Sub Total Price
    ${discount_before}=    Checkout3 - mini cart - Get All Discount Price
    ${total_price_before}=    Checkout3 - mini cart - Get Total Price
    # 4. Go to check out 1 and then verify discount
    # 5. Go to check out 2 and then verify discount
    # 6. Go to check out 3 and then verify point
    Go To Checkout1 Until Checkout3 And Verify Discount    ${sub_total_price_before}    ${discount_before}    ${total_price_before}    0
    # 7. Verify db:cart.
    ${customer_ref_id}=    Point - Get Customer ref id
    Point - Verify Point in DB is None - Cart Table    ${customer_ref_id}
    # 8. Place order.
    ${discount_after}=    Checkout3 - mini cart - Get All Discount Price
    ${order_id}=    Checkout 3 - Create Order CCW
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    #9. Verify discount on thank you page.
    Verify discount on thank you page    ${discount_after}
    # 10. Verify point and mark delete flag on db: cart. (Robot will check point in DB but delete flag will be tested manually)
    ${customer_ref_id}=    Get Customer Ref Id Data    ${order_id}
    Point - Verify Point in DB is None - Cart Table    ${customer_ref_id}
    # 11. Verify point on db: orders.
    Verify Point Reference Id on Order DB None    ${order_id}
    # 12. Verify point on db: order_shipment_items.
    Point - Verify Point in DB is None - Order Shipment Item Table    ${item_id[0]}
    Point - Verify Point in DB is None - Order Shipment Item Table    ${item_id[1]}
    # 13. Verify remaining point. (Manual this step)
    #--P'Men

4 Qty
    [Tags]    4qty
    ${point}=    Set Variable    10
    ${inventory_id}=    Set Variable    ${inventoryID_Men2}
    Add To Cart    ${inventory_id}    1
    Go To Checkout1 Until Checkout3
    ${expected_point_discount}=    Apply Point    ${point}
    Go To    ${ITM_URL}/checkout/step1
    Point - Update Product Qty In Cart    ${inventory_id}    2
    ${discount_expect}=    Checkout3 - mini cart - Get All Discount Price
    Point - Verify Discount After Apply Point    0.00    0.00    0
    Go To    ${ITM_URL}/checkout/step2
    Point - Update Product Qty In Cart    ${inventory_id}    3
    ${discount_expect}=    Checkout3 - mini cart - Get All Discount Price
    Point - Verify Discount After Apply Point    0.00    0.00    0
    Go To    ${ITM_URL}/checkout/step3
    Point - Update Product Qty In Cart    ${inventory_id}    4
    ${discount_expect}=    Checkout3 - mini cart - Get All Discount Price
    Point - Verify Discount After Apply Point    0.00    0.00    0
    ${discount_after}=    Checkout3 - mini cart - Get All Discount Price
    ${order_id}=    Checkout 3 - Create Order CCW
    Verify discount on thank you page    ${discount_after}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${customer_ref_id}=    Get Customer Ref Id Data    ${order_id}
    Point - Verify Point in DB is None - Cart Table    ${customer_ref_id[0]}
    Point - Verify Point in DB is None - Order Shipment Item Table    ${item_id[0]}
    Verify Point Reference Id on Order DB None    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_01392 [Single item][CCW] To verify that after edited quantity point will be remove, point is removed on UI and stamped to DB correctly.
    [Tags]    regression    TC_ITMWM_01392    ready
    ${point}=    Set Variable    10
    ${inventory_id}=    Set Variable    ${inventoryID_Men2}
    Add To Cart    ${inventory_id}    1
    Go To Checkout1 Until Checkout3
    ${expected_point_discount}=    Apply Point    ${point}
    Go To    ${ITM_URL}/checkout/step1
    Point - Update Product Qty In Cart    ${inventory_id}    2
    ${discount_expect}=    Checkout3 - mini cart - Get All Discount Price
    Point - Verify Discount After Apply Point    0.00    0.00    0
    Go To    ${ITM_URL}/checkout/step2
    Point - Update Product Qty In Cart    ${inventory_id}    1
    ${discount_expect}=    Checkout3 - mini cart - Get All Discount Price
    Point - Verify Discount After Apply Point    0.00    0.00    0
    Go To    ${ITM_URL}/checkout/step3
    Point - Update Product Qty In Cart    ${inventory_id}    2
    ${discount_expect}=    Checkout3 - mini cart - Get All Discount Price
    Point - Verify Discount After Apply Point    0.00    0.00    0
    ${discount_after}=    Checkout3 - mini cart - Get All Discount Price
    ${order_id}=    Checkout 3 - Create Order CCW
    Verify discount on thank you page    ${discount_after}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${customer_ref_id}=    Get Customer Ref Id Data    ${order_id}
    Point - Verify Point in DB is None - Cart Table    ${customer_ref_id[0]}
    Point - Verify Point in DB is None - Order Shipment Item Table    ${item_id[0]}
    Verify Point Reference Id on Order DB None    ${order_id}
    [Teardown]    Close All Browsers

TC_ITMWM_01397 [Multipe item][CCW] To verify that after removed item point will be remove, point is removed on UI and stamped to DB correctly.
    [Tags]    regression    TC_ITMWM_01397    ready
    ${point}=    Set Variable    10
    ${inventoryID} =    Create List    ${inventoryID_Men3}    ${inventoryID_Men2}
    Add To Cart Multi Inventory    ${inventoryID}
    Go To Checkout1 Until Checkout3
    ${expected_point_discount}=    Apply Point    ${point}
    Click Element    id=btn-edit-cart
    Delete Specific Item in Cart Light Box    ${inventoryID_Men3}
    Reload Page
    ${customer_ref_id}=    Point - Get Customer ref id
    Point - Verify Point in DB is None - Cart Table    ${customer_ref_id}
    ${discount_after}=    Checkout3 - mini cart - Get All Discount Price
    ${order_id}=    Checkout 3 - Create Order CCW
    Verify discount on thank you page    ${discount_after}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    ${customer_ref_id}=    Get Customer Ref Id Data    ${order_id}
    Point - Verify Point in DB is None - Cart Table    ${customer_ref_id[0]}
    Point - Verify Point in DB is None - Order Shipment Item Table    ${item_id[0]}
    Verify Point Reference Id on Order DB None    ${order_id}
    #--Rut
    [Teardown]    Close All Browsers

TC_ITMWM_01394 [Single item][CCW] To verify that after edited point but not confirm, point is shown on UI and stamped to DB correctly.
    [Tags]    regression    TC_ITMWM_01394    ready
    ${point}=    Set Variable    1
    ${special_price}=    Set Variable    500
    ${normal_price}=    Set Variable    600
    Set Price From Inventory THOR    ${inventoryID_Rut}    ${special_price}    ${normal_price}
    Guest Buy Product Until Checkout3 Thor    ${Text_Email}    ${inventoryID_Rut}
    ${sub_total_price}=    Checkout3 - mini cart - Get Sub Total Price
    ${discount}=    Checkout3 - mini cart - Get All Discount Price
    ${total_price}=    Checkout3 - mini cart - Get Total Price
    ${expected_point_discount}=    Apply Point    1
    Point - Edit Point For True You    10    close
    Go To Checkout1 Until Checkout3 And Verify Discount    ${sub_total_price}    ${discount}    ${total_price}    ${expected_point_discount}
    ${customer_ref_id}=    Point - Get Customer ref id
    Point - Verify Point in DB - Cart Table    ${customer_ref_id}    ${point}    ${expected_point_discount}    trueyou
    ${discount_after}=    Checkout3 - mini cart - Get All Discount Price
    ${order_id}=    Checkout 3 - Create Order CCW
    Verify discount on thank you page    ${discount_after}
    LOGIN PCMS    ${pcms_email}    ${pcms_password}
    ${item_id}=    TrackOrder - Get Order Shipment id    ${order_id}
    Verify Point Reference Id on Order DB Not None    ${order_id}
    Point - Verify Point in DB is Not None - Order Shipment Item Table    ${item_id[0]}
    #--Tam
    [Teardown]    Close All Browsers

TC_ITMWM_01393 [Single item][CCW] To verify that after edited point, the new point is shown on UI and stamped to DB correctly.
    [Tags]    regression    TC_ITMWM_01393    ready
    ${point_for_add}=    Set Variable    10
    ${point_for_edit}=    Set Variable    5
    Add To Cart    ${inventoryID_Tam}    1
    Go To Checkout1 Until Checkout3
    ${sub_total_price_before}=    Checkout3 - mini cart - Get Sub Total Price
    ${discount_before}=    Checkout3 - mini cart - Get All Discount Price
    Apply Point    ${point_for_add}
    ${expected_point_discount}=    Apply Edit Point    ${point_for_edit}
    Wait For Ajax Load Point
    ${point_discount}=    Point - Get Discount from Point
    Go To Checkout1 Until Checkout2 And Verify Discount    ${sub_total_price_before}    ${discount_before}    ${point_discount}
    ${customer_ref_id}=    Point - Get Customer ref id
    Point - Verify Point in DB - Cart Table    ${customer_ref_id}    ${point_for_edit}    ${expected_point_discount}    trueyou
    Go To    ${ITM_URL}/checkout/step3
    ${discount_after}=    Checkout3 - mini cart - Get All Discount Price
    ${order_id}=    Checkout 3 - Create Order CCW
    Verify discount on thank you page    ${discount_after}
    Point - Verify Point in DB - Cart Table    ${customer_ref_id}    ${point_for_edit}    ${expected_point_discount}    trueyou
    Verify Point Reference Id on Order DB Not None    ${order_id}
    ${item_id}=    get_order_shipment_item_data    ${order_id}
    Point - Verify Point in DB is Not None - Order Shipment Item Table    ${item_id[0][0]}
    [Teardown]    Close All Browsers

TC_ITMWM_01404 [Multiple item][CCW] To verify that add new point after removed item, the new point is shown on UI and stamped to DB correctly.
    [Tags]    regression    TC_ITMWM_01404    ready
    ${point_for_add}=    Set Variable    10
    ${point_for_edit}=    Set Variable    5
    Add To Cart    ${inventoryID_Tam}    2
    Go To Checkout1 Until Checkout3
    ${sub_total_price_before}=    Checkout3 - mini cart - Get Sub Total Price
    ${discount_before}=    Checkout3 - mini cart - Get All Discount Price
    Apply Point    ${point_for_add}
    Point - Update Product Qty In Cart    ${inventoryID_Tam}    1
    ${sub_total_price_before}=    Checkout3 - mini cart - Get Sub Total Price
    ${discount_before}=    Checkout3 - mini cart - Get All Discount Price
    ${expected_point_discount}=    Apply Point    ${point_for_edit}
    ${customer_ref_id}=    Point - Get Customer ref id
    Point - Verify Point in DB - Cart Table    ${customer_ref_id}    ${point_for_edit}    ${expected_point_discount}    trueyou
    ${discount_after}=    Checkout3 - mini cart - Get All Discount Price
    ${order_id}=    Checkout 3 - Create Order CCW
    Verify discount on thank you page    ${discount_after}
    Point - Verify Point in DB - Cart Table    ${customer_ref_id}    ${point_for_edit}    ${expected_point_discount}    trueyou
    Verify Point Reference Id on Order DB Not None    ${order_id}
    ${item_id}=    get_order_shipment_item_data    ${order_id}
    Point - Verify Point in DB is Not None - Order Shipment Item Table    ${item_id[0][0]}
    #--Tam
    #--P'John
    [Teardown]    Close All Browsers
