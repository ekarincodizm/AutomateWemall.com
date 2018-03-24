*** Settings ***
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           OperatingSystem
Library           String
Library           DateTime
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Orders/keywords_orders.robot
Resource          ${CURDIR}/../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Self_Service/keywords_common.robot
Resource          ${CURDIR}/../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Self_Service/Main_form/keywords_main_form.robot
Resource          ${CURDIR}/../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Self_Service/Order_tracking/keywords_order_tracking.robot
Resource          ${CURDIR}/../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Self_Service/Order_tracking/keywords_shipping_details.robot
Resource          ${CURDIR}/../../../Keyword/Common/keywords_itruemart_common.robot

Suite Teardown    Close All Browsers
*** Test Cases ***
TC_ITMWM_01227 [Mobile] Display shipping details after item status = shipped
    [Tags]  TC_ITMWM_01227   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100048144
    SS Mobile Common - Open Self Service And Select Topic Order Tracking
    SS Mobile Main Form - Input Email                  ${var_order_customer_email}
    SS Mobile Main Form - Input Order Id               ${var_order_id}
    SS Mobile Main Form - Click Next Step
    SS Mobile Order Tracking - Display Order Tracking
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
    SS Mobile Order Tracking - [item] Display Tracking Details             ${var_item_id}          ${var_item_tracking_number}
    SS Mobile Order Tracking - Click View Tracking                         ${var_item_id}
    SS Mobile Shipping Details - Display Shipping Title
    SS Mobile Shipping Details - Display Order Info
    SS Mobile Shipping Details - Display Shipping Step Info
    SS Mobile Shipping Details - Display Close Button

TC_ITMWM_01228 [Mobile] Display shipping details after item status = delivered
    [Tags]  TC_ITMWM_01228   regression   ready   ITMMZ-1295   ITMMZ-1296   BP-2016S13   blackpanther
    Orders - Get Order on PCMS by Order ID      100012037
    SS Mobile Common - Open Self Service And Select Topic Order Tracking
    SS Mobile Main Form - Input Email                  ${var_order_customer_email}
    SS Mobile Main Form - Input Order Id               ${var_order_id}
    SS Mobile Main Form - Click Next Step
    SS Mobile Order Tracking - Display Order Tracking
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
    SS Mobile Order Tracking - [item] Display Tracking Details             ${var_item_id}          ${var_item_tracking_number}
    SS Mobile Order Tracking - Click View Tracking                         ${var_item_id}
    SS Mobile Shipping Details - Display Shipping Title
    SS Mobile Shipping Details - Display Order Info
    SS Mobile Shipping Details - Display Shipping Step Info
    SS Mobile Shipping Details - Display Close Button
