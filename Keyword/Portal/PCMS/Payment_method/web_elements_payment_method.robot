*** Variables ***

${xpath-payment-method-container}     //div[contains(@class, "payment-method")]/div[@class="mws-panel-body"]

${xpath-search-button}  //input[@value="Search"]

${xpath-payment-method-kbank-period}   //input[@type="checkbox" and @name="banks[]" and @value="1"]/../following-sibling::ul
${xpath-payment-method-bay-period}   //input[@type="checkbox" and @name="banks[]" and @value="2"]/../following-sibling::ul
${xpath-payment-method-central-period}   //input[@type="checkbox" and @name="banks[]" and @value="3"]/../following-sibling::ul
${xpath-payment-method-first-choice-period}   //input[@type="checkbox" and @name="banks[]" and @value="4"]/../following-sibling::ul
${xpath-payment-method-tesco-period}   //input[@type="checkbox" and @name="banks[]" and @value="5"]/../following-sibling::ul
${xpath-payment-method-ktc-period}   //input[@type="checkbox" and @name="banks[]" and @value="6"]/../following-sibling::ul
${xpath-payment-method-bbl-period}   //input[@type="checkbox" and @name="banks[]" and @value="7"]/../following-sibling::ul

&{XPATH_PAYMENT_CHANNEL}  txt_product_name=//input[@id="product"]
 ...  btn_search=//input[@value="Search"]
 ...  btn_edit_first=//a[contains(@href, "/products/set-payment/edit")][1]
 ...  btn_save=//div[@class="mws-panel-body no-padding"]/div/div/input[@value="Save"]
 ...  chk_ccw=${xpath-payment-method-container}/label[1]/input
 ...  chk_installment=${xpath-payment-method-container}/label[3]/input
 ...  chk_atm=${xpath-payment-method-container}/label[4]/input
 ...  chk_ibanking=${xpath-payment-method-container}/label[5]/input
 ...  chk_bank_transfer=${xpath-payment-method-container}/label[6]/input
 ...  chk_counter_service=${xpath-payment-method-container}/label[7]/input
 ...  chk_ewallet=${xpath-payment-method-container}/label[8]/input
 ...  chk_allow_promotion_code=allow_promotion

 ...  chk_kbank=//input[@type="checkbox" and @name="banks[]" and @value="1"]
 ...  chk_kbank_period_container=//input[@type="checkbox" and @name="banks[]" and @value="1"]/../following-sibling::ul

 ...  chk_bay=//input[@type="checkbox" and @name="banks[]" and @value="2"]
 ...  chk_bay_period_container=//input[@type="checkbox" and @name="banks[]" and @value="2"]/../following-sibling::ul

 ...  chk_central=//input[@type="checkbox" and @name="banks[]" and @value="3"]
 ...  chk_central_period_container=//input[@type="checkbox" and @name="banks[]" and @value="3"]/../following-sibling::ul

 ...  chk_first_choice=//input[@type="checkbox" and @name="banks[]" and @value="4"]
 ...  chk_first_choice_period_container=//input[@type="checkbox" and @name="banks[]" and @value="4"]/../following-sibling::ul

 ...  chk_tesco=//input[@type="checkbox" and @name="banks[]" and @value="5"]
 ...  chk_tesco_period_container=//input[@type="checkbox" and @name="banks[]" and @value="5"]/../following-sibling::ul

 ...  chk_ktc=//input[@type="checkbox" and @name="banks[]" and @value="6"]
 ...  chk_ktc_period_container=//input[@type="checkbox" and @name="banks[]" and @value="6"]/../following-sibling::ul

 ...  chk_bbl=//input[@type="checkbox" and @name="banks[]" and @value="7"]
 ...  chk_bbl_period_container=//input[@type="checkbox" and @name="banks[]" and @value="7"]/../following-sibling::ul



 ...  div_bank_installment_container=//div[contains(@class, "bank-installment")][1]/div[@class="mws-panel-body"]
 ...  div_installment_allow_promotion_container=//div[contains(@class, "bank-installment")][2]/div[@class="mws-panel-body"]
 ...  chk_allow_promotion=//*[@name="allow_promotion"]
 ...  btn_save_installment=//div[contains(@class, "bank-installment")][2]/div[contains(@class, "mws-panel-body")][2]/div/div/input
 ...  btn_save_no_installment=//div[contains(@class, "payment-method")]/div[contains(@class, "mws-panel-body")][2]/div/div/input

