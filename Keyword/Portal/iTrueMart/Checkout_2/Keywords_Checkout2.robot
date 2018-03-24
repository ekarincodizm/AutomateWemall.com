*** Settings ***
Library           Selenium2Library
Resource          ${CURDIR}/WebElement_Checkout2.robot

*** Variables ***
${CHECKOUT_TIMEOUT}    20s
${checkout2_timeout}    30s
&{DATA_CHECKOUT}    valid_username=robotautomate@gmail.com    valid_password=true1234    valid_username_checkout=robotautomate@gmail.com    valid_password_checkout=true1234    valid_ssoid=27145880    valid_name=Robot Automate    valid_mobile=0901234567
...               valid_email=robotautomate@gmail.com    valid_address=This is a robot address    valid_card_holder_name=Robot Automate    valid_credit_card_number=4111111111111111    invalid_credit_card_number=4111111111111112    valid_cvc=123    valid_billing_name=
...               valid_billing_mobile=    valid_billing_email=    valid_billing_address=
# ssoid for stg40k only
&{DATA_CHECKOUT_2}    valid_username=robotautomate01@gmail.com    valid_password=true1234    valid_username_checkout=robotautomate01@gmail.com    valid_password_checkout=true1234    valid_ssoid=27115272

*** Keywords ***
Checkout2 - Input Name
    [Arguments]    ${Text_Name}
    Wait Until Element Is Visible    ${Checkout2_InputName}    20s
    Input Text    ${Checkout2_InputName}    ${Text_Name}

Checkout2 - Input Phone
    [Arguments]    ${Text_Phone}
    Wait Until Element Is Visible    ${Checkout2_InputPhone}    20s
    Input Text    ${Checkout2_InputPhone}    ${Text_Phone}

Checkout2 - Select Province
    Wait Until Element Is Visible    ${Checkout2_Province}    20s
    Click Element    ${Checkout2_Province}
    Click Element    ${Checkout2_Province}/option[3]

Checkout2 - Select District
    Wait Until Element Is Visible    ${Checkout2_District}    20s
    Click Element    ${Checkout2_District}
    Wait Until Element Is Visible    ${Checkout2_District}/option[2]    20s
    Click Element    ${Checkout2_District}/option[2]

Checkout2 - Select SubDistrict
    Wait Until Element Is Visible    ${Checkout2_SubDistrict}    20s
    Click Element    ${Checkout2_SubDistrict}
    Wait Until Element Is Visible    ${Checkout2_SubDistrict}/option[2]    20s
    Click Element    ${Checkout2_SubDistrict}/option[2]

Checkout2 - Select ZipCode
    Wait Until Element Is Visible    ${Checkout2_ZipCode}    20s
    Click Element    ${Checkout2_ZipCode}
    Wait Until Element Is Visible    ${Checkout2_ZipCode}/option[2]    20s
    Click Element    ${Checkout2_ZipCode}/option[2]

Checkout2 - Input Address
    [Arguments]    ${Text_Address}
    Wait Until Element Is Visible    ${Checkout2_InputAddress}    20s
    Input Text    ${Checkout2_InputAddress}    ${Text_Address}

Checkout2 - Input Email
    [Arguments]    ${email}
    input text      ${Checkout2_Email}      ${email}

Checkout2 - Click Next
    Wait Until Element Is Visible    ${Checkout2_NextBtn}    20s
    Click Element    ${Checkout2_NextBtn}

Checkout2 - Click Next Member
    Sleep    3
    Wait Until Element Is Visible    ${Checkout2_NextBtn_Member}    20s
    Click Element    ${Checkout2_NextBtn_Member}

Checkout2 - Wait Loading
    Wait Until Element Is Not Visible    ${Checkout2_LoadingImg}    20s

Display Checkout Step2 Page
    Selenium2Library.Wait Until Page Contains Element    id=contener
    Selenium2Library.Location Should Contain    ${URL_ITM.CHECKOUT_STEP2_CONTAIN}

Display Existing Address
    Selenium2Library.Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.address_list_container}    ${CHECKOUT_TIMEOUT}
    Selenium2Library.Element Should Be Visible    ${XPATH_CHECKOUT_STEP2.address_list_container}

