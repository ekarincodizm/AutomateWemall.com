*** Settings ***
Library           Collections
Library           DateTime
Resource          ${CURDIR}/../../Resource/Config/${ENV}/env_config.robot
Library           RequestsLibrary
Library           HttpLibrary
Library           Selenium2Library
Library           DatabaseLibrary
Library           String
Resource          WebElement_Common.robot
Library           OperatingSystem
Resource          ${CURDIR}/../../Resource/Config/${ENV}/database.robot    # TC_iTM_01776    # TC_iTM_01777    # TC_iTM_01778    # TC_iTM_01779    # TC_iTM_01796
Library           ${CURDIR}/../../Python_Library/formatnumber.py

*** Keywords ***
Get current epoch time
    ${datetime}=    Get Current Date    result_format=datetime
    Comment    ${current_date}=    Convert Date    ${current_date}    date_format=%d%m%Y%H%M
    Comment    ${current_date}=    Add Time To Date    ${current_date}    ${x} minutes    exclude_millis=true
    Comment    ${epoch_date}=    Convert Date    ${current_date}    result_format=epoch
    [Return]    ${datetime.year}${datetime.month}${datetime.day}${datetime.hour}${datetime.minute}${datetime.second}

Verify return code and return message
    [Arguments]    ${response}    ${return_code}    ${expect_message}
    ${message}=    Get response message    ${response}
    Should Be Equal    ${message.strip()}    ${expect_message.strip()}
    Should Be Equal    ${response.status_code}    ${return_code}

Get response message
    [Arguments]    ${response}
    ${json_obj}    To Json    ${response.text}
    ${message}=    Get From Dictionary    ${json_obj}    message
    [Return]    ${message}

Delete Merchant from PDS by Merchant ID
    [Arguments]    ${UrlMerchantID}
    Comment    ${header}=    Create Dictionary    Content-Type=application/x-www-form-urlencoded    Basic=Zmxhc2g6Rmxhc2gxMjM0
    Comment    ${auth}=    Create List    test    password
    Comment    Create Session    auth    ${Merchant_API_URL}    headers=${header}    auth=${auth}
    Comment    ${resp}=    Post Request    auth    /authen/v1/tokens?grant_type=merchant
    Comment    ${json_obj}    To Json    ${resp.text}
    Comment    ${access_token}    Get From Dictionary    ${json_obj}    access_token
    Comment    ${refresh_token}    Get From Dictionary    ${json_obj}    refresh_token
    ${tokens}=    Get access token
    ${access_token}    Get From List    ${tokens}    0
    ${refresh_token}    Get From List    ${tokens}    1
    ${header}=    Create Dictionary    x-wm-accessToken=${access_token}
    Set To Dictionary    ${header}    x-wm-refreshToken    ${refresh_token}
    Create Session    Http DELETE    ${Merchant_API_URL}    headers=${header}
    ${response}=    Delete Request    Http DELETE    /mch/v1/merchants/${UrlMerchantID}
    Verify return code and return message    ${response}    ${200}    Success
    [Return]    ${response}

Wait Until Element is ready and click
    [Arguments]    ${element}    ${sec_timeout}
    Wait Until Page Contains Element    ${element}    ${sec_timeout}
    Wait Until Element Is Visible    ${element}    ${sec_timeout}
    Wait Until Element Is Enabled    ${element}    ${sec_timeout}
    ${ajaxloadign-background}=    Run Keyword And Return Status    Element Should Be Visible    ${Loading_image}
    Run Keyword If    ${ajaxloadign-background}    Wait Until Element Is Not Visible    ${Loading_image}    60s
    Sleep    2
    Click Element    ${element}

Wait Until Element is ready and type
    [Arguments]    ${element}    ${input_text}    ${sec_timeout}
    Wait Until Page Contains Element    ${element}
    Wait Until Element Is Visible    ${element}    ${sec_timeout}
    Wait Until Element Is Enabled    ${element}    ${sec_timeout}
    Input Text    ${element}    ${input_text}

Wait until checkbox is ready and select
    [Arguments]    ${checkbox_element}    ${sec_timeout}
    Wait Until Element Is Visible    ${checkbox_element}    ${sec_timeout}
    Wait Until Element Is Enabled    ${checkbox_element}    ${sec_timeout}
    ${some_random_element}=    Get Webelement    ${checkbox_element}
    Select Checkbox    ${some_random_element}

