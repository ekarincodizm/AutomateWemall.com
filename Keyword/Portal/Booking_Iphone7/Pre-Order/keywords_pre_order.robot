*** Keywords ***
Booking Pre-Order Page - Verify URL
    Location Should Contain    /iphone7/pre-order

Booking Pre-Order Page - Verify EN URL
    Location Should Contain    /en/iphone7/pre-order

Booking Pre-Order Page - Verify Page
    Sleep    3s
    Page Should Contain     เลือกระบุเอกสารสำคัญ   10s

Booking Pre-Order Page - Verify EN Page
    Sleep    3s
    Page Should Contain     Select your identification document       10s

Booking Pre-Order Page - Verify Billing Checkbox is Selected
    Wait Until Element Is Visible      ${billing-checkbox}          10s
    Checkbox Should Be Selected     ${billing-checkbox}

Booking Pre-Order Page - Select Billing Checkbox
    Select Checkbox     ${billing-checkbox}

Booking Pre-Order Page - Unselect Billing Checkbox
    Unselect Checkbox     jquery=[data-id="lbl_billing_address"]

Booking Pre-Order Page - Click Billing Checkbox
    Click Element    ${billing-checkbox}

Booking Pre-Order Page - Display All Input
    Wait Until Element Is Visible      ${BkPre-person_id}          10s
    Wait Until Element Is Visible      ${BkPre-firstname}           10s
    Wait Until Element Is Visible      ${BkPre-lastname}            10s
    Wait Until Element Is Visible      ${BkPre-customer_tel}        10s
    Wait Until Element Is Visible      ${BkPre-customer_email}      10s
    Wait Until Element Is Visible      ${BkPre-customer_address_no}      10s
    Wait Until Element Is Visible      ${BkPre-customer_address_moo}      10s
    Wait Until Element Is Visible      ${BkPre-customer_address_village}     10s
    Wait Until Element Is Visible      ${BkPre-customer_address_floor}      10s
    Wait Until Element Is Visible      ${BkPre-customer_address_soi}      10s
    Wait Until Element Is Visible      ${BkPre-customer_address_road}      10s
    Wait Until Element Is Visible      ${BkPre-customer_province_id}      10s
    Wait Until Element Is Visible      ${BkPre-customer_city_id}      10s
    Wait Until Element Is Visible      ${BkPre-customer_district_id}      10s
    Wait Until Element Is Visible      ${BkPre-customer_postcode}      10s
    Wait Until Element Is Visible      ${BkPre-capacity}      10s
    Wait Until Element Is Visible      ${BkPre-color}      10s
    Wait Until Element Is Visible      ${XPATH_BOOKING_PREORDER.lbl_bundle}      10s
    Wait Until Element Is Visible      ${XPATH_BOOKING_PREORDER.lbl_handset}      10s

Booking Pre-Order Page - Verify error fields are appeared
    Wait Until Element Is Visible      id=person_id-error          10s
    Wait Until Element Is Visible      id=firstname-error          10s
    Wait Until Element Is Visible      id=lastname-error          10s
    Wait Until Element Is Visible      id=customer_tel-error          10s
    Wait Until Element Is Visible      id=customer_email-error          10s
    Wait Until Element Is Visible      id=all_product-error          10s
    Wait Until Element Is Visible      id=bundle_type-error          10s
    Wait Until Element Is Visible      id=customer_address_no-error          10s
    Wait Until Element Is Visible      id=customer_address_road-error          10s
    Wait Until Element Is Visible      id=customer_province_id-error          10s
    Wait Until Element Is Visible      id=customer_city_id-error          10s
    Wait Until Element Is Visible      id=customer_district_id-error          10s
    Wait Until Element Is Visible      id=customer_postcode-error          10s

