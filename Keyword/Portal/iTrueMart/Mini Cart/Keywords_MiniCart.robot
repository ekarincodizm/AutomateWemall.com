*** Settings ***
Library           Selenium2Library
Library           String
Resource          ../../../../Resource/Env_config.robot
Resource          ../../../Common/Keywords_Common.robot
Resource          ${CURDIR}/WebElement_MiniCart.robot
Resource          ${CURDIR}/../../../../Keyword/Features/Create_Order/Create_order.txt

*** Variables ***

*** Keywords ***
Assert Freebie amount
    [Arguments]    ${expect_freebie_TitleAndAmount}
    sleep    5
    Wait Until Element Is Visible    ${MiniCart_FreebieCartTitleAndAmount}
    ${Actual_MiniCart_FreebieCartTitleAndAmount}    Get Text    ${MiniCart_FreebieCartTitleAndAmount}
    Should Be Equal    ${expect_freebie_TitleAndAmount}    ${Actual_MiniCart_FreebieCartTitleAndAmount}

Assert Freebie Item
    [Arguments]    ${freebie_name}    ${freebie_no}
    ${freebie_item_element}    Replace String    ${MiniCart_FreebieItem}    REPLACE_ME    ${freebie_name}
    Wait Until Element Is Visible    ${freebie_item_element}    60
    Should Not Be Empty    Get Webelement    ${freebie_item_element}
    ${price}    Get Text    ${freebie_item_element}//p[2]
    ${no}    Get Text    ${freebie_item_element}//p[1]/span
    Should Contain    ${price}    0.00
    Should Contain    ${no}    ${freebie_no}

Assert total cart item
    [Arguments]    ${Expect_MiniCart_Qualtity}
    Wait Until Element Is Visible    ${MiniCart_Qualtity}
    ${Actual_MiniCart_Qualtity}    Get Text    ${MiniCart_Qualtity}
    Should Be Equal    ${Expect_MiniCart_Qualtity}    ${Actual_MiniCart_Qualtity}

Assert Freebie Item list
    [Arguments]    ${Expect_ItemList}
    ${length}=    Evaluate    len(${Expect_ItemList})
    : FOR    ${INDEX}    IN RANGE    0    ${length}
    \    ${expect_values}    Get From List    ${Expect_ItemList}    ${INDEX}
    \    Comment    ${element_menu}    Replace String    ${lvl1_menu}    REPLACE_ME    ${expect}
    \    ${Actual_FreebieItems}    Get Webelements    ${MiniCart_FreebieItemList}
    \    ${freebie_item_element}    Get From List    ${Actual_FreebieItems}    ${INDEX}
    \    ${actual}    Get Text    ${freebie_item_element}    #class='cart-box-name'
    \    Comment    ${price}    Get Text    Get Webelement    ${freebie_item_element}    ${freebie_item_element}//*[@class='cart-box-price']
    \    Comment    ${no}    Get Text    Get Webelement    ${freebie_item_element}    ${freebie_item_element}//*[@class='cart-box-no']
    \    Comment    ${price2}    Get Text    Get Webelement    ${freebie_item_element}    ${freebie_item_element}//*[@class='cart-box-price2']
    \    ${expect_name}    Get From List    ${expect_values}    0
    \    Should Contain    ${actual}    ${expect_name}
    \    Should Contain    ${actual}    0.00
    \    ${expect_price}    Get From List    ${expect_values}    1
    \    Should Contain    ${actual}    ${expect_price}
    \    Comment    Should Contain    ${actual}    ส่วนลด 100 %
    \    ${expect_no}    Get From List    ${expect_values}    2
    \    Should Contain    ${actual}    ${expect_no}

Display Normal Price On Mini Cart As Zero
    ${total-price}=    Get Price From Mini Cart
    Should Be Equal As Numbers    ${total-price}    0.00

Display Normal Price On Mini Cart As
    [Arguments]   ${expect-price}
    ${total-price}=    Get Price From Mini Cart
    Should Be Equal As Numbers    ${total-price}    ${expect-price}

