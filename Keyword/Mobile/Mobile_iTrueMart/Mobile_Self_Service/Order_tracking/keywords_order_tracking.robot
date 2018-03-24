*** Settings ***
Resource          web_element_order_tracking.robot
Resource          ${CURDIR}/../../../../Common/keywords_date.robot

*** Keywords ***
SS Mobile Order Tracking - Display Order Tracking
    Wait Until Element Is Visible               ${SS_OrderTracking_Container}            15s
    Element Should Be Visible                   ${SS_OrderTracking_Container}

SS Mobile Order Tracking - Display Not Found Order
    [Arguments]         ${order_id}             ${email}
    Wait Until Element Is Visible               ${SS_OrderTracking.not_found_order_image}            15s
    Element Should Be Visible                   ${SS_OrderTracking.not_found_order_image}
    Wait Until Element Is Visible               ${SS_OrderTracking.not_found_order_txt}              15s
    ${txt_not_found_order}=                     Get Text                            ${SS_OrderTracking.not_found_order_txt}
    ${txt_not_found_order}=                     Convert To String                   ${txt_not_found_order}
    Should Contain                              ${txt_not_found_order}                    ไม่พบประวัติการสั่งซื้อของเลขที่ ${order_id}${\n}บนอีเมล์ ${email} ของคุณ

SS Mobile Order Tracking - Display Order Id
    [Arguments]         ${order_id}
    Wait Until Element Is Visible               ${SS_OrderTracking.order_id}        10s
    ${txt_order_id}=                            Get Text                            ${SS_OrderTracking.order_id}
    ${order_id}=                                Convert To String                   ${order_id}
    Should Be Equal                             ${txt_order_id}                     ${order_id}

SS Mobile Order Tracking - Display Order Date
    [Arguments]         ${order_date}
    ${order_date}=                              Convert Datetime to thai format             ${order_date}
    Wait Until Element Is Visible               ${SS_OrderTracking.order_date}      10s
    ${txt_order_date}=                          Get Text                            ${SS_OrderTracking.order_date}
    ${order_date_}=                              Convert To String                  ${order_date}
    Should Contain                             ${txt_order_date}                   วันสั่งซื้อ : ${order_date_}
#
SS Mobile Order Tracking - Display Order Sub Total
    [Arguments]         ${sub_total}
    Wait Until Element Is Visible               ${SS_OrderTracking.sub_total}       10s
    ${txt_sub_total}=                           Get Text                            ${SS_OrderTracking.sub_total}
    ${sub_total}=                               Convert To String                   ${sub_total}
    ${txt_sub_total}=                           Convert To String                   ${txt_sub_total}
    Should Contain                             ${txt_sub_total}                    มูลค่าสินค้า : ${sub_total}

SS Mobile Order Tracking - Display Order Total Item
    [Arguments]         ${total_item}
    Wait Until Element Is Visible               ${SS_OrderTracking.total_item}      10s
    ${txt_total_item}=                          Get Text                            ${SS_OrderTracking.total_item}
    ${txt_total_item}=                          Convert To String                  ${txt_total_item}
    ${total_item}=                              Convert To String                  ${total_item}
    Should Contain                              ${txt_total_item}                   จำนวน : ${total_item}

SS Mobile Order Tracking - [item] Display Product Name
    [Arguments]         ${item_id}      ${product_name}
    ${item_id}=                         Convert To String               ${item_id}
    ${element_product_name}=            Replace String                  ${SS_OrderTracking.item_product_name}       REPLACE_ITEM_ID     ${item_id}
    Wait Until Element Is Visible       ${element_product_name}         10s

SS Mobile Order Tracking - [item] Display Product Image
    [Arguments]         ${item_id}
    ${item_id}=                         Convert To String               ${item_id}
    ${element_product_image}=           Replace String                  ${SS_OrderTracking.item_product_image}       REPLACE_ITEM_ID     ${item_id}
    Wait Until Element Is Visible       ${element_product_image}         10s

SS Mobile Order Tracking - [item] Display Product Price
    [Arguments]         ${item_id}      ${product_price}
    ${item_id}=                         Convert To String               ${item_id}
    ${element_product_price}=           Replace String                  ${SS_OrderTracking.item_product_price}       REPLACE_ITEM_ID     ${item_id}
    Wait Until Element Is Visible       ${element_product_price}        10s
    ${fact_product_price}=              Get Text                        ${element_product_price}
    ${product_price}=                   Convert To String               ราคาต่อหน่วย : ${product_price} บาท
    Should Contain                      ${fact_product_price}           ${product_price}

