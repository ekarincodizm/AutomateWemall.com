*** Settings ***
Library           HttpLibrary.HTTP
Library           ${CURDIR}/../../../../Python_Library/mnp_util.py
Resource          ${CURDIR}/../../../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource          ${CURDIR}/../../../../Keyword/Features/Create_Order/Create_order.txt
Resource          ${CURDIR}/../../../../Keyword/API/PCMS/Product/update_stock.robot
Resource          ${CURDIR}/../../../../Keyword/API/common/api_keywords.robot
# Resource          ${CURDIR}/../../../../Keyword/Features/point_redeemtion/apply_point.robot
Resource          ${CURDIR}/../../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_checkout_1/keywords_checkout1_mobile.robot
Resource          ${CURDIR}/../../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_checkout_2/keywords_checkout2_mobile.robot
Resource          ${CURDIR}/../../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_checkout_3/keywords_checkout3_mobile.robot

*** Keywords ***
API Cart - Add Bundle
	[Arguments]   ${inventory_id}=None
	...     ${inventory_id2}=None
	...     ${customer_ref_id}=None
	...     ${customer_type}=None
	...     ${mobile_id}=None
	...     ${idcard}=None
	...     ${price_plan_id}=None
	...     ${customer_email}=None
	...     ${customer_tel}=None
	...     ${path_json}=None

    Run Keyword If  '${inventory_id}' == 'None'        Return From Keyword  ${EMPTY}
    Run Keyword If  '${inventory_id2}' == 'None'       Return From Keyword  ${EMPTY}
    Run Keyword If  '${customer_ref_id}' == 'None'     Return From Keyword  ${EMPTY}
    Run Keyword If  '${customer_type}' == 'None'       Return From Keyword  ${EMPTY}
    Run Keyword If  '${mobile_id}' == 'None'           Return From Keyword  ${EMPTY}
    Run Keyword If  '${idcard}' == 'None'              Return From Keyword  ${EMPTY}
    Run Keyword If  '${price_plan_id}' == 'None'       Return From Keyword  ${EMPTY}
    ${customer_email}=   Run Keyword If   '${customer_email}' == 'None'   Convert To String   robotautomate@mail.com   ELSE   Convert To String   ${customer_email}
	${customer_tel}=     Run Keyword If   '${customer_tel}' == 'None'     Convert To String   081234500   ELSE   Convert To String   ${customer_tel}
    ${content}=    Get File          ${path_json}    utf-8
    ${content}=    Replace String    ${content}     ^^inventory_id^^        ${inventory_id}
    ${content}=    Replace String    ${content}     ^^inventory_id2^^       ${inventory_id2}
    ${content}=    Replace String    ${content}     ^^customer_ref_id^^     ${customer_ref_id}
    ${content}=    Replace String    ${content}     ^^customer_type^^       ${customer_type}
    ${content}=    Replace String    ${content}     ^^mobile_id^^           ${mobile_id}
    ${content}=    Replace String    ${content}     ^^idcard^^              ${idcard}
    ${content}=    Replace String    ${content}     ^^price_plan_id^^       ${price_plan_id}
    ${content}=    Replace String    ${content}     ^^customer_email^^      ${customer_email}
    ${content}=    Replace String    ${content}     ^^customer_tel^^        ${customer_tel}
    Log To Console                  content-after-replace=${content}
    Log to console                  ${PCMS_API_URL}${truemoveh-registerinfo-save}
	Create Http Context             ${PCMS_API_URL}    http
	Set Request Header              Content-type     application/json
	Set Request Body                ${content}
	Next Request Should Succeed
	HttpLibrary.HTTP.POST           ${truemoveh-registerinfo-save}
	${response}=                    Get Response Body
	Log To Console                  Add Bundle:res_api_add_bundle=${response}
	[return]    ${response}

