*** Settings ***
Library           Selenium2Library
Resource          WebElement_ThankYouPage.robot
Resource          ../Login/keywords_login.robot    # Library    ${CURDIR}/../../../Python_Library/message_library.py
Resource          ${CURDIR}/../../../../Keyword/API/PCMS/Cart/keywords_cart.robot
Library           ${CURDIR}/../../../../Python_Library/order_promotion_log.py
Library           ${CURDIR}/../../../../Python_Library/message_library.py

*** Variables ***

*** Keywords ***
ThankYou - Close Popup Thor
    ${present}=  Run Keyword And Return Status    Element Should Be Visible   ${Thankyou_ClosePopup}    20s
    Run Keyword If    ${present}    Click Element    ${Thankyou_ClosePopup}

ThankYou - Close Popup
    Wait Until Element Is Visible    ${Thankyou_ClosePopup}    20s
    Click Element    ${Thankyou_ClosePopup}

ThankYou - Close Popup If Exist
    ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${Thankyou_ClosePopup}    20s
    Log To Console    status=${status}
    Run Keyword If    "${status}" == "${True}"    ThankYou - Close Popup
    Sleep    2s

Thankyou - Open Thankyou Page And Get Delivery Text
    [Arguments]    ${lang}=th    ${customer_email}=robotautomate@gmail.com    ${customer_pwd}=true1234
    Open Browser    ${ITM_URL}    ${BROWSER}
    Login User to iTrueMart    ${customer_email}    ${customer_pwd}
    Go To    ${ITM_URL}/${lang}/checkout/thank-you?order_id=${var.order_id}&thank=y
    Thankyou - Get Delivery Text

Thankyou - Get Delivery Text
    Wait Until Element Is Visible    ${Thankyou_DeliveryText}    60s
    ${delivery_text}=    Get Text    ${Thankyou_DeliveryText}
    Set Test Variable    ${actual.delivery_text}    ${delivery_text}

The Shipping Data Same As Address From Checkout2
    [Arguments]    ${product_levelD_name}
    Page Should Contain    ${product_levelD_name}

E-mail Shows Shipping Address Same As Input In Checkout2
    ${email}=    Get Text    ${get_email_Thankyou}
    ${address}=    Get Text    ${get_address_Thankyou}
    Should Be Equal    ${email}    robotautomate@gmail.com
    Should Be Equal    ${address}    This is a robot address แขวง สวนหลวง เขต สวนหลวง กรุงเทพมหานคร 10250

Thankyou - Get order id
    ${get_order_id}=    Get Text    ${Thankyou_OrderID}
    Log To Console    order id=${get_order_id}
    [Return]    ${get_order_id}

Thankyou - Get Order ID II
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_order_id}    ${CHECKOUT_TIMEOUT}
    ${order-id}=    Get Text    ${XPATH_THANKYOU.lbl_order_id}
    Return From Keyword    ${order-id}

Thankyou - Display Header
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_order_status_head}    60s
    Element Should Be Visible    ${XPATH_THANKYOU.lbl_order_status_head}

Thankyou - Header Display Payment Status As Success
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_order_status_head}    60s
    Element Should Contain    ${XPATH_THANKYOU.lbl_order_status_head}    ${MSG_THANKYOU.order_payment_status_success}

Thankyou - Header Display Payment Status As Waiting
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_order_status_head}    ${CHECKOUT_TIMEOUT}
    Element Should Contain    ${XPATH_THANKYOU.lbl_order_status_head}    ${MSG_THANKYOU.order_payment_status_waiting}

Thankyou - Header Display Payment Status As Success EN
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_order_status_head}    60s
    Element Should Contain    ${XPATH_THANKYOU.lbl_order_status_head}    ${MSG_THANKYOU_EN.order_payment_status_success}

Thankyou - Header Display Payment Status As Waiting EN
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_order_status_head}    ${CHECKOUT_TIMEOUT}
    Element Should Contain    ${XPATH_THANKYOU.lbl_order_status_head}    ${MSG_THANKYOU_EN.order_payment_status_waiting}

