*** Settings ***
Library           ../../../Python_Library/order_history_library.py
Library           ../../../Python_Library/message_library.py
# Library           ../../../Python_Library/product.py
Library           ../../../Python_Library/variant_library.py

Resource          ../../../Resource/Config/${ENV}/Env_config.robot
Resource          ../../../Resource/Config/${ENV}/database.robot


*** Variables ***
${customer_ref_id}    27145880
${customer_email}     robotautomate@gmail.com
${order_status}       new
${payment_status}     success
${order_created_at}   '2026-06-06 05:00:00'
${lang_code}          th
${payment_method}     1

*** Keywords ***
Prepare Order
    [Arguments]   ${customer_ref_id}=${customer_ref_id}   ${email}=${customer_email}    ${payment_method}=${payment_method}    ${order_status}=${order_status}    ${payment_status}=${payment_status}    ${lang}=${lang_code}    ${order_date}=${order_created_at}

    Log TO Console  customer_ref_id=${customer_ref_id}   customer_email=${customer_email}

    ${inventory_id}=    get_available_inventory_id
    ${order_id}=    insert_order    ${customer_ref_id}    ${email}    ${payment_method}    ${order_status}    ${payment_status}    ${lang}    ${order_created_at}
    Set test variable    ${var.order_id}    ${order_id}
    ${shipment_id}=    insert_order_shipment    ${var.order_id}    ${order_date}
    Set test variable    ${var.shipment_id}    ${shipment_id}
    ${shipment_item_id}=    insert_order_shipment_item    ${var.order_id}    ${var.shipment_id}    None    ${order_date}    ${inventory_id}

    Log To Console    get_inventory_normal = ${inventory_id}

    Set test variable    ${var.shipment_item_id}    ${shipment_item_id}
    Set test variable    ${var.product_inventory_id}    ${inventory_id}
    insert_order_billing    ${var.order_id}
    Log to console    order_id=${var.order_id}
    [Return]    ${var.order_id}

Prepare Order Wrong Image path
    ${image}=    Set Variable    //cdn-p3.itruemart-dev.com/pcms/uploads/14-10-30/73f1daf122492feddc3d7a25c56ed148_s.jpg
    ${order_id}=    insert_order    ${customer_ref_id}    ${customer_email}
    ${order_shipment_id}=    insert_order_shipment    ${order_id}
    ${order_shipment_item_id}=    insert_order_shipment_item    ${order_id}    ${order_shipment_id}    ${image}
    [Return]    ${order_id}

DB Order - Prepare Clear Order
    ${order_id}=   Get Order By Created At   ${order_created_at}
    Log To Console   order_created_at=${order_created_at}
    Log To Console   order_id=${order_id}
    ${rp}=   delete_order_with_condition     ${order_created_at}   created_at
    Log To Console   rp=${rp}


Remove Order
    [Arguments]    ${order_id}=${var.order_id}
    Log To Console   ---------delete_order=${order_id}----------
    delete_order    ${order_id}
    delete_order_shipment    ${order_id}
    delete_order_shipment_item    ${order_id}
    delete_order_billing    ${order_id}

Call Payment Detail API
    [Arguments]    ${order_id}    ${customer_ref_id}    ${customer_type}
    Create Http Context    ${PCMS_API_URL}    http
    Set Request Header    Content-Type    application/json
    HttpLibrary.HTTP.GET    /api/45311375168544/payment/detail?order_id=${order_id}&customer_ref_id=${customer_ref_id}&customer_type=${customer_type}
    ${result}=    Get Response Body
    # pcms.itruemart-dev.com/api/45311375168544/payment/detail?customer_ref_id= customer_type= order_id=
    [Return]    ${result}

Prepare Order Which Has Two Items With Different Shop Id
    [Arguments]   ${customer_ref_id}=${customer_ref_id}   ${email}=${customer_email}    ${payment_method}=${payment_method}    ${order_status}=${order_status}    ${payment_status}=${payment_status}    ${lang}=${lang_code}    ${order_date}=${order_created_at}

    ${order_id}=    insert_order    ${customer_ref_id}    ${email}    ${payment_method}    ${order_status}    ${payment_status}    ${lang}    ${order_created_at}

    Set test variable    ${var.order_id}    ${order_id}

    ${shipment_id}=    insert_order_shipment    ${var.order_id}    ${order_date}
    Set test variable    ${var.shipment_id}    ${shipment_id}

    ${shipment_item_id_1}=    insert_order_shipment_item    ${var.order_id}    ${var.shipment_id}    None    ${order_date}    ${var.inventory_id_1}    ${var.shop_id_1}
    ${shipment_item_id_1}=    insert_order_shipment_item    ${var.order_id}    ${var.shipment_id}    None    ${order_date}    ${var.inventory_id_2}    ${var.shop_id_2}

    Set test variable    ${var.shipment_item_id_1}    ${shipment_item_id_1}
    Set test variable    ${var.shipment_item_id_1}    ${shipment_item_id_1}
    insert_order_billing    ${var.order_id}
    Log to console    order_id=${var.order_id}
    [Return]    ${var.order_id}

Send Mail And Sms Using Payment Detail API
    Call Payment Detail API    ${var.order_id}   ${customer_ref_id}    ${customer_type}