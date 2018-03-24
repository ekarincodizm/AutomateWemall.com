*** Settings ***
Library    Collections
Library    HttpLibrary.HTTP
Library    ${CURDIR}/../../../../Python_Library/message_library.py
Library    ${CURDIR}/../../../../Python_Library/variant_library.py

Resource   web_element_email_sms.robot
Resource   ${CURDIR}/../../../../Keyword/API/PCMS/Product/update_stock.robot

*** Keywords ***
Expect Email Step1 With Delivery Time And Text
    [Arguments]    ${order_id}    ${customer_email}    ${delivery_min}    ${delivery_max}    ${delivery_text}
    ${delivery_time}=  Set Variable    ${delivery_min} - ${delivery_max}
    ${count_message}=  get_email_by_delivery    ${order_id}    ${customer_email}    ${delivery_time}    ${delivery_text}
    Log To Console    ====== Expect Email Delivery Time ====== ${delivery_time}
    Log To Console    ====== Expect Email Delivery Text ====== ${delivery_text}
    Log To Console    ====== Expect Email count row tbl message ====== ${count_message}

    Should Be True    ${count_message} > 0

Expect Email Step1 With Delivery Text And Time Is The Same Min-Max Date
    [Arguments]    ${order_id}    ${customer_email}    ${delivery_min}    ${delivery_max}    ${delivery_text}
    Should Be Equal    ${delivery_min}    ${delivery_max}
    ${delivery_time}=  Set Variable    ${delivery_max}
    ${count_message}=  get_email_by_delivery    ${order_id}    ${customer_email}    ${delivery_time}    ${delivery_text}
    Should Be True    ${count_message} > 0

Expect Sms Delivery Time
    [Arguments]     ${order_id}    ${delivery_min}    ${delivery_max}
    ${delivery_txt}=    Set Variable    ${delivery_min} - ${delivery_max}
    ${count}=    py_get_sms_by_delivery_txt    ${order_id}    thankyou-page    ${delivery_txt}
    Should Be True    ${count}>0

Expect Email Has Two Item With Delivery Time And Text
    [Arguments]    ${delivery_min_day_1}=09 มิ.ย. 69
    ...            ${delivery_min_day_2}=10 มิ.ย. 69
    ...            ${delivery_max_day_1}=16 มิ.ย. 69
    ...            ${delivery_max_day_2}=12 มิ.ย. 69
    ...            ${delivery_text}=หากสั่งสินค้ามากกว่า 1 ชิ้น ระยะเวลาจัดส่งจะขึ้นกับระยะจัดส่งของสินค้าที่ระยะจัดส่งนานที่สุด หรือ อาจมีการแยกจัดส่ง โดยตัวแทนจำหน่ายหรือไปรษณีย์ไทย

    Expect Email Step1 With Delivery Time And Text    ${var.order_id}    ${customer_email}    ${delivery_min_day_1}    ${delivery_max_day_1}    ${delivery_text}
    Expect Email Step1 With Delivery Time And Text    ${var.order_id}    ${customer_email}    ${delivery_min_day_2}    ${delivery_max_day_2}    ${delivery_text}

Expect Sms Delivery Time With Combined Date For Two Items
    [Arguments]    ${delivery_min}=3
    ...            ${delivery_max}=7

    Expect Sms Delivery Time    ${var.order_id}    ${delivery_min}    ${delivery_max}

Prepare Two Variants
    @{product_id}=    get_two_available_product_id_from_variant
    Log to console  product_id_list=${product_id}
    ${inventory_id_1}=    get_inventory_id_from_product_id    @{product_id}[0]
    ${inventory_id_2}=    get_inventory_id_from_product_id    @{product_id}[1]
    ${backup_shop_id_1}=    get_original_shop_id_by_inventory_id    ${inventory_id_1}
    ${backup_shop_id_2}=    get_original_shop_id_by_inventory_id    ${inventory_id_2}

    #Log to console   backup_shop_id_2=${backup_shop_id_2}

    Set Test Variable    ${var.inventory_id_1}    ${inventory_id_1}
    Set Test Variable    ${var.inventory_id_2}    ${inventory_id_2}
    Set Test Variable    ${var.backup_shop_id_1}    ${backup_shop_id_1}
    Set Test Variable    ${var.backup_shop_id_2}    ${backup_shop_id_2}

    Wemall Common - Assign Value To Test Variable  backup_shop_id_1  ${backup_shop_id_1}
    Wemall Common - Assign Value To Test Variable  backup_shop_id_2  ${backup_shop_id_2}

    Adjust Stock Remaining By Inventory ID    ${inventory_id_1}    10
    Adjust Stock Remaining By Inventory ID    ${inventory_id_2}    10

    Log To Console   ----backup_shop_id_1=${var.backup_shop_id_1}----
    Log To Console   ----backup_shop_id_2=${var.backup_shop_id_2}----
    Log To Console   ----inventory_id_1=${inventory_id_1}----
    Log To Console   ----inventory_id_2=${inventory_id_2}----
    Log To Console  ===== Prepare Two Variants ======

    Wemall Common - Assign Value To Test Variable  inv_id_1   ${inventory_id_1}
    Wemall Common - Assign Value To Test Variable  inv_id_2   ${inventory_id_2}

    assign_shop_id_to_existing_inventory_id    ${var.shop_id_1}    ${var.inventory_id_1}
    assign_shop_id_to_existing_inventory_id    ${var.shop_id_2}    ${var.inventory_id_2}