Thankyou - Count All Items as Expect Qty
    [Arguments]    ${expect_qty}=1
    Wait Until Element Is Visible    ${XPATH_THANKYOU.row_all_item}    ${CHECKOUT_TIMEOUT}
    ${qty}=    Get Matching Xpath Count    ${XPATH_THANKYOU.row_all_item}
    Should Be Equal As Integers    ${qty}    ${expect_qty}
    Log to console    allQty=${qty}
    Log to console    allExpectQty=${expect_qty}

Thankyou - Count Normal Items as Expect Qty
    [Arguments]    ${expect_qty}=1
    Wait Until Element Is Visible    ${XPATH_THANKYOU.row_normal_item}    ${CHECKOUT_TIMEOUT}
    ${qty}=    Get Matching Xpath Count    ${XPATH_THANKYOU.row_normal_item}
    Should Be Equal As Integers    ${qty}    ${expect_qty}
    Log to console    NormalQty=${qty}
    Log to console    NormalExpectQty=${expect_qty}

Thankyou - Count Freebie Items as Expect Qty
    [Arguments]    ${expect_qty}=1
    Wait Until Element Is Visible    ${XPATH_THANKYOU.row_freebie_item}    ${CHECKOUT_TIMEOUT}
    ${qty}=    Get Matching Xpath Count    ${XPATH_THANKYOU.row_freebie_item}
    Should Be Equal As Integers    ${qty}    ${expect_qty}
    Log to console    FreeQty=${qty}
    Log to console    FreeExpectQty=${expect_qty}

Thankyou - Price of Freebie Item Is Zero
    [Arguments]    ${position}=1
    ${element}=    Replace String    ${XPATH_THANKYOU.freebie_item_price_row_x}    ^^position^^    ${position}
    Wait Until Element Is Visible    ${element}    ${CHECKOUT_TIMEOUT}
    ${total_price}=    Get Text    ${element}
    Should Be Equal    ${total_price}    0.00

Thankyou - Total Price of Freebie Item Is Zero
    [Arguments]    ${position}=1
    ${element}=    Replace String    ${XPATH_THANKYOU.freebie_item_total_price_row_x}    ^^position^^    ${position}
    Wait Until Element Is Visible    ${element}    ${CHECKOUT_TIMEOUT}
    ${total_price}=    Get Text    ${element}
    Should Be Equal    ${total_price}    0.00

Thankyou - Display Short description From Camp On Remark
    Wait Until Element Is Visible    ${XPATH_THANKYOU.camp_short_description}    60s
    Element Should Be Visible    ${XPATH_THANKYOU.camp_short_description}
    #### OLD KEYWORDS ####

Display Thankyou Page
    Location Should Contain    /checkout/thank-you

Display Payment Status On Thankyou Page As Success
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_payment_status}    ${CHECKOUT_TIMEOUT}
    Element Should Contain    ${XPATH_THANKYOU.lbl_payment_status}    ${MSG_THANKYOU.payment_status_success}

Display Payment Status On Thankyou Page As Failed
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_payment_status}    ${CHECKOUT_TIMEOUT}
    Element Should Contain    ${XPATH_THANKYOU.lbl_payment_status}    ${MSG_THANKYOU.payment_status_failed}

Display Payment Status On Thankyou Page As Waiting
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_payment_status}    ${CHECKOUT_TIMEOUT}
    Element Should Contain    ${XPATH_THANKYOU.lbl_payment_status}    ${MSG_THANKYOU.payment_status_waiting}

Display Order Status On Thankyou Page As Verify Pending
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_order_status}    ${CHECKOUT_TIMEOUT}
    Element Should Contain    ${XPATH_THANKYOU.lbl_order_status}    ${MSG_THANKYOU.order_status_verify_pending}

Display Tracking Number On Thankyou Page As No Tracking Number
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_tracking_number}    ${CHECKOUT_TIMEOUT}
    Element Should Contain    ${XPATH_THANKYOU.lbl_tracking_number}    ${MSG_THANKYOU.no_tracking_number}

Display Estimated Date Of Delivery On Thankyou Page
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_estimated_date_of_delivery}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${XPATH_THANKYOU.lbl_estimated_date_of_delivery}

Display Normal Price Of First Product On Thankyou Page As Zero
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_first_normal_price}    ${CHECKOUT_TIMEOUT}
    ${normal-price}=    Get Text    ${XPATH_THANKYOU.lbl_first_normal_price}
    ${normal-price}=    Convert String To Float    ${normal-price}
    Should Be Equal As Numbers    ${normal-price}    0.00

