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
