*** Keywords ***
Booking ThankYou Page - Display EN Page
    Location Should Contain    /en/iphone-se/pre-order/thank-you/

Booking ThankYou Page - Display Page
    Location Should Contain    /iphone-se/pre-order/thank-you/

Booking ThankYou Page - Display ThankYou Success
    [Arguments]    ${product_type}      ${lang}
    Wait Until Element Is Visible       ${BkThankyou_Success}          60s
    Element Should Be Visible           ${BkThankyou_Success}
    Run Keyword IF    '${product_type}' == 'normal'    Booking ThankYou Page - Verify Display Cutomer Info     ${lang}
        ...    ELSE    Booking ThankYou Page - Verify Display Cutomer Info With Bundle     ${lang}
    Booking ThankYou Page - Verify Display Billing Address Same Shipping        ${lang}
    Booking ThankYou Page - Get Payment Status Success      ${lang}

Booking ThankYou Page - Display ThankYou Waiting
    Wait Until Element Is Visible       ${BkThankyou_Waiting1}          10s
    Element Should Be Visible           ${BkThankyou_Waiting1}
    Wait Until Element Is Visible       ${BkThankyou_Waiting2}          10s
    Element Should Be Visible           ${BkThankyou_Waiting2}

Booking ThankYou Page - Display ThankYou Fail
    [Arguments]    ${product_type}      ${lang}
    Wait Until Element Is Visible       ${BkThankyou_Fail1}          10s
    Element Should Be Visible           ${BkThankyou_Fail1}
    Run Keyword IF    '${product_type}' == 'normal'    Booking ThankYou Page - Verify Display Cutomer Info     ${lang}
        ...    ELSE    Booking ThankYou Page - Verify Display Cutomer Info With Bundle     ${lang}
    Booking ThankYou Page - Verify Display Billing Address Same Shipping        ${lang}
    Booking ThankYou Page - Get Payment Status Fail     ${lang}

Booking ThankYou Page - Display Button Re-Query
    Wait Until Element Is Visible       ${BkThankyou_BtnReQuery}          10s
    Element Should Be Visible           ${BkThankyou_BtnReQuery}

Booking ThankYou Page - Display Button Contact Call Center
    Wait Until Element Is Visible       ${BkThankyou_BtnContactCLT}          10s
    Element Should Be Visible           ${BkThankyou_BtnContactCLT}

Booking ThankYou Page - Display Customer Data
    Booking ThankYou Page - Display Person ID As Value To Random ID Card
    Booking ThankYou Page - Display Customer Name As Test Data Value
    Booking ThankYou Page - Display Customer Tel As Test Data Value
    Booking ThankYou Page - Display Customer Email As Test Data Value

Booking ThankYou Page - Display Billing Data
    Booking ThankYou Page - Display Bill Address As Test Data Value
    Booking ThankYou Page - Display Bill District As Value in PCMS
    Booking ThankYou Page - Display Bill City As Value in PCMS
    Booking ThankYou Page - Display Bill Province As Value in PCMS
    Booking ThankYou Page - Display Bill Postcode As Test Data Value

Booking ThankYou Page - Display Billing Data EN
    Booking ThankYou Page - Display Bill Address As Test Data Value
    Booking ThankYou Page - Display Bill District As Value in PCMS EN
    Booking ThankYou Page - Display Bill City As Value in PCMS EN
    Booking ThankYou Page - Display Bill Province As Value in PCMS EN
    Booking ThankYou Page - Display Bill Postcode As Test Data Value

Booking ThankYou Page - Display Booking Data
    Booking ThankYou Page - Display Date of Booking As Value To Date Now
    Booking ThankYou Page - Display Deposit

Booking ThankYou Page - Display Booking Data EN
    Booking ThankYou Page - Display Date of Booking As Value To Date Now EN
    Booking ThankYou Page - Display Deposit EN

