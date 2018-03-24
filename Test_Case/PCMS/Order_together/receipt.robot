*** Settings ***
Test Teardown     Close All Browsers
Force Tags        WLS_Order
Library           Selenium2Library
Resource          ${CURDIR}/../../../Resource/Init.robot
Resource          ${CURDIR}/../../../Keyword/Features/Create_Product/Create_Product.robot
Resource          ${CURDIR}/../../../Keyword/Features/Create_Order/Create_order.txt
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Track_order/Keywords_TrackOrder.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Run_PCMS_order/Keywords_RunPCMSOrder.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Order_together/keywords_order_together.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Receipt/Keywords_Receipts.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Receipt/WebElement_Receipt.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Item_status/update_item_status.robot
Resource          ${CURDIR}/../../../Keyword/API/common/api_keywords.robot
Library           ${CURDIR}/../../../Python_Library/DatabaseData.py

*** Variables ***
${CHECKOUT_TIMEOUT}    20s
${Text_Email}     flash@test.com
${Text_Name}      Flash test
${Text_Phone}     0918888888
${Text_Address}    test merchant type
# normal item stock type = 1
${sku_id1}        INAAC1112411
# freebie
${sku_id2}        JHAAA1111211
# item for PC1,PC3
${sku_id3}        LAAAB1114411
# normal item stock type = 4
${sku_id4}        8380
${PC1-code}       PC1CG
${PC3-code}       PC3CG
#Staging item
${Product_MarketPlace}    NIAAB1119511
#Alpha item
# ${Product_MarketPlace}    ACAAC1113611
${customer_cancelled}    customer_cancelled
${product_name_retail}    Product For flash Test Automate retail5
${product_name_retail2}    Product For stark Test Automate retail5
${product_name_market}    Product For flash Test Automate merket place5
${product_name_market2}    Product For stark Test Automate merket place5

*** Test Cases ***
TC_iTM_02247 Reciept Item Order merchant_type = retail - Success
    [Tags]    TC_iTM_02247    ready    receipt    order    flash    regression
    ${pkey}=    Insert products by name with retail type    ${product_name_retail}
    Log To Console    pkey=${pkey}
    ${get_order_id}=    Guest buy product(pkey) success with CCW    ${pkey}
    Login Pcms
    TrackOrder - Go To Order Detail Page    ${get_order_id}
    ${tracking_inventory_ids_list}=    Get inventory ids from tracking page
    Change All Items Status To Pending Shipment    ${get_order_id}
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Receipt - Seach order reciept    ${get_order_id}
    Click expand order detail
    ${order_shipment_items}=    Get order shipment items from DB    ${get_order_id}
    ${together_order_items}=    Get together order items from DB    ${get_order_id}
    Check merchant type of order items    ${order_shipment_items[0][1]}    R
    Check merchant type of order items    ${together_order_items[0][1]}    R
    ${receipt_inventory_merchant_dicts_list}=    Get inventory ids and merchant from receipt page
    Check inventory ids and merchant type case same merchant type    ${tracking_inventory_ids_list}    ${receipt_inventory_merchant_dicts_list}    Retail

TC_iTM_02248 Reciept Item Order merchant_type = market place(M) - Success
    [Tags]    TC_iTM_02248    ready    regression    receipt    order    flash
    ${pkey_M}=    Insert products by name with marketplace type    ${product_name_market}
    Log To Console    pkey market place=${pkey_M}
    ${get_order_id}=    Guest buy product(pkey) success with CCW    ${pkey_M}
    Login Pcms
    TrackOrder - Go To Order Detail Page    ${get_order_id}
    ${tracking_inventory_ids_list}=    Get inventory ids from tracking page
    Change All Items Status To Pending Shipment    ${get_order_id}
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Receipt - Seach order reciept    ${get_order_id}
    Click expand order detail
    ${order_shipment_items}=    Get order shipment items from DB    ${get_order_id}
    ${together_order_items}=    Get together order items from DB    ${get_order_id}
    Check merchant type of order items    ${order_shipment_items[0][1]}    M
    Check merchant type of order items    ${together_order_items[0][1]}    M
    ${receipt_inventory_merchant_dicts_list}=    Get inventory ids and merchant from receipt page
    Check inventory ids and merchant type case same merchant type    ${tracking_inventory_ids_list}    ${receipt_inventory_merchant_dicts_list}    Market Place

TC_iTM_02249 Reciept Item Order merchant_type = retail and market place - Success
    [Tags]    regression    order    ready    TC_iTM_02249    receipt    flash
    ${pkey_R}=    Insert products by name with retail type    ${product_name_retail}
    Log To Console    product pkey retail=${pkey_R}
    ${pkey_M}=    Insert products by name with marketplace type    ${product_name_market}
    Log To Console    pkey market place=${pkey_M}
    ${get_order_id}=    Guest buy multiple-product(pkey) success with CCW    ${pkey_R}    ${pkey_M}
    Login Pcms
    TrackOrder - Go To Order Detail Page    ${get_order_id}
    ${tracking_inventory_ids_list}=    Get inventory ids from tracking page
    Change All Items Status To Pending Shipment    ${get_order_id}
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Receipt - Seach order reciept    ${get_order_id}
    Click expand order detail
    ${order_shipment_items}=    Get order shipment items from DB    ${get_order_id}
    ${together_order_items}=    Get together order items from DB    ${get_order_id}
    Check merchant type of order items    ${order_shipment_items[0][1]}    R
    Check merchant type of order items    ${order_shipment_items[1][1]}    M
    Check merchant type of order items    ${together_order_items[0][1]}    R
    Check merchant type of order items    ${together_order_items[1][1]}    M
    ${receipt_inventory_merchant_dicts_list}=    Get inventory ids and merchant from receipt page
    ${merchant_retail_display}=    Get From Dictionary    ${receipt_inventory_merchant_dicts_list[0]}    merchant
    ${merchant_marketpalce_display}=    Get From Dictionary    ${receipt_inventory_merchant_dicts_list[1]}    merchant
    Check inventory ids and merchant type case mixed merchant type    ${merchant_retail_display}    Retail
    Check inventory ids and merchant type case mixed merchant type    ${merchant_marketpalce_display}    Market Place

