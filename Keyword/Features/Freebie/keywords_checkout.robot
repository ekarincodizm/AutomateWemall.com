*** Variable ***
@{collections}      มือถือ และ แท็บเล็ต
@{excludes_collection}    Samsung Galaxy Note 4 เครื่องเปล่า ศูนย์ทรู
&{promotion_condition_all_cart}    type=Cart
&{var_freebie_condition_collection_exclude_some}    type=Collection    collections=@{collections}    excludes=@{excludes_collection}
&{var_freebie_promotion_code_data_percent}    type=Coupon Code    name=Robot Freebie    start_date=${EMPTY}    end_date=${EMPTY}    code=ROBOTFB    detail=Freebie Promotion Code Test    note=Note Freebie Promotion Code Test    status=Activate    code_type=Single    no_used=100    code_prefix=BOTFB    no_suffix=3    minimum_price=0    discount_type=Percent    discount_value=10    maximum_discount=5000   budget_type=PC1   time_per_user=Unlimited
&{var_freebie_promotion_code_data_price}    type=Coupon Code    name=Robot Freebie    start_date=${EMPTY}    end_date=${EMPTY}    code=ROBOTFB    detail=Freebie Promotion Code Test    note=Note Freebie Promotion Code Test    status=Activate    code_type=Single    no_used=100    code_prefix=BOTFB    no_suffix=3    minimum_price=0    discount_type=Price    discount_value=100    budget_type=PC1     time_per_user=Unlimited
${robot_campaign_ITMMZ_1211}    Robot_Campaign_ITMMZ_1211

*** Keywords ***
Freebie Checkout - Go To Level D Main Product
    Go To          ${ITM_URL}/products/item-${var_freebie_main_level_d_pkey}.html

Freebie Checkout - Go To Level D Normal Product
    Go To          ${ITM_URL}/products/item-${var_freebie_normal_level_d_pkey}.html

Freebie Checkout - Go To Level D Normal2 Product
    Go To          ${ITM_URL}/products/item-${var_freebie_normal2_level_d_pkey}.html

Freebie Checkout - Check Current Stock Main Product
    ${stock}=         Check Stock By Sku       ${var_freebie_main_level_d_inventory}
    ${remaining}=       Get Json Value         ${stock}        /remaining/${var_freebie_main_level_d_inventory}
    ${hold}=            Get Json Value         ${stock}        /hold/${var_freebie_main_level_d_inventory}
    Set Test Variable       ${var_freebie_main_product_remaining_old}            ${remaining}
    Set Test Variable       ${var_freebie_main_product_hold_old}            ${hold}
    Log to console      main:${var_freebie_main_product_remaining_old}

Freebie Checkout - Check Current Stock Free Product
    ${stock}=         Check Stock By Sku       ${var_freebie_free_level_d_inventory}
    ${remaining}=       Get Json Value         ${stock}        /remaining/${var_freebie_free_level_d_inventory}
    ${hold}=            Get Json Value         ${stock}        /hold/${var_freebie_free_level_d_inventory}
    Set Test Variable       ${var_freebie_free_product_remaining_old}            ${remaining}
    Set Test Variable       ${var_freebie_free_product_hold_old}            ${hold}
    Log to console      free:${var_freebie_free_product_remaining_old}

Freebie Checkout - Check Current Stock Normal Product
    ${stock}=         Check Stock By Sku       ${var_freebie_normal_level_d_inventory}
    ${remaining}=       Get Json Value         ${stock}        /remaining/${var_freebie_normal_level_d_inventory}
    ${hold}=            Get Json Value         ${stock}        /hold/${var_freebie_normal_level_d_inventory}
    Set Test Variable       ${var_freebie_normal_product_remaining_old}            ${remaining}
    Set Test Variable       ${var_freebie_normal_product_hold_old}            ${hold}
    Log to console      normal:${var_freebie_normal_product_remaining_old}

