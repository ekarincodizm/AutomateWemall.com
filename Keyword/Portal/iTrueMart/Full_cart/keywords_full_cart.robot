*** Settings ***
Library           String
Resource          ${CURDIR}/web_element_full_cart.robot
Library           ${CURDIR}/../../../../Python_Library/string_library.py

*** Keywords ***
Display Full Cart
    Wait Until Element Is Visible   ${XPATH_FULL_CART.div_full_cart}   60s
    Element Should Be Visible   ${XPATH_FULL_CART.div_full_cart}

Display Full Cart Page
    Wait Until Element Is Visible    ${cart_light_box}    60s
    Location Should Contain          /cart

Full Cart Not Display
    Wait Until Element Is Not Visible    ${XPATH_FULL_CART.div_full_cart}
    Element Should Not Be Visible    ${XPATH_FULL_CART.div_full_cart}

User Click Next Process On Full Cart
	Wait Until Element Is Visible   ${XPATH_FULL_CART.btn_next}    60s
	${is_click}=   Run Keyword And Return Status   Click Element  ${XPATH_FULL_CART.btn_next}
    Run Keyword If   '${is_click}' == '${False}'   Click Element  ${XPATH_FULL_CART.btn_next}

Display Title Of Full Cart As 1 Item
    Wait Until Element Is Visible    ${XPATH_FULL_CART.div_title_no_of_items}    ${CHECKOUT_TIMEOUT}
    Sleep    2s
    Element Should Contain    ${XPATH_FULL_CART.div_title_no_of_items}    1

Display Title Of Full Cart As 2 Items
    Wait Until Element Is Visible    ${XPATH_FULL_CART.div_title_no_of_items}    ${CHECKOUT_TIMEOUT}
    Element Should Contain    ${XPATH_FULL_CART.div_title_no_of_items}    2

Display Title Of Full Cart As 3 Items
    Wait Until Element Is Visible    ${XPATH_FULL_CART.div_title_no_of_items}    ${CHECKOUT_TIMEOUT}
    Element Should Contain    ${XPATH_FULL_CART.div_title_no_of_items}    3

Total Product On Full Cart Is One Item
    Wait Until Element Is Visible    ${XPATH_FULL_CART.row_items}    ${CHECKOUT_TIMEOUT}
    ${total-products}=    Get Matching Xpath Count    ${XPATH_FULL_CART.row_items}
    Log To Console    total-products=${total-products}
    Should Be Equal As Integers    ${total-products}    1

Total Product On Full Cart Is Two Item
    Wait Until Element Is Visible    ${XPATH_FULL_CART.row_items}    ${CHECKOUT_TIMEOUT}
    ${total-products}=    Get Matching XPath Count    ${XPATH_FULL_CART.row_items}
    Should Be Equal As Integers    ${total-products}    2

Display Product Name Of First Product On Full Cart
    # ${product-name}=    Get Text    ${XPATH_FULL_CART.lbl_first_product_name}
    # Element Should Contain    ${XPATH_FULL_CART.lbl_first_product_name}    Asus Zenfone 5.
    Wait Until Element Is Visible    ${XPATH_FULL_CART.lbl_first_product_name}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${XPATH_FULL_CART.lbl_first_product_name}

Display Normal Price Of First Product On Full Cart As Zero
    Wait Until Element Is Visible    ${XPATH_FULL_CART.lbl_first_normal_price}    ${CHECKOUT_TIMEOUT}
    ${normal-price}=    Get Text    ${XPATH_FULL_CART.lbl_first_normal_price}
    ${normal-price}=    Convert String To Float    ${normal-price}
    Should Be Equal As Numbers    ${normal-price}    0.0
    ${dict}=    Set Variable    ${TEST_VAR}
    Set To Dictionary    ${dict}    first-normal-price=${normal-price}
    Set Test Variable    ${TEST_VAR}    ${dict}

Display Normal Price Of First Product On Full Cart Not Zero
    Wait Until Element Is Visible    ${XPATH_FULL_CART.lbl_first_normal_price}    ${CHECKOUT_TIMEOUT}
    ${normal-price}=    Get Text    ${XPATH_FULL_CART.lbl_first_normal_price}
    ${normal-price}=    Convert String To Float    ${normal-price}
    Should Not Be Equal As Numbers    ${normal-price}    0.0
    ${dict}=    Set Variable    ${TEST_VAR}
    Set To Dictionary    ${dict}    first-normal-price=${normal-price}
    Set Test Variable    ${TEST_VAR}    ${dict}