TC_iTM_02453 verify order receipt from order type Normal+Freebie+PC1
    [Tags]    regression    order    ready    TC_iTM_02453    receipt
    Stock - Increase Stock By Inventory Id    ${sku_id1}
    Stock - Increase Stock By Inventory Id    ${sku_id2}
    Stock - Increase Stock By Inventory Id    ${sku_id3}
    ${product_pkey1} =    product.Get Product Pkey    ${sku_id1}
    ${product_pkey2} =    product.Get Product Pkey    ${sku_id2}
    ${product_pkey3} =    product.Get Product Pkey    ${sku_id3}
    ${ProductURL1}=    Set Variable    ${ITM_URL}/products/item-${product_pkey1}.html
    ${ProductURL2}=    Set Variable    ${ITM_URL}/products/item-${product_pkey2}.html
    ${ProductURL3}=    Set Variable    ${ITM_URL}/products/item-${product_pkey3}.html
    Open Browser    ${ProductURL1}    chrome
    Maximize Browser Window
    # Level D - Increase Product Quantity
    Sleep    2s
    Level D - User Click Add To Cart Button
    Display Full Cart
    Go To    ${ProductURL2}
    Maximize Browser Window
    # Level D - Increase Product Quantity
    Sleep    2s
    Level D - User Click Add To Cart Button
    Display Full Cart
    Go To    ${ProductURL3}
    Maximize Browser Window
    # Level D - Increase Product Quantity
    Sleep    2s
    Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    Display Checkout Step1 Page
    Checkout1 - Input Email    ${Text_Email}
    Checkout1 - Click Next
    Checkout1 - Wait Loading
    Display Checkout Step2 Page
    Checkout2 - Input Name    ${Text_Name}
    Checkout2 - Input Phone    ${Text_Phone}
    Checkout2 - Select Province
    Checkout2 - Select District
    Checkout2 - Select SubDistrict
    Checkout2 - Select ZipCode
    Checkout2 - Input Address    ${Text_Address}
    Checkout2 - Click Next
    Checkout3 - Display Checkout Step3 Page
    Set Test Variable    ${TEST_VARIABLE_COUPON_CODE}    ${PC1-code}
    Sleep    3s
    User Enter Coupon Code
    Sleep    3s
    User Click Apply Coupon Button
    Sleep    5s
    User Click Payment Channel CCW Tab
    Checkout 3 - User Enter Valid Data Master Card As Member
    ${get_order_id}=    Thankyou - Get order id
    # #PCMS order receipt
    ${order_shipment_data}=    get order shipment item data    ${get_order_id}
    # Log To Console    ${order_shipment_data[0][0]}
    # Log To Console    ${order_shipment_data[1][0]}
    # Log To Console    ${order_shipment_data[2][0]}
    # Log To Console    ${order_shipment_data[3][0]}
    ${body}=    Create Request Api update item status Pick&Pack with serial number for Multi-item    ${get_order_id}    ${order_shipment_data}    4
    Send Api update status    ${body}
    # FMS update status shipped
    ${body}=    Create Request Api update item status Shipped with serial number for Multi-item    ${get_order_id}    ${order_shipment_data}    LYRA_serial_number    4
    Send Api update status    ${body}
    Open PCMS And Sync Order Together
    Go To Order Together Page
    Go to order reciept page    ${get_order_id}
    Receipt - Seach order reciept    ${get_order_id}
    Click expand order detail
    Click Print Copy Receipt Button
    # Login Pcms    ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    # Run PCMS Order
    # Go to order reciept page    ${get_order_id}
    # Receipt - Seach order reciept    ${get_order_id}
    # Click expand order detail
    # ${Check_Invoice_ID}    Get Text    //*[@id="tb-order"]/tbody/tr[1]/td[4]
    # ${Check_OrderID}    Get Text    //*[@id="tb-order"]/tbody/tr[1]/td[5]/b
    # Log To Console    \n Order ID = ${Check_OrderID}
    # Log To Console    Invoice ID = ${Check_Invoice_ID}

TC_iTM_03382 Verify Receipt ID after create order by using product retail 3 order
    [Tags]    order    receipt    MarketPlaceInvoiceID    sprint11    lyra    TC_iTM_03382
    ...    regression
    Stock - Increase Stock By Inventory Id    ${sku_id1}
    Buy Retail Product    ${sku_id1}
    Buy Retail Product    ${sku_id1}
    Buy Retail Product    ${sku_id1}
    Open PCMS And Sync Order Together    1

TC_iTM_03383 Verify Receipt ID after create order by using product Market Place 3 order
    [Tags]    order    receipt    MarketPlaceInvoiceID    sprint11    lyra    TC_iTM_03383
    ...    regression
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1

TC_iTM_03384 Verify Receipt ID after create order by using product Retail&Market 3 order
    [Tags]    order    receipt    MarketPlaceInvoiceID    sprint11    lyra    TC_iTM_03384
    ...    regression
    Stock - Increase Stock By Inventory Id    ${sku_id1}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1

TC_iTM_03385 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [R+M+RM] x3 time
    [Tags]    order    receipt    MarketPlaceInvoiceID    sprint11    lyra    TC_iTM_03385
    ...    regression
    Stock - Increase Stock By Inventory Id    ${sku_id1}
    Buy Retail Product    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1

TC_iTM_03386 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [R+RM+M] x3 time
    [Tags]    order    receipt    MarketPlaceInvoiceID    sprint11    lyra    TC_iTM_03386
    ...    regression
    Stock - Increase Stock By Inventory Id    ${sku_id1}
    Buy Retail Product    ${sku_id1}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1

TC_iTM_03387 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [M+R+RM] x3 time
    [Tags]    order    receipt    MarketPlaceInvoiceID    sprint11    lyra    TC_iTM_03387
    ...    regression
    Stock - Increase Stock By Inventory Id    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1

TC_iTM_03388 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [M+RM+R] x3 time
    [Tags]    order    receipt    MarketPlaceInvoiceID    sprint11    lyra    TC_iTM_03388
    ...    regression
    Stock - Increase Stock By Inventory Id    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Open PCMS And Sync Order Together    1

TC_iTM_03389 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [RM+R+M] x3 time
    [Tags]    order    receipt    MarketPlaceInvoiceID    sprint11    lyra    TC_iTM_03389
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1

TC_iTM_03390 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [RM+M+R] x3 time
    [Tags]    order    receipt    MarketPlaceInvoiceID    sprint11    lyra    TC_iTM_03390
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Open PCMS And Sync Order Together    1

TC_iTM_03391 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [R+M+RM][R+RM+M][M+R+RM]
    [Tags]    order    receipt    MarketPlaceInvoiceID    sprint11    lyra    TC_iTM_03391
    Buy Retail Product    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1

TC_iTM_03392 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [R+RM+M][M+R+RM][M+RM+R]
    [Tags]    order    receipt    MarketPlaceInvoiceID    sprint11    lyra    TC_iTM_03392
    Buy Retail Product    ${sku_id1}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Open PCMS And Sync Order Together    1

TC_iTM_03393 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [M+R+RM][M+RM+R][RM+R+M]
    [Tags]    order    receipt    MarketPlaceInvoiceID    sprint11    lyra    TC_iTM_03393
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1

TC_iTM_03394 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [M+RM+R][RM+R+M][RM+M+R]
    [Tags]    order    receipt    MarketPlaceInvoiceID    sprint11    lyra    TC_iTM_03394
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Open PCMS And Sync Order Together    1

TC_iTM_03395 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [R+M+RM][M+R+RM][RM+R+M]
    [Tags]    order    receipt    MarketPlaceInvoiceID    sprint11    lyra    TC_iTM_03395
    Buy Retail Product    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1

TC_iTM_03396 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [R+RM+M][M+RM+R][RM+M+R]
    [Tags]    order    receipt    MarketPlaceInvoiceID    sprint11    lyra    TC_iTM_03396
    Buy Retail Product    ${sku_id1}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Open PCMS And Sync Order Together    1

