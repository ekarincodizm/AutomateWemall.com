*** Keywords ***
Booking - Window Desktop Size
    Set Window Size      ${1500}	      ${800}

Booking - Window Mobile Size
    Set Window Size      ${500}	      ${800}

Booking - Get Product
    Set Test Variable   ${var_booking_product_inventory_id}    ${BOOKING_PREORDER_VALID.inventory_id}

Booking - Check Current Stock Remaining Product
    ${stock}=           Check Stock By Sku       ${var_booking_product_inventory_id}
    ${remaining}=       Get Json Value         ${stock}        /remaining/${var_booking_product_inventory_id}
    ${hold}=            Get Json Value         ${stock}        /hold/${var_booking_product_inventory_id}
    Set Test Variable       ${var_booking_stock_remaining_old}            ${remaining}
    Set Test Variable       ${var_booking_stock_hold_old}            ${hold}
    Log to console      inv_:${var_booking_product_inventory_id}
    Log to console      old_stock:${var_booking_stock_remaining_old}

Booking - Restore Stock Remaining Product
    Adjust Stock Remaining By Inventory ID       ${var_booking_product_inventory_id}           ${var_booking_stock_remaining_old}
    Log To Console     restore_stock:success

Booking - Adjust Stock Remaining Product
    [Arguments]         ${stock}=0
    Booking - Check Current Stock Remaining Product
    Booking Py - Check Stock Hold Booking By Inventory ID
    ${stock}=       Evaluate      ${stock}+${var_booking_stock_hold_booking}
    Adjust Stock Remaining By Inventory ID       ${var_booking_product_inventory_id}           ${stock}

Booking - Clear Cache Stock Products
    Open Browser    ${BOOKING_URL}/ajax/products?lang=en&no-cache=1
    Sleep           2s
    Go To           ${BOOKING_URL}/ajax/products?no-cache=1
    Sleep           2s

Booking Py - Get Booking Data By Booking Code
    Log To Console    come
    ${booking_data}=                Py Get Booking Data         ${var_booking_code}
    Log To Console    ${booking_data}
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

Booking Data - Check Payment Status
    [Arguments]    ${payment_status}
    Should Be Equal	    ${var_booking_payment_status}    ${payment_status}

Booking Data - Check Booking Status
    [Arguments]    ${booking_status}
    Should Be Equal	    ${var_booking_booking_status}    ${booking_status}

Booking Data - Booking Expired as Booking Date Extend 3 Month
    Should Be Equal	    ${var_booking_expired_at}    ${var_booking_booking_at_extend_3_month}

Booking Data - Booking Expired as Booking Date Extend 1 Hour
    Should Be Equal	    ${var_booking_expired_at}    ${var_booking_booking_at_extend_1_hour}