Booking ThankYou Page - Display Device Data
    Wait Until Element Is Visible   ${XPATH_BOOKING_THANKYOU.lbl_product_name}   10s
    Element Should Contain   ${XPATH_BOOKING_THANKYOU.lbl_product_name}          ${var_booking_product_name}
    Wait Until Element Is Visible   ${XPATH_BOOKING_THANKYOU.lbl_booking_product_name}   10s
    Element Should Contain   ${XPATH_BOOKING_THANKYOU.lbl_booking_product_name}          ${var_booking_product_name}

Booking ThankYou Page - Display Device Data on Mobile Size
    Wait Until Element Is Visible   ${XPATH_BOOKING_THANKYOU.lbl_product_name_mobile}   10s
    Element Should Contain   ${XPATH_BOOKING_THANKYOU.lbl_product_name_mobile}          ${var_booking_product_name}
    Wait Until Element Is Visible   ${XPATH_BOOKING_THANKYOU.lbl_booking_product_name}   10s
    Element Should Contain   ${XPATH_BOOKING_THANKYOU.lbl_booking_product_name}          ${var_booking_product_name}

Booking ThankYou Page - Display Device Bundle Data
    Wait Until Element Is Visible   ${XPATH_BOOKING_THANKYOU.lbl_product_name}   10s
    Element Should Contain   ${XPATH_BOOKING_THANKYOU.lbl_product_name}          ${var_booking_product_name} ${BOOKING_TRANS_TH.number_type}
    Wait Until Element Is Visible   ${XPATH_BOOKING_THANKYOU.lbl_booking_product_name}   10s
    Element Should Contain   ${XPATH_BOOKING_THANKYOU.lbl_booking_product_name}          ${var_booking_product_name} ${BOOKING_TRANS_TH.number_type}

Booking ThankYou Page - Display Device Bundle Data EN
    Wait Until Element Is Visible   ${XPATH_BOOKING_THANKYOU.lbl_product_name}   10s
    Element Should Contain   ${XPATH_BOOKING_THANKYOU.lbl_product_name}          ${var_booking_product_name} ${BOOKING_TRANS_EN.number_type}
    Wait Until Element Is Visible   ${XPATH_BOOKING_THANKYOU.lbl_booking_product_name}   10s
    Element Should Contain   ${XPATH_BOOKING_THANKYOU.lbl_booking_product_name}          ${var_booking_product_name} ${BOOKING_TRANS_EN.number_type}

Booking ThankYou Page - Display Person ID As Test Data Value
    Wait Until Element Is Visible   ${XPATH_BOOKING_THANKYOU.lbl_person_id}   10s
    Element Should Contain   ${XPATH_BOOKING_THANKYOU.lbl_person_id}          ${BOOKING_PREORDER_VALID.person_id}

Booking ThankYou Page - Display Person ID As Value To Random ID Card
    Wait Until Element Is Visible   ${XPATH_BOOKING_THANKYOU.lbl_person_id}   10s
    Element Should Contain   ${XPATH_BOOKING_THANKYOU.lbl_person_id}          ${var_random_id_card}

Booking ThankYou Page - Display Date of Booking As Value To Date Now
    Get Date Now Format Thai
    Wait Until Element Is Visible   ${XPATH_BOOKING_THANKYOU.lbl_created_at}   10s
    Element Should Contain   ${XPATH_BOOKING_THANKYOU.lbl_created_at}          ${var_booking_thai_month}

Booking ThankYou Page - Display Date of Booking As Value To Date Now EN
    Get Date Now Format English
    Wait Until Element Is Visible   ${XPATH_BOOKING_THANKYOU.lbl_created_at}   10s
    Element Should Contain   ${XPATH_BOOKING_THANKYOU.lbl_created_at}          ${var_booking_english_month}

Booking ThankYou Page - Display Deposit
    Wait Until Element Is Visible   ${XPATH_BOOKING_THANKYOU.lbl_deposit}   10s
    Element Should Contain   ${XPATH_BOOKING_THANKYOU.lbl_deposit}          ${BOOKING_DATA_TH.deposit} ${BOOKING_TRANS_TH.bath}

