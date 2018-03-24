*** Keywords ***
Booking Error Page - Display Error Content
    Wait Until Element Is Visible       ${XPATH_BOOKING_ERROR.error_content}      10s
    Element Should Be Visible           ${XPATH_BOOKING_ERROR.error_content}

Booking Error Page - Display Error Title
    Wait Until Element Is Visible       ${XPATH_BOOKING_ERROR.error_title}      10s
    Element Should Be Visible           ${XPATH_BOOKING_ERROR.error_title}

Booking Error Page - Display Error Message
    Wait Until Element Is Visible       ${XPATH_BOOKING_ERROR.error_message}      10s
    Element Should Be Visible           ${XPATH_BOOKING_ERROR.error_message}

Booking Error Page - Display Out Of Stock
    Booking Error Page - Display Error Title as Out Of Stock
    Booking Error Page - Display Error Message as Out Of Stock

Booking Error Page - Display Out Of Stock EN
    Booking Error Page - Display Error Title as Out Of Stock EN
    Booking Error Page - Display Error Message as Out Of Stock EN

Booking Error Page - Display Something Wrong
    Booking Error Page - Display Error Title as Something Wrong
    Booking Error Page - Display Error Message as Something Wrong

Booking Error Page - Display Something Wrong EN
    Booking Error Page - Display Error Title as Something Wrong EN
    Booking Error Page - Display Error Message as Something Wrong EN

Booking Error Page - Display Error Title as Out Of Stock
    Wait Until Element Is Visible   ${XPATH_BOOKING_ERROR.error_title}   10s
    Element Should Contain   ${XPATH_BOOKING_ERROR.error_title}          ${BOOKING_TRANS_TH.out_of_stock_title}

Booking Error Page - Display Error Message as Out Of Stock
    Wait Until Element Is Visible   ${XPATH_BOOKING_ERROR.error_message}   10s
    Element Should Contain   ${XPATH_BOOKING_ERROR.error_message}        ${BOOKING_TRANS_TH.out_of_stock_desc}

Booking Error Page - Display Error Title as Out Of Stock EN
    Wait Until Element Is Visible   ${XPATH_BOOKING_ERROR.error_title}   10s
    Element Should Contain   ${XPATH_BOOKING_ERROR.error_title}          ${BOOKING_TRANS_EN.out_of_stock_title}

Booking Error Page - Display Error Message as Out Of Stock EN
    Wait Until Element Is Visible   ${XPATH_BOOKING_ERROR.error_message}   10s
    Element Should Contain   ${XPATH_BOOKING_ERROR.error_message}        ${BOOKING_TRANS_EN.out_of_stock_desc}

Booking Error Page - Display Error Title as Something Wrong
    Wait Until Element Is Visible   ${XPATH_BOOKING_ERROR.error_title}   10s
    Element Should Contain   ${XPATH_BOOKING_ERROR.error_title}          ${BOOKING_TRANS_TH.wrong_title}

Booking Error Page - Display Error Message as Something Wrong
    Wait Until Element Is Visible   ${XPATH_BOOKING_ERROR.error_message}   10s
    Element Should Contain   ${XPATH_BOOKING_ERROR.error_message}        ${BOOKING_TRANS_TH.wrong_desc}

Booking Error Page - Display Error Title as Something Wrong EN
    Wait Until Element Is Visible   ${XPATH_BOOKING_ERROR.error_title}   10s
    Element Should Contain   ${XPATH_BOOKING_ERROR.error_title}          ${BOOKING_TRANS_EN.wrong_title}

Booking Error Page - Display Error Message as Something Wrong EN
    Wait Until Element Is Visible   ${XPATH_BOOKING_ERROR.error_message}   10s
    Element Should Contain   ${XPATH_BOOKING_ERROR.error_message}        ${BOOKING_TRANS_EN.wrong_desc}


