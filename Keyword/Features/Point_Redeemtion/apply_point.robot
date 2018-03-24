*** Settings ***
Library           HttpLibrary.HTTP
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_wemall_common.robot
Resource          ${CURDIR}/../../../Keyword/Features/Point_Redeemtion/WebElement_apply_point.robot
Library           ${CURDIR}/../../../Python_Library/float.py
Library           ${CURDIR}/../../../Python_Library/DatabaseDataPoint.py
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/sticky_header/keywords_sticky_header.robot

*** Keywords ***
Point - Verify Point Redeem Tab is Shown
    Wait Until Element Is Visible    id=point_tab    10

Point - Click on Redeem Point Tab
    Wait Until Element Is Visible     id=point_tab     10
    Sleep   3s
    Click Element    id=point_tab

Point - Choose Trueyou Channel
    Wait Until Element Is Visible    name=partnerRadioOptions    10
    Select Radio Button    partnerRadioOptions    trueyou

Point - Choose Trueyou Channel For Mobile
    Wait Until Element Is Visible    //*[@id="mydropdown"]/div/a/label    20
    Click Element       //*[@id="mydropdown"]/div/a/label
    Wait Until Element Is Visible    //*[@id="mydropdown"]/ul/li[1]/a/label    10
    Click Element   //*[@id="mydropdown"]/ul/li[1]/a/label

Point - Input Trueyou Account
    [Arguments]     ${trueyou_user}     ${trueyou_pass}
    Wait Until Ajax Loading Is Not Visible
    Wait Until Element Is Visible    id=username    20
    Wait Until Element Is Visible    id=password    20
    Input Text    id=username     ${trueyou_user}
    Input Text    id=password     ${trueyou_pass}

    Click Element    id=cartlightbox-go-next
    Sleep    10

Point - Verify Point in DB - Order Shipment Item Table
    [Arguments]     ${item_id}     ${redeem_point_ui}     ${redeem_point_to_money_ui}     ${redeem_point_to_money_original_ui}     ${redeem_partner_ui}
    ${point_data_db}=    Get Point Data From Order Shipment Item     ${item_id}
    Should Be Equal As Numbers      ${redeem_point_ui}     ${point_data_db[1]}
    Should Be Equal As Numbers      ${redeem_point_to_money_ui}     ${point_data_db[2]}
    Should Be Equal As Numbers      ${redeem_point_to_money_original_ui}     ${point_data_db[3]}
    Should Be Equal As Strings      ${redeem_partner_ui}    ${point_data_db[4]}

Point - Verify Point in DB is Not None - Order Shipment Item Table
    [Arguments]     ${item_id}
    ${point_data_db}=    Get Point Data From Order Shipment Item     ${item_id}
    ${redeem_point_ui}=     Convert To String    ${point_data_db[1]}
    ${redeem_point_to_money_ui}=     Convert To String    ${point_data_db[2]}
    ${redeem_point_to_money_original_ui}=     Convert To String    ${point_data_db[3]}
    ${redeem_partner_ui}=     Convert To String    ${point_data_db[4]}
    Should Not Be Equal As Strings     ${redeem_point_ui}    None
    Should Not Be Equal As Strings     ${redeem_point_to_money_ui}    None
    Should Not Be Equal As Strings     ${redeem_point_to_money_original_ui}    None
    Should Not Be Equal As Strings     ${redeem_partner_ui}    None

Point - Verify Point in DB is None - Order Shipment Item Table
    [Arguments]     ${item_id}
    ${point_data_db}=    Get Point Data From Order Shipment Item     ${item_id}
    ${redeem_point_ui}=     Convert To String    ${point_data_db[1]}
    ${redeem_point_to_money_ui}=     Convert To String    ${point_data_db[2]}
    ${redeem_point_to_money_original_ui}=     Convert To String    ${point_data_db[3]}
    ${redeem_partner_ui}=     Convert To String    ${point_data_db[4]}
    Should Be Equal As Strings     ${redeem_point_ui}    None
    Should Be Equal As Strings     ${redeem_point_to_money_ui}    None
    Should Be Equal As Strings     ${redeem_point_to_money_original_ui}    None
    Should Be Equal As Strings     ${redeem_partner_ui}    None