Freebie Checkout - Check Current Stock Normal2 Product
    ${stock}=         Check Stock By Sku       ${var_freebie_normal2_level_d_inventory}
    ${remaining}=       Get Json Value         ${stock}        /remaining/${var_freebie_normal2_level_d_inventory}
    ${hold}=            Get Json Value         ${stock}        /hold/${var_freebie_normal2_level_d_inventory}
    Set Test Variable       ${var_freebie_normal2_product_remaining_old}            ${remaining}
    Set Test Variable       ${var_freebie_normal2_product_hold_old}            ${hold}
    Log to console      normal2:${var_freebie_normal2_product_remaining_old}

Freebie Checkout - Set Remaining Main Product
    [Arguments]         ${main_stock}=0
    Adjust Stock Remaining By Inventory ID       ${var_freebie_main_level_d_inventory}           ${main_stock}

Freebie Checkout - Set Remaining Free Product
    [Arguments]         ${free_stock}=0
    Adjust Stock Remaining By Inventory ID       ${var_freebie_free_level_d_inventory}           ${free_stock}

Freebie Checkout - Set Remaining Normal Product
    [Arguments]         ${normal_stock}=0
    Adjust Stock Remaining By Inventory ID       ${var_freebie_normal_level_d_inventory}           ${normal_stock}

Freebie Checkout - Set Remaining Normal2 Product
    [Arguments]         ${normal_stock}=0
    Adjust Stock Remaining By Inventory ID       ${var_freebie_normal2_level_d_inventory}           ${normal_stock}

Freebie Checkout - Check Remaining Main Product
    [Arguments]    ${expect_qty}
    ${stock}=         Check Stock By Sku       ${var_freebie_main_level_d_inventory}
    ${remaining}=       Get Json Value         ${stock}        /remaining/${var_freebie_main_level_d_inventory}
    Should Be Equal As Integers    ${remaining}     ${expect_qty}

Freebie Checkout - Check Remaining Free Product
    [Arguments]    ${expect_qty}
    ${stock}=         Check Stock By Sku       ${var_freebie_free_level_d_inventory}
    ${remaining}=       Get Json Value         ${stock}        /remaining/${var_freebie_free_level_d_inventory}
    Should Be Equal As Integers    ${remaining}     ${expect_qty}

Freebie Checkout - Check Remaining Normal Product
    [Arguments]    ${expect_qty}
    ${stock}=         Check Stock By Sku       ${var_freebie_normal_level_d_inventory}
    ${remaining}=       Get Json Value         ${stock}        /remaining/${var_freebie_normal_level_d_inventory}
    Should Be Equal As Integers    ${remaining}     ${expect_qty}

Freebie Checkout - Check Remaining Normal2 Product
    [Arguments]    ${expect_qty}
    ${stock}=         Check Stock By Sku       ${var_freebie_normal2_level_d_inventory}
    ${remaining}=       Get Json Value         ${stock}        /remaining/${var_freebie_normal2_level_d_inventory}
    Should Be Equal As Integers    ${remaining}     ${expect_qty}

Freebie Checkout - Rebuild Stock More Than 1Variant
    Go To          ${ITM_URL}/${PRODUCT-REBUILD-STOCK}?product_pkey=${var_freebie_main_level_d_pkey}&option_pkey[0]=${var_freebie_main_level_d_style1}&debugger=1
    Wait Until Element Is Visible                      //pre[@class="-kint"]     30s

Freebie Checkout - Rebuild Stock No Variant
    Go To          ${ITM_URL}/${PRODUCT-REBUILD-STOCK-NO-VARIANT}?product_pkey=${var_freebie_main_level_d_pkey}&data_inv_id=${var_freebie_main_level_d_inventory}&debugger=1
    Wait Until Element Is Visible                      //pre[@class="-kint"]     30s

Freebie Checkout - Rebuild Stock More Than 1Variant Normal
    Go To          ${ITM_URL}/${PRODUCT-REBUILD-STOCK}?product_pkey=${var_freebie_normal_level_d_pkey}&option_pkey[0]=${var_freebie_normal_level_d_style1}&debugger=1
    Wait Until Element Is Visible                      //pre[@class="-kint"]     30s

