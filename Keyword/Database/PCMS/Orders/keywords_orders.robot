*** Settings ***
Library           Selenium2Library
Library           Collections
Library           String
Library           ${CURDIR}/../../../../Python_Library/order_shipment_items_library.py
Library           ${CURDIR}/../../../../Python_Library/order.py
Library           ${CURDIR}/../../../../Python_Library/OrderLibrary.py
Library           ${CURDIR}/../../../../Python_Library/DatabaseData.py

*** Keywords ***
Order Shipment Items - Get Item Id By Order Id and Inventory Id
    [Arguments]    ${order_id}    ${inventory_id}
    ${order_shipment_items}=    get_item_id    ${order_id}    ${inventory_id}
    ${item_id}=    Convert To String    @{order_shipment_items}[0]
    Log To Console    ${item_id}
    Return From Keyword    ${item_id}

Verify Shipping Fee in DB - Order Table
    [Arguments]    ${order_id}    ${shipping_fee}
    ${shipping_fee_data}=     get_shipping_fee_in_order   ${order_id}
    Should Not Be Empty  ${shipping_fee_data}
    Should Be Equal As Integers   ${shipping_fee}   ${shipping_fee_data[0]}

Orders - Update Order Expired
    [Arguments]         ${order_id}
    ${datetime}=        Get Current Date            result_format=datetime
    ${new_datetime}=	Subtract Time From Date	    ${datetime}	                5 hours
    ${exp_datetime}=	Convert Date	            ${new_datetime}	            result_format=%Y-%m-%d %H:%M:%S
    ${result}=          update_order_expired        ${order_id}                 ${exp_datetime}
    Log To Console      update_order_expired=${result}

Orders - Clear Expired Order
    #Open Browser                ${PCMS_URL}/command/clear-online-expired-order          ${BROWSER}
    Open Browser                ${PCMS_URL}/command/clear-expired-orders          ${BROWSER}

Orders - Get Lasted Order By Customer Ref Id
    [Arguments]         ${customer_ref_id}
    #${order}=   py_get_lasted_order_by_customer_ref_id   ${customer_ref_id}
    ${order}=    get_latest_order_by_customer_ref_id   ${customer_ref_id}
    [Return]   ${order}

Orders - Is All Shipment Items Have Delivered Status
    [Arguments]   ${items_list}
    ${result}=    check_all_shipment_items_have_delivered_status    ${items_list}
    [return]  ${result}

Order Shipment Item - Update Create At Change Time Backwords
    [Arguments]         ${item_id}    ${back_time}
    ${datetime}=        Get Current Date            result_format=datetime
    ${new_datetime}=    Subtract Time From Date     ${datetime}                 ${back_time}
    ${transaction_datetime}=    Convert Date                ${new_datetime}             result_format=%Y-%m-%d %H:%M:%S
    ${result}=          py_update_order_item_create_at        ${item_id}                 ${transaction_datetime}
    Log To Console      update_order_item_create_at=${result}

Order - Get Random Bundle Order With Payment Status Success
    ${order_id}=    get_random_bundle_order_with_payment_status_success
    [Return]    ${order_id}   

Orders - Get Order on PCMS
    ${orders}=                  py_get_orders
    ${order_id}=                Get From Dictionary     ${orders}       order_id
    ${customer_email}=          Get From Dictionary     ${orders}       customer_email
    ${sub_total}=               Get From Dictionary     ${orders}       sub_total
    ${created_at}=              Get From Dictionary     ${orders}       created_at
    Set Test Variable           ${var_order_id}                         ${order_id}
    Set Test Variable           ${var_order_customer_email}             ${customer_email}
    Set Test Variable           ${var_order_sub_total}                  ${sub_total}
    Set Test Variable           ${var_order_date}                       ${created_at}
    Log To Console              get_order_id=${var_order_id}

Orders - Get Order Shipment Item By Order Id
    [Arguments]         ${order_id}
    ${items}=           py_get_order_shipment_items_by_order_id         ${order_id}
    Set Test Variable           ${var_order_shipment_items}             ${items}

Orders - Get Order on PCMS by Order ID
    [Arguments]         ${order_id}
    ${orders}=                  py_get_order_by_order_id                ${order_id}
    ${order_id}=                Get From Dictionary     ${orders}       order_id
    ${customer_email}=          Get From Dictionary     ${orders}       customer_email
    ${sub_total}=               Get From Dictionary     ${orders}       sub_total
    ${created_at}=              Get From Dictionary     ${orders}       created_at
    ${customer_name}=           Get From Dictionary     ${orders}       customer_name
    ${customer_address}=        Get From Dictionary     ${orders}       customer_address
    ${customer_district}=       Get From Dictionary     ${orders}       customer_district
    ${customer_city}=           Get From Dictionary     ${orders}       customer_city
    ${customer_province}=       Get From Dictionary     ${orders}       customer_province
    ${customer_postcode}=       Get From Dictionary     ${orders}       customer_postcode
    ${customer_tel}=            Get From Dictionary     ${orders}       customer_tel
    Set Test Variable           ${var_order_id}                         ${order_id}
    Set Test Variable           ${var_order_customer_email}             ${customer_email}
    Set Test Variable           ${var_order_sub_total}                  ${sub_total}
    Set Test Variable           ${var_order_date}                       ${created_at}
    Set Test Variable           ${var_order_customer_name}              ${customer_name}
    Set Test Variable           ${var_order_customer_address}           ${customer_address}
    Set Test Variable           ${var_order_customer_district}          ${customer_district}
    Set Test Variable           ${var_order_customer_city}              ${customer_city}
    Set Test Variable           ${var_order_customer_province}          ${customer_province}
    Set Test Variable           ${var_order_customer_postcode}          ${customer_postcode}
    Set Test Variable           ${var_order_customer_tel}               ${customer_tel}
    Log To Console              get_order_id=${var_order_id}

Orders - Get Order on PCMS by Customer Tel
    [Arguments]         ${customer_tel}
    ${orders}=                  py_get_order_by_customer_tel                ${customer_tel}
    ${order_id}=                Get From Dictionary     ${orders}       order_id
    Set Test Variable           ${var_order_id}                         ${order_id}
    Log To Console              get_order_id=${var_order_id}