Display Special Price Of First Product On Full Cart As Zero
    Wait Until Element Is Visible    ${XPATH_FULL_CART.lbl_first_special_price}    ${CHECKOUT_TIMEOUT}
    ${special-price}=    Get Text    ${XPATH_FULL_CART.lbl_first_special_price}
    ${special-price}=    Convert String To Float    ${special-price}
    Should Be Equal As Numbers    ${special-price}    0.0
    ${dict}=    Set Variable    ${TEST_VAR}
    Set To Dictionary    ${dict}    first-special-price=${special-price}
    Set Test Variable    ${TEST_VAR}    ${dict}

Display Special Price Of First Product On Full Cart Not Zero
    Wait Until Element Is Visible    ${XPATH_FULL_CART.lbl_first_special_price}    ${CHECKOUT_TIMEOUT}
    ${special-price}=    Get Text    ${XPATH_FULL_CART.lbl_first_special_price}
    Run Keyword If    '${LOG_LEVEL}' == 'debug'    Log To Console    special-price=${special-price}
    ${special-price}=    Convert String To Float    ${special-price}
    Run Keyword If    '${LOG_LEVEL}' == 'debug'    Log To Console    special-price=${special-price}
    Should Not Be Equal As Numbers    ${special-price}    0.0
    ${dict}=    Set Variable    ${TEST_VAR}
    Set To Dictionary    ${dict}    first-special-price=${special-price}
    Set Test Variable    ${TEST_VAR}    ${dict}

Do Not Display Special Price Of First Product On Full Cart
    Element Should Not Be Visible    ${XPATH_FULL_CART.lbl_first_special_price}

Do Not Display Claim Price Of First Product On Full Cart
    Element Should Not Be Visible    ${XPATH_FULL_CART.lbl_first_claim_price}

Get Bundle Price On Full Cart
    Wait Until Element Is Visible    ${XPATH_FULL_CART.lbl_bundle_price}    ${CHECKOUT_TIMEOUT}
    ${price}=    Get Text    ${XPATH_FULL_CART.lbl_bundle_price}
    ${price}=    Convert String To Float    ${price}
    [Return]    ${price}

Get Price On Full Cart
    Wait Until Element Is Visible    ${XPATH_FULL_CART.lbl_summary_normal_price}    ${CHECKOUT_TIMEOUT}
    ${normal-price}=    Get Text    ${XPATH_FULL_CART.lbl_summary_normal_price}
    Log To Console    normal-price=${normal-price}
    ${normal-price}=    Convert String To Float    ${normal-price}
    Wait Until Element Is Visible    ${XPATH_FULL_CART.lbl_summary_discount_price}    ${CHECKOUT_TIMEOUT}
    ${discount-price}=    Get Text    ${XPATH_FULL_CART.lbl_summary_discount_price}
    ${discount-price}=    Replace String    ${discount-price}    -    ${EMPTY}
    ${discount-price}=    Convert String To Float    ${discount-price}
    Wait Until Element Is Visible    ${XPATH_FULL_CART.lbl_summary_sub_total_price}    20s
    ${sub-total-price}=    Get Text    ${XPATH_FULL_CART.lbl_summary_sub_total_price}
    ${sub-total-price}=    Py Remove Whitespace    ${sub-total-price}
    ${sub-total-price}=    Replace String    ${sub-total-price}    (รวมภาษีมูลค่าเพิ่ม)    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    <small>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    </small>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    <br>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    \n    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    \r    ${EMPTY}
    ${sub-total-price}=    Convert String To Float    ${sub-total-price}
    Wait Until Element Is Visible    ${XPATH_FULL_CART.lbl_summary_shipping_price}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${XPATH_FULL_CART.lbl_summary_shipping_price}
    ${shipping-price}=    Get Text    ${XPATH_FULL_CART.lbl_summary_shipping_price}
    ${shipping-price}=    Run Keyword If    '${shipping-price}' != 'ฟรี'    Convert String To Float    ${shipping-price}
    ...    ELSE    Set Variable    ${shipping-price}
    ${dict}=    Set Variable    ${TEST_VAR}
    Set To Dictionary    ${dict}    summary-normal-price=${normal-price}
    Set To Dictionary    ${dict}    summary-discount-price=${discount-price}
    Set To Dictionary    ${dict}    summary-sub-total-price=${sub-total-price}
    Set To Dictionary    ${dict}    summary-shipping-price=${shipping-price}
    Set Test Variable    ${TEST_VAR}    ${dict}