API Cart - Add Sim
    [Arguments]   ${inventory_id_sim}=None
    ...     ${customer_ref_id}=None
    ...     ${customer_type}=None
    ...     ${mobile_id}=None
    ...     ${idcard}=None
    ...     ${price_plan_id}=None
    ...     ${customer_email}=None
    ...     ${customer_tel}=None
	...     ${path_json}=None

    ${customer_email}=   Run Keyword If   '${customer_email}' == 'None'   Convert To String   robotautomate@mail.com   ELSE   Convert To String   ${customer_email}
	${customer_tel}=     Run Keyword If   '${customer_tel}' == 'None'     Convert To String   081234500   ELSE   Convert To String   ${customer_tel}
    ${content}=    Get File          ${path_json}    utf-8
    ${content}=    Replace String    ${content}     ^^inventory_id_sim^^    ${inventory_id_sim}
    ${content}=    Replace String    ${content}     ^^customer_ref_id^^     ${customer_ref_id}
    ${content}=    Replace String    ${content}     ^^customer_type^^       ${customer_type}
    ${content}=    Replace String    ${content}     ^^mobile_id^^           ${mobile_id}
    ${content}=    Replace String    ${content}     ^^idcard^^              ${idcard}
    ${content}=    Replace String    ${content}     ^^price_plan_id^^       ${price_plan_id}
    ${content}=    Replace String    ${content}     ^^customer_email^^      ${customer_email}
    ${content}=    Replace String    ${content}     ^^customer_tel^^        ${customer_tel}
    Log To Console    content-after-replace=${content}
    Create Http Context             ${PCMS_API_URL}    http
    Set Request Header              Content-type     application/json
    Set Request Body                ${content}
    Next Request Should Succeed
    HttpLibrary.HTTP.POST           ${truemoveh-registerinfo-save}
    ${response}=                    Get Response Body
    Log To Console                  res_api_add_sim=${response}
    [return]    ${response}

API Cart - Add MNP Sim
    [Arguments]   ${inventory_id}=None
    ...     ${customer_ref_id}=None
    ...     ${customer_type}=None
    ...     ${mobile_number}=None
    ...     ${idcard}=None
    ...     ${price_plan_id}=None
    ...     ${mnp_type}=None

    ${idcard}=              Run Keyword If      '${idcard}' == 'None'       Convert To String   3680134424831   ELSE   Convert To String   ${idcard}
    ${mnp_type}=            Run Keyword If      '${mnp_type}' == 'None'     Convert To String   mnp             ELSE   Convert To String   ${mnp_type}
    ${response}=            api_add_mnp_to_cart_v2      ${inventory_id}     ${customer_ref_id}      ${customer_type}        ${mobile_number}        ${idcard}       ${price_plan_id}       ${mnp_type}
    ${code}=                Get From Dictionary         ${response}     code
    Set Test Variable       ${var_resp_add_mnp_response}            ${response}
    Set Test Variable       ${var_resp_add_mnp_code}                ${code}
    [return]    ${response}
    #----- Note: Example ------ #
#    User Login From login page         ${username_login}           ${password_login}
#    Clear Cart Current User
#    API Cart - Add MNP Sim          TRAAA1126711        ${TV_user_id}       ${TV_user_type}     081111111          4410464455153           5       mnp

API Cart - Add MNP Device
    [Arguments]   ${inventory_id}=None
    ...     ${customer_ref_id}=None
    ...     ${customer_type}=None
    ...     ${mobile_number}=None
    ...     ${idcard}=None
    ...     ${price_plan_id}=None
    ...     ${mnp_type}=None

    ${mnp_type}=            Run Keyword If      '${mnp_type}' == 'None'     Convert To String   mnp_device             ELSE   Convert To String   ${mnp_type}
    ${response}=            api_add_mnp_to_cart_v2      ${inventory_id}     ${customer_ref_id}      ${customer_type}        ${mobile_number}        ${idcard}       ${price_plan_id}       ${mnp_type}
    ${code}=                Get From Dictionary         ${response}     code
    Set Test Variable       ${var_resp_add_mnp_response}            ${response}
    Set Test Variable       ${var_resp_add_mnp_code}                ${code}
    [return]    ${response}

