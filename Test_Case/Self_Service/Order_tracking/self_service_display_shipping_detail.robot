*** Settings ***
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           OperatingSystem
Library           String
Library           DateTime
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Orders/keywords_orders.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Self_Service/keywords_common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Self_Service/Main_form/keywords_main_form.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Self_Service/Order_tracking/keywords_order_tracking.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Self_Service/Order_tracking/keywords_shipping_details.robot
Resource          ${CURDIR}/../../../Keyword/Common/keywords_itruemart_common.robot

Suite Teardown    Close All Browsers
*** Test Cases ***
TC_ITMWM_01198 Display shipping details after item status = shipped
    [Tags]  TC_ITMWM_01198   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100048144
    SS Common - Open Wemall and Select Topic Order Tracking
    SS Main Form - Input Email                  ${var_order_customer_email}
    SS Main Form - Input Order Id               ${var_order_id}
    SS Main Form - Click Next Step
    SS Order Tracking - Display Order Tracking
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
    : FOR    ${item}    IN    @{var_order_shipment_items}
    \           ${item_id}=                     Get From Dictionary         ${item}       item_id
#    \           Continue For Loop If            ${item_id} != 4994420
    \           ${item_name}=                   Get From Dictionary         ${item}       item_name
    \           ${quantity}=                    Get From Dictionary         ${item}       quantity
    \           ${tracking_number}=             Get From Dictionary         ${item}       tracking_number
    \           Set Test Variable               ${var_item_id}                            ${item_id}
    \           Set Test Variable               ${var_item_name}                          ${item_name}
    \           Set Test Variable               ${var_item_tracking_number}               ${tracking_number}
    \           Set Test Variable               ${var_item_quantity}                      ${quantity}
    SS Order Tracking - [item] Display Tracking Details             ${var_item_id}          ${var_item_tracking_number}
    SS Order Tracking - Click View Tracking                         ${var_item_id}
    SS Shipping Details - Display Shipping Step
    SS Shipping Details - Display Caption as Data and shipping status
    SS Shipping Details - Display Product Name                      ${var_item_name}
    SS Shipping Details - Display Product Qty                       ${var_item_quantity}
    SS Shipping Details - Display Customer Name                     ${var_order_customer_name}
    SS Shipping Details - Display Customer Adderss
    SS Shipping Details - Display Customer Tel                      ${var_order_customer_tel}
    SS Common - [Modal] Display Back Button
    SS Common - [Modal] Do not Display Live Chat Button
    SS Common - [Modal] Do not Display Success Button

TC_ITMWM_01199 Display shipping details after item status = delivered
    [Tags]  TC_ITMWM_01199   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100012037
    SS Common - Open Wemall and Select Topic Order Tracking
    SS Main Form - Input Email                  ${var_order_customer_email}
    SS Main Form - Input Order Id               ${var_order_id}
    SS Main Form - Click Next Step
    SS Order Tracking - Display Order Tracking
    Orders - Get Order Shipment Item By Order Id    ${var_order_id}
    : FOR    ${item}    IN    @{var_order_shipment_items}
    \           ${item_id}=                     Get From Dictionary         ${item}       item_id
    \           ${item_name}=                   Get From Dictionary         ${item}       item_name
    \           ${quantity}=                    Get From Dictionary         ${item}       quantity
    \           ${tracking_number}=             Get From Dictionary         ${item}       tracking_number
    \           Set Test Variable               ${var_item_id}                            ${item_id}
    \           Set Test Variable               ${var_item_name}                          ${item_name}
    \           Set Test Variable               ${var_item_tracking_number}               ${tracking_number}
    \           Set Test Variable               ${var_item_quantity}                      ${quantity}
    SS Order Tracking - [item] Display Tracking Details             ${var_item_id}          ${var_item_tracking_number}
    SS Order Tracking - Click View Tracking                         ${var_item_id}
    SS Shipping Details - Display Shipping Step
    SS Shipping Details - Display Caption as Data and shipping status
    SS Shipping Details - Display Product Name                      ${var_item_name}
    SS Shipping Details - Display Product Qty                       ${var_item_quantity}
    SS Shipping Details - Display Customer Name                     ${var_order_customer_name}
    SS Shipping Details - Display Customer Adderss
    SS Shipping Details - Display Customer Tel                      ${var_order_customer_tel}
    SS Common - [Modal] Display Back Button
    SS Common - [Modal] Do not Display Live Chat Button
    SS Common - [Modal] Do not Display Success Button
