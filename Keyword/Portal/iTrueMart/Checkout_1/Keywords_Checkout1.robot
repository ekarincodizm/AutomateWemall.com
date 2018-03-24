*** Settings ***
Library           Selenium2Library
Resource          WebElement_Checkout1.robot

*** Variables ***
# &{DATA_CHECKOUT}    valid_username=robotautomate@gmail.com
#  ...   valid_password=true1234
#### robotautomate@gmail.com found issue when login item in cart missing just ONLY this User Found at 26/10/2016
#### fail at TC_iTM_02542 ,TC_iTM_02543 , TC_iTM_02544
&{DATA_CHECKOUT}    valid_username=robot35@mail.com
 ...   valid_password=123456
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
 ...   invalid_credit_card_number=4111111111111112    valid_cvc=123    valid_billing_name=    valid_billing_mobile=    valid_billing_email=    valid_billing_address=
&{DATA_CHECKOUT}    valid_username=robotautomate@gmail.com    valid_password=true1234    valid_username_checkout=robotautomate@gmail.com    valid_password_checkout=true1234    valid_ssoid=27145880    valid_name=Robot Automate    valid_mobile=0901234567
...               valid_email=robotautomate@gmail.com    valid_address=This is a robot address    valid_card_holder_name=Robot Automate    valid_credit_card_number=4111111111111111    invalid_credit_card_number=4111111111111112    valid_cvc=123    valid_billing_name=
...               valid_billing_mobile=    valid_billing_email=    valid_billing_address=
# ssoid for stg40k only
&{DATA_CHECKOUT_2}    valid_username=robotautomate01@gmail.com    valid_password=true1234    valid_username_checkout=robotautomate01@gmail.com    valid_password_checkout=true1234    valid_ssoid=27115272

*** Keywords ***
Checkout1 - Go To Checkout1
    Go To    ${WEMALL_URL_SSL}/checkout/step1
Checkout1 - Input Email
    [Arguments]    ${Text_Email}
    Wait Until Element Is Visible    ${Checkout1_InputEmail}    20s
    Input Text    ${Checkout1_InputEmail}    ${Text_Email}

Checkout1 - Wait Loading
    Wait Until Element Is Not Visible    ${Checkout1_LoadingImg}    20s

Checkout1 - Click Next
    Wait Until Element Is Visible    ${Checkout1_NextBtn}    20s
    Click Element    ${Checkout1_NextBtn}

Checkout1 - Input Password
    [Arguments]    ${Text_Password}
    Wait Until Element Is Visible    ${Checkout1_InputPassword}    20s
    Input Text    ${Checkout1_InputPassword}    ${Text_Password}

Checkout1 - Click Have Member Radio Button
    Wait Until Element Is Visible    ${Checkout1_RadioMember}    20s
    Click Element    ${Checkout1_RadioMember}

Display Checkout Step1 Page
    Wait Until Page Contains Element    ${XPATH_CHECKOUT_STEP1.btn_next}    ${CHECKOUT_TIMEOUT}
    Location Should Contain    ${URL_ITM.CHECKOUT_STEP1_CONTAIN}

User Click Open Full Cart On Checkout1
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP1.lnk_full_cart}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_CHECKOUT_STEP1.lnk_full_cart}

User Select Buy As Guest
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP1.rdo_guest}    ${CHECKOUT_TIMEOUT}
    Select Radio Button    ${XPATH_CHECKOUT_STEP1.rdo_guest}    ${XPATH_CHECKOUT_STEP1.rdo_guest_val}

User Select Buy As Member
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP1.rdo_member}    ${CHECKOUT_TIMEOUT}
    Select Radio Button    ${XPATH_CHECKOUT_STEP1.rdo_member}    ${XPATH_CHECKOUT_STEP1.rdo_member_val}

User Enter Valid Tel no On Checkout1
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP1.txt_username}    ${CHECKOUT_TIMEOUT}
    Input Text    ${XPATH_CHECKOUT_STEP1.txt_username}    ${DATA_CHECKOUT.valid_mobile}

User Enter Valid Tel no Password On Checkout1
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP1.txt_password}    ${CHECKOUT_TIMEOUT}
    Input Text    ${XPATH_CHECKOUT_STEP1.txt_password}    ${DATA_CHECKOUT.valid_password_mobile}

User Enter Valid Email On Checkout1
    [Arguments]   ${username}=${DATA_CHECKOUT.valid_username}
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP1.txt_username}    ${CHECKOUT_TIMEOUT}
    Input Text    ${XPATH_CHECKOUT_STEP1.txt_username}    ${username}

User Enter Valid Password On Checkout1
    [Arguments]   ${password}=${DATA_CHECKOUT.valid_password}
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP1.txt_password}    ${CHECKOUT_TIMEOUT}
    Input Text    ${XPATH_CHECKOUT_STEP1.txt_password}    ${password}

