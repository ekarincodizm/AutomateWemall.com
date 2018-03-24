*** Settings ***
Library             Selenium2Library
Library             HttpLibrary.HTTP
Library             Collections
Resource            ${CURDIR}/../../../../Keyword/Common/Keywords_Common.robot
Library             ${CURDIR}/../../../../Python_Library/common.py
Library             ${CURDIR}/../../../../Python_Library/truemoveh_import_mobile_number.py
Library             ${CURDIR}/../../../../Python_Library/excel.py

*** Keywords ***
Truemoveh - Excel import mobile - Append Header To List
    @{content}    Create List
    Append To List    ${content}    0    0    Phone_Number
    Append To List    ${content}    0    1    Number_Type
    Append To List    ${content}    0    2    Zone
    Append To List    ${content}    0    3    Propo_Type
    Append To List    ${content}    0    4    Expired_Date
    Append To List    ${content}    0    5    Pattern
    Append To List    ${content}    0    6    Company Code
    [Return]    ${content}

Truemoveh - Excel import mobile - Append Data
    [Arguments]    ${content}    ${row}    ${Phone_Number}   ${Number_Type}    ${Zone}    ${Propo_Type}     ${Expired_Date}    ${Pattern}     ${Company Code}
    Append To List    ${content}    ${row}    0    ${Phone_Number}
    Append To List    ${content}    ${row}    1    ${Number_Type}
    Append To List    ${content}    ${row}    2    ${Zone}
    Append To List    ${content}    ${row}    3    ${Propo_Type}
    Append To List    ${content}    ${row}    4    ${Expired_Date}
    Append To List    ${content}    ${row}    5    ${Pattern}
    Append To List    ${content}    ${row}    6    ${Company Code}

Truemoveh - Excel import mobile - Create excel file
    [Arguments]    ${content}    ${file_name}
    Create And Write To Excel File    ${file_name}    ${content}

Create Truemoveh Excel import mobile
    [Arguments]    ${total_row}    ${mobile_list}    ${Propo_Type}    ${file_name}=mobile_import.xlsx
    ${content}=    Truemoveh - Excel import mobile - Append Header To List
    ${Number_Type}=    Get Dictionary Keys    ${mobile_list}
    ${Phone_Number}=    Get Dictionary Values    ${mobile_list}
    ${total_row}=    Evaluate    ${total_row}+1
    :FOR    ${i}    IN RANGE    1    ${total_row}
    \    ${index}=    Evaluate    ${i}-1
    \    Truemoveh - Excel import mobile - Append Data    ${content}    ${i}     ${Phone_Number[${index}]}   ${Number_Type[${index}]}    BKPOS    ${Propo_Type}     31/12/2020 23:23:59    XXYY     ROBOT
    Truemoveh - Excel import mobile - Create excel file    ${content}    ${CURDIR}/../../../../Resource/TestData/SuperNumber/${file_name}

Clear Proposition and Price Plan and Mobile number
    [Arguments]    ${unique_num}
    SuperNumber - Delete Data With Import Lot And Company Code    ${unique_num}
    Clear Prepared Proposition and Price Plan    ${unique_num}    ${unique_num}
    Close All Browsers

Truemoveh - Go To Import Mobile Number By Excel
    Go To    ${PCMS_URL}/truemoveh/import-mobile
    Wait Until Element Is Visible    id=mws-container    20s

Truemoveh - Go To Mobile Report
    Go To    ${PCMS_URL}/truemoveh/report/mobile
    Wait Until Element Is Visible    id=mws-container    20s

Input Mobile Number
    Wait Until Element Is Visible       //input[@type="submit"]       10s
    Input Text     name=mobile     ${Input_lot}

Upload Mobile Import Excel
    [Arguments]    ${file}    ${import_lot}
    ${file_excel}      common.get_canonical_path    ${path_excel}/${file}
    Choose File    name=file_excel      ${file_excel}
    Input Text     name=lot             ${import_lot}

Select Mobile type
    [Arguments]    ${type_selected}
    Select From List    //select[@id="mobile_type"]    ${type_selected}

Click Search
    Wait Until Element Is Visible       //input[@type="submit"]       10s
    Click Element      //input[@type="submit"]

