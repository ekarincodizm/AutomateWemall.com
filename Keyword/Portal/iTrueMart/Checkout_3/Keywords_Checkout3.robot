*** Settings ***
Library           Selenium2Library
Library           String
Resource          ../../../../Resource/Env_config.robot
Resource          ../../../Common/Keywords_Common.robot
Resource          ../../../Features/PC1_And_PC3/ITM.robot
Resource          WebElement_Checkout3.robot

*** Variables ***
${Shipping_fee_blink}    //*[@class='sum text-blink text-blink-active text-blink-animation']
${valid_credit_card_number_master}    5555555555554444
&{DATA_CHECKOUT}    valid_username=robotautomate@gmail.com    valid_password=true1234    valid_username_checkout=robotautomate@gmail.com    valid_password_checkout=true1234    valid_ssoid=27145880    valid_name=Robot Automate    valid_mobile=0901234567
...               valid_email=robotautomate@gmail.com    valid_address=This is a robot address    valid_card_holder_name=Robot Automate    valid_credit_card_number=5555555555554444    invalid_credit_card_number=4111111111111112    valid_cvc=123    valid_billing_name=
...               valid_billing_mobile=    valid_billing_email=    valid_billing_address=
# ssoid for stg40k only
&{DATA_CHECKOUT_2}    valid_username=robotautomate01@gmail.com    valid_password=true1234    valid_username_checkout=robotautomate01@gmail.com    valid_password_checkout=true1234    valid_ssoid=27115272

*** Keywords ***
Checkout3 - Select payment channal
    [Arguments]    ${payment_channal}
    Comment    Wait Until Element Is Visible    ${Submit_Checkout3}    20s
    Wait Until Element is ready and click    ${payment_channal}    60
    Comment    Wait Until Element Is Not Visible    ${Loading_image}    20s    None

Checkout3 - Apply Coupon
    [Arguments]    ${coupon}
    Wemall Common - Close Live Chat
    Wait Until Element Is Visible    ${Checkout3_InputCoupon}    60s
    Mini Cart - Wait Until Point Ajax Loading Is Not Display    60s
    Input Text    ${Checkout3_InputCoupon}    ${coupon}
    Mini Cart - Wait Until Point Ajax Loading Is Not Display    60s
    Keywords_Checkout3.Retry Coupon Code    ${coupon}
    Wait Until Element Is Visible    ${Checkout3_box_discount}    60s
    Wait Until Page Contains Element    ${Checkout3_box_discount}    60s
    # Wait Until Page Does Not Contain    ${Shipping_fee_blink}
    Click Element    ${Checkout3_SubmitCoupon}
    Wait Until Element Is Not Visible    ${Checkout3_LoadingImg}    20s

Checkout3 - Apply CCW
    [Arguments]    ${Text_CCWName}    ${Text_CCWCardNo}    ${Text_CCWCCV}
    Wait Until Element is ready and type    ${Checkout3_CCWName}    ${Text_CCWName}    60
    Wait Until Element is ready and type    ${Checkout3_CCWCardNo}    ${Text_CCWCardNo}    60
    Wait Until Element Is Not Visible    ${Checkout3_LoadingImg}    20s
    Click Element    ${Checkout3_CCWMonth}
    Wait Until Element Is Not Visible    ${Checkout3_LoadingImg}    20s
    Click Element    ${Checkout3_CCWMonth}/option[contains(text(),'11')]
    Click Element    ${Checkout3_CCWYear}
    Wait Until Element Is Not Visible    ${Checkout3_LoadingImg}    20s
    Click Element    ${Checkout3_CCWYear}/option[contains(text(),'2022')]
    Wait Until Element is ready and type    ${Checkout3_CCWCCV}    ${Text_CCWCCV}    60
    Keywords_Checkout3.Reattempt to Input CCW Name    ${Text_CCWName}
    Keywords_Checkout3.Reattempt to Input CCW Card No    ${Text_CCWCardNo}
    Keywords_Checkout3.Reattempt to Input CCW CCV    ${Text_CCWCCV}

Checkout3 - Click Submit
    Wait Until Element is ready and click    ${Submit_Checkout3}    60
    Comment    Wait Until Element Is Not Visible    ${Checkout3_LoadingImg}    20s