Display Sub Total Price Of First Product On Full Cart As Zero
    Wait Until Element Is Visible    ${XPATH_FULL_CART.lbl_first_sub_total_price}    ${CHECKOUT_TIMEOUT}
    ${sub-total-price}=    Get Text    ${XPATH_FULL_CART.lbl_first_sub_total_price}
    ${sub-total-price}=    Convert String To Float    ${sub-total-price}
    Should Be Equal As Numbers    ${sub-total-price}    0.0
    ${dict}=    Set Variable    ${TEST_VAR}
    Set To Dictionary    ${dict}    first-sub-total-price=${sub-total-price}
    Set Test Variable    ${TEST_VAR}    ${dict}

Display Sub Total Price Of First Product On Full Cart Not Zero
    Wait Until Element Is Visible    ${XPATH_FULL_CART.lbl_first_sub_total_price}    ${CHECKOUT_TIMEOUT}
    ${sub-total-price}=    Get Text    ${XPATH_FULL_CART.lbl_first_sub_total_price}
    Log To console    sub-total-price=${sub-total-price}
    ${sub-total-price}=    Convert String To Float    ${sub-total-price}
    Log To console    after-convert-sub-total-price=${sub-total-price}
    Should Not Be Equal As Numbers    ${sub-total-price}    0.0
    ${dict}=    Set Variable    ${TEST_VAR}
    Set To Dictionary    ${dict}    first-sub-total-price=${sub-total-price}
    Set Test Variable    ${TEST_VAR}    ${dict}

Display Link Remove Item Of First Product On Full Cart
    Wait Until Element Is Visible    ${XPATH_FULL_CART.lnk_first_remove_item}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${XPATH_FULL_CART.lnk_first_remove_item}
    ${link-remove-item}=    Get Text    ${XPATH_FULL_CART.lnk_first_remove_item}
    Element Should Contain    ${XPATH_FULL_CART.lnk_first_remove_item}    ${XPATH_FULL_CART.lnk_first_remove_item_text}

Display Summary Normal Price On Full Cart As Zero
    Wait Until Element Is Visible    ${XPATH_FULL_CART.lbl_summary_normal_price}    ${CHECKOUT_TIMEOUT}
    ${normal-price}=    Get Text    ${XPATH_FULL_CART.lbl_summary_normal_price}
    Log To Console    normal-price=${normal-price}
    ${normal-price}=    Convert String To Float    ${normal-price}
    Should Be Equal As Numbers    ${normal-price}    0.0
    ${dict}=    Set Variable    ${TEST_VAR}
    Set To Dictionary    ${dict}    summary-normal-price=${normal-price}
    Set Test Variable    ${TEST_VAR}    ${dict}

Display Summary Normal Price On Full Cart Not Zero
    Wait Until Element Is Visible    ${XPATH_FULL_CART.lbl_summary_normal_price}    ${CHECKOUT_TIMEOUT}
    ${normal-price}=    Get Text    ${XPATH_FULL_CART.lbl_summary_normal_price}
    ${normal-price}=    Convert String To Float    ${normal-price}
    Should Not Be Equal As Numbers    ${normal-price}    0.0
    ${dict}=    Set Variable    ${TEST_VAR}
    Set To Dictionary    ${dict}    summary-normal-price=${normal-price}
    Set Test Variable    ${TEST_VAR}    ${dict}

Display Summary Shipping Price On Full Cart Not Free
    Wait Until Element Is Visible    ${XPATH_FULL_CART.lbl_summary_shipping_price_fullcart}    ${CHECKOUT_TIMEOUT}
    Should Not Be Equal As Strings    ${XPATH_FULL_CART.lbl_summary_shipping_price_fullcart}    ฟรี

Display Summary Shipping Price On Full Cart As Free
    Wait Until Element Is Visible    ${XPATH_FULL_CART.lbl_summary_shipping_price_fullcart}    ${CHECKOUT_TIMEOUT}
    Element Should Contain    ${XPATH_FULL_CART.lbl_summary_shipping_price_fullcart}    ฟรี

Display Summary Shipping Price On Full Cart For Mobile Not Free
    Wait Until Element Is Visible    ${XPATH_FULL_CART_HAVE_SHIPPING_PRICE_FOR_MOBILE}    ${CHECKOUT_TIMEOUT}
    Should Not Be Equal As Strings    ${XPATH_FULL_CART_HAVE_SHIPPING_PRICE_FOR_MOBILE}    ฟรี

Display Summary Shipping Price On Full Cart For Mobile As Free
    Wait Until Element Is Visible    ${XPATH_FULL_CART_SHIPPING_PRICE_FOR_MOBILE}    ${CHECKOUT_TIMEOUT}
    Element Should Contain    ${XPATH_FULL_CART_SHIPPING_PRICE_FOR_MOBILE}    ฟรี