User Click First Member Address
    Selenium2Library.Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.btn_first_select_address}    ${CHECKOUT_TIMEOUT}
    Selenium2Library.Click Element    ${XPATH_CHECKOUT_STEP2.btn_first_select_address}

User Click Add New Address Button
    Sleep    5s
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.btn_add_new_address}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_CHECKOUT_STEP2.btn_add_new_address}
    Log To Console    ==== Add New Address Button ====
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.btn_add_new_address}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_CHECKOUT_STEP2.btn_add_new_address}
    Log To Console    ==== Add New Address Button ====

User Enter Valid Data As Guest On Checkout2
    [Arguments]    ${email}=${DATA_CHECKOUT.valid_email}
    Wait Until All Element Is Visible On Checkout2
    User Enter Valid Name
    User Enter Valid Mobile
    User Enter Valid Email    ${email}
    User Select Province As Bangkok
    User Select City As Suanluang
    User Select District As Suanluang
    User Select Zipcode As 10250
    User Enter Valid Address
    User Click Next Button

User Enter Valid Data As Guest On Checkout2 Edit Address
    Wait Until All Element Is Visible On Checkout2
    Sleep    5s
    User Enter Valid Name Edit
    User Enter Valid Mobile Edit
    User Enter Valid Email Edit
    User Select Province As Chiangmai
    User Select City As Maetang
    User Select District As Cholae
    User Select Zipcode As 50150
    User Enter Valid Address Edit
    User Click Next Button

User Click Edit Address Change Tel no Only
    Wait Until All Element Is Visible On Checkout2
    Sleep    5s
    User Enter Valid Mobile Edit
    User Click Next Button

User Click Edit Address Change Tel no Which Has More Than 10 Digits
    Wait Until All Element Is Visible On Checkout2
    Sleep    5s
    User Enter Valid Mobile Edit More Than 10 Digits

User Enter Valid Data As Guest On Checkout2 EN
    Wait Until All Element Is Visible On Checkout2
    User Enter Valid Name
    User Enter Valid Mobile
    User Enter Valid Email
    User Select Province As Bangkok EN
    User Select City As Suanluang EN
    User Select District As Suanluang EN
    User Select Zipcode As 10250
    User Enter Valid Address
    User Click Next Button

User Enter Valid Data As Member On Checkout2
    Display Existing Address
    User Click First Member Address
    Wait Until Ajax Loading Is Not Visible

Wait Until All Element Is Visible On Checkout2
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.txt_name}    ${CHECKOUT_TIMEOUT}
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.txt_mobile}    ${CHECKOUT_TIMEOUT}
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.txt_email}    ${CHECKOUT_TIMEOUT}
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.cbo_province}    ${CHECKOUT_TIMEOUT}
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.cbo_city}    ${CHECKOUT_TIMEOUT}
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.cbo_district}    ${CHECKOUT_TIMEOUT}
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.cbo_zipcode}    ${CHECKOUT_TIMEOUT}
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.txt_address}    ${CHECKOUT_TIMEOUT}
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.btn_next}    ${CHECKOUT_TIMEOUT}

User Enter Valid Name Edit
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.txt_name}    ${CHECKOUT_TIMEOUT}
    Clear Element Text    ${XPATH_CHECKOUT_STEP2.txt_name}
    Input Text    ${XPATH_CHECKOUT_STEP2.txt_name}    Tester ITM

User Enter Valid Mobile Edit
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.txt_mobile}    ${CHECKOUT_TIMEOUT}
    Clear Element Text    ${XPATH_CHECKOUT_STEP2.txt_mobile}
    Input Text    ${XPATH_CHECKOUT_STEP2.txt_mobile}    021234567

User Enter Valid Mobile Edit More Than 10 Digits
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.txt_mobile}    ${CHECKOUT_TIMEOUT}
    Clear Element Text    ${XPATH_CHECKOUT_STEP2.txt_mobile}
    Input Text    ${XPATH_CHECKOUT_STEP2.txt_mobile}    021234567890

