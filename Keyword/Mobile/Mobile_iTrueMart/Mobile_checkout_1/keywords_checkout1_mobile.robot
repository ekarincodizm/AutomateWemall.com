*** Settings ***
Library         Selenium2Library
Resource        webelement_checkout1_mobile.robot


*** Variables ***
&{DATA_CHECKOUT}    valid_username=robotautomate@gmail.com
 ...   valid_password=true1234
 ...   valid_username_without_address=suttipong.gk@gmail.com
 ...   valid_password_without_address=135791000
 ...   valid_username_checkout=robotautomate@gmail.com
 ...   valid_password_checkout=true1234
 ...   valid_ssoid=27145880
 ...   valid_name=Robot Automate
 ...   valid_mobile=0956493248
 ...   valid_password_mobile=testitmqa
 ...   valid_email=robotautomate@gmail.com
 ...   valid_address=This is a robot address
 ...   valid_card_holder_name=Robot Automate
 ...   valid_credit_card_number=4111111111111111
 ...   invalid_credit_card_number=4111111111111112
 ...   valid_cvc=123
 ...   valid_billing_name=
 ...   valid_billing_mobile=
 ...   valid_billing_email=
 ...   valid_billing_address=

&{DATA_CHECKOUT}    valid_username=robotautomate@gmail.com    valid_password=true1234    valid_username_checkout=robotautomate@gmail.com    valid_password_checkout=true1234    valid_ssoid=27145880    valid_name=Robot Automate    valid_mobile=0901234567
...               valid_email=robotautomate@gmail.com    valid_address=This is a robot address    valid_card_holder_name=Robot Automate    valid_credit_card_number=4111111111111111    invalid_credit_card_number=4111111111111112    valid_cvc=123    valid_billing_name=
...               valid_billing_mobile=    valid_billing_email=    valid_billing_address=

# ssoid for stg40k only
&{DATA_CHECKOUT_2}    valid_username=robotautomate01@gmail.com    valid_password=true1234    valid_username_checkout=robotautomate01@gmail.com    valid_password_checkout=true1234    valid_ssoid=27115272

*** Keywords ***
Checkout 1 Mobile - Input Email
    [Arguments]    ${Text_Email}
    Wait Until Element Is Visible    ${Checkout1_InputEmail_Mobile}    20s
    Input Text    ${Checkout1_InputEmail_Mobile}    ${Text_Email}

Checkout 1 Mobile - Wait Loading
    Wait Until Element Is Not Visible    ${Checkout1_LoadingImg}    20s

Checkout 1 Mobile - Click Next
    Wait Until Element Is Visible    ${Checkout1_NextBtn_Mobile}    20s
    Click Element    ${Checkout1_NextBtn_Mobile}

Checkout 1 Mobile - Input Password
    [Arguments]    ${Text_Password}
    Wait Until Element Is Visible    ${Checkout1_InputPassword_Mobile}    20s
    Input Text    ${Checkout1_InputPassword_Mobile}    ${Text_Password}

Checkout 1 Mobile - Display Checkout Step1 Page
    Wait Until Page Contains Element    ${XPATH_CHECKOUT_STEP1_MOBILE.btn_next}    ${CHECKOUT_TIMEOUT}
    Location Should Contain    ${URL_ITM.CHECKOUT_STEP1_CONTAIN}

Checkout 1 Mobile - Wemall Checkout 1 URL Is Displayed
    Wait Until Page Contains Element  ${XPATH_CHECKOUT_STEP1_MOBILE.btn_next}   ${TIMEOUT}
    Location Should Be  ${WEMALL_MOBILE_URL_SSL}/checkout/step1

Checkout 1 Mobile - User Select Buy As Member
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP1_MOBILE.rdo_member}    ${CHECKOUT_TIMEOUT}
    Select Radio Button    ${XPATH_CHECKOUT_STEP1_MOBILE.rdo_member}    ${XPATH_CHECKOUT_STEP1_MOBILE.rdo_member_val}

Checkout 1 Mobile - User Enter Valid Email On Checkout1
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP1_MOBILE.txt_username}    ${CHECKOUT_TIMEOUT}
    Input Text    ${XPATH_CHECKOUT_STEP1_MOBILE.txt_username}    ${DATA_CHECKOUT.valid_username}

Checkout 1 Mobile - User Enter Valid Password On Checkout1
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP1_MOBILE.txt_password}    ${CHECKOUT_TIMEOUT}
    Input Text    ${XPATH_CHECKOUT_STEP1_MOBILE.txt_password}    ${DATA_CHECKOUT.valid_password}

Checkout 1 Mobile - Display Form Login At Checkout1
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP1_MOBILE.container}    ${CHECKOUT_TIMEOUT}

    Element Should Be Visible    ${XPATH_CHECKOUT_STEP1_MOBILE.container}

Checkout 1 Mobile - User Click Next Button On Checkout1
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP1_MOBILE.btn_next}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_CHECKOUT_STEP1_MOBILE.btn_next}

Checkout 1 Mobile - User Enter Valid Data As Member On Checkout1
    Checkout 1 Mobile - Display Checkout Step1 Page
    Checkout 1 Mobile - User Select Buy As Member
    Checkout 1 Mobile - Display Form Login At Checkout1
    Checkout 1 Mobile - User Enter Valid Email On Checkout1
    Checkout 1 Mobile - User Enter Valid Password On Checkout1
    Checkout 1 Mobile - User Click Next Button On Checkout1