Booking Pre-Order Page - Verify error billing fields are appeared
    Wait Until Element Is Visible      id=customer_billing_no-error          10s
    Wait Until Element Is Visible      id=customer_billing_road-error          10s
    Wait Until Element Is Visible      id=bill_province_id-error          10s
    Wait Until Element Is Visible      id=bill_city_id-error          10s
    Wait Until Element Is Visible      id=bill_district_id-error          10s
    Wait Until Element Is Visible      id=bill_postcode-error          10s

Booking Pre-Order Page - Display All Billing Input
    Wait Until Element Is Visible      ${BkPre-customer_billing_no}      10s
    Wait Until Element Is Visible      ${BkPre-customer_billing_moo}      10s
    Wait Until Element Is Visible      ${BkPre-customer_billing_village}     10s
    Wait Until Element Is Visible      ${BkPre-customer_billing_floor}      10s
    Wait Until Element Is Visible      ${BkPre-customer_billing_soi}      10s
    Wait Until Element Is Visible      ${BkPre-customer_billing_road}      10s
    Wait Until Element Is Visible      ${BkPre-billing_province_id}      10s
    Wait Until Element Is Visible      ${BkPre-billing_city_id}      10s
    Wait Until Element Is Visible      ${BkPre-billing_district_id}      10s
    Wait Until Element Is Visible      ${BkPre-billing_postcode}      10s

Booking Pre-Order Page - User Enter Valid Identification Document
    Random Id Card
    Booking Pre-Order Page - User Enter Valid Person ID    ${var_random_id_card}
    Booking Pre-Order Page - User Enter Valid Firstname
    Booking Pre-Order Page - User Enter Valid Lastname
    Booking Pre-Order Page - User Enter Valid Customer Tel
    Booking Pre-Order Page - User Enter Valid Customer Email

Booking Pre-Order Page - User Select Product Model
    ${count}=    Get Matching Xpath Count    //div[@class='product_data_select']
    Log To Console    ${count}

    : FOR    ${INDEX}    IN RANGE    0    ${count}
        \    ${element}=    Evaluate    ${INDEX}+2
        \    ${index_element}=    Evaluate    ${INDEX}+1
        \    Log To Console    ${INDEX}
        \    Log To Console    ${element}
        \    Click Element    jquery=.iCheck-helper:eq(${element})
        \    ${size}=    Get Matching Xpath Count    ${div_product_data}[${index_element}]${product_size_element}/option
        \    ${color}=    Get Matching Xpath Count    ${div_product_data}[${index_element}]${product_color_element}/option
        \    ${size}=    Evaluate    ${size}-1
        \    ${color}=    Evaluate    ${color}-1
        \    Log To Console    size : ${size}
        \    Log To Console    color : ${color}
        \    ${chk_size}=    Booking Pre-Order Page - Select Size    ${index_element}    ${size}
        \    ${chk_color}=    Run Keyword IF    ${chk_size} == True    Run Keywords    Booking Pre-Order Page - Select Color    ${index_element}    ${color}
        \    ...    AND    Exit For Loop

    ${product_name}=    Get Value    jquery=#product-name
    log to console    ${product_name}
    [Return]    ${product_name}

Booking Pre-Order Page - Select Size
    [Arguments]    ${index}=1    ${count_size}=1
    :FOR    ${SIZE}    IN RANGE    0    ${count_size}
    \    ${size_element}=    Evaluate    ${SIZE}+2
    \    ${size_index}=    Evaluate    ${SIZE}+1
    \    ${size_index_1}=    Convert To String    ${size_index}
    \    ${chk_size}=    Run Keyword And Return Status    Wait Until Element Is Enabled    ${div_product_data}[${index}]${product_size_element}/option[${size_element}]
    \    Log To console    chksize = ${chk_size}
    \    Log To console    chksizeindex = ${size_index}
    \    ${product_id}=    Get Value    ${div_product_data}[${index}]//input[@class="product_type valid"]
    \    Log To console    val = ${product_id}
    \    Run Keyword IF    ${chk_size} == True    Run Keywords    Select From List By Value    id=size_product_type_id_${product_id}    ${size_index_1}
    \    ...    AND    Exit For Loop
    [Return]    ${chk_size}

