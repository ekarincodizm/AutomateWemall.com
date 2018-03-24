*** Keywords ***

Booking Pre-Order Page - Verify Display Cutomer Info
    [Arguments]    ${lang}=th    ${product_name}=''
    Page Should Contain    ${var_random_id_card}          10s
    Page Should Contain    ${BOOKING_PREORDER_VALID.firstname}           10
    Page Should Contain    ${BOOKING_PREORDER_VALID.customer_tel}    10
    Page Should Contain    ${BOOKING_PREORDER_VALID.customer_email}    10
    Run Keyword IF    '${lang}' == 'th'    Page Should Contain    ${product_name}    10
    ...    ELSE    Page Should Contain    ${product_name}    10

Booking Pre-Order Page - Verify Display Billing Address Same Shipping
    [Arguments]    ${lang}=th
    Page Should Contain    ${BOOKING_PREORDER_VALID.customer_address_no}    10
    Page Should Contain    ${BOOKING_PREORDER_VALID.customer_address_moo}    10
    Page Should Contain    ${BOOKING_PREORDER_VALID.customer_address_village}    10
    Page Should Contain    ${BOOKING_PREORDER_VALID.customer_address_floor}    10
    Page Should Contain    ${BOOKING_PREORDER_VALID.customer_address_soi}    10
    Page Should Contain    ${BOOKING_PREORDER_VALID.customer_address_road}    10
    Run Keyword If    '${lang}' == 'th'    Run Keywords    Page Should Contain    ${BOOKING_PREORDER_VALID.customer_province_name}    10
    ...    AND    Page Should Contain    ${BOOKING_PREORDER_VALID.customer_city_name}    10
    ...    AND    Page Should Contain    ${BOOKING_PREORDER_VALID.customer_district_name}    10
    ...    ELSE    Run Keywords    Page Should Contain    ${BOOKING_PREORDER_VALID.customer_province_name_en}    10
    ...    AND    Page Should Contain    ${BOOKING_PREORDER_VALID.customer_city_name_en}    10
    ...    AND    Page Should Contain    ${BOOKING_PREORDER_VALID.customer_district_name_en}    10

Booking Pre-Order Page - Verify Display Billing Address Not Same Shipping
    [Arguments]    ${lang}=th
    Page Should Contain    ${BOOKING_PREORDER_VALID.customer_billing_no}    10
    Page Should Contain    ${BOOKING_PREORDER_VALID.customer_billing_moo}    10
    Page Should Contain    ${BOOKING_PREORDER_VALID.customer_billing_village}    10
    Page Should Contain    ${BOOKING_PREORDER_VALID.customer_billing_floor}    10
    Page Should Contain    ${BOOKING_PREORDER_VALID.customer_billing_soi}    10
    Page Should Contain    ${BOOKING_PREORDER_VALID.customer_billing_road}    10
    Run Keyword If    '${lang}' == 'th'    Run Keywords    Page Should Contain    ${BOOKING_PREORDER_VALID.customer_billing_province_name}    10
    ...    AND    Page Should Contain    ${BOOKING_PREORDER_VALID.customer_billing_city_name}    10
    ...    AND    Page Should Contain    ${BOOKING_PREORDER_VALID.customer_billing_district_name}    10
    ...    ELSE    Run Keywords    Page Should Contain    ${BOOKING_PREORDER_VALID.customer_billing_province_name_en}    10
    ...    AND    Page Should Contain    ${BOOKING_PREORDER_VALID.customer_billing_city_name_en}    10
    ...    AND    Page Should Contain    ${BOOKING_PREORDER_VALID.customer_billing_district_name_en}    10

Booking Pre-Order Page - Goto Page 3
    [Arguments]    ${lang}=th    ${type}=web    ${address}=shipping
    Run Keyword IF    '${lang}' == 'th'    Booking Terms and Conditions Page - Open Page
    ...    ELSE    Booking Terms and Conditions Page - Open EN Page

    Run Keyword IF    '${type}' == 'web'    Maximize Browser Window
    ...    ELSE    Booking - Window Mobile Size

    Booking Terms and Conditions Page - Choose Radio Accept
    Booking Terms and Conditions Page - Click Next

    Run Keyword IF    '${lang}' == 'th'    Booking Pre-Order Page - Verify Page
    ...    ELSE    Booking Pre-Order Page - Verify EN Page

    Booking Pre-Order Page - Display All Input
    Booking Pre-Order Page - User Enter Valid Identification Document

    ${product_name}=    Run Keyword IF    '${lang}' == 'th'    Booking Pre-Order Page - User Select Product Model
    ...    ELSE    Booking Pre-Order Page - User Select Product Model EN

    Booking Pre-Order Page - User Choose Handset Only
    Booking Pre-Order Page - User Enter Valid Address

    Run Keyword If    '${address}' == 'billing'    Run Keywords    Booking Pre-Order Page - Click Billing Checkbox
    ...    AND    Booking Pre-Order Page - Display All Billing Input
    ...    AND    Booking Pre-Order Page - User Enter Valid Billing Address

    Booking Pre-Order Page - Click Button Next
    [Return]    ${product_name}
    
Booking Pre-Order Page - Goto Page 3 Bundle
    [Arguments]    ${lang}=th    ${type}=web    ${address}=shipping
    Run Keyword IF    '${lang}' == 'th'    Booking Terms and Conditions Page - Open Page
    ...    ELSE    Booking Terms and Conditions Page - Open EN Page

    Run Keyword IF    '${type}' == 'web'    Maximize Browser Window
    ...    ELSE    Booking - Window Mobile Size

    Booking Terms and Conditions Page - Choose Radio Accept
    Booking Terms and Conditions Page - Click Next

    Run Keyword IF    '${lang}' == 'th'    Booking Pre-Order Page - Verify Page
    ...    ELSE    Booking Pre-Order Page - Verify EN Page

    Booking Pre-Order Page - Display All Input
    Booking Pre-Order Page - User Enter Valid Identification Document

    Run Keyword IF    '${lang}' == 'th'    Booking Pre-Order Page - User Select Product Model
    ...    ELSE    Booking Pre-Order Page - User Select Product Model EN

    Booking Pre-Order Page - User Choose Bundle
    Booking Pre-Order Page - User Enter Valid Address

    Run Keyword If    '${address}' == 'billing'    Run Keywords    Booking Pre-Order Page - Click Billing Checkbox
    ...    AND    Booking Pre-Order Page - Display All Billing Input
    ...    AND    Booking Pre-Order Page - User Enter Valid Billing Address

    Booking Pre-Order Page - Click Button Next
