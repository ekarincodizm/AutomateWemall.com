*** Settings ***
Library           Selenium2Library
Library           String
Resource          ../../../../Resource/Env_config.robot
Resource          webelement_checkout3_mobile.robot    #Resource    WebElement_Checkout3.robot

*** Variables ***
${Shipping_fee_blink}    //*[@class='sum text-blink text-blink-active text-blink-animation']
${valid_credit_card_number_master}    5555555555554444
&{DATA_CHECKOUT}    valid_username=robotautomate@gmail.com    valid_password=true1234    valid_username_checkout=robotautomate@gmail.com    valid_password_checkout=true1234    valid_ssoid=27145880    valid_name=Robot Automate    valid_mobile=0901234567
...               valid_email=robotautomate@gmail.com    valid_address=This is a robot address    valid_card_holder_name=Robot Automate    valid_credit_card_number=4111111111111111    invalid_credit_card_number=4111111111111112    valid_cvc=123    valid_billing_name=
...               valid_billing_mobile=    valid_billing_email=    valid_billing_address=
# ssoid for stg40k only
&{DATA_CHECKOUT_2}    valid_username=robotautomate01@gmail.com    valid_password=true1234    valid_username_checkout=robotautomate01@gmail.com    valid_password_checkout=true1234    valid_ssoid=27115272

*** Keywords ***
#Checkout3 - Select payment channal
#    [Arguments]    ${payment_channal}
 #   Comment    Wait Until Element Is Visible    ${Submit_Checkout3}    20s
  #  Wait Until Element is ready and click    ${payment_channal}    60
   # Wait Until Element Is Not Visible    ${Loading_image}    20s

#Checkout3 Mobile - Apply Coupon
 #   [Arguments]    ${coupon}
  #  sleep    5
   # #Click Element    ${Checkout3_InputCoupon}
#    Input Text    ${Checkout3_InputCoupon}    ${coupon}
 #   Comment    Click Element    ${Checkout3_CCWName}
  #  Retry Coupon Code    ${coupon}
   # Wait Until Page Does Not Contain    ${Shipping_fee_blink}
#    Click Element    ${Checkout3_SubmitCoupon}
 #   Wait Until Element Is Not Visible    ${Checkout3_LoadingImg}    20s

#Checkout3 Mobile - Apply CCW
 #   [Arguments]    ${Text_CCWName}    ${Text_CCWCardNo}    ${Text_CCWCCV}
  #  Wait Until Element is ready and type    ${Checkout3_CCWName}    ${Text_CCWName}    60
   # Wait Until Element is ready and type    ${Checkout3_CCWCardNo}    ${Text_CCWCardNo}    60
#    Wait Until Element Is Not Visible    ${Checkout3_LoadingImg}    20s
 #   Click Element    ${Checkout3_CCWMonth}
  #  Wait Until Element Is Not Visible    ${Checkout3_LoadingImg}    20s
   # Click Element    ${Checkout3_CCWMonth}/option[contains(text(),'11')]
#    Click Element    ${Checkout3_CCWYear}
 #   Wait Until Element Is Not Visible    ${Checkout3_LoadingImg}    20s
  #  Click Element    ${Checkout3_CCWYear}/option[contains(text(),'2022')]
   # Wait Until Element is ready and type    ${Checkout3_CCWCCV}    ${Text_CCWCCV}    60
#    Reattempt to Input CCW Name    ${Text_CCWName}
 #   Reattempt to Input CCW Card No    ${Text_CCWCardNo}
  #  Reattempt to Input CCW CCV    ${Text_CCWCCV}

Checkout3 Mobile - Apply CCW For Mobile
    [Arguments]    ${Text_CCWName}    ${Text_CCWCardNo}    ${Text_CCWCCV}
    Wait Until Element is ready and type    ${Checkout3_CCWName}    ${Text_CCWName}    60
    Wait Until Element is ready and type    ${Checkout3_CCWCardNo_Mobile}    ${Text_CCWCardNo}    60
    Wait Until Element Is Not Visible    ${Checkout3_LoadingImg}    20s
    Click Element    ${Checkout3_CCWMonth_Mobile}
    Wait Until Element Is Not Visible    ${Checkout3_LoadingImg}    20s
    Click Element    ${Checkout3_CCWMonth_Mobile}/option[contains(text(),'11')]
    Click Element    ${Checkout3_CCWYear_Mobile}
    Wait Until Element Is Not Visible    ${Checkout3_LoadingImg}    20s
    Click Element    ${Checkout3_CCWYear_Mobile}/option[contains(text(),'2022')]
    Wait Until Element is ready and type    ${Checkout3_CCWCCV_Mobile}    ${Text_CCWCCV}    60
    Reattempt to Input CCW Name For Mobile    ${Text_CCWName}
    Reattempt to Input CCW Card No For Mobile    ${Text_CCWCardNo}
    Reattempt to Input CCW CCV For Mobile    ${Text_CCWCCV}