Display Discount Price On Mini Cart As Zero
    ${discount-price}=    Get Discount Price From Mini Cart
    Should Be Equal As Numbers    ${discount-price}    0.0

Display Shipping Price On Mini Cart Equal As Free
    ${shipping-price}=    Get Shipping Price From Mini Cart
    Should Be Equal As Numbers    ${shipping-price}    ฟรี

Display Sub Total Price On Mini Cart Equal As Zero
    ${sub-total-price}=    Get Sub Total Price From Mini Cart
    Should Be Equal As Numbers    ${sub-total-price}    0.00

Display Coupon On Mini Cart
    Wait Until Element Is Visible    ${XPATH_MINI_CART.btn_remove_coupon}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${XPATH_MINI_CART.btn_remove_coupon}

Not Display Coupon On Mini Cart
    Sleep  2
    Wait Until Element Is Not Visible    ${XPATH_MINI_CART.btn_remove_coupon}    ${CHECKOUT_TIMEOUT}
    Element Should Not Be Visible    ${XPATH_MINI_CART.btn_remove_coupon}

Discount Price On Mini Cart Not Display
    Element Should Not Be Visible    ${XPATH_MINI_CART.discount_price}

Get Price From Mini Cart
    Wait Until Element Is Visible    ${XPATH_MINI_CART.total_price}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${XPATH_MINI_CART.total_price}
    ${total-price}=    Get Text    ${XPATH_MINI_CART.total_price}
    ${total-price}=    Replace String    ${total-price}    ,    ${EMPTY}
    ${total-price}=    Replace String    ${total-price}    \n    ${EMPTY}
    Return From Keyword    ${total-price}

Get Discount Price From Mini Cart
    Wait Until Element Is Visible    ${XPATH_MINI_CART.discount_price}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${XPATH_MINI_CART.discount_price}
    ${discount-price}=    Get Text    ${XPATH_MINI_CART.discount_price}
    ${discount-price}=    Replace String    ${discount-price}    ,    ${EMPTY}
    ${discount-price}=    Replace String    ${discount-price}    -    ${EMPTY}
    ${discount-price}=    Replace String    ${discount-price}    \n    ${EMPTY}
    Return From Keyword    ${discount-price}

Get Shipping Price From Mini Cart
    Wait Until Element Is Visible    ${XPATH_MINI_CART.shipping_price}    ${CHECKOUT_TIMEOUT}
    ${status}    ${msg}=    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${XPATH_MINI_CART.shipping_price_free}    ${CHECKOUT_TIMEOUT}
    ${shipping-price}=    Run Keyword If    "${status}" == "FAIL"    Get Text    ${XPATH_MINI_CART.shipping_price}
    ...    ELSE    Get Text    ${XPATH_MINI_CART.shipping_price_free}
    # Element Should Be Visible    ${XPATH_MINI_CART.shipping_price}
    ${shipping-price}=    Get Text    ${XPATH_MINI_CART.shipping_price}
    ${shipping-price}=    Replace String    ${shipping-price}    ,    ${EMPTY}
    ${shipping-price}=    Replace String    ${shipping-price}    \n    ${EMPTY}
    Return From Keyword    ${shipping-price}

Get Sub Total Price From Mini Cart
    Wait Until Element Is Visible    ${XPATH_MINI_CART.sub_total_price}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${XPATH_MINI_CART.sub_total_price}
    ${sub-total}=    Get Text    ${XPATH_MINI_CART.sub_total_price}
    ${sub-total}=    Replace String    ${sub-total}    ,    ${EMPTY}
    ${sub-total}=    Replace String    ${sub-total}    <br><br>    ${EMPTY}
    ${sub-total}=    Replace String    ${sub-total}    (รวมภาษีมูลค่าเพิ่ม)    ${EMPTY}
    ${sub-total}=    Replace String    ${sub-total}    \n    ${EMPTY}
    Return From Keyword    ${sub-total}