Display Quantity Of First Product On Thankyou Page As 1 Item
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_first_quantity}    ${CHECKOUT_TIMEOUT}
    ${quantity}=    Get Text    ${XPATH_THANKYOU.lbl_first_quantity}
    Should Be Equal As Strings    ${quantity}    1

Display Total Price Of First Product On Thankyou Page As Zero
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_first_total_price}    ${CHECKOUT_TIMEOUT}
    ${total-price}=    Get Text    ${XPATH_THANKYOU.lbl_first_total_price}
    ${total-price}=    Convert String To Float    ${total-price}
    Should Be Equal As Numbers    ${total-price}    0.00

Display Summary Total Price On Thankyou Page As Zero
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_summary_total_price}    ${CHECKOUT_TIMEOUT}
    ${total-price}=    Get text    ${XPATH_THANKYOU.lbl_summary_total_price}
    ${total-price}=    Convert String To Float    ${total-price}
    Should Be Equal As Numbers    ${total-price}    0.00

Display Summary Discount Price On Thankyou As Zero
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_summary_discount_price}    ${CHECKOUT_TIMEOUT}
    ${discount-price}=    Get Text    ${XPATH_THANKYOU.lbl_summary_discount_price}
    ${discount-price}=    Convert String To Float    ${discount-price}
    Should Be Equal As Numbers    ${discount-price}    0.00

Display Summary Discount Price On Thankyou As
    [Arguments]    ${exp_discount}
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_summary_discount_price}    ${CHECKOUT_TIMEOUT}
    ${discount-price}=    Get Text    ${XPATH_THANKYOU.lbl_summary_discount_price}
    ${discount-price}=    Replace String    ${discount-price}    ,    ${EMPTY}
    ${discount-price}=    Convert String To Float    ${discount-price}
    ${exp_discount}=    Convert String To Float    ${exp_discount}
    Should Not Be Equal As Numbers    ${discount-price}    ${exp_discount}

Display Summary Shipping Price On Thankyou As Free
    ThankYou - Close Popup Thor
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_summary_shipping_price}    ${CHECKOUT_TIMEOUT}
    ${shipping-price}=    Get Text    ${XPATH_THANKYOU.lbl_summary_shipping_price}
    Should Be Equal As Strings    ${shipping-price}    ฟรี

Display Summary Shipping Price On Thankyou As Not Free
    ThankYou - Close Popup Thor
    Wait Until Element Is Visible     ${XPATH_THANKYOU.lbl_summary_shipping_price}    ${CHECKOUT_TIMEOUT}
    ${shipping-price}=    Get Text    ${XPATH_THANKYOU.lbl_summary_shipping_price}
    Should Not Be Equal As Strings    ${shipping-price}    ฟรี

Display Summary Shipping Price On Thankyou As
    [Arguments]    ${exp_shipping_fee}
    ThankYou - Close Popup Thor
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_summary_shipping_price}    ${CHECKOUT_TIMEOUT}
    ${shipping-price}=    Get Text    ${XPATH_THANKYOU.lbl_summary_shipping_price}
    ${shipping-price}=    Convert String To Float    ${shipping-price}
    Should Be Equal As Numbers    ${shipping-price}    ${exp_shipping_fee}

Display Summary Shipping Price On Thankyou As 49 Baht
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_summary_shipping_price}    ${CHECKOUT_TIMEOUT}
    ${shipping-price}=    Get Text    ${XPATH_THANKYOU.lbl_summary_shipping_price}
    ${shipping-price}=    Convert String To Float    ${shipping-price}
    Should Be Equal As Numbers    ${shipping-price}    49.00

Display Summary Shipping Price On Thankyou As 50 Baht
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_summary_shipping_price}    ${CHECKOUT_TIMEOUT}
    ${shipping-price}=    Get Text    ${XPATH_THANKYOU.lbl_summary_shipping_price}
    ${shipping-price}=    Convert String To Float    ${shipping-price}
    Should Be Equal As Numbers    ${shipping-price}    50.00

