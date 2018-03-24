*** Keywords ***
Booking Py - Get Booking Data By Booking Code
    ${booking_data}=                Py Get Booking Data         ${var_booking_code}
    ${id}=              Get From Dictionary     ${booking_data}      id
    ${payment_status}=              Get From Dictionary     ${booking_data}      payment_status
    ${booking_status}=              Get From Dictionary     ${booking_data}      booking_status
    ${expired_at}=                  Get From Dictionary     ${booking_data}      expired_at
    ${booking_at}=                  Get From Dictionary     ${booking_data}      booking_at
    ${booking_at_extend_3_month}=   Get From Dictionary     ${booking_data}      booking_at_3m
    ${booking_at_extend_1_hour}=    Get From Dictionary     ${booking_data}      booking_at_1hr

    Set Test Variable       ${var_booking_id}                           ${id}
    Set Test Variable       ${var_booking_payment_status}               ${payment_status}
    Set Test Variable       ${var_booking_booking_status}               ${booking_status}
    Set Test Variable       ${var_booking_expired_at}                   ${expired_at}
    Set Test Variable       ${var_booking_booking_at}                   ${booking_at}
    Set Test Variable       ${var_booking_booking_at_extend_3_month}    ${booking_at_extend_3_month}
    Set Test Variable       ${var_booking_booking_at_extend_1_hour}    ${booking_at_extend_1_hour}

    Log To Console        ${var_booking_payment_status}
    Log To Console        ${var_booking_booking_status}
    Log To Console        ${var_booking_expired_at}
    Log To Console        ${var_booking_booking_at}
    Log To Console        ${var_booking_booking_at_extend_3_month}
    Log To Console        ${var_booking_booking_at_extend_1_hour}

Booking Py - Get Billing District Name From PCMS
    ${district}=        Py Get District      ${BOOKING_PREORDER_VALID.billing_district_id}
    ${name_th}=         Get From Dictionary         ${district}      name_th
    ${name_en}=         Get From Dictionary         ${district}      name_en
    Set Test Variable       ${var_booking_bill_district_th}            ${name_th}
    Set Test Variable       ${var_booking_bill_district_en}            ${name_en}

Booking Py - Get Billing City Name From PCMS
    ${city}=        Py Get City       ${BOOKING_PREORDER_VALID.billing_city_id}
    ${name_th}=         Get From Dictionary         ${city}      name_th
    ${name_en}=         Get From Dictionary         ${city}      name_en
    Set Test Variable       ${var_booking_bill_city_th}            ${name_th}
    Set Test Variable       ${var_booking_bill_city_en}            ${name_en}

Booking Py - Get Billing Province Name From PCMS
    ${province}=        Py Get Province       ${BOOKING_PREORDER_VALID.billing_province_id}
    ${name_th}=         Get From Dictionary         ${province}      name_th
    ${name_en}=         Get From Dictionary         ${province}      name_en
    Set Test Variable       ${var_booking_bill_province_th}            ${name_th}
    Set Test Variable       ${var_booking_bill_province_en}            ${name_en}

Booking Py - Check Stock Hold Booking By Inventory ID
    [Arguments]  ${inventory_id}=${var_booking_product_inventory_id}
    ${date} =	                Get Current Date	        result_format=datetime
    ${booking_date_now}=        Convert To String           ${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}
    ${stock}=                   Py Check Stock Hold Bookings By Inventory Id       ${inventory_id}       ${booking_date_now}
    Set Test Variable           ${var_booking_stock_hold_booking}            ${stock}
    Log To Console              stock_hold_booking:${var_booking_stock_hold_booking}