#Checkout3 Mobile - Click Submit
 #   Wait Until Element is ready and click    ${Submit_Checkout3}    60
    # Wait Until Element Is Not Visible    ${Checkout3_LoadingImg}    20s

Checkout3 Mobile - Click Submit For Mobile
    Wait Until Element is ready and click    ${Submit_Checkout3_Mobile}    60

#Checkout3 Mobile - Wait Loading
 #   Wait Until Element Is Not Visible    ${Checkout3_LoadingImg}    20s

#heckout3 Mobile - Confirm CCW
  #  Wait Until Element Is Visible    ${Checkout3_ConfirmBtn}    60s
 #   Click Element    ${Checkout3_ConfirmBtn}
    # Wait Until Element Is Not Visible    ${Checkout3_LoadingImg}    20s

Checkout3 Mobile - Confirm CCW For Mobile
    Wait Until Element Is Visible    ${Checkout3_ConfirmBtn}    60s
    Click Element    ${Checkout3_ConfirmBtn}

#Checkout3 Mobile Retry Coupon Code
 #   [Arguments]    ${Text_Code}
  #  ${verify_coupon}    Get Text    ${Checkout3_InputCoupon}
   # ${present_coupon}=    Run Keyword And Return Status    Should Be Empty    ${verify_coupon}
    #Run Keyword If    ${present_coupon}    Reattempt to Input Coupon Code    ${Text_Code}

#Checkout3 Mobile Retry CCW Name
 #   [Arguments]    ${Text_CCWName}
  #  ${verify_CCW_Name}    Get Text    ${Checkout3_CCWName}
   # ${present_CCW_Name}=    Run Keyword And Return Status    Should Be Empty    ${verify_CCW_Name}
    #Run Keyword If    ${present_CCW_Name}    Checkout3 - Reattempt to Input CCW Name    ${Text_CCWName}

#Checkout3 Mobile Checkout3 Mobile Retry CCW Card No
 #   [Arguments]    ${Text_CCWCardNo}
  #  ${verify_CardNo}    Get Text    ${Checkout3_CCWCardNo}
   # ${present_CardNo}=    Run Keyword And Return Status    Should Be Empty    ${verify_CardNo}
    #Run Keyword If    ${present_CardNo}    Checkout3 - Reattempt to Input CCW Card No    ${Text_CCWCardNo}

#RCheckout3 Mobile etry CCW CCV
 #   [Arguments]    ${Text_CCWCCV}
  #  ${verify_CCV}    Get Text    ${Checkout3_CCWCCV}
   # ${present_CCV}=    Run Keyword And Return Status    Should Be Empty    ${verify_CCV}
    #Run Keyword If    ${present_CCV}    Checkout3 - Reattempt to Input CCW CCV    ${Text_CCWCCV}

#Checkout3 Mobile Reattempt to Input Coupon Code
 #   [Arguments]    ${Text_Code}
  #  : FOR    ${INDEX}    IN RANGE    0    10
   # \    Focus    ${Checkout3_InputCoupon}
    #\    Input Text    ${Checkout3_InputCoupon}    ${Text_Code}
#    \    Wait Until Element Is Not Visible    ${Checkout3_LoadingImg}    20s
 #   \    Comment    Click Element    ${Checkout3_CCWName}
  #  \    ${verify_coupon}    Get Value    ${Checkout3_InputCoupon}
   # \    Comment    ${verify_coupon}    Get Text    ${Checkout3_InputCoupon}
    #\    ${empty_present}    Run Keyword And Return Status    Should Be Empty    ${verify_coupon}
#    \    Run Keyword If    ${empty_present}==${False}    Exit For Loop

#Checkout3 Mobile Reattempt to Input CCW Name
 #   [Arguments]    ${Text_CWName}
  #  : FOR    ${INDEX}    IN RANGE    0    10
   # \    Input Text    ${Checkout3_CCWName}    ${Text_CWName}
    #\    Wait Until Element Is Not Visible    ${Checkout3_LoadingImg}    20s