Checkout3 - Wait Loading
    Wait Until Element Is Not Visible    ${Checkout3_LoadingImg}    20s

Checkout3 - Confirm CCW
    Wait Until Element Is Visible    ${Checkout3_ConfirmBtn}    60s
    Click Element    ${Checkout3_ConfirmBtn}
    Wait Until Element Is Not Visible    ${Checkout3_LoadingImg}    20s

Retry Coupon Code
    [Arguments]    ${Text_Code}
    ${verify_coupon}    Get Text    ${Checkout3_InputCoupon}
    ${present_coupon}=    Run Keyword And Return Status    Should Be Empty    ${verify_coupon}
    Run Keyword If    ${present_coupon}    Keywords_Checkout3.Reattempt to Input Coupon Code    ${Text_Code}

Retry CCW Name
    [Arguments]    ${Text_CCWName}
    ${verify_CCW_Name}    Get Text    ${Checkout3_CCWName}
    ${present_CCW_Name}=    Run Keyword And Return Status    Should Be Empty    ${verify_CCW_Name}
    Run Keyword If    ${present_CCW_Name}    Keywords_Checkout3.Reattempt to Input CCW Name    ${Text_CCWName}

Retry CCW Card No
    [Arguments]    ${Text_CCWCardNo}
    ${verify_CardNo}    Get Text    ${Checkout3_CCWCardNo}
    ${present_CardNo}=    Run Keyword And Return Status    Should Be Empty    ${verify_CardNo}
    Run Keyword If    ${present_CardNo}    Keywords_Checkout3.Reattempt to Input CCW Card No    ${Text_CCWCardNo}

Retry CCW CCV
    [Arguments]    ${Text_CCWCCV}
    ${verify_CCV}    Get Text    ${Checkout3_CCWCCV}
    ${present_CCV}=    Run Keyword And Return Status    Should Be Empty    ${verify_CCV}
    Run Keyword If    ${present_CCV}    Keywords_Checkout3.Reattempt to Input CCW CCV    ${Text_CCWCCV}

Reattempt to Input Coupon Code
    [Arguments]    ${Text_Code}
    : FOR    ${INDEX}    IN RANGE    0    10
    \    Focus    ${Checkout3_InputCoupon}
    \    Input Text    ${Checkout3_InputCoupon}    ${Text_Code}
    \    Wait Until Element Is Not Visible    ${Checkout3_LoadingImg}    20s
    \    Comment    Click Element    ${Checkout3_CCWName}
    \    ${verify_coupon}    Get Value    ${Checkout3_InputCoupon}
    \    Comment    ${verify_coupon}    Get Text    ${Checkout3_InputCoupon}
    \    ${empty_present}    Run Keyword And Return Status    Should Be Empty    ${verify_coupon}
    \    Run Keyword If    ${empty_present}==${False}    Exit For Loop

Reattempt to Input CCW Name
    [Arguments]    ${Text_CWName}
    : FOR    ${INDEX}    IN RANGE    0    10
    \    Input Text    ${Checkout3_CCWName}    ${Text_CWName}
    \    Wait Until Element Is Not Visible    ${Checkout3_LoadingImg}    20s
    \    Comment    Click Element    ${Checkout3_CCWCCV}
    \    ${verify_Name}    Get Value    ${Checkout3_CCWName}
    \    Comment    ${verify_Name}    Get Text    ${Checkout3_CCWName}
    \    ${empty_present}    Run Keyword And Return Status    Should Be Empty    ${verify_Name}
    \    Run Keyword If    ${empty_present}==${False}    Exit For Loop

Reattempt to Input CCW CCV
    [Arguments]    ${Text_CWCCV}
    : FOR    ${INDEX}    IN RANGE    0    10
    \    Input Text    ${Checkout3_CCWCCV}    ${Text_CWCCV}
    \    Wait Until Element Is Not Visible    ${Checkout3_LoadingImg}    20s
    \    Comment    Click Element    ${Checkout3_CCWName}
    \    ${verify_CWCCV}    Get Value    ${Checkout3_CCWCCV}
    \    Comment    ${verify_CWCCV}    Get Text    ${Checkout3_CCWCCV}
    \    ${empty_present}    Run Keyword And Return Status    Should Be Empty    ${verify_CWCCV}
    \    Run Keyword If    ${empty_present}==${False}    Exit For Loop