Display Summary Shipping Price On Full Cart As 50 Baht
    Wait Until Element Is Visible    ${XPATH_FULL_CART.lbl_summary_shipping_price_fullcart}    ${CHECKOUT_TIMEOUT}
    ${shipping-price}=    Get Text    ${XPATH_FULL_CART.lbl_summary_shipping_price_fullcart}
    #${shipping-price}=    Convert String To Float    ${shipping-price}
    Should Be Equal As Numbers    ${shipping-price}    50.0
    ${dict}=    Set Variable    ${TEST_VAR}
    Set To Dictionary    ${dict}    summary-shipping-price=${shipping-price}
    Set Test Variable    ${TEST_VAR}    ${dict}

Display Summary Shipping Price On Full Cart As
    [Arguments]    ${exp_shipping_fee}
    Wait Until Element Is Visible    ${XPATH_FULL_CART.lbl_summary_shipping_price_fullcart}    ${CHECKOUT_TIMEOUT}
    ${shipping-price}=    Get Text    ${XPATH_FULL_CART.lbl_summary_shipping_price_fullcart}
    Should Be Equal As Numbers    ${shipping-price}    ${exp_shipping_fee}

Display Summary Discount Price On Full Cart As Zero
    Wait Until Element Is Visible    ${XPATH_FULL_CART.lbl_summary_discount_price}    ${CHECKOUT_TIMEOUT}
    ${discount-price}=    Get Text    ${XPATH_FULL_CART.lbl_summary_discount_price}
    ${discount-price}=    Convert String To Float    ${discount-price}
    Should Be Equal As Numbers    ${discount-price}    0.0
    ${dict}=    Set Variable    ${TEST_VAR}
    Set To Dictionary    ${dict}    summary-discount-price=${discount-price}
    Set Test Variable    ${TEST_VAR}    ${dict}

Display Summary Discount Price On Full Cart Not Zero
    Wait Until Element Is Visible    ${XPATH_FULL_CART.lbl_summary_discount_price}    ${CHECKOUT_TIMEOUT}
    ${discount-price}=    Get Text    ${XPATH_FULL_CART.lbl_summary_discount_price}
    ${discount-price}=    Convert String To Float    ${discount-price}
    Should Not Be Equal As Numbers    ${discount-price}    0.0
    ${dict}=    Set Variable    ${TEST_VAR}
    Set To Dictionary    ${dict}    summary-discount-price=${discount-price}
    Set Test Variable    ${TEST_VAR}    ${dict}

Display Summary Discount Price On Full Cart As
    [Arguments]    ${exp_discount}
    Wait Until Element Is Visible    ${XPATH_FULL_CART.lbl_summary_discount_price}    ${CHECKOUT_TIMEOUT}
    ${discount-price}=    Get Text    ${XPATH_FULL_CART.lbl_summary_discount_price}
    ${discount-price}=    Convert String To Float    ${discount-price}
    ${exp_discount}=    Convert String To Float    ${exp_discount}
    Should Not Be Equal As Numbers    ${discount-price}    ${exp_discount}

Display Summary Sub Total Price On Full Cart As Zero
    Wait Until Element Is Visible    ${XPATH_FULL_CART.lbl_summary_sub_total_price}    20s
    ${sub-total-price}=    Get Text    ${XPATH_FULL_CART.lbl_summary_sub_total_price}
    ${sub-total-price}=    Py Remove Whitespace    ${sub-total-price}
    ${sub-total-price}=    Replace String    ${sub-total-price}    (รวมภาษีมูลค่าเพิ่ม)    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    <small>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    </small>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    <br>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    \n    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    \r    ${EMPTY}
    ${sub-total-price}=    Run Keyword If    '${sub-total-price}' == '0.00'    Convert String To Float    ${sub-total-price}
    ...    ELSE    Set Variable    ${sub-total-price}
    Should Be Equal As Numbers    ${sub-total-price}    0.0
    ${dict}=    Set Variable    ${TEST_VAR}
    Set To Dictionary    ${dict}    summary-sub-total-price=${sub-total-price}
    Set Test Variable    ${TEST_VAR}    ${dict}

Display Summary Sub Total Price On Full Cart Not Zero
    Wait Until Element Is Visible    ${XPATH_FULL_CART.lbl_summary_sub_total_price}    ${CHECKOUT_TIMEOUT}
    ${sub-total-price}=    Get Text    ${XPATH_FULL_CART.lbl_summary_sub_total_price}
    ${sub-total-price}=    Py Remove Whitespace    ${sub-total-price}
    ${sub-total-price}=    Replace String    ${sub-total-price}    (รวมภาษีมูลค่าเพิ่ม)    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    <small>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    </small>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    <br>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    \n    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    \r    ${EMPTY}
    ${sub-total-price}=    Convert String To Float    ${sub-total-price}
    Should Not Be Equal As Numbers    ${sub-total-price}    0.0
    ${dict}=    Set Variable    ${TEST_VAR}
    Set To Dictionary    ${dict}    summary-sub-total-price=${sub-total-price}
    Set Test Variable    ${TEST_VAR}    ${dict}