#    \    Comment    Click Element    ${Checkout3_CCWCCV}
 #   \    ${verify_Name}    Get Value    ${Checkout3_CCWName}
  #  \    Comment    ${verify_Name}    Get Text    ${Checkout3_CCWName}
   # \    ${empty_present}    Run Keyword And Return Status    Should Be Empty    ${verify_Name}
    #\    Run Keyword If    ${empty_present}==${False}    Exit For Loop

#Checkout3 Mobile Reattempt to Input CCW CCV
 #   [Arguments]    ${Text_CWCCV}
  #  : FOR    ${INDEX}    IN RANGE    0    10
   # \    Input Text    ${Checkout3_CCWCCV}    ${Text_CWCCV}
    #\    Wait Until Element Is Not Visible    ${Checkout3_LoadingImg}    20s
#    \    Comment    Click Element    ${Checkout3_CCWName}
 #   \    ${verify_CWCCV}    Get Value    ${Checkout3_CCWCCV}
  #  \    Comment    ${verify_CWCCV}    Get Text    ${Checkout3_CCWCCV}
   # \    ${empty_present}    Run Keyword And Return Status    Should Be Empty    ${verify_CWCCV}
    #\    Run Keyword If    ${empty_present}==${False}    Exit For Loop

#Checkout3 Mobile Reattempt to Input CCW Card No
 #   [Arguments]    ${Text_CWCardNo}
  #  : FOR    ${INDEX}    IN RANGE    0    10
   # \    Input Text    ${Checkout3_CCWCardNo}    ${Text_CWCardNo}
    #\    Wait Until Element Is Not Visible    ${Checkout3_LoadingImg}    20s
#    \    Comment    Click Element    ${Checkout3_CCWName}
 #   \    ${verify_CardNo}    Get Value    ${Checkout3_CCWCardNo}
  #  \    Comment    ${verify_CardNo}    Get Text    ${Checkout3_CCWCardNo}
   # \    ${empty_present}    Run Keyword And Return Status    Should Be Empty    ${verify_CardNo}
    #\    Run Keyword If    ${empty_present}==${False}    Exit For Loop

Reattempt to Input CCW Name For Mobile
    [Arguments]    ${Text_CWName}
    : FOR    ${INDEX}    IN RANGE    0    10
    \    Input Text    ${Checkout3_CCWName}    ${Text_CWName}
    \    Wait Until Element Is Not Visible    ${Checkout3_LoadingImg}    20s
    \    Comment    Click Element    ${Checkout3_CCWCCV_Mobile}
    \    ${verify_Name}    Get Value    ${Checkout3_CCWName}
    \    Comment    ${verify_Name}    Get Text    ${Checkout3_CCWName}
    \    ${empty_present}    Run Keyword And Return Status    Should Be Empty    ${verify_Name}
    \    Run Keyword If    ${empty_present}==${False}    Exit For Loop

Reattempt to Input CCW CCV For Mobile
    [Arguments]    ${Text_CWCCV}
    : FOR    ${INDEX}    IN RANGE    0    10
    \    Input Text    ${Checkout3_CCWCCV_Mobile}    ${Text_CWCCV}
    \    Wait Until Element Is Not Visible    ${Checkout3_LoadingImg}    20s
    \    Comment    Click Element    ${Checkout3_CCWName}
    \    ${verify_CWCCV}    Get Value    ${Checkout3_CCWCCV_Mobile}
    \    Comment    ${verify_CWCCV}    Get Text    ${Checkout3_CCWCCV_Mobile}
    \    ${empty_present}    Run Keyword And Return Status    Should Be Empty    ${verify_CWCCV}
    \    Run Keyword If    ${empty_present}==${False}    Exit For Loop

Reattempt to Input CCW Card No For Mobile
    [Arguments]    ${Text_CWCardNo}
    : FOR    ${INDEX}    IN RANGE    0    10
    \    Input Text    ${Checkout3_CCWCardNo_Mobile}    ${Text_CWCardNo}
    \    Wait Until Element Is Not Visible    ${Checkout3_LoadingImg}    20s
    \    Comment    Click Element    ${Checkout3_CCWName}
    \    ${verify_CardNo}    Get Value    ${Checkout3_CCWCardNo_Mobile}
    \    Comment    ${verify_CardNo}    Get Text    ${Checkout3_CCWCardNo_Mobile}
    \    ${empty_present}    Run Keyword And Return Status    Should Be Empty    ${verify_CardNo}
    \    Run Keyword If    ${empty_present}==${False}    Exit For Loop