Get current date by format
    [Arguments]    ${date format}    ${adjust date}
    [Documentation]    Get current date with specific format (Robot DateTime lib format) with plus adjust date from current date
    ${datetime}=    Get Current Date    result_format=%Y-%m-%d %H:%M:%S.%f
    ${OutputDate}=    Add Time To Date    ${datetime}    ${adjust date}
    ${OutputDate}=    Convert Date    ${OutputDate}=    result_format=${date format}
    [Return]    ${OutputDate}

Get current epoch time short
    ${datetime}=    Get Current Date    result_format=datetime
    [Return]    ${datetime.minute}${datetime.second}

Get current epoch time with microsecond
    ${datetime}=    Get Current Date    result_format=datetime
    [Return]    ${datetime.minute}${datetime.second}${datetime.microsecond}

Get Access Token
    ${header}=    Create Dictionary    Content-Type=application/x-www-form-urlencoded    Basic=Zmxhc2g6Rmxhc2gxMjM0
    ${auth}=    Create List    test    password
    Create Session    auth    ${Merchant_API_URL}    headers=${header}    auth=${auth}
    ${resp}=    Post Request    auth    /authen/v1/tokens?grant_type=merchant
    ${json_obj}    To Json    ${resp.text}
    ${access_token}    Get From Dictionary    ${json_obj}    access_token
    ${refresh_token}    Get From Dictionary    ${json_obj}    refresh_token
    [Return]    ${access_token}    ${refresh_token}

Replace string in WebElelment
    [Arguments]    ${webelelemnt}    ${string}
    ${output}    Replace String    ${webelelemnt}    REPLACE_ME    ${string}
    [Return]    ${output}

Change status to Picked and Packed with Order ID
    [Arguments]    ${order_id}    ${order_shipment_item_id}    ${sap_material_code}    ${material_id}    ${stock_type}=RT
    ${Pick_status}    Set Variable    picked
    ${Pack_status}    Set Variable    packed
    ${json_Picked}=    Create Dictionary    order_id=${order_id}
    Set To Dictionary    ${json_Picked}    order_shipment_item_id    ${order_shipment_item_id}
    Set To Dictionary    ${json_Picked}    item_status    ${Pick_status}
    Set To Dictionary    ${json_Picked}    sap_material_code    ${sap_material_code}
    Set To Dictionary    ${json_Picked}    material_id    ${material_id}
    Set To Dictionary    ${json_Picked}    stock_type    ${stock_type}
    ${json_packed}=    Create Dictionary    order_id=${order_id}
    Set To Dictionary    ${json_packed}    order_shipment_item_id    ${order_shipment_item_id}
    Set To Dictionary    ${json_packed}    item_status    ${Pack_status}
    Set To Dictionary    ${json_packed}    sap_material_code    ${sap_material_code}
    Set To Dictionary    ${json_packed}    material_id    ${material_id}
    Set To Dictionary    ${json_packed}    stock_type    ${stock_type}
    ${json_body}    Create Dictionary
    Set To Dictionary    ${json_body}    \    ${json_Picked}
    Set To Dictionary    ${json_body}    \    ${json_packed}
    ${json_str_body}=    Create List    ${json_body}
    ${response}=    FMS POST api/v4/orders/update-status    ${json_body}
    FMS Verify return code and return message    ${response}    ${200}    success
    ${response}=    To Json    ${response.text}
    ${item_status}=    Get From Dictionary    ${response}    status
    [Return]    ${item_status}

Change status to shipped with Order ID
    [Arguments]    ${order_id}    ${order_shipment_item_id}    ${sap_material_code}    ${material_id}    ${serial_number}=${EMPTY}
    ${item_status}    Set Variable    shipped
    ${json_shipped}=    Create Dictionary    order_id=${order_id}
    Set To Dictionary    ${json_shipped}    order_shipment_item_id    ${order_shipment_item_id}
    Set To Dictionary    ${json_shipped}    item_status    ${item_status}
    Set To Dictionary    ${json_shipped}    sap_material_code    ${sap_material_code}
    Set To Dictionary    ${json_shipped}    material_id    ${material_id}
    Set To Dictionary    ${json_shipped}    logistic_code    E2E_Stagging
    Set To Dictionary    ${json_shipped}    tracking_number    tracking_order_id_${order_shipment_item_id}
    Set To Dictionary    ${json_shipped}    serial_number    ${serial_number}
    ${timestamp}    Get current epoch time
    Set To Dictionary    ${json_shipped}    timestamp_status    ${timestamp}
    ${json_body}=    Create List    ${json_shipped}
    ${response}=    FMS POST api/v4/orders/update-status    ${json_body}
    FMS Verify return code and return message    ${response}    ${200}    success
    ${response}=    To Json    ${response.text}
    ${item_status}=    Get From Dictionary    ${response}    status
    [Return]    ${item_status}