User Click Edit Address Change Tel no Which Contain Special Charactor
    Wait Until All Element Is Visible On Checkout2
    Sleep    5s
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.txt_mobile}    ${CHECKOUT_TIMEOUT}
    Clear Element Text    ${XPATH_CHECKOUT_STEP2.txt_mobile}
    Input Text    ${XPATH_CHECKOUT_STEP2.txt_mobile}    02-12345678
    User Click Next Button

User Input Name Which Contain Special Charactor
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.txt_name}    ${CHECKOUT_TIMEOUT}
    Input Text    ${XPATH_CHECKOUT_STEP2.txt_name}    ,-

User Click Edit Address Change Name Which Contain Special Charactor
    Wait Until All Element Is Visible On Checkout2
    Sleep    5s
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.txt_name}    ${CHECKOUT_TIMEOUT}
    Clear Element Text    ${XPATH_CHECKOUT_STEP2.txt_name}
    Input Text    ${XPATH_CHECKOUT_STEP2.txt_name}    ,-
    User Click Next Button

Should Be Allow In Text Name
    ${name}=    Get Value    ${XPATH_CHECKOUT_STEP2.txt_name}
    Should Be Equal    ${name}    ,-

User Enter Valid Email Edit
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.txt_email}    ${CHECKOUT_TIMEOUT}
    Clear Element Text    ${XPATH_CHECKOUT_STEP2.txt_email}
    Input Text    ${XPATH_CHECKOUT_STEP2.txt_email}    suttipong.gk@gmail.com

User Select Province As Chiangmai
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.cbo_province}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_CHECKOUT_STEP2.cbo_province}/option[text()="เชียงใหม่"]
    Sleep    3s

User Select City As Maetang
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.cbo_city}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_CHECKOUT_STEP2.cbo_city}/option[text()="แม่แตง"]
    Sleep    3s

User Select District As Cholae
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.cbo_district}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_CHECKOUT_STEP2.cbo_district}/option[text()="ช่อแล"]
    Sleep    3s

User Select Zipcode As 50150
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.cbo_zipcode}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_CHECKOUT_STEP2.cbo_zipcode}/option[text()="50150"]

User Enter Valid Address Edit
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.txt_address}    ${CHECKOUT_TIMEOUT}
    Clear Element Text    ${XPATH_CHECKOUT_STEP2.txt_address}
    Input text    ${XPATH_CHECKOUT_STEP2.txt_address}    345/553

User Enter Valid Name
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.txt_name}    ${CHECKOUT_TIMEOUT}
    Input Text    ${XPATH_CHECKOUT_STEP2.txt_name}    ${DATA_CHECKOUT.valid_name}

User Enter Valid Mobile
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.txt_mobile}    ${CHECKOUT_TIMEOUT}
    Input Text    ${XPATH_CHECKOUT_STEP2.txt_mobile}    ${DATA_CHECKOUT.valid_mobile}

User Enter Valid Email
    [Arguments]    ${email}=${DATA_CHECKOUT.valid_email}
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.txt_email}    ${CHECKOUT_TIMEOUT}
    Input Text    ${XPATH_CHECKOUT_STEP2.txt_email}    ${email}

User Select Province As Bangkok
    Wait Until Page Contains Element    ${XPATH_CHECKOUT_STEP2.cbo_province}/option[text()="กรุงเทพมหานคร"]    ${checkout2_timeout}
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.cbo_province}    ${checkout2_timeout}
    Click Element    ${XPATH_CHECKOUT_STEP2.cbo_province}/option[text()="กรุงเทพมหานคร"]
    ${status}=    Run Keyword And Return Status    Click Element    ${XPATH_CHECKOUT_STEP2.cbo_province}/option[text()="กรุงเทพมหานคร"]
    Run Keyword If    '${status}' == '${False}'    Click Element    ${XPATH_CHECKOUT_STEP2.cbo_province}/option[text()="กรุงเทพมหานคร"]

User Select Province As Bangkok EN
    Wait Until Page Contains Element    ${XPATH_CHECKOUT_STEP2.cbo_province}/option[text()="BANGKOK"]    ${checkout2_timeout}
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.cbo_province}    ${checkout2_timeout}
    Click Element    ${XPATH_CHECKOUT_STEP2.cbo_province}/option[text()="BANGKOK"]
    ${status}=    Run Keyword And Return Status    Click Element    ${XPATH_CHECKOUT_STEP2.cbo_province}/option[text()="BANGKOK"]
    Run Keyword If    '${status}' == '${False}'    Click Element    ${XPATH_CHECKOUT_STEP2.cbo_province}/option[text()="BANGKOK"]