TC_iTM_03398 Verify Receipt ID after create order by using product Retail , Market Place [R+R+M]+R
    [Tags]    order    receipt    RunCron    TC_iTM_03398    sprint11    lyra
    ...    regression
    # ${get_order_id}=    Buy Retail Product    ${sku_id1}
    Stock - Increase Stock By Inventory Id    ${sku_id1}
    Buy Retail Product    ${sku_id1}
    Buy Retail Product    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1
    Buy Retail Product    ${sku_id1}
    Open PCMS And Sync Order Together    1

TC_iTM_03399 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [R+R+M]+RM
    [Tags]    order    receipt    RunCron    TC_iTM_03399    sprint11    lyra
    ...    regression
    Stock - Increase Stock By Inventory Id    ${sku_id1}
    Buy Retail Product    ${sku_id1}
    Buy Retail Product    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1

TC_iTM_03400 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [RM+RM+M]+R
    [Tags]    order    receipt    RunCron    TC_iTM_03400    sprint11    lyra
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1
    Buy Retail Product    ${sku_id1}
    Open PCMS And Sync Order Together    1

TC_iTM_03401 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [RM+RM+M]+RM
    [Tags]    order    receipt    RunCron    TC_iTM_03401    sprint11    lyra
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1

TC_iTM_03402 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [R+RM+M]+R
    [Tags]    order    receipt    RunCron    TC_iTM_03402    sprint11    lyra
    Buy Retail Product    ${sku_id1}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1
    Buy Retail Product    ${sku_id1}
    Open PCMS And Sync Order Together    1

TC_iTM_03403 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [R+RM+M]+RM
    [Tags]    order    receipt    RunCron    TC_iTM_03403    sprint11    lyra
    Buy Retail Product    ${sku_id1}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1

TC_iTM_03404 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [RM+R+M]+R
    [Tags]    order    receipt    RunCron    TC_iTM_03404    sprint11    lyra
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1
    Buy Retail Product    ${sku_id1}
    Open PCMS And Sync Order Together    1

TC_iTM_03405 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [RM+R+M]+RM
    [Tags]    order    receipt    RunCron    TC_iTM_03405    sprint11    lyra
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1

TC_iTM_03406 Verify Receipt ID after create order by using product Retail , Market Place [R+R+M+M]+R
    [Tags]    order    receipt    RunCron    TC_iTM_03406    sprint11    lyra
    ...    regression
    Stock - Increase Stock By Inventory Id    ${sku_id1}
    Buy Retail Product    ${sku_id1}
    Buy Retail Product    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1
    Buy Retail Product    ${sku_id1}
    Open PCMS And Sync Order Together    1

TC_iTM_03407 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [R+R+M+M]+RM
    [Tags]    order    receipt    RunCron    TC_iTM_03407    sprint11    lyra
    ...    regression
    Stock - Increase Stock By Inventory Id    ${sku_id1}
    Buy Retail Product    ${sku_id1}
    Buy Retail Product    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1

TC_iTM_03408 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [RM+RM+M+M]+R
    [Tags]    order    receipt    RunCron    TC_iTM_03408    sprint11    lyra
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1
    Buy Retail Product    ${sku_id1}
    Open PCMS And Sync Order Together    1

TC_iTM_03409 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [RM+RM+M+M]+RM
    [Tags]    order    receipt    RunCron    TC_iTM_03409    sprint11    lyra
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1

TC_iTM_03410 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [R+RM+M+M]+R
    [Tags]    order    receipt    RunCron    TC_iTM_03410    sprint11    lyra
    Buy Retail Product    ${sku_id1}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1
    Buy Retail Product    ${sku_id1}
    Open PCMS And Sync Order Together    1

TC_iTM_03411 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [R+RM+M+M]+RM
    [Tags]    order    receipt    RunCron    TC_iTM_03411    sprint11    lyra
    Buy Retail Product    ${sku_id1}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1

TC_iTM_03412 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [RM+R+M+M]+R
    [Tags]    order    receipt    RunCron    TC_iTM_03412    sprint11    lyra
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1
    Buy Retail Product    ${sku_id1}
    Open PCMS And Sync Order Together    1

TC_iTM_03413 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [RM+R+M+M]+RM
    [Tags]    order    receipt    RunCron    TC_iTM_03413    sprint11    lyra
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1

TC_iTM_03414 Verify Receipt ID after create order by using product Retail , Market Place [R+M+R+M]+R
    [Tags]    order    receipt    RunCron    TC_iTM_03414    sprint11    lyra
    ...    regression
    Stock - Increase Stock By Inventory Id    ${sku_id1}
    Buy Retail Product    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1
    Buy Retail Product    ${sku_id1}
    Open PCMS And Sync Order Together    1

TC_iTM_03415 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [RM+M+RM+M]+R
    [Tags]    order    receipt    RunCron    TC_iTM_03415    sprint11    lyra
    ...    regression
    Stock - Increase Stock By Inventory Id    ${sku_id1}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1
    Buy Retail Product    ${sku_id1}
    Open PCMS And Sync Order Together    1

TC_iTM_03416 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [R+M+R+M]+RM
    [Tags]    order    receipt    RunCron    TC_iTM_03416    sprint11    lyra
    Buy Retail Product    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1

TC_iTM_03417 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [RM+M+RM+M]+RM
    [Tags]    order    receipt    RunCron    TC_iTM_03417    sprint11    lyra
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1

TC_iTM_03418 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [R+M+RM]+R
    [Tags]    order    receipt    RunCron    TC_iTM_03418    sprint11    lyra
    Buy Retail Product    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1
    Buy Retail Product    ${sku_id1}
    Open PCMS And Sync Order Together    1

TC_iTM_03419 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [R+M+RM]+RM
    [Tags]    order    receipt    RunCron    TC_iTM_03419    sprint11    lyra
    Buy Retail Product    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1

TC_iTM_03420 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [RM+M+R]+R
    [Tags]    order    receipt    RunCron    TC_iTM_03420    sprint11    lyra
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Open PCMS And Sync Order Together    1
    Buy Retail Product    ${sku_id1}
    Open PCMS And Sync Order Together    1

TC_iTM_03421 Verify Receipt ID after create order by using product Retail , Market Place , Retail&Market Place [RM+M+R]+RM
    [Tags]    order    receipt    RunCron    TC_iTM_03421    sprint11    lyra
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Open PCMS And Sync Order Together    1
    Buy Retail&Market Place Product    ${sku_id1}    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1

TC_iTM_03422 Verify Receipt ID after create order by using product Retail , Market Place [R+R+M]+M
    [Tags]    order    receipt    RunCron    TC_iTM_03422    sprint11    lyra
    ...    regression
    Stock - Increase Stock By Inventory Id    ${sku_id1}
    Buy Retail Product    ${sku_id1}
    Buy Retail Product    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1
    Buy Market Place Product    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1

TC_iTM_03423 Verify Receipt ID after create order by using product Retail , Market Place [R+M+R]+M
    [Tags]    order    receipt    RunCron    TC_iTM_03423    sprint11    lyra
    ...    regression
    Stock - Increase Stock By Inventory Id    ${sku_id1}
    Buy Retail Product    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Open PCMS And Sync Order Together    1
    Buy Market Place Product    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1