Upload Mobile Import Excel - Click Upload Button
    Wait Until Element Is Visible       //input[@type="submit"]       10s
    Click Element      //input[@type="submit"]

Upload Mobile Import Excel - Click Confirm Upload Button
    Wait Until Element Is Visible       //input[@type="submit"]       10s
    Click Element      //input[@type="submit"]

Clear Prepared Proposition and Price Plan
    [Arguments]    ${nas_code}    ${pp_code}

    ${price_plan}=    get_price_plan_by_price_plan_code    ${pp_code}
    ${proposition}=    get_proposition_by_nascode    ${nas_code}

    remove_proposition_by_nascode    ${nas_code}
    Run Keyword If    ${price_plan} is not ${None}    remove_price_plan_by_id          ${price_plan[0]}
    Run Keyword If    ${price_plan} is not ${None}    remove_proposition_maps_by_price_plan_id     ${price_plan[0]}
    Run Keyword If    ${proposition} is not ${None}    remove_proposition_maps_by_proposition_id    ${proposition[0]}

Clear Imported Mobile Number
    [Arguments]    ${mobile_list}
    :for    ${mobile}    in    @{mobile_list}
    \    ${mobile_number}=    Get From Dictionary    ${mobile_list}    ${mobile}
    \    remove_mobile_by_number    ${mobile_number}

Prepare Proposition
    [Arguments]    ${nas_code}
    ${proposition}=       Get Dummy Proposition    ${nas_code}
    ${proposition_id}=    add_proposition     ${proposition}
    [return]    ${proposition_id}

Prepare Price Plan
    [Arguments]    ${pp_code}    ${sub_description}=ROBOT Price Plan 999    ${long_description}=Long Desc Robot    ${recommend}=N
    ${response}=    add_price_plan    ${pp_code}    ${sub_description}    ${long_description}    ${recommend}
    [return]    ${response}

Prepare Proposition and Price Plan
    [Arguments]    ${nas_code}    ${pp_code}    ${sub_description}=ROBOT Price Plan 999    ${long_description}=Long Desc Robot    ${recommend}=N
    ${proposition_id}=    Prepare Proposition    ${nas_code}
    ${price_plan_id}=     Prepare Price Plan    ${pp_code}    ${sub_description}    ${long_description}    ${recommend}
    ${response}=    Run Keyword If    ${proposition_id} > 0 and ${price_plan_id} > 0    add_proposition_maps    ${proposition_id}    ${price_plan_id}

    [return]    ${proposition_id}    ${price_plan_id}

Get Dummy Proposition
    [Arguments]    ${nas_code}
    &{dict}=    Create Dictionary
    Set To Dictionary    ${dict}    nas_code            ${nas_code}
    Set To Dictionary    ${dict}    proposition_name    THOR Proposition Name
    Set To Dictionary    ${dict}    pool_number         TEST1234
    Set To Dictionary    ${dict}    baseline            0.00
    Set To Dictionary    ${dict}    penalty             9.99
    Set To Dictionary    ${dict}    contract            12
    Set To Dictionary    ${dict}    t_and_c             TC Short
    Set To Dictionary    ${dict}    t_and_c_long        TC Long
    Set To Dictionary    ${dict}    parent_id           0
    Set To Dictionary    ${dict}    source_type         sim

    [return]    ${dict}

Verify All Mobile Number in List
    Truemoveh - Go To Mobile Report
    :for    ${mobile}    in    @{mobile_list}
    \    ${mobile_type}    ${mobile_number}=    Evaluate    "${mobile}".split(":")
    \    Search Mobile Number by Mobile Number    ${mobile_number}
    \    Verify Mobile Type        ${mobile_type}
    \    Verify Mobile Number      ${mobile_number}

Search Mobile Number by Mobile Number
    [Arguments]    ${mobile_number}
    Wait Until Element Is Visible    name=mobile    5s
    Input Text     name=mobile     ${mobile_number}
    Click Search

Sum mobile number
    [Arguments]    ${mobile_number}
    ${amount}    Set Variable    0
    @{mobile_number}=    Convert To List       ${mobile_number}
    :for    ${number}    in    @{mobile_number}
    \    Log    ${number}
    \    ${amount}=    Evaluate     ${number} + ${amount}

    [Return]    ${amount}