Email Sms - Assign Backup Shop Id Back To Variant
    assign_shop_id_to_existing_inventory_id    ${var.backup_shop_id_1}    ${var.inventory_id_1}
    assign_shop_id_to_existing_inventory_id    ${var.backup_shop_id_2}    ${var.inventory_id_2}

Delete Log Email And Sms From Table Message By Order Id
    [Arguments]    ${order_id}
    ${result}=  delete_message_by_order    ${order_id}

Set Expect Variable TH
    ${delivery_text}=  Set Variable    หากสั่งสินค้ามากกว่า 1 ชิ้น ระยะเวลาจัดส่งจะขึ้นกับระยะจัดส่งของสินค้าที่ระยะจัดส่งนานที่สุด หรือ อาจมีการแยกจัดส่ง โดยตัวแทนจำหน่ายหรือไปรษณีย์ไทย

    Set Expect Delivery Min    09 มิ.ย. 69
    Set Expect Delivery Max    16 มิ.ย. 69
    Set Expect Delivery Text    ${delivery_text}

Set Expect Variable EN
    ${delivery_text}=  Set Variable    If you order more than 1 item, estimate delivery time will up to the item which has the longest delivery time or it will ship separately by supplier or Thai post.

    Set Expect Delivery Min
    Set Expect Delivery Max
    Set Expect Delivery Text    ${delivery_text}

Set Expect Delivery Min
    [Arguments]    ${delivery_min_day}=09 Jun 26
    Set Test Variable    ${expect.delivery_min_day}    ${delivery_min_day}

Set Expect Delivery Max
    [Arguments]    ${delivery_max_day}=16 Jun 26
    Set Test Variable    ${expect.delivery_max_day}    ${delivery_max_day}

Set Expect Delivery Text
    [Arguments]    ${delivery_text}
    Set Test Variable    ${expect.delivery_text}       ${delivery_text}

Delete Inserted Email-Sms
    Delete Log Email And Sms From Table Message By Order Id    ${var.order_id}

Email SMS - Get Message Email Thankyou By Order Id
    [Arguments]     ${order_id}
    ${message_thankyou}=    get_email_thankyou          ${order_id}
    ${subject}=             Convert To String        @{message_thankyou}[0]
    ${send_to}=             Convert To String        @{message_thankyou}[1]
    ${channel}=             Convert To String        @{message_thankyou}[2]
    ${content}=             Convert To String        @{message_thankyou}[3]
    Set Test Variable       ${var_email_thankyou_subject}        ${subject}
    Set Test Variable       ${var_email_thankyou_send_to}        ${send_to}
    Set Test Variable       ${var_email_thankyou_channel}        ${channel}
    Set Test Variable       ${var_email_thankyou_content}        ${content}

Email SMS - Get Message Email Repeat After Success By Order Id
    [Arguments]     ${order_id}
    ${message_after_success}=    get_email_after_success          ${order_id}
    ${subject}=             Convert To String        @{message_after_success}[0]
    ${send_to}=             Convert To String        @{message_after_success}[1]
    ${channel}=             Convert To String        @{message_after_success}[2]
    ${content}=             Convert To String        @{message_after_success}[3]
    Set Test Variable       ${var_email_thankyou_subject}        ${subject}
    Set Test Variable       ${var_email_thankyou_send_to}        ${send_to}
    Set Test Variable       ${var_email_thankyou_channel}        ${channel}
    Set Test Variable       ${var_email_thankyou_content}        ${content}

Email SMS - Get Message Email Register TruemoveH By Order Id
    [Arguments]     ${order_id}
    ${message_thankyou}=    get_email_register_truemoveh          ${order_id}
    ${subject}=             Convert To String        @{message_thankyou}[0]
    ${send_to}=             Convert To String        @{message_thankyou}[1]
    ${channel}=             Convert To String        @{message_thankyou}[2]
    ${content}=             Convert To String        @{message_thankyou}[3]
    Set Test Variable       ${var_email_register_tmvh_subject}        ${subject}
    Set Test Variable       ${var_email_register_tmvh_send_to}        ${send_to}
    Set Test Variable       ${var_email_register_tmvh_channel}        ${channel}
    Set Test Variable       ${var_email_register_tmvh_content}        ${content}

