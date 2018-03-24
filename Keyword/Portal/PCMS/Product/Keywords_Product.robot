*** Settings ***
Library           HttpLibrary.HTTP
Library           Selenium2Library
Library           String
Library           BuiltIn
Library           DatabaseLibrary
Resource          ../../../Database/PCMS/keyword_pcms.robot
Resource          WebElement_Product.robot
Library           ${CURDIR}/../../../../Python_Library/variant_library.py
Library           ${CURDIR}/../../../../Python_Library/product.py

*** Keywords ***
Go To Product Set Shipping
    Go To    ${PCMS_URL}/products/set-shipping

Go To Product Set Payment
    Go To    ${PCMS_URL}/products/set-payment

SET ALLOW COD
    [Arguments]    ${inv_id}
    Go To Product Set Shipping
    Wait Until Page Contains Element    id=product    60
    ${product_name}=    get_product_name    ${inv_id}
    Input Text    id=product    ${product_name}
    Click Element    ${xpath-search-button}
    Wait Until Page Contains Element    ${xpath-set-shipping-first-edit-button}    60
    Click Element    ${xpath-set-shipping-first-edit-button}
    Wait Until Element Is Visible    name=allow_cod    60
    Select Checkbox    name=allow_cod
    Wait Until Page Contains Element    ${xpath-save-button}    60
    Click Element    ${xpath-save-button}

SET NOT ALLOW COD
    [Arguments]    ${inv_id}
    GO TO PRODUCT SET SHIPPING
    Wait Until Page Contains Element    id=product    60
    ${product_name}=    get_product_name    ${inv_id}
    Input Text    id=product    ${product_name}
    Click Element    ${xpath-search-button}
    Wait Until Page Contains Element    ${xpath-set-shipping-first-edit-button}    60
    Click Element    ${xpath-set-shipping-first-edit-button}
    Wait Until Element Is Visible    name=allow_cod    60
    Unselect Checkbox    name=allow_cod
    Wait Until Page Contains Element    ${xpath-save-button}    60
    Click Element    ${xpath-save-button}

SET ALLOW TM
    [Arguments]    ${inv_id}
    GO TO PRODUCT SET PAYMENT
    Wait Until Page Contains Element    id=product    60
    ${product_name}=    get_product_name    ${inv_id}
    Input Text    id=product    ${product_name}
    Click Element    ${xpath-search-button}
    Wait Until Page Contains Element    ${xpath-set-payment-first-edit-button}    60
    Click Element    ${xpath-set-payment-first-edit-button}
    Wait Until Element Is Visible    //*[@value="11"]    60
    Select Checkbox    //*[@value="11"]
    Sleep    2
    ${installment_Selected}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${set-save-payment-installment}    5s
    Run Keyword If    ${installment_Selected}==True    Click Element    ${set-save-payment-installment}
    ${installment_not_Selected}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${save-set-payment}    5s
    Run Keyword If    ${installment_not_Selected}==True    Click Element    ${save-set-payment}

SET ALLOW CS CHANNEL
    [Arguments]    ${inv_id}
    GO TO PRODUCT SET PAYMENT
    Wait Until Page Contains Element    id=product    60
    ${product_name}=    get_product_name    ${inv_id}
    Input Text    id=product    ${product_name}
    Click Element    ${xpath-search-button}
    Wait Until Page Contains Element    ${xpath-set-payment-first-edit-button}    60
    Click Element    ${xpath-set-payment-first-edit-button}
    Wait Until Element Is Visible    ${checkbox-CS}    60
    Select Checkbox    ${checkbox-CS}
    Sleep    2
    ${installment_Selected}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${set-save-payment-installment}    5s
    Run Keyword If    ${installment_Selected}==True    Click Element    ${set-save-payment-installment}
    ${installment_not_Selected}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${save-set-payment}    5s
    Run Keyword If    ${installment_not_Selected}==True    Click Element    ${save-set-payment}

