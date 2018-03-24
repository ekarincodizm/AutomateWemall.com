*** Keywords ***
PCMS Booking - Go To Report Booking Page
    Go To        ${PCMS_URL}/bookings

PCMS Booking - Go To Report TMVH Order Booking Page
    Go To        ${PCMS_URL}/booking/orders_booking

PCMS Booking - Go To Report TMVH Order Tracking Page
    Go To        ${PCMS_URL}/booking/order_tracking

PCMS Booking - Search By Booking Code
    [Arguments]    ${booking_code}
    Wait Until Element Is Visible       ${XPATH_PCMS_BOOKING.input_booking_code}    10s
    Wait Until Element Is Visible       ${XPATH_PCMS_BOOKING.btn_search}            10s
    Input Text        ${XPATH_PCMS_BOOKING.input_booking_code}     ${booking_code}
    Click Element     ${XPATH_PCMS_BOOKING.btn_search}

PCMS Booking - Report Booking Display Payment Success By Booking ID
    [Arguments]    ${booking_id}=${var_booking_id}
    ${element}=       Replace String    ${XPATH_PCMS_BOOKING.lbl_payment_status_bk_id}    ^^booking_id^^    ${booking_id}
    Wait Until Element Is Visible       ${element}          10s
    Element Should Contain              ${element}          success

PCMS Booking - Report Booking Display Payment Waiting By Booking ID
    [Arguments]    ${booking_id}=${var_booking_id}
    ${element}=       Replace String    ${XPATH_PCMS_BOOKING.lbl_payment_status_bk_id}    ^^booking_id^^    ${booking_id}
    Wait Until Element Is Visible       ${element}          10s
    Element Should Contain              ${element}          waiting

PCMS Booking - TMVH Order Booking Display No Data
    Wait Until Element Is Visible       ${XPATH_PCMS_BOOKING_TMVH_BOOKING.td_no_data}    10s
    Element Should Be Visible           ${XPATH_PCMS_BOOKING_TMVH_BOOKING.td_no_data}

PCMS Booking - TMVH Order Tracking Display No Data
    Wait Until Element Is Visible       ${XPATH_PCMS_BOOKING_TMVH_TRACKING.td_no_data}    10s
    Element Should Be Visible           ${XPATH_PCMS_BOOKING_TMVH_TRACKING.td_no_data}