Display Summary Sub Total Price On Thankyou As Zero
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_summary_sub_total_price}    ${CHECKOUT_TIMEOUT}
    ${sub-total-price}=    Get Text    ${XPATH_THANKYOU.lbl_summary_sub_total_price}
    ${sub-total-price}=    Py Remove Whitespace    ${sub-total-price}
    ${sub-total-price}=    Replace String    ${sub-total-price}    (รวมภาษีมูลค่าเพิ่ม)    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    <small>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    </small>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    <br>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    \n    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    \r    ${EMPTY}
    ${sub-total-price}=    Convert String To Float    ${sub-total-price}
    Should Be Equal As Numbers    ${sub-total-price}    0.00

Display Summary Sub Total Price On Thankyou As 49 Baht
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_summary_sub_total_price}    ${CHECKOUT_TIMEOUT}
    ${sub-total-price}=    Get Text    ${XPATH_THANKYOU.lbl_summary_sub_total_price}
    ${sub-total-price}=    Py Remove Whitespace    ${sub-total-price}
    ${sub-total-price}=    Replace String    ${sub-total-price}    (รวมภาษีมูลค่าเพิ่ม)    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    <small>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    </small>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    <br>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    \n    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    \r    ${EMPTY}
    ${sub-total-price}=    Convert String To Float    ${sub-total-price}
    Should Be Equal As Numbers    ${sub-total-price}    49.00

Display Summary Sub Total Price On Thankyou As 50 Baht
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_summary_sub_total_price}    ${CHECKOUT_TIMEOUT}
    ${sub-total-price}=    Get Text    ${XPATH_THANKYOU.lbl_summary_sub_total_price}
    ${sub-total-price}=    Py Remove Whitespace    ${sub-total-price}
    ${sub-total-price}=    Replace String    ${sub-total-price}    (รวมภาษีมูลค่าเพิ่ม)    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    <small>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    </small>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    <br>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    \n    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    \r    ${EMPTY}
    ${sub-total-price}=    Convert String To Float    ${sub-total-price}
    Should Be Equal As Numbers    ${sub-total-price}    50.00

Display Summary Sub Total Price On Thankyou As
    [Arguments]    ${exp_price}
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_summary_sub_total_price}    ${CHECKOUT_TIMEOUT}
    ${sub-total-price}=    Get Text    ${XPATH_THANKYOU.lbl_summary_sub_total_price}
    ${sub-total-price}=    Py Remove Whitespace    ${sub-total-price}
    ${sub-total-price}=    Replace String    ${sub-total-price}    (รวมภาษีมูลค่าเพิ่ม)    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    <small>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    </small>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    <br>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    \n    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    \r    ${EMPTY}
    ${sub-total-price}=    Convert String To Float    ${sub-total-price}
    ${exp_price}=    Convert String To Float    ${exp_price}
    Should Be Equal As Numbers    ${exp_price}    50.00

Thankyou Page - Expect Sub Total Price
    [Arguments]    ${expect_price}
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_summary_sub_total_price}    ${CHECKOUT_TIMEOUT}
    ${sub-total-price}=    Get Text    ${XPATH_THANKYOU.lbl_summary_sub_total_price}
    Log To Console    Before Convert=${sub-total-price}
    ${sub-total-price}=    Py Remove Whitespace    ${sub-total-price}
    ${sub-total-price}=    Replace String    ${sub-total-price}    (รวมภาษีมูลค่าเพิ่ม)    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    <small>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    </small>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    <br>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    \n    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    \r    ${EMPTY}
    ${sub-total-price}=    Convert String To Float    ${sub-total-price}
    Log To Console    After Convert=${sub-total-price}
    Should Be Equal As Numbers    ${expect_price}    ${sub-total-price}

Display Correctly Summary Sub Total On Thankyou
    ${total-price}=    Get Total Price On Thankyou Page
    ${discount-price}=    Get Discount Price On Thankyou
    ${shipping-price}=    Get Shipping Price On Thankyou
    ${sub-total-price}=    Get Sub Total Price On Thankyou
    ${summary}=    Evaluate    ${total-price} - ${discount-price}
    ${summary}=    Run Keyword If    '${shipping-price}' != 'ฟรี'    Evaluate    ${summary} + ${shipping-price}
    ...    ELSE    Set Variable    ${summary}
    Log To console    summary=${summary}
    Should Be Equal As Numbers    ${summary}    ${sub-total-price}