Display Correctly Summary Sub Total On Mini Cart
    ${sub-total}=    Get Sub Total Price From Mini Cart
    ${shipping-price}=    Get Shipping Price From Mini Cart
    ${total-price}=    Get Price From Mini Cart
    ${discount-price}=    Get Discount Price From Mini Cart
    ${sub-total}=    Convert String To Float    ${sub-total}
    ${total-price}=    Convert String To Float    ${total-price}
    ${discount-price}=    Convert String To Float    ${discount-price}
    ${shipping-price}=    Run Keyword If    '${shipping-price}' != 'ฟรี'    Convert String To Float    ${shipping-price}
    ...    ELSE    Set Variable    ${shipping-price}
    ${summary}=    Evaluate    ${total-price} - ${discount-price}
    ${summary}=    Run Keyword If    '${shipping-price}' != 'ฟรี'    Evaluate    ${summary} + ${shipping-price}
    ...    ELSE    Set Variable    ${summary}
    Log To console    summary=${summary}
    Should Be Equal As Numbers    ${summary}    ${sub-total}

Display Title Of Mini Cart As 1 Item
    Wait Until Element Is Visible    ${XPATH_MINI_CART.div_title}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${XPATH_MINI_CART.div_title}
    ${title}=    Get Text    ${XPATH_MINI_CART.div_title}
    Should Contain    ${title}    1

Display Title Of Mini Cart AS 2 Items
    Wait Until Elelment Is Visible    ${XPATH_MINI_CART.div_title}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${XPATH_MINI_CART.div_title}
    ${title}=    Get Text    ${XPATH_MINI_CART.div_title}
    Should Contain    ${title}    2

Display Title Of Mini Cart AS 3 Items
    Wait Until Elelment Is Visible    ${XPATH_MINI_CART.div_title}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${XPATH_MINI_CART.div_title}
    ${title}=    Get Text    ${XPATH_MINI_CART.div_title}
    Should Contain    ${title}    3

Display Product Name Of First Product On Mini Cart As
    [Arguments]   ${expect_product_name}
    Wait Until Element Is Visible    ${XPATH_MINI_CART.lbl_first_product_name}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${XPATH_MINI_CART.lbl_first_product_name}
    ${product_name}=   Get Text   ${XPATH_MINI_CART.lbl_first_product_name}
    ${product_name}=   Remove String    ${product_name}    ${SPACE}
    ${expect_product_name}=   Remove String    ${expect_product_name}    ${SPACE}
    Log To Console  product_name=${product_name}
    Log To Console  expect_product_name=${expect_product_name}
    Should Contain   ${product_name}   ${expect_product_name}

Display Product Name Of First Product On Mini Cart
    Wait Until Element Is Visible    ${XPATH_MINI_CART.lbl_first_product_name}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${XPATH_MINI_CART.lbl_first_product_name}

Display Normal Price Of First Product On Mini Cart
    Wait Until Element Is Visible    ${XPATH_MINI_CART.lbl_first_normal_price}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${XPATH_MINI_CART.lbl_first_normal_price}

Display Quantity Of First Product On Mini Cart As 1 Item
    Wait Until Element Is Visible    ${XPATH_MINI_CART.lbl_first_quantity}    ${CHECKOUT_TIMEOUT}
    ${qty}=    Get Text    ${XPATH_MINI_CART.lbl_first_quantity}
    Should Be Equal As Strings    ${qty}    1

Display Total Price Of First Product On Mini Cart As Zero
    Wait Until Element Is Visible    ${XPATH_MINI_CART.lbl_first_total_price}    ${CHECKOUT_TIMEOUT}
    ${total-price}=    Get Text    ${XPATH_MINI_CART.lbl_first_total_price}
    ${total-price}=    Convert String To Float    ${total-price}
    Should Be Equal As Numbers    ${total-price}    0.00