Booking Pre-Order Page - Select Color
    [Arguments]    ${index}=1    ${count_color}=1
    :FOR    ${COLOR}    IN RANGE    0    ${count_color}
    \    ${color_element}=    Evaluate    ${COLOR}+2
    \    ${color_index}=    Evaluate    ${COLOR}+1
    \    ${color_index_1}=    Convert To String    ${color_index}
    \    ${chk_color}=    Run Keyword And Return Status    Wait Until Element Is Enabled    ${div_product_data}[${index}]${product_color_element}/option[${color_element}]
    \    Log To console    chkcolor = ${chk_color}
    \    Log To console    chkcolorindex = ${color_index}
    \    ${product_id}=    Get Value    ${div_product_data}[${index}]//input[@class="product_type valid"]
    \    Log To console    val = ${product_id}
    \    Run Keyword IF    ${chk_color} == True    Run Keywords    Select From List By Index    id=color_product_type_id_${product_id}    ${color_index_1}
    \    ...    AND    Exit For Loop
    [Return]    ${chk_color}

Booking Pre-Order Page - User Select Product Model EN
    ${count}=    Get Matching Xpath Count    //div[@class='product_data_select']
    Log To Console    ${count}

    : FOR    ${INDEX}    IN RANGE    0    ${count}
        \    ${element}=    Evaluate    ${INDEX}+2
        \    ${index_element}=    Evaluate    ${INDEX}+1
        \    Log To Console    ${INDEX}
        \    Log To Console    ${element}
        \    Click Element    jquery=.iCheck-helper:eq(${element})
        \    ${size}=    Get Matching Xpath Count    ${div_product_data}[${index_element}]${product_size_element}/option
        \    ${color}=    Get Matching Xpath Count    ${div_product_data}[${index_element}]${product_color_element}/option
        \    ${size}=    Evaluate    ${size}-1
        \    ${color}=    Evaluate    ${color}-1
        \    Log To Console    size : ${size}
        \    Log To Console    color : ${color}
        \    ${chk_size}=    Booking Pre-Order Page - Select Size    ${index_element}    ${size}
        \    ${chk_color}=    Run Keyword IF    ${chk_size} == True    Run Keywords    Booking Pre-Order Page - Select Color    ${index_element}    ${color}
        \    ...    AND    Exit For Loop

    ${product_name}=    Get Value    jquery=#product-name
    log to console    ${product_name}
    [Return]    ${product_name}

Booking Pre-Order Page - User Enter Valid Address
    Booking Pre-Order Page - User Enter Valid Customer Address No
    Booking Pre-Order Page - User Select Customer Province ID
    Booking Pre-Order Page - User Enter Valid Customer Address Moo
    Booking Pre-Order Page - User Select Customer City ID
    Booking Pre-Order Page - User Enter Valid Customer Address Village
    Booking Pre-Order Page - User Select Customer District ID
    Booking Pre-Order Page - User Enter Valid Customer Address Floor
    Booking Pre-Order Page - User Select Customer Postcode ID
    Booking Pre-Order Page - User Enter Valid Customer Address Soi
    Booking Pre-Order Page - User Enter Valid Customer Address Road

Booking Pre-Order Page - User Enter Valid Billing Address
    Booking Pre-Order Page - User Enter Valid Customer Billing No
    Booking Pre-Order Page - User Select Customer Billing Province ID
    Booking Pre-Order Page - User Enter Valid Customer Billing Moo
    Booking Pre-Order Page - User Select Customer Billing City ID
    Booking Pre-Order Page - User Enter Valid Customer Billing Village
    Booking Pre-Order Page - User Select Customer Billing District ID
    Booking Pre-Order Page - User Enter Valid Customer Billing Floor
    Booking Pre-Order Page - User Select Customer Billing Postcode ID
    Booking Pre-Order Page - User Enter Valid Customer Billing Soi
    Booking Pre-Order Page - User Enter Valid Customer Billing Road