Get Order Id To Test Var
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_order_id}    ${CHECKOUT_TIMEOUT}
    ${order-id}=    Get Text    ${XPATH_THANKYOU.lbl_order_id}
    ${dict}=    Set Variable    ${TEST_VAR}
    Set To Dictionary    ${dict}    order_id=${order-id}
    Set Test Variable    ${TEST_VAR}    ${dict}

Get Order ID
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_order_id}    ${CHECKOUT_TIMEOUT}
    ${order-id}=    Get Text    ${XPATH_THANKYOU.lbl_order_id}
    Return From Keyword    ${order-id}

Get Total Price On Thankyou Page
    ThankYou - Close Popup Thor
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_summary_total_price}    ${CHECKOUT_TIMEOUT}
    ${total-price}=    Get text    ${XPATH_THANKYOU.lbl_summary_total_price}
    ${total-price}=    Convert String To Float    ${total-price}
    Return From Keyword    ${total-price}

Get Discount Price On Thankyou
    ThankYou - Close Popup Thor
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_summary_discount_price}    ${CHECKOUT_TIMEOUT}
    ${discount-price}=    Get Text    ${XPATH_THANKYOU.lbl_summary_discount_price}
    ${discount-price}=    Replace String    ${discount-price}    -    ${EMPTY}
    ${discount-price}=    Convert String To Float    ${discount-price}
    Return From Keyword    ${discount-price}

Get Shipping Price On Thankyou
    ThankYou - Close Popup Thor
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_summary_shipping_price}    ${CHECKOUT_TIMEOUT}
    ${shipping-price}=    Get Text    ${XPATH_THANKYOU.lbl_summary_shipping_price}
    ${shipping-price}=    Run Keyword If    '${shipping-price}' != 'ฟรี'    Convert String To Float    ${shipping-price}
    ...    ELSE    Set Variable    ${shipping-price}
    Return From Keyword    ${shipping-price}

Get Sub Total Price On Thankyou
    ThankYou - Close Popup Thor
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_summary_sub_total_price}    ${CHECKOUT_TIMEOUT}
    ${sub-total-price}=    Get Text    ${XPATH_THANKYOU.lbl_summary_sub_total_price}
    ${sub-total-price}=    Py Remove Whitespace    ${sub-total-price}
    ${sub-total-price}=    Replace String    ${sub-total-price}    (รวมภาษีมูลค่าเพิ่ม)    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    <small>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    </small>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    <br>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    \n    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    \r    ${EMPTY}
    ${sub-total-price}=    Convert String To Float    ${sub-total-price}
    Return From Keyword    ${sub-total-price}

Customer Has Been Received SMS Thankyou
    ${order_id}=    Get From Dictionary    ${TEST_VAR}    order_id
    @{message-data}=    Get Sms Thankyou    ${order_id}
    Should Contain    @{message-data}[0]    ${MSG_THANKYOU.sms_subject1}
    Should Contain    @{message-data}[0]    ${MSG_THANKYOU.sms_subject2}

Customer Has Been Received Email Thankyou
    ${order_id}=    Get From Dictionary    ${TEST_VAR}    order_id
    ${message-data}=    Get Email Thankyou    ${order_id}
    Should Contain    @{message-data}[0]    ${MSG_THANKYOU.email_subject}

Customer Has Been Received Email Mnp
    ${order_id}=    Get From Dictionary    ${TEST_VAR}    order_id
    ${message-data}=    Get Email Mnp    ${order_id}
    Should Contain    @{message-data}[0]    ${MSG_THANKYOU.email_mnp_subject}

Customer Does Not Received Email Mnp
    ${order_id}=    Get From Dictionary    ${TEST_VAR}    order_id
    ${message-data}=    Get Email Mnp    ${order_id}
    Should Contain    ${message-data}    None

Customer Does Not Received Email Thankyou
    ${order_id}=    Get From Dictionary    ${TEST_VAR}    order_id
    ${message-data}=    Get Email Thankyou    ${order_id}
    Should Contain    ${message-data}    None

Check Number Of Normal Item On Thankyou Page
    [Arguments]    ${expect_qty}=1
    Wait Until Element Is Visible    ${XPATH_THANKYOU.row_normal_item}    ${CHECKOUT_TIMEOUT}
    ${qty}=    Get Matching Xpath Count    ${XPATH_THANKYOU.row_normal_item}
    Should Be Equal As Integers    ${qty}    ${expect_qty}
    Log to console    NormalQty=${qty}
    Log to console    NormalExpectQty=${expect_qty}

