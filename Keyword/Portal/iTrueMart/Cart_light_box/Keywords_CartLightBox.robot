*** Settings ***
Library           String
Resource          ${CURDIR}/../..//../../Resource/Env_config.robot
Resource          ${CURDIR}/../../../Common/Keywords_Common.robot
Resource          ${CURDIR}/../Header/keywords_header.robot
Resource          WebElement_CartLightBox.robot

*** Variables ***

*** Keywords ***
Assert Freebie amount
    [Arguments]    ${expect_freebie_TitleAndAmount}
    sleep    5
    Wait Until Element Is Visible    ${CartLightBox_FreebieCartTitleAndAmount}    30
    ${Actual_freebie_TitleAndAmount}    Get Text    ${CartLightBox_FreebieCartTitleAndAmount}
    Should Be Equal    ${expect_freebie_TitleAndAmount}    ${Actual_freebie_TitleAndAmount}

Assert Freebie Item
    [Arguments]    ${freebie_name}    ${freebie_price}    ${freebie_no}
    sleep    3
    ${freebie_item_element}    Replace String    ${CartLightBox_FreebieItem}    REPLACE_ME    ${freebie_name}
    Wait Until Element Is Visible    ${freebie_item_element}    60
    Wait Until Page Does Not Contain    //*[contains(@class,'text-blink-active')]    30
    Should Not Be Empty    Get Webelement    ${freebie_item_element}
    Wait Until Element Is Visible    ${freebie_item_element}//*[@class='cart-column price']    15
    ${price}    Get Text    ${freebie_item_element}//*[@class='cart-column price']
    ${no}    Get Value    ${freebie_item_element}//*[@class='cart-freebie-no']
    ${price2}    Get Text    ${freebie_item_element}//*[@class='cart-column net-price']
    Comment    Should Contain    ${price}    -
    Should Contain    ${price}    ${freebie_price}
    Should Contain    ${price}    ส่วนลด 100 %
    Should Contain    ${no}    ${freebie_no}
    Should Contain    ${price2}    0.00

Assert Freebie short description
    [Arguments]    ${expect_description}
    ${CartLightBox_FreebieDescription_element}    Replace string in WebElelment    ${CartLightBox_FreebieDescription}    ${expect_description}
    Wait Until Element Is Visible    ${CartLightBox_FreebieDescription_element}
    ${actual_description}    Get Text    ${CartLightBox_FreebieDescription_element}
    Should Be Equal    ${actual_description}    - ${expect_description}

Assert total cart item
    [Arguments]    ${Expect_CartLightBox_Qualtity}
    Wait Until Element Is Visible    ${CartLightBox_Qualtity}
    ${Actual_CartLightBox_Qualtity}    Get Text    ${CartLightBox_Qualtity}
    Should Be Equal    ${Actual_CartLightBox_Qualtity}    ${Expect_CartLightBox_Qualtity}

Assert Freebie Item list
    [Arguments]    ${Expect_ItemList}
    ${length}=    Evaluate    len(${Expect_ItemList})
    : FOR    ${INDEX}    IN RANGE    0    ${length}
    \    ${expect_values}    Get From List    ${Expect_ItemList}    ${INDEX}
    \    Comment    ${element_menu}    Replace String    ${lvl1_menu}    REPLACE_ME    ${expect}
    \    ${Actual_FreebieItems}    Get Webelements    ${CartLightBox_FreebieItemList}
    \    ${freebie_item_element}    Get From List    ${Actual_FreebieItems}    ${INDEX}
    \    ${actual}    Get Text    ${freebie_item_element}    #class='cart-box-name'
    \    Comment    ${price}    Get Text    Get Webelement    ${freebie_item_element}    ${freebie_item_element}//*[@class='cart-column price']
    \    Comment    ${no}    Get Text    Get Webelement    ${freebie_item_element}    ${freebie_item_element}//*[@class='cart-freebie-no']
    \    Comment    ${price2}    Get Text    Get Webelement    ${freebie_item_element}    ${freebie_item_element}//*[@class='cart-column net-price']
    \    ${expect_name}    Get From List    ${expect_values}    0
    \    Should Contain    ${actual}    ${expect_name}
    \    Should Contain    ${actual}    0.00
    \    ${expect_price}    Get From List    ${expect_values}    1
    \    Should Contain    ${actual}    ${expect_price}
    \    #\    Comment    Should Contain    ${actual}    ส่วนลด 100 %
    \    ${expect_no}    Get From List    ${expect_values}    2
    \    Should Contain    ${actual}    ${expect_no}

Next to Checkout 1
    Wait Until Element Is Not Visible    ${CartLightBox_LoadingItemList}
    Wait Until Element Is Visible    ${CartLightBox_NextBtn}    20s
    Click Element    ${CartLightBox_NextBtn}
    Sleep    10s
    Wait Until Element Is Not Visible    ${LoadingImg}    20s

