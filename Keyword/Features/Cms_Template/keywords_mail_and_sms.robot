*** Variables ***
${blackpanther_username}       blackpantherautomate@gmail.com
${blackpanther_password}       true1234

*** Keywords ***
Cms Template Mail Sms - Login and Clear Cart
    User Login From login page      ${blackpanther_username}       ${blackpanther_password}
    Clear Cart Current User

Cms Template Mail Sms - Prepare Product Installment
    Cms Template Prepare Data - Get Product Installment
    Cms Template Mail Sms - Set Old Stock For Restore
    Adjust Stock Remaining By Inventory ID       ${var_mail_sms_product_inventory_id}           ${product_stock}
    Go To          ${ITM_URL}/${PRODUCT-REBUILD-STOCK-NO-VARIANT}?product_pkey=${var_mail_sms_product_pkey}&data_inv_id=${var_mail_sms_product_inventory_id}&debugger=1
    Wait Until Element Is Visible                      //pre[@class="-kint"]     30s

Cms Template Mail Sms - Prepare Product COD
    Cms Template Prepare Data - Get Product COD
    Cms Template Mail Sms - Set Old Stock For Restore
    Adjust Stock Remaining By Inventory ID       ${var_mail_sms_product_inventory_id}           ${product_stock}
    Go To          ${ITM_URL}/${PRODUCT-REBUILD-STOCK-NO-VARIANT}?product_pkey=${var_mail_sms_product_pkey}&data_inv_id=${var_mail_sms_product_inventory_id}&debugger=1
    Wait Until Element Is Visible                      //pre[@class="-kint"]     30s

Cms Template Mail Sms - Buy Product
    Go To       ${ITM_URL}/products/item-${var_mail_sms_product_pkey}.html
    Sleep           5s
    Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    User Click First Member Address
    Checkout3 - Display Checkout Step3 Page

Cms Template Mail Sms - Buy Product EN
    Go To       ${ITM_URL}/en/products/item-${var_mail_sms_product_pkey}.html
    Sleep           5s
    Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    User Click First Member Address
    Checkout3 - Display Checkout Step3 Page

Cms Template Mail Sms - Checkout with CCW
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

Cms Template Mail Sms - Checkout with CCW Faied
    Display All CCW Information
    User Enter Valid Card Holder Name
    User Enter Invalid Credit Card Number
    User Enter Valid CVC
    User Select Valid Card Expired
    Sleep               5s
    User Click Submit Button On Checkout3
    Sleep               5s
    Display Confirm Payment Popup
    Sleep               5s
    User Click Confirm Payment Button On Checkout3

Cms Template Mail Sms - Checkout with Installment
    User Click Payment Channel Installment Tab
    Checkout3 - Wait Loading
    Cms Template Mail Sms - Installment payment and Submit    กสิกรไทย    @value='10'
    Fill in KBank CC payment gateway and submit    MasterCard    5555555555554444    111    08    2036    Test

Cms Template Mail Sms - Checkout with Installment EN
    User Click Payment Channel Installment Tab
    Checkout3 - Wait Loading
    Cms Template Mail Sms - Installment payment and Submit    Kasikorn Bank    @value='10'
    Fill in KBank CC payment gateway and submit    MasterCard    5555555555554444    111    08    2036    Test

Cms Template Mail Sms - Checkout with Installment Failed
    User Click Payment Channel Installment Tab
    Checkout3 - Wait Loading
    Cms Template Mail Sms - Installment payment and Submit    กสิกรไทย    @value='10'
    Fill in KBank CC payment gateway and submit    MasterCard    5555555555554441    111    08    2036    Test

Cms Template Mail Sms - Checkout with Installment Failed EN
    User Click Payment Channel Installment Tab
    Checkout3 - Wait Loading
    Cms Template Mail Sms - Installment payment and Submit    Kasikorn Bank    @value='10'
    Fill in KBank CC payment gateway and submit    MasterCard    5555555555554441    111    08    2036    Test

Cms Template Mail Sms - Checkout with COD
    Checkout3 - COD payment same address and Submit

Cms Template Mail Sms - Checkout with Counter Service
    Checkout3 - Counter Service payment and Submit