Check Number Of Free Item On Thankyou Page
    [Arguments]    ${expect_qty}=1
    Wait Until Element Is Visible    ${XPATH_THANKYOU.row_freebie_item}    ${CHECKOUT_TIMEOUT}
    ${qty}=    Get Matching Xpath Count    ${XPATH_THANKYOU.row_freebie_item}
    Should Be Equal As Integers    ${qty}    ${expect_qty}
    Log to console    FreeQty=${qty}
    Log to console    FreeExpectQty=${expect_qty}

Check Number Of All Item On Thankyou Page
    [Arguments]    ${expect_qty}=1
    Wait Until Element Is Visible    ${XPATH_THANKYOU.row_all_item}    ${CHECKOUT_TIMEOUT}
    ${qty}=    Get Matching Xpath Count    ${XPATH_THANKYOU.row_all_item}
    Should Be Equal As Integers    ${qty}    ${expect_qty}
    Log to console    allQty=${qty}
    Log to console    allExpectQty=${expect_qty}

Check Freebie Item Price Is Zero
    [Arguments]    ${position}
    ${element}=    Replace String    ${XPATH_THANKYOU.freebie_item_price_row_x}    ^^position^^    ${position}
    Wait Until Element Is Visible    ${element}    ${CHECKOUT_TIMEOUT}
    ${total_price}=    Get Text    ${element}
    Should Be Equal    ${total_price}    0.00

Check Freebie Item Total Price Is Zero
    [Arguments]    ${position}
    ${element}=    Replace String    ${XPATH_THANKYOU.freebie_item_total_price_row_x}    ^^position^^    ${position}
    Wait Until Element Is Visible    ${element}    ${CHECKOUT_TIMEOUT}
    ${total_price}=    Get Text    ${element}
    Should Be Equal    ${total_price}    0.00

Display Remark Short description From Camp On Thankyou
    Wait Until Element Is Visible    ${XPATH_THANKYOU.camp_short_description}    60s
    Element Should Be Visible    ${XPATH_THANKYOU.camp_short_description}

Count Remark Short description From Camp On Thankyou
    [Arguments]    ${expect_qty}=1
    Wait Until Element Is Visible    ${XPATH_THANKYOU.camp_short_description}    ${CHECKOUT_TIMEOUT}
    ${qty}=    Get Matching Xpath Count    ${XPATH_THANKYOU.camp_short_description}
    Should Be Equal As Integers    ${qty}    ${expect_qty}

Display Order Payment Status On Thankyou Page As Waiting
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_order_status_head}    ${CHECKOUT_TIMEOUT}
    Element Should Contain    ${XPATH_THANKYOU.lbl_order_status_head}    ${MSG_THANKYOU.order_payment_status_waiting}

Display Order Payment Status On Thankyou Page As Success
    Wait Until Element Is Visible    ${XPATH_THANKYOU.lbl_order_status_head}    60s
    Element Should Contain    ${XPATH_THANKYOU.lbl_order_status_head}    ${MSG_THANKYOU.order_payment_status_success}

Display Cybersource Page
    Location Should Contain    /payments/v1/cybersource

Display Payment Kbank Page
    Location Should Contain    kbank

Assert item on thank you page
    Comment    Wait Until Element is ready and click    //*[@id="popup-regis"]//img[@class="close-modal"]    60s
    Wait Until Element Is Visible    //*[@class="p-order"]/div[2]/div[2]    10s
    Wait Until Element Is Visible    //*[@class="p-order"]/div[2]/div[3]    10s
    Wait Until Element Is Visible    //*[@class="p-order"]/div[2]/div[4]    10s
    Wait Until Element Is Visible    //*[@class="p-order"]/div[2]/div[5]    10s
    Wait Until Element Is Visible    //*[@class="p-order"]/div[2]/div[6]    10s
    Wait Until Element Is Visible    //*[@class="p-order"]/div[2]/div[7]    10s
    Wait Until Element Is Visible    //*[@class="p-order"]/div[2]/div[8]    10s