API Cart - Add Item

    #[Arguments]
    [Arguments]   ${customer_ref_id}    ${customer_type}    ${inventory_id}    ${qty}=1
    log TO console   add item =xxxxx
    #Log To Console   ${PCMS_API_URL}
    Create Http Context    ${PCMS_API_URL}    http
    # Set Request Header    Content-Type    application/json
    Set Request Body    customer_ref_id=${customer_ref_id}&customer_type=${customer_type}&inventory_id=${inventory_id}&qty=${qty}

    #Next Request Should Succeed
    Stock - Increase Stock By Test Variable   100  ${inventory_id}
    Log to console   API Cart - Add Item URL: ${PCMS_API_URL}/api/v2/45311375168544/cart/add-item
    Log to console   customer_ref_id=${customer_ref_id}
    Log to console   inventory_id=${inventory_id}
    Log to console   pcms_api_url=${PCMS_API_URL}
    HttpLibrary.HTTP.POST    /api/v2/45311375168544/cart/add-item
    ${body}=    Get Response Body
    Log To Console   body=${body}
    #${status}=   Get Json Value   ${body}   /status
    #Should Be Equal As Strings     ${status}    "success"

    Next Request Should Succeed
    HttpLibrary.HTTP.POST    ${add-cart}   #/cart/add-item
    ${body}=    Get Response Body
    ${status}=   Get Json Value   ${body}   /status
    Should Be Equal As Strings     ${status}    "success"

    #Verify Response Status Code and Message    200    ${status}"

API Cart - Remove Single product from Cart
    [Arguments]    ${PCMS_APP_KEY}    ${Customer_Type}    ${Customer_ref_id}    ${inventory_id}
    Create Http Context    ${PCMS_URL_API}    http
    Set Request Body    inventory_id=${inventory_id}&customer_type=${Customer_Type}&customer_ref_id=${Customer_ref_id}
    HttpLibrary.HTTP.POST    ${delete-cart}
    ${body}=    Get Response Body
    ${status}=    Get Response Status
    Should Start With    ${status}    200
    ${response}=   Create Dictionary   status=${status}   body=${body}
    [return]    ${response}

API Cart - Cart Response Should Have Total Item In Cart
    [Arguments]   ${response_body}   ${qty}
    ${cart_details}=   Get Json Value   ${response_body}   /data/cart_details
    ${items_count}=    Get Json Value   ${response_body}   /data/items_count
    ${cart_details_json}=    To Json      ${cart_details}
    ${total_cart_details}=   Get Length   ${cart_details_json}

    Log to console   items_count=${items_count}
    Log to console   total_cart_details=${total_cart_details}

    Should Be Equal As Numbers   ${items_count}          ${qty}
    Should Be Equal As Numbers   ${total_cart_details}   ${qty}

API Cart - Cart Response Should Has Inventory Id
    [Arguments]   ${response_body}   ${inv_id}
    ${cart_details}=   Get Json Value   ${response_body}   /data/cart_details
    Should Contain   ${cart_details}   ${inv_id}
    @{result}=    Run Keyword And Ignore Error   Get Json Value   ${response_body}   /data/cart_details/${inv_id}
    Should Be Equal   'PASS'   '@{result}[0]'

API Cart - Cart Response Should Not Has Inventory Id
    [Arguments]   ${response_body}   ${inv_id}
    ${cart_details}=   Get Json Value   ${response_body}   /data/cart_details
    Should Not Contain   ${cart_details}   ${inv_id}
    @{result}=    Run Keyword And Ignore Error   Get Json Value   ${response_body}   /data/cart_details/${inv_id}
    Should Be Equal   'FAIL'   '@{result}[0]'

API Add Cart
    [Arguments]   ${host}    ${URL}   ${customer_ref_id}    ${customer_type}    ${inventory_id}    ${qty}
    Log to console   in api add cart keyword
    Create Http Context    ${host}    http
    # Set Request Header    Content-Type    application/json
    Set Request Body    customer_ref_id=${customer_ref_id}&customer_type=${customer_type}&inventory_id=${inventory_id}&qty=${qty}
    Next Request Should Succeed
    HttpLibrary.HTTP.POST    ${URL}
    ${body}=    Get Response Body
    # Log To Console   Add Cart Body Response=${body}
    Verify Response Status Code and Message    200    200 OK

API Set Card Data
    [Arguments]   ${host}    ${URL}   ${customer_ref_id}    ${customer_type}    ${creditnum}    ${command}
    Create Http Context    ${host}    http
    # Set Request Header    Content-Type    application/json
    Set Request Body    customer_ref_id=${customer_ref_id}&customer_type=${customer_type}&creditnum=${creditnum}&command=${command}
    Next Request Should Succeed
    HttpLibrary.HTTP.POST    ${URL}
    ${body}=    Get Response Body
    Verify Response Status Code and Message    200    200 OK