Display Summary Sub Total Price On Full Cart As 50 Baht
    Wait Until Element Is Visible    ${XPATH_FULL_CART.lbl_summary_sub_total_price}    ${CHECKOUT_TIMEOUT}
    ${sub-total-price}=    Get Text    ${XPATH_FULL_CART.lbl_summary_sub_total_price}
    ${sub-total-price}=    Py Remove Whitespace    ${sub-total-price}
    ${sub-total-price}=    Replace String    ${sub-total-price}    (รวมภาษีมูลค่าเพิ่ม)    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    <small>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    </small>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    <br>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    \n    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    \r    ${EMPTY}
    ${sub-total-price}=    Convert String To Float    ${sub-total-price}
    Should Be Equal As Numbers    ${sub-total-price}    50.0
    ${dict}=    Set Variable    ${TEST_VAR}
    Set To Dictionary    ${dict}    summary-sub-total-price=${sub-total-price}
    Set Test Variable    ${TEST_VAR}    ${dict}

Display Summary Sub Total Price On Full Cart As
    [Arguments]    ${exp_price}
    Wait Until Element Is Visible    ${XPATH_FULL_CART.lbl_summary_sub_total_price}    ${CHECKOUT_TIMEOUT}
    ${sub-total-price}=    Get Text    ${XPATH_FULL_CART.lbl_summary_sub_total_price}
    ${sub-total-price}=    Py Remove Whitespace    ${sub-total-price}
    ${sub-total-price}=    Replace String    ${sub-total-price}    (รวมภาษีมูลค่าเพิ่ม)    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    <small>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    </small>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    <br>    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    \n    ${EMPTY}
    ${sub-total-price}=    Replace String    ${sub-total-price}    \r    ${EMPTY}
    ${sub-total-price}=    Convert String To Float    ${sub-total-price}
    ${exp_price}=    Convert String To Float    ${exp_price}
    Should Be Equal As Numbers    ${sub-total-price}    ${exp_price}

Display Correctly Summary Sub Total On Full Cart
    ${normal-price}=    Get From Dictionary    ${TEST_VAR}    summary-normal-price
    ${discount-price}=    Get From Dictionary    ${TEST_VAR}    summary-discount-price
    ${sub-total-price}=    Get From Dictionary    ${TEST_VAR}    summary-sub-total-price
    ${shipping-price}=    Get From Dictionary    ${TEST_VAR}    summary-shipping-price
    ${summary}=    Evaluate    ${normal-price} - ${discount-price}
    ${summary}=    Run Keyword If    '${shipping-price}' != 'ฟรี'    Evaluate    ${summary} + ${shipping-price}
    ...    ELSE    Set Variable    ${summary}
    Log To console    summary=${summary}
    Should Be Equal As Numbers    ${summary}    ${sub-total-price}

Display Quantity Of First Product On Full Cart As 1
    Wait Until Element Is Visible    ${XPATH_FULL_CART.cbo_first_quantity}    ${CHECKOUT_TIMEOUT}
    ${quantity}=    Get Matching XPath Count    ${XPATH_FULL_CART.cbo_first_quantity}/option[@value="1" and @selected="selected"]
    Log To Console    quantity=${quantity}
    Should Be Equal As Integers    ${quantity}    1

User Cannot Change Quantity More Than 1 Item
    Wait Until Element Is Visible    ${XPATH_FULL_CART.cbo_first_quantity}    ${CHECKOUT_TIMEOUT}
    ${quantity}=    Get Matching Xpath Count    ${XPATH_FULL_CART.cbo_first_quantity}
    Should Be Equal As Integers    ${quantity}    1

User Click Remove First Item
    Wait Until Element Is Visible    ${XPATH_FULL_CART.lnk_first_remove_item}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_FULL_CART.lnk_first_remove_item}
    Confirm Action
    Wait Until Ajax Loading Is Not Visible

User Click Remove Second Item
    Wait Until Element Is Visible    ${XPATH_FULL_CART.lnk_second_remove_item}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_FULL_CART.lnk_second_remove_item}
    Confirm Action
    Wait Until Ajax Loading Is Not Visible

User Click Close Button On Full Cart
    Wait Until Element Is Visible    ${XPATH_FULL_CART.lnk_close}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_FULL_CART.lnk_close}

