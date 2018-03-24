*** Settings ***
Library           Selenium2Library
Resource          ${CURDIR}/webelement_checkout2_mobile.robot

*** Variables ***
${checkout2_timeout}    30s
&{DATA_CHECKOUT}    valid_username=robotautomate@gmail.com
 ...   valid_password=true1234
 ...   valid_username_checkout=robotautomate@gmail.com
 ...   valid_password_checkout=true1234
 ...   valid_ssoid=27145880
 ...   valid_name=Robot Automate
 ...   valid_mobile=0901234567
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
# ssoid for stg40k only
&{DATA_CHECKOUT_2}    valid_username=robotautomate01@gmail.com
 ...   valid_password=true1234
 ...   valid_username_checkout=robotautomate01@gmail.com
 ...   valid_password_checkout=true1234
 ...   valid_ssoid=27115272

*** Keywords ***

Checkout 2 Mobile - Input Name
    [Arguments]    ${Text_Name}
    Wait Until Element Is Visible    ${Checkout2_InputName}    20s
    Input Text    ${Checkout2_InputName}    ${Text_Name}

Checkout 2 Mobile - Input Phone
    [Arguments]    ${Text_Phone}
    Wait Until Element Is Visible    ${Checkout2_InputPhone}    20s
    Input Text    ${Checkout2_InputPhone}    ${Text_Phone}

Checkout 2 Mobile - Select Province
    Wait Until Element Is Visible    ${Checkout2_Province}    20s
    Click Element    ${Checkout2_Province}
    Click Element    ${Checkout2_Province}/option[3]
    Sleep    2s
    Click Element    ${Checkout2_Province}
    Click Element    ${Checkout2_Province}/option[5]

Checkout 2 Mobile - Select District
    Wait Until Element Is Visible    ${Checkout2_District_Mobile}    30s
    Click Element    ${Checkout2_District_Mobile}
    Wait Until Element Is Visible    ${Checkout2_District_Mobile}/option[2]    30s
    Click Element    ${Checkout2_District_Mobile}/option[2]

Checkout 2 Mobile - Select SubDistrict
    Wait Until Element Is Visible    ${Checkout2_SubDistrict_Mobile}    20s
    Click Element    ${Checkout2_SubDistrict_Mobile}
    Wait Until Element Is Visible    ${Checkout2_SubDistrict_Mobile}/option[2]    20s
    Click Element    ${Checkout2_SubDistrict_Mobile}/option[2]

Checkout 2 Mobile - Select ZipCode
    Wait Until Element Is Visible    ${Checkout2_ZipCode}    20s
    Click Element    ${Checkout2_ZipCode}
    Wait Until Element Is Visible    ${Checkout2_ZipCode}/option[2]    20s
    Click Element    ${Checkout2_ZipCode}/option[2]

Checkout 2 Mobile - Input Address
    [Arguments]    ${Text_Address}
    Wait Until Element Is Visible    ${Checkout2_InputAddress}    20s
    Input Text    ${Checkout2_InputAddress}    ${Text_Address}

Checkout 2 Mobile - Input Email
    [Arguments]    ${email}
    input text      ${Checkout2_Email}      ${email}

Checkout 2 Mobile - Click Next
    Wait Until Element Is Visible    ${Checkout2_NextBtn_Mobile}    20s
    Click Element    ${Checkout2_NextBtn_Mobile}

Checkout 2 Mobile - Wemall Checkout 2 URL Is Displayed
    Wait Until Page Contains Element  ${XPATH_CHECKOUT_STEP2_MOBILE.mini_cart_container}   ${TIMEOUT}
    Location Should Be  ${WEMALL_MOBILE_URL}/checkout/step2


Checkout 2 Mobile - Display Existing Address
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2_MOBILE.address_list_container}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${XPATH_CHECKOUT_STEP2_MOBILE.address_list_container}

Checkout 2 Mobile - User Click First Member Address
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2_MOBILE.btn_first_select_address}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_CHECKOUT_STEP2_MOBILE.btn_first_select_address}

Checkout 2 Mobile - User Enter Valid Data As Member On Checkout2
    Checkout 2 Mobile - Display Existing Address
    Checkout 2 Mobile - User Click First Member Address
    Checkout 2 Mobile - User Click Ship To This Address Button
    Wait Until Ajax Loading Is Not Visible

Checkout 2 Mobile - User Click Ship To This Address Button
    Click Element    ${XPATH_CHECKOUT_STEP2_MOBILE.btn_ship_to_this_address}