User Select City As Suanluang
    Wait Until Page Contains Element    ${XPATH_CHECKOUT_STEP2.cbo_city}/option[text()="สวนหลวง"]    ${checkout2_timeout}
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.cbo_city}    ${checkout2_timeout}
    ${status}=    Run Keyword And Return Status    Click Element    ${XPATH_CHECKOUT_STEP2.cbo_city}/option[text()="Suanluang"]
    Run Keyword If    '${status}' == '${False}'    Click Element    ${XPATH_CHECKOUT_STEP2.cbo_city}/option[text()="สวนหลวง"]

User Select City As Suanluang EN
    Wait Until Page Contains Element    ${XPATH_CHECKOUT_STEP2.cbo_city}/option[text()="SUAN LUANG"]    ${checkout2_timeout}
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.cbo_city}    ${checkout2_timeout}
    ${status}=    Run Keyword And Return Status    Click Element    ${XPATH_CHECKOUT_STEP2.cbo_city}/option[text()="SUAN LUANG"]
    Run Keyword If    '${status}' == '${False}'    Click Element    ${XPATH_CHECKOUT_STEP2.cbo_city}/option[text()="SUAN LUANG"]

User Select District As Suanluang
    Wait Until Page Contains Element    ${XPATH_CHECKOUT_STEP2.cbo_district}/option[text()="สวนหลวง"]    ${checkout2_timeout}
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.cbo_district}    ${checkout2_timeout}
    ${status}=    Run Keyword And Return Status    Click Element    ${XPATH_CHECKOUT_STEP2.cbo_district}/option[text()="สวนหลวง"]
    Run Keyword If    '${status}' == '${False}'    Click Element    ${XPATH_CHECKOUT_STEP2.cbo_district}/option[text()="สวนหลวง"]

User Select District As Suanluang EN
    Wait Until Page Contains Element    ${XPATH_CHECKOUT_STEP2.cbo_district}/option[text()="SUAN LUANG"]    ${checkout2_timeout}
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.cbo_district}    ${checkout2_timeout}
    ${status}=    Run Keyword And Return Status    Click Element    ${XPATH_CHECKOUT_STEP2.cbo_district}/option[text()="SUAN LUANG"]
    Run Keyword If    '${status}' == '${False}'    Click Element    ${XPATH_CHECKOUT_STEP2.cbo_district}/option[text()="สวSUAN LUANGนหลวง"]

User Select Zipcode As 10250
    Wait Until Page Contains Element    ${XPATH_CHECKOUT_STEP2.cbo_zipcode}/option[text()="10250"]    ${checkout2_timeout}
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.cbo_zipcode}    ${checkout2_timeout}
    ${status}=    Run Keyword And Return Status    Click Element    ${XPATH_CHECKOUT_STEP2.cbo_zipcode}/option[text()="10250"]
    Run Keyword If    '${status}' == '${False}'    Click Element    ${XPATH_CHECKOUT_STEP2.cbo_zipcode}/option[text()="10250"]

User Enter Valid Address
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.txt_address}    ${CHECKOUT_TIMEOUT}
    Input text    ${XPATH_CHECKOUT_STEP2.txt_address}    ${DATA_CHECKOUT.valid_address}

User Click Next Button
    Sleep    3s
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.btn_next}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_CHECKOUT_STEP2.btn_next}

User First Member Address Is Not Visible
    Wait Until Element Is Not Visible    ${XPATH_CHECKOUT_STEP2.btn_first_select_address}    20

Should Be Go To Step2
    Location Should Be    ${ITM_URL}/checkout/step2

New Address Should Be Selected
    Element Should Contain    ${XPATH_CHECKOUT_STEP2.active_address}    This is a robot address

New Address Should Be Selected And Show New Address
    Sleep    3s
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.active_address}    ${CHECKOUT_TIMEOUT}
    Element Should Contain    ${XPATH_CHECKOUT_STEP2.active_address}    Tester ITM