Booking Pre-Order Page - Get All Billing Location Name
    Booking Pre-Order Page - Get Billing Province Name
    Booking Pre-Order Page - Get Billing District Name
    Booking Pre-Order Page - Get Billing City Name

Booking Pre-Order Page - Check All Billing Location Name
    Booking Pre-Order Page - Check Billing Province Name As Value in PCMS
    Booking Pre-Order Page - Check Billing District Name As Value in PCMS
    Booking Pre-Order Page - Check Billing City Name As Value in PCMS

Booking Pre-Order Page - Check All Billing Location Name EN
    Booking Pre-Order Page - Check Billing Province Name As Value in PCMS EN
    Booking Pre-Order Page - Check Billing District Name As Value in PCMS EN
    Booking Pre-Order Page - Check Billing City Name As Value in PCMS EN

Booking Pre-Order Page - User Enter Valid Person ID
    [Arguments]     ${person_id}=None
    ${person_id}=   Run Keyword If   '${person_id}' == 'None'   Convert To String   ${BOOKING_PREORDER_VALID.person_id}   ELSE   Convert To String   ${person_id}
    Input Text      ${BkPre-person_id}       ${person_id}

Booking Pre-Order Page - User Enter Valid Firstname
    Input Text      ${BkPre-firstname}       ${BOOKING_PREORDER_VALID.firstname}

Booking Pre-Order Page - User Enter Valid Lastname
    Input Text      ${BkPre-lastname}       ${BOOKING_PREORDER_VALID.lastname}

Booking Pre-Order Page - User Enter Valid Customer Tel
    Input Text      ${BkPre-customer_tel}       ${BOOKING_PREORDER_VALID.customer_tel}

Booking Pre-Order Page - User Enter Valid Customer Email
    Input Text      ${BkPre-customer_email}       ${BOOKING_PREORDER_VALID.customer_email}

Booking Pre-Order Page - User Enter Valid Customer Address No
    Input Text      ${BkPre-customer_address_no}       ${BOOKING_PREORDER_VALID.customer_address_no}

Booking Pre-Order Page - User Enter Valid Customer Address Moo
    Input Text      ${BkPre-customer_address_moo}       ${BOOKING_PREORDER_VALID.customer_address_moo}

Booking Pre-Order Page - User Enter Valid Customer Address Village
    Input Text      ${BkPre-customer_address_village}       ${BOOKING_PREORDER_VALID.customer_address_village}

Booking Pre-Order Page - User Enter Valid Customer Address Floor
    Input Text      ${BkPre-customer_address_floor}       ${BOOKING_PREORDER_VALID.customer_address_floor}

Booking Pre-Order Page - User Enter Valid Customer Address Soi
    Input Text      ${BkPre-customer_address_soi}       ${BOOKING_PREORDER_VALID.customer_address_soi}

Booking Pre-Order Page - User Enter Valid Customer Address Road
    Input Text      ${BkPre-customer_address_road}       ${BOOKING_PREORDER_VALID.customer_address_road}

#Booking Pre-Order Page - User Enter Valid Customer Postcode
#    Input Text      ${BkPre-customer_postcode}       ${BOOKING_PREORDER_VALID.customer_postcode}

Booking Pre-Order Page - User Enter Valid Customer Billing No
    Input Text      ${BkPre-customer_billing_no}       ${BOOKING_PREORDER_VALID.customer_billing_no}

Booking Pre-Order Page - User Enter Valid Customer Billing Moo
    Input Text      ${BkPre-customer_billing_moo}       ${BOOKING_PREORDER_VALID.customer_billing_moo}