SS Mobile Order Tracking - [item] Display Product Qty
    [Arguments]         ${item_id}      ${product_quantity}
    ${item_id}=                         Convert To String               ${item_id}
    ${element_product_quantity}=        Replace String                  ${SS_OrderTracking.item_product_quantity}       REPLACE_ITEM_ID     ${item_id}
    Wait Until Element Is Visible       ${element_product_quantity}     10s
    ${fact_product_quantity}=           Get Text                        ${element_product_quantity}
    ${product_quantity}=                Convert To String               จำนวน : ${product_quantity} ชิ้น
    Should Contain                      ${fact_product_quantity}        ${product_quantity}

SS Mobile Order Tracking - [item] Display Payment Status Customer
    [Arguments]         ${item_id}      ${payment_status_customer}
    ${item_id}=                                 Convert To String                       ${item_id}
    ${element_payment_status_customer}=         Replace String                          ${SS_OrderTracking.item_payment_status_customer}       REPLACE_ITEM_ID     ${item_id}
    Wait Until Element Is Visible               ${element_payment_status_customer}      10s
    ${fact_payment_status_customer}=            Get Text                                ${element_payment_status_customer}
    ${payment_status_customer}=                 Convert To String                       ${payment_status_customer}
    Should Contain                              ${fact_payment_status_customer}         ${payment_status_customer}

SS Mobile Order Tracking - [item] Display Item Status Customer
    [Arguments]         ${item_id}      ${item_status_customer}
    ${item_id}=                              Convert To String                          ${item_id}
    ${element_item_status_customer}=         Replace String                             ${SS_OrderTracking.item_status_customer}       REPLACE_ITEM_ID     ${item_id}
    Wait Until Element Is Visible            ${element_item_status_customer}            10s
    ${fact_item_status_customer}=            Get Text                                   ${element_item_status_customer}
    ${item_status_customer}=                 Convert To String                          ${item_status_customer}
    Should Contain                           ${fact_item_status_customer}               ${item_status_customer}

SS Mobile Order Tracking - [item] Display Tracking Details
    [Arguments]         ${item_id}      ${tracking_number}
    ${item_id}=                              Convert To String                          ${item_id}
    ${element_tracking_no}=                  Replace String                             ${SS_OrderTracking.item_txt_tracking_no}       REPLACE_ITEM_ID     ${item_id}
    ${element_tracking_title}=               Replace String                             ${SS_OrderTracking.item_title_tracking}       REPLACE_ITEM_ID     ${item_id}
    ${element_tracking_btn}=                 Replace String                             ${SS_OrderTracking.item_btn_tracking_no}        REPLACE_ITEM_ID     ${item_id}
    Wait Until Element Is Visible            ${element_tracking_no}                     10s
    Wait Until Element Is Visible            ${element_tracking_title}                  10s
    Element Should Contain                   ${element_tracking_title}                  เลขที่พัสดุ (อ้างอิง)
    Run Keyword IF                           '${tracking_number}' != 'None'             SS Mobile Order Tracking - [item] Display Tracking Number Button           ${item_id}
    ...     ELSE                             SS Mobile Order Tracking - [item] Do not Display Tracking Number Button                          ${item_id}
    ${tracking_number}=                      Run Keyword IF                             '${tracking_number}' == 'None'                  Convert To String       ยังไม่มีเลขที่พัสดุ
    ...     ELSE                             Convert To String                          ${tracking_number}
    ${fact_title_tracking}=                  Get Text                                   ${element_tracking_no}
    Should Contain                           ${tracking_number}                         ${fact_title_tracking}

SS Mobile Order Tracking - [item] Display Tracking Number
    [Arguments]         ${item_id}      ${tracking_number}
    ${item_id}=                              Convert To String                          ${item_id}
    ${element_tracking_number}=             Replace String                              ${SS_OrderTracking.item_txt_tracking_no}       REPLACE_ITEM_ID     ${item_id}
    Wait Until Element Is Visible            ${element_tracking_number}                 10s
    ${tracking_number}=                      Run Keyword IF                             '${tracking_number}' == 'None'                  Convert To String       ยังไม่มีเลขที่พัสดุ
    ...     ELSE                             Convert To String                          ${tracking_number}
    ${fact_title_tracking}=                  Get Text                                   ${element_tracking_number}
    ${fact_title_tracking}=                  Convert To String                          ${fact_title_tracking}
    Should Contain                           ${tracking_number}       ${fact_title_tracking}