FMS Verify return code and return message
    [Arguments]    ${response}    ${return_code}    ${expect_message}
    ${message}=    FMS Get response message    ${response}
    Should Be Equal    ${message.strip()}    ${expect_message.strip()}
    Should Be Equal    ${response.status_code}    ${return_code}

FMS Get response message
    [Arguments]    ${response}
    ${json_obj}    To Json    ${response.text}
    ${message}=    Get From Dictionary    ${json_obj}    status
    [Return]    ${message}

FMS POST api/v4/orders/update-status
    [Arguments]    ${items}
    ${json_string}=    Evaluate    json.dumps(${items})    json
    ${header}=    Create Dictionary    Content-Type=application/json
    Create Session    Http Post    ${PCMS_URL}
    ${response}=    Post Request    Http Post    api/v4/orders/update-status    ${items}    ${header}
    [Return]    ${response}

Connect DB ITM
    [Documentation]    Parameterized Input, require run argument "-v ENV:${env name}"
    ...
    ...    Actual values are in \Resource\Config\${env name}\database.robot
    Connect To Database    pymysql    ${DB_NAME}    ${DB_USERNAME}    ${DB_PASSWORD}    ${DB_HOSTNAME}    ${DB_PORT}

Get Row Count
    [Arguments]    ${table_id}
    ${row}=    Get Matching XPath Count    //table[@id='${table_id}']/tbody/tr
    Return From Keyword    ${row}

Verify return code and return message1
    [Arguments]    ${response}    ${return_code}    ${expect_message}
    ${message}=    Get response message    ${response}
    Should Be Equal    ${message.strip()}    ${expect_message.strip()}
    Should Be Equal    ${response.status_code}    ${return_code}

Input Text To CKEditor
    [Arguments]    ${ckeditor_locator}    ${content}
    # ${ckeditor_locator}= //div[@id="${ckeditor_id}"]
    Wait Until Element Is Visible    ${ckeditor_locator}${ckeditor_iframe}    20
    Select Frame    ${ckeditor_locator}${ckeditor_iframe}
    Execute JavaScript    document.getElementsByTagName('body')[0].innerHTML = '${content}';
    Unselect Frame

Get Text From CKEditor
    [Arguments]    ${ckeditor_locator}
    # ${ckeditor_locator}= //div[@id="${ckeditor_id}"]
    Wait Until Element Is Visible    ${ckeditor_locator}${ckeditor_iframe}    20
    Select Frame    ${ckeditor_locator}${ckeditor_iframe}
    ${content}=    Get Text    //body
    Unselect Frame
    [Return]    ${content}

Random ID Card
    ${Digit_1}=    Evaluate    random.randint(1, 8)    random
    ${Digit_2}=    Evaluate    random.randint(0, 9)    random
    ${Digit_3}=    Evaluate    random.randint(0, 9)    random
    ${Digit_4}=    Evaluate    random.randint(0, 9)    random
    ${Digit_5}=    Evaluate    random.randint(0, 9)    random
    ${Digit_6}=    Evaluate    random.randint(0, 9)    random
    ${Digit_7}=    Evaluate    random.randint(0, 9)    random
    ${Digit_8}=    Evaluate    random.randint(0, 9)    random
    ${Digit_9}=    Evaluate    random.randint(0, 9)    random
    ${Digit_10}=    Evaluate    random.randint(0, 9)    random
    ${Digit_11}=    Evaluate    random.randint(0, 9)    random
    ${Digit_12}=    Evaluate    random.randint(0, 9)    random
    ${Sum}=    Evaluate    (((${Digit_1}*13)+(${Digit_2}*12)+(${Digit_3}*11)+(${Digit_4}*10)+(${Digit_5}*9)+(${Digit_6}*8)+(${Digit_7}*7)+(${Digit_8}*6)+(${Digit_9}*5)+(${Digit_10}*4)+(${Digit_11}*3)+(${Digit_12}*2))%11)-11
    ${Sum_str}=    Convert To String    ${Sum}
    ${Digit_13}=    Get Substring    ${Sum_str}    -1
    ${ID_Card}=    Evaluate    ${Digit_1}${Digit_2}${Digit_3}${Digit_4}${Digit_5}${Digit_6}${Digit_7}${Digit_8}${Digit_9}${Digit_10}${Digit_11}${Digit_12}${Digit_13}
    [Return]    ${ID_Card}