Email SMS - Get Message Email Activate Sim Success TruemoveH By Order Id
    [Arguments]     ${order_id}
    ${message_activate_success}=    get_email_activate_success_truemoveh          ${order_id}
    ${subject}=             Convert To String        @{message_activate_success}[0]
    ${send_to}=             Convert To String        @{message_activate_success}[1]
    ${channel}=             Convert To String        @{message_activate_success}[2]
    ${content}=             Convert To String        @{message_activate_success}[3]
    Set Test Variable       ${var_email_activate_sim_tmvh_subject}        ${subject}
    Set Test Variable       ${var_email_activate_sim_tmvh_send_to}        ${send_to}
    Set Test Variable       ${var_email_activate_sim_tmvh_channel}        ${channel}
    Set Test Variable       ${var_email_activate_sim_tmvh_content}        ${content}

Email SMS - Get Message Email Activate Sim Fail TruemoveH By Order Id
    [Arguments]     ${order_id}
    ${message_activate_fail}=    get_email_activate_fail_truemoveh          ${order_id}
    ${subject}=             Convert To String        @{message_activate_fail}[0]
    ${send_to}=             Convert To String        @{message_activate_fail}[1]
    ${channel}=             Convert To String        @{message_activate_fail}[2]
    ${content}=             Convert To String        @{message_activate_fail}[3]
    Set Test Variable       ${var_email_activate_sim_tmvh_subject}        ${subject}
    Set Test Variable       ${var_email_activate_sim_tmvh_send_to}        ${send_to}
    Set Test Variable       ${var_email_activate_sim_tmvh_channel}        ${channel}
    Set Test Variable       ${var_email_activate_sim_tmvh_content}        ${content}

Email SMS - Get Message SMS Thankyou By Order Id
    [Arguments]     ${order_id}
    ${message_thankyou}=    get_sms_thankyou        ${order_id}
    ${subject}=             Convert To String         @{message_thankyou}[0]
    ${send_to}=             Convert To String         @{message_thankyou}[1]
    ${channel}=             Convert To String         @{message_thankyou}[2]
    ${content}=             Convert To String         @{message_thankyou}[3]
    ${response}=            Convert To String         @{message_thankyou}[4]
    Set Test Variable       ${var_sms_thankyou_subject}        ${subject}
    Set Test Variable       ${var_sms_thankyou_send_to}        ${send_to}
    Set Test Variable       ${var_sms_thankyou_channel}        ${channel}
    Set Test Variable       ${var_sms_thankyou_content}        ${content}
    Set Test Variable       ${var_sms_thankyou_response}       ${response}

Email SMS - Get Message SMS Repeat After Success By Order Id
    [Arguments]     ${order_id}
    ${message_after_success}=    get_sms_thankyou        ${order_id}
    ${subject}=             Convert To String         @{message_after_success}[0]
    ${send_to}=             Convert To String         @{message_after_success}[1]
    ${channel}=             Convert To String         @{message_after_success}[2]
    ${content}=             Convert To String         @{message_after_success}[3]
    ${response}=            Convert To String         @{message_after_success}[4]
    Set Test Variable       ${var_sms_thankyou_subject}        ${subject}
    Set Test Variable       ${var_sms_thankyou_send_to}        ${send_to}
    Set Test Variable       ${var_sms_thankyou_channel}        ${channel}
    Set Test Variable       ${var_sms_thankyou_content}        ${content}
    Set Test Variable       ${var_sms_thankyou_response}       ${response}

Email SMS - Email Thankyou Content without iTruemart
    Should Not Contain	        ${var_email_thankyou_content}        ${MSG_EMAIL.itruemart}
    Should Not Contain	        ${var_email_thankyou_content}        ${MSG_EMAIL.iTrueMart}
    Should Not Contain	        ${var_email_thankyou_content}        ${MSG_EMAIL.iTruemart}

Email SMS - Email Thankyou Content has Wemall
    Should Contain	            ${var_email_thankyou_content}        ${MSG_EMAIL.wemall}
    Should Contain	            ${var_email_thankyou_content}        ${MSG_EMAIL.WeMall}
    Should Contain	            ${var_email_thankyou_content}        ${MSG_EMAIL.WeMall}

Email SMS - Email Thankyou Content Show Logo Wemall
    Should Contain	            ${var_email_thankyou_content}        ${URL_LOGO_WEMALL}