Page Should Be Show Alert
    ${alert_name}    Get Text    ${XPATH_CHECKOUT_STEP2.alerttext_name}
    ${alert_province}    Get Text    ${XPATH_CHECKOUT_STEP2.alert_province}
    ${alert_district}    Get Text    ${XPATH_CHECKOUT_STEP2.alert_district}
    ${alert_sub_district}    Get Text    ${XPATH_CHECKOUT_STEP2.alert_sub_district}
    ${alert_postcode}    Get Text    ${XPATH_CHECKOUT_STEP2.alert_postcode}
    ${alert_address}    Get Text    ${XPATH_CHECKOUT_STEP2.alert_address}
    Should Be Equal    ${alert_name}    * กรุณากรอกชื่อ-นามสกุล
    Should Be Equal    ${alert_province}    * กรุณาเลือกจังหวัด
    Should Be Equal    ${alert_district}    * กรุณาเลือกอำเภอ/เขต
    Should Be Equal    ${alert_sub_district}    * กรุณาเลือกตำบล/แขวง
    Should Be Equal    ${alert_postcode}    * กรุณากรอกรหัสไปรษณีย์
    Should Be Equal    ${alert_address}    * กรุณากรอกที่อยู่

User Click Edit Address
    Sleep    5s
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.btn_edit_address}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_CHECKOUT_STEP2.btn_edit_address}

User Click Delete Address
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.btn_delete_address}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_CHECKOUT_STEP2.btn_delete_address}
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.btn_confirm_delete}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_CHECKOUT_STEP2.btn_confirm_delete}
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.btn_ok_deletesuccess}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_CHECKOUT_STEP2.btn_ok_deletesuccess}

Get Data_id Second Box
    ${data_id}    Selenium2Library.Get Element Attribute    //div[@id="address_list_container"]/div[2]@data-id
    Log To Console    ${data_id}
    [Return]    ${data_id}

Address Should Be Deleted and Old Address Is Selected
    [Arguments]    ${data_id}
    ${expect_data_id}    Selenium2Library.Get Element Attribute    //div[@id="address_list_container"]/div[1]@data-id
    Should Be Equal    ${expect_data_id}    ${data_id}
    Page Should Contain Element    ${XPATH_CHECKOUT_STEP2.active_address}

Shoule Be Success For Change Tel no
    Sleep    5s
    Page Should Not Contain    * หมายเลขโทรศัพท์ต้องเป็นตัวเลข 9 หลักสำหรับโทรศัพท์บ้านและ 10 หลักสำหรับโทรศัพท์มือถือ

Should Be Show Just 10 Digits
    Sleep    5s
    ${tel_no}=    Get Value    ${XPATH_CHECKOUT_STEP2.txt_mobile}
    Log To Console    ${tel_no}
    Should Be Equal    ${tel_no}    0212345678

User Input Name Which Contain Invalid Special Charactor
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.txt_name}    ${CHECKOUT_TIMEOUT}
    Input Text    ${XPATH_CHECKOUT_STEP2.txt_name}    A*B

User Click Edit Address Change Name Which Contain Invalid Special Charactor
    Wait Until All Element Is Visible On Checkout2
    Sleep    5s
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.txt_name}    ${CHECKOUT_TIMEOUT}
    Clear Element Text    ${XPATH_CHECKOUT_STEP2.txt_name}
    Input Text    ${XPATH_CHECKOUT_STEP2.txt_name}    A*B
    User Click Next Button

Should Be Can Not Allow And Show Alert Text
    ${alert_name}    Get Text    ${XPATH_CHECKOUT_STEP2.alerttext_name}
    Should Be Equal    ${alert_name}    * ห้ามกรอกอักขระพิเศษ กรุณากรอกข้อมูลใหม่อีกครั้ง

User Input Which Contain valid Special Charactor
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.txt_address}    ${CHECKOUT_TIMEOUT}
    Input Text    ${XPATH_CHECKOUT_STEP2.txt_address}    (),-