Reattempt to Input CCW Card No
    [Arguments]    ${Text_CWCardNo}
    : FOR    ${INDEX}    IN RANGE    0    10
    \    Input Text    ${Checkout3_CCWCardNo}    ${Text_CWCardNo}
    \    Wait Until Element Is Not Visible    ${Checkout3_LoadingImg}    20s
    \    Comment    Click Element    ${Checkout3_CCWName}
    \    ${verify_CardNo}    Get Value    ${Checkout3_CCWCardNo}
    \    Comment    ${verify_CardNo}    Get Text    ${Checkout3_CCWCardNo}
    \    ${empty_present}    Run Keyword And Return Status    Should Be Empty    ${verify_CardNo}
    \    Run Keyword If    ${empty_present}==${False}    Exit For Loop

Checkout3 - CC payment and Submit
    [Arguments]    ${Text_CCWName}    ${Text_CCWCardNo}    ${Text_CCWCCV}
    Keywords_Checkout3.Checkout3 - Select payment channal    ${Payment_Channal_CC}
    Keywords_Checkout3.Checkout3 - Apply CCW    ${Text_CCWName}    ${Text_CCWCardNo}    ${Text_CCWCCV}
    Keywords_Checkout3.Checkout3 - Click Submit
    Keywords_Checkout3.Checkout3 - Confirm CCW

Checkout3 - COD payment same address and Submit
    Keywords_Checkout3.Checkout3 - Select payment channal    ${Payment_Channal_COD}
    Wait Until Ajax Loading Is Not Visible
    Keywords_Checkout3.Checkout3 - Click Submit

Checkout3 - COD payment difference address and Submit
    [Arguments]    ${Text_Name}    ${Text_Phone}    ${Text_Address}
    Keywords_Checkout3.Checkout3 - Select payment channal    ${Payment_Channal_COD}
    Keywords_Checkout3.Checkout3 - COD Input Name    ${Text_Name}
    Keywords_Checkout3.Checkout3 - COD Input Phone    ${Text_Phone}
    Keywords_Checkout3.Checkout3 - COD Select Province
    Keywords_Checkout3.Checkout3 - COD Select District
    Keywords_Checkout3.Checkout3 - COD Select SubDistrict
    Keywords_Checkout3.Checkout3 - COD Select ZipCode
    Keywords_Checkout3.Checkout3 - COD Input Address    ${Text_Address}
    Keywords_Checkout3.Checkout3 - Wait Loading
    Keywords_Checkout3.Checkout3 - Click Submit

Checkout3 - COD Input Name
    [Arguments]    ${Text_Name}
    Wait Until Element Is Visible    ${Checkout3_CODInputName}    20s
    Input Text    ${Checkout3_CODInputName}    ${Text_Name}

Checkout3 - COD Input Phone
    [Arguments]    ${Text_Phone}
    Wait Until Element Is Visible    ${Checkout3_CODInputPhone}    20s
    Input Text    ${Checkout3_CODInputPhone}    ${Text_Phone}

Checkout3 - COD Select Province
    Wait Until Element Is Visible    ${Checkout3_CODProvince}    20s
    Click Element    ${Checkout3_CODProvince}
    Click Element    ${Checkout3_CODProvince}/option[2]

Checkout3 - COD Select District
    Wait Until Element Is Visible    ${Checkout3_CODDistrict}    20s
    Click Element    ${Checkout3_CODDistrict}
    Wait Until Element Is Visible    ${Checkout3_CODDistrict}/option[2]    20s
    Click Element    ${Checkout3_CODDistrict}/option[2]

Checkout3 - COD Select SubDistrict
    Wait Until Element Is Visible    ${Checkout3_CODSubDistrict}    20s
    Click Element    ${Checkout3_CODSubDistrict}
    Wait Until Element Is Visible    ${Checkout3_CODSubDistrict}/option[2]    20s
    Click Element    ${Checkout3_CODSubDistrict}/option[2]

Checkout3 - COD Select ZipCode
    Wait Until Element Is Visible    ${Checkout3_CODZipCode}    20s
    Click Element    ${Checkout3_CODZipCode}
    Wait Until Element Is Visible    ${Checkout3_CODZipCode}/option[2]    20s
    Click Element    ${Checkout3_CODZipCode}/option[2]