User Enter Valid Email On Checkout1 Without Address
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP1.txt_username}    ${CHECKOUT_TIMEOUT}
    Input Text    ${XPATH_CHECKOUT_STEP1.txt_username}    ${DATA_CHECKOUT.valid_username_without_address}

User Enter Valid Password On Checkout1 Without Address
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP1.txt_password}    ${CHECKOUT_TIMEOUT}
    Input Text    ${XPATH_CHECKOUT_STEP1.txt_password}    ${DATA_CHECKOUT.valid_password_without_address}

Display Form Login At Checkout1
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP1.container}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${XPATH_CHECKOUT_STEP1.container}

Checkout 1 - Username Box Is Displayed
    Wait Until Element Is Visible   ${XPATH_CHECKOUT_STEP1.txt_username}  ${CHECKOUT_TIMEOUT}
    Element Should Be Visible  ${XPATH_CHECKOUT_STEP1.txt_username}

Checkout 1 - Password Box Is Displayed
    Wait Until Element Is Visible  ${XPATH_CHECKOUT_STEP1.txt_password}  ${CHECKOUT_TIMEOUT}
    Element Should Be Visible   ${XPATH_CHECKOUT_STEP1.txt_password}

Checkout 1 - Select Login Type Is Displayed
    Wait Until Element Is Visible  ${XPATH_CHECKOUT_STEP1.rdo_member}  ${CHECKOUT_TIMEOUT}
    Element Should Be Visible  ${XPATH_CHECKOUT_STEP1.rdo_member}
    Wait Until Element Is Visible  ${XPATH_CHECKOUT_STEP1.rdo_guest}  ${CHECKOUT_TIMEOUT}
    Element Should Be Visible   ${XPATH_CHECKOUT_STEP1.rdo_guest}

Checkout 1 - Next Button Is Displayed
    Wait Until Element Is Visible   ${XPATH_CHECKOUT_STEP1.btn_next}  ${CHECKOUT_TIMEOUT}
    Element Should Be Visible   ${XPATH_CHECKOUT_STEP1.btn_next}

User Click Next Button On Checkout1
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP1.btn_next}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_CHECKOUT_STEP1.btn_next}

User Enter Valid Data As Guest On Checkout1
    [Arguments]  ${email}
    User Select Buy As Guest
    User Enter Valid Email On Checkout1  ${email}
    User Click Next Button On Checkout1

User Enter Valid Data As Member On Checkout1
    [Arguments]   ${email}=${DATA_CHECKOUT.valid_username}   ${password}=${DATA_CHECKOUT.valid_password}
    Display Checkout Step1 Page
    User Select Buy As Member
    Display Form Login At Checkout1
    User Enter Valid Email On Checkout1   ${email}
    User Enter Valid Password On Checkout1   ${password}
    User Click Next Button On Checkout1

User Enter Valid Data As Member On Mobile Checkout1
    Display Checkout Step1 Page
    User Select Buy As Member
    Display Form Login At Checkout1
    User Enter Valid Email On Checkout1
    User Enter Valid Password On Checkout1
    User Click Next Button On Checkout1

User Enter Valid Data As Member On Checkout1 With Tel no
    Display Checkout Step1 Page
    User Select Buy As Member
    Display Form Login At Checkout1
    User Enter Valid Tel no On Checkout1
    User Enter Valid Tel no Password On Checkout1
    User Click Next Button On Checkout1

User Enter Valid Data As Member On Checkout1 Without Address
    Display Checkout Step1 Page
    User Select Buy As Member
    Display Form Login At Checkout1
    User Enter Valid Email On Checkout1 Without Address
    User Enter Valid Password On Checkout1 Without Address
    User Click Next Button On Checkout1

Checkout1 - Click login with facebook on Checkout1 page
    Wait Until Element Is Visible    ${FBloginBtn_LoginPage_locator}    20s
    Click Element    ${FBloginBtn_LoginPage_locator}

Checkout 1 - Checkout 1 Should Has Url As Wemall
    Location Should Be   ${WEMALL_URL_SSL}/checkout/step1
# Checkout 1 - Checkout 1 Content Is Displayed
#     Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP1.}

Checkout 1 - User Enter Valid Data on Checkout1
    [Arguments]    ${username}=robotautomate@gmail.com    ${password}=true1234
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP1.txt_username}    ${CHECKOUT_TIMEOUT}
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP1.txt_password}    ${CHECKOUT_TIMEOUT}
    Input Text    ${XPATH_CHECKOUT_STEP1.txt_username}    ${username}
    Input Text    ${XPATH_CHECKOUT_STEP1.txt_password}    ${password}
    Sleep    1s

Checkout 1 - User Enter Valid Data As Member Freebie on Checkout1
    Checkout 1 - User Enter Valid Data on Checkout1    ${freebie_username_login}    ${freebie_password_login}