Display Sub Total Price Of First Product On Mini Cart
    Wait Until Element Is Visible    ${XPATH_MINI_CART.lbl_first_sub_total_price}    ${CHECKOUT_TIMEOUT}
    Elemenet Should Be Visible    ${XPATH_MINI_CART.lbl_first_sub_total_price}

Display Summary Shipping price On Mini Cart As Free
    Wait Until Element Is Visible    ${XPATH_MINI_CART.lbl_summary_shipping_price}    ${CHECKOUT_TIMEOUT}
    ${shipping-price}=    Get Text    ${XPATH_MINI_CART.lbl_summary_shipping_price}
    Log To Console    shipping-price=${shipping-price}
    Should Be Equal As Strings    ${shipping-price}    ฟรี

Display Summary Shipping Price On Mini Cart As 50 Baht
    Wait Until Element Is Visible    ${XPATH_MINI_CART.lbl_summary_shipping_price}    ${CHECKOUT_TIMEOUT}
    ${shipping-price}=    Get Text    ${XPATH_MINI_CART.lbl_summary_shipping_price}
    ${shipping-price}=    Py Remove Whitespace    ${shipping-price}
    ${shipping-price}=    Replace String    ${shipping-price}    \n    ${EMPTY}
    ${shipping-price}=    Replace String    ${shipping-price}    \r    ${EMPTY}
    ${shipping-price}=    Convert String To Float    ${shipping-price}
    Log To Console    shipping-price after convert =${shipping-price}
    Should Be Equal As Numbers    ${shipping-price}    50.00

Display Summary Discount Price On Mini Cart As Zero
    Wait Until Element Is Visible    ${XPATH_MINI_CART.lbl_summary_discount_price}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${XPATH_MINI_CART.lbl_summary_discount_price}
    ${discount-price}=    Get Text    ${XPATH_MINI_CART.lbl_summary_discount_price}
    ${discount-price}=    Convert String To Float    ${discount-price}
    Should Be Equal As Numbers    ${discount-price}    0.00

Display Summary Discount Price On Mini Cart As 50 Baht
    Wait Until Element Is Visible    ${XPATH_MINI_CART.lbl_summary_discount_price}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${XPATH_MINI_CART.lbl_summary_discount_price}
    ${discount-price}=    Get Text    ${XPATH_MINI_CART.lbl_summary_discount_price}
    ${discount-price}=    Convert String To Float    ${discount-price}
    Should Be Equal As Numbers    ${discount-price}    50.00

Display Summary Discount Price On Mini Cart Equal As
    [Arguments]    ${cal-discount-price}
    Wait Until Element Is Visible    ${XPATH_MINI_CART.discount_price}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${XPATH_MINI_CART.discount_price}
    ${discount-price}=    Get Text    ${XPATH_MINI_CART.discount_price}
    ${discount-price}=    Replace String    ${discount-price}    ,    ${EMPTY}
    ${discount-price}=    Replace String    ${discount-price}    -    ${EMPTY}
    ${discount-price}=    Convert String To Float    ${discount-price}
    ${cal-discount-price}=    Convert String To Float    ${cal-discount-price}
    Should Be Equal As Numbers    ${discount-price}    ${cal-discount-price}

Mini Cart - Expect Sub Total Price As
    [Arguments]   ${price}
    Wait Until Element Is Visible    ${XPATH_MINI_CART.lbl_summary_sub_total_price}    ${CHECKOUT_TIMEOUT}
    ${sub-total-price}=    Get Text    ${XPATH_MINI_CART.lbl_summary_sub_total_price}
    ${sub-total-price}=    Py Remove Whitespace    ${sub-total-price}
    ${sub-total-price}=    Replace String    ${sub-total-price}    (รวมภาษีมูลค่าเพิ่ม)    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    <small>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    </small>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    <br>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    \n    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    \r    ${EMPTY}
    ${sub-total-price}=    Convert String To Float    ${sub-total-price}
    Should Be Equal As Numbers    ${sub-total-price}    ${price}