Booking Pre-Order Page - User Enter Valid Customer Billing Village
    Input Text      ${BkPre-customer_billing_village}       ${BOOKING_PREORDER_VALID.customer_billing_village}

Booking Pre-Order Page - User Enter Valid Customer Billing Floor
    Input Text      ${BkPre-customer_billing_floor}       ${BOOKING_PREORDER_VALID.customer_billing_floor}

Booking Pre-Order Page - User Enter Valid Customer Billing Soi
    Input Text      ${BkPre-customer_billing_soi}       ${BOOKING_PREORDER_VALID.customer_billing_soi}

Booking Pre-Order Page - User Enter Valid Customer Billing Road
    Input Text      ${BkPre-customer_billing_road}       ${BOOKING_PREORDER_VALID.customer_billing_road}

#Booking Pre-Order Page - User Enter Valid Customer Billing Postcode
#    Input Text      ${BkPre-billing_postcode}       ${BOOKING_PREORDER_VALID.billing_postcode}

Booking Pre-Order Page - User Select Product Capacity
    [Arguments]     ${capacity}=None
    ${capacity}=   Run Keyword If   '${capacity}' == 'None'   Convert To String   ${BOOKING_PREORDER_VALID.capacity}   ELSE   Convert To String   ${capacity}
    Select From List By Value      ${BkPre-capacity}       ${capacity}

Booking Pre-Order Page - User Select Product Color
    [Arguments]     ${color}=None
    ${color}=   Run Keyword If   '${color}' == 'None'   Convert To String   ${BOOKING_PREORDER_VALID.color}   ELSE   Convert To String   ${color}
    Select From List By Value      ${BkPre-color}       ${color}

Booking Pre-Order Page - User Select Customer Province ID
    Wait Until Element Is Visible   ${XPATH_BOOKING_PREORDER.cbo_customer_province_id}/option[@value="${BOOKING_PREORDER_VALID.customer_province_id}"]   10s
    Select From List By Value      ${BkPre-customer_province_id}       ${BOOKING_PREORDER_VALID.customer_province_id}
    Wait Until Element Is Not Visible      ${XPATH_BOOKING_PREORDER.i_waiting}    15s

Booking Pre-Order Page - User Select Customer District ID
    Wait Until Element Is Visible   ${XPATH_BOOKING_PREORDER.cbo_customer_district_id}/option[@value="${BOOKING_PREORDER_VALID.customer_district_id}"]   10s
    Select From List By Value      ${BkPre-customer_district_id}       ${BOOKING_PREORDER_VALID.customer_district_id}
    Wait Until Element Is Not Visible      ${XPATH_BOOKING_PREORDER.i_waiting}    15s

Booking Pre-Order Page - User Select Customer Postcode ID
    Wait Until Element Is Visible   ${XPATH_BOOKING_PREORDER.cbo_customer_postcode_id}/option[@value="${BOOKING_PREORDER_VALID.customer_postcode}"]   10s
    Select From List By Value      ${BkPre-customer_postcode}       ${BOOKING_PREORDER_VALID.customer_postcode}
    Wait Until Element Is Not Visible      ${XPATH_BOOKING_PREORDER.i_waiting}    15s

Booking Pre-Order Page - User Select Customer City ID
    Wait Until Element Is Visible   ${XPATH_BOOKING_PREORDER.cbo_customer_city_id}/option[@value="${BOOKING_PREORDER_VALID.customer_city_id}"]   10s
    Select From List By Value      ${BkPre-customer_city_id}       ${BOOKING_PREORDER_VALID.customer_city_id}
    Wait Until Element Is Not Visible      ${XPATH_BOOKING_PREORDER.i_waiting}    15s

Booking Pre-Order Page - User Select Customer Billing Province ID
    Wait Until Element Is Visible   ${XPATH_BOOKING_PREORDER.cbo_billing_province_id}/option[@value="${BOOKING_PREORDER_VALID.billing_province_id}"]   10s
    Select From List By Value      ${BkPre-billing_province_id}       ${BOOKING_PREORDER_VALID.billing_province_id}
    Wait Until Element Is Not Visible      ${XPATH_BOOKING_PREORDER.i_waiting}    15s