Freebie Checkout - Rebuild Stock More Than 1Variant Normal2
    Go To          ${ITM_URL}/${PRODUCT-REBUILD-STOCK}?product_pkey=${var_freebie_normal2_level_d_pkey}&option_pkey[0]=${var_freebie_normal2_level_d_style1}&debugger=1
    Wait Until Element Is Visible                      //pre[@class="-kint"]     30s

Freebie Checkout - Choose Style Option Main Product
    Wait Until Element Is Visible              ${XPATH_LEVEL_D.div_style_type}             30s
    ${main_style}=              Convert To String               ${var_freebie_main_level_d_style1}
    ${element_main_style}=      Replace String                  ${XPATH_LEVEL_D.btn_style_option_pkey}      ^^style-option-pkey^^     ${main_style}
    Wait Until Element Is Visible              ${element_main_style}                       30s
    Click Element                              ${element_main_style}
    Wait Until Element Is Not Visible          ${LvD_LoadingImg}                           30s

Freebie Checkout - Choose Style Option Normal Product
    Wait Until Element Is Visible              ${XPATH_LEVEL_D.div_style_type}
    ${main_style}=              Convert To String               ${var_freebie_normal_level_d_style1}
    ${element_main_style}=      Replace String                  ${XPATH_LEVEL_D.btn_style_option_pkey}      ^^style-option-pkey^^   ${main_style}
    Wait Until Element Is Visible              ${element_main_style}                       30s
    Click Element                              ${element_main_style}
    Wait Until Element Is Not Visible          ${LvD_LoadingImg}                           30s

Freebie Checkout - Choose Style Option Normal2 Product
    Wait Until Element Is Visible              ${XPATH_LEVEL_D.div_style_type}
    ${main_style}=              Convert To String               ${var_freebie_normal2_level_d_style1}
    ${element_main_style}=      Replace String                  ${XPATH_LEVEL_D.btn_style_option_pkey}      ^^style-option-pkey^^   ${main_style}
    Wait Until Element Is Visible              ${element_main_style}                       30s
    Click Element                              ${element_main_style}
    Wait Until Element Is Not Visible          ${LvD_LoadingImg}                           30s

Freebie Checkout - Set Freebie On Camp
    [Arguments]         ${quantity_main}=None            ${quantity_free}=None

    ${start_timestamp}=   Convert Date To Time Stamp     -30
    ${end_timestamp}=     Convert Date To Time Stamp     60
    ${path_json}=         Convert To String              ${CURDIR}/../../../Resource/json/Freebie/camp_json_1main_1free.json
#    ${path_json}=         Convert To String              ${EXECDIR}/../../../Resource/json/Freebie/camp_json_1main_1free.json
    ${response_camp}=     Create Promotion Freebie On Camp     ${var_freebie_main_level_d_inventory}    ${quantity_main}    ${var_freebie_free_level_d_inventory}    ${quantity_free}    None    None    None    None    None    None    None      ${path_json}         ${FREEBIE-CAMPAIGN-ID}        ${start_timestamp}          ${end_timestamp}

    ${prodmotion_id}=           Get Json Value     ${response_camp}             /data/id
    Log to console      ${prodmotion_id}
    Set Test Variable           ${var_freebie_promotion_id}         ${prodmotion_id}

Freebie Checkout - Restore Remaining And Promotion
    Adjust Stock Remaining By Inventory ID       ${var_freebie_main_level_d_inventory}           ${var_freebie_main_product_remaining_old}
    Adjust Stock Remaining By Inventory ID       ${var_freebie_free_level_d_inventory}           ${var_freebie_free_product_remaining_old}
    Delete Promotion Freebie On Camp             ${var_freebie_promotion_id}

Freebie Checkout - Restore Remaining 1Main 1Free 2Normal And Promotion And Campaign
    Adjust Stock Remaining By Inventory ID       ${var_freebie_main_level_d_inventory}           ${var_freebie_main_product_remaining_old}
    Adjust Stock Remaining By Inventory ID       ${var_freebie_free_level_d_inventory}           ${var_freebie_free_product_remaining_old}
    Adjust Stock Remaining By Inventory ID       ${var_freebie_normal_level_d_inventory}         ${var_freebie_normal_product_remaining_old}
    Adjust Stock Remaining By Inventory ID       ${var_freebie_normal2_level_d_inventory}        ${var_freebie_normal2_product_remaining_old}
    Delete Promotion Freebie On Camp        ${var_freebie_promotion_id}

