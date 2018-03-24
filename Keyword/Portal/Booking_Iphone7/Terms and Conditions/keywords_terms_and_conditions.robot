*** Keywords ***
Booking Terms and Conditions Page - Open Page
    Open Browser     ${BOOKING_URL}/iphone7/term-and-conditions    Chrome
    #Open Browser     http://thor-www.itruemart-dev.com:89/referer.html    Chrome
    #Sleep    5s
    #Click Element    xpath=/html/body/a[3]
    #Select Window    url=${BOOKING_URL}iphone7/term-and-conditions

Booking Terms and Conditions Page - Open EN Page
    Open Browser     ${BOOKING_URL}/en/iphone7/term-and-conditions    Chrome
    #Open Browser     http://thor-www.itruemart-dev.com:89/referer.html    Chrome
    #Sleep    5s
    #Click Element    xpath=/html/body/a[4]
    #Select Window    url=${BOOKING_URL}en/iphone7/term-and-conditions

Booking Terms and Conditions Page - Go To Page
    Go To     ${BOOKING_URL}/iphone7/term-and-conditions

Booking Terms and Conditions Page - Go To EN Page
    Go To     ${BOOKING_URL}/en/iphone7/term-and-conditions

Booking Terms and Conditions Page - Verify URL
    Location Should Contain    /iphone7

Booking Terms and Conditions Page - Verify EN URL
    Location Should Contain    /en/iphone7

Booking Terms and Conditions Page - Display T&C
    Wait Until Element Is Visible       ${BkLd_Terms_Conditions}      10s
    Element Should Be Visible           ${BkLd_Terms_Conditions}

Booking Terms and Conditions Page - Choose Radio Accept
    #Wait Until Element Is Visible      ${accept_radio_button}      15s
    Click Element                      ${accept_radio_button}

Booking Terms and Conditions Page - Choose Radio Not Accept
    #Wait Until Element Is Visible      ${not_accept_radio_button}      15s
    Click Element                      ${not_accept_radio_button}

Booking Terms and Conditions Page - Click Back
    Wait Until Element Is Visible       ${landing_back_button}      10s
    Click Element                       ${landing_back_button}

Booking Terms and Conditions Page - Click Next
    Wait Until Element Is Visible      ${landing_next_button}      10s
    Click Element                      ${landing_next_button}

Booking Terms and Conditions Page - Verify Alert Message
    Wait Until Element Is Visible      id=popup-error      10s
    Page Should Contain    กรุณาเลือกยอมรับเงื่อนไข เพื่อดำเนินการขั้นตอนต่อไป    10s

Booking Terms and Conditions Page - EN - Verify Alert Message
    Wait Until Element Is Visible      id=popup-error      10s
    Page Should Contain    Please indicate that you have read and agree to the Terms and Conditions    10s

Booking Terms and Conditions Page - Close Alert Message
    Click Element                      jquery=[data-dismiss="modal"]