TC_iTM_03424 Verify Receipt ID after create order by using product Retail , Market Place [M+M+M]+R
    [Tags]    order    receipt    RunCron    TC_iTM_03424    sprint11    lyra
    ...    regression
    Stock - Increase Stock By Inventory Id    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Market Place Product    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1
    Buy Retail Product    ${sku_id1}
    Open PCMS And Sync Order Together    1

TC_iTM_03425 Verify Receipt ID after create order by using product Retail , Market Place [R+R+R]+M
    [Tags]    order    receipt    RunCron    TC_iTM_03425    sprint11    lyra
    ...    regression
    Stock - Increase Stock By Inventory Id    ${sku_id1}
    Buy Retail Product    ${sku_id1}
    Buy Retail Product    ${sku_id1}
    Buy Retail Product    ${sku_id1}
    Open PCMS And Sync Order Together    1
    Buy Market Place Product    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1

TC_iTM_03426 Verify Receipt ID after create order by using product Retail , Market Place [R+R+R]+R
    [Tags]    order    receipt    RunCron    TC_iTM_03426    sprint11    lyra
    ...    regression
    Stock - Increase Stock By Inventory Id    ${sku_id1}
    Buy Retail Product    ${sku_id1}
    Buy Retail Product    ${sku_id1}
    Buy Retail Product    ${sku_id1}
    Open PCMS And Sync Order Together    1
    Buy Retail Product    ${sku_id1}
    Open PCMS And Sync Order Together    1

TC_iTM_03427 Verify Receipt ID after create order by using product Retail , Market Place [M+R+M]+R
    [Tags]    order    receipt    RunCron    TC_iTM_03427    sprint11    lyra
    ...    regression
    Stock - Increase Stock By Inventory Id    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Buy Retail Product    ${sku_id1}
    Buy Market Place Product    ${Product_MarketPlace}
    Open PCMS And Sync Order Together    1
    Buy Retail Product    ${sku_id1}
    Open PCMS And Sync Order Together    1

TC_iTM_02563 Show "ต้นฉบับ" Button and "สำเนา" Button When Material Code != 0 and Merchant_type = Retail - Success
    [Tags]    TC_iTM_02563    ready    receipt    order    regression    flash
    ...    order_together
    ${pkey}=    Insert products by name with retail type    ${product_name_retail}
    ${get_order_id}=    Guest buy product(pkey) success with CCW    ${pkey}
    ${order_shipment_items}=    Get order shipment items from DB    ${get_order_id}
    ${order_shipment_item_id}=    Set Variable    ${order_shipment_items[0][0]}
    ${sap_material_code}=    Set Variable    3000043395
    ${stock_type}=    Set Variable    RX
    ${item_status}=    Set Variable    [{"order_id": "${get_order_id}","order_shipment_item_id": ${order_shipment_item_id},"item_status": "picked","sap_material_code": "${sap_material_code}","material_id": "SDSD-0","stock_type" : "${stock_type}","tracking_number": "AD15A000371V","logistic_code": "ADENMM","serial_number": "CM14081005633","timestamp_status": "1451985055"}]
    Log to console    ${item_status}
    HTTP Post Request    ${PCMS_URL_API}    http    /api/v4/orders/update-status    ${item_status}    ${EMPTY}    ${EMPTY}
    ...    application/json
    Login Pcms
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Receipt - Seach order reciept    ${get_order_id}
    Click expand order detail
    ${together_order_items}=    Get together order items from DB    ${get_order_id}
    Check merchant type of order items    ${together_order_items[0][1]}    R
    Check merchant type of order items    ${order_shipment_items[0][1]}    R
    Click Print Copy Receipt Button
    Click Print Receipt Button

TC_iTM_02564 Show "ต้นฉบับ" Button and "สำเนา" Button When Material Code = 0 and Merchant_type = Market Place On Product
    [Tags]    TC_iTM_02564    ready    receipt    order    regression    flash
    ...    order_together
    ${pkey}=    Insert products by name with marketplace type    ${product_name_market}
    ${get_order_id}=    Guest buy product(pkey) success with CCW    ${pkey}
    ${order_shipment_items}=    Get order shipment items from DB    ${get_order_id}
    ${order_shipment_item_id}=    Set Variable    ${order_shipment_items[0][0]}
    ${sap_material_code}=    Set Variable    0
    ${stock_type}=    Set Variable    RX
    ${item_status}=    Set Variable    [{"order_id": "${get_order_id}","order_shipment_item_id": ${order_shipment_item_id},"item_status": "picked","sap_material_code": "${sap_material_code}","material_id": "SDSD-0","stock_type" : "${stock_type}","tracking_number": "AD15A000371V","logistic_code": "ADENMM","serial_number": "CM14081005633","timestamp_status": "1451985055"}]
    Log to console    ${item_status}
    HTTP Post Request    ${PCMS_URL_API}    http    /api/v4/orders/update-status    ${item_status}    ${EMPTY}    ${EMPTY}
    ...    application/json
    Login Pcms
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Receipt - Seach order reciept    ${get_order_id}
    Click expand order detail
    ${together_order_items}=    Get together order items from DB    ${get_order_id}
    Check merchant type of order items    ${together_order_items[0][1]}    M
    Check merchant type of order items    ${order_shipment_items[0][1]}    M
    Click Print Copy Receipt Button
    Click Print Receipt Button

TC_iTM_02580 Show "ต้นฉบับ" Button and "สำเนา" Button When - Product2 :Material Code = 1 and Merchant_type = Retail - Product1 :Material Code = 0 and Merchant_type = Market Place
    [Tags]    TC_iTM_02580    ready    receipt    order    regression    flash
    ...    order_together
    ${pkeyR}=    Insert products by name with retail type    ${product_name_retail}
    ${pkeyM}=    Insert products by name with marketplace type    ${product_name_market}
    ${get_order_id}=    Guest buy multiple-product(pkey) success with CCW    ${pkeyR}    ${pkeyM}
    ${order_shipment_items}=    Get order shipment items from DB    ${get_order_id}
    ${order_shipment_item_id_R}=    Set Variable    ${order_shipment_items[0][0]}
    ${order_shipment_item_id_M}=    Set Variable    ${order_shipment_items[1][0]}
    ${sap_material_code}=    Set Variable    1
    ${stock_type}=    Set Variable    RX
    ${item_status_R}=    Set Variable    {"order_id": "${get_order_id}","order_shipment_item_id": ${order_shipment_item_id_R},"item_status": "picked","sap_material_code": "${sap_material_code}","material_id": "SDSD-0","stock_type" : "${stock_type}","tracking_number": "AD15A000371V","logistic_code": "ADENMM","serial_number": "CM14081005633","timestamp_status": "1451985055"}
    ${sap_material_code}=    Set Variable    0
    ${stock_type}=    Set Variable    MX
    ${item_status_M}=    Set Variable    {"order_id": "${get_order_id}","order_shipment_item_id": ${order_shipment_item_id_M},"item_status": "picked","sap_material_code": "${sap_material_code}","material_id": "SDSD-0","stock_type" : "${stock_type}","tracking_number": "AD15A000371V","logistic_code": "ADENMM","serial_number": "CM14081005633","timestamp_status": "1451985055"}
    ${item_status}=    Set Variable    [${item_status_R},${item_status_M}]
    Log to console    ${item_status}
    HTTP Post Request    ${PCMS_URL_API}    http    /api/v4/orders/update-status    ${item_status}    ${EMPTY}    ${EMPTY}
    ...    application/json
    Login Pcms
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Receipt - Seach order reciept    ${get_order_id}
    Click expand order detail
    ${together_order_items}=    Get together order items from DB    ${get_order_id}
    Check merchant type of order items    ${together_order_items[0][1]}    R
    Check merchant type of order items    ${order_shipment_items[0][1]}    R
    Check merchant type of order items    ${together_order_items[1][1]}    M
    Check merchant type of order items    ${order_shipment_items[1][1]}    M
    Click Print Copy Receipt Button
    Click Print Receipt Button