Freebie Checkout - Add Main Product No Style 2 Qty To Cart And Logout
    Freebie Checkout - Login And Go To Level D Product Main
    Freebie Checkout - Level D Add 2 Qty To Cart And Logout

Freebie Checkout - Add Main Product No Style 3 Qty To Cart And Logout
    Freebie Checkout - Login And Go To Level D Product Main
    Freebie Checkout - Level D Add 3 Qty To Cart And Logout

Freebie Checkout - Add Main Product has Style 2 Qty To Cart And Logout
    Freebie Checkout - Login And Go To Level D Product Main
    Freebie Checkout - Choose Style Option Main Product
    Freebie Checkout - Level D Add 2 Qty To Cart And Logout

Freebie Checkout - Add Main Product has Style 3 Qty To Cart And Logout
    Freebie Checkout - Login And Go To Level D Product Main
    Freebie Checkout - Choose Style Option Main Product
    Freebie Checkout - Level D Add 3 Qty To Cart And Logout

Freebie Checkout - Add Main Product has Style 2 Qty To Cart And Success

    Freebie Checkout - Login And Go To Level D Product Main
    Freebie Checkout - Choose Style Option Main Product
    Level D - Increase Product Quantity
    Level D - User Click Add To Cart Button
    Display Full Cart


Freebie Checkout - Login And Go To Level D Product Main
#This keyword doesn't log in naa ja :(
    Go To                   ${ITM_URL}
    Set Test Variable       ${CHECKOUT_TIMEOUT}    30s
    Sleep               3s
    Freebie Checkout - Go To Level D Main Product

Freebie Checkout - Level D Add 2 Qty To Cart And Logout
    Level D - Increase Product Quantity
    Level D - User Click Add To Cart Button
    Display Full Cart
    Logout Page - Go To Logout Page

Freebie Checkout - Level D Add 3 Qty To Cart And Logout
    Level D - Increase Product Quantity
    Sleep               3s
    Level D - Increase Product Quantity
    Sleep               3s
    Level D - User Click Add To Cart Button
    Display Full Cart
    Logout Page - Go To Logout Page

Freebie Checkout - User Login Check Item In Cart has Promotion Buy 2 Get 1
    Go To           ${ITM_URL}
    Login User to iTrueMart With User Freebie Checkout
    Click Cart Box Button
    Full Cart - Display Normal Product First Item 2 Qty
    Full Cart - Display Free Product First Item 1 Qty
    Full Cart - Display Camp Short Description

Freebie Checkout - Step 3 User Enter Valid Data Master Card
    Display All CCW Information
    User Enter Valid Card Holder Name
    Checkout 3 - User Enter Valid Credit Card Number As Master Card
    User Enter Valid CVC
    User Select Valid Card Expired
    Sleep               5s
    User Click Submit Button On Checkout3
    Sleep               5s
    Display Confirm Payment Popup
    Sleep               5s
    User Click Confirm Payment Button On Checkout3

Freebie Checkout - Step 3 User Apply Coupon And Enter Valid Data Master Card
    User Enter Coupon Code
    User Click Apply Coupon Button
    Display All CCW Information
    User Enter Valid Card Holder Name
    Checkout 3 - User Enter Valid Credit Card Number As Master Card
    User Enter Valid CVC
    User Select Valid Card Expired
    Sleep               5s
    User Click Submit Button On Checkout3
    Sleep               5s
    Display Confirm Payment Popup
    Sleep               5s
    User Click Confirm Payment Button On Checkout3

Freebie Checkout - Display Freebie Order On Thankyou Page Success
    Wait Until Element Is Visible  ${XPATH_THANKYOU.lbl_order_status_head}   60s
    Location Should Contain    /checkout/thank-you
    Thankyou - Header Display Payment Status As Success
    Freebie Checkout - Get Order ID From Thankyou Page