Display Summary Sub Total Price On Mini Cart As Zero
    Wait Until Element Is Visible    ${XPATH_MINI_CART.lbl_summary_sub_total_price}    ${CHECKOUT_TIMEOUT}
    ${sub-total-price}=    Get Text    ${XPATH_MINI_CART.lbl_summary_sub_total_price}
    ${sub-total-price}=    Py Remove Whitespace    ${sub-total-price}
    ${sub-total-price}=    Replace String    ${sub-total-price}    (รวมภาษีมูลค่าเพิ่ม)    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    <small>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    </small>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    <br>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    \n    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    \r    ${EMPTY}
    ${sub-total-price}=    Convert String To Float    ${sub-total-price}
    Should Be Equal As Numbers    ${sub-total-price}    0.00

Display Summary Sub Total Price On Mini Cart As 50 Baht
    Wait Until Element Is Visible    ${XPATH_MINI_CART.lbl_summary_sub_total_price}    ${CHECKOUT_TIMEOUT}
    ${sub-total-price}=    Get Text    ${XPATH_MINI_CART.lbl_summary_sub_total_price}
    ${sub-total-price}=    Py Remove Whitespace    ${sub-total-price}
    ${sub-total-price}=    Replace String    ${sub-total-price}    (รวมภาษีมูลค่าเพิ่ม)    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    <small>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    </small>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    <br>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    \n    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    \r    ${EMPTY}
    ${sub-total-price}=    Convert String To Float    ${sub-total-price}
    Should Be Equal As Numbers    ${sub-total-price}    50.00

#Get Price on Mini Cart - Checkout3
Checkout3 - mini cart - Get Sub Total Price
    ${total-price}=     Get Text     jquery=.sum.sum_total_price.cart-price
    ${total-price}=     Replace String     ${total-price}      ,     ${EMPTY}
    Return From Keyword     ${total-price}

Checkout3 - mini cart - Get Sub Total Price For Mobile
    Wait Until Element Is Visible    //*[@id="total_price"]/p    60s
    ${total-price}=     Get Text     //*[@id="total_price"]/p
    ${total-price}=     Replace String     ${total-price}      ,     ${EMPTY}
    Return From Keyword     ${total-price}

#Get Sub Total Price on Mini Cart - Checkout3
Checkout3 - mini cart - Get Total Price
    ${sub_total_price}    Set Variable    jquery=.sum.clr-3
    Wait Until Element Is Visible   ${sub_total_price}     10s
    Element Should Be Visible   ${sub_total_price}

    ${sub_total}=      Get Text     ${sub_total_price}
    ${sub_total}=      Replace String      ${sub_total}    ,     ${EMPTY}
    ${sub_total}=      Replace String      ${sub_total}    <br><br>     ${EMPTY}
    ${sub_total}=      Replace String      ${sub_total}    (รวมภาษีมูลค่าเพิ่ม)      ${EMPTY}
    ${sub_total}=      Replace String      ${sub_total}    \n      ${EMPTY}
    Return From Keyword    ${sub_total}

Checkout3 - mini cart - Get Total Price For Mobile
    ${sub_total_price}    Set Variable    //*[@id="sub_total"]/h3
    Wait Until Element Is Visible   ${sub_total_price}     10s
    Element Should Be Visible   ${sub_total_price}

    ${sub_total}=      Get Text     ${sub_total_price}
    ${sub_total}=      Replace String      ${sub_total}    ,     ${EMPTY}
#    ${sub_total}=      Replace String      ${sub_total}    <br><br>     ${EMPTY}
#    ${sub_total}=      Replace String      ${sub_total}    (รวมภาษีมูลค่าเพิ่ม)      ${EMPTY}
#    ${sub_total}=      Replace String      ${sub_total}    \n      ${EMPTY}
    Return From Keyword    ${sub_total}