Get ACL
    [Arguments]     ${index}
    Go To   ${ITM_URL}/test/user
    Wait Until Element Is Visible   //i[1]
    ${av}=   Get Text   //i[${index}]
    # Log to console   ${av}
    [Return]   ${av}

Get carts
    [Arguments]     ${ref_id}
    Connect DB ITM
    ${total_row}=    Query    SELECT * FROM `carts` where `customer_ref_id` = ${ref_id} And `deleted_at` is NULL
    # Log To Console    test=${total_row_colelction[0][0]}
    [Return]    ${total_row}

Get carts by id
    [Arguments]     ${id}
    Connect DB ITM
    ${total_row}=    Query    SELECT * FROM `carts` where `id` = ${id}
    # Log To Console    test=${total_row_colelction[0][0]}
    [Return]    ${total_row}

Checkout3 - Cancle CCW
    Wait Until Element Is Visible    //*[@class="close-modal confirm-payment-close-btn"]    60s
    Click Element    //*[@class="close-modal confirm-payment-close-btn"]

Checkout2 Click Next Member
    Wait Until Element Is Visible    //*[@class="form-bot-address-active select-address-button-active"]    30s
    Click Element    //*[@class="form-bot-address-active select-address-button-active"]

Member Buy Product with CCW
    [Arguments]    ${Text_Email}    ${Text_Password}    ${ref}    ${inventory_id}=random
    ${Text_Name}    Set Variable    Robot_Name
    ${Text_Phone}    Set Variable    0900000000
    ${Text_Address}    Set Variable    Robot_Address
    ${Text_CWName}    Set Variable    test
    ${Text_CWCardNo}    Set Variable    5555555555554444
    ${Text_CWCCV}    Set Variable    123
    ${inv_id}=    Run Keyword If    'random' == '${inventory_id}'    Get One Inventory ID
    ...    ELSE    Set Variable    ${inventory_id}
    Adjust Stock By inventory_id    ${inv_id}
    ${product_pkey}=    Get Product Pkey    ${inv_id}
    Open Browser    ${ITM_URL}/products/item-${product_pkey}.html    chrome
    Maximize Browser Window
    Level D Choose Product Color
    Level D Click Add To Cart success case
    Sleep    5s
    Keywords_CartLightBox.Next to Checkout 1
    Checkout1 - Click Have Member Radio Button
    Checkout1 - Input Email    ${Text_Email}
    Checkout1 - Input Password    ${Text_Password}
    Checkout1 - Click Next
    Checkout2 Click Next Member
    Wait Until Element Is Visible    //*[@id="ccw-info-name"]    60s
    # ${ref}=  Get ACL    3
    # Go To   ${ITM_URL}/checkout/step3
    Checkout3 - Apply CCW    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}
    ${rs}=    Get carts    ${ref}
    Checkout3 - Click Submit
    Checkout3 - Confirm CCW
    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID For Member
    [Return]    ${order_id}      ${rs}


Member Buy Product Until Checkout3
    [Arguments]    ${Text_Email}    ${Text_Password}    ${ref_id}    ${inventory_id}=random    ${Text_CWCardNo}=4555555555554444
    ${Text_Name}    Set Variable    Robot_Name
    ${Text_Phone}    Set Variable    0900000000
    ${Text_Address}    Set Variable    Robot_Address
    ${Text_CWName}    Set Variable    test
    # ${Text_CWCardNo}    Set Variable    4555555555554444
    ${Text_CWCCV}    Set Variable    123
    ${inv_id}=    Run Keyword If    'random' == '${inventory_id}'    Get One Inventory ID
    ...    ELSE    Set Variable    ${inventory_id}
    Adjust Stock By inventory_id    ${inv_id}
    ${product_pkey}=    Get Product Pkey    ${inv_id}
    Open Browser    ${ITM_URL}/products/item-${product_pkey}.html    chrome
    Maximize Browser Window
    Level D Choose Product Color
    Level D Click Add To Cart success case
    Sleep    5s
    Keywords_CartLightBox.Next to Checkout 1
    Checkout1 - Click Have Member Radio Button
    Checkout1 - Input Email    ${Text_Email}
    Checkout1 - Input Password    ${Text_Password}
    Checkout1 - Click Next
    Checkout2 Click Next Member
    Wait Until Element Is Visible    //*[@id="ccw-info-name"]    60s
    Checkout3 - Apply CCW    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}
    ${rs}=    Get carts    ${ref_id}
    [Return]    ${rs}