User Click Edit Address Which Contain valid Special Charactor
    Wait Until All Element Is Visible On Checkout2
    Sleep    5s
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.txt_address}    ${CHECKOUT_TIMEOUT}
    Clear Element Text    ${XPATH_CHECKOUT_STEP2.txt_address}
    Input Text    ${XPATH_CHECKOUT_STEP2.txt_address}    (),-
    User Click Next Button

Should Be Allow And Edit Success
    ${address}=    Get Value    ${XPATH_CHECKOUT_STEP2.txt_address}
    Should Be Equal    ${address}    (),-

User Click Send The Address
    ${name}=    Get Text    ${XPATH_CHECKOUT_STEP2.name_in_active_textbox}
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.btn_send_the_address}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_CHECKOUT_STEP2.btn_send_the_address}
    [Return]    ${name}

The Address Should Be Selected
    [Arguments]    ${name}
    ${expect_name}=    Get Text    ${XPATH_CHECKOUT_STEP2.name_in_active_textbox}
    Log To Console    ${name}    ${expect_name}
    Should Be Equal    ${expect_name}    ${name}

The District And Sub-District Is Change
    ${district}=    Get Text    ${XPATH_CHECKOUT_STEP2.district_text}
    ${sub-district}=    Get Text    ${XPATH_CHECKOUT_STEP2.text_sub_district}
    Should Be Equal    ${district}    เขต
    Should Be Equal    ${sub-district}    แขวง

Get Name Which Active Box
    Sleep    5s
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.name_in_active_textbox}    ${CHECKOUT_TIMEOUT}
    ${name}=    Get Text    ${XPATH_CHECKOUT_STEP2.name_in_active_textbox}
    Log TO Console    name=${name}
    [Return]    ${name}

Address 1 Should Be Deleted And New Address Should Be Active
    [Arguments]    ${name}
    Sleep    5s
    ${expect_name}    Get Text    ${XPATH_CHECKOUT_STEP2.name_in_active_textbox}
    Should Not Be Equal    ${name}    ${expect_name}

The E-mail Using Logging From Step1 Is Displayed
    Sleep    5s
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.txt_email}    ${CHECKOUT_TIMEOUT}
    ${email}=    Get Value    ${XPATH_CHECKOUT_STEP2.txt_email}
    Should Be Equal    ${email}    robotautomate@gmail.com
    Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.btn_next}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_CHECKOUT_STEP2.btn_next}

Checkout2 - Click Add New ShippingAddress
    Wait Until Element Is Visible    ${Checkout2_AddShippingAddress}    20s
    Click Element    ${Checkout2_AddShippingAddress}

Checkout2 - Choose 1stShipping Address
    Wait Until Element Is Visible    ${Checkout2_ShippingFirstAddress}    20s
    Click Element    ${Checkout2_ShippingFirstAddress}

Checkout2 - Check an Avaliable Items On MiniCart
    [Arguments]    ${Text_ProductName}
    Wait Until Element Is Visible    ${Checkout2_MiniCart}    20s
    Element Should Contain    ${Checkout2_MiniCart}    ${Text_ProductName}

Checkout2 - Delete All Address On Checkout2
    : FOR    ${INDEX}    IN RANGE    50
    \    ${Check_visible_Address}=    Run Keyword And Return Status    Element Should Be Visible    ${Delete_itemPosition1_fromCart}
    \    Run keyword if    ${Check_visible_items}    Run keywords    Click Element    ${Delete_itemPosition1_fromCart}
    \    ...    AND    Confirm Action
    \    ...    AND    Sleep    5s
    \    ...    ELSE    Exit FOR loop

Checkout 2 - Checkout 2 Should Has Url As Wemall
    Selenium2Library.Location Should Be    ${WEMALL_URL}/checkout/step2

Checkout 2 - Address List Is Displayed
    Selenium2Library.Wait Until Element Is Visible    ${XPATH_CHECKOUT_STEP2.address_list_container}    ${CHECKOUT_TIMEOUT}
    Selenium2Library.Element Should Be Visible    ${XPATH_CHECKOUT_STEP2.address_list_container}

Go To Checkout 2
    Go To    ${WEMALL_URL}/checkout/step2

Go To Checkout 2 EN
    Go To    ${WEMALL_URL}/en/checkout/step2