Cms Template Mail Sms - Get Order Id From Thankyou Page
   Thankyou - Display Header
   ${order_id}=             Thankyou - Get Order ID II
   Set Test Variable        ${var_mail_sms_order_id}       ${order_id}
   Log to console           order_id=${var_mail_sms_order_id}

Cms Template Mail Sms - Get Message Email Thankyou
    ${message_thankyou}=    Email - Get Message Thankyou By Order Id       ${var_mail_sms_order_id}
    ${subject}=             Convert To String        @{message_thankyou}[0]
    ${send_to}=             Convert To String        @{message_thankyou}[1]
    ${channel}=             Convert To String        @{message_thankyou}[2]
    ${content}=             Convert To String        @{message_thankyou}[3]
    Set Test Variable       ${var_email_subject}        ${subject}
    Set Test Variable       ${var_email_send_to}        ${send_to}
    Set Test Variable       ${var_email_channel}        ${channel}
    Set Test Variable       ${var_email_content}        ${content}

Cms Template Mail Sms - Expect Email Thankyou Content without iTrueMart
    Email SMS - Get Message Email Thankyou By Order Id              ${var_mail_sms_order_id}
    Email SMS - Email Thankyou Content without iTruemart
    Email SMS - Email Thankyou Content Not Show Logo iTrueMart

Cms Template Mail Sms - Expect Email Thankyou Content has Wemall
    Email SMS - Get Message Email Thankyou By Order Id              ${var_mail_sms_order_id}
    Email SMS - Email Thankyou Content has Wemall
    Email SMS - Email Thankyou Content Show Logo Wemall

Cms Template Mail Sms - Expect Email Thankyou iTrueMart Changed to Wemall
    Email SMS - Get Message Email Thankyou By Order Id              ${var_mail_sms_order_id}
    Email SMS - Get Message SMS Thankyou By Order Id                ${var_mail_sms_order_id}
    Email SMS - Email Thankyou Content Show Logo Wemall
    Email SMS - Email Thankyou Content Not Show Logo iTrueMart
    Email SMS - Email Thankyou Content Display Support Wemall
    Email SMS - Email Thankyou Content Not Display Support iTrueMart
    Email SMS - Email Thankyou Content Display Reference
    Email SMS - Email Thankyou Content Not Display Reference with iTrueMart
    Email SMS - SMS Thankyou Sender as Wemall
    Email SMS - SMS Thankyou Sender not iTrueMart

Cms Template Mail Sms - Expect Email Thankyou iTrueMart Changed to Wemall EN
    Email SMS - Get Message Email Thankyou By Order Id              ${var_mail_sms_order_id}
    Email SMS - Get Message SMS Thankyou By Order Id                ${var_mail_sms_order_id}
    Email SMS - Email Thankyou Content Show Logo Wemall
    Email SMS - Email Thankyou Content Not Show Logo iTrueMart
    Email SMS - Email Thankyou Content Display Support Wemall
    Email SMS - Email Thankyou Content Not Display Support iTrueMart
    Email SMS - Email Thankyou Content Display Reference EN
    Email SMS - Email Thankyou Content Not Display Reference with iTrueMart EN
    Email SMS - SMS Thankyou Sender as Wemall
    Email SMS - SMS Thankyou Sender not iTrueMart

Cms Template Mail Sms - Expect Email Register TruemoveH iTrueMart Changed to Wemall
    Sleep           7s
    Email SMS - Get Message Email Register TruemoveH By Order Id            ${var_mail_sms_order_id}
#    Email SMS - Email Register TruemoveH Content Show Logo Wemall
#    Email SMS - Email Register TruemoveH Content Not Show Logo iTrueMart
#    Email SMS - Email Register TruemoveH Content wemall.com
#    Email SMS - Email Register TruemoveH Content not itruemart.com
    Email SMS - Email Register TruemoveH Content not iTrueMart.com ucwords

Cms Template Mail Sms - Expect Email Activat Sim Success TruemoveH iTrueMart Changed to Wemall
    Sleep           7s
    Email SMS - Get Message Email Activate Sim Success TruemoveH By Order Id            ${var_mail_sms_order_id}
#    Email SMS - Email Activate Sim TruemoveH Content Show Logo Wemall
#    Email SMS - Email Activate Sim TruemoveH Content Not Show Logo iTrueMart
#    Email SMS - Email Activate Sim TruemoveH Content wemall.com
#    Email SMS - Email Activate Sim TruemoveH Content not itruemart.com
    Email SMS - Email Activate Sim TruemoveH Content not iTrueMart.com ucwords