Booking ThankYou Page - Display Deposit EN
    Wait Until Element Is Visible   ${XPATH_BOOKING_THANKYOU.lbl_deposit}   10s
    Element Should Contain   ${XPATH_BOOKING_THANKYOU.lbl_deposit}          ${BOOKING_DATA_EN.deposit} ${BOOKING_TRANS_EN.bath}

Booking ThankYou Page - Display Customer Name As Test Data Value
    Wait Until Element Is Visible   ${XPATH_BOOKING_THANKYOU.lbl_customer_name}   10s
    Element Should Contain   ${XPATH_BOOKING_THANKYOU.lbl_customer_name}          ${BOOKING_PREORDER_VALID.firstname} ${BOOKING_PREORDER_VALID.lastname}

Booking ThankYou Page - Display Customer Tel As Test Data Value
    Wait Until Element Is Visible   ${XPATH_BOOKING_THANKYOU.lbl_customer_tel}   10s
    Element Should Contain   ${XPATH_BOOKING_THANKYOU.lbl_customer_tel}          ${BOOKING_PREORDER_VALID.customer_tel}

Booking ThankYou Page - Display Customer Email As Test Data Value
    Wait Until Element Is Visible   ${XPATH_BOOKING_THANKYOU.lbl_customer_email}   10s
    Element Should Contain   ${XPATH_BOOKING_THANKYOU.lbl_customer_email}          ${BOOKING_PREORDER_VALID.customer_email}

Booking ThankYou Page - Display Bill Address As Test Data Value
    Wait Until Element Is Visible   ${XPATH_BOOKING_THANKYOU.lbl_bill_address}   10s
    ${bill_address}=   Convert To String     ${BOOKING_PREORDER_VALID.customer_billing_no} ${BOOKING_PREORDER_VALID.customer_billing_moo} ${BOOKING_PREORDER_VALID.customer_billing_village} ${BOOKING_PREORDER_VALID.customer_billing_floor} ${BOOKING_PREORDER_VALID.customer_billing_soi} ${BOOKING_PREORDER_VALID.customer_billing_road}
    Element Should Contain   ${XPATH_BOOKING_THANKYOU.lbl_bill_address}          ${bill_address}

Booking ThankYou Page - Display Bill District As Test Data Value
    Wait Until Element Is Visible   ${XPATH_BOOKING_THANKYOU.lbl_bill_district}   10s
    Element Should Contain   ${XPATH_BOOKING_THANKYOU.lbl_bill_district}          ${var_booking_bill_district}

Booking ThankYou Page - Display Bill City As Test Data Value
    Wait Until Element Is Visible   ${XPATH_BOOKING_THANKYOU.lbl_bill_city}   10s
    Element Should Contain   ${XPATH_BOOKING_THANKYOU.lbl_bill_city}          ${var_booking_bill_city}

Booking ThankYou Page - Display Bill Province As Test Data Value
    Wait Until Element Is Visible   ${XPATH_BOOKING_THANKYOU.lbl_bill_province}   10s
    Element Should Contain   ${XPATH_BOOKING_THANKYOU.lbl_bill_province}          ${var_booking_bill_province}

Booking ThankYou Page - Display Bill Postcode As Test Data Value
    Wait Until Element Is Visible   ${XPATH_BOOKING_THANKYOU.lbl_bill_postcode}   10s
    Element Should Contain   ${XPATH_BOOKING_THANKYOU.lbl_bill_postcode}          ${BOOKING_PREORDER_VALID.billing_postcode}

Booking ThankYou Page - Display Bill District As Value in PCMS
    Wait Until Element Is Visible   ${XPATH_BOOKING_THANKYOU.lbl_bill_district}   10s
    Element Should Contain   ${XPATH_BOOKING_THANKYOU.lbl_bill_district}          ${var_booking_bill_district_th}