No Items In Cart
    Wait Until Element Is Visible    ${XPATH_FULL_CART.div_no_item_in_cart_container}    ${CHECKOUT_TIMEOUT}
    Element Should Contain    ${XPATH_FULL_CART.lbl_no_item_in_cart}    ${XPATH_FULL_CART.lbl_no_item_in_cart_text}

User Accept Confirm Remove
    Confirm Action

Do Not Have Mnp Product On Full Cart
    ${count-mnp}=    Get Matching Xpath Count    ${XPATH_FULL_CART.row_first_mnp}
    Should Be Equal As Integers    ${count-mnp}    0

First Item On Full Cart Is Mnp Product
    Wait Until Element Is Visible    ${XPATH_FULL_CART.row_first_mnp}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${XPATH_FULL_CART.row_first_mnp}

First Item On Full Cart Is Not Mnp Product
    Wait Until Element Is Visible    ${XPATH_FULL_CART.row_first_no_mnp}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${XPATH_FULL_CART.row_first_no_mnp}

First Item On Full Cart Is Normal Product
    Wait Until Element Is Visible    ${XPATH_FULL_CART.row_first_normal}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${XPATH_FULL_CART.row_first_normal}

Second Item On Full Cart Is Mnp Product
    Wait Until Element Is Visible    ${XPATH_FULL_CART.row_second_mnp}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${XPATH_FULL_CART.row_second_mnp}

Second Item On Full Cart Is Not Mnp Product
    Wait Until Element Is Visible    ${XPATH_FULL_CART.row_second_no_mnp}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${XPATH_FULL_CART.row_second_no_mnp}

Second Item On Full Cart Is Normal Product
    Wait Until Element Is Visible    ${XPATH_FULL_CART.row_second_normal}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${XPATH_FULL_CART.row_second_normal}

Full Cart - Display Camp Short Description
    Wait Until Element Is Visible    ${XPATH_FULL_CART.camp_short_description}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${XPATH_FULL_CART.camp_short_description}

Full Cart - Count Camp Short Description
    [Arguments]    ${expect_qty}=1
    Wait Until Element Is Visible    ${XPATH_FULL_CART.camp_short_description}    ${CHECKOUT_TIMEOUT}
    ${count_element}=    Get Matching Xpath Count    ${XPATH_FULL_CART.camp_short_description}
    ${count_camp}=    Convert To Integer    ${count_element}
    Should Be Equal As Integers    ${count_camp}    ${expect_qty}

Full Cart - Do Not Display Product Free On Full Cart
    ${row_element}=    Replace String    ${ROW_X_TYPE}    ^^type^^    freebie
    Element Should Not Be Visible    ${row_element}

Full Cart - Do Not Display Normal Product Second Item
    ${row_element}=    Replace String    ${ROW_X_ITEM_X_TYPE}    ^^type^^    normal
    ${row_element}=    Replace String    ${row_element}    ^^position^^    2
    Element Should Not Be Visible    ${row_element}

Full Cart - Do Not Display Camp Short Description
    Element Should Not Be Visible    ${XPATH_FULL_CART.camp_short_description}

Full Cart - Select Quantity Product Normal By Inventory Id
    [Arguments]    ${inventory_id}    ${qty}
    #${element_type}=    Replace String    ${ROW_X_TYPE}    ^^type^^    normal
    #${cbo_inventory}=    Replace String    ${XPATH_FULL_CART.cbo_quantity_inventory}    ^^inventory^^    ${inventory_id}
    ${cbo_inventory}=    Replace String    jquery=.select-cart.cartbox-update-item-qty[data-inventory-id="^^inventory^^"]    ^^inventory^^    ${inventory_id}
    #Wait Until Element Is Visible    ${element_type}${cbo_inventory}    60s
    #Select From List By Value    ${element_type}${cbo_inventory}    ${qty}
    Wait Until Element Is Visible    ${cbo_inventory}    60s
    Select From List By Value    ${cbo_inventory}    ${qty}

Full Cart - Select Box Quantity Max 1
    Wait Until Element Is Visible    ${SelectBox_NormalProduct_FirstItem_Value1}    30s
    Element Should Be Visible    ${SelectBox_NormalProduct_FirstItem_Value1}
    Element Should Not Be Visible    ${SelectBox_NormalProduct_FirstItem_Value2}
    Element Should Not Be Visible    ${SelectBox_NormalProduct_FirstItem_Value3}
    Element Should Not Be Visible    ${SelectBox_NormalProduct_FirstItem_Value4}
    Element Should Not Be Visible    ${SelectBox_NormalProduct_FirstItem_Value5}