Point - Choose Discount and Click Next
    [Arguments]    ${point}=1     ${next_process}=true
    Sleep    5
    Wait Until Element Is Not Visible    jquery=div.ajaxloading-widget-background    60
    Wait Until Element Is Enabled    id=chk_tandc     60
    Select Checkbox    id=chk_tandc
    Wait Until Element Is Enabled   xpath=//select[@name="point"]    60
    Select From List    xpath=//select[@name="point"]    ${point}
    Wait Until Element Is Not Visible    jquery=div.ajaxloading-widget-background    60
    Wait Until Element Is Enabled    id=cartlightbox-go-next     60

    Run Keyword IF    '${next_process}'=='true'   Click Element    id=cartlightbox-go-next
    ...   ELSE    Click Element    jquery=.close

    # Click Element    id=cartlightbox-go-next
    Sleep    5

Point - Verify Point and Discount are displayed
    [Arguments]     ${point}     ${money}
    ${point_verify}=     Convert To Number    ${point}    2
    ${point_verify}=     convert_float_to_float_2digit    ${point_verify}
    ${point_verify}=     Convert To String    ${point_verify}
    ${money}=     Convert To Number    ${money}    2
    ${money}=     convert_float_to_float_2digit    ${money}
    ${money}=     Convert To String    ${money}

    Wait Until Element Is Visible    //*[@id="summary-redeem-point"]    60
    Wait Until Element Is Visible    //*[@id="summary-redeem-money"]    60
    ${actual_point}=    Get Text    //*[@id="summary-redeem-point"]
    ${actual_money}=    Get Text    //*[@id="summary-redeem-money"]

    Should Contain    ${actual_point}     ${point_verify}
    Should Contain    ${actual_money}    - ${money}

Point - Get Discount from Point
    Wait Until Element Is Visible    id=summary-redeem-money
    ${discount}=    Get Text    id=summary-redeem-money
    Return From Keyword    ${discount}

Point - Verify Sub Total Price After Apply Point
    [Arguments]     ${subtotal_before}     ${subtotal_after}
    Should Be Equal    ${subtotal_before}    ${subtotal_after}

Point - Verify Discount After Apply Point
    [Arguments]     ${discount_before}     ${discount_after}    ${point_discount}
    ${point_discount}=    Convert To String    ${point_discount}
    ${point_discount}=    Replace String    ${point_discount}    ${SPACE}    ${EMPTY}
    ${point_discount}=    Replace String    ${point_discount}    -    ${EMPTY}
    ${point_discount}=    Convert To Number    ${point_discount}    2
    ${point_discount}=    convert_float_to_float_2digit    ${point_discount}
    ${discount}=    Evaluate    ${discount_before} + ${point_discount}
    ${discount}=    convert_float_to_float_2digit    ${discount}
    Should Be Equal    ${discount_after}    ${discount}

Point - Verify Total Price After Apply Point
    [Arguments]     ${sub_total_price_before_apply}     ${shipping_fee}     ${total_price_after_apply}    ${discount}
    ${shipping_fee}=    Run Keyword If    '${shipping_fee}' == 'ฟรี'   Set Variable    0
    ...    ELSE    Set Variable    ${shipping_fee}
    ${discount}=    Convert To String    ${discount}
    ${discount}=    Replace String    ${discount}    ${SPACE}    ${EMPTY}
    ${discount}=    Replace String    ${discount}    -    ${EMPTY}
    ${discount}=    Convert To Number    ${discount}    2
    ${discount}=    convert_float_to_float_2digit    ${discount}
    ${total}=    Evaluate    (${sub_total_price_before_apply} + ${shipping_fee}) - ${discount}
    ${total}=    convert_float_to_float_2digit    ${total}
    Should Be Equal    ${total_price_after_apply}    ${total}

# Point - Calculate Point Discount
#     [Arguments]     ${ratio}     ${point}
#     ${money}=    Evaluate    ${ratio}*${point}
#     Return From Keyword    ${money}

Point - Calculate Point Discount
    [Arguments]     @{rate}
    ${discount}=    Set Variable    0
    : FOR    ${ratio}    ${point}    IN    @{rate}
    \    ${money}=    Evaluate    ${ratio} * ${point}
    \    ${discount}=    Evaluate    ${discount} + ${money}
    Return From Keyword    ${discount}

Point - Click on Edit Point Tab
    Wait Until Element Is Visible     id=change-point-value     5
    Scroll Page To Element    itm    id=change-point-value
    Click Element    id=change-point-value

Point - Edit Point For True You
    [Arguments]     ${point}=5    ${next_process}=true
    Point - Click on Edit Point Tab
    Point - Choose Trueyou channel
    Wait Until Element Is Visible   xpath=//select[@name="point"]
    Select From List    xpath=//select[@name="point"]    ${point}
    Point - Choose Discount and Click Next    ${point}    ${next_process}