SET NOT ALLOW CS CHANNEL
    [Arguments]    ${inv_id}
    GO TO PRODUCT SET PAYMENT
    Wait Until Page Contains Element    id=product    60
    ${product_name}=    get_product_name    ${inv_id}
    Input Text    id=product    ${product_name}
    Click Element    ${xpath-search-button}
    Wait Until Page Contains Element    ${xpath-set-payment-first-edit-button}    60
    Click Element    ${xpath-set-payment-first-edit-button}
    Wait Until Element Is Visible    ${checkbox-CS}    60
    Unselect Checkbox    ${checkbox-CS}
    Sleep    2
    Wait Until Page Contains Element    ${save-set-payment}    60
    Click Element    ${save-set-payment}

Go To Edit Payment Channel Page
    [Arguments]    ${inv_id}
    ${product_id}=    get_product_id    ${inv_id}
    Go To    ${PCMS_URL}/products/set-payment/edit/${product_id}
    Wait Until Page Contains    Edit Product Payment    10s

Set Kbank Installment Payment
    Wait Until Element Is Visible    ${checkbox_installment_payment_method}    10s
    Select Checkbox    ${checkbox_installment_payment_method}
    Wait Until Element Is Visible    ${checkbox_installment_kbank}    10s
    Select Checkbox    ${checkbox_installment_kbank}
    Wait Until Element Is Visible    ${checkbox_installment_kbank_3month}    10s
    Select Checkbox    ${checkbox_installment_kbank_3month}
    Wait Until Element Is Visible    ${button_save_installment_payment}    10s
    Click Element    ${button_save_installment_payment}
    Wait Until Page Contains    Save data success

Set bangkok bank Installment Payment
    Wait Until Element Is Visible    ${checkbox_installment_payment_method}    10s
    Select Checkbox    ${checkbox_installment_payment_method}
    Wait Until Element Is Visible    ${checkbox_installment_bbl}    10s
    Select Checkbox    ${checkbox_installment_bbl}
    Wait Until Element Is Visible    ${checkbox_installment_bbl_6month}    10s
    Select Checkbox    ${checkbox_installment_bbl_6month}
    Wait Until Element Is Visible    ${button_save_installment_payment}    10s
    Click Element    ${button_save_installment_payment}
    Wait Until Page Contains    Save data success

Set ktc Installment Payment
    Wait Until Element Is Visible    ${checkbox_installment_payment_method}    10s
    Select Checkbox    ${checkbox_installment_payment_method}
    Wait Until Element Is Visible    ${checkbox_installment_ktc}    10s
    Select Checkbox    ${checkbox_installment_ktc}
    Wait Until Element Is Visible    ${checkbox_installment_ktc_3month}    10s
    Select Checkbox    ${checkbox_installment_ktc_3month}
    Wait Until Element Is Visible    ${button_save_installment_payment}    10s
    Click Element    ${button_save_installment_payment}
    Wait Until Page Contains    Save data success

Unselect Installment Payment
    Wait Until Element Is Visible    ${checkbox_installment_payment_method}    10s
    Unselect Checkbox    ${checkbox_installment_payment_method}
    Wait Until Element Is Visible    ${save-set-payment}    10s
    Click Element    ${save-set-payment}
    Wait Until Page Contains    Save data success

Set allow cod with product name
    [Arguments]    ${product_name}
    GO TO PRODUCT SET SHIPPING
    Input Text    id=product    ${product_name}
    Click Element    ${xpath-search-button}
    Wait Until Page Contains Element    ${xpath-set-shipping-first-edit-button}    60
    Click Element    ${xpath-set-shipping-first-edit-button}
    Wait Until Element Is Visible    name=allow_cod    60
    Select Checkbox    name=allow_cod
    Wait Until Page Contains Element    ${xpath-save-button}    60
    Click Element    ${xpath-save-button}

Go To Product Collection Page
    Go To    ${PCMS_URL}/products/collection

Go To Product List Page
    Go To    ${PCMS_URL}/products

Go To Product Set Content Page
    Go To    ${PCMS_URL}/products/set-content

Go To Product Set Price Page
    Go To    ${PCMS_URL}/products/set-price