Checkout3 - COD Input Address
    [Arguments]    ${Text_Address}
    Wait Until Element Is Visible    ${Checkout3_CODInputAddress}    20s
    Input Text    ${Checkout3_CODInputAddress}    ${Text_Address}

Checkout3 - Installment Select installment provider
    [Arguments]    ${installment_provider}
    ${installment_provider_element}    Replace String    ${Checkout3_Installment_Provider}    REPLACE_ME    ${installment_provider}
    Wait Until Element Is Visible    ${installment_provider_element}    20s
    Wait Until Element is ready and click    ${installment_provider_element}    5

Checkout3 - Installment Select installment plan
    [Arguments]    ${installment_plan}
    [Documentation]    Option of installment you want to use in number
    Wait Until Element is ready and click    ${Checkout3_Installment_Month_Selectbox}    20s
    Wait Until Element is ready and click    ${Checkout3_Installment_Month_Selectbox}//option[${installment_plan}]    20s
    #Wait Until Element is ready and click    ${Checkout3_Installment_Month_Selectbox}//option[@value=${installment_plan}]    20s

Checkout3 - Installment payment and Submit
    [Arguments]    ${installment_provider}    ${installment_plan}
    Keywords_Checkout3.Checkout3 - Select payment channal    ${Payment_Channal_Installment}
    Sleep    5s
    Keywords_Checkout3.Checkout3 - Installment Select installment provider    ${installment_provider}
    Sleep    5s
    Keywords_Checkout3.Checkout3 - Installment Select installment plan    ${installment_plan}
    Sleep    8s
    Keywords_Checkout3.Checkout3 - Click Submit
    Sleep    5s
    Keywords_Checkout3.Checkout3 - Confirm CCW

Checkout3 - Counter Service payment and Submit
    Keywords_Checkout3.Checkout3 - Select payment channal    ${Payment_Channal_CounterService}
    Wait Until Ajax Loading Is Not Visible
    Keywords_Checkout3.Checkout3 - Click Submit

User Pay By Wallet Payment
    # Wait Until Element Is Not Visible    //div[@class="modal-backdrop fade"]    ${CHECKOUT_TIMEOUT}
    User Click Payment Channel Wallet Tab
    Wait Until Ajax Loading Is Not Visible
    User Click Submit Button On Checkout3
    Display Confirm Payment Wallet Popup
    User Click Confirm Payment Wallet Button On Checkout3

User Pay By Installment Payment BBL
    User Click Payment Channel Installment Tab
    Wait Until Ajax Loading Is Not Visible
    Select Installment BBL Bank
    Select Installment Period
    User Click Submit Button On Checkout3
    Wait Until Ajax Loading Is Not Visible
    Display Confirm Payment Popup
    User Click Confirm Payment Button On Checkout3

User Pay By Installment Payment Kbank
    User Click Payment Channel Installment Tab
    Wait Until Ajax Loading Is Not Visible
    Select Installment Kbank Bank
    Select Installment Period
    User Click Submit Button On Checkout3
    Wait Until Ajax Loading Is Not Visible
    Display Confirm Payment Popup
    User Click Confirm Payment Button On Checkout3

Select Installment BBL Bank
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.rdo_inst_bank_bbl}
    Click Element    ${XPATH_CHECKOUT_STEP3.rdo_inst_bank_bbl}

Select Installment Kbank Bank
    Wait Until Element Is Visible    //img[contains(@src, "k_bank.png")]    30s
    Click Element    //img[contains(@src, "k_bank.png")]

Select Installment First Bank
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.rdo_inst_bank_first}
    Click Element    ${XPATH_CHECKOUT_STEP3.rdo_inst_bank_first}

Select Installment Period
    Wait Until Element Is Visible    //select[@id="pay_per_month"]/option[2]
    Click Element    //select[@id="pay_per_month"]/option[2]

User Enter Valid Data As Member On Checkout3
    Display All CCW Information
    User Enter Valid Card Holder Name
    User Enter Valid Credit Card Number
    User Enter Valid CVC
    User Select Valid Card Expired
    User Click Submit Button On Checkout3
    Display Confirm Payment Popup
    User Click Confirm Payment Button On Checkout3