Point - Verify Message - Cannot use point via offline payment
    Sleep    5
    Page Should Contain    หากลูกค้าต้องการเลือกช่องทางนี้ในการชำระเงิน จะไม่สามารถใช้คะแนนสะสมในการรับส่วนลดได้ค่ะ หรือ หากลูกค้ายืนยันจะใช้ช่องทางนี้ กรุณายกเลิกคะแนนสะสมก่อนค่ะ

Point - Verify Point in DB - Cart Table
    [Arguments]     ${user_id}    ${point}    ${point_discount_money}    ${point_partner}
    ${point_data}=    Py Get Cart Detail Point    ${user_id}
    Should Be Equal As Numbers    ${point_data[0]}    ${point}
    Should Be Equal As Numbers    ${point_data[1]}    ${point_discount_money}
    Should Be Equal As Strings    ${point_data[2]}    ${point_partner}

Point - Verify Point in DB is None - Cart Table
    [Arguments]     ${user_id}
    ${point_data}=    Py Get Cart Detail Point    ${user_id}
    Should Be Equal As Strings     ${point_data[0]}    None
    Should Be Equal As Strings     ${point_data[1]}    None
    Should Be Equal As Strings     ${point_data[2]}    None

Point - Verify Point in DB is Not None - Cart Table
    [Arguments]     ${user_id}
    ${point_data}=    Py Get Cart Detail Point    ${user_id}
    Should Not Be Equal As Strings     ${point_data[0]}    None
    Should Not Be Equal As Strings     ${point_data[1]}    None
    Should Not Be Equal As Strings     ${point_data[2]}    None

Point - Verify Point Error Page Cannot Redeem Point
    [Arguments]    ${lang}=th
    Wait Until Element Is Visible    ${JQUERY_ERROR_PAGE_DIV_ICON_CANCEL}    ${CHECKOUT_TIMEOUT}
    Selenium2Library.Element Text Should Be    ${JQUERY_ERROR_PAGE_DIV_ICON_CANCEL} h1    ${TXT_ERROR_PAGE_H1.${lang}}
    Selenium2Library.Element Text Should Be    ${JQUERY_ERROR_PAGE_DIV_ICON_CANCEL} span    ${TXT_ERROR_PAGE_SPAN.${lang}}

Point - Remove Point
    Click Element    //div[@id="redeem_main"]//div[@id="delete-point"]
    Wait Until Ajax Loading Is Not Visible

Point - Get User Point
    Wait Until Element Is Visible    ${user-point-remain}    60s
    ${user-point-remain}=    Get Text    ${user-point-remain}
    Return From Keyword    ${user-point-remain}

Verify Shipping Fee on Cart-light-box As Free
    [Arguments]    ${lang}
    Wait Until Element Is Visible    jquery=.sum    15s
    ${shipping_fee_value}=    Get Text    jquery=.sum

    ${expect_shipping_fee}=    Run Keyword If    '${lang}'=='th'    Set Variable    ฟรี
    ...    ELSE    Set Variable    free

    Should Be Equal As Strings    ${shipping_fee_value}    ${expect_shipping_fee}

Verify Shipping Fee on Cart-light-box As Not Free
    [Arguments]    ${expect_shipping_fee}
    Wait Until Element Is Visible    jquery=.sum    15s
    ${shipping_fee_value}=    Get Text    jquery=.sum

    # ${shipping_fee_value}=    Convert String To Float    ${shipping_fee_value}
    Should Be Equal As Numbers    ${shipping_fee_value}    ${expect_shipping_fee}

Apply Edit Point
    [Arguments]    ${point}=10    ${ratio}=0.1
    ${rate}=     Create List     ${ratio}    ${point}
    ${expected_point_discount}=     Point - Calculate Point Discount    @{rate}
    Point - Edit Point For True You    ${point}
    [Return]    ${expected_point_discount}