TC_iTM_02499 Reciept Item Order display_stock_type = RD - Success
    [Tags]    TC_iTM_02499    flash    ready    regression    order_together    receipt
    ${pkey}=    Insert products by name with retail type    ${product_name_retail}
    ${get_order_id}=    Guest buy product(pkey) success with CCW    ${pkey}
    ${order_shipment_items}=    Get order shipment items from DB    ${get_order_id}
    ${order_shipment_item_id}=    Set Variable    ${order_shipment_items[0][0]}
    Login Pcms
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    ${sap_material_code}=    Set Variable    0
    ${stock_type}=    Set Variable    RD
    ${item_status}=    Set Variable    [{"order_id": "${get_order_id}","order_shipment_item_id": ${order_shipment_item_id},"item_status": "picked","sap_material_code": "${sap_material_code}","material_id": "SDSD-0","stock_type" : "${stock_type}","tracking_number": "AD15A000371V","logistic_code": "ADENMM","serial_number": "CM14081005633","timestamp_status": "1451985055"}]
    Log to console    ${item_status}
    HTTP Post Request    ${PCMS_URL_API}    http    /api/v4/orders/update-status    ${item_status}    ${EMPTY}    ${EMPTY}
    ...    application/json
    ${together_order_items}=    Get together order items from DB    ${get_order_id}
    Check display stock type of order items    ${together_order_items[0][3]}    RD
    ${order_shipment_items_after}=    Get order shipment items from DB    ${get_order_id}
    Check display stock type of order items    ${order_shipment_items_after[0][2]}    RD

TC_iTM_02500 Reciept Item Order display_stock_type = MD - Success
    [Tags]    TC_iTM_02500    flash    ready    regression    order_together    receipt
    ${pkey}=    Insert products by name with marketplace type    ${product_name_market}
    ${get_order_id}=    Guest buy product(pkey) success with CCW    ${pkey}
    ${order_shipment_items}=    Get order shipment items from DB    ${get_order_id}
    ${order_shipment_item_id}=    Set Variable    ${order_shipment_items[0][0]}
    ${sap_material_code}=    Set Variable    0
    ${stock_type}=    Set Variable    MD
    ${item_status}=    Set Variable    [{"order_id": "${get_order_id}","order_shipment_item_id": ${order_shipment_item_id},"item_status": "picked","sap_material_code": "${sap_material_code}","material_id": "SDSD-0","stock_type" : "${stock_type}","tracking_number": "AD15A000371V","logistic_code": "ADENMM","serial_number": "CM14081005633","timestamp_status": "1451985055"}]
    Log to console    ${item_status}
    HTTP Post Request    ${PCMS_URL_API}    http    /api/v4/orders/update-status    ${item_status}    ${EMPTY}    ${EMPTY}
    ...    application/json
    Login Pcms
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    ${together_order_items}=    Get together order items from DB    ${get_order_id}
    Check display stock type of order items    ${together_order_items[0][3]}    MD
    ${order_shipment_items_after}=    Get order shipment items from DB    ${get_order_id}
    Check display stock type of order items    ${order_shipment_items_after[0][2]}    MD

TC_iTM_02501 Reciept Item Order display_stock_type = RD and MD - Success
    [Tags]    TC_iTM_02501    flash    ready    regression    order_together    receipt
    ${pkeyR}=    Insert products by name with retail type    ${product_name_retail}
    ${pkeyM}=    Insert products by name with marketplace type    ${product_name_market}
    ${get_order_id}=    Guest buy multiple-product(pkey) success with CCW    ${pkeyR}    ${pkeyM}
    ${order_shipment_items}=    Get order shipment items from DB    ${get_order_id}
    ${order_shipment_item_id_R}=    Set Variable    ${order_shipment_items[0][0]}
    ${order_shipment_item_id_M}=    Set Variable    ${order_shipment_items[1][0]}
    Login Pcms
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    ${sap_material_code}=    Set Variable    1
    ${stock_type}=    Set Variable    RD
    ${item_status_R}=    Set Variable    {"order_id": "${get_order_id}","order_shipment_item_id": ${order_shipment_item_id_R},"item_status": "picked","sap_material_code": "${sap_material_code}","material_id": "SDSD-0","stock_type" : "${stock_type}","tracking_number": "AD15A000371V","logistic_code": "ADENMM","serial_number": "CM14081005633","timestamp_status": "1451985055"}
    ${sap_material_code}=    Set Variable    0
    ${stock_type}=    Set Variable    MD
    ${item_status_M}=    Set Variable    {"order_id": "${get_order_id}","order_shipment_item_id": ${order_shipment_item_id_M},"item_status": "picked","sap_material_code": "${sap_material_code}","material_id": "SDSD-0","stock_type" : "${stock_type}","tracking_number": "AD15A000371V","logistic_code": "ADENMM","serial_number": "CM14081005633","timestamp_status": "1451985055"}
    ${item_status}=    Set Variable    [${item_status_R},${item_status_M}]
    Log to console    ${item_status}
    HTTP Post Request    ${PCMS_URL_API}    http    /api/v4/orders/update-status    ${item_status}    ${EMPTY}    ${EMPTY}
    ...    application/json
    ${together_order_items}=    Get together order items from DB    ${get_order_id}
    Check display stock type of order items    ${together_order_items[0][3]}    RD
    Check display stock type of order items    ${together_order_items[1][3]}    MD
    ${order_shipment_items_after}=    Get order shipment items from DB    ${get_order_id}
    Check display stock type of order items    ${order_shipment_items_after[0][2]}    RD
    Check display stock type of order items    ${order_shipment_items_after[1][2]}    MD

