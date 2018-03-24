*** Keywords ***
Booking Landing Page - Open Page
    Open Browser     ${BOOKING_URL}/iphone-se

Booking Landing Page - Open EN Page
    Open Browser     ${BOOKING_URL}/en/iphone-se

Booking Landing Page - Go To Page
    Open Browser     ${BOOKING_URL}/iphone-se

Booking Landing Page - Go To EN Page
    Open Browser     ${BOOKING_URL}/en/iphone-se

Booking Landing Page - Display Page
    Location Should Contain    /iphone-se

Booking Landing Page - Display EN Page
    Location Should Contain    /en/iphone-se

Booking Landing Page - Display T&C
    Wait Until Element Is Visible       ${BkLd_Terms_Conditions}      10s
    Element Should Be Visible           ${BkLd_Terms_Conditions}

Booking Landing Page - Choose Radio Accept
    Wait Until Element Is Visible      ${XPATH_BOOKING_LANDING.rdo_accept}      15s
    Click Element                      ${XPATH_BOOKING_LANDING.rdo_accept}

Booking Landing Page - Choose Radio Not Accept
    Wait Until Element Is Visible      ${XPATH_BOOKING_LANDING.rdo_not_accept}      15s
    Click Element                      ${XPATH_BOOKING_LANDING.rdo_not_accept}

Booking Landing Page - Click Button Pre-Order
    Wait Until Element Is Visible       ${BkLd_Btn_Pre_Order}      10s
    Click Element                       ${BkLd_Btn_Pre_Order}

Booking Landing Page - Click Button Accept
    Wait Until Element Is Visible      ${XPATH_BOOKING_LANDING.btn_accept}      10s
    Click Element                      ${XPATH_BOOKING_LANDING.btn_accept}

Booking Landing Page - Click Button Not Accept
    Wait Until Element Is Visible      ${XPATH_BOOKING_LANDING.btn_not_accept}      10s
    Click Element                      ${XPATH_BOOKING_LANDING.btn_not_accept}

Booking Landing Page - Display Promotion And Next
    Wait Until Element Is Visible            ${BkLd_Promotion_Btn}        15s
    Click Element                           ${BkLd_Promotion_Btn}