Booking ThankYou Page - Display Bill City As Value in PCMS
    Wait Until Element Is Visible   ${XPATH_BOOKING_THANKYOU.lbl_bill_city}   10s
    Element Should Contain   ${XPATH_BOOKING_THANKYOU.lbl_bill_city}          ${var_booking_bill_city_th}

Booking ThankYou Page - Display Bill Province As Value in PCMS
    Wait Until Element Is Visible   ${XPATH_BOOKING_THANKYOU.lbl_bill_province}   10s
    Element Should Contain   ${XPATH_BOOKING_THANKYOU.lbl_bill_province}          ${var_booking_bill_province_th}

Booking ThankYou Page - Display Bill District As Value in PCMS EN
    Wait Until Element Is Visible   ${XPATH_BOOKING_THANKYOU.lbl_bill_district}   10s
    Element Should Contain   ${XPATH_BOOKING_THANKYOU.lbl_bill_district}          ${var_booking_bill_district_en}

Booking ThankYou Page - Display Bill City As Value in PCMS EN
    Wait Until Element Is Visible   ${XPATH_BOOKING_THANKYOU.lbl_bill_city}   10s
    Element Should Contain   ${XPATH_BOOKING_THANKYOU.lbl_bill_city}          ${var_booking_bill_city_en}

Booking ThankYou Page - Display Bill Province As Value in PCMS EN
    Wait Until Element Is Visible   ${XPATH_BOOKING_THANKYOU.lbl_bill_province}   10s
    Element Should Contain   ${XPATH_BOOKING_THANKYOU.lbl_bill_province}          ${var_booking_bill_province_en}

Booking ThankYou Page - Display Image Product
    Wait Until Element Is Visible      //img[@src="${BOOKING_URL}/${BOOKING_IMAGE_PRODUCT_URL}/${var_booking_photo}" and @id="product_image"]      10s
    Element Should Be Visible  //img[@src="${BOOKING_URL}/${BOOKING_IMAGE_PRODUCT_URL}/${var_booking_photo}" and @id="product_image"]

Booking ThankYou Page - Display Image Product Mobile
    Wait Until Element Is Visible      //img[@src="${BOOKING_URL}/${BOOKING_IMAGE_PRODUCT_URL}/${var_booking_photo}" and @id="product_image_mobile"]      10s
    Element Should Be Visible  //img[@src="${BOOKING_URL}/${BOOKING_IMAGE_PRODUCT_URL}/${var_booking_photo}" and @id="product_image_mobile"]

Booking ThankYou Page - Get Booking Code
    Wait Until Element Is Visible   ${XPATH_BOOKING_THANKYOU.lbl_booking_code}   10s
    ${booking_code}=   Get Text     ${XPATH_BOOKING_THANKYOU.lbl_booking_code}
    Set Test Variable        ${var_booking_code}       ${booking_code}
    Log To Console      ${var_booking_code}

Booking ThankYou Page - Verify Display Cutomer Info
    [Arguments]    ${lang}=th
    Page Should Contain    ${var_random_id_card}          10s
    Page Should Contain    ${BOOKING_PREORDER_VALID.firstname}           10
    Page Should Contain    ${BOOKING_PREORDER_VALID.customer_tel}    10
    Page Should Contain    ${BOOKING_PREORDER_VALID.customer_email}    10
    Run Keyword IF    '${lang}' == 'th'    Page Should Contain    ${BOOKING_PREORDER_VALID.product_name}    10
    ...    ELSE    Page Should Contain    ${BOOKING_PREORDER_VALID.product_name_en}    10