Booking Pre-Order Page - User Select Customer Billing District ID
    Wait Until Element Is Visible   ${XPATH_BOOKING_PREORDER.cbo_billing_district_id}/option[@value="${BOOKING_PREORDER_VALID.billing_district_id}"]   10s
    Select From List By Value      ${BkPre-billing_district_id}       ${BOOKING_PREORDER_VALID.billing_district_id}
    Wait Until Element Is Not Visible      ${XPATH_BOOKING_PREORDER.i_waiting}    15s

Booking Pre-Order Page - User Select Customer Billing Postcode ID
    Wait Until Element Is Visible   ${XPATH_BOOKING_PREORDER.cbo_billing_postcode_id}/option[@value="${BOOKING_PREORDER_VALID.billing_postcode}"]   10s
    Select From List By Value      ${BkPre-billing_postcode}       ${BOOKING_PREORDER_VALID.billing_postcode}
    Wait Until Element Is Not Visible      ${XPATH_BOOKING_PREORDER.i_waiting}    15s

Booking Pre-Order Page - User Select Customer Billing City ID
    Wait Until Element Is Visible   ${XPATH_BOOKING_PREORDER.cbo_billing_city_id}/option[@value="${BOOKING_PREORDER_VALID.billing_city_id}"]   10s
    Select From List By Value      ${BkPre-billing_city_id}       ${BOOKING_PREORDER_VALID.billing_city_id}
    Wait Until Element Is Not Visible      ${XPATH_BOOKING_PREORDER.i_waiting}    15s

Booking Pre-Order Page - User Choose Bundle
    Wait Until Element Is Visible      ${XPATH_BOOKING_PREORDER.lbl_bundle}      10s
    Click Element       ${XPATH_BOOKING_PREORDER.lbl_bundle}

Booking Pre-Order Page - User Choose Handset Only
    Wait Until Element Is Visible      ${XPATH_BOOKING_PREORDER.lbl_handset}      10s
    Click Element       ${XPATH_BOOKING_PREORDER.lbl_handset}

Booking Pre-Order Page - Click Billing Address
    Wait Until Element Is Visible      ${XPATH_BOOKING_PREORDER.lbl_billing_address}      10s
    Click Element       ${XPATH_BOOKING_PREORDER.lbl_billing_address}

Booking Pre-Order Page - Click Button Next
    Wait Until Element Is Visible      ${BkPre-next}      10s
    Click Element       ${BkPre-next}

Booking Pre-Order Page - Display Billing No
    Wait Until Element Is Visible      ${BkPre-customer_billing_no}      10s

Booking Pre-Order Page - Display Error Validate
    Wait Until Element Is Visible       ${XPATH_BOOKING_PREORDER.alert_error}      10s
    Element Should Be Visible           ${XPATH_BOOKING_PREORDER.alert_error}

Booking Pre-Order Page - Display Image Product
    Wait Until Element Is Visible      //img[@src="/${BOOKING_IMAGE_PRODUCT_URL}/${var_booking_photo}"]      10s
    Element Should Be Visible  //img[@src="/${BOOKING_IMAGE_PRODUCT_URL}/${var_booking_photo}"]

Booking Pre-Order Page - Not Display Billing No
    Wait Until Element Is Not Visible      ${BkPre-customer_billing_no}      10s