Checkout 3 - User Enter Valid Data Master Card As Member
    Display All CCW Information
    User Enter Valid Card Holder Name
    Checkout 3 - User Enter Valid Credit Card Number As Master Card
    User Enter Valid CVC
    User Select Valid Card Expired
    Wait Until Ajax Loading Is Not Visible
    User Click Submit Button On Checkout3
    Display Confirm Payment Popup
    User Click Confirm Payment Button On Checkout3

Checkout 3 - User Enter Valid Data Master Card Not Submit
    Display All CCW Information
    User Enter Valid Card Holder Name
    Checkout 3 - User Enter Valid Credit Card Number As Master Card
    User Enter Valid CVC
    User Select Valid Card Expired

User Enter Valid Data As Member On Checkout3 Not Submit
    Display All CCW Information
    User Enter Valid Card Holder Name
    User Enter Valid Credit Card Number
    User Enter Valid CVC
    User Select Valid Card Expired

User Enter Invalid Data As Member On Checkout3
    Display All CCW Information
    User Enter Valid Card Holder Name
    User Enter Invalid Credit Card Number
    User Enter Valid CVC
    User Select Valid Card Expired
    User Click Submit Button On Checkout3
    Display Confirm Payment Popup
    User Click Confirm Payment Button On Checkout3

User Enter Valid Data As Guest On Checkout3
    Display All CCW Information
    User Enter Valid Card Holder Name
    User Enter Valid Credit Card Number
    User Enter Valid CVC
    User Select Valid Card Expired
    User Click Submit Button On Checkout3
    Display Confirm Payment Popup
    User Click Confirm Payment Button On Checkout3

Checkout3 - Display Checkout Step3 Page
    Selenium2Library.Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.tab_ccw}    ${CHECKOUT_TIMEOUT}
    Selenium2Library.Location Should Contain    ${URL_ITM.CHECKOUT_STEP3_CONTAIN}

User Click Payment Channel CCW Tab
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.tab_ccw}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_CHECKOUT_STEP3.tab_ccw}

User Click Payment Channel Counter Service Tab
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.tab_cs}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_CHECKOUT_STEP3.tab_cs}

User Click Payment Channel Installment Tab
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.tab_installment}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_CHECKOUT_STEP3.tab_installment}

User Click Payment Channel Wallet Tab
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.tab_wallet}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_CHECKOUT_STEP3.tab_wallet}

User Click Payment Channel COD Tab
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.tab_cod}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_CHECKOUT_STEP3.tab_cod}

User Click Submit Button On Checkout3
    Selenium2Library.Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.btn_payment}    ${CHECKOUT_TIMEOUT}
    Selenium2Library.Click Element    ${XPATH_CHECKOUT_STEP3.btn_payment}

Display Confirm Payment Popup
    Selenium2Library.Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.div_confirm_payment_popup}    30s
    #Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.div_confirm_payment_popup}    ${CHECKOUT_TIMEOUT}
    Selenium2Library.Element Should Be Visible    ${XPATH_CHECKOUT_STEP3.div_confirm_payment_popup}

Display Confirm Payment Wallet Popup
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.div_confirm_payment_wallet_popup}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${XPATH_CHECKOUT_STEP3.div_confirm_payment_wallet_popup}

User Click Confirm Payment Button On Checkout3
    Selenium2Library.Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.btn_confirm_payment}
    Selenium2Library.Click Element    ${XPATH_CHECKOUT_STEP3.btn_confirm_payment}

User Click Confirm Payment Wallet Button On Checkout3
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.btn_confirm_payment_wallet}
    Click Element    ${XPATH_CHECKOUT_STEP3.btn_confirm_payment_wallet}

User Enter Coupon Code
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.txt_coupon_code}    ${CHECKOUT_TIMEOUT}
    Sleep    1s
    Input Text    ${XPATH_CHECKOUT_STEP3.txt_coupon_code}    ${TEST_VARIABLE_COUPON_CODE}

User Click Apply Coupon Button
    #Click Element    ${XPATH_CHECKOUT_STEP3.btn_apply_code}
    Comment    Execute Javascript    ${XPATH_CHECKOUT_STEP3.jquery_btn_apply_code}
    Click Element    //input[@id="coupon_button"]

Display All CCW Information
    Display Card Holder Name
    Display Credit Card Number
    Display CVC
    Display Card Expired Date