Apply Point
    [Arguments]    ${point}=10    ${ratio}=0.1    ${trueyou_user}=runoinar@gmail.com    ${trueyou_pass}=75103598
    ${rate}=     Create List     ${ratio}    ${point}
    ${expected_point_discount}=     Point - Calculate Point Discount    @{rate}
    Wait For Ajax Load Shipping Fee On Mini Cart
    ${sub_total_price_before}=     Checkout3 - mini cart - Get Sub Total Price
    ${discount_before}=     Checkout3 - mini cart - Get All Discount Price
    ${total_price_before}=     Checkout3 - mini cart - Get Total Price

    Point - Verify Point Redeem Tab is Shown
    Point - Click on Redeem Point Tab
    Point - Choose Trueyou channel
    ${status_login_trueyou}=    Run Keyword And Return Status    Wait Until Element Is Visible    id=username    20
    Run Keyword IF    ${status_login_trueyou}   Point - Input Trueyou Account     ${trueyou_user}    ${trueyou_pass}
    Point - Choose Discount and Click Next    ${point}
    Point - Verify Point and Discount are displayed     ${point}     ${expected_point_discount}

    Wait For Ajax Load Shipping Fee On Mini Cart
    ${point_discount}=    Point - Get Discount from Point
    ${sub_total_price_after}=     Checkout3 - mini cart - Get Sub Total Price
    ${discount_after}=     Checkout3 - mini cart - Get All Discount Price
    ${total_price_after}=     Checkout3 - mini cart - Get Total Price
    ${Shipping_fee}=     Checkout3 - mini cart - Get Shipping Price

   # verify price
    Point - Verify Sub Total Price After Apply Point    ${sub_total_price_before}    ${sub_total_price_after}
    Point - Verify Discount After Apply Point     ${discount_before}    ${discount_after}    ${point_discount}
    Point - Verify Total Price After Apply Point    ${sub_total_price_before}    ${Shipping_fee}    ${total_price_after}    ${point_discount}

    [Return]    ${expected_point_discount}

Apply Point For Mobile
    [Arguments]    ${point}=10    ${ratio}=0.1    ${trueyou_user}=runoinar@gmail.com    ${trueyou_pass}=75103598
    ${rate}=     Create List     ${ratio}    ${point}
    ${expected_point_discount}=     Point - Calculate Point Discount    @{rate}

    Wait For Ajax Load Shipping Fee On Mini Cart
    ${sub_total_price_before}=     Checkout3 - mini cart - Get Sub Total Price For Mobile
    ${discount_before}=     Checkout3 - mini cart - Get All Discount Price For Mobile
    ${total_price_before}=     Checkout3 - mini cart - Get Total Price For Mobile

    Point - Verify Point Redeem Tab is Shown
    Point - Click on Redeem Point Tab
    Point - Choose Trueyou Channel For Mobile
    Wait Until Ajax Loading Is Not Visible
    ${status_login_trueyou}=    Run Keyword And Return Status    Wait Until Element Is Visible    id=username    20
    Run Keyword IF    ${status_login_trueyou}   Point - Input Trueyou Account     ${trueyou_user}    ${trueyou_pass}
    Wait Until Ajax Loading Is Not Visible
    Point - Choose Discount and Click Next    ${point}
    Point - Verify Point and Discount are displayed     ${point}     ${expected_point_discount}

    ${point_discount}=    Point - Get Discount from Point
    Wait For Ajax Load Shipping Fee On Mini Cart
    ${sub_total_price_after}=     Checkout3 - mini cart - Get Sub Total Price For Mobile
    ${discount_after}=     Checkout3 - mini cart - Get All Discount Price For Mobile
    ${total_price_after}=     Checkout3 - mini cart - Get Total Price For Mobile
    ${Shipping_fee}=     Checkout3 - mini cart - Get Shipping Price For Mobile

   # verify price
    Point - Verify Sub Total Price After Apply Point    ${sub_total_price_before}    ${sub_total_price_after}
    Point - Verify Discount After Apply Point     ${discount_before}    ${discount_after}    ${point_discount}
    Point - Verify Total Price After Apply Point    ${sub_total_price_before}   ${Shipping_fee}    ${total_price_after}    ${discount_after}

    [Return]    ${expected_point_discount}

Display Full Cart And Verify Shipping Fee As Free
    Go To    ${ITM_URL}/cart
    Display Summary Shipping Price On Full Cart As Free

Display Full Cart And Verify Shipping Fee Not Free
    Go To    ${ITM_URL}/cart
    Display Summary Shipping Price On Full Cart Not Free

Go To Checkout1 Until Checkout3 And Verify Shipping Fee
    [Arguments]       ${shipping_fee}=0       ${verify_on_cart_lightbox}=0
    ${shipping_fee_send}=     Run Keyword If  ${shipping_fee} == 0       Set Variable     ฟรี       ELSE      Set Variable      ${shipping_fee}
    Go to     ${ITM_URL}/checkout/step1
    Run Keyword IF    1 == ${verify_on_cart_lightbox}   Verify Shipping fee Mini Cart And Cart Light Box      ${shipping_fee_send}
    ...    ELSE     Mini Cart - Verify Shipping fee        ${shipping_fee_send}
    Checkout1 - Input Email    ${Text_Email}
    Checkout1 - Click Next
    Checkout1 - Wait Loading
    Checkout2 - Input Name     ${Text_Name}
    Checkout2 - Input Phone    ${Text_Phone}
    Checkout2 - Select Province
    Checkout2 - Select District
    Checkout2 - Select SubDistrict
    Checkout2 - Select ZipCode
    Checkout2 - Input Address    ${Text_Address}
    Run Keyword IF    1 == ${verify_on_cart_lightbox}   Verify Shipping fee Mini Cart And Cart Light Box      ${shipping_fee_send}
    ...    ELSE     Mini Cart - Verify Shipping fee        ${shipping_fee_send}
    Checkout2 - Click Next
    Run Keyword IF    1 == ${verify_on_cart_lightbox}   Verify Shipping fee Mini Cart And Cart Light Box      ${shipping_fee_send}
    ...    ELSE     Mini Cart - Verify Shipping fee        ${shipping_fee_send}