Full Cart - Display Normal Product First Item x Qty
    [Arguments]    ${quantity}=1
    ${row_element}=    Replace String    ${ROW_X_ITEM_X_TYPE}    ^^type^^    normal
    ${row_element}=    Replace String    ${row_element}    ^^position^^    1
    ${qty_element}=    Convert To String    ${XPATH_FULL_CART.cbo_quantity}
    ${val_qty_element}=    Convert To String    option[@value="${quantity}" and @selected="selected"]
    Wait Until Element Is Visible    ${row_element}${qty_element}    ${CHECKOUT_TIMEOUT}
    Log To Console    \nrow_element-qty_element-/val_qty_element = ${row_element}${qty_element}/${val_qty_element}\n
    Element Should Be Visible    ${row_element}${qty_element}/${val_qty_element}

Full Cart - Display Normal Product Second Item x Qty
    [Arguments]    ${quantity}=1
    ${row_element}=    Replace String    ${ROW_X_ITEM_X_TYPE}    ^^type^^    normal
    ${row_element}=    Replace String    ${row_element}    ^^position^^    2
    ${qty_element}=    Convert To String    ${XPATH_FULL_CART.cbo_quantity}
    ${val_qty_element}=    Convert To String    option[@value="${quantity}" and @selected="selected"]
    Wait Until Element Is Visible    ${row_element}${qty_element}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${row_element}${qty_element}/${val_qty_element}

Full Cart - Display Normal Product Third Item x Qty
    [Arguments]    ${quantity}=1
    ${row_element}=    Replace String    ${ROW_X_ITEM_X_TYPE}    ^^type^^    normal
    ${row_element}=    Replace String    ${row_element}    ^^position^^    3
    ${qty_element}=    Convert To String    ${XPATH_FULL_CART.cbo_quantity}
    ${val_qty_element}=    Convert To String    option[@value="${quantity}" and @selected="selected"]
    Wait Until Element Is Visible    ${row_element}${qty_element}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${row_element}${qty_element}/${val_qty_element}

Full Cart - Display Free Product First Item x Qty
    [Arguments]    ${quantity}=1
    ${row_element}=    Replace String    ${ROW_X_ITEM_X_TYPE}    ^^type^^    freebie
    ${row_element}=    Replace String    ${row_element}    ^^position^^    1
    ${qty_element}=    Convert To String    ${XPATH_FULL_CART.lbl_quantity}
    ${val_qty_element}=    Convert To String    *[@value="${quantity}"]
    Wait Until Element Is Visible    ${row_element}${qty_element}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${row_element}${qty_element}/${val_qty_element}

Full Cart - Display Free Product Second Item x Qty
    [Arguments]    ${quantity}=1
    ${row_element}=    Replace String    ${ROW_X_ITEM_X_TYPE}    ^^type^^    freebie
    ${row_element}=    Replace String    ${row_element}    ^^position^^    2
    ${qty_element}=    Convert To String    ${XPATH_FULL_CART.lbl_quantity}
    ${val_qty_element}=    Convert To String    *[@value="${quantity}"]
    Wait Until Element Is Visible    ${row_element}${qty_element}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${row_element}${qty_element}/${val_qty_element}

Full Cart - Display Bundle Product First Item x Qty
    [Arguments]    ${quantity}=1
    ${row_element}=    Replace String    ${ROW_X_ITEM_X_TYPE}    ^^type^^    bundle
    ${row_element}=    Replace String    ${row_element}    ^^position^^    1
    ${qty_element}=    Convert To String    ${XPATH_FULL_CART.cbo_quantity}
    ${val_qty_element}=    Convert To String    option[@value="${quantity}" and @selected="selected"]
    Wait Until Element Is Visible    ${row_element}${qty_element}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${row_element}${qty_element}/${val_qty_element}

Full Cart - Display Sim Product First Item x Qty
    [Arguments]    ${quantity}=1
    ${row_element}=    Replace String    ${ROW_X_ITEM_X_TYPE}    ^^type^^    sim
    ${row_element}=    Replace String    ${row_element}    ^^position^^    1
    ${qty_element}=    Convert To String    ${XPATH_FULL_CART.cbo_quantity}
    ${val_qty_element}=    Convert To String    option[@value="${quantity}" and @selected="selected"]
    Wait Until Element Is Visible    ${row_element}${qty_element}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${row_element}${qty_element}/${val_qty_element}

Full Cart - Display Normal Product First Item 1 Qty
    Full Cart - Display Normal Product First Item x Qty    1

Full Cart - Display Normal Product First Item 2 Qty
    Full Cart - Display Normal Product First Item x Qty    2

Full Cart - Display Normal Product First Item 3 Qty
    Full Cart - Display Normal Product First Item x Qty    3