Expected String Equal
    [Arguments]    ${arg_expected}    ${arg_actual}
    Should Be Equal As Strings    ${arg_expected}    ${arg_actual}

Println
    [Arguments]    ${string}
    Log To Console    ${string}

GetStringFromJson
    [Arguments]    ${json}    ${node}
    ${data}=    Get Json Value    ${json}    ${node}
    ${data}=    Replace String    ${data}    "    ${EMPTY}
    ${data}=    Replace String    ${data}    \\r    ${EMPTY}
    ${data}=    Replace String    ${data}    \\n    ${EMPTY}
    [Return]    ${data}

Exit
    [Arguments]    ${variable}
    Fatal Error    ${variable}

Connect DB PCMS
    [Arguments]    ${DB_NAME}    ${DB_USERNAME}    ${DB_PASSWORD}    ${DB_HOSTNAME}
    Connect To Database    pymysql    ${DB_NAME}    ${DB_USERNAME}    ${DB_PASSWORD}    ${DB_HOSTNAME}    3306

Convert To Uppercase If variable is String
    [Arguments]    ${item}
    ${is_string}    Run Keyword and Return Status    Should Be String    ${item}
    ${upper}=    Run Keyword If    ${is_string}    Convert To Uppercase    ${item}
    ${ret}=    Set Variable If    ${is_string}    ${upper}    ${item}
    Return From Keyword    ${ret}

Strip And Convert To Uppercase If variable is String
    [Arguments]    ${item}
    ${is_string}    Run Keyword and Return Status    Should Be String    ${item}
    ${upper}=    Run Keyword If    ${is_string}    Convert To Uppercase    ${item}
    ${ret}=    Set Variable If    ${is_string}    ${upper}    ${item}
    ${strip}=    Run Keyword If    ${is_string}    Strip String    ${ret}
    Return From Keyword    ${strip}

Get file name from canonical path
    [Arguments]    ${canonical_path}
    ${replaced_string}=    Replace String    ${canonical_path}    \\    /
    ${split_result}=    Split String    ${replaced_string}    /
    ${split_result_length}=    Get Length    ${split_result}
    ${file_name_index}=    Evaluate    ${split_result_length}-1
    Return From Keyword    ${split_result[${file_name_index}]}

Get Date From Today As PCMS Format
    [Arguments]    ${increment}=0 day
    ${result_date}=    Get Current Date    local    ${increment}    timestamp    True
    ${result_date}=    Convert Date    ${result_date}    result_format=%Y-%m-%d
    Return From Keyword    ${result_date}

Formatnumber
    [Arguments]    ${num}    ${digi}=2
    ${num}=    Convert To String    ${num}
    ${str}=    Split String   ${num}    .
    ${Has_digi}=    Get Length   ${str}
    ${add_commas}=   ncomma    ${str[0]}
    ${strdigi}=    Run Keyword If    ${Has_digi} > 1  Set Variable   ${str[1]}0000000000000000000    ELSE    Set Variable    0000000000000000000
    ${dd}=    Get Substring   ${strdigi}    0    ${digi}
    ${number}=    Set Variable    ${add_commas}.${dd}
    [Return]     ${number}

Get Inventory ID
    Connect DB ITM
    ${inv_id}=    query    SELECT variants.inventory_id FROM variants, products, imported_materials, (SELECT product_style_type.product_id, sum(product_style_type.style_type_id) number FROM product_style_type GROUP BY product_style_type.product_id) style WHERE `products`.`id` = `variants`.`product_id` AND variants.deleted_at is null AND variants.status = 'active' AND variants.stock_type = 1 AND products.status = 'publish' AND products.active = 1 AND products.has_variants = 1 AND products.deleted_at is null AND style.product_id = products.id AND style.number = 1 AND variants.inventory_id = imported_materials.inventory_id ORDER BY products.id, variants.id desc
    [Return]    ${inv_id[0][0]}

Scroll Page To Location
    [Arguments]    ${x_location}=0    ${y_location}=3000
    Execute JavaScript    window.scrollTo(${x_location},${y_location})

Convert Tuple To List
    [Arguments]    ${tuple}
    @{result}=    Create List
    ${tuple}    Convert To String    ${tuple}
    @{ids_list}=    Split String    ${tuple}
    : FOR    ${item}    IN    @{ids_list}
    \    ${item}=    Remove String    ${item}    (    )    ,
    \    ...    L
    \    Append to list    ${result}    ${item}
    Return From Keyword    ${result}