Cms Template Mail Sms - Expect Email Activat Sim Fail TruemoveH iTrueMart Changed to Wemall
    Sleep           7s
    Email SMS - Get Message Email Activate Sim Fail TruemoveH By Order Id               ${var_mail_sms_order_id}
#    Email SMS - Email Activate Sim TruemoveH Content Show Logo Wemall
#    Email SMS - Email Activate Sim TruemoveH Content Not Show Logo iTrueMart
#    Email SMS - Email Activate Sim TruemoveH Content wemall.com
#    Email SMS - Email Activate Sim TruemoveH Content not itruemart.com
    Email SMS - Email Activate Sim TruemoveH Content not iTrueMart.com ucwords

Cms Template Mail Sms - Go To Level D To Buy Product
	Go To  ${ITM_URL}/products/item-${var_mail_sms_product_pkey}.html
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   20
	Click Add to Cart
    User Click Next Process On Full Cart

Cms Template Mail Sms - Go To Level D To Buy Product (EN)
	Go To  ${ITM_URL}/en/products/item-${var_mail_sms_product_pkey}.html
	Wait Until Element Is Not Visible   ${LvD_LoadingImg}   20
	Sleep           5s
	Click Add to Cart
	Display Full Cart
    User Click Next Process On Full Cart

Cms Template Mail Sms - Get Order ID After Thank You
    ${order_id}=   Thankyou - Get Order ID II
    Set Test Variable       ${var_mail_sms_order_id}           ${order_id}
    Log To Console          order_id=${var_mail_sms_order_id}

Cms Template Mail Sms - Restore
    Adjust Stock Remaining By Inventory ID      ${var_mail_sms_product_inventory_id}           ${var_mail_sms_remaining_old}

Cms Template Mail Sms - Set Stock
    Adjust Stock Remaining By Inventory ID      ${var_mail_sms_product_inventory_id}      100

Cms Template Mail Sms - Set Old Stock For Restore
    ${stock}=         Check Stock By Sku       ${var_mail_sms_product_inventory_id}
    ${remaining}=       Get Json Value         ${stock}        /remaining/${var_mail_sms_product_inventory_id}
    ${hold}=            Get Json Value         ${stock}        /hold/${var_mail_sms_product_inventory_id}
    Set Test Variable       ${var_mail_sms_remaining_old}            ${remaining}
    Set Test Variable       ${var_mail_sms_remaining_old}            ${hold}

Cms Template Mail Sms - Add Product Sim To Cart
    keywords_prepare_bundle.Random Id Card
    Get TruemoveH Data For Search Available Mobile Number Sim
    Get TruemoveH Mobile Id For Sim     ${var_tmh_sim_mobile_province_id}   ${var_tmh_sim_mobile_type}
    ${mobile_id}=        Convert To String              ${var_tmh_sim_mobile_id}
    ${price_plan}=       Convert To String              ${var_tmh_sim_mobile_price_plan_id}
    ${id_card}=          Convert To String              ${var_random_id_card}
    ${customer_type}=    Convert To String              ${TV_user_group}
    ${customer_type}=    Replace String Using Regexp    ${customer_type}    "    ${EMPTY}
    ${path_json}=         Convert To String              ${CURDIR}/../../../Resource/json/add_sim_to_cart.json
    ${response}=   API Cart - Add Sim    ${var_tmh_sim_inventory_id}   ${TV_user_id}   ${customer_type}   ${mobile_id}   ${id_card}   ${price_plan}   None   None   ${path_json}
    Set Test Variable     ${var_response_add_sim_to_cart}     ${response}

Cms Template Mail Sms - Approve Thai ID
    Login Pcms
    Set Window Size             ${1500}          ${800}
    TMVH Order Report - Go To TruemoveH Order Report
    TMVH Order Report - Input Search By Order ID                ${var_mail_sms_order_id}
    TMVH Order Report - Click Search Button On Order Tracker Page
    TMVH Order Report - Click Verify Thai ID                    ${var_mail_sms_order_id}
    TMVH Verify Thai ID - Click Approve

