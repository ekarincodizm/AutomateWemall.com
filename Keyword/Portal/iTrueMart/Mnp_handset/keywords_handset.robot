*** Settings ***
Resource    ${CURDIR}/web_element_mnp_handset.robot

*** Keywords ***
Display Handset Step1 Page
	Location Should Contain   handset

Input MNP2 Verify Form
	Input Text    ${msisdn_input_box}    0961415653
	Input Text    ${idcard_input_box}    3101200151538
	User Select Valid Birthdate
	User Click Verify Button

Create MNP Truemoveh Order verify
	[Arguments]    ${order_id}
	${dict}=   Create Dictionary   idcard=3101200151538   mobile=0961415653   mnp1_status=success   activate_status=success   status=Y   pcms_order_id=${order_id}   mnp1_success_date=Get time

	${r}=  create_truemoveh_order_verify   ${dict}
	Log to console  ${r}
	[Return]    ${r}

Close Chat Bar
    ${chatbar}=   Get Matching Xpath Count   ${chatbar_box}
	Run Keyword If  '${chatbar}' > '0'  Execute Javascript   document.getElementById('chatbar').style.display = 'none';

Count Price Plans From Register MNP Page
	${count}=   Get Matching Xpath Count   ${price_plan_id_hidden}
	${price_plans}=    Create List
	:FOR    ${i}    IN RANGE    1    ${count} + 1
	\    ${price_plan}=    Selenium2Library.Get Element Attribute    //*[@id="mnp-step1"]/div[2]/div[3]/div[1]/div/div[${i}]//*[@name="price_plan_id"]@value
	\    Append To List    ${price_plans}    ${price_plan}
	${total_price_plan_from_ui}    Get Length    ${price_plans}
	[Return]    ${total_price_plan_from_ui}


MNP Handset - User Click Go To Step 2 Button
	Wait Until Element Is Visible   ${XPATH_HANDSET.btn_goto_step2}  ${CHECKOUT_TIMEOUT}
	Click Element  ${XPATH_HANDSET.btn_goto_step2}


MNP Handset - User Click Go To Step 3 Button
	Wait Until Element Is Visible  ${XPATH_HANDSET.btn_goto_step3}  ${CHECKOUT_TIMEOUT}
	Click Element  ${XPATH_HANDSET.btn_goto_step3}

Prepare To Enter Handset On Web
    Prepare LD MNP Device Product has more than 1variant
    Prepare Data Status Is Waiting And Activate Status Is Success And MNP1 Status Is Success
    Open Level D Page MNP Product On Web
    Sleep   0.25s
    Choose Color And Size Variant is MNP
    Tab MNP Device Is Visible
    Sleep   0.5s
    Click Tab MNP Device
    Click MNP Buy Button
    MNP Form Popup is Opened with Default Value
    Input All Required Fields And Click Verify
    Sleep   2s
    Click To Enter Handset
    Location Should Contain   ${URL_MNP.HANDSET}

Prepare To Enter Handset On Mobile
    Prepare LD MNP Device Product has more than 1variant
    Prepare Data Status Is Waiting And Activate Status Is Success And MNP1 Status Is Success
    Open Level D Page MNP Product On Mobile
    Sleep   0.25s
    Choose Color And Size Variant is MNP
    Tab MNP Device Is Visible
    Click Tab MNP Device
    Click MNP Buy Button
    MNP Form Popup is Opened with Default Value
    Input All Required Fields And Click Verify
    Sleep   2s
    Click To Enter Handset
    Location Should Contain   ${URL_MNP.HANDSET}

Click To Enter Handset
    Click Element   ${XPATH_VERIFY.btn_verify_register}

Open Level D Page MNP Product On Web
	Open Browser    ${HOST}/products/item-${var_ld_mnp_2v_pkey}.html   ${BROWSER}

Open Level D Page MNP Product On Mobile
    Open Browser    ${MOBILE-HOME}/products/item-${var_ld_mnp_2v_pkey}.html    ${BROWSER}

Open Handset Page On Web
	Open Browser    ${URL_MNP.HANDSET}      ${BROWSER}

Open Handset Page with Inventory Id On Web
    Open Browser    ${URL_MNP.HANDSET}?inventory_id=APAAA1116211      ${BROWSER}
    Location Should Contain     ${URL_MNP.HANDSET}

Open Handset Page On Mobile
	Open Browser    ${URL_MNP_MOBILE.HANDSET}   ${BROWSER}

Level D Is Displayed On Web
    Location Should Contain         ${var_ld_mnp_2v_pkey}.html

Level D Is Displayed On Mobile
    Location Should Contain         ${MOBILE-HOME}/products/item-${var_ld_mnp_2v_pkey}.html

MNP Web URL Is Displayed
    Location Should Contain         ${URL_MNP.LANDING}

MNP Mobile URL Is Displayed
    Location Should Contain         ${URL_MNP_MOBILE.LANDING}

Default Price Plan Is Displayed
    Element Should Be Visible       ${XPATH_REGISTER.btn_checkbox}

One Price Plan Is Displayed
    Xpath Should Match X Times        ${XPATH_REGISTER.price_plan_items}      1

