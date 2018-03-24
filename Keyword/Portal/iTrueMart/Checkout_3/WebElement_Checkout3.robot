*** Variables ***
${Payment_Channal_COD}    //*[@class='hservice']
${Payment_Channal_CC}    //*[@class='visa']
${Payment_Channal_Installment}    //*[contains(@class, 'install')]
${Payment_Channal_ATM}    //*[@class='atm']
${Payment_Channal_iBank}    //*[@class='ibank']
${Payment_Channal_Bank}    //*[@class='bank']
${Payment_Channal_Wallet}    //*[@class='tmn_wallet']
${Payment_Channal_CounterService}    //*[@class='cservice']
${Submit_Checkout3}    //*[@id="step3-submit"]
${Checkout3_LoadingImg}    //*[@class="ajaxloading-widget-background"]
${Checkout3_CCWName}    //*[@id="ccw-info-name"]
${Checkout3_CCWCardNo}    //*[@id="ccw-info-no"]
${Checkout3_CCWMonth}    //*[@id="month"]
${Checkout3_CCWYear}    //*[@id="year"]
${Checkout3_CCWCCV}    //*[@id="channel-ccw"]/div[4]/div[4]/div/input
${Checkout3_InputCoupon}    //*[@id="coupon-text"]
${Checkout3_SubmitCoupon}    //*[@id="coupon_button"]
${Checkout3_ConfirmBtn}    //*[@id="confirm-payment-submit"]
${Checkout3_NextBtn}    //*[@id="btnSave"]
${Checkout3_CODInputName}    //*[@id="name"]
${Checkout3_CODInputPhone}    //*[@id="telephone"]
${Checkout3_CODProvince}    //*[@id="province-control"]
${Checkout3_CODDistrict}    //*[@id="district-control"]
${Checkout3_CODSubDistrict}    //*[@id="sub-district-control"]
${Checkout3_CODZipCode}    //*[@id="zip-code-control"]
${Checkout3_CODInputAddress}    //*[@id="address"]
${Checkout3_Installment_Provider}    //*[@class='bank-list']//span[contains(text(),'REPLACE_ME')]/..
${Checkout3_Installment_Month_Selectbox}    //*[@id='pay_per_month']
${Checkout3_installment__main-text}       //*[@class="installment__main-text"][@style="color:red;"]
${Checkout3_Submit_popup_err}                 //*[@id="close-btn"]
${Checkout3_point_ajaxloading}    //*[@class="point-ajaxloading-widget-background"]
${Checkout3_box_discount}    //*[@class="box-discount"]


&{XPATH_CHECKOUT_STEP3}   btn_payment=//*[@id="step3-submit"]
 ...  btn_confirm_payment=//*[@id="confirm-payment-submit"]
 ...  btn_confirm_payment_wallet=//*[@id="confirm-payment-tmn_wallet-submit"]
 ...  div_confirm_payment_popup=//div[@id="confirm-payment-popup-msg"]
 ...  div_confirm_payment_wallet_popup=//div[@id="confirm-payment-tmn_wallet-popup-msg"]
 ...  txt_card_holder_name=//input[@id="ccw-info-name"]
 ...  txt_credit_card_number=//input[@id="ccw-info-no"]
 ...  txt_cvc=//input[@name="ccv"]
 ...  txt_coupon_code=coupon-text
 ...  cbo_card_expired_year=//select[@id="year"]
 ...  cbo_card_expired_month=//select[@id="month"]
 ...  rdo_inst_bank_bbl=//label[@for="rdo_bbl"]
 ...  rdo_inst_bank_first=//*[contains(@class,"inst-bank-list")]/*[@class="bank-list"][1]/label
 ...  tab_ccw=//*[@id="payment-channel-selection"]/li[contains(@class, "visa")]/h2/a[contains(@href, "ccw")]
 ...  tab_cs=//*[@id="payment-channel-selection"]/li/h2/a[contains(@href, "counterservice")]
 ...  tab_ewallet=//*[@id="payment-channel-selection"]/li/h2/a[contains(@href, "wallet")]
 ...  tab_cod=//*[@id="payment-channel-selection"]/li/h2/a[contains(@href, "cod")]
 ...  tab_installment=//*[@id="payment-channel-selection"]/li/h2/a[contains(@href, "instalment")]
 ...  tab_wallet=//*[@id="payment-channel-selection"]/li/h2/a[contains(@href, "channel-tmn_wallet")]
 ...  lbl_err_cannot_pay_counter_service=//div[@id="cservice"]/p[2]
 ...  lbl_err_cannot_pay_cod=//div[@id="hservice"]/p[2]
 ...  lbl_err_cannot_pay_installment=//div[@id="install"]/p[2]
 ...  lbl_err_cannot_pay_ewallet=//div[@id="tmn_wallet"]/p[2]
 ...  btn_show_popup_cannot_pay=//a[contains(@class, "show-manageitempayment-btn")]
 ...  spn_popup_cannot_pay=//span[@id="manage-itempayment-title"]
 ...  btn_delete_unpayable=//div[@class="cart-item__heading--alert"]/a[contains(@class, "manage-itempayment-delete-btn")]
 ...  popup_confirm_delete_unpayable=//div[@id="popup-msg"]
 ...  btn_confirm_delete_unpayable=//div[@id="popup-msg"]/div[2]/div/input[contains(@class, "confirm-itempayment-delete-btn")]
 ...  lnk_full_cart=//a[@id="btn-edit-cart"]
 ...  btn_apply_code=coupon_button
 ...  txt_coupon_code=//input[@id="coupon-text"]
 ...  btn_apply_code=//input[@id="coupon_button"]
 ...  div_icon_cancel=//div[contains(@class, 'thank-icon') and contains(@class, 'icon-cancel') ]
 ...  dropdown_edit_item=//select[@class="select-cart cartlightbox-update-item-qty"]
 ...  btn_continue_on_cart=//*[@id="cartlightbox-go-next"]
 ...  btn_edit_address=//a[@href="https://www.itruemart-dev.com/checkout/step2"]
 ...  txt_name_checkout3=//div[@class="on-cart bdr-none"]/h2
 ...  txt_shiping_list_checkout3=//li[@data-type="normal"]/div/p
 ...  img_nav_checkout3_active=//div[@class="wm-checkout-step-nav active-step-3"]