#Verify Shipping fee Mini Cart And Cart Light Box
#    [Arguments]       ${shipping_fee_send}
#    Mini Cart - Verify Shipping Fee      ${shipping_fee_send}
#    Click Element      id=btn-edit-cart
#    Wait Until Element Is Visible       jquery=.item-name     30
#    CartLightBox - Verify Shipping Fee       ${shipping_fee_send}
#    # Reload Page
#    Wait Until Ajax Loading Is Not Visible
#    Click Element At Coordinates    jquery=.modal-open    1    1

Verify Point Reference Id on Order DB Not None
    [Arguments]       ${order_id}
    ${point_reference_id}=    Get Point Reference Id Data    ${order_id}
    Should Not Be Equal as Strings      ${point_reference_id[0]}       None

Verify Point Reference Id on Order DB None
    [Arguments]       ${order_id}
    ${point_reference_id}=    Get Point Reference Id Data    ${order_id}
    Should Be Equal as Strings      ${point_reference_id[0]}       None

Point - Update Product Qty In Cart
    [Arguments]    ${inventory_id}    ${qty}
    Wait Until Element Is Visible    id=btn-edit-cart    30
    Click Element    id=btn-edit-cart
    Wait Until Element Is Visible    //select[@data-inventory-id="${inventory_id}"]    30
    Select From List By Value    //select[@data-inventory-id="${inventory_id}"]    ${qty}
    Wait Until Ajax Loading Is Not Visible
    Wait Until Element Is Visible    //*[@id="cartlightbox-go-next"]    20s
    Click Element    //*[@id="cartlightbox-go-next"]

Point - Update Product Qty In Cart For Mobile
    [Arguments]    ${inventory_id}    ${qty}
#    Wait Until Element Is Visible    //*[@id="minicart-container"]/h2/div/a    30
#    Click Element    //*[@id="minicart-container"]/h2/div/a
    Wait Until Element Is Visible    jquery=span.edit-cart a    30
    Scroll Page To Element    itm    jquery=span.edit-cart a
    Click Element    jquery=span.edit-cart a
    Wait Until Element Is Visible    //select[@data-inventory_id="${inventory_id}"]
    Select From List By Value    //select[@data-inventory_id="${inventory_id}"]    ${qty}
    Sleep     5
    Click Element   //*[@id="proceed_to_checkout_button"]

Go To Checkout1 Until Checkout3
    Go To    ${ITM_URL}/checkout/step1
    Checkout 1 - Input Email       ${Text_Email}
    Checkout 1 - Click Next
    Checkout 2 - Input Name     ${Text_Name}
    Checkout 2 - Input Phone    ${Text_Phone}
    Checkout 2 - Select Province
    Checkout 2 - Select District
    Checkout 2 - Select SubDistrict
    Checkout 2 - Select ZipCode
    Checkout 2 - Input Address     ${Text_Address}
    Checkout 2 - Click Next

Web - Go To Checkout1 And Input Step
    [Arguments]    ${Text_Email}
    Go To    ${ITM_URL}/checkout/step1
    Checkout 1 Mobile - Input Email       ${Text_Email}
    Checkout 1 Mobile - Click Next

Web - Go To Checkout2 And Input Step
    [Arguments]    ${Text_Name}    ${Text_Phone}    ${Text_Address}
    Go To    ${ITM_URL}/checkout/step2
    Checkout 2 - Input Name     ${Text_Name}
    Checkout 2 - Input Phone    ${Text_Phone}
    Checkout 2 - Select Province
    Checkout 2 - Select District
    Checkout 2 - Select SubDistrict
    Checkout 2 - Select ZipCode
    Checkout 2 - Input Address     ${Text_Address}
    Checkout 2 - Click Next

Mobile - Go To Checkout1 And Input Step
    [Arguments]    ${Text_Email}
    Go To    ${ITM_MOBILE_URL}/checkout/step1
    Checkout 1 Mobile - Input Email       ${Text_Email}
    Checkout 1 Mobile - Click Next