Verify Mobile Type
    [Arguments]     ${expect_type}
     ${result}=     Get Text     //td[3]
     Should Be Equal As Strings     ${result}      ${expect_type}

Verify Mobile Number
    [Arguments]     ${expect_mobile}
     ${result}=     Get Text     //td[4]
     Should Be Equal As Strings     ${result}      ${expect_mobile}

Get Mobile Type List From DB
    @{mobile_type_db_raw_data}=       get_mobile_type
    @{mobile_type_db}      Create List     all
    ${list_length_db}=    Get Length       ${mobile_type_db_raw_data}
    :for    ${index}    in range    1     ${list_length_db}+1
    \        Append To List     ${mobile_type_db}     ${mobile_type_db_raw_data[${index}-1][0]}

    [return]    @{mobile_type_db}

Verify Mobile Type In Report
    [Arguments]    ${mobile_number}     ${mobile_type}
    Input Text     name=mobile     ${mobile_number}
    Click Search
    Verify Mobile Type      ${mobile_type}
    Verify Mobile Number      ${mobile_number}

Verify Mobile Type Dropdown List With DB
    [Arguments]    ${mobile_type_db}
    @{mobile_type_ui_raw_data}=    Get List Items     //select[@id="mobile_type"]
    ${list_length_ui}=    Get Length       ${mobile_type_ui_raw_data}
    :for    ${index}    in range    1     ${list_length_ui}+1
    \     ${mobile_type_ui}=      Convert To Lowercase      ${mobile_type_ui_raw_data[${index}-1].strip()}
    \     Should Be Equal As Strings      ${mobile_type_ui}       ${mobile_type_db[${index}-1]}

Supernumber - Verify Field on Register Page
    [Arguments]    ${mobile_number}    ${sub_description}
    Page Should Contain     ลงทะเบียน     10
    Page Should Contain     บอร์และโปรโมชั่นที่เลือก
    Page Should Contain     ${mobile_number}
    Page Should Contain     ${sub_description}
#    Page Should Contain     ระบุรุ่นมือถือและประเภทซิม
#    Page Should Contain     เลือกรุ่นมือถือที่จะนำไปใช้งาน
#    Page Should Contain     ประเภทซิม
    Page Should Contain     ระบุข้อมูลส่วนตัว
    Page Should Contain     คำนำหน้าชื่อ
    Page Should Contain     ชื่อ*
    Page Should Contain     นามสกุล*
    Page Should Contain     วันที่เกิด*
    Page Should Contain     Email*
    Page Should Contain     เบอร์โทรศัพท์ที่ติดต่อได้*
    Page Should Contain     หมายเลขบัตรประชาชน*
    Page Should Contain     วันที่หมดอายุ*
    Page Should Contain     สำเนาบัตรประชาชน*
    Page Should Contain     ระบุที่อยู่ตามบัตรประชาชน
    Page Should Contain     ระบุที่อยู่ใบแจ้งค่าบริการ

Supernumber - Upload Nation ID file
    [Arguments]    ${file_name}
    ${path_to_file}    common.get_canonical_path    ${CURDIR}../../../../../Resource/PIC/${file_name}
    Log To Console    path=${path_to_file}
    Wait Until Element Is Visible    id=id-card-click    10s
    Choose File    id=file-id-card     ${path_to_file}

Supernumber - Input ID card
    [Arguments]    ${national_id}
    ${national_id}=    Convert To String    ${national_id}
    Input Text    id=nationalId     ${national_id}

Supernumber - Input Random ID card
    ${national_id}=    Random Id Card
    ${national_id}=    Convert To String    ${national_id}
    Input Text    id=nationalId     ${national_id}
    [return]    ${national_id}