TC_iTM_02502 Reciept Item Order display_stock_type is not RD and MD - Success
    [Tags]    TC_iTM_02502    flash    ready    regression    order_together    receipt
    ${pkeyR}=    Insert products by name with retail type    ${product_name_retail}
    ${pkeyM}=    Insert products by name with marketplace type    ${product_name_market}
    ${get_order_id}=    Guest buy multiple-product(pkey) success with CCW    ${pkeyR}    ${pkeyM}
    ${order_shipment_items}=    Get order shipment items from DB    ${get_order_id}
    ${order_shipment_item_id_R}=    Set Variable    ${order_shipment_items[0][0]}
    ${order_shipment_item_id_M}=    Set Variable    ${order_shipment_items[1][0]}
    ${sap_material_code}=    Set Variable    1
    ${stock_type}=    Set Variable    RT
    ${item_status_R}=    Set Variable    {"order_id": "${get_order_id}","order_shipment_item_id": ${order_shipment_item_id_R},"item_status": "picked","sap_material_code": "${sap_material_code}","material_id": "SDSD-0","stock_type" : "${stock_type}","tracking_number": "AD15A000371V","logistic_code": "ADENMM","serial_number": "CM14081005633","timestamp_status": "1451985055"}
    ${sap_material_code}=    Set Variable    0
    ${stock_type}=    Set Variable    MX
    ${item_status_M}=    Set Variable    {"order_id": "${get_order_id}","order_shipment_item_id": ${order_shipment_item_id_M},"item_status": "picked","sap_material_code": "${sap_material_code}","material_id": "SDSD-0","stock_type" : "${stock_type}","tracking_number": "AD15A000371V","logistic_code": "ADENMM","serial_number": "CM14081005633","timestamp_status": "1451985055"}
    ${item_status}=    Set Variable    [${item_status_R},${item_status_M}]
    Log to console    ${item_status}
    HTTP Post Request    ${PCMS_URL_API}    http    /api/v4/orders/update-status    ${item_status}    ${EMPTY}    ${EMPTY}
    ...    application/json
    Login Pcms
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    ${together_order_items}=    Get together order items from DB    ${get_order_id}
    Check display stock type of order items    ${together_order_items[0][3]}    RT
    Check display stock type of order items    ${together_order_items[1][3]}    MX
    ${order_shipment_items_after}=    Get order shipment items from DB    ${get_order_id}
    Check display stock type of order items    ${order_shipment_items_after[0][2]}    RT
    Check display stock type of order items    ${order_shipment_items_after[1][2]}    MX