Mobile - Go To Checkout2 And Input Step
    [Arguments]    ${Text_Name}    ${Text_Phone}    ${Text_Address}
    Go To    ${ITM_URL}/checkout/step2
    Checkout 2 Mobile - Input Name     ${Text_Name}
    Checkout 2 Mobile - Input Phone    ${Text_Phone}
    Checkout 2 Mobile - Select Province
    Checkout 2 Mobile - Select District
    Checkout 2 Mobile - Select SubDistrict
    Checkout 2 Mobile - Select ZipCode
    Checkout 2 Mobile - Input Address     ${Text_Address}
    Mini Cart - Verify Shipping Fee On Mobile       ${shipping_fee_send}
    Checkout 2 Mobile - Click Next

Wait For Ajax Load And Verify Discount On Mini Cart
    [Arguments]    ${sub_total_price_before}    ${discount_before}    ${point_discount}
    Wait For Ajax Load Shipping Fee On Mini Cart
    ${total_price_expect}=     Checkout3 - mini cart - Get Total Price
    ${discount_expect}=     Checkout3 - mini cart - Get All Discount Price
    ${sub_total_price_expect}=     Checkout3 - mini cart - Get Sub Total Price
    ${Shipping_fee}=      Checkout3 - mini cart - Get Shipping Price
    Log to console    Total is ${total_price_expect}
    Log to console    Sub Total is ${sub_total_price_expect}
    Log to console    DisCount ${discount_expect}
    Point - Verify Total Price After Apply Point    ${sub_total_price_before}    ${Shipping_fee}    ${total_price_expect}    ${point_discount}
    Point - Verify Sub Total Price After Apply Point    ${sub_total_price_before}    ${sub_total_price_expect}
    Point - Verify Discount After Apply Point     ${discount_before}    ${discount_expect}    ${point_discount}

Go To Checkout1 Until Checkout2 And Verify Discount
    [Arguments]    ${sub_total_price_before}    ${discount_before}    ${point_discount}
    Go To    ${ITM_URL}/checkout/step1
    Wait For Ajax Load And Verify Discount On Mini Cart    ${sub_total_price_before}    ${discount_before}    ${point_discount}

    Go To    ${ITM_URL}/checkout/step2
    Wait For Ajax Load And Verify Discount On Mini Cart    ${sub_total_price_before}    ${discount_before}    ${point_discount}

Go To Checkout2 And Verify Discount For Mobile
    [Arguments]        ${sub_total_price_before}        ${discount_before}        ${point_discount}
    Go To    ${ITM_MOBILE_URL}/checkout/step2
    Wait For Ajax Load Shipping Fee On Mini Cart
    ${total_price_expect}=     Checkout3 - mini cart - Get Total Price For Mobile
    ${discount_expect}=     Checkout3 - mini cart - Get All Discount Price For Mobile
    ${sub_total_price_expect}=     Checkout3 - mini cart - Get Sub Total Price For Mobile
    ${Shipping_fee}=      Checkout3 - mini cart - Get Shipping Price For Mobile
    Point - Verify Total Price After Apply Point    ${sub_total_price_before}    ${Shipping_fee}    ${total_price_expect}    ${point_discount}
    Point - Verify Sub Total Price After Apply Point    ${sub_total_price_before}    ${sub_total_price_expect}
    Point - Verify Discount After Apply Point     ${discount_before}    ${discount_expect}    ${point_discount}


Go To Checkout1 Until Checkout2 And Verify Discount For Mobile
    [Arguments]        ${sub_total_price_before}        ${discount_before}        ${point_discount}
    Go To    ${ITM_MOBILE_URL}/checkout/step1
    Wait For Ajax Load Shipping Fee On Mini Cart
    ${total_price_expect}=     Checkout3 - mini cart - Get Total Price
    ${discount_expect}=     Checkout3 - mini cart - Get All Discount Price
    ${sub_total_price_expect}=     Checkout3 - mini cart - Get Sub Total Price
    ${Shipping_fee}=      Checkout3 - mini cart - Get Shipping Price
    Log to console    Total is ${total_price_expect}
    Log to console    Sub Total is ${sub_total_price_expect}
    Log to console    Dis Count ${discount_expect}
    Point - Verify Total Price After Apply Point    ${sub_total_price_before}    ${Shipping_fee}    ${total_price_expect}    ${point_discount}
    Point - Verify Sub Total Price After Apply Point    ${sub_total_price_before}    ${sub_total_price_expect}
    Point - Verify Discount After Apply Point     ${discount_before}    ${discount_expect}    ${point_discount}

    Go To Checkout2 And Verify Discount    ${sub_total_price_before}        ${discount_before}        ${point_discount}