Supernumber - Input Information on Register Page
# Phone model 152 = HUAWEI Alex 4G (G620S)
# Sim_model APAAE1116111 = nano sim
    [Arguments]    ${phone_model}=152
    ...    ${sim_model}=${SKU_SIM_SEER}
    ...    ${birthdate_year}=2529
    ...    ${birthdate_month}=8
    ...    ${birthdate_day}=6
    ...    ${email}=supernumber_register@robot.com
    ...    ${phone_number}=0956493248
    ...    ${national_id}=None
    ...    ${expired_year}=2565
    ...    ${expired_month}=8
    ...    ${expired_day}=6
    ...    ${file_name}=cat_ID.jpg
    ...    ${customer_name}=supernumberregister
    ...    ${customer_province}=6
    ...    ${customer_district}=66
    ...    ${customer_sub_district}=466
    ...    ${customer_zip_code}=477
    ...    ${customer_address}=14 SuperAddress
    ...    ${customer_section}=SuperSection
    ...    ${customer_village}=SuperVillage
    ...    ${customer_room}=SuperRoom
    ...    ${customer_alley}=SuperAlley
    ...    ${customer_road}=SuperRoad

#    Wait Until Element Is Visible    id=phoneModel    30
#    Select From List By Value    id=phoneModel    ${phone_model}
#    Sleep    2
#    Select From List By Value    id=simModel      ${sim_model}

    Click Element    id=prefix_mr
    Input Text    id=firstname    RobotSupernumber
    Input Text    id=lastname     SeerNitikit

    Select From List By Value    id=birthdateYear     ${birthdate_year}
    Select From List By Value    id=birthdateMonth    ${birthdate_month}
    Select From List By Value    id=birthdateDay      ${birthdate_day}

    Input Text    id=email          ${email}
    Input Text    id=phoneNumber    ${phone_number}

    Run Keyword If    '${national_id}' == 'None'    Supernumber - Input Random ID card
    ...    ELSE    Supernumber - Input ID card     ${national_id}

    Select From List By Value    id=cardExpirationYear     ${expired_year}
    Select From List By Value    id=cardExpirationMonth    ${expired_month}
    Select From List By Value    id=cardExpirationDay      ${expired_day}

    Supernumber - Upload Nation ID file    ${file_name}

    Select From List By Value    id=customerProvince       ${customer_province}
    Sleep    2
    Select From List By Value    id=customerDistrict       ${customer_district}
    Sleep    2
    Select From List By Value    id=customerSubDistrict    ${customer_sub_district}
    Sleep    2
    Select From List By Value    id=customerZipcode        ${customer_zip_code}

    Input Text    id=customerAddress    ${customer_address}
    Input Text    id=customerSection    ${customer_section}
    Input Text    id=customerVillage    ${customer_village}
    Input Text    id=customerRoom       ${customer_room}
    Input Text    id=customerAlley      ${customer_alley}
    Input Text    id=customerRoad       ${customer_road}

Supernumber - Set Shipping Address to be the same as Customer Address
    Wait Until Element Is Visible    xpath=//*[@id="form-registration"]/div/div[3]/div[25]/label    10
    Click Element    xpath=//*[@id="form-registration"]/div/div[3]/div[25]/label

Supernumber - Accept Policy
    Wait Until Element Is Visible    xpath=//*[@id="form-registration"]/div/div[3]/div[38]/div/label    30
    Click Element    xpath=//*[@id="form-registration"]/div/div[3]/div[38]/div/label
    Sleep    3
    Wait Until Element Is Visible    jquery=.mi-tmvh-btn-accept-condition    30
    Click Element    jquery=.mi-tmvh-btn-accept-condition

Supernumber - Submit Register Page
    Wait Until Element Is Visible    id=btn-submit-form-registration    60
    Sleep    2
    Click Button    id=btn-submit-form-registration

Supernumber - Confirm Register
    Wait Until Element Is Visible    xpath=//*[@id="message-success-callback"]/div/div/div/div[2]/div/div/a    60
    Sleep    5
#    Click Button    id=btn-message-success-callback
    Click Element    xpath=//*[@id="message-success-callback"]/div/div/div/div[2]/div/div/a