Multi Price Plans Are Displayed
    Xpath Should Match X Times        ${XPATH_REGISTER.price_plan_items}      5

Empty Price Plan Is Displayed
    Xpath Should Match X Times        ${XPATH_REGISTER.price_plan_items}      0

Recommend Price Plan Is Displayed
    Page Should Contain Element     ${XPATH_REGISTER.recommended_item}

User Click Back Device Step1
  	Sleep   0.5
  	Wait Until Element Is Visible   ${XPATH_REGISTER.btn_back_device_step1}
  	Click Element  ${XPATH_REGISTER.btn_back_device_step1}
  	Sleep   1.5s

User Upload ID Card MNP Device
    User Upload ID Card Image

Input All Required Fields And Click Verify
    Wait Until Element Is Visible  ${XPATH_VERIFY.txt_mobile}
    Sleep   0.5s
    Input Text   ${XPATH_VERIFY.txt_mobile}     0959592970
    Input Text   ${XPATH_VERIFY.txt_thai_id}    3870404834865
    Click Element   ${XPATH_VERIFY.txt_birth_date}
    Wait Until Element Is Visible   ${XPATH_VERIFY.cld_birth_date}
    Sleep   0.5s
    Click Element   ${XPATH_VERIFY.cld_select_birth_day}/td[${MNP_REGISTER.SAMPLE_DATA.cld_birth_day}]
    Sleep   0.5s
    Click Element  ${XPATH_VERIFY.btn_verify}

User Fill All Required Field Customer Information Except Title
    User Select ID Card Expired Date
    User Enter Valid First Name
    User Enter Valid Last Name
    User Select Gender As Male
    User Select Valid Marital Status
    User Enter Valid Customer Tel
    User Select Title As Empty

User Fill All Required Field Customer Information Except Firstname
    User Select ID Card Expired Date
    User Select Title As Mr
    User Enter Empty First Name
    User Enter Valid Last Name
    User Select Gender As Male
    User Select Valid Marital Status
    User Enter Valid Customer Tel

User Fill All Required Field Customer Information Except Lastname
    User Select ID Card Expired Date
    User Select Title As Mr
    User Enter Valid First Name
    User Enter Empty Last Name
    User Select Gender As Male
    User Select Valid Marital Status
    User Enter Valid Customer Tel

User Fill All Required Field Customer Information Except Status
    User Select ID Card Expired Date
    User Select Title As Mr
    User Enter Valid First Name
    User Enter Valid Last Name
    User Select Gender As Male
    User Enter Valid Customer Tel
    User Select Marital Status As Empty

User Fill All Required Field Customer Information Except Contact
    User Select ID Card Expired Date
    User Select Title As Mr
    User Enter Valid First Name
    User Enter Valid Last Name
    User Select Gender As Male
    User Select Valid Marital Status
    User Enter Empty Customer Tel

User Fill All Required Field Customer Information ID Address
    User Select ID Card Expired Date
    User Select Title As Mr
    User Enter Valid First Name
    User Enter Valid Last Name
    User Select Gender As Male
    User Select Valid Marital Status
    User Enter Valid Customer Tel

User Fill All Required Field Customer Information Except District
    User Fill All Required Field Customer Information ID Address
    User Select Customer Province As Bangkok

User Fill All Required Field Customer Information Except SubDistrict
    User Fill All Required Field Customer Information Except District
    User Select Customer City First Position

User Fill All Required Field Customer Information Except ZipCode
    User Fill All Required Field Customer Information Except SubDistrict
    User Select Customer District First Position
    User Select Customer Zipcode As Empty

User Fill All Required Field Customer Information Except Address
    User Fill All Required Field Customer Information Except ZipCode
    User Select Customer Zipcode First Position
    User Enter Customer Address As Empty

User Fill All Required Field Billing Information Except District
    User Select Billing Province As Kra-bi

User Fill All Required Field Billing Information Except SubDistrict
    User Fill All Required Field Billing Information Except District
    User Select Billing City First Position

User Fill All Required Field Billing Information Except ZipCode
    User Fill All Required Field Billing Information Except SubDistrict
    User Select Billing District First Position

User Fill All Required Field Billing Information Except Address
    User Fill All Required Field Billing Information Except ZipCode
    User Select Billing Zipcode First Position
    User Enter Billing Address As Empty

User Fill All Required Field Customer Information
    User Select ID Card Expired Date
    User Select Title As Mr
    User Enter Valid First Name
    User Enter Valid Last Name
    User Select Gender As Male
    User Select Valid Marital Status
    User Enter Valid Customer Tel
    User Select Customer Province As Bangkok
    User Select Customer City First Position
    User Select Customer District First Position
    User Select Customer Zipcode First Position
    User Enter Customer Address
    Select Checkbox   ${XPATH_REGISTER.btn_billing_checkbox}
    Verify Billing Check Box Is Already Checked

# Get Mnp Device inventory To Test Var
#     ${inv_id}=  Get Inventory Mnp Device
#     ${dict}=   Set Variable   ${TEST_VAR}
#     Set To Dictionary  ${dict}   inv_id_device=${inv_id}
#     Set Test Variable  ${TEST_VAR}  ${dict}