TC_iTM_02944 When Product2: merchant_type=Retail and Status=Cancel, Product1: merchant_type=Retail and Status=Cancel
    [Tags]    TC_iTM_02944    flash    ready    regression    order_together    receipt
    ...    cancel
    ${pkeyR1}=    Insert products by name with retail type    ${product_name_retail}
    ${pkeyR2}=    Insert products by name with retail type    ${product_name_retail2}
    ${get_order_id}=    Guest buy multiple-product(pkey) success with CCW    ${pkeyR1}    ${pkeyR2}
    ${order_shipment_items}=    Get order shipment items from DB    ${get_order_id}
    ${order_shipment_item_id_1}=    Set Variable    ${order_shipment_items[0][0]}
    ${order_shipment_item_id_2}=    Set Variable    ${order_shipment_items[1][0]}
    ${sku1}=    Get SKU from Order Shipment Item ID    ${order_shipment_item_id_1}
    ${sku2}=    Get SKU from Order Shipment Item ID    ${order_shipment_item_id_2}
    Log to Console    sku 1 = ${sku1}
    Log to Console    sku 2 = ${sku2}
    Login Pcms
    TrackOrder - Go To Order Detail Page    ${get_order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${get_order_id}
    Log To Console    item_id=${items_id}
    TrackOrder - Set Items status    ${items_id}    customer_cancelled
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Receipt - Seach order reciept    ${get_order_id}
    Click expand order detail
    ${together_order_items}=    Get together order items from DB    ${get_order_id}
    Check merchant type of order items    ${together_order_items[0][1]}    R
    Check merchant type of order items    ${order_shipment_items[0][1]}    R
    Check merchant type of order items    ${together_order_items[1][1]}    R
    Check merchant type of order items    ${order_shipment_items[1][1]}    R
    Click Print Copy Receipt Button
    Click Print Receipt Button

TC_iTM_02945 When Product1: merchant_type=Retail and Status=Cancel, Product2: merchant_type=Retail and Material Code=1
    [Tags]    TC_iTM_02945    flash    ready    regression    order_together    receipt
    ...    cancel
    ${pkeyR1}=    Insert products by name with retail type    ${product_name_retail}
    ${pkeyR2}=    Insert products by name with retail type    ${product_name_retail2}
    ${get_order_id}=    Guest buy multiple-product(pkey) success with CCW    ${pkeyR1}    ${pkeyR2}
    ${order_shipment_items}=    Get order shipment items from DB    ${get_order_id}
    ${order_shipment_item_id_1}=    Set Variable    ${order_shipment_items[0][0]}
    ${order_shipment_item_id_2}=    Set Variable    ${order_shipment_items[1][0]}
    Login Pcms
    TrackOrder - Go To Order Detail Page    ${get_order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${get_order_id}
    Log To Console    item_id=${items_id}
    Log To Console    item_id=${items_id[0][0]}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    ${sap_material_code}=    Set Variable    1
    ${stock_type}=    Set Variable    RX
    ${item_status_2}=    Set Variable    {"order_id": "${get_order_id}","order_shipment_item_id": ${order_shipment_item_id_2},"item_status": "picked","sap_material_code": "${sap_material_code}","material_id": "SDSD-0","stock_type" : "${stock_type}","tracking_number": "AD15A000371V","logistic_code": "ADENMM","serial_number": "CM14081005633","timestamp_status": "1451985055"}
    ${item_status}=    Set Variable    [${item_status_2}]
    Log to console    ${item_status}
    HTTP Post Request    ${PCMS_URL_API}    http    /api/v4/orders/update-status    ${item_status}    ${EMPTY}    ${EMPTY}
    ...    application/json
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Receipt - Seach order reciept    ${get_order_id}
    Click expand order detail
    ${together_order_items}=    Get together order items from DB    ${get_order_id}
    Check merchant type of order items    ${together_order_items[0][1]}    R
    Check merchant type of order items    ${order_shipment_items[0][1]}    R
    Check merchant type of order items    ${together_order_items[1][1]}    R
    Check merchant type of order items    ${order_shipment_items[1][1]}    R
    Click Print Copy Receipt Button
    Click Print Receipt Button

TC_iTM_02947 Show "ต้นฉบับ" Button and "สำเนา" Button When Product1: merchant_type=Retail and Status=Cancel, Product2: merchant_type=Market Place and Material Code=0
    [Tags]    TC_iTM_02947    flash    ready    regression    order_together    receipt
    ...    cancel
    ${pkeyR}=    Insert products by name with retail type    ${product_name_retail}
    ${pkeyM}=    Insert products by name with marketplace type    ${product_name_market}
    ${get_order_id}=    Guest buy multiple-product(pkey) success with CCW    ${pkeyR}    ${pkeyM}
    ${order_shipment_items}=    Get order shipment items from DB    ${get_order_id}
    ${order_shipment_item_id_1}=    Set Variable    ${order_shipment_items[0][0]}
    ${order_shipment_item_id_2}=    Set Variable    ${order_shipment_items[1][0]}
    Login Pcms
    TrackOrder - Go To Order Detail Page    ${get_order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${get_order_id}
    Log To Console    item_id=${items_id}
    Log To Console    item_id=${items_id[0][0]}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Receipt - Seach order reciept    ${get_order_id}
    Click expand order detail
    ${together_order_items}=    Get together order items from DB    ${get_order_id}
    Check merchant type of order items    ${together_order_items[0][1]}    R
    Check merchant type of order items    ${order_shipment_items[0][1]}    R
    Check merchant type of order items    ${together_order_items[1][1]}    M
    Check merchant type of order items    ${order_shipment_items[1][1]}    M
    Click Print Copy Receipt Button
    Click Print Receipt Button

TC_iTM_02949 Show "ต้นฉบับ" Button and "สำเนา" Button When Product1: merchant_type=Retail and Material Code=1,Product2: merchant_type=Market Place and Status=Cancel
    [Tags]    TC_iTM_02949    flash    ready    regression    order_together    receipt
    ...    cancel
    ${pkeyR}=    Insert products by name with retail type    ${product_name_retail}
    ${pkeyM}=    Insert products by name with marketplace type    ${product_name_market}
    ${get_order_id}=    Guest buy multiple-product(pkey) success with CCW    ${pkeyR}    ${pkeyM}
    ${order_shipment_items}=    Get order shipment items from DB    ${get_order_id}
    ${order_shipment_item_id_1}=    Set Variable    ${order_shipment_items[0][0]}
    ${order_shipment_item_id_2}=    Set Variable    ${order_shipment_items[1][0]}
    Login Pcms
    TrackOrder - Go To Order Detail Page    ${get_order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${get_order_id}
    Log To Console    item_id=${items_id}
    Log To Console    item_id=${items_id[1][0]}
    TrackOrder - Set Item status    ${items_id[1][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[1][0]}
    ${sap_material_code}=    Set Variable    1
    ${stock_type}=    Set Variable    RX
    ${item_status_1}=    Set Variable    {"order_id": "${get_order_id}","order_shipment_item_id": ${order_shipment_item_id_1},"item_status": "picked","sap_material_code": "${sap_material_code}","material_id": "SDSD-0","stock_type" : "${stock_type}","tracking_number": "AD15A000371V","logistic_code": "ADENMM","serial_number": "CM14081005633","timestamp_status": "1451985055"}
    ${item_status}=    Set Variable    [${item_status_1}]
    Log to console    ${item_status}
    HTTP Post Request    ${PCMS_URL_API}    http    /api/v4/orders/update-status    ${item_status}    ${EMPTY}    ${EMPTY}
    ...    application/json
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Receipt - Seach order reciept    ${get_order_id}
    Click expand order detail
    ${together_order_items}=    Get together order items from DB    ${get_order_id}
    Check merchant type of order items    ${together_order_items[0][1]}    R
    Check merchant type of order items    ${order_shipment_items[0][1]}    R
    Check merchant type of order items    ${together_order_items[1][1]}    M
    Check merchant type of order items    ${order_shipment_items[1][1]}    M
    Click Print Copy Receipt Button
    Click Print Receipt Button

TC_iTM_02950 Show "ต้นฉบับ" Button and "สำเนา" Button When Product2: merchant_type=Market Place and Status = Cancel, Product1: merchant_type=Market Place and Status = Cancel
    [Tags]    TC_iTM_02950    flash    ready    regression    order_together    receipt
    ...    cancel
    ${pkeyM1}=    Insert products by name with marketplace type    ${product_name_market}
    ${pkeyM2}=    Insert products by name with marketplace type    ${product_name_market2}
    ${get_order_id}=    Guest buy multiple-product(pkey) success with CCW    ${pkeyM1}    ${pkeyM2}
    ${order_shipment_items}=    Get order shipment items from DB    ${get_order_id}
    ${order_shipment_item_id_1}=    Set Variable    ${order_shipment_items[0][0]}
    ${order_shipment_item_id_2}=    Set Variable    ${order_shipment_items[1][0]}
    Login Pcms
    TrackOrder - Go To Order Detail Page    ${get_order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${get_order_id}
    Log To Console    item_id=${items_id}
    TrackOrder - Set Items status    ${items_id}    customer_cancelled
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Receipt - Seach order reciept    ${get_order_id}
    Click expand order detail
    ${together_order_items}=    Get together order items from DB    ${get_order_id}
    Log To Console    ${together_order_items}
    Check merchant type of order items    ${together_order_items[0][1]}    M
    Check merchant type of order items    ${order_shipment_items[0][1]}    M
    Check merchant type of order items    ${together_order_items[1][1]}    M
    Check merchant type of order items    ${order_shipment_items[1][1]}    M
    Click Print Copy Receipt Button
    Click Print Receipt Button

TC_iTM_02951_2 Show "ต้นฉบับ" Button and "สำเนา" Button When Product1: merchant_type=Market Place and Status = Cancel, Product2: merchant_type=Market Place
    [Tags]    TC_iTM_02951_2    flash    ready    order_together    reciept    cancel
    ${pkeyM1}=    Insert products by name with marketplace type    ${product_name_market}
    ${pkeyM2}=    Insert products by name with marketplace type    ${product_name_market2}
    ${get_order_id}=    Guest buy multiple-product(pkey) success with CCW    ${pkeyM1}    ${pkeyM2}
    ${order_shipment_items}=    Get order shipment items from DB    ${get_order_id}
    ${order_shipment_item_id_1}=    Set Variable    ${order_shipment_items[0][0]}
    ${order_shipment_item_id_2}=    Set Variable    ${order_shipment_items[1][0]}
    Login Pcms
    TrackOrder - Go To Order Detail Page    ${get_order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${get_order_id}
    Log To Console    item_id=${items_id}
    Log To Console    item_id=${items_id[0][0]}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Receipt - Seach order reciept    ${get_order_id}
    Click expand order detail
    ${together_order_items}=    Get together order items from DB    ${get_order_id}
    Check merchant type of order items    ${together_order_items[0][1]}    M
    Check merchant type of order items    ${order_shipment_items[0][1]}    M
    Check merchant type of order items    ${together_order_items[1][1]}    M
    Check merchant type of order items    ${order_shipment_items[1][1]}    M
    Click Print Copy Receipt Button
    Click Print Receipt Button

TC_iTM_02951_3 Show "ต้นฉบับ" Button and "สำเนา" Button When Product1: merchant_type=Market Place and Material Code=1, Product2: merchant_type=Market Place and Material Code=1
    [Tags]    TC_iTM_02951_3    flash    ready    order_together    receipt    cancel
    ${pkeyM1}=    Insert products by name with marketplace type    ${product_name_market}
    ${pkeyM2}=    Insert products by name with marketplace type    ${product_name_market2}
    ${get_order_id}=    Guest buy multiple-product(pkey) success with CCW    ${pkeyM1}    ${pkeyM2}
    ${order_shipment_items}=    Get order shipment items from DB    ${get_order_id}
    ${order_shipment_item_id_1}=    Set Variable    ${order_shipment_items[0][0]}
    ${order_shipment_item_id_2}=    Set Variable    ${order_shipment_items[1][0]}
    ${sap_material_code}=    Set Variable    1
    ${stock_type}=    Set Variable    MX
    ${item_status_1}=    Set Variable    {"order_id": "${get_order_id}","order_shipment_item_id": ${order_shipment_item_id_1},"item_status": "picked","sap_material_code": "${sap_material_code}","material_id": "SDSD-0","stock_type" : "${stock_type}","tracking_number": "AD15A000371V","logistic_code": "ADENMM","serial_number": "CM14081005633","timestamp_status": "1451985055"}
    ${sap_material_code}=    Set Variable    1
    ${stock_type}=    Set Variable    MX
    ${item_status_2}=    Set Variable    {"order_id": "${get_order_id}","order_shipment_item_id": ${order_shipment_item_id_2},"item_status": "picked","sap_material_code": "${sap_material_code}","material_id": "SDSD-0","stock_type" : "${stock_type}","tracking_number": "AD15A000371V","logistic_code": "ADENMM","serial_number": "CM14081005633","timestamp_status": "1451985055"}
    ${item_status}=    Set Variable    [${item_status_1}, ${item_status_2}]
    Log to console    ${item_status}
    HTTP Post Request    ${PCMS_URL_API}    http    /api/v4/orders/update-status    ${item_status}    ${EMPTY}    ${EMPTY}
    ...    application/json
    Login Pcms
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Receipt - Seach order reciept    ${get_order_id}
    Click expand order detail
    ${together_order_items}=    Get together order items from DB    ${get_order_id}
    Check merchant type of order items    ${together_order_items[0][1]}    M
    Check merchant type of order items    ${order_shipment_items[0][1]}    M
    Check merchant type of order items    ${together_order_items[1][1]}    M
    Check merchant type of order items    ${order_shipment_items[1][1]}    M
    Click Print Copy Receipt Button
    Click Print Receipt Button

TC_iTM_02951_4 Show "ต้นฉบับ" Button and "สำเนา" Button When Product1: merchant_type=Retail and Material Code=1, Product2: merchant_type=Retail and Material Code=1
    [Tags]    TC_iTM_02951_4    flash    ready    order_together    receipt    cancel
    ${pkeyR1}=    Insert products by name with retail type    ${product_name_retail}
    ${pkeyR2}=    Insert products by name with retail type    ${product_name_retail2}
    ${get_order_id}=    Guest buy multiple-product(pkey) success with CCW    ${pkeyR1}    ${pkeyR2}
    ${order_shipment_items}=    Get order shipment items from DB    ${get_order_id}
    ${order_shipment_item_id_1}=    Set Variable    ${order_shipment_items[0][0]}
    ${order_shipment_item_id_2}=    Set Variable    ${order_shipment_items[1][0]}
    ${sku1}=    Get SKU from Order Shipment Item ID    ${order_shipment_item_id_1}
    ${sku2}=    Get SKU from Order Shipment Item ID    ${order_shipment_item_id_2}
    Log to Console    sku 1 = ${sku1}
    Log to Console    sku 2 = ${sku2}
    ${sap_material_code}=    Set Variable    1
    ${stock_type}=    Set Variable    RX
    ${item_status_1}=    Set Variable    {"order_id": "${get_order_id}","order_shipment_item_id": ${order_shipment_item_id_1},"item_status": "picked","sap_material_code": "${sap_material_code}","material_id": "SDSD-0","stock_type" : "${stock_type}","tracking_number": "AD15A000371V","logistic_code": "ADENMM","serial_number": "CM14081005633","timestamp_status": "1451985055"}
    ${sap_material_code}=    Set Variable    1
    ${stock_type}=    Set Variable    RX
    ${item_status_2}=    Set Variable    {"order_id": "${get_order_id}","order_shipment_item_id": ${order_shipment_item_id_2},"item_status": "picked","sap_material_code": "${sap_material_code}","material_id": "SDSD-0","stock_type" : "${stock_type}","tracking_number": "AD15A000371V","logistic_code": "ADENMM","serial_number": "CM14081005633","timestamp_status": "1451985055"}
    ${item_status}=    Set Variable    [${item_status_1}, ${item_status_2}]
    Log to console    ${item_status}
    HTTP Post Request    ${PCMS_URL_API}    http    /api/v4/orders/update-status    ${item_status}    ${EMPTY}    ${EMPTY}
    ...    application/json
    Login Pcms
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Receipt - Seach order reciept    ${get_order_id}
    Click expand order detail
    ${together_order_items}=    Get together order items from DB    ${get_order_id}
    Check merchant type of order items    ${together_order_items[0][1]}    R
    Check merchant type of order items    ${order_shipment_items[0][1]}    R
    Check merchant type of order items    ${together_order_items[1][1]}    R
    Check merchant type of order items    ${order_shipment_items[1][1]}    R
    Click Print Copy Receipt Button
    Click Print Receipt Button

TC_iTM_02951 Show "ต้นฉบับ" Button and "สำเนา" Button When Product1: merchant_type=Market Place and Status=Cancel, Product2: merchant_type=Market Place and Material Code=1
    [Tags]    TC_iTM_02951    flash    ready    regression    order_together    receipt
    ...    cancel
    ${pkeyM1}=    Insert products by name with marketplace type    ${product_name_market}
    ${pkeyM2}=    Insert products by name with marketplace type    ${product_name_market2}
    ${get_order_id}=    Guest buy multiple-product(pkey) success with CCW    ${pkeyM1}    ${pkeyM2}
    ${order_shipment_items}=    Get order shipment items from DB    ${get_order_id}
    ${order_shipment_item_id_1}=    Set Variable    ${order_shipment_items[0][0]}
    ${order_shipment_item_id_2}=    Set Variable    ${order_shipment_items[1][0]}
    Login Pcms
    TrackOrder - Go To Order Detail Page    ${get_order_id}
    ${items_id}=    TrackOrder - Get Order Shipment id    ${get_order_id}
    Log To Console    item_id=${items_id}
    Log To Console    item_id=${items_id[0][0]}
    TrackOrder - Set Item status    ${items_id[0][0]}    customer_cancelled
    TrackOrder - Click save    ${items_id[0][0]}
    ${sap_material_code}=    Set Variable    1
    ${stock_type}=    Set Variable    MX
    ${item_status_2}=    Set Variable    {"order_id": "${get_order_id}","order_shipment_item_id": ${order_shipment_item_id_2},"item_status": "picked","sap_material_code": "${sap_material_code}","material_id": "SDSD-0","stock_type" : "${stock_type}","tracking_number": "AD15A000371V","logistic_code": "ADENMM","serial_number": "CM14081005633","timestamp_status": "1451985055"}
    ${item_status}=    Set Variable    [${item_status_2}]
    Log to console    ${item_status}
    HTTP Post Request    ${PCMS_URL_API}    http    /api/v4/orders/update-status    ${item_status}    ${EMPTY}    ${EMPTY}
    ...    application/json
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Run PCMS Order
    Go to order reciept page    ${get_order_id}
    Receipt - Seach order reciept    ${get_order_id}
    Click expand order detail
    ${together_order_items}=    Get together order items from DB    ${get_order_id}
    Check merchant type of order items    ${together_order_items[0][1]}    M
    Check merchant type of order items    ${order_shipment_items[0][1]}    M
    Check merchant type of order items    ${together_order_items[1][1]}    M
    Check merchant type of order items    ${order_shipment_items[1][1]}    M
    Click Print Copy Receipt Button
    Click Print Receipt Button