#Checkout3 Mobile Checkout3 - CC payment and Submit
 #   [Arguments]    ${Text_CCWName}    ${Text_CCWCardNo}    ${Text_CCWCCV}
  #  Mobile - Checkout3 - Select payment channal    ${Payment_Channal_CC}
   # Checkout3 - Apply CCW    ${Text_CCWName}    ${Text_CCWCardNo}    ${Text_CCWCCV}
    #Checkout3 - Click Submit
#    Checkout3 - Confirm CCW

#Checkout3 Mobile- COD payment same address and Submit
 #   Mobile - Checkout3 - Select payment channal    ${Payment_Channal_COD}
  #  Wait Until Ajax Loading Is Not Visible
   # Checkout3 - Click Submit

#Checkout3 Mobile - COD payment difference address and Submit
 #   [Arguments]    ${Text_Name}    ${Text_Phone}    ${Text_Address}
  #  Mobile - Checkout3 - Select payment channal    ${Payment_Channal_COD}
   # Checkout3 - COD Input Name    ${Text_Name}
    #Checkout3 - COD Input Phone    ${Text_Phone}
#    Checkout3 - COD Select Province
 #   Checkout3 - COD Select District
  #  Checkout3 - COD Select SubDistrict
   # Checkout3 - COD Select ZipCode
    #Checkout3 - COD Input Address    ${Text_Address}
#    Checkout3 - Wait Loading
 #   Checkout3 - Click Submit

#Checkout3 Mobile - COD Input Name
 #   [Arguments]    ${Text_Name}
  #  Wait Until Element Is Visible    ${Checkout3_CODInputName}    20s
   # Input Text    ${Checkout3_CODInputName}    ${Text_Name}

#Checkout3 Mobile - COD Input Phone
 #   [Arguments]    ${Text_Phone}
  #  Wait Until Element Is Visible    ${Checkout3_CODInputPhone}    20s
   # Input Text    ${Checkout3_CODInputPhone}    ${Text_Phone}

#Checkout3 Mobile - COD Select Province
 #   Wait Until Element Is Visible    ${Checkout3_CODProvince}    20s
  #  Click Element    ${Checkout3_CODProvince}
   # Click Element    ${Checkout3_CODProvince}/option[2]

#Checkout3 Mobile - COD Select District
 #   Wait Until Element Is Visible    ${Checkout3_CODDistrict}    20s
  #  Click Element    ${Checkout3_CODDistrict}
   # Wait Until Element Is Visible    ${Checkout3_CODDistrict}/option[2]    20s
    #Click Element    ${Checkout3_CODDistrict}/option[2]

#Checkout3 Mobile - COD Select SubDistrict
 #   Wait Until Element Is Visible    ${Checkout3_CODSubDistrict}    20s
  #  Click Element    ${Checkout3_CODSubDistrict}
   # Wait Until Element Is Visible    ${Checkout3_CODSubDistrict}/option[2]    20s
    #Click Element    ${Checkout3_CODSubDistrict}/option[2]

#Checkout3 Mobile - COD Select ZipCode
 #   Wait Until Element Is Visible    ${Checkout3_CODZipCode}    20s
  #  Click Element    ${Checkout3_CODZipCode}
   # Wait Until Element Is Visible    ${Checkout3_CODZipCode}/option[2]    20s
    #Click Element    ${Checkout3_CODZipCode}/option[2]

#Checkout3 Mobile - COD Input Address
 #   [Arguments]    ${Text_Address}
  #  Wait Until Element Is Visible    ${Checkout3_CODInputAddress}    20s
   # Input Text    ${Checkout3_CODInputAddress}    ${Text_Address}

#Checkout3 Mobile - Installment Select installment provider
 #   [Arguments]    ${installment_provider}
  #  ${installment_provider_element}    Replace String    ${Checkout3_Installment_Provider}    REPLACE_ME    ${installment_provider}
   # Wait Until Element Is Visible    ${installment_provider_element}    20s
    #Wait Until Element is ready and click    ${installment_provider_element}    5

#Checkout3 Mobile - Installment Select installment plan
 #   [Arguments]    ${installment_plan}
  #  [Documentation]    Option of installment you want to use in number
  #
   # Wait Until Element is ready and click    ${Checkout3_Installment_Month_Selectbox}    20s
    #Wait Until Element is ready and click    ${Checkout3_Installment_Month_Selectbox}//option[${installment_plan}]    20s