Search product with product name
    [Arguments]    ${product_name}    ${table_id}=productListTable
    Input Text    ${product_name_text_box}    ${product_name}
    Click Element    ${product_search_button}
    Wait Until Page Contains    ${product_name}
    #Wait Until Element Contains    xpath=//*[@id="${table_id}"]    ${product_name}
    # ${pkey_element}=    Get Web Element    ${product_first_record_pkey}
    # [Return]    ${pkey_element.text}

Search product by product name
    [Arguments]    ${product_name}
    Input Text    ${product_name_text_box}    ${product_name}
    Click Element    ${product_search_button}
    Wait Until Element Contains    ${form_search_product}    ${product_name}    15

Rollback product active status and variants status
    [Arguments]    ${product_id}    ${product_active_status}    ${variant_status_list}
    Update DB product active status    ${product_id}    ${product_active_status}
    Update DB variants status    ${product_id}    ${variant_status_list}

Update DB product active status
    [Arguments]    ${product_id}    ${product_active_status}
    update_product_active_status_by_product_id    ${product_id}    ${product_active_status}

Update DB variants status
    [Arguments]    ${product_id}    ${status_list}
    ${variants}=    get_variant_by_product_id    ${product_id}
    ${variants_length}=    Get Length    ${variants}
    ${status_list_length}=    Get Length    ${status_list}
    Should be equal    ${variants_length}    ${status_list_length}
    : FOR    ${INDEX}    IN RANGE    0    ${status_list_length}
    \    ${variant}=    Get From List    ${variants}    ${INDEX}
    \    ${status}=    Get From List    ${status_list}    ${INDEX}
    \    ${inventory_id}=    Set Variable    ${variant[1]}
    \    update_variants_status_by_inventory_id    ${inventory_id}    ${status}

Click Edit Product Button
    Click Element    ${product_first_record_edit_button}
    Wait Until Element Is Visible    ${product_status_select}    15s

Select product status
    [Arguments]    ${status}
    Select From List    ${product_status_select}    ${status}

Save product status
    Click Element    ${product_save_status_button}
    Wait Until Page Contains    Product name has been modified.

Get product have two variants by product active status
    [Arguments]    ${product_status}
    ${product}=    get_product_have_2_variants_by_product_active_status    ${product_status}
    Log to console    product_id::${product[0]}
    Log to console    product_title::${product[1]}
    [Return]    ${product}

Get product by pkey
    [Arguments]    ${product_pkey}
    ${product}=    py_get_product_by_pkey    ${product_pkey}
    Log to console    product_id::${product[0]}
    Log to console    product_title::${product[1]}
    [Return]    ${product}

Get product id from url location
    ${location_url}=    Get Location
    Log to console    url::${location_url}
    ${split_result}=    Split String    ${location_url}    /
    ${split_result_length}=    Get Length    ${split_result}
    ${product_id_index}=    Evaluate    ${split_result_length}-1
    Log to console    split_result::${split_result}
    Log to console    product_id_index::${product_id_index}
    Log to console    productId::${split_result[${product_id_index}]}
    [Return]    ${split_result[${product_id_index}]}

Product - Get product not in alias merchant
    #product_pkey,product_id,product_name
    ${records}=    Get products not in alias merchant
    [Return]    ${records}

Product - Set Inactive Product By Product name
    [Arguments]    ${product_title}
    Log To Console    product_title=${product_title}
    Go To Product List Page
    Search product with product name    ${product_title}
    Click Edit Product Button
    Select product status    0
    Run Keyword And Ignore Error    Confirm Action
    Save product status

Product - Set Inactive Product By Inventory ID
    [Arguments]    ${inv_id}
    Go To Product List Page
    ${product_title}=    get_product_name    ${inv_id}
    Search product with product name    ${product_title}
    Click Edit Product Button
    Select product status    0
    Save product status

Product - Set Active Product By Product name
    [Arguments]    ${product_title}
    Go To Product List Page
    Search product with product name    ${product_title}
    Click Edit Product Button
    Select product status    1
    Run Keyword And Ignore Error    Confirm Action
    Save product status

Product - Set Active Product By Inventory ID
    [Arguments]    ${inv_id}
    Go To Product List Page
    ${product_title}=    get_product_name    ${inv_id}
    Search product with product name    ${product_title}
    Click Edit Product Button
    Select product status    1
    Save product status