Booking Pre-Order Page - Get Product Color And Size
    [Arguments]   ${lang}=None
    ${ajax_products}=   Run Keyword If   '${lang}' == 'en'   Convert To String   /ajax/products?lang=en&no-cache=1   ELSE   Convert To String   /ajax/products?no-cache=1

    Create Http Context     ${BOOKING_LEVEL_DOMAIN}      http
    Next Request Should Succeed
    HttpLibrary.HTTP.GET     ${ajax_products}
    ${response}=     Get Response Body

    ${product_size_id}=         Get Json Value     ${response}             /data/products/${var_booking_product_inventory_id}/product_size_id
    ${product_color_id}=        Get Json Value     ${response}             /data/products/${var_booking_product_inventory_id}/product_color_id
    ${photo}=                   Get Json Value     ${response}             /data/products/${var_booking_product_inventory_id}/photo
    ${product_name}=            Get Json Value     ${response}             /data/products/${var_booking_product_inventory_id}/product_name
    ${product_name}=            Replace String Using Regexp     ${product_name}          "         ${EMPTY}
    ${photo}=                   Replace String Using Regexp     ${photo}          "         ${EMPTY}
    Set Test Variable    ${var_booking_product_size_id}     ${product_size_id}
    Set Test Variable    ${var_booking_product_color_id}    ${product_color_id}
    Set Test Variable    ${var_booking_photo}               ${photo}
    Set Test Variable    ${var_booking_product_name}        ${product_name}

    Log To Console      size=${var_booking_product_size_id}
    Log To Console      color=${var_booking_product_color_id}
    Log To Console      name=${var_booking_product_name}

Booking Pre-Order Page - Get Billing Province Name
    ${bill_province}=    Get Text   ${XPATH_BOOKING_PREORDER.cbo_billing_province_id}/option[@value="${BOOKING_PREORDER_VALID.billing_province_id}"]
    Set Test Variable    ${var_booking_bill_province}     ${bill_province}

Booking Pre-Order Page - Get Billing District Name
    ${bill_district}=    Get Text   ${XPATH_BOOKING_PREORDER.cbo_billing_district_id}/option[@value="${BOOKING_PREORDER_VALID.billing_district_id}"]
    Set Test Variable    ${var_booking_bill_district}     ${bill_district}

Booking Pre-Order Page - Get Billing City Name
    ${bill_city}=    Get Text   ${XPATH_BOOKING_PREORDER.cbo_billing_city_id}/option[@value="${BOOKING_PREORDER_VALID.billing_city_id}"]
    Set Test Variable    ${var_booking_bill_city}     ${bill_city}

Booking Pre-Order Page - Set Invalid Value Input Inventory Id
    Execute Javascript	return window.document.getElementById('inventory_id').value='1234';

Booking Pre-Order Page - Remove Input Inventory Id
    Execute Javascript	return window.document.getElementById('inventory_id').remove();

Booking Pre-Order Page - Check Billing District Name As Value in PCMS
    Booking Py - Get Billing District Name From PCMS
    Should Be Equal	   ${var_booking_bill_district}          ${var_booking_bill_district_th}

Booking Pre-Order Page - Check Billing City Name As Value in PCMS
    Booking Py - Get Billing City Name From PCMS
    Should Be Equal	   ${var_booking_bill_city}          ${var_booking_bill_city_th}

Booking Pre-Order Page - Check Billing Province Name As Value in PCMS
    Booking Py - Get Billing Province Name From PCMS
    Should Be Equal	   ${var_booking_bill_province}          ${var_booking_bill_province_th}

Booking Pre-Order Page - Check Billing District Name As Value in PCMS EN
    Booking Py - Get Billing District Name From PCMS
    Should Be Equal	   ${var_booking_bill_district}          ${var_booking_bill_district_en}

Booking Pre-Order Page - Check Billing City Name As Value in PCMS EN
    Booking Py - Get Billing City Name From PCMS
    Should Be Equal	   ${var_booking_bill_city}          ${var_booking_bill_city_en}

Booking Pre-Order Page - Check Billing Province Name As Value in PCMS EN
    Booking Py - Get Billing Province Name From PCMS
    Should Be Equal	   ${var_booking_bill_province}          ${var_booking_bill_province_en}