#Get Discount on Mini Cart - Checkout3
Checkout3 - mini cart - Get All Discount Price
    ${total_discount}    Set Variable    jquery=.cart-price.text-blink-animation:eq(1)
    Wait Until Element Is Visible    ${total_discount}     20s
    Element Should Be Visible    ${total_discount}

    ${total_discount}=      Get Text     ${total_discount}
    ${total_discount}=      Replace String      ${total_discount}    ,     ${EMPTY}
    ${total_discount}=      Replace String      ${total_discount}    <br><br>     ${EMPTY}
    ${total_discount}=      Replace String      ${total_discount}    รวมส่วนลดเพิ่มเติมทั้งหมด      ${EMPTY}
    Return From Keyword    ${total_discount}

Checkout3 - mini cart - Get All Discount Price For Mobile
    ${total_discount}    Set Variable    //*[@id="total_discount"]/p
    Wait Until Element Is Visible    ${total_discount}     10s
    Element Should Be Visible    ${total_discount}

    ${total_discount}=      Get Text     ${total_discount}
    ${total_discount}=      Replace String      ${total_discount}    ,     ${EMPTY}
#    ${total_discount}=      Replace String      ${total_discount}    <br><br>     ${EMPTY}
#    ${total_discount}=      Replace String      ${total_discount}    รวมส่วนลดเพิ่มเติมทั้งหมด      ${EMPTY}
    Return From Keyword    ${total_discount}

Checkout3 - mini cart - Get Shipping Price
    ${xpath}=    Get Matching Xpath Count    //div[@id="minicart-container"]/div[@class="total-list"][2]/div[1]
    Wait Until Element Is Visible    //div[@id="minicart-container"]/div[@class="total-list"][2]/div[1]    11s
    ${shipping-price}=   Get Text    //div[@id="minicart-container"]/div[@class="total-list"][2]/div[1]

    ${shipping-price}=  Run Keyword If  '${shipping-price}' != 'ฟรี'  Replace String  ${shipping-price}  ,  ${EMPTY}   ELSE  Set Variable  ${shipping-price}
    Log To Console  shipping-price=${shipping-price}
    [Return]  ${shipping-price}

Checkout3 - mini cart - Get Shipping Price For Mobile
    ${xpath}=  Get Matching Xpath Count  //*[@id="total_shipping_fee"]/p
    Wait Until Element Is Visible   //*[@id="total_shipping_fee"]/p    11s
    ${shipping-price}=   Get Text    //*[@id="total_shipping_fee"]/p

    ${shipping-price}=  Run Keyword If  '${shipping-price}' != 'ฟรี'  Replace String  ${shipping-price}  ,  ${EMPTY}   ELSE  Set Variable  ${shipping-price}
    Log To Console  shipping-price=${shipping-price}
    [Return]  ${shipping-price}

Mini Cart - Verify Shipping Fee
    [arguments]    ${shipping_fee}=45.00
    Mini Cart - Verify Shipping Fee on UI    ${shipping_fee}

Mini Cart - Verify Shipping Fee On Mobile
    [arguments]    ${shipping_fee}=45.00
    Mini Cart - Verify Shipping Fee on Mobile UI     ${shipping_fee}

Mini Cart - Verify Shipping Fee is Zero
    Mini Cart - Verify Shipping Fee on UI    ฟรี

Mini Cart - Verify Shipping Fee on UI
    [arguments]    ${expected_shipping_fee}
    ${actual_shipping_fee}=    Checkout3 - mini cart - Get Shipping Price
    Should Be Equal    ${expected_shipping_fee}    ${actual_shipping_fee}

Mini Cart - Verify Shipping Fee on Mobile UI
    [arguments]    ${expected_shipping_fee}
    ${actual_shipping_fee}=    Checkout3 - mini cart - Get Shipping Price For Mobile
    Should Be Equal    ${expected_shipping_fee}    ${actual_shipping_fee}