Guest Buy Product with CCW
    [Arguments]    ${Text_Email}    ${inventory_id}=random
    ${Text_Name}    Set Variable    Robot_Name
    ${Text_Phone}    Set Variable    0900000000
    ${Text_Address}    Set Variable    Robot_Address
    ${Text_CWName}    Set Variable    test
    ${Text_CWCardNo}    Set Variable    5555555555554444
    ${Text_CWCCV}    Set Variable    123
    ${inv_id}=    Run Keyword If    'random' == '${inventory_id}'    Get One Inventory ID
    ...    ELSE    Set Variable    ${inventory_id}
    Adjust Stock By inventory_id    ${inv_id}
    ${product_pkey}=    Get Product Pkey    ${inv_id}
    Open Browser    ${ITM_URL}/products/item-${product_pkey}.html    chrome
    Maximize Browser Window
    Level D Choose Product Color
    Level D Click Add To Cart success case
    sleep    5
    Keywords_CartLightBox.Next to Checkout 1
    Guest Fill Data and Submit Checkout1    ${Text_Email}
    Checkout2 - Input Name    ${Text_Name}
    Checkout2 - Input Phone    ${Text_Phone}
    Checkout2 - Select Province
    Checkout2 - Select District
    Checkout2 - Select SubDistrict
    Checkout2 - Select ZipCode
    Checkout2 - Input Address    ${Text_Address}
    Checkout2 - Click Next
    ${ref}=  Get ACL    2
    Go To   ${ITM_URL}/checkout/step3
    Checkout3 - Apply CCW    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}
    Checkout3 - Click Submit
    ${rs}=    Get carts    ${ref}
    Checkout3 - Confirm CCW
    ${order_id}=    Wait until Purchase Success Appear and retrieve Order ID
    [Return]    ${order_id}    ${ref}   ${rs}


Guest Buy Product Until Checkout3 Thor
    [Arguments]    ${Text_Email}    ${inventory_id}=random
    ${Text_Name}    Set Variable    Robot_Name
    ${Text_Phone}    Set Variable    0900000000
    ${Text_Address}    Set Variable    Robot_Address
    ${inv_id}=    Run Keyword If    'random' == '${inventory_id}'    Get One Inventory ID
    ...    ELSE    Set Variable    ${inventory_id}
    Open Browser    ${ITM_URL}    chrome
    Maximize Browser Window
    Adjust Stock By inventory_id    ${inv_id}
    ${product_pkey}=    Get Product Pkey    ${inv_id}
    Go To    ${ITM_URL}/products/item-${product_pkey}.html
    Maximize Browser Window
    Level D Choose Product Color
    Level D Click Add To Cart success case
    sleep    5
    Keywords_CartLightBox.Next to Checkout 1
    Guest Fill Data and Submit Checkout1    ${Text_Email}
    Checkout2 - Input Name    ${Text_Name}
    Checkout2 - Input Phone    ${Text_Phone}
    Checkout2 - Select Province
    Checkout2 - Select District
    Checkout2 - Select SubDistrict
    Checkout2 - Select ZipCode
    Checkout2 - Input Address    ${Text_Address}
    Checkout2 - Click Next