SS Mobile Order Tracking - [item] Display Tracking Number Button
    [Arguments]         ${item_id}
    ${item_id}=                              Convert To String                          ${item_id}
    ${element_tracking_btn}=                 Replace String                             ${SS_OrderTracking.item_btn_tracking_no}        REPLACE_ITEM_ID     ${item_id}
    Element Should Be Visible                ${element_tracking_btn}

SS Mobile Order Tracking - [item] Do not Display Tracking Number Button
    [Arguments]         ${item_id}
    ${item_id}=                              Convert To String                          ${item_id}
    ${element_tracking_btn}=                 Replace String                             ${SS_OrderTracking.item_btn_tracking_no}        REPLACE_ITEM_ID     ${item_id}
    Element Should Not Be Visible                ${element_tracking_btn}

SS Mobile Order Tracking - [item] Display Estimated Time Shipping
    [Arguments]         ${item_id}
    ${item_id}=                              Convert To String                          ${item_id}
    ${element_title_estimated_time}=         Replace String                             ${SS_OrderTracking.item_tracking_estimated_time_shipping}       REPLACE_ITEM_ID     ${item_id}
    ${element_shipping_date}=                Replace String                             ${SS_OrderTracking.item_shipping_date}       REPLACE_ITEM_ID     ${item_id}
    Wait Until Element Is Visible            ${element_title_estimated_time}            10s
    Wait Until Element Is Visible            ${element_shipping_date}                   10s

SS Mobile Order Tracking - Display Item Details
    : FOR    ${item}    IN    @{var_order_shipment_items}
    \           ${item_id}=                     Get From Dictionary         ${item}       item_id
    \           ${inventory_id}=                Get From Dictionary         ${item}       inventory_id
    \           ${item_name}=                   Get From Dictionary         ${item}       item_name
    \           ${quantity}=                    Get From Dictionary         ${item}       quantity
    \           ${item_price}=                  Get From Dictionary         ${item}       item_price
    \           ${tracking_number}=             Get From Dictionary         ${item}       tracking_number
    \           ${payment_status_customer}=     Get From Dictionary         ${item}       payment_status_customer
    \           ${item_status_customer}=        Get From Dictionary         ${item}       item_status_customer
    \           ${total_item}=                  Get From Dictionary         ${item}       total_item
    \           Set Test Variable               ${var_order_total_item}     ${total_item}
    \           SS Mobile Order Tracking - [item] Display Product Name             ${item_id}      ${item_name}
    \           SS Mobile Order Tracking - [item] Display Product Image            ${item_id}
    \           SS Mobile Order Tracking - [item] Display Product Price            ${item_id}      ${item_price}
    \           SS Mobile Order Tracking - [item] Display Product Qty              ${item_id}      ${quantity}
    \           SS Mobile Order Tracking - [item] Display Payment Status Customer  ${item_id}      ${payment_status_customer}
    \           SS Mobile Order Tracking - [item] Display Item Status Customer     ${item_id}      ${item_status_customer}
    \           SS Mobile Order Tracking - [item] Display Tracking Details         ${item_id}      ${tracking_number}
    \           SS Mobile Order Tracking - [item] Display Estimated Time Shipping      ${item_id}

SS Mobile Order Tracking - Display Delivery Note
    Wait Until Element Is Visible           ${SS_OrderTracking.delivery_text}                   10s
    Element Should Be Visible               ${SS_OrderTracking.delivery_text}

SS Mobile Order Tracking - Display Camp short description
    Wait Until Element Is Visible           ${SS_OrderTracking.camp_short_description}            10s
    Element Should Be Visible               ${SS_OrderTracking.camp_short_description}

SS Mobile Order Tracking - Click View Tracking
    [Arguments]         ${item_id}
    ${item_id}=                              Convert To String                          ${item_id}
    ${link_tracking}=             Replace String                             ${SS_OrderTracking.item_txt_tracking_no}       REPLACE_ITEM_ID     ${item_id}
    Wait Until Element Is Visible           ${link_tracking}
    Click Element                           ${link_tracking}