Supernumber - Verify Error Message on Register Page
#    Page Should Contain     ${phoneModel-error}
#    Page Should Contain     ${simModel-error}
    Page Should Contain     ${title-error}
    Page Should Contain     ${gender-error}
    Page Should Contain     ${firstname-error}
    Page Should Contain     ${lastname-error}
    Page Should Contain     ${groupBirthDate-error}
    Page Should Contain     ${email-error}
    Page Should Contain     ${phoneNumber-error}
    Page Should Contain     ${nationalId-error}
    Page Should Contain     ${groupCardExpirationDate-error}
    Page Should Contain     ${customerProvince-error}
    # Page Should Contain     ${customerDistrict-error}
    # Page Should Contain     ${customerSubDistrict-error}
    # Page Should Contain     ${customerZipcode-error}
    Page Should Contain     ${customerAddress-error}
    Page Should Contain     ${customerRoad-error}
    Page Should Contain     ${billingProvince-error}
    # Page Should Contain     ${billingDistrict-error}
    # Page Should Contain     ${billingSubDistrict-error}
    # Page Should Contain     ${billingZipcode-error}
    Page Should Contain     ${billingAddress-error}
    Page Should Contain     ${billingRoad-error}

Supernumber - Verify No Error Message on Register Page
#    Page Should Not Contain     ${phoneModel-error}
#    Page Should Not Contain     ${simModel-error}
    Page Should Not Contain     ${title-error}
    Page Should Not Contain     ${gender-error}
    Page Should Not Contain     ${firstname-error}
    Page Should Not Contain     ${lastname-error}
    Page Should Not Contain     ${groupBirthDate-error}
    Page Should Not Contain     ${email-error}
    Page Should Not Contain     ${phoneNumber-error}
    Page Should Not Contain     ${nationalId-error}
    Page Should Not Contain     ${groupCardExpirationDate-error}
    Page Should Not Contain     ${customerProvince-error}
    Page Should Not Contain     ${customerDistrict-error}
    Page Should Not Contain     ${customerSubDistrict-error}
    Page Should Not Contain     ${customerZipcode-error}
    Page Should Not Contain     ${customerAddress-error}
    Page Should Not Contain     ${customerRoad-error}
    Page Should Not Contain     ${billingProvince-error}
    Page Should Not Contain     ${billingDistrict-error}
    Page Should Not Contain     ${billingSubDistrict-error}
    Page Should Not Contain     ${billingZipcode-error}
    Page Should Not Contain     ${billingAddress-error}
    Page Should Not Contain     ${billingRoad-error}

Supernumber - Verify Orders Table
    [Arguments]    ${order_id}     ${expect_order_status}=new   ${expect_payment_status}=success
    ${order_data}=     get_order_by_id     ${order_id}
    Should Be Equal AS Strings     ${expect_order_status}         ${order_data[0]}
    Should Be Equal As Strings     ${expect_payment_status}       ${order_data[1]}

Supernumber - Verify Order Shipment Items Table
    [Arguments]    ${order_id}  ${expect_inventory_id}   ${expect_item_status}=verify_pending   ${expect_payment_status}=success
    ${order_shipment_data}=     get_order_shipment_items_by_id       ${order_id}
    Should Be Equal AS Strings     ${expect_inventory_id}         ${order_shipment_data[0]}
    Should Be Equal As Strings     ${expect_item_status}          ${order_shipment_data[1]}
    Should Be Equal As Strings     ${expect_payment_status}       ${order_shipment_data[2]}

Supernumber - Verify Truemoveh Order Verify Table
    [Arguments]    ${order_id}   ${expect_mobile_id}   ${expect_mobile}    ${expect_price_plan_id}     ${expect_bundle_type}=sim  ${expect_merchant_id}=1
    ${truemoveh_order_verify_data}=     get_truemoveh_order_verify_by_pcms_order_id       ${order_id}
    Should Be Equal AS Strings     ${expect_merchant_id}         ${truemoveh_order_verify_data[0]}
    Should Be Equal As Strings     ${expect_mobile_id}           ${truemoveh_order_verify_data[1]}
    Should Be Equal As Strings     ${expect_mobile}              ${truemoveh_order_verify_data[2]}
    Should Be Equal As Strings     ${expect_price_plan_id}       ${truemoveh_order_verify_data[3]}
    Should Be Equal As Strings     ${expect_bundle_type}         ${truemoveh_order_verify_data[4]}

Supernumber - Verify Stock Hold Table
    [Arguments]    ${order_id}  ${expect_status}=temporary
    ${stock_hold_data}=     get_stock_hold_by_order_id       ${order_id}
    ${reformat_create_datetime}=     Convert Date   ${stock_hold_data[1]}   result_format=%d-%m-%Y
    ${reformat_expired_datetime}=    Convert Date   ${stock_hold_data[2]}   result_format=%d-%m-%Y
    Should Be Equal AS Strings     ${reformat_create_datetime}         ${reformat_expired_datetime}
    Should Be Equal AS Strings     ${expect_status}         ${stock_hold_data[0]}