Mini Cart - Display Normal Product First Item x Qty
    [Arguments]    ${expect_qty}=1
    #Display Quantity Of Normal First Position On Mini Cart As X Quantity
    ${element}=    Convert To String    ${MINI_CART_ROW_ITEM_NORMAL}[1]${MINI_CART_ITEM_QUANTITY}
    Wait Until Element Is Visible    ${element}    30s
    ${quantity_txt}=    Get Text    ${element}
    ${cart_quantity}=    Convert To Integer    ${quantity_txt}
    Should Be Equal As Integers    ${cart_quantity}    ${expect_qty}

Mini Cart - Display Normal Product Second Item x Qty
    [Arguments]    ${expect_qty}=1
    #Display Quantity Of Normal Second Position On Mini Cart As X Quantity
    ${element}=    Convert To String    ${MINI_CART_ROW_ITEM_NORMAL}[2]${MINI_CART_ITEM_QUANTITY}
    Wait Until Element Is Visible    ${element}    30s
    ${quantity_txt}=    Get Text    ${element}
    ${cart_quantity}=    Convert To Integer    ${quantity_txt}
    Should Be Equal As Integers    ${cart_quantity}    ${expect_qty}

Mini Cart - Display Free Product First Item x Qty
    [Arguments]    ${expect_qty}=1
    #Display Quantity Of Freebie First Position On Mini Cart As X Quantity
    ${element}=    Convert To String    ${MINI_CART_ROW_ITEM_FREEBIE}[1]${MINI_CART_ITEM_QUANTITY}
    Wait Until Element Is Visible    ${element}    30s
    ${quantity_txt}=    Get Text    ${element}
    ${cart_quantity}=    Convert To Integer    ${quantity_txt}
    Should Be Equal As Integers    ${cart_quantity}    ${expect_qty}

Mini Cart - Display Free Product Second Item x Qty
    [Arguments]    ${expect_qty}=1
    #Display Quantity Of Freebie Second Position On Mini Cart As X Quantity
    ${element}=    Convert To String    ${MINI_CART_ROW_ITEM_FREEBIE}[2]${MINI_CART_ITEM_QUANTITY}
    Wait Until Element Is Visible    ${element}    30s
    ${quantity_txt}=    Get Text    ${element}
    ${cart_quantity}=    Convert To Integer    ${quantity_txt}
    Should Be Equal As Integers    ${cart_quantity}    ${expect_qty}

Mini Cart - Display Bundle Product First Item x Qty
    [Arguments]    ${expect_qty}=1
    #Display Quantity Of Bundle First Position On Mini Cart As X Quantity
    ${element}=    Convert To String    ${MINI_CART_ROW_ITEM_BUNDLE}[1]${MINI_CART_ITEM_QUANTITY}
    Wait Until Element Is Visible    ${element}    ${CHECKOUT_TIMEOUT}
    ${quantity_txt}=    Get Text    ${element}
    ${cart_quantity}=    Convert To Integer    ${quantity_txt}
    Should Be Equal As Integers    ${cart_quantity}    ${expect_qty}

Mini Cart - Display Bundle Product Second Item x Qty
    [Arguments]    ${expect_qty}=1
    #Display Quantity Of Bundle Second Position On Mini Cart As X Quantity
    ${element}=    Convert To String    ${MINI_CART_ROW_ITEM_BUNDLE}[2]${MINI_CART_ITEM_QUANTITY}
    Wait Until Element Is Visible    ${element}    ${CHECKOUT_TIMEOUT}
    ${quantity_txt}=    Get Text    ${element}
    ${cart_quantity}=    Convert To Integer    ${quantity_txt}
    Should Be Equal As Integers    ${cart_quantity}    ${expect_qty}