Email SMS - Email Thankyou Content Not Show Logo iTrueMart
    Should Not Contain          ${var_email_thankyou_content}        ${URL_LOGO_ITRUEMART}
    Should Not Contain          ${var_email_thankyou_content}        ${URL_LOGO_ITRUEMART_2}

Email SMS - Email Thankyou Content Display Thank for Order
    Should Contain	            ${var_email_thankyou_content}        ${MSG_EMAIL.thank_for_order}

Email SMS - Email Thankyou Content Not Display Thank for Order with iTrueMart
    Should Not Contain          ${var_email_thankyou_content}        ${MSG_EMAIL.thank_for_order_with_itm}

Email SMS - Email Thankyou Content Display Support Wemall
    Should Contain	            ${var_email_thankyou_content}        ${MSG_EMAIL.support_wemall}

Email SMS - Email Thankyou Content Not Display Support iTrueMart
    Should Not Contain          ${var_email_thankyou_content}        ${MSG_EMAIL.support_itruemart}

Email SMS - Email Thankyou Content Display Reference
    Should Contain	            ${var_email_thankyou_content}        ${MSG_EMAIL.order_reference}

Email SMS - Email Thankyou Content Not Display Reference with iTrueMart
    Should Not Contain          ${var_email_thankyou_content}        ${MSG_EMAIL.order_reference_itm}

Email SMS - SMS Thankyou Sender as Wemall
    Should Contain	            ${var_sms_thankyou_response}        ${SMS_SENDER_WEMALL}

Email SMS - SMS Thankyou Sender not iTrueMart
    Should Not Contain          ${var_sms_thankyou_response}        ${SMS_SENDER_ITRUEMART}

Email SMS - Email Thankyou Content Display Thank for Order EN
    Should Contain	            ${var_email_thankyou_content}        ${MSG_EMAIL_EN.thank_for_order}

Email SMS - Email Thankyou Content Not Display Thank for Order with iTrueMart EN
    Should Not Contain          ${var_email_thankyou_content}        ${MSG_EMAIL_EN.thank_for_order_with_itm}

Email SMS - Email Thankyou Content Display Reference EN
    Should Contain	            ${var_email_thankyou_content}        ${MSG_EMAIL_EN.order_reference}

Email SMS - Email Thankyou Content Not Display Reference with iTrueMart EN
    Should Not Contain          ${var_email_thankyou_content}        ${MSG_EMAIL_EN.order_reference_itm}

## Register Sim and Bundle ##
Email SMS - Email Register TruemoveH Content Show Logo Wemall
    Should Contain	            ${var_email_register_tmvh_content}        ${URL_LOGO_WEMALL}

Email SMS - Email Register TruemoveH Content Not Show Logo iTrueMart
    Should Not Contain          ${var_email_register_tmvh_content}        ${URL_LOGO_ITRUEMART}
    Should Not Contain          ${var_email_register_tmvh_content}        ${URL_LOGO_ITRUEMART_2}

Email SMS - Email Register TruemoveH Content wemall.com
    Should Contain	            ${var_email_register_tmvh_content}        ${MSG_EMAIL.wemall_dot_com}

Email SMS - Email Register TruemoveH Content not itruemart.com
    Should Not Contain	        ${var_email_register_tmvh_content}        ${MSG_EMAIL.itruemart_dot_com}

Email SMS - Email Register TruemoveH Content not iTrueMart.com ucwords
    Should Not Contain          ${var_email_register_tmvh_content}        ${MSG_EMAIL.itruemart_dot_com_ucwords}

## Activate Sim ##
Email SMS - Email Activate Sim TruemoveH Content Show Logo Wemall
    Should Contain	            ${var_email_activate_sim_tmvh_content}        ${URL_LOGO_WEMALL}

Email SMS - Email Activate Sim TruemoveH Content Not Show Logo iTrueMart
    Should Not Contain          ${var_email_activate_sim_tmvh_content}        ${URL_LOGO_ITRUEMART}
    Should Not Contain          ${var_email_activate_sim_tmvh_content}        ${URL_LOGO_ITRUEMART_2}

Email SMS - Email Activate Sim TruemoveH Content wemall.com
    Should Contain	            ${var_email_activate_sim_tmvh_content}        ${MSG_EMAIL.wemall_dot_com}

Email SMS - Email Activate Sim TruemoveH Content not itruemart.com
    Should Not Contain	        ${var_email_activate_sim_tmvh_content}        ${MSG_EMAIL.itruemart_dot_com}

Email SMS - Email Activate Sim TruemoveH Content not iTrueMart.com ucwords
    Should Not Contain          ${var_email_activate_sim_tmvh_content}        ${MSG_EMAIL.itruemart_dot_com_ucwords}