Go To Checkout1 Until Checkout3 And Verify Discount
    [Arguments]        ${sub_total_price_before}        ${discount_before}        ${total_price_before}        ${point_discount}
    Go To    ${ITM_URL}/checkout/step1
    Wait For Ajax Load Shipping Fee On Mini Cart
    ${total_price_expect}=     Checkout3 - mini cart - Get Total Price
    ${discount_expect}=     Checkout3 - mini cart - Get All Discount Price
    ${sub_total_price_expect}=     Checkout3 - mini cart - Get Sub Total Price
    ${Shipping_fee}=      Checkout3 - mini cart - Get Shipping Price
    Log to console    Total is ${total_price_expect}
    Log to console    Sub Total is ${sub_total_price_expect}
    Log to console    Dis Count ${discount_expect}
    Point - Verify Total Price After Apply Point    ${sub_total_price_before}    ${Shipping_fee}    ${total_price_expect}    ${point_discount}
    Point - Verify Sub Total Price After Apply Point    ${sub_total_price_before}    ${sub_total_price_expect}
    Point - Verify Discount After Apply Point     ${discount_before}    ${discount_expect}    ${point_discount}

    Go To    ${ITM_URL}/checkout/step2
    Wait For Ajax Load Shipping Fee On Mini Cart
    ${total_price_expect}=     Checkout3 - mini cart - Get Total Price
    ${discount_expect}=     Checkout3 - mini cart - Get All Discount Price
    ${sub_total_price_expect}=     Checkout3 - mini cart - Get Sub Total Price
    ${Shipping_fee}=      Checkout3 - mini cart - Get Shipping Price
    Point - Verify Total Price After Apply Point    ${sub_total_price_before}    ${Shipping_fee}    ${total_price_expect}    ${point_discount}
    Point - Verify Sub Total Price After Apply Point    ${sub_total_price_before}    ${sub_total_price_expect}
    Point - Verify Discount After Apply Point     ${discount_before}    ${discount_expect}    ${point_discount}

    Go To    ${ITM_URL}/checkout/step3
    Wait For Ajax Load Shipping Fee On Mini Cart
    ${total_price_expect}=     Checkout3 - mini cart - Get Total Price
    ${discount_expect}=     Checkout3 - mini cart - Get All Discount Price
    ${sub_total_price_expect}=     Checkout3 - mini cart - Get Sub Total Price
    ${Shipping_fee}=      Checkout3 - mini cart - Get Shipping Price
    Point - Verify Total Price After Apply Point    ${sub_total_price_before}    ${Shipping_fee}    ${total_price_expect}    ${point_discount}
    Point - Verify Sub Total Price After Apply Point    ${sub_total_price_before}    ${sub_total_price_expect}
    Point - Verify Discount After Apply Point     ${discount_before}    ${discount_expect}    ${point_discount}

Point - Get Customer ref id
    ${URL}=         Get Location
    Go To  ${ITM_URL}/test/user
    sleep  10s
    Wait Until Element Is Visible    //i[1]
    ${group}=    Get Text    //i[1]
    Log to console    ${group}
    ${idx}=    Set Variable If    ${group} == "guest"    2    3
    ${user_type}=    Set Variable If    ${group} == "guest"    non-user    user
    ${user_id}=    Get Text    //i[${idx}]
    ${Customer_ref_id}=    Remove String    ${user_id}    "
    Log To Console    ${Customer_ref_id}
    Go To     ${URL}
    [Return]    ${Customer_ref_id}

Wait For Ajax Load Total Discount On Cart Light Box
#    Wait Until Element Is Visible
    ${element_total_discount}=    Set Variable    Jquery=.sum text-blink text-blink-active text-blink-animation
    Wait Until Page Does Not Contain    ${element_total_discount}    30s

Wait For Ajax Load Shipping Fee On Mini Cart
    ${element_shipping_fee}=    Set Variable    Jquery=.text-blink-active
    ${status_login_trueyou}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${element_shipping_fee}    5s
    Run Keyword IF    ${status_login_trueyou}   Wait Until Page Does Not Contain Element    ${element_shipping_fee}    10s

Wait For Ajax Load Point
    sleep    5s

Display Full Cart And Verify Shipping Fee For Mobile As Free
    Go To    ${ITM_MOBILE_URL}/cart
    Display Summary Shipping Price On Full Cart For Mobile As Free

Display Full Cart And Verify Shipping Fee For Mobile Not Free
    Go To    ${ITM_MOBILE_URL}/cart
    Display Summary Shipping Price On Full Cart For Mobile Not Free