Display Card Holder Name
    Selenium2Library.Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.txt_card_holder_name}    ${CHECKOUT_TIMEOUT}
    Selenium2Library.Element Should Be Visible    ${XPATH_CHECKOUT_STEP3.txt_card_holder_name}

Display Credit Card Number
    Selenium2Library.Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.txt_credit_card_number}    ${CHECKOUT_TIMEOUT}
    Selenium2Library.Element Should Be Visible    ${XPATH_CHECKOUT_STEP3.txt_credit_card_number}

Display CVC
    Selenium2Library.Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.txt_cvc}    ${CHECKOUT_TIMEOUT}
    Selenium2Library.Element Should Be Visible    ${XPATH_CHECKOUT_STEP3.txt_cvc}

Display Card Expired Date
    Selenium2Library.Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.cbo_card_expired_month}    ${CHECKOUT_TIMEOUT}
    Selenium2Library.Element Should Be Visible    ${XPATH_CHECKOUT_STEP3.cbo_card_expired_month}
    Selenium2Library.Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.cbo_card_expired_year}    ${CHECKOUT_TIMEOUT}
    Selenium2Library.Element Should Be Visible    ${XPATH_CHECKOUT_STEP3.cbo_card_expired_year}

User Enter Valid Card Holder Name
    Selenium2Library.Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.txt_card_holder_name}    ${CHECKOUT_TIMEOUT}
    Selenium2Library.Input Text    ${XPATH_CHECKOUT_STEP3.txt_card_holder_name}    ${DATA_CHECKOUT.valid_card_holder_name}

User Enter Valid Credit Card Number
    Selenium2Library.Input Text    ${XPATH_CHECKOUT_STEP3.txt_credit_card_number}    ${DATA_CHECKOUT.valid_credit_card_number}
    Selenium2Library.Click Element    //body
    Wait Until Ajax Loading Is Not Visible

Checkout 3 - User Enter Valid Credit Card Number As Master Card
    Input Text    ${XPATH_CHECKOUT_STEP3.txt_credit_card_number}    ${valid_credit_card_number_master}
    Click Element    //body
    Wait Until Ajax Loading Is Not Visible

User Enter Invalid Credit Card Number
    Input Text    ${XPATH_CHECKOUT_STEP3.txt_credit_card_number}    ${DATA_CHECKOUT.invalid_credit_card_number}
    Click Element    //body
    Wait Until Ajax Loading Is Not Visible

User Enter Valid CVC
    Selenium2Library.Input Text    ${XPATH_CHECKOUT_STEP3.txt_cvc}    ${DATA_CHECKOUT.valid_cvc}

User Select Valid Month Card Expired
    ${valid-month}=    Get Card Expired Valid Month
    Selenium2Library.Click Element    ${XPATH_CHECKOUT_STEP3.cbo_card_expired_month}/option[@value="${valid-month}"]

User Select Valid Year Card Expired
    ${valid-year}=    Get Card Expired Valid Year
    Selenium2Library.Click Element    ${XPATH_CHECKOUT_STEP3.cbo_card_expired_year}/option[@value="${valid-year}"]

User Select Valid Card Expired
    User Select Valid Month Card Expired
    User Select Valid Year Card Expired

Get Card Expired Valid Year
    ${date}=    Get Current Date
    ${date}=    Convert Date    ${date}    datetime
    Return From Keyword    ${date.year}

Get Card Expired Valid Month
    ${date}=    Get Current Date
    ${date}=    Convert Date    ${date}    datetime
    ${valid-month}=    Convert Month Add Zero Prefix    ${date.month}
    Return From Keyword    ${valid-month}

Get Card Expired Valid Day
    ${date}=    Get Current Date
    ${date}=    Convert Date    ${date}    datetime
    ${valid-day}=    Convert Day Add Zero Prefix    ${date.day}
    Return From Keyword    ${valid-day}

User Click Billing Address
    Click Element    ${XPATH_CHECKOUT_STEP3.chk_billing_address}

User Enter Billing Tax Id
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.txt_tax_id}    ${CHECKOUT_TIMEOUT}
    Input Text    ${XPATH_CHECKOUT_STEP3.txt_tax_id}    ${DATA_CHECKOUT.valid_tax_id}