Supernumber - Verify Truemoveh Hold Mobile Log Table
    [Arguments]    ${mobile}  ${expect_status}=permanent
    ${truemoveh_hold_mobile_log_data}=      get_truemoveh_hold_mobile_log_by_mobile     ${mobile}
    ${reformat_create_datetime}=     Convert Date   ${truemoveh_hold_mobile_log_data[2]}    result_format=%d-%m-%Y
    ${reformat_expired_datetime}=    Convert Date   ${truemoveh_hold_mobile_log_data[3]}    result_format=%d-%m-%Y
    Should Be Equal AS Strings     ${reformat_create_datetime}         ${reformat_expired_datetime}
    Should Be Equal AS Strings     ${mobile}         ${truemoveh_hold_mobile_log_data[0]}
    Should Be Equal AS Strings     ${expect_status}         ${truemoveh_hold_mobile_log_data[1]}

Supernumber - Verify Truemoveh Mobiles Table
    [Arguments]    ${mobile}    ${expect_import_lot}    ${expect_zone_id}     ${expect_proposition_id}     ${expect_used}=N    ${expect_status}=Y       ${expect_mobile_type}=4
    ${truemoveh_mobile_data}=      get_truemoveh_mobiles_by_mobile     ${mobile}
    Should Be Equal AS Strings     ${mobile}         ${truemoveh_mobile_data[2]}
    Should Be Equal AS Strings     ${expect_import_lot}         ${truemoveh_mobile_data[0]}
    Should Be Equal AS Strings     ${expect_zone_id}            ${truemoveh_mobile_data[1]}
    Should Be Equal AS Strings     ${expect_mobile_type}        ${truemoveh_mobile_data[3]}
    Should Be Equal AS Strings     ${expect_proposition_id}     ${truemoveh_mobile_data[4]}
    Should Be Equal AS Strings     ${expect_used}               ${truemoveh_mobile_data[5]}
    Should Be Equal AS Strings     ${expect_status}             ${truemoveh_mobile_data[6]}

Supernumber - Login ITM
    [Arguments]    ${Text_Email}    ${Text_Pass}
    Click Element    jquery=.btn-my-profile.last-menu
    Wait Until Element is ready and type    id=login_username    ${Text_Email}    60s
    Wait Until Element is ready and type    id=login_password    ${Text_Pass}    60s
    Wait Until Element is ready and click    id=btn_login    60s
    Wait Until Element Is Not Visible    xpath=//*[@class="ajaxloading-widget-icon-container ng-loading-icn"]    60s

Supernumber - Prepare cart and return redirect redirect_url
    # Example: Supernumber - Input Information on Register Page    ${phone_model}    ${sim_model}    ${birthdate_year}    ${birthdate_month}    ${birthdate_day}
    # ...     ${email}    ${phone_number}    ${national_id}    ${file_name}    ${customer_province}    ${customer_district}
    # ...    ${customer_sub_district}    ${customer_zip_code}    ${customer_address}    ${customer_section}
    # ...    ${customer_village}    ${customer_room}    ${customer_road}
    [Arguments]    ${unique_id}    ${mobile_number}    ${sub_description}    ${description}    ${recommend}
    Clear Prepared Proposition and Price Plan    ${unique_id}    ${unique_id}
    SuperNumber - Delete Data With Import Lot And Company Code    ${unique_id}

    ${proposition_id}    ${price_plan_id}=    Prepare Proposition and Price Plan     ${unique_id}    ${unique_id}    ${sub_description}    ${description}    ${recommend}
    ${expired_date}=    Get Current Date    result_format=datetime    exclude_millis=true    increment=+3days
    SuperNumber - Insert Mobile Number     import_lot=${unique_id}    zone_id=1    mobile=${mobile_number}    mobile_type=4    mobile_pattern_id=1    proposition_id=${proposition_id}    used=N    status=Y    expired_date=${expired_date}
    ${response}=    SuperNumber - Send Api Prepare Cart   2952505724  13eda61450bac36b5a12    ${mobile_number}   ${price_plan_id}
    ${redirect_url_response}=      Get Json Value  ${response}     /data/redirect_url
    ${redirect_url_response} =    Remove String   ${redirect_url_response}    "
    Log To Console    ${redirect_url_response}
    Return From Keyword    ${redirect_url_response}    ${proposition_id}    ${price_plan_id}