&{MSG_CHECKOUT_STEP3}  cannot_pay_counter_service=
 ...  cannot_pay_with_installment1=แบบ "[ผ่อนชำระ] เครดิต" ได้
 ...  cannot_pay_with_installment2=สินค้าในตะกร้าของคุณไม่สามารถเลือกชำระ
 ...  cannot_pay_with_cod1=สินค้าในตะกร้าของคุณไม่สามารถเลือกชำระ
 ...  cannot_pay_with_cod2=แบบ "เก็บเงินปลายทาง" ได้
 ...  cannot_pay_with_counter_service1=สินค้าในตะกร้าของคุณไม่สามารถเลือกชำระ
 ...  cannot_pay_with_counter_service2=แบบ "เคาน์เตอร์เซอร์วิส" ได้
 ...  btn_show_popup_cannot_pay=

${TAB-PAYMENT-INSTALMENT}	//*[@id='payment-channel-selection']/li/h2/a[contains(@href, "instalment")]
${TAB-PAYMENT-CCW}   //*[@id='payment-channel-selection']/li/h2/a[contains(@href, "ccw")]
${TAB-PAYMENT-ATM}   //*[@id='payment-channel-selection']/li/h2/a[contains(@href, "atm")]
${TAB-PAYMENT-IBANKING}    //*[@id='payment-channel-selection']/li/h2/a[contains(@href, "ibanking")]
${TAB-PAYMENT-COUNTER}    //*[@id='payment-channel-selection']/li/h2/a[contains(@href, "paymentcounter")]
${TAB-PAYMENT-CSERVICE}    //*[@id='payment-channel-selection']/li/h2/a[contains(@href, "counterservice")]
${TAB-PAYMENT-COD}    //*[@id='payment-channel-selection']/li/h2/a[contains(@href, "cod")]
${all-ccw-information}    id=channel-ccw
${textbox-name-ccw}    id=ccw-info-name
${textbox-number-card-ccw}    id=ccw-info-no
${month-expire-ccw}     //*[@id='month']/option[13]
${year-expire-ccw}    //*[@id='year']/option[12]
${textbox-code-of-card-ccw}     //*[@id='channel-ccw']/div[4]/div[4]/div/input
${submit-checkout3}    id=step3-submit
${confirm-payment-submit}    id=confirm-payment-submit
${checkout3-discount-minicart}    //*[@id='minicart-container']/div[11]/div[1]
${btn-delete-notallow-item}    jquery=div.cart-item__heading--alert a.manage-itempayment-delete-btn
${btn-confirm-delete-notallow-item}    jquery=input.confirm-itempayment-delete-btn

#minicart
${edit-order}    id=btn-edit-cart
${name-product-minicart}    //*[@id='minicart-container']/div[4]/ul/li[1]/div[1]/p
${promotion-name-discount-minicart}    //*[@id='coupon-container']/div[1]/p/span[1]
${discount-minicart}    //*[@id='minicart-container']/div[7]/div[1]
${discount-coupon-minicart}    //*[@id='coupon-container']/div[1]/div
${subtotal-minicart}    //*[@id='minicart-container']/div[5]/div[1]
${shipping-fee-minicart}    //*[@id='minicart-container']/div[6]/div[1]
${total-discount-minicart}    //*[@id='minicart-container']/div[11]/div[1]
${total-minicart}    //*[@id='minicart-container']/div[12]/div[1]
${trueyou-discount-minicart}    //*[@id='minicart-container']/div[8]/div/p/span
${TEXTBOX-PROMOTION-CODE}    id=coupon-text
${button-use-coupon}    id=coupon_button
${alert-input-coupon-code}    //*[@id="coupon_code_error"]
${minicart-form}    id=minicart-container
${cart-icon-levelD}    //*[@class="icn_cart"]

#wallet
${wallet_checkout3}    jquery=[href='#channel-tmn_wallet']
${wallet_checkout3_mobile}    jquery=div.payment-channel input[id="tmn_wallet"]
${wallet_checkout3_confirm_popup}    jquery=#confirm-payment-tmn_wallet-submit
${wallet_checkout3_confirm_popup_mobile}    jquery=div.col-xs-12 a[id="confirm-payment-submit"]
${discount_message}    jquery="p.control-label-total.clr-7.text-ani-1"
${discount_price}    jquery="div.sum.clr-7.text-ani-1"