Go To Checkout1 Until Checkout3 And Verify Shipping Fee For Mobile
    [Arguments]       ${shipping_fee}=0
    ${shipping_fee_send}=     Run Keyword If  ${shipping_fee} == 0       Set Variable     ฟรี       ELSE      Set Variable      ${shipping_fee}
    Run Keyword If  ${shipping_fee} == 0       Display Full Cart And Verify Shipping Fee For Mobile As Free       ELSE      Display Full Cart And Verify Shipping Fee For Mobile Not Free
    Go To    ${ITM_MOBILE_URL}/checkout/step1
    Checkout 1 Mobile - Input Email       ${Text_Email}
    Checkout 1 Mobile - Click Next
    Checkout 2 Mobile - Input Name     ${Text_Name}
    Checkout 2 Mobile - Input Phone    ${Text_Phone}
    Checkout 2 Mobile - Select Province
    Checkout 2 Mobile - Select District
    Checkout 2 Mobile - Select SubDistrict
    Checkout 2 Mobile - Select ZipCode
    Checkout 2 Mobile - Input Address     ${Text_Address}
    Mini Cart - Verify Shipping Fee On Mobile       ${shipping_fee_send}
    Checkout 2 Mobile - Click Next
    Sleep     10s
    Mini Cart - Verify Shipping Fee On Mobile       ${shipping_fee_send}

#Verify Shipping fee Mini Cart And Cart Light Box
#    [Arguments]       ${shipping_fee_send}
#    Mini Cart - Verify Shipping Fee      ${shipping_fee_send}
#    Click Element      id=btn-edit-cart
#    Wait Until Element Is Visible       jquery=.item-name     30
#    CartLightBox - Verify Shipping Fee       ${shipping_fee_send}
#    Reload Page

Verify Shipping fee Mini Cart And Cart Light Box
    [Arguments]       ${shipping_fee_send}
    Mini Cart - Verify Shipping Fee      ${shipping_fee_send}
    Click Element      id=btn-edit-cart
    Wait Until Element Is Visible       jquery=.item-name     30
    CartLightBox - Verify Shipping Fee       ${shipping_fee_send}
    Reload Page
#    Wait Until Ajax Loading Is Not Visible
#    Click Element At Coordinates    jquery=.modal-open    1    1

Point - Verify Ref Transaction Data In DB
    [Arguments]    ${user_id}    ${order_id}    ${has_data}=1
    ${ref_transaction}=    get_ref_transaction_redeem_point    ${user_id}    ${order_id}
    Run Keyword IF    ${has_data}==1   Should Not Be Empty 	${ref_transaction}
    ...   ELSE    Should Be Equal As Strings     	${ref_transaction}    None

Point - Verify Point And Status From Return Point In DB
    [Arguments]    ${user_id}    ${order_id}    ${merchant_id}    ${partner_id}    ${point}=0    ${status}=0

    ${return_point_data}=    get_return_point    ${user_id}    ${order_id}    ${merchant_id}    ${partner_id}
    Run Keyword IF    ${point}==0   Should Be Equal As Strings 	${return_point_data}    None
    ...    ELSE    Point - Verify Point And Status    ${point}    ${status}    ${return_point_data}

Point - Verify Point And Status
    [Arguments]    ${point}    ${status}    ${return_point_data}

    ${point_verify}=     Convert To Number    ${point}    2
    ${point_verify}=     convert_float_to_float_2digit    ${point_verify}
    ${point_verify}=     Convert To String    ${point_verify}

    Should Be Equal As Strings     	${point_verify}    ${return_point_data[0]}
    Should Be Equal As Strings     	${status}    ${return_point_data[1]}

Point - Perpare Point Campaign Rate
   [Arguments]    ${inventory_id}   ${ratio}
   ${merchantID}=    Set Variable    1
   ${campaign_name}=    Set Variable    Poin-test-campaign
   ${campaign_ratio}=   Set Variable    ${ratio}
   Insert Point Campaign    ${merchantID}   ${campaign_name}    ${campaign_ratio}
   ${campaign_id}=   Get Campaign Id   ${merchantID}   ${campaign_name}    ${campaign_ratio}
   ${campaign_id}=    Convert To Number    ${campaign_id[0]}
   Insert Point Campaign Keys   ${campaign_id}    ${inventory_id}
   [Return]    ${campaign_id}

Point - Delete Point Campaign
   [Arguments]    ${campaign_id}
   Delete Point Campaign    ${campaign_id}

Point - Delete Point Campaign Key
  [Arguments]    ${campaign_id}
  Delete Point Campaign Key   ${campaign_id}