Cms Template Mail Sms - Update Status to Shipped
    Track Orders - Go To Order Tracker
    Track Orders - Input Search By Order ID                         ${var_mail_sms_order_id}
    Track Orders - Click Search Button On Order Tracker Page
    Track Orders - Click View Shipment Detail                       ${var_mail_sms_order_id}
    Order Detail - Change All Items Status To Pending Shipment      ${var_mail_sms_order_id}
    Order Detail - Change All Items Status To Shipped               ${var_mail_sms_order_id}

Cms Template Mail Sms - Activate Sim to Status Success
    [Arguments]    ${dealer_id}=0
    Activate Sim Report - Go To TruemoveH Activate Sim Report
    Activate Sim Report - Input Search By Order ID                      ${var_mail_sms_order_id}
    Run Keyword If    ${dealer_id} != 0    Activate Sim Report - Dropdown Search By Dealer    ${dealer_id}
    Activate Sim Report - Click Search Button
    ${item_id}=         Order Shipment Items - Get Item Id By Order Id and Inventory Id     ${var_mail_sms_order_id}        ${var_tmh_sim_inventory_id}
    Activate Sim Report - Change Activate Status To Success             ${item_id}            12345

Cms Template Mail Sms - Activate Sim to Status Blacklist
    Activate Sim Report - Go To TruemoveH Activate Sim Report
    Activate Sim Report - Input Search By Order ID                      ${var_mail_sms_order_id}
    Activate Sim Report - Click Search Button
    ${item_id}=         Order Shipment Items - Get Item Id By Order Id and Inventory Id     ${var_mail_sms_order_id}        ${var_tmh_sim_inventory_id}
    Activate Sim Report - Change Activate Status To Blacklist             ${item_id}            test remark

Cms Template Mail Sms - Expect Email Repeat After Success iTrueMart Changed to Wemall
    Email SMS - Get Message Email Repeat After Success By Order Id       ${var_mail_sms_order_id}
    Email SMS - Get Message SMS Repeat After Success By Order Id         ${var_mail_sms_order_id}
    Email SMS - Email Thankyou Content Show Logo Wemall
    Email SMS - Email Thankyou Content Not Show Logo iTrueMart
    Email SMS - Email Thankyou Content Display Support Wemall
    Email SMS - Email Thankyou Content Not Display Support iTrueMart
    Email SMS - Email Thankyou Content Display Reference
    Email SMS - Email Thankyou Content Not Display Reference with iTrueMart
    Email SMS - SMS Thankyou Sender as Wemall
    Email SMS - SMS Thankyou Sender not iTrueMart

Cms Template Mail Sms - Expect Email Repeat After Success iTrueMart Changed to Wemall EN
    Email SMS - Get Message Email Repeat After Success By Order Id       ${var_mail_sms_order_id}
    Email SMS - Get Message SMS Repeat After Success By Order Id         ${var_mail_sms_order_id}
    Email SMS - Email Thankyou Content Show Logo Wemall
    Email SMS - Email Thankyou Content Not Show Logo iTrueMart
    Email SMS - Email Thankyou Content Display Support Wemall
    Email SMS - Email Thankyou Content Not Display Support iTrueMart
    Email SMS - Email Thankyou Content Display Reference EN
    Email SMS - Email Thankyou Content Not Display Reference with iTrueMart EN
    Email SMS - SMS Thankyou Sender as Wemall
    Email SMS - SMS Thankyou Sender not iTrueMart

Cms Template Mail Sms - Installment payment and Submit
    [Arguments]    ${installment_provider}    ${installment_plan}
    Checkout3 - Select payment channal    ${Payment_Channal_Installment}
    Sleep       5s
    Checkout3 - Installment Select installment provider    ${installment_provider}
    Sleep       5s
    Checkout3 - Installment Select installment plan    ${installment_plan}
    Sleep       5s
    Wait Until Element Is Visible           ${Submit_Checkout3}         30s
    Click Element                           ${Submit_Checkout3}
    Wait Until Element Is Not Visible       ${Checkout3_LoadingImg}     20s
    Sleep       5s
    Wait Until Element Is Visible           ${Checkout3_ConfirmBtn}     30s
    Click Element                           ${Checkout3_ConfirmBtn}
    Wait Until Element Is Not Visible       ${Checkout3_LoadingImg}     20s