Mini Cart - Display Sim Product First Item x Qty
    [Arguments]    ${expect_qty}=1
    #Display Quantity Of Sim First Position On Mini Cart As X Quantity
    ${element}=    Convert To String    ${MINI_CART_ROW_ITEM_SIM}[1]${MINI_CART_ITEM_QUANTITY}
    Wait Until Element Is Visible    ${element}    ${CHECKOUT_TIMEOUT}
    ${quantity_txt}=    Get Text    ${element}
    ${cart_quantity}=    Convert To Integer    ${quantity_txt}
    Should Be Equal As Integers    ${cart_quantity}    ${expect_qty}

Mini Cart - Display Normal Price On Mini Cart As
    [Arguments]   ${price}=None


User Click Edit Cart On Mini Cart
    Wait Until Element Is Visible    ${XPATH_MINI_CART.a_edit_cart}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_MINI_CART.a_edit_cart}

Expected Quantity First Normal Item In Mini Cart Checkout Step2
    [Arguments]    ${Expect_quantity}
    Wait Until Element Is Visible    ${xpath_quantity_frist_normal_item}    60
    ${quantity_frist_normal_item}    Get Text    ${xpath_quantity_frist_normal_item}
    Should Be Equal    ${quantity_frist_normal_item}    ${Expect_quantity}

Expected Quantity Second Normal Item In Mini Cart Checkout Step2
    [Arguments]    ${Expect_quantity}
    Wait Until Element Is Visible    ${xpath_quantity_second_normal_item}    60
    ${quantity_second_normal_item}    Get Text    ${xpath_quantity_second_normal_item}
    Should Be Equal    ${quantity_second_normal_item}    ${Expect_quantity}

Expected Quantity First Freebie Item In Mini Cart Checkout Step2
    [Arguments]    ${Expect_quantity}
    Wait Until Element Is Visible    ${xpath_quantity_frist_freebie_item}    60
    ${quantity_frist_freebie_item}    Get Text    ${xpath_quantity_frist_freebie_item}
    Should Be Equal    ${quantity_frist_freebie_item}    ${Expect_quantity}

Expected Quantity Second Freebie Item In Mini Cart Checkout Step2
    [Arguments]    ${Expect_quantity}
    Wait Until Element Is Visible    ${xpath_quantity_second_freebie_item}    60
    ${quantity_second_freebie_item}    Get Text    ${xpath_quantity_second_freebie_item}
    Should Be Equal    ${quantity_second_freebie_item}    ${Expect_quantity}

Mini Cart - Display Normal Product First Item 1 Qty
    Mini Cart - Display Normal Product First Item x Qty    1

Mini Cart - Display Normal Product First Item 2 Qty
    Mini Cart - Display Normal Product First Item x Qty    2

Mini Cart - Display Normal Product First Item 3 Qty
    Mini Cart - Display Normal Product First Item x Qty    3

Mini Cart - Display Normal Product First Item 4 Qty
    Mini Cart - Display Normal Product First Item x Qty    4

Mini Cart - Display Normal Product Second Item 2 Qty
    Mini Cart - Display Normal Product Second Item x Qty    2

Mini Cart - Display Free Product First Item 1 Qty
    Mini Cart - Display Free Product First Item x Qty    1

Mini Cart - Display Free Product First Item 2 Qty
    Mini Cart - Display Free Product First Item x Qty    2

Mini Cart - Display Free Product Second Item 3 Qty
    Mini Cart - Display Free Product Second Item x Qty    3

Mini Cart - Wait Until Point Ajax Loading Is Not Display
    [Arguments]   ${timeout}=60s
    Wait Until Element Is Not Visible   ${XPATH_MINI_CART.point_ajax_loading}   ${timeout}

Mini Cart - Expect Total Items
    [Arguments]   ${total_items}
    ${real_total_items}=   Get Matching XPath Count   ${XPATH_MINI_CART.row_items}
    Should Be Equal As Integers   ${real_total_items}   ${total_items}

Verify Total Discount on Mini Cart
    [Arguments]    ${discount}
    ${total_discount}=    Checkout3 - mini cart - Get Total Price
    Log To Console    ${total_discount}
    Should Be Equal As Numbers    ${discount}    ${total_discount}