Supernumber - Submit Order by Guest
    [Arguments]    ${Text_Email}=supernumber@robot.com
    ...    ${Text_Name}=Supernumber_Robot
    ...    ${Text_Phone}=0956493248
    ...    ${Text_Address}=Test_Address
    ...    ${Text_CWName}=TEST
    ...    ${Text_CWCardNo}=5555555555554444
    ...    ${Text_CWCCV}=111
    Guest Fill Data and Submit Checkout1    ${Text_Email}
    Keywords_Checkout2.Checkout2 - Input Name    ${Text_Name}
    Keywords_Checkout2.Checkout2 - Input Phone    ${Text_Phone}
    Keywords_Checkout2.Checkout2 - Select Province
    Keywords_Checkout2.Checkout2 - Select District
    Keywords_Checkout2.Checkout2 - Select SubDistrict
    Keywords_Checkout2.Checkout2 - Select ZipCode
    Keywords_Checkout2.Checkout2 - Input Address    ${Text_Address}
    Keywords_Checkout2.Checkout2 - Click Next
    Keywords_Checkout3.Checkout3 - Apply CCW    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}
    Keywords_Checkout3.Checkout3 - Click Submit
    Keywords_Checkout3.Checkout3 - Confirm CCW
    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID
    [Return]    ${order_id}

Supernumber - Submit Order by Member
    [Arguments]    ${Text_Email}=thorfortest@gmail.com
    ...    ${Text_Password}=thorthor
    ...    ${Text_CWName}=TEST
    ...    ${Text_CWCardNo}=5555555555554444
    ...    ${Text_CWCCV}=111
    Keywords_Checkout1.Checkout1 - Click Have Member Radio Button
    Keywords_Checkout1.Checkout1 - Input Email    ${Text_Email}
    Keywords_Checkout1.Checkout1 - Input Password    ${Text_Password}
    Keywords_Checkout1.Checkout1 - Click Next
    Keywords_Checkout2.Checkout2 - Click Next Member
    Keywords_Checkout3.Checkout3 - Apply CCW    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}
    Keywords_Checkout3.Checkout3 - Click Submit
    Keywords_Checkout3.Checkout3 - Confirm CCW
    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID
    [Return]    ${order_id}

Supernumber - Submit Order
    [Arguments]    ${Text_CWName}=TEST
    ...    ${Text_CWCardNo}=5555555555554444
    ...    ${Text_CWCCV}=111
    Keywords_Checkout2.Checkout2 - Click Next Member
    Sleep   10
    Keywords_Checkout3.Checkout3 - Apply CCW    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}
    Keywords_Checkout3.Checkout3 - Click Submit
    Keywords_Checkout3.Checkout3 - Confirm CCW
    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID
    [Return]    ${order_id}

Supernumber - Update Max Allow Date In Truemoveh Mobile Number Types
    [Arguments]    ${date_max_allow}    ${name_merchant}
    ${result}=    update_max_allow_date_truemoveh_mobiles_number_types    ${date_max_allow}    ${name_merchant}
    [Return]    ${result}

Supernumber - Get Data Truemoveh Mobile Number Types
    [Arguments]    ${name_merchant}
    ${result}=    get_data_truemoveh_mobile_number_types    ${name_merchant}
    [Return]    ${result}

Supernumber - Verify Message Error Max Allow From Tcc
    [Arguments]    ${message_error}
    Wait Until Element Is Visible    jquery=#message-error-callback-content    20s
    ${link_text}=      Get Text        jquery=#message-error-callback-content
    Should Be Equal    ${link_text}    ${message_error}

Supernumber - Click Button Close Error Message
    Wait Until Element Is Visible    jquery=#btn-message-error-callback    60s
    Sleep    3
    Click Element    jquery=#btn-message-error-callback