User Select Billing Province As Bangkok
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.cbo_billing_province}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_CHECKOUT_STEP3.cbo_billing_province}/option[text()="กรุงเทพมหานคร"]
    Sleep    2s

User Select Billing City As Suanluang
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.cbo_billing_city}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_CHECKOUT_STEP3.cbo_billing_city}/option[text()="สวนหลวง"]
    Sleep    2s

User Select Billing District As Suanluang
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.cbo_billing_district}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_CHECKOUT_STEP3.cbo_billing_district}/option[text()="สวนหลวง"]
    Sleep    2s

User Select Billing Zipcode As 10250
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.cbo_billing_zipcode}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_CHECKOUT_STEP3.cbo_billing_zipcode}/option[text()="10250"]
    Sleep    2s

User Enter Billing Address
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.txt_billing_address}    ${CHECKOUT_TIMEOUT}
    Input Text    ${XPATH_CHECKOUT_STEP3.txt_billing_address}    ${DATA_CHECKOUT.valid_billing_address}

Display Error Some Product Cannot Pay By Counter Service
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.lbl_err_cannot_pay_counter_service}    ${CHECKOUT_TIMEOUT}
    Element Should Contain    ${XPATH_CHECKOUT_STEP3.lbl_err_cannot_pay_counter_service}    ${MSG_CHECKOUT_STEP3.cannot_pay_with_counter_service1}
    Element Should Contain    ${XPATH_CHECKOUT_STEP3.lbl_err_cannot_pay_counter_service}    ${MSG_CHECKOUT_STEP3.cannot_pay_with_counter_service2}

Display Error Some Product Conflict Payment Counter Service
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.lbl_err_cannot_pay_counter_service}    ${CHECKOUT_TIMEOUT}
    Element Should Contain    ${XPATH_CHECKOUT_STEP3.lbl_err_cannot_pay_counter_service}    ${MSG_CHECKOUT_STEP3.conflict_pay_with_counter_service1}
    Element Should Contain    ${XPATH_CHECKOUT_STEP3.lbl_err_cannot_pay_counter_service}    ${MSG_CHECKOUT_STEP3.conflict_pay_with_counter_service2}

Display Error Some Product Cannot Pay By Cod
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.lbl_err_cannot_pay_cod}    ${CHECKOUT_TIMEOUT}
    Element Should Contain    ${XPATH_CHECKOUT_STEP3.lbl_err_cannot_pay_cod}    ${MSG_CHECKOUT_STEP3.cannot_pay_with_cod1}
    Element Should Contain    ${XPATH_CHECKOUT_STEP3.lbl_err_cannot_pay_cod}    ${MSG_CHECKOUT_STEP3.cannot_pay_with_cod2}

Display Error Some Product Conflict Payment Cod
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.lbl_err_cannot_pay_cod}    ${CHECKOUT_TIMEOUT}
    Element Should Contain    ${XPATH_CHECKOUT_STEP3.lbl_err_cannot_pay_cod}    ${MSG_CHECKOUT_STEP3.conflict_pay_with_cod1}
    Element Should Contain    ${XPATH_CHECKOUT_STEP3.lbl_err_cannot_pay_cod}    ${MSG_CHECKOUT_STEP3.conflict_pay_with_cod2}

Display Error Some Product Cannot Pay By Installment
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.lbl_err_cannot_pay_installment}    ${CHECKOUT_TIMEOUT}
    Element Should Contain    ${XPATH_CHECKOUT_STEP3.lbl_err_cannot_pay_installment}    ${MSG_CHECKOUT_STEP3.cannot_pay_with_installment1}
    Element Should Contain    ${XPATH_CHECKOUT_STEP3.lbl_err_cannot_pay_installment}    ${MSG_CHECKOUT_STEP3.cannot_pay_with_installment2}

Do Not Display Error Some Product Cannot Pay By E-Wallet
    Element Should Not Be Visible    ${XPATH_CHECKOUT_STEP3.lbl_err_cannot_pay_ewallet}
    #Element Should Contain    ${XPATH_CHECKOUT_STEP3.lbl_err_cannot_pay_ewallet}    ${MSG_CHECKOUT_STEP3.cannot_pay_with_ewallet1}
    #Element Should Contain    ${XPATH_CHECKOUT_STEP3.lbl_err_cannot_pay_ewallet}    ${MSG_CHECKOUT_STEP3.cannot_pay_with_ewallet2}

