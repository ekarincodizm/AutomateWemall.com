*** Settings ***
Library    ${CURDIR}/../../../../Python_Library/policy_library.py
Library    ${CURDIR}/../../../../Python_Library/shop_library.py
Library    ${CURDIR}/../../../../Python_Library/order_history_library.py

Library    HttpLibrary.HTTP

*** Keywords ***
Call Thankyou API
    Create Http Context    ${PCMS_API_URL}    http
    Set Request Header    Content-Type    application/json
    HttpLibrary.HTTP.GET    /api/45311375168544/payment/item?order_id=${var.order_id}&customer_ref_id=4620761&customer_type=user
    ${result}=    Get Response Body
    ${delivery_min_day}=    Get json value    ${result}    /data/shipments/0/items/0/expected_delivery_min
    ${delivery_max_day}=    Get json value    ${result}    /data/shipments/0/items/0/expected_delivery_max
    ${delivery_text}=       Get json value    ${result}    /data/order/delivery_text

    Set Test Variable    ${actual.delivery_min_day}    ${delivery_min_day}
    Set Test Variable    ${actual.delivery_max_day}    ${delivery_max_day}
    Set Test Variable    ${actual.delivery_text}    ${delivery_text}