Booking ThankYou Page - Verify Display Cutomer Info With Bundle
    [Arguments]    ${lang}=th
    Page Should Contain    ${var_random_id_card}          10s
    Page Should Contain    ${BOOKING_PREORDER_VALID.firstname}           10
    Page Should Contain    ${BOOKING_PREORDER_VALID.customer_tel}    10
    Page Should Contain    ${BOOKING_PREORDER_VALID.customer_email}    10
    Run Keyword IF    '${lang}' == 'th'    Page Should Contain    ${BOOKING_PREORDER_VALID.product_bundle_name_th}    10
    ...    ELSE    Page Should Contain    ${BOOKING_PREORDER_VALID.product_bundle_name_en}    10

Booking ThankYou Page - Verify Display Billing Address Same Shipping
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

Booking ThankYou Page - Get Payment Status Success
    [Arguments]    ${lang}=th
    Wait Until Element Is Visible   ${XPATH_BOOKING_THANKYOU.lbl_payment_status}   10s
    ${payment_status}=   Get Text     ${XPATH_BOOKING_THANKYOU.lbl_payment_status}
    Run Keyword If    '${lang}' == 'th'    Should Be Equal     ${payment_status}       ชำระเงินสำเร็จ (Success)
    ...    ELSE    Should Be Equal     ${payment_status}       Payment Success

Booking ThankYou Page - Get Payment Status Fail
    [Arguments]    ${lang}=th
    Wait Until Element Is Visible   ${XPATH_BOOKING_THANKYOU.lbl_payment_status}   10s
    ${payment_status}=   Get Text     ${XPATH_BOOKING_THANKYOU.lbl_payment_status}
    Run Keyword If    '${lang}' == 'th'    Should Be Equal     ${payment_status}       ชำระเงินไม่สำเร็จ (Failed)
    ...    ELSE    Should Be Equal     ${payment_status}       Payment Failed
    
Booking ThankYou Page - Verify Label Thank You Page TH
    Page Should Contain    ${BOOKING_THANK_YOU_TH.booking_code}
    Page Should Contain    ${BOOKING_THANK_YOU_TH.payment_status}
    Page Should Contain    ${BOOKING_THANK_YOU_TH.person_id}
    Page Should Contain    ${BOOKING_THANK_YOU_TH.booking_at}
    Page Should Contain    ${BOOKING_THANK_YOU_TH.booking_channel}
    Page Should Contain    ${BOOKING_THANK_YOU_TH.customer_name}
    Page Should Contain    ${BOOKING_THANK_YOU_TH.customer_tel}
    Page Should Contain    ${BOOKING_THANK_YOU_TH.customer_email}
    Page Should Contain    ${BOOKING_THANK_YOU_TH.bill_address}
    Page Should Contain    ${BOOKING_THANK_YOU_TH.model}
    Page Should Contain    ${BOOKING_THANK_YOU_TH.derivery_date}
    Page Should Contain    ${BOOKING_THANK_YOU_TH.deposit}
    Page Should Contain    ${BOOKING_THANK_YOU_TH.shipping_fee}

Booking ThankYou Page - Verify Label Thank You Page EN
    Page Should Contain    ${BOOKING_THANK_YOU_EN.booking_code}
    Page Should Contain    ${BOOKING_THANK_YOU_EN.payment_status}
    Page Should Contain    ${BOOKING_THANK_YOU_EN.person_id}
    Page Should Contain    ${BOOKING_THANK_YOU_EN.booking_at}
    Page Should Contain    ${BOOKING_THANK_YOU_EN.booking_channel}
    Page Should Contain    ${BOOKING_THANK_YOU_EN.customer_name}
    Page Should Contain    ${BOOKING_THANK_YOU_EN.customer_tel}
    Page Should Contain    ${BOOKING_THANK_YOU_EN.customer_email}
    Page Should Contain    ${BOOKING_THANK_YOU_EN.bill_address}
    Page Should Contain    ${BOOKING_THANK_YOU_EN.model}
    Page Should Contain    ${BOOKING_THANK_YOU_EN.derivery_date}
    Page Should Contain    ${BOOKING_THANK_YOU_EN.deposit}
    Page Should Contain    ${BOOKING_THANK_YOU_EN.shipping_fee}