Do Not Display Error Some Product Cannot Pay By Installment
    Element Should Not Be Visible    ${XPATH_CHECKOUT_STEP3.lbl_err_cannot_pay_installment}

Display Error Some Product Conflict Payment Installment
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.lbl_err_cannot_pay_installment}    ${CHECKOUT_TIMEOUT}
    Element Should Contain    ${XPATH_CHECKOUT_STEP3.lbl_err_cannot_pay_installment}    ${MSG_CHECKOUT_STEP3.conflict_pay_with_installment1}
    Element Should Contain    ${XPATH_CHECKOUT_STEP3.lbl_err_cannot_pay_installment}    ${MSG_CHECKOUT_STEP3.conflict_pay_with_installment2}

User Click Button Open Modal Unpayable List
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.btn_show_popup_cannot_pay}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_CHECKOUT_STEP3.btn_show_popup_cannot_pay}

Display Unpayable Popup Modal
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.spn_popup_cannot_pay}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${XPATH_CHECKOUT_STEP3.spn_popup_cannot_pay}

User Click Delete Unpayable Button
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.btn_delete_unpayable}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_CHECKOUT_STEP3.btn_delete_unpayable}

User Click Delete Unpayable Button On Confirm Dialog
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.btn_confirm_delete_unpayable}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_CHECKOUT_STEP3.btn_confirm_delete_unpayable}

User Click Open Full Cart On Checkout3
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.lnk_full_cart}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_CHECKOUT_STEP3.lnk_full_cart}

Display Temporary Out Of Stock Page
    Log to console    Wait for url of Out of stock page
    #Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.div}    ${CHECKOUT_TIMEOUT}
    #Location Should Contain

Checkout3 - Display Out Of Stock Page
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.div_icon_cancel}    ${CHECKOUT_TIMEOUT}
    Location Should Contain    ${URL_ITM.CHECKOUT_STEP3_CONTAIN}

Verify Coupon code error message
    [Arguments]    ${expect_error_message}
    Wait Until Element Is Visible    ${alert-input-coupon-code}    30s
    Element should contain    ${alert-input-coupon-code}    ${expect_error_message}

Verify if Coupon code apply successful
    Wait Until Element Is Not Visible    ${Checkout3_SubmitCoupon}    60s
    Element Should not be visible    ${Checkout3_SubmitCoupon}

User Edit List Item
    Click Element    id=btn-edit-cart
    Display Full Cart
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.dropdown_edit_item}    ${CHECKOUT_TIMEOUT}
    Select From List    ${XPATH_CHECKOUT_STEP3.dropdown_edit_item}    5
    Sleep    5s
    Click Element    ${XPATH_CHECKOUT_STEP3.btn_continue_on_cart}

User Click Edit Address At Checkout3 Page
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.btn_edit_address}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_CHECKOUT_STEP3.btn_edit_address}

The New Address Should Be Show At Checkout3
    Sleep    3s
    ${new_address}=    Get Text    ${XPATH_CHECKOUT_STEP3.txt_name_checkout3}
    Should Be Equal    ${new_address}    Tester ITM

Should Be Go To Step3
    Location Should Be    ${ITM_URL_SSL}/checkout/step3

Checkout 3 - Checkout 3 Should Has Url As Wemall
    Selenium2Library.Location Should Be    ${WEMALL_URL_SSL}/checkout/step3

Checkout 3 - Verify Popup Coupon code error message
    [Arguments]    ${expect_error_message}=เนื่องจากคุณได้ทำการแก้ไขข้อมูล หากต้องการใช้รหัสส่วนลด กรุณากรอกรหัสส่วนลดในช่องใส่คูปองส่วนลดด้านขวามืออีกครั้งเพื่อรับสิทธิ์
    Wait Until Element Is Visible    ${Checkout3_installment__main-text}    30s
    Element should contain    ${Checkout3_installment__main-text}    ${expect_error_message}

Checkout3 - User Enter Coupon Code
    [Arguments]    ${code}=None
    ${var_code_exist}=    Variable Should Exist    ${TEST_VAR.code}
    Wait Until Element Is Visible    id=coupon_code    60s
    Input Text    id=coupon_code    ${TEST_VAR.code}