Verify discount on thank you page
    [Arguments]    ${expect_discount}
    #ThankYou - Close Popup Thor
    ${sub_total}=    Get Total Price On Thankyou Page
    ${discount}=    Get Discount Price On Thankyou
    ${shipping_fee}=    Get Shipping Price On Thankyou
    ${total_price}=    Get Sub Total Price On Thankyou

    ${shipping_fee}=    Run Keyword If    '${shipping_fee}' == 'ฟรี'   Set Variable    0
    ...    ELSE    Set Variable    ${shipping_fee}

    ${sub_total}=     Convert To Number    ${sub_total}    2
    ${shipping_fee}=     Convert To Number    ${shipping_fee}    2
    ${discount}=     Convert To Number    ${discount}    2
    ${discount}=     convert_float_to_float_2digit    ${discount}
    ${total_price}=     Convert To Number    ${total_price}    2
    ${total_price}=     convert_float_to_float_2digit    ${total_price}

    Should Be Equal     ${discount}    ${expect_discount}
    ${total}=    Evaluate    (${sub_total} + ${shipping_fee}) - ${expect_discount}
    ${total}=    convert_float_to_float_2digit    ${total}
    Should Be Equal    ${total}    ${total_price}

Verify discount on thank you page for mobile
    [Arguments]    ${expect_discount}
    ${sub_total}=    Get Total Price On Thankyou Page
    ${discount}=    Get Discount Price On Thankyou
    ${shipping_fee}=    Get Shipping Price On Thankyou
    ${total_price}=    Get Sub Total Price On Thankyou

    ${shipping_fee}=    Run Keyword If    '${shipping_fee}' == 'ฟรี'   Set Variable    0
    ...    ELSE    Set Variable    ${shipping_fee}

    ${sub_total}=     Convert To Number    ${sub_total}    2
    ${shipping_fee}=     Convert To Number    ${shipping_fee}    2
    ${discount}=     Convert To Number    ${discount}    2
    ${discount}=     convert_float_to_float_2digit    ${discount}
    ${total_price}=     Convert To Number    ${total_price}    2
    ${total_price}=     convert_float_to_float_2digit    ${total_price}

    Should Be Equal     ${discount}    ${expect_discount}
    ${total}=    Evaluate    (${sub_total} + ${shipping_fee}) - ${expect_discount}
    ${total}=    convert_float_to_float_2digit    ${total}
    Should Be Equal    ${total}    ${total_price}

Thankyou Page - Check Order Promotiom Log
    [Arguments]    ${order_id}
    ${row}=    chk_order_promotion_log    ${order_id}
    Should Be Equal As Integers    0    ${row[0]}
    # [Return]    ${row}

Thankyou Page - Check DB Send Email
    [Arguments]    ${order_id}    ${email}    ${total_price}=None
    ${row}=    get_thankyou_send_smail    ${order_id}    ${email}
    # Log To Console    xxx====${row}
    #Should Not Be Equal As Integers    0    ${row[0]}
    # ${escaped}=    Regexp Escape    ''
    Should Match Regexp    ${row[5]}    <td .*>0.00</td>
    Run Keyword If    '${total_price}' != 'None'    Should Match Regexp    ${row[5]}    <div>${total_price}</div>

Thankyou Page - Expect Product Is Displayed
    [Arguments]    ${product_name}
    Wait Until Element Is Visible    ${XPATH_THANKYOU.row_all_item}    60s
    ${element_product_name}=    Get Text    ${XPATH_THANKYOU.row_all_item}[1]/div[contains(@class, "p-title-p")]
    ${product_name}=    Remove String    ${product_name}    ${SPACE}
    ${element_product_name}=    Remove String    ${element_product_name}    ${SPACE}
    Log To Console    thk_page_product_name=${product_name}
    Log To Console    thk_page_expect_product_name=${element_product_name}
    Should Contain    ${element_product_name}    ${product_name}
    # Element Should Contain    ${XPATH_THANKYOU.row_all_item}[1]/div[contains(@class, "p-title-p")]    ${product_name}

Thankyou Page - Expect Product Is Not Displayed
    [Arguments]    ${product_name}
    Wait Until Element Is Visible    ${XPATH_THANKYOU.row_all_item}    60s
    Page Should Not Contain    ${product_name}
    Element Should Not Contain    ${XPATH_THANKYOU.row_all_item}[1]/div[contains(@class, "p-title-p")]    ${product_name}