Delete all items in cart
    Wait Until Element Is Visible    ${Cart_detail_CartLightBoxPge}    60s
    : FOR    ${INDEX}    IN RANGE    50
    \    ${Check_visible_items}=    Run Keyword And Return Status    Element Should Be Visible    ${Delete_itemPosition1_fromCart}
    \    Run keyword if    ${Check_visible_items}    Run keywords    Click Element    ${Delete_itemPosition1_fromCart}
    \    ...    AND    Confirm Action
    \    ...    AND    Sleep    5s
    \    ...    ELSE    Exit FOR loop

Open cartLightBox from MiniCart
    Comment    Wait Until Element Is Visible    ${OpenCartLightbox_from_Carticon}    20s
    Comment    Click Element    ${OpenCartLightbox_from_Carticon}
    Go to    ${ITM_URL}/cart

Verify Cart Light Box is Not Empty
    Wait Until Element Is Visible    ${cart_light_box_popup}    30s
    Wait Until Page Does Not Contain Element    ${cart_light_box_popup}:contains("กำลังโหลดรายการ...")    30s
    Wait Until Element Is Visible    ${product_in_cart_list}    30s

Verify Cart Light Box is Empty
    Wait Until Element Is Visible    ${cart_light_box_popup}    15s
    Wait Until Page Does Not Contain Element    ${cart_light_box_popup}:contains("กำลังโหลดรายการ...")    30s
    Page Should Not Contain Element    ${product_in_cart_list}    15s
    # Wait Until Element Is Not Visible    ${product_in_cart_list}    15s
    ${actual_text}    Get Text    ${cart_light_box_popup}
    Should Be Equal As Strings    ไม่พบสินค้าในตะกร้า    ${actual_text}

Close Cart Light Box
    Wait Until Element Is Visible    ${close_cart_light_box_button}    5s
    ${result}=    Run Keyword And Return Status    Click Element    ${close_cart_light_box_button}
    Run Keyword If    ${result} == False    Sleep    3s
    Run Keyword If    ${result} == False    Click Element    ${close_cart_light_box_button}
    Wait Until Element Is Not Visible    ${cart_light_box_popup}    15s

Delete Specific Item in Cart Light Box
    [Arguments]    ${inventory_id}
    Wait Until Element Is Visible    ${cart_light_box_popup}    15s
    ${result}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${delete_link_item_in_cart}[data-inventory-id="${inventory_id}"]    5s
    Click Element    ${delete_link_item_in_cart}[data-inventory-id="${inventory_id}"]
    Sleep    3s
    Confirm Action
    Wait Until Element Is Not Visible    ${ajax_loading_widget}    20s

Check Avaliable items on Cart Light Box by Item Name
    [Arguments]    ${item_name}
    Wait Until Element Is Visible    ${Cart_detail_CartLightBoxPge}    60s
    Element should contain    ${Cart_detail_CartLightBoxPge}    ${item_name}

Items Should not Avaliable in CartLightBox
    [Arguments]    ${item_name}
    Wait Until Element Is Visible    ${Cart_detail_CartLightBoxPge}    60s
    Element Should Not Contain    ${Cart_detail_CartLightBoxPge}    ${item_name}

Cart light box - Click product link
    [Arguments]    ${p_key}
    Wait Until Element Is Visible    jquery=a[data-product-key='${p_key}'] > img    10s
    Click element    jquery=a[data-product-key='${p_key}'] > img
    sleep    3s

Cart light box - Verify prduct link
    [Arguments]    ${page_url}
    ${old_location}=    Get Location
    Select Window    url=${page_url}
    ${current_location}=    Get Location
    Should Be Equal    ${page_url}    ${current_location}
    close window
    Select Window    url=${old_location}

Cart light box - Click edit cart
    click element    ${CartLightBox_EditBtn}
    sleep    3s

CartLightBox - Select Quantity Product Normal By Inventory Id
    [Arguments]    ${inventory_id}    ${qty}
    ${cbo_inventory}=    Replace String    jquery=.select-cart.cartlightbox-update-item-qty[data-inventory-id="^^inventory^^"]    ^^inventory^^    ${inventory_id}
    Wait Until Element Is Visible    ${cbo_inventory}    60s
    Select From List By Value    ${cbo_inventory}    ${qty}

CartLightBox - Get Shipping Price
    Wait Until Element Is Visible    id=cart-popup    10s
    ${shipping-price}=    Get Text    jQuery=#cartlightbox-sumary-bottom .sum
    ${shipping-price}=    Run Keyword If    '${shipping-price}' != 'ฟรี'    Replace String    ${shipping-price}    ,    ${EMPTY}
    ...    ELSE    Set Variable    ${shipping-price}
    Log To Console    shipping-price=${shipping-price}
    [Return]    ${shipping-price}

CartLightBox - Verify Shipping Fee
    [Arguments]    ${shipping_fee}=45.00
    CartLightBox - Verify Shipping Fee on UI    ${shipping_fee}

CartLightBox - Verify Shipping Fee is Zero
    CartLightBox - Verify Shipping Fee on UI    ฟรี

CartLightBox - Verify Shipping Fee on UI
    [Arguments]    ${expected_shipping_fee}
    ${actual_shipping_fee}=    CartLightBox - Get Shipping Price
    Should Be Equal    ${expected_shipping_fee}    ${actual_shipping_fee}