Guest Buy Product Until Checkout3 Thor For Mobile
    [Arguments]    ${Text_Email}    ${inventory_id}=random    ${new_browser}=true
    ${Text_Name}    Set Variable    Robot_Name
    ${Text_Phone}    Set Variable    0900000000
    ${Text_Address}    Set Variable    Robot_Address
    ${inv_id}=    Run Keyword If    'random' == '${inventory_id}'    Get One Inventory ID
    ...    ELSE    Set Variable    ${inventory_id}
    Run Keyword IF    'true' == '${new_browser}'    Open Browser    ${ITM_MOBILE_URL}    chrome
    Maximize Browser Window
    Adjust Stock By inventory_id    ${inv_id}
    ${product_pkey}=    Get Product Pkey    ${inv_id}
    Go To    ${ITM_MOBILE_URL}/products/item-${product_pkey}.html
    Maximize Browser Window
    Level D Choose Product Color
    Level D Click Add To Cart success case for mobile
    sleep    5
    Go To    ${ITM_MOBILE_URL}/checkout/step1
    Checkout 1 Mobile - Input Email       ${Text_Email}
    Checkout 1 Mobile - Click Next
    Checkout 2 Mobile - Input Name     ${Text_Name}
    Checkout 2 Mobile - Input Phone    ${Text_Phone}
    Checkout 2 Mobile - Select Province
    Checkout 2 Mobile - Select District
    Checkout 2 Mobile - Select SubDistrict
    Checkout 2 Mobile - Select ZipCode
    Checkout 2 Mobile - Input Address     ${Text_Address}
    Checkout 2 Mobile - Click Next
    Sleep     10s

Guest Buy Multi Product Until Checkout3 Thor For Mobile
    [Arguments]    ${Text_Email}    ${inventory_id}
    ${Text_Name}    Set Variable    Robot_Name
    ${Text_Phone}    Set Variable    0900000000
    ${Text_Address}    Set Variable    Robot_Address
    Open Browser    ${ITM_MOBILE_URL}    chrome
    Add To Cart Multi Inventory For Mobile    ${inventory_id}
    Go To    ${ITM_MOBILE_URL}/checkout/step1
    Checkout 1 Mobile - Input Email       ${Text_Email}
    Checkout 1 Mobile - Click Next
    Checkout 2 Mobile - Input Name     ${Text_Name}
    Checkout 2 Mobile - Input Phone    ${Text_Phone}
    Checkout 2 Mobile - Select Province
    Checkout 2 Mobile - Select District
    Checkout 2 Mobile - Select SubDistrict
    Checkout 2 Mobile - Select ZipCode
    Checkout 2 Mobile - Input Address     ${Text_Address}
    Checkout 2 Mobile - Click Next
    Sleep     10s

Guest Buy Product Until Checkout3
    [Arguments]    ${Text_Email}    ${point}    ${ref_id}    ${inventory_id}=random    ${Text_CWCardNo}=4555555555554444
    ${Text_Name}    Set Variable    Robot_Name
    ${Text_Phone}    Set Variable    0900000000
    ${Text_Address}    Set Variable    Robot_Address
    ${Text_CWName}    Set Variable    test
    # ${Text_CWCardNo}    Set Variable    4555555555554444
    ${Text_CWCCV}    Set Variable    123
    ${inv_id}=    Run Keyword If    'random' == '${inventory_id}'    Get One Inventory ID
    ...    ELSE    Set Variable    ${inventory_id}
    Adjust Stock By inventory_id    ${inv_id}
    ${product_pkey}=    Get Product Pkey    ${inv_id}
    Go To    ${ITM_URL}/products/item-${product_pkey}.html
    # Go To    ${ITM_URL}/products/infothink-avengers-thor-8-gb-2536354175614.html
    Maximize Browser Window
    Level D Choose Product Color
    Level D Click Add To Cart success case
    sleep    5
    Keywords_CartLightBox.Next to Checkout 1
    Guest Fill Data and Submit Checkout1    ${Text_Email}
    Checkout2 - Input Name    ${Text_Name}
    Checkout2 - Input Phone    ${Text_Phone}
    Checkout2 - Select Province
    Checkout2 - Select District
    Checkout2 - Select SubDistrict
    Checkout2 - Select ZipCode
    Checkout2 - Input Address    ${Text_Address}
    Checkout2 - Click Next
    # ${ref}=  Get ACL    2
    # Go To   ${ITM_URL}/checkout/step3
    Checkout3 - Apply CCW    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}
    # Checkout3 - Click Submit
    # Checkout3 - Cancle CCW
    ${rs}=    Get carts    ${ref_id}
    [Return]    ${rs}

API Cart - Expect Cannot Add Mnp
    Should Be Equal As Integers        400         ${var_resp_add_mnp_code}

API Cart - Expect Add Mnp Success
    Should Be Equal As Integers        200         ${var_resp_add_mnp_code}