Full Cart - Display Normal Product First Item 4 Qty
    Full Cart - Display Normal Product First Item x Qty    4

Full Cart - Display Normal Product First Item 5 Qty
    Full Cart - Display Normal Product First Item x Qty    5

Full Cart - Display Normal Product First Item 6 Qty
    Full Cart - Display Normal Product First Item x Qty    6

Full Cart - Display Normal Product Second Item 1 Qty
    Full Cart - Display Normal Product Second Item x Qty    1

Full Cart - Display Normal Product Second Item 2 Qty
    Full Cart - Display Normal Product Second Item x Qty    2

Full Cart - Display Normal Product Second Item 3 Qty
    Full Cart - Display Normal Product Second Item x Qty    3

Full Cart - Display Normal Product Second Item 5 Qty
    Full Cart - Display Normal Product Second Item x Qty    5

Full Cart - Display Normal Product Third Item 1 Qty
    Full Cart - Display Normal Product Third Item x Qty    1

Full Cart - Display Normal Product Third Item 2 Qty
    Full Cart - Display Normal Product Third Item x Qty    2

Full Cart - Display Normal Product Third Item 3 Qty
    Full Cart - Display Normal Product Third Item x Qty    3

Full Cart - Display Normal Product Third Item 4 Qty
    Full Cart - Display Normal Product Third Item x Qty    4

Full Cart - Display Normal Product Third Item 5 Qty
    Full Cart - Display Normal Product Third Item x Qty    5

Full Cart - Display Free Product First Item 1 Qty
    Full Cart - Display Free Product First Item x Qty    1

Full Cart - Display Free Product First Item 2 Qty
    Full Cart - Display Free Product First Item x Qty    2

Full Cart - Display Free Product First Item 3 Qty
    Full Cart - Display Free Product First Item x Qty    3

Full Cart - Display Free Product First Item 4 Qty
    Full Cart - Display Free Product First Item x Qty    4

Full Cart - Display Free Product Second Item 1 Qty
    Full Cart - Display Free Product Second Item x Qty    1

Full Cart - Display Free Product Second Item 2 Qty
    Full Cart - Display Free Product Second Item x Qty    2

Full Cart - Display Bundle Product First Item 1 Qty
    Full Cart - Display Bundle Product First Item x Qty    1

Full Cart - Display Sim Product First Item 1 Qty
    Full Cart - Display Sim Product First Item x Qty    1

Full Cart - Display Total Quantity Items Of Full Cart As Expect Qty
    [Arguments]    ${expect_qty}=1
    Sleep    5s
    Wait Until Element Is Visible    ${cart_light_box_popup}    60s
    Wait Until Element Is Visible    ${CartLightBox_ItemQty}    60s
    ${amount_txt}=    Get Text    ${CartLightBox_ItemQty}
    Log To Console    ${CartLightBox_ItemQty}
    Log To Console    ${amount_txt}
    ${cart_amount}=    Convert To Integer    ${amount_txt}
    Should Be Equal As Integers    ${cart_amount}    ${expect_qty}

Verify Cart Light Box is Not Empty
    Wait Until Element Is Visible    ${cart_light_box}    30s
    Wait Until Page Does Not Contain Element    ${cart_light_box}:contains("กำลังโหลดรายการ...")    30s
    Wait Until Element Is Visible    ${product_in_cart_list}    30s

Verify Cart Light Box is Empty
    Wait Until Element Is Visible    ${cart_light_box}    15s
    Wait Until Page Does Not Contain Element    ${cart_light_box}:contains("กำลังโหลดรายการ...")    30s
    # Wait Until Element Is Not Visible    ${product_in_cart_list}    15s
    Page Should Not Contain Element    ${product_in_cart_list}    15s
    ${actual_text}    Get Text    ${cart_light_box}
    Should Be Equal As Strings    ไม่พบสินค้าในตะกร้า    ${actual_text}

Get Item Count on Full Cart To Remove
    ${row}=    Get Matching XPath Count    //a[contains(text(), "ลบรายการ")]
    Return From Keyword    ${row}

User Remove All Item in Full Cart
    Go To    ${ITM_URL}/cart
    Sleep    10
    ${row}=    Get Item Count on Full Cart To Remove
    : FOR    ${index}    IN RANGE    ${row}
    \    ${div_index}    Evaluate    ${index} +2
    \    Wait Until Ajax Loading Is Not Visible
    \    User Click Remove First Item

Full Cart - Cannot Add Duplicate Product Wow
    Wait Until Ajax Loading Is Not Visible
    Sleep    3s
    Page Should Contain    ${MSG_FULL_CART.one_piece_one_order}