#Checkout3 Mobile - Installment payment and Submit
 #   [Arguments]    ${installment_provider}    ${installment_plan}
  #  Mobile - Checkout3 - Select payment channal    ${Payment_Channal_Installment}
   # sleep    5
    #Checkout3 - Installment Select installment provider    ${installment_provider}
#    sleep    5
 #   Checkout3 - Installment Select installment plan    ${installment_plan}
  #  Checkout3 - Click Submit
   # Checkout3 - Confirm CCW

#Checkout3 Mobile - Counter Service payment and Submit
 #   Mobile - Checkout3 - Select payment channal    ${Payment_Channal_CounterService}
  #  Wait Until Ajax Loading Is Not Visible
   # Checkout3 - Click Submit

#Checkout3 Mobile User Pay By Wallet Payment
 #   # Wait Until Element Is Not Visible    //div[@class="modal-backdrop fade"]    ${CHECKOUT_TIMEOUT}
  #  User Click Payment Channel Wallet Tab
   # Wait Until Ajax Loading Is Not Visible
    #User Click Submit Button On Checkout3
#    Display Confirm Payment Wallet Popup
 #   User Click Confirm Payment Wallet Button On Checkout3

#Checkout3 Mobile User Pay By Installment Payment
 #   User Click Payment Channel Wallet Tab
  #  Wait Until Ajax Loading Is Not Visible
   # Select Installment BBL Bank
    #Select Installment Period
#    User Click Submit Button On Checkout3
 #   Display Confirm Payment Popup
  #  User Click Confirm Payment Button On Checkout3

#Checkout3 Mobile Select Installment BBL Bank
 #   Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.rdo_inst_bank_bbl}
  #  Click Element    ${XPATH_CHECKOUT_STEP3.rdo_inst_bank_bbl}

#Checkout3 Mobile Select Installment Period
 #   Wait Until Element Is Visible    //select[@id="pay_per_month"]/option[2]
  #  Click Element    //select[@id="pay_per_month"]/option[2]

#Checkout3 Mobile User Enter Valid Data As Member On Checkout3
 #   Display All CCW Information
  #  User Enter Valid Card Holder Name
   # User Enter Valid Credit Card Number
    #User Enter Valid CVC
#    User Select Valid Card Expired
 #   User Click Submit Button On Checkout3
  #  Display Confirm Payment Popup
   # User Click Confirm Payment Button On Checkout3

#Checkout3 Mobile - User Enter Valid Data Master Card As Member
 #   Display All CCW Information
  #  User Enter Valid Card Holder Name
   # Checkout 3 - User Enter Valid Credit Card Number As Master Card
    #User Enter Valid CVC
#    User Select Valid Card Expired
 #   User Click Submit Button On Checkout3
  #  Display Confirm Payment Popup
   # User Click Confirm Payment Button On Checkout3

#Checkout3 Mobile User Enter Valid Data As Member On Checkout3 Not Submit
 #   Display All CCW Information
  #  User Enter Valid Card Holder Name
   # User Enter Valid Credit Card Number
    #User Enter Valid CVC
#    User Select Valid Card Expired

#Checkout3 Mobile User Enter Invalid Data As Member On Checkout3
 #   Display All CCW Information
  #  User Enter Valid Card Holder Name
   #User Enter Valid CVC
    #User Select Valid Card Expired
#    User Click Submit Button On Checkout3
 #   Display Confirm Payment Popup
  #  User Click Confirm Payment Button On Checkout3

#Checkout3 Mobile User Enter Valid Data As Guest On Checkout3
#  Display All CCW Information
 #   User Enter Valid Card Holder Name
 #   User Enter Valid Credit Card Number
  #  User Enter Valid CVC
   # User Select Valid Card Expired
    #User Click Submit Button On Checkout3
#    Display Confirm Payment Popup
 #   User Click Confirm Payment Button On Checkout3

#Checkout3 Mobile - Display Checkout Step3 Page
 #   Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.tab_ccw}    ${CHECKOUT_TIMEOUT}
  #  Location Should Contain    ${URL_ITM.CHECKOUT_STEP3_CONTAIN}

#Checkout3 Mobile User Click Payment Channel CCW Tab
 #   Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.tab_ccw}    ${CHECKOUT_TIMEOUT}
  #  Click Element    ${XPATH_CHECKOUT_STEP3.tab_ccw}

#Checkout3 Mobile User Click Payment Channel Counter Service Tab
 #   Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP3.tab_cs}    ${CHECKOUT_TIMEOUT}
  #  Click Element    ${XPATH_CHECKOUT_STEP3.tab_cs}