Freebie Checkout - Display Freebie Order On Thankyou Page Waiting
    Wait Until Element Is Visible  ${XPATH_THANKYOU.lbl_order_status_head}   60s
    Location Should Contain    /checkout/thank-you
    Thankyou - Header Display Payment Status As Waiting
    Freebie Checkout - Get Order ID From Thankyou Page

Freebie Checkout - Get Order ID From Thankyou Page
    ${order_id}=        Thankyou - Get Order ID II
    Set Test Variable  ${var_freebie_order_id}  ${order_id}
    Log to console     ${var_freebie_order_id}

Freebie Checkout - Count Stock Hold Permanent
    [Arguments]    ${expect_qty_item_to_hold}
    ${item_to_hold}=     Count Stock Hold Permanent By Order Id      ${var_freebie_order_id}
    Should Be Equal As Integers      ${expect_qty_item_to_hold}    ${item_to_hold}

Freebie Checkout - Count Stock Hold Temporary
    [Arguments]    ${expect_qty_item_to_hold}
    ${item_to_hold}=     Count Stock Hold Temporary By Order Id      ${var_freebie_order_id}
    Should Be Equal As Integers      ${expect_qty_item_to_hold}    ${item_to_hold}

Freebie Checkout - Check Order Freebie On PCMS
    [Arguments]    ${expect_qty_normal}   ${expect_qty_freebie}
#    ${var_freebie_order_id}=    Convert To String       100007550
#    ${var_freebie_promotion_id}=    Convert To String       14777
    Login Pcms
    Track Orders - Go To Order Tracker
    Track Orders - Input Search By Order ID                 ${var_freebie_order_id}
    Track Orders - Click Search Button On Order Tracker Page
    Track Orders - Click View Shipment Detail               ${var_freebie_order_id}
    Order Detail - Order Display Payment Status Success
    Order Detail - Count Order Item Type Normal             ${expect_qty_normal}
    Order Detail - Count Order Item Type Freebie            ${expect_qty_freebie}
    Order Detail - Display Promotion Camp Logs
    Order Detail - Find Camp ID On Promotion Camp Logs      ${var_freebie_promotion_id}

Freebie Checkout - Input Kbank Data On Kbank Payment Gateway
    Fill in KBank CC payment gateway and submit    MasterCard    5555555555554444    111    08    2036    Test

Freebie Checkout - Create Promotion Code Main Exclude Normal Discount Percent
    [Arguments]   ${promotion_name}   ${discount_value}
    Login Pcms
    Go To           ${PCMS_URL}/campaigns
    Camp - Filter and select Campaing in Campaign list      ${robot_campaign_ITMMZ_1211}
    Promotion - Fill Data to Create Promotion   ${promotion_name}   BPTEST   Test Detail       Test Note       500
    Promotion - Select Discount Percent      ${discount_value}
    Promotion - Select Unlimited Single Code to Create Promotion     100     BPFB
    Input Random Chars       2
    Promotion - Select Effects On Cart With Conditions          collection
    Promotion - Select Effect Collection      ${var_freebie_collection_id}
    Promotion - Select Effect Exclude Products    ${var_freebie_normal_level_d_pkey}
    Promotion - Save Promotion

Freebie Checkout - Create Promotion Code For Freebie Discount On Cart
    [Arguments]   ${promotion_name}   ${discount_value}
    Login Pcms
    Go To           ${PCMS_URL}/campaigns
    Camp - Filter and select Campaing in Campaign list      ${robot_campaign_ITMMZ_1211}
    Promotion - Fill Data to Create Promotion   ${promotion_name}   BPTEST   Test Detail       Test Note       500
    Promotion - Select Discount Percent      ${discount_value}
    Promotion - Select Unlimited Single Code to Create Promotion     100     BPFB
    Input Random Chars       2
    Promotion - Save Promotion

Freebie Checkout - Set Promotion Code For Freebie
    [Arguments]   ${promotion_name}
    Camp - Filter and select Campaing in Campaign list     ${promotion_name}
    ${code}=    Get Code From Promotion     ${promotion_name}
    Set Test Variable          ${TEST_VARIABLE_COUPON_CODE}      ${code}
    Log to console     ${TEST_VARIABLE_COUPON_CODE}
