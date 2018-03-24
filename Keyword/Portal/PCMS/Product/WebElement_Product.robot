*** Variables ***
${xpath-search-button}    xpath=//input[@value="Search"]
${xpath-save-button}    xpath=//input[@value="Save"]
# On PCMS Product: Set Shipping Data
${xpath-set-shipping-first-edit-button}    xpath=//a[contains(@href, "/products/set-shipping/edit")][1]
# On PCMS Product: Set Payment Data
${xpath-set-payment-first-edit-button}    xpath=//a[contains(@href, "/products/set-payment/edit")][1]
${checkbox-CS}    xpath=//input[@name="paymentMethods[]"][@value="8"]
${save-set-payment}    xpath=//div[@class="mws-panel grid_8 payment-method"]/div[3]/div/div/input[@class="btn btn-primary"]
${checkbox_installment_payment_method}    jquery=div.mws-panel-body:eq(1) label:eq(2) input[value="3"]
${checkbox_installment_kbank}    jquery=div.bank-installment .mws-panel-body:eq(0) div:eq(0) label:eq(0) input[value="1"]
${checkbox_installment_kbank_3month}    jquery=.installment:eq(0) li:eq(0) label:eq(0) input[value=3]
${button_save_installment_payment}    jquery=div.bank-installment .no-padding input.btn.btn-primary[value="Save"]
${PRODUCT-COLLECTION-TABLE}    xpath=//*[@id="productCollectionTable"]
${PRODUCT-LIST-TABLE}    xpath=//*[@id="productListTable"]
${PRODUCT-SET-CONTENT-TABLE}    xpath=//*[@id="productSetContentTable"]
${PRODUCT-LIST-ALL-TABLES}    xpath=//*[@class="mws-datatable-fn mws-table"]
${form_search_product}    xpath=//*[@class="mws-datatable-fn mws-table"]
${product_name_text_box}    xpath=//*[@id='product']
${product_search_button}    xpath=//*[@id='mws-container']/div[1]/div/form/div/div[10]/input[1]
${product_first_record_edit_button}    xpath=//*[@id='productListTable']/tbody/tr[1]/td[7]/a/input
${product_first_record_pkey}    xpath=//*[@id='productListTable']/tbody/tr[1]/td[3]
${product_status_select}    xpath=//*[@id='product-status']
${product_save_status_button}    xpath=//*[@id='submit-btn']
${set-save-payment-installment}    //div[@class="mws-panel grid_8 bank-installment"]/div[3]/div/div/input[@class="btn btn-primary"]
${checkbox_installment_bbl}    jquery=div.bank-installment .mws-panel-body:eq(0) div:eq(6) label:eq(0) input[value="7"]
${checkbox_installment_bbl_6month}    jquery=.installment:eq(6) li:eq(0) label:eq(0) input[value=6]
${installment_bbl_payment_failed}    https://psipay.bangkokbank.com/b2c/images/bt_confirm_e.jpg
${installment_ktc_payment_submit}    https://testpaygate.ktc.co.th/static_ktciso/payment/images/submit.gif
${installment_ktc_payment_cancel}    https://testpaygate.ktc.co.th/static_ktciso/payment/images/cancel.gif
${checkbox_installment_ktc}    jquery=div.bank-installment .mws-panel-body:eq(0) div:eq(5) label:eq(0) input[value="6"]
${checkbox_installment_ktc_3month}    jquery=.installment:eq(5) li:eq(0) label:eq(0) input[value=3]


