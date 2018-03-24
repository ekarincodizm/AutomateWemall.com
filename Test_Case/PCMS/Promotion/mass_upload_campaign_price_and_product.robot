*** Settings ***
Force Tags    WLS_Promotion
Library           Selenium2Library
Library           Collections
Resource          ${CURDIR}/../../../Resource/Init.robot
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Features/Discount_campaign/crud_everyday_wow.robot
Resource          ${CURDIR}/../../../Keyword/Portal/CAMPS/CAMPS_Common/Keywords_CAMPS_Common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Promotion/keywords_mass_price_product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Promotion/keywords_export_campaign_price_and_product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource          ${CURDIR}/../../../Resource/Config/${env}/env_config.robot
Resource          ${CURDIR}/../../../Resource/TestData/${env}/test_data.robot
Test Setup        Login Pcms
Test Teardown     Run Keywords    Run keyword If    "${camp_name}" != "${EMPTY}"     Login Pcms    AND     Delete campaign - delete by campaign name    ${camp_name}    AND    Close All Browsers

*** Variables ***
${message_success_template}      Mass upload completed. ??row?? row(s) processed.
${message_fail_template}         ??row?? Error(s) found. Please re-check your file and try to upload again.
${status_fail_camp_type}         Campaign type is not allowed.
${status_fail_mass_period_current}          Campaign has already been started.
${status_fail_mass_discount_empty}          Missing Discount Price.
${status_fail_mass_sku_empty}               Missing Inventory Id.
${status_fail_mass_campaign_id_empty}       Missing Campaign Id.
${status_fail_mass_sku_and_discount_empty}    Missing Inventory Id. / Missing Discount Price.
${status_fail_mass_campaign_id_and_discount_empty}    Missing Campaign Id. / Missing Discount Price.
${status_fail_mass_campaign_id_and_sku_empty}    Missing Campaign Id. / Missing Inventory Id.
${status_fail_mass_campaign_id_not_exist}        Invalid Campaign Id.
${status_fail_discount_decimal}    Discount Price must be integer value.
${status_fail_discount_text}       Invalid Discount Price.
${status_fail_discount_zero}       Discount Price must be greater than 0.
${status_fail_mass_row_empty}               Please remove empty row
${status_fail_duplicate_campaign_id_and_sku}     Duplicate Campaign Id and Inventory Id are duplicate with other rows in CSV file.
${status_fail_duplicate_campaignid_sku_and_discount}     Duplicate Campaign Id and Inventory Id are duplicate with other rows in CSV file.

*** Test Cases ***
TC_iTM_03468 User add new sku to campaign - Success
    [Tags]    TC_iTM_03468    ready    regression    phoenix    WLS_High
    ## Prerequisite ##
    #.. Create Discount Campaign
    ${app_name}=    Set Variable    iTruemart
    ${camp_type}=    Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=    Set Variable    percent
    ${start_period}=    Get Date From Today As PCMS Format    1 day
    ${end_period}=    Get Date From Today As PCMS Format    2 day
    ${product_name_list}=    Create List    &{product-disc-1}[name]    &{product-disc-2}[name]
    ${camp_name}=    Set Variable    ${EMPTY}
    ${camp_name}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    199
    @{data_value2}=     Create List     ${camp_id}      &{product-disc-2}[sku]    99
    @{data_value3}=     Create List     ${camp_id}      &{product-disc-4}[sku]    100
    @{data}=            Create List     ${data_name}        ${data_value1}      ${data_value2}      ${data_value3}
    ${discount_value_1}=      Evaluate    &{product-disc-1}[normal_price] - @{data_value1}[2]
    ${discount_value_2}=      Evaluate    &{product-disc-2}[normal_price] - @{data_value2}[2]
    ${discount_value_3}=      Evaluate    &{product-disc-4}[normal_price] - @{data_value3}[2]

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    3

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Verify Upload Result
    Mass Price Product - verify upload result message    ${message_success}
    Mass Price Product - User click back button to mass upload price and product page

    #.. Verify Upload History
    ${display_name_top_bar}=    Get display name in top menu
    ${result_row_from_web}=    Get upload history result from web page    ${filename}    ${display_name_top_bar}

    ${num_all_history}=    All history of mass upload
    Check upload history result with DB    @{result_row_from_web}    ${num_all_history}    ${history_camp_price_prod_db}

    ${username_in_history}=    Set Variable    ${result_row_from_web[1]}
    Check user in history same the user in top menu    ${username_in_history}    ${display_name_top_bar}

    Check all row in history    ${num_all_history}
    Sleep    1s
    Mass Price Product - Delete history record by username after upload success    ${username_in_history}    ${filename}

    #.. Verify Discount Product Table
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click discount product button    ${camp_name}
    Discount campaign - Wait Until Page Contains Discount Product Table

    &{expect_sku_detail_1}=    Create Dictionary    name=&{product-disc-1}[sku_name]
    ...    net_price=&{product-disc-1}[normal_price]
    ...    special_price=&{product-disc-1}[special_price]
    ...    discount_value=${discount_value_1}
    ...    discount_type=price
    ...    price=@{data_value1}[2]

    &{expect_sku_detail_2}=    Create Dictionary    name=&{product-disc-2}[sku_name]
    ...    net_price=&{product-disc-2}[normal_price]
    ...    special_price=&{product-disc-2}[special_price]
    ...    discount_value=${discount_value_2}
    ...    discount_type=price
    ...    price=@{data_value2}[2]

    &{expect_sku_detail_3}=    Create Dictionary    name=&{product-disc-4}[sku_name]
    ...    net_price=&{product-disc-4}[normal_price]
    ...    special_price=&{product-disc-4}[special_price]
    ...    discount_value=${discount_value_3}
    ...    discount_type=price
    ...    price=@{data_value3}[2]

    @{expect_skus_detail}=    Create List    ${expect_sku_detail_1}    ${expect_sku_detail_2}    ${expect_sku_detail_3}
    Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail    ${expect_skus_detail}

TC_iTM_03469 User delete some sku from campaign - Success
    [Tags]    TC_iTM_03469    ready    regression    phoenix    WLS_High
    ## Prerequisite ##
    #.. Create Discount Campaign
    ${app_name}=    Set Variable    iTruemart
    ${camp_type}=    Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=    Set Variable    percent
    ${start_period}=    Get Date From Today As PCMS Format    1 day
    ${end_period}=    Get Date From Today As PCMS Format    2 day
    ${product_name_list}=    Create List    &{product-disc-1}[name]    &{product-disc-2}[name]
    ${camp_name}=    Set Variable    ${EMPTY}
    ${camp_name}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    199

    @{data}=            Create List     ${data_name}        ${data_value1}
    ${discount_value_1}=      Evaluate    &{product-disc-1}[normal_price] - @{data_value1}[2]

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    1

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Verify Upload Result
    Mass Price Product - verify upload result message    ${message_success}
    Mass Price Product - User click back button to mass upload price and product page

    #.. Verify Upload History
    ${display_name_top_bar}=    Get display name in top menu
    ${result_row_from_web}=    Get upload history result from web page    ${filename}    ${display_name_top_bar}

    ${num_all_history}=    All history of mass upload
    Check upload history result with DB    @{result_row_from_web}    ${num_all_history}    ${history_camp_price_prod_db}

    ${username_in_history}=    Set Variable    ${result_row_from_web[1]}
    Check user in history same the user in top menu    ${username_in_history}    ${display_name_top_bar}

    Check all row in history    ${num_all_history}
    Sleep    1s
    Mass Price Product - Delete history record by username after upload success    ${username_in_history}    ${filename}

    #.. Verify Discount Product Table
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click discount product button    ${camp_name}
    Discount campaign - Wait Until Page Contains Discount Product Table

    &{expect_sku_detail_1}=    Create Dictionary    name=&{product-disc-1}[sku_name]
    ...    net_price=&{product-disc-1}[normal_price]
    ...    special_price=&{product-disc-1}[special_price]
    ...    discount_value=${discount_value_1}
    ...    discount_type=price
    ...    price=@{data_value1}[2]

    @{expect_skus_detail}=    Create List    ${expect_sku_detail_1}

    Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail    ${expect_skus_detail}

TC_iTM_03470 User replace all existing sku with new sku in campaign - Success
    [Tags]    Campaign     Mass_upload     regression    ready    phoenix    WLS_High
    ## Prerequisite ##
    #.. Create Discount Campaign
    ${app_name}=    Set Variable    iTruemart
    ${camp_type}=    Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=    Set Variable    percent
    ${start_period}=    Get Date From Today As PCMS Format    1 day
    ${end_period}=    Get Date From Today As PCMS Format    2 day
    ${product_name_list}=    Create List    &{product-disc-1}[name]    &{product-disc-2}[name]
    ${camp_name}=    Set Variable    ${EMPTY}
    ${camp_name}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-3}[sku]    100
    @{data}=            Create List     ${data_name}        ${data_value1}
    ${discount_value_1}=      Evaluate    &{product-disc-3}[normal_price] - @{data_value1}[2]

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    1

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Verify Upload Result
    Mass Price Product - verify upload result message    ${message_success}
    Mass Price Product - User click back button to mass upload price and product page

    #.. Verify Upload History
    ${display_name_top_bar}=    Get display name in top menu
    ${result_row_from_web}=    Get upload history result from web page    ${filename}    ${display_name_top_bar}

    ${num_all_history}=    All history of mass upload
    Check upload history result with DB    @{result_row_from_web}    ${num_all_history}    ${history_camp_price_prod_db}

    ${username_in_history}=    Set Variable    ${result_row_from_web[1]}
    Check user in history same the user in top menu    ${username_in_history}    ${display_name_top_bar}

    Check all row in history    ${num_all_history}
    Sleep    1s
    Mass Price Product - Delete history record by username after upload success    ${username_in_history}    ${filename}

    #.. Verify Discount Product Table
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click discount product button    ${camp_name}
    Discount campaign - Wait Until Page Contains Discount Product Table

    &{expect_sku_detail_1}=    Create Dictionary    name=&{product-disc-3}[sku_name]
    ...    net_price=&{product-disc-3}[normal_price]
    ...    special_price=&{product-disc-3}[special_price]
    ...    discount_value=${discount_value_1}
    ...    discount_type=price
    ...    price=@{data_value1}[2]

    @{expect_skus_detail}=    Create List    ${expect_sku_detail_1}
    Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail    ${expect_skus_detail}

TC_iTM_03471 Mass upload product and campaign price to extra wow (everyday wow) - Fail
    [Tags]    TC_iTM_03471    ready    regression    phoenix    WLS_High
    ## Prerequisite ##
    #.. Create Discount Campaign
    ${app_name}=    Set Variable    iTruemart
    ${camp_type}=    Set Variable    everyday wow
    ${discount_value}=    Set Variable    50
    ${discount_type}=    Set Variable    percent
    ${start_period}=    Get Date From Today As PCMS Format    1 day
    ${end_period}=    Get Date From Today As PCMS Format    2 day
    ${product_name_list}=    Create List    &{product-disc-1}[name]    &{product-disc-2}[name]
    ${camp_name}=    Set Variable    ${EMPTY}
    ${camp_name}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Wow Campaign    ${product_name_list}

    ##.. Upload existing SKUs
    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    199
    @{data_value2}=     Create List     ${camp_id}      &{product-disc-2}[sku]    99
    @{data}=            Create List     ${data_name}        ${data_value1}      ${data_value2}

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}
    ##.. Provide message success with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    2

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Generate failed record(s) in result
    #### [failed row number in csv], [camp_id], [sku_id], [discount_price], [status]
    ${data_value1}=    Create List    2    @{data_value1}    ${status_fail_camp_type}
    ${data_value2}=    Create List    3    @{data_value2}    ${status_fail_camp_type}
    @{result}=        Create List     ${data_value1}      ${data_value2}
    #.. Verify Upload Result
    Mass Price Product - verify fail result    ${message_fail}    ${result}
    Mass Price Product - User click back link to mass upload price and product page

    #.. Verify Upload History -- Not Check

    #.. Verify Discount Product Table
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click discount product button    ${camp_name}
    Discount campaign - Wait Until Page Contains Discount Product Table

    ${discount_value_1}=      Evaluate    (&{product-disc-1}[normal_price]*${discount_value})/100
    ${discount_value_2}=      Evaluate    (&{product-disc-2}[normal_price]*${discount_value})/100

    ${price_1}=    Evaluate    &{product-disc-1}[normal_price]-${discount_value_1}
    ${price_2}=    Evaluate    &{product-disc-2}[normal_price]-${discount_value_2}

    &{expect_sku_detail_1}=    Create Dictionary    name=&{product-disc-1}[sku_name]
    ...    net_price=&{product-disc-1}[normal_price]
    ...    special_price=&{product-disc-1}[special_price]
    ...    discount_value=${discount_value}
    ...    discount_type=percent
    ...    price=${price_1}

    &{expect_sku_detail_2}=    Create Dictionary    name=&{product-disc-2}[sku_name]
    ...    net_price=&{product-disc-2}[normal_price]
    ...    special_price=&{product-disc-2}[special_price]
    ...    discount_value=${discount_value}
    ...    discount_type=percent
    ...    price=${price_2}

    @{expect_skus_detail}=    Create List    ${expect_sku_detail_1}    ${expect_sku_detail_2}
    Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail    ${expect_skus_detail}

    ##.. Upload exisitng and new SKUs
    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    200
    @{data_value2}=     Create List     ${camp_id}      &{product-disc-2}[sku]    100
    @{data_value3}=     Create List     ${camp_id}      &{product-disc-4}[sku]    100
    @{data}=            Create List     ${data_name}        ${data_value1}      ${data_value2}      ${data_value3}

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}
    ##.. Provide message success with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    3

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Generate failed record(s) in result
    #### [failed row number in csv], [camp_id], [sku_id], [discount_price], [status]
    ${data_value1}=    Create List    2    @{data_value1}    ${status_fail_camp_type}
    ${data_value2}=    Create List    3    @{data_value2}    ${status_fail_camp_type}
    ${data_value3}=    Create List    4    @{data_value3}    ${status_fail_camp_type}
    @{result}=        Create List     ${data_value1}      ${data_value2}      ${data_value3}
    #.. Verify Upload Result
    Mass Price Product - verify fail result    ${message_fail}    ${result}
    Mass Price Product - User click back link to mass upload price and product page

    #.. Verify Upload History -- Not Check

    #.. Verify Discount Product Table
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click discount product button    ${camp_name}
    Discount campaign - Wait Until Page Contains Discount Product Table

    ${discount_value_1}=      Evaluate    (&{product-disc-1}[normal_price]*${discount_value})/100
    ${discount_value_2}=      Evaluate    (&{product-disc-2}[normal_price]*${discount_value})/100

    ${price_1}=    Evaluate    &{product-disc-1}[normal_price]-${discount_value_1}
    ${price_2}=    Evaluate    &{product-disc-2}[normal_price]-${discount_value_2}

    &{expect_sku_detail_1}=    Create Dictionary    name=&{product-disc-1}[sku_name]
    ...    net_price=&{product-disc-1}[normal_price]
    ...    special_price=&{product-disc-1}[special_price]
    ...    discount_value=${discount_value}
    ...    discount_type=percent
    ...    price=${price_1}

    &{expect_sku_detail_2}=    Create Dictionary    name=&{product-disc-2}[sku_name]
    ...    net_price=&{product-disc-2}[normal_price]
    ...    special_price=&{product-disc-2}[special_price]
    ...    discount_value=${discount_value}
    ...    discount_type=percent
    ...    price=${price_2}

    @{expect_skus_detail}=    Create List    ${expect_sku_detail_1}    ${expect_sku_detail_2}
    Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail    ${expect_skus_detail}

TC_iTM_03472 Mass upload product and campaign price to wow banner (wow 1 baht) - Fail
    [Tags]    TC_iTM_03472    ready    regression    phoenix    WLS_High
    ## Prerequisite ##
    #.. Create Discount Campaign
    ${app_name}=    Set Variable    iTruemart
    ${camp_type}=    Set Variable    everyday wow 1 bath
    ${discount_value}=    Set Variable    50
    ${discount_type}=    Set Variable    percent
    ${start_period}=    Get Date From Today As PCMS Format    1 day
    ${end_period}=    Get Date From Today As PCMS Format    2 day
    ${product_name_list}=    Create List    &{product-disc-1}[name]    &{product-disc-2}[name]
    ${camp_name}=    Set Variable    ${EMPTY}
    ${camp_name}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Wow Campaign    ${product_name_list}

    ##.. Upload existing SKUs
    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    199
    @{data_value2}=     Create List     ${camp_id}      &{product-disc-2}[sku]    99
    @{data}=            Create List     ${data_name}        ${data_value1}      ${data_value2}

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}
    ##.. Provide message success with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    2

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Generate failed record(s) in result
    #### [failed row number in csv], [camp_id], [sku_id], [discount_price], [status]
    ${data_value1}=    Create List    2    @{data_value1}    ${status_fail_camp_type}
    ${data_value2}=    Create List    3    @{data_value2}    ${status_fail_camp_type}
    @{result}=        Create List     ${data_value1}      ${data_value2}
    #.. Verify Upload Result
    Mass Price Product - verify fail result    ${message_fail}    ${result}
    Mass Price Product - User click back link to mass upload price and product page

    #.. Verify Upload History -- Not Check

    #.. Verify Discount Product Table
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click discount product button    ${camp_name}
    Discount campaign - Wait Until Page Contains Discount Product Table

    ${discount_value_1}=      Evaluate    (&{product-disc-1}[normal_price]*${discount_value})/100
    ${discount_value_2}=      Evaluate    (&{product-disc-2}[normal_price]*${discount_value})/100

    ${price_1}=    Evaluate    &{product-disc-1}[normal_price]-${discount_value_1}
    ${price_2}=    Evaluate    &{product-disc-2}[normal_price]-${discount_value_2}

    &{expect_sku_detail_1}=    Create Dictionary    name=&{product-disc-1}[sku_name]
    ...    net_price=&{product-disc-1}[normal_price]
    ...    special_price=&{product-disc-1}[special_price]
    ...    discount_value=${discount_value}
    ...    discount_type=percent
    ...    price=${price_1}

    &{expect_sku_detail_2}=    Create Dictionary    name=&{product-disc-2}[sku_name]
    ...    net_price=&{product-disc-2}[normal_price]
    ...    special_price=&{product-disc-2}[special_price]
    ...    discount_value=${discount_value}
    ...    discount_type=percent
    ...    price=${price_2}

    @{expect_skus_detail}=    Create List    ${expect_sku_detail_1}    ${expect_sku_detail_2}
    Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail    ${expect_skus_detail}

    ##.. Upload exisitng and new SKUs
    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    200
    @{data_value2}=     Create List     ${camp_id}      &{product-disc-2}[sku]    100
    @{data_value3}=     Create List     ${camp_id}      &{product-disc-4}[sku]    100
    @{data}=            Create List     ${data_name}        ${data_value1}      ${data_value2}      ${data_value3}

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}
    ##.. Provide message success with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    3

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Generate failed record(s) in result
    #### [failed row number in csv], [camp_id], [sku_id], [discount_price], [status]
    ${data_value1}=    Create List    2    @{data_value1}    ${status_fail_camp_type}
    ${data_value2}=    Create List    3    @{data_value2}    ${status_fail_camp_type}
    ${data_value3}=    Create List    4    @{data_value3}    ${status_fail_camp_type}
    @{result}=        Create List     ${data_value1}      ${data_value2}      ${data_value3}
    #.. Verify Upload Result
    Mass Price Product - verify fail result    ${message_fail}    ${result}
    Mass Price Product - User click back link to mass upload price and product page

    #.. Verify Upload History -- Not Check

    #.. Verify Discount Product Table
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click discount product button    ${camp_name}
    Discount campaign - Wait Until Page Contains Discount Product Table

    ${discount_value_1}=      Evaluate    (&{product-disc-1}[normal_price]*${discount_value})/100
    ${discount_value_2}=      Evaluate    (&{product-disc-2}[normal_price]*${discount_value})/100

    ${price_1}=    Evaluate    &{product-disc-1}[normal_price]-${discount_value_1}
    ${price_2}=    Evaluate    &{product-disc-2}[normal_price]-${discount_value_2}

    &{expect_sku_detail_1}=    Create Dictionary    name=&{product-disc-1}[sku_name]
    ...    net_price=&{product-disc-1}[normal_price]
    ...    special_price=&{product-disc-1}[special_price]
    ...    discount_value=${discount_value}
    ...    discount_type=percent
    ...    price=${price_1}

    &{expect_sku_detail_2}=    Create Dictionary    name=&{product-disc-2}[sku_name]
    ...    net_price=&{product-disc-2}[normal_price]
    ...    special_price=&{product-disc-2}[special_price]
    ...    discount_value=${discount_value}
    ...    discount_type=percent
    ...    price=${price_2}

    @{expect_skus_detail}=    Create List    ${expect_sku_detail_1}    ${expect_sku_detail_2}
    Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail    ${expect_skus_detail}

TC_iTM_03473 Campaign price of extra wow (line tmvh) is updated - Success
    [Tags]    TC_iTM_03473    Campaign     Mass_upload     regression    ready    phoenix    WLS_High
    ## Prerequisite ##
    #.. Create Discount Campaign
    ${app_name}=    Set Variable    iTruemart
    ${camp_type}=    Set Variable    discount(line truemoveH)
    ${discount_value}=    Set Variable    50
    ${discount_type}=    Set Variable    percent
    ${start_period}=    Get Date From Today As PCMS Format    1 day
    ${end_period}=    Get Date From Today As PCMS Format    2 day
    ${product_name_list}=    Create List    &{product-disc-1}[name]    &{product-disc-2}[name]
    ${camp_name}=    Set Variable    ${EMPTY}
    ${camp_name}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    ##.. Upload existing SKUs
    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    199
    @{data_value2}=     Create List     ${camp_id}      &{product-disc-2}[sku]    99
    @{data}=            Create List     ${data_name}        ${data_value1}    ${data_value2}
    ${discount_value_1}=      Evaluate    &{product-disc-1}[normal_price] - @{data_value1}[2]
    ${discount_value_2}=      Evaluate    &{product-disc-2}[normal_price] - @{data_value2}[2]

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    2

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Verify Upload Result
    Mass Price Product - verify upload result message    ${message_success}
    Mass Price Product - User click back button to mass upload price and product page

    #.. Verify Upload History
    ${display_name_top_bar}=    Get display name in top menu
    ${result_row_from_web}=    Get upload history result from web page    ${filename}    ${display_name_top_bar}

    ${num_all_history}=    All history of mass upload
    Check upload history result with DB    @{result_row_from_web}    ${num_all_history}    ${history_camp_price_prod_db}

    ${username_in_history}=    Set Variable    ${result_row_from_web[1]}
    Check user in history same the user in top menu    ${username_in_history}    ${display_name_top_bar}

    Check all row in history    ${num_all_history}
    Sleep    1s
    Mass Price Product - Delete history record by username after upload success    ${username_in_history}    ${filename}

    #.. Verify Discount Product Table
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click discount product button    ${camp_name}
    Discount campaign - Wait Until Page Contains Discount Product Table

    &{expect_sku_detail_1}=    Create Dictionary    name=&{product-disc-1}[sku_name]
    ...    net_price=&{product-disc-1}[normal_price]
    ...    special_price=&{product-disc-1}[special_price]
    ...    discount_value=${discount_value_1}
    ...    discount_type=price
    ...    price=@{data_value1}[2]

    &{expect_sku_detail_2}=    Create Dictionary    name=&{product-disc-2}[sku_name]
    ...    net_price=&{product-disc-2}[normal_price]
    ...    special_price=&{product-disc-2}[special_price]
    ...    discount_value=${discount_value_2}
    ...    discount_type=price
    ...    price=@{data_value2}[2]

    @{expect_skus_detail}=    Create List    ${expect_sku_detail_1}    ${expect_sku_detail_2}
    Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail    ${expect_skus_detail}

    ##.. Upload exisitng and new SKUs
    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    200
    @{data_value2}=     Create List     ${camp_id}      &{product-disc-2}[sku]    100
    @{data_value3}=     Create List     ${camp_id}      &{product-disc-4}[sku]    100
    @{data}=            Create List     ${data_name}        ${data_value1}    ${data_value2}    ${data_value3}
    ${discount_value_1}=      Evaluate    &{product-disc-1}[normal_price] - @{data_value1}[2]
    ${discount_value_2}=      Evaluate    &{product-disc-2}[normal_price] - @{data_value2}[2]
    ${discount_value_3}=      Evaluate    &{product-disc-4}[normal_price] - @{data_value3}[2]

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    3

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Verify Upload Result
    Mass Price Product - verify upload result message    ${message_success}
    Mass Price Product - User click back button to mass upload price and product page

    #.. Verify Upload History
    ${display_name_top_bar}=    Get display name in top menu
    ${result_row_from_web}=    Get upload history result from web page    ${filename}    ${display_name_top_bar}

    ${num_all_history}=    All history of mass upload
    Check upload history result with DB    @{result_row_from_web}    ${num_all_history}    ${history_camp_price_prod_db}

    ${username_in_history}=    Set Variable    ${result_row_from_web[1]}
    Check user in history same the user in top menu    ${username_in_history}    ${display_name_top_bar}

    Check all row in history    ${num_all_history}
    Sleep    1s
    Mass Price Product - Delete history record by username after upload success    ${username_in_history}    ${filename}

    #.. Verify Discount Product Table
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click discount product button    ${camp_name}
    Discount campaign - Wait Until Page Contains Discount Product Table

    &{expect_sku_detail_1}=    Create Dictionary    name=&{product-disc-1}[sku_name]
    ...    net_price=&{product-disc-1}[normal_price]
    ...    special_price=&{product-disc-1}[special_price]
    ...    discount_value=${discount_value_1}
    ...    discount_type=price
    ...    price=@{data_value1}[2]

    &{expect_sku_detail_2}=    Create Dictionary    name=&{product-disc-2}[sku_name]
    ...    net_price=&{product-disc-2}[normal_price]
    ...    special_price=&{product-disc-2}[special_price]
    ...    discount_value=${discount_value_2}
    ...    discount_type=price
    ...    price=@{data_value2}[2]

    &{expect_sku_detail_3}=    Create Dictionary    name=&{product-disc-4}[sku_name]
    ...    net_price=&{product-disc-4}[normal_price]
    ...    special_price=&{product-disc-4}[special_price]
    ...    discount_value=${discount_value_3}
    ...    discount_type=price
    ...    price=@{data_value3}[2]

    @{expect_skus_detail}=    Create List    ${expect_sku_detail_1}    ${expect_sku_detail_2}    ${expect_sku_detail_3}
    Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail    ${expect_skus_detail}

    #change period to current
    ${start_period}=    Get Date From Today As PCMS Format
    ${end_period}=    Get Date From Today As PCMS Format    1 day
    Edit campaign - period    ${camp_name}    ${start_period}    ${end_period}

    ${product_name_pkey_1}=    Set Variable    &{product-disc-1}[name]-&{product-disc-1}[pkey]
    ${percent_1}=    Evaluate    int((&{product-disc-1}[normal_price]-@{data_value1}[2])*100/&{product-disc-1}[normal_price])
    &{expected_price_1}    Create Dictionary    name_pkey=${product_name_pkey_1}    normal=&{product-disc-1}[normal_price]
    ...    special=@{data_value1}[2]    discount_percent=${percent_1}

    ${product_name_pkey_2}=    Set Variable    &{product-disc-4}[name]-&{product-disc-4}[pkey]
    ${percent_2}=    Evaluate    int((&{product-disc-4}[normal_price]-@{data_value3}[2])*100/&{product-disc-4}[normal_price])
    &{expected_price_2}    Create Dictionary    name_pkey=${product_name_pkey_2}    normal=&{product-disc-4}[normal_price]
    ...    special=@{data_value3}[2]    discount_percent=${percent_2}

    @{expected_prices}=    Create List    ${expected_price_1}    ${expected_price_2}
    : For    ${item}    IN    @{expected_prices}
    \    ${normal}    ${special}    ${percent}=    Get Product Price Detail From Level D    &{item}[name_pkey]
    \    Should Be Equal    '${normal}'     '&{item}[normal]'
    \    Should Be Equal    '${special}'    '&{item}[special]'
    \    Should Be Equal    '${percent}'    '&{item}[discount_percent]'

TC_iTM_03474 Campaign price of extra wow (line true you) is updated - Success
    [Tags]    TC_iTM_03474    Campaign     Mass_upload     regression    ready    phoenix    WLS_High
    ## Prerequisite ##
    #.. Create Discount Campaign
    ${app_name}=    Set Variable    iTruemart
    ${camp_type}=    Set Variable    discount(line true you)
    ${discount_value}=    Set Variable    50
    ${discount_type}=    Set Variable    percent
    ${start_period}=    Get Date From Today As PCMS Format    1 day
    ${end_period}=    Get Date From Today As PCMS Format    2 day
    ${product_name_list}=    Create List    &{product-disc-1}[name]    &{product-disc-2}[name]
    ${camp_name}=    Set Variable    ${EMPTY}
    ${camp_name}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    ##.. Upload exisitng SKUs
    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    199
    @{data_value2}=     Create List     ${camp_id}      &{product-disc-2}[sku]    99
    @{data}=            Create List     ${data_name}        ${data_value1}    ${data_value2}
    ${discount_value_1}=      Evaluate    &{product-disc-1}[normal_price] - @{data_value1}[2]
    ${discount_value_2}=      Evaluate    &{product-disc-2}[normal_price] - @{data_value2}[2]

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    2

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Verify Upload Result
    Mass Price Product - verify upload result message    ${message_success}
    Mass Price Product - User click back button to mass upload price and product page

    #.. Verify Upload History
    ${display_name_top_bar}=    Get display name in top menu
    ${result_row_from_web}=    Get upload history result from web page    ${filename}    ${display_name_top_bar}

    ${num_all_history}=    All history of mass upload
    Check upload history result with DB    @{result_row_from_web}    ${num_all_history}    ${history_camp_price_prod_db}

    ${username_in_history}=    Set Variable    ${result_row_from_web[1]}
    Check user in history same the user in top menu    ${username_in_history}    ${display_name_top_bar}

    Check all row in history    ${num_all_history}
    Sleep    1s
    Mass Price Product - Delete history record by username after upload success    ${username_in_history}    ${filename}

    #.. Verify Discount Product Table
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click discount product button    ${camp_name}
    Discount campaign - Wait Until Page Contains Discount Product Table

    &{expect_sku_detail_1}=    Create Dictionary    name=&{product-disc-1}[sku_name]
    ...    net_price=&{product-disc-1}[normal_price]
    ...    special_price=&{product-disc-1}[special_price]
    ...    discount_value=${discount_value_1}
    ...    discount_type=price
    ...    price=@{data_value1}[2]

    &{expect_sku_detail_2}=    Create Dictionary    name=&{product-disc-2}[sku_name]
    ...    net_price=&{product-disc-2}[normal_price]
    ...    special_price=&{product-disc-2}[special_price]
    ...    discount_value=${discount_value_2}
    ...    discount_type=price
    ...    price=@{data_value2}[2]

    @{expect_skus_detail}=    Create List    ${expect_sku_detail_1}    ${expect_sku_detail_2}
    Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail    ${expect_skus_detail}

    ##.. Upload exisitng and new SKUs
    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    200
    @{data_value2}=     Create List     ${camp_id}      &{product-disc-2}[sku]    100
    @{data_value3}=     Create List     ${camp_id}      &{product-disc-4}[sku]    100
    @{data}=            Create List     ${data_name}        ${data_value1}    ${data_value2}    ${data_value3}
    ${discount_value_1}=      Evaluate    &{product-disc-1}[normal_price] - @{data_value1}[2]
    ${discount_value_2}=      Evaluate    &{product-disc-2}[normal_price] - @{data_value2}[2]
    ${discount_value_3}=      Evaluate    &{product-disc-4}[normal_price] - @{data_value3}[2]

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    3

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Verify Upload Result
    Mass Price Product - verify upload result message    ${message_success}
    Mass Price Product - User click back button to mass upload price and product page

    #.. Verify Upload History
    ${display_name_top_bar}=    Get display name in top menu
    ${result_row_from_web}=    Get upload history result from web page    ${filename}    ${display_name_top_bar}

    ${num_all_history}=    All history of mass upload
    Check upload history result with DB    @{result_row_from_web}    ${num_all_history}    ${history_camp_price_prod_db}

    ${username_in_history}=    Set Variable    ${result_row_from_web[1]}
    Check user in history same the user in top menu    ${username_in_history}    ${display_name_top_bar}

    Check all row in history    ${num_all_history}
    Sleep    1s
    Mass Price Product - Delete history record by username after upload success    ${username_in_history}    ${filename}

    #.. Verify Discount Product Table
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click discount product button    ${camp_name}
    Discount campaign - Wait Until Page Contains Discount Product Table

    &{expect_sku_detail_1}=    Create Dictionary    name=&{product-disc-1}[sku_name]
    ...    net_price=&{product-disc-1}[normal_price]
    ...    special_price=&{product-disc-1}[special_price]
    ...    discount_value=${discount_value_1}
    ...    discount_type=price
    ...    price=@{data_value1}[2]

    &{expect_sku_detail_2}=    Create Dictionary    name=&{product-disc-2}[sku_name]
    ...    net_price=&{product-disc-2}[normal_price]
    ...    special_price=&{product-disc-2}[special_price]
    ...    discount_value=${discount_value_2}
    ...    discount_type=price
    ...    price=@{data_value2}[2]

    &{expect_sku_detail_3}=    Create Dictionary    name=&{product-disc-4}[sku_name]
    ...    net_price=&{product-disc-4}[normal_price]
    ...    special_price=&{product-disc-4}[special_price]
    ...    discount_value=${discount_value_3}
    ...    discount_type=price
    ...    price=@{data_value3}[2]

    @{expect_skus_detail}=    Create List    ${expect_sku_detail_1}    ${expect_sku_detail_2}    ${expect_sku_detail_3}
    Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail    ${expect_skus_detail}

    #change period to current
    ${start_period}=    Get Date From Today As PCMS Format
    ${end_period}=    Get Date From Today As PCMS Format    1 day
    Edit campaign - period    ${camp_name}    ${start_period}    ${end_period}

    ${product_name_pkey_1}=    Set Variable    &{product-disc-1}[name]-&{product-disc-1}[pkey]
    ${percent_1}=    Evaluate    int((&{product-disc-1}[normal_price]-@{data_value1}[2])*100/&{product-disc-1}[normal_price])
    &{expected_price_1}    Create Dictionary    name_pkey=${product_name_pkey_1}    normal=&{product-disc-1}[normal_price]
    ...    special=@{data_value1}[2]    discount_percent=${percent_1}

    ${product_name_pkey_2}=    Set Variable    &{product-disc-4}[name]-&{product-disc-4}[pkey]
    ${percent_2}=    Evaluate    int((&{product-disc-4}[normal_price]-@{data_value3}[2])*100/&{product-disc-4}[normal_price])
    &{expected_price_2}    Create Dictionary    name_pkey=${product_name_pkey_2}    normal=&{product-disc-4}[normal_price]
    ...    special=@{data_value3}[2]    discount_percent=${percent_2}

    @{expected_prices}=    Create List    ${expected_price_1}    ${expected_price_2}
    : For    ${item}    IN    @{expected_prices}
    \    ${normal}    ${special}    ${percent}=    Get Product Price Detail From Level D    &{item}[name_pkey]
    \    Should Be Equal    '${normal}'    '&{item}[normal]'
    \    Should Be Equal    '${special}'    '&{item}[special]'
    \    Should Be Equal    '${percent}'    '&{item}[discount_percent]'

TC_iTM_03475 Campaign price of extra wow (line tmvh) is updated - Success
    [Tags]    TC_iTM_03475    Campaign     Mass_upload     regression    ready    phoenix    WLS_High
    ## Prerequisite ##
    #.. Create Discount Campaign
    ${app_name}=    Set Variable    iTruemart
    ${camp_type}=    Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=    Set Variable    percent
    ${start_period}=    Get Date From Today As PCMS Format    1 day
    ${end_period}=    Get Date From Today As PCMS Format    2 day
    ${product_name_list}=    Create List    &{product-disc-1}[name]    &{product-disc-2}[name]
    ${camp_name}=    Set Variable    ${EMPTY}
    ${camp_name}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    ##.. Upload exisitng SKUs
    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    199
    @{data_value2}=     Create List     ${camp_id}      &{product-disc-2}[sku]    99
    @{data}=            Create List     ${data_name}        ${data_value1}    ${data_value2}
    ${discount_value_1}=      Evaluate    &{product-disc-1}[normal_price] - @{data_value1}[2]
    ${discount_value_2}=      Evaluate    &{product-disc-2}[normal_price] - @{data_value2}[2]

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    2

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Verify Upload Result
    Mass Price Product - verify upload result message    ${message_success}
    Mass Price Product - User click back button to mass upload price and product page

    #.. Verify Upload History
    ${display_name_top_bar}=    Get display name in top menu
    ${result_row_from_web}=    Get upload history result from web page    ${filename}    ${display_name_top_bar}

    ${num_all_history}=    All history of mass upload
    Check upload history result with DB    @{result_row_from_web}    ${num_all_history}    ${history_camp_price_prod_db}

    ${username_in_history}=    Set Variable    ${result_row_from_web[1]}
    Check user in history same the user in top menu    ${username_in_history}    ${display_name_top_bar}

    Check all row in history    ${num_all_history}
    Sleep    1s
    Mass Price Product - Delete history record by username after upload success    ${username_in_history}    ${filename}

    #.. Verify Discount Product Table
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click discount product button    ${camp_name}
    Discount campaign - Wait Until Page Contains Discount Product Table

    &{expect_sku_detail_1}=    Create Dictionary    name=&{product-disc-1}[sku_name]
    ...    net_price=&{product-disc-1}[normal_price]
    ...    special_price=&{product-disc-1}[special_price]
    ...    discount_value=${discount_value_1}
    ...    discount_type=price
    ...    price=@{data_value1}[2]

    &{expect_sku_detail_2}=    Create Dictionary    name=&{product-disc-2}[sku_name]
    ...    net_price=&{product-disc-2}[normal_price]
    ...    special_price=&{product-disc-2}[special_price]
    ...    discount_value=${discount_value_2}
    ...    discount_type=price
    ...    price=@{data_value2}[2]

    @{expect_skus_detail}=    Create List    ${expect_sku_detail_1}    ${expect_sku_detail_2}
    Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail    ${expect_skus_detail}

    ##.. Upload exisitng and new SKUs
    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    200
    @{data_value2}=     Create List     ${camp_id}      &{product-disc-2}[sku]    100
    @{data_value3}=     Create List     ${camp_id}      &{product-disc-4}[sku]    100
    @{data}=            Create List     ${data_name}        ${data_value1}    ${data_value2}    ${data_value3}
    ${discount_value_1}=      Evaluate    &{product-disc-1}[normal_price] - @{data_value1}[2]
    ${discount_value_2}=      Evaluate    &{product-disc-2}[normal_price] - @{data_value2}[2]
    ${discount_value_3}=      Evaluate    &{product-disc-4}[normal_price] - @{data_value3}[2]

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    3

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Verify Upload Result
    Mass Price Product - verify upload result message    ${message_success}
    Mass Price Product - User click back button to mass upload price and product page

    #.. Verify Upload History
    ${display_name_top_bar}=    Get display name in top menu
    ${result_row_from_web}=    Get upload history result from web page    ${filename}    ${display_name_top_bar}

    ${num_all_history}=    All history of mass upload
    Check upload history result with DB    @{result_row_from_web}    ${num_all_history}    ${history_camp_price_prod_db}

    ${username_in_history}=    Set Variable    ${result_row_from_web[1]}
    Check user in history same the user in top menu    ${username_in_history}    ${display_name_top_bar}

    Check all row in history    ${num_all_history}
    Sleep    1s
    Mass Price Product - Delete history record by username after upload success    ${username_in_history}    ${filename}

    #.. Verify Discount Product Table
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click discount product button    ${camp_name}
    Discount campaign - Wait Until Page Contains Discount Product Table

    &{expect_sku_detail_1}=    Create Dictionary    name=&{product-disc-1}[sku_name]
    ...    net_price=&{product-disc-1}[normal_price]
    ...    special_price=&{product-disc-1}[special_price]
    ...    discount_value=${discount_value_1}
    ...    discount_type=price
    ...    price=@{data_value1}[2]

    &{expect_sku_detail_2}=    Create Dictionary    name=&{product-disc-2}[sku_name]
    ...    net_price=&{product-disc-2}[normal_price]
    ...    special_price=&{product-disc-2}[special_price]
    ...    discount_value=${discount_value_2}
    ...    discount_type=price
    ...    price=@{data_value2}[2]

    &{expect_sku_detail_3}=    Create Dictionary    name=&{product-disc-4}[sku_name]
    ...    net_price=&{product-disc-4}[normal_price]
    ...    special_price=&{product-disc-4}[special_price]
    ...    discount_value=${discount_value_3}
    ...    discount_type=price
    ...    price=@{data_value3}[2]

    @{expect_skus_detail}=    Create List    ${expect_sku_detail_1}    ${expect_sku_detail_2}    ${expect_sku_detail_3}
    Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail    ${expect_skus_detail}

    #change period to current
    ${start_period}=    Get Date From Today As PCMS Format
    ${end_period}=    Get Date From Today As PCMS Format    1 day
    Edit campaign - period    ${camp_name}    ${start_period}    ${end_period}

    ${product_name_pkey_1}=    Set Variable    &{product-disc-1}[name]-&{product-disc-1}[pkey]
    ${percent_1}=    Evaluate    int((&{product-disc-1}[normal_price]-@{data_value1}[2])*100/&{product-disc-1}[normal_price])
    &{expected_price_1}    Create Dictionary    name_pkey=${product_name_pkey_1}    normal=&{product-disc-1}[normal_price]
    ...    special=@{data_value1}[2]    discount_percent=${percent_1}

    ${product_name_pkey_2}=    Set Variable    &{product-disc-4}[name]-&{product-disc-4}[pkey]
    ${percent_2}=    Evaluate    int((&{product-disc-4}[normal_price]-@{data_value3}[2])*100/&{product-disc-4}[normal_price])
    &{expected_price_2}    Create Dictionary    name_pkey=${product_name_pkey_2}    normal=&{product-disc-4}[normal_price]
    ...    special=@{data_value3}[2]    discount_percent=${percent_2}

    @{expected_prices}=    Create List    ${expected_price_1}    ${expected_price_2}
    : For    ${item}    IN    @{expected_prices}
    \    ${normal}    ${special}    ${percent}=    Get Product Price Detail From Level D    &{item}[name_pkey]
    \    Should Be Equal    '${normal}'    '&{item}[normal]'
    \    Should Be Equal    '${special}'    '&{item}[special]'
    \    Should Be Equal    '${percent}'    '&{item}[discount_percent]'

TC_iTM_03476 Mass upload product and price to campaign that its period is future - Success
    [Tags]    TC_iTM_03476    Campaign     Mass_upload     regression    ready    phoenix    WLS_Medium
    ## Prerequisite ##
    #.. Create Discount Campaign
    ${app_name}=    Set Variable    iTruemart
    ${camp_type}=    Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=    Set Variable    percent
    ${start_period}=    Get Date From Today As PCMS Format    1 day
    ${end_period}=    Get Date From Today As PCMS Format    2 day
    ${product_name_list}=    Create List    &{product-disc-1}[name]    &{product-disc-2}[name]
    ${camp_name}=    Set Variable    ${EMPTY}
    ${camp_name}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    ##.. Upload exisitng and new SKUs
    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    199
    @{data_value2}=     Create List     ${camp_id}      &{product-disc-2}[sku]    99
    @{data}=            Create List     ${data_name}        ${data_value1}    ${data_value2}
    ${discount_value_1}=      Evaluate    &{product-disc-1}[normal_price] - @{data_value1}[2]
    ${discount_value_2}=      Evaluate    &{product-disc-2}[normal_price] - @{data_value2}[2]

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    2

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Verify Upload Result
    Mass Price Product - verify upload result message    ${message_success}
    Mass Price Product - User click back button to mass upload price and product page

    #.. Verify Upload History
    ${display_name_top_bar}=    Get display name in top menu
    ${result_row_from_web}=    Get upload history result from web page    ${filename}    ${display_name_top_bar}

    ${num_all_history}=    All history of mass upload
    Check upload history result with DB    @{result_row_from_web}    ${num_all_history}    ${history_camp_price_prod_db}

    ${username_in_history}=    Set Variable    ${result_row_from_web[1]}
    Check user in history same the user in top menu    ${username_in_history}    ${display_name_top_bar}

    Check all row in history    ${num_all_history}
    Sleep    1s
    Mass Price Product - Delete history record by username after upload success    ${username_in_history}    ${filename}

    #.. Verify Discount Product Table
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click discount product button    ${camp_name}
    Discount campaign - Wait Until Page Contains Discount Product Table

    &{expect_sku_detail_1}=    Create Dictionary    name=&{product-disc-1}[sku_name]
    ...    net_price=&{product-disc-1}[normal_price]
    ...    special_price=&{product-disc-1}[special_price]
    ...    discount_value=${discount_value_1}
    ...    discount_type=price
    ...    price=@{data_value1}[2]

    &{expect_sku_detail_2}=    Create Dictionary    name=&{product-disc-2}[sku_name]
    ...    net_price=&{product-disc-2}[normal_price]
    ...    special_price=&{product-disc-2}[special_price]
    ...    discount_value=${discount_value_2}
    ...    discount_type=price
    ...    price=@{data_value2}[2]

    @{expect_skus_detail}=    Create List    ${expect_sku_detail_1}    ${expect_sku_detail_2}
    Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail    ${expect_skus_detail}

    ##.. Upload exisitng and new SKUs
    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    200
    @{data_value2}=     Create List     ${camp_id}      &{product-disc-2}[sku]    100
    @{data_value3}=     Create List     ${camp_id}      &{product-disc-4}[sku]    100
    @{data}=            Create List     ${data_name}        ${data_value1}    ${data_value2}    ${data_value3}
    ${discount_value_1}=      Evaluate    &{product-disc-1}[normal_price] - @{data_value1}[2]
    ${discount_value_2}=      Evaluate    &{product-disc-2}[normal_price] - @{data_value2}[2]
    ${discount_value_3}=      Evaluate    &{product-disc-4}[normal_price] - @{data_value3}[2]

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    3

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Verify Upload Result
    Mass Price Product - verify upload result message    ${message_success}
    Mass Price Product - User click back button to mass upload price and product page

    #.. Verify Upload History
    ${display_name_top_bar}=    Get display name in top menu
    ${result_row_from_web}=    Get upload history result from web page    ${filename}    ${display_name_top_bar}

    ${num_all_history}=    All history of mass upload
    Check upload history result with DB    @{result_row_from_web}    ${num_all_history}    ${history_camp_price_prod_db}

    ${username_in_history}=    Set Variable    ${result_row_from_web[1]}
    Check user in history same the user in top menu    ${username_in_history}    ${display_name_top_bar}

    Check all row in history    ${num_all_history}
    Sleep    1s
    Mass Price Product - Delete history record by username after upload success    ${username_in_history}    ${filename}

    #.. Verify Discount Product Table
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click discount product button    ${camp_name}
    Discount campaign - Wait Until Page Contains Discount Product Table

    &{expect_sku_detail_1}=    Create Dictionary    name=&{product-disc-1}[sku_name]
    ...    net_price=&{product-disc-1}[normal_price]
    ...    special_price=&{product-disc-1}[special_price]
    ...    discount_value=${discount_value_1}
    ...    discount_type=price
    ...    price=@{data_value1}[2]

    &{expect_sku_detail_2}=    Create Dictionary    name=&{product-disc-2}[sku_name]
    ...    net_price=&{product-disc-2}[normal_price]
    ...    special_price=&{product-disc-2}[special_price]
    ...    discount_value=${discount_value_2}
    ...    discount_type=price
    ...    price=@{data_value2}[2]

    &{expect_sku_detail_3}=    Create Dictionary    name=&{product-disc-4}[sku_name]
    ...    net_price=&{product-disc-4}[normal_price]
    ...    special_price=&{product-disc-4}[special_price]
    ...    discount_value=${discount_value_3}
    ...    discount_type=price
    ...    price=@{data_value3}[2]

    @{expect_skus_detail}=    Create List    ${expect_sku_detail_1}    ${expect_sku_detail_2}    ${expect_sku_detail_3}
    Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail    ${expect_skus_detail}

TC_iTM_03477 Mass upload to product and price to campaign that is its period is current - Fail
    [Tags]    TC_iTM_03477    ready    regression    phoenix    WLS_Medium
    ## Prerequisite ##
    #.. Create Discount Campaign
    ${app_name}=    Set Variable    iTruemart
    ${camp_type}=    Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=    Set Variable    percent
    ${start_period}=    Get Date From Today As PCMS Format    -1 day
    ${end_period}=    Get Date From Today As PCMS Format    1 day
    ${product_name_list}=    Create List    &{product-disc-1}[name]    &{product-disc-2}[name]
    ${camp_name}=    Set Variable    ${EMPTY}
    ${camp_name}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    ##.. Upload exisitng SKUs
    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    199
    @{data_value2}=     Create List     ${camp_id}      &{product-disc-2}[sku]    99
    @{data}=            Create List     ${data_name}    ${data_value1}    ${data_value2}

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    2

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Generate failed record(s) in result
    #### [failed row number in csv], [camp_id], [sku_id], [discount_price], [status]
    ${data_value1}=    Create List    2    @{data_value1}    ${status_fail_mass_period_current}
    ${data_value2}=    Create List    3    @{data_value2}    ${status_fail_mass_period_current}
    @{result}=        Create List     ${data_value1}     ${data_value2}
    #.. Verify Upload Result
    Mass Price Product - verify fail result    ${message_fail}    ${result}
    Mass Price Product - User click back link to mass upload price and product page

    #.. Verify Upload History -- Not Check

    #.. Verify Discount Product Table
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click discount product button    ${camp_name}
    Discount campaign - Wait Until Page Contains Discount Product Table

    ${discount_value_1}=      Evaluate    (&{product-disc-1}[normal_price]*${discount_value})/100
    ${discount_value_2}=      Evaluate    (&{product-disc-2}[normal_price]*${discount_value})/100

    ${price_1}=    Evaluate    &{product-disc-1}[normal_price]-${discount_value_1}
    ${price_2}=    Evaluate    &{product-disc-2}[normal_price]-${discount_value_2}

    &{expect_sku_detail_1}=    Create Dictionary    name=&{product-disc-1}[sku_name]
    ...    net_price=&{product-disc-1}[normal_price]
    ...    special_price=&{product-disc-1}[special_price]
    ...    discount_value=${discount_value}
    ...    discount_type=percent
    ...    price=${price_1}

    &{expect_sku_detail_2}=    Create Dictionary    name=&{product-disc-2}[sku_name]
    ...    net_price=&{product-disc-2}[normal_price]
    ...    special_price=&{product-disc-2}[special_price]
    ...    discount_value=${discount_value}
    ...    discount_type=percent
    ...    price=${price_2}
    @{expect_skus_detail}=    Create List    ${expect_sku_detail_1}    ${expect_sku_detail_2}
    Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail    ${expect_skus_detail}

    ##.. Upload exisitng and new SKUs
    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    199
    @{data_value2}=     Create List     ${camp_id}      &{product-disc-2}[sku]    99
    @{data_value3}=     Create List     ${camp_id}      &{product-disc-3}[sku]    100
    @{data}=            Create List     ${data_name}    ${data_value1}    ${data_value2}    ${data_value3}

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    3

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Generate failed record(s) in result
    #### [failed row number in csv], [camp_id], [sku_id], [discount_price], [status]
    ${data_value1}=    Create List    2    @{data_value1}    ${status_fail_mass_period_current}
    ${data_value2}=    Create List    3    @{data_value2}    ${status_fail_mass_period_current}
    ${data_value3}=    Create List    4    @{data_value3}    ${status_fail_mass_period_current}
    @{result}=        Create List     ${data_value1}     ${data_value2}     ${data_value3}
    #.. Verify Upload Result
    Mass Price Product - verify fail result    ${message_fail}    ${result}
    Mass Price Product - User click back link to mass upload price and product page

    #.. Verify Upload History -- Not Check

    #.. Verify Discount Product Table
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click discount product button    ${camp_name}
    Discount campaign - Wait Until Page Contains Discount Product Table

    ${discount_value_1}=      Evaluate    (&{product-disc-1}[normal_price]*${discount_value})/100
    ${discount_value_2}=      Evaluate    (&{product-disc-2}[normal_price]*${discount_value})/100
    # ${discount_value_3}=      Evaluate    (&{product-disc-3}[normal_price]*${discount_value})/100

    ${price_1}=    Evaluate    &{product-disc-1}[normal_price]-${discount_value_1}
    ${price_2}=    Evaluate    &{product-disc-2}[normal_price]-${discount_value_2}
    # ${price_3}=    Evaluate    &{product-disc-3}[normal_price]-${discount_value_3}

    &{expect_sku_detail_1}=    Create Dictionary    name=&{product-disc-1}[sku_name]
    ...    net_price=&{product-disc-1}[normal_price]
    ...    special_price=&{product-disc-1}[special_price]
    ...    discount_value=${discount_value}
    ...    discount_type=percent
    ...    price=${price_1}

    &{expect_sku_detail_2}=    Create Dictionary    name=&{product-disc-2}[sku_name]
    ...    net_price=&{product-disc-2}[normal_price]
    ...    special_price=&{product-disc-2}[special_price]
    ...    discount_value=${discount_value}
    ...    discount_type=percent
    ...    price=${price_2}

    # &{expect_sku_detail_3}=    Create Dictionary    name=&{product-disc-3}[sku_name]
    # ...    net_price=&{product-disc-3}[normal_price]
    # ...    special_price=&{product-disc-3}[special_price]
    # ...    discount_value=${discount_value}
    # ...    discount_type=percent
    # ...    price=${price_3}

    @{expect_skus_detail}=    Create List    ${expect_sku_detail_1}    ${expect_sku_detail_2}
    Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail    ${expect_skus_detail}

TC_iTM_03478 Mass upload product and price to campaign that its period is past - Success
    [Tags]    TC_iTM_03478    ready    regression    phoenix    WLS_Medium
    ## Prerequisite ##
    #.. Create Discount Campaign
    ${app_name}=    Set Variable    iTruemart
    ${camp_type}=    Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=    Set Variable    percent
    ${start_period}=    Get Date From Today As PCMS Format    -10 day
    ${end_period}=    Get Date From Today As PCMS Format    -9 day
    ${product_name_list}=    Create List    &{product-disc-1}[name]    &{product-disc-2}[name]
    ${camp_name}=    Set Variable    ${EMPTY}
    ${camp_name}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    ##.. Upload exisitng SKUs
    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    199
    @{data_value2}=     Create List     ${camp_id}      &{product-disc-2}[sku]    99
    @{data}=            Create List     ${data_name}        ${data_value1}      ${data_value2}
    ${discount_value_1}=      Evaluate    &{product-disc-1}[normal_price] - @{data_value1}[2]
    ${discount_value_2}=      Evaluate    &{product-disc-2}[normal_price] - @{data_value2}[2]

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    2

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Verify Upload Result
    Mass Price Product - verify upload result message    ${message_success}
    Mass Price Product - User click back button to mass upload price and product page

    #.. Verify Upload History
    ${display_name_top_bar}=    Get display name in top menu
    ${result_row_from_web}=    Get upload history result from web page    ${filename}    ${display_name_top_bar}

    ${num_all_history}=    All history of mass upload
    Check upload history result with DB    @{result_row_from_web}    ${num_all_history}    ${history_camp_price_prod_db}

    ${username_in_history}=    Set Variable    ${result_row_from_web[1]}
    Check user in history same the user in top menu    ${username_in_history}    ${display_name_top_bar}

    Check all row in history    ${num_all_history}
    Sleep    1s
    Mass Price Product - Delete history record by username after upload success    ${username_in_history}    ${filename}

    #.. Verify Discount Product Table
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click discount product button    ${camp_name}
    Discount campaign - Wait Until Page Contains Discount Product Table

    &{expect_sku_detail_1}=    Create Dictionary    name=&{product-disc-1}[sku_name]
    ...    net_price=&{product-disc-1}[normal_price]
    ...    special_price=&{product-disc-1}[special_price]
    ...    discount_value=${discount_value_1}
    ...    discount_type=price
    ...    price=@{data_value1}[2]

    &{expect_sku_detail_2}=    Create Dictionary    name=&{product-disc-2}[sku_name]
    ...    net_price=&{product-disc-2}[normal_price]
    ...    special_price=&{product-disc-2}[special_price]
    ...    discount_value=${discount_value_2}
    ...    discount_type=price
    ...    price=@{data_value2}[2]

    @{expect_skus_detail}=    Create List    ${expect_sku_detail_1}    ${expect_sku_detail_2}
    Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail    ${expect_skus_detail}

    ##.. Upload exisitng and new SKUs
    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    200
    @{data_value2}=     Create List     ${camp_id}      &{product-disc-2}[sku]    100
    @{data_value3}=     Create List     ${camp_id}      &{product-disc-4}[sku]    100
    @{data}=            Create List     ${data_name}        ${data_value1}      ${data_value2}      ${data_value3}
    ${discount_value_1}=      Evaluate    &{product-disc-1}[normal_price] - @{data_value1}[2]
    ${discount_value_2}=      Evaluate    &{product-disc-2}[normal_price] - @{data_value2}[2]
    ${discount_value_3}=      Evaluate    &{product-disc-4}[normal_price] - @{data_value3}[2]

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    3

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Verify Upload Result
    Mass Price Product - verify upload result message    ${message_success}
    Mass Price Product - User click back button to mass upload price and product page

    #.. Verify Upload History
    ${display_name_top_bar}=    Get display name in top menu
    ${result_row_from_web}=    Get upload history result from web page    ${filename}    ${display_name_top_bar}

    ${num_all_history}=    All history of mass upload
    Check upload history result with DB    @{result_row_from_web}    ${num_all_history}    ${history_camp_price_prod_db}

    ${username_in_history}=    Set Variable    ${result_row_from_web[1]}
    Check user in history same the user in top menu    ${username_in_history}    ${display_name_top_bar}

    Check all row in history    ${num_all_history}
    Sleep    1s
    Mass Price Product - Delete history record by username after upload success    ${username_in_history}    ${filename}

    #.. Verify Discount Product Table
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click discount product button    ${camp_name}
    Discount campaign - Wait Until Page Contains Discount Product Table

    &{expect_sku_detail_1}=    Create Dictionary    name=&{product-disc-1}[sku_name]
    ...    net_price=&{product-disc-1}[normal_price]
    ...    special_price=&{product-disc-1}[special_price]
    ...    discount_value=${discount_value_1}
    ...    discount_type=price
    ...    price=@{data_value1}[2]

    &{expect_sku_detail_2}=    Create Dictionary    name=&{product-disc-2}[sku_name]
    ...    net_price=&{product-disc-2}[normal_price]
    ...    special_price=&{product-disc-2}[special_price]
    ...    discount_value=${discount_value_2}
    ...    discount_type=price
    ...    price=@{data_value2}[2]

    &{expect_sku_detail_3}=    Create Dictionary    name=&{product-disc-4}[sku_name]
    ...    net_price=&{product-disc-4}[normal_price]
    ...    special_price=&{product-disc-4}[special_price]
    ...    discount_value=${discount_value_3}
    ...    discount_type=price
    ...    price=@{data_value3}[2]

    @{expect_skus_detail}=    Create List    ${expect_sku_detail_1}    ${expect_sku_detail_2}    ${expect_sku_detail_3}
    Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail    ${expect_skus_detail}

TC_iTM_03479 mass upload campaign Price & Product to single campaign via mass upload Campaign ID, SKU and Campaign Price - Success
    [Tags]    TC_iTM_03479    ready    regression    phoenix    WLS_Low
    ## Prerequisite ##
    #.. Create Discount Campaign
    ${app_name}=    Set Variable    iTruemart
    ${camp_type}=    Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=    Set Variable    percent
    ${start_period}=    Get Date From Today As PCMS Format    1 day
    ${end_period}=    Get Date From Today As PCMS Format    2 day
    ${product_name_list}=    Create List    &{product-disc-1}[name]
    ${camp_name}=    Set Variable    ${EMPTY}
    ${camp_name}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    20
    @{data}=            Create List     ${data_name}        ${data_value1}
    ${discount_value_1}=      Evaluate    &{product-disc-1}[normal_price] - @{data_value1}[2]

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    1

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Verify Upload Result
    Mass Price Product - verify upload result message    ${message_success}
    Mass Price Product - User click back button to mass upload price and product page

    #.. Verify Upload History
    ${display_name_top_bar}=    Get display name in top menu
    ${result_row_from_web}=    Get upload history result from web page    ${filename}    ${display_name_top_bar}

    ${num_all_history}=    All history of mass upload
    Check upload history result with DB    @{result_row_from_web}    ${num_all_history}    ${history_camp_price_prod_db}

    ${username_in_history}=    Set Variable    ${result_row_from_web[1]}
    Check user in history same the user in top menu    ${username_in_history}    ${display_name_top_bar}

    Check all row in history    ${num_all_history}
    Sleep    1s
    Mass Price Product - Delete history record by username after upload success    ${username_in_history}    ${filename}

    #.. Verify Discount Product Table
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click discount product button    ${camp_name}
    Discount campaign - Wait Until Page Contains Discount Product Table

    &{expect_sku_detail_1}=    Create Dictionary    name=&{product-disc-1}[sku_name]
    ...    net_price=&{product-disc-1}[normal_price]
    ...    special_price=&{product-disc-1}[special_price]
    ...    discount_value=${discount_value_1}
    ...    discount_type=price
    ...    price=@{data_value1}[2]

    @{expect_skus_detail}=    Create List    ${expect_sku_detail_1}
    Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail    ${expect_skus_detail}

TC_iTM_03480 mass upload campaign Price & Product to multiple campaigns via mass upload Campaign ID, SKU and Campaign Price - Success
    [Tags]    TC_iTM_03480    ready    regression    phoenix    WLS_Low
    #.. Create Discount Campaign
    #.. Create campaign 1
    ${app_name}=    Set Variable    iTruemart
    ${camp_type}=    Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=    Set Variable    percent
    ${start_period}=    Get Date From Today As PCMS Format    1 day
    ${end_period}=    Get Date From Today As PCMS Format    2 day
    ${product_name_list}=    Create List    &{product-disc-1}[name]
    ${camp_name1}=    Set Variable    ${EMPTY}
    ${camp_name1}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id1}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name1}
    Discount campaign - Select Products to Campaign    ${product_name_list}
    Edit campaign - code and name and description    ${camp_name1}    TEST_CAMP_1
    ${camp_name1}=    Set Variable    TEST_CAMP_1
    #.. Create campaign 2
    ${app_name}=    Set Variable    iTruemart
    ${camp_type}=    Set Variable    discount(line true you)
    ${discount_value}=    Set Variable    50
    ${discount_type}=    Set Variable    percent
    ${start_period}=    Get Date From Today As PCMS Format    3 day
    ${end_period}=    Get Date From Today As PCMS Format    4 day
    ${product_name_list}=    Create List    &{product-disc-2}[name]
    ${camp_name2}=    Set Variable    ${EMPTY}
    ${camp_name2}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id2}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name2}
    Discount campaign - Select Products to Campaign    ${product_name_list}
    Edit campaign - code and name and description    ${camp_name2}    TEST_CAMP_2
    ${camp_name2}=    Set Variable    TEST_CAMP_2
    #.. Create campaign 3
    ${app_name}=    Set Variable    iTruemart
    ${camp_type}=    Set Variable    discount(line truemoveH)
    ${discount_value}=    Set Variable    50
    ${discount_type}=    Set Variable    percent
    ${start_period}=    Get Date From Today As PCMS Format    5 day
    ${end_period}=    Get Date From Today As PCMS Format    6 day
    ${product_name_list}=    Create List    &{product-disc-3}[name]
    ${camp_name3}=    Set Variable    ${EMPTY}
    ${camp_name3}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id3}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name3}
    Discount campaign - Select Products to Campaign    ${product_name_list}
    Edit campaign - code and name and description    ${camp_name3}    TEST_CAMP_3
    ${camp_name3}=    Set Variable    TEST_CAMP_3

    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id1}      &{product-disc-1}[sku]    10
    @{data_value2}=     Create List     ${camp_id2}      &{product-disc-2}[sku]    20
    @{data_value3}=     Create List     ${camp_id3}      &{product-disc-3}[sku]    30
    @{data}=            Create List     ${data_name}        ${data_value1}      ${data_value2}      ${data_value3}
    ${discount_value_1}=      Evaluate    &{product-disc-1}[normal_price] - @{data_value1}[2]
    ${discount_value_2}=      Evaluate    &{product-disc-2}[normal_price] - @{data_value2}[2]
    ${discount_value_3}=      Evaluate    &{product-disc-3}[normal_price] - @{data_value3}[2]

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    3

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}
    Mass Price Product - verify upload result message    ${message_success}
    Mass Price Product - User click back button to mass upload price and product page

    #.. Verify Discount Product Table
    #.... verify campaign 1
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click discount product button    ${camp_name1}
    Discount campaign - Wait Until Page Contains Discount Product Table

    &{expect_sku_detail_1}=    Create Dictionary    name=&{product-disc-1}[sku_name]
    ...    net_price=&{product-disc-1}[normal_price]
    ...    special_price=&{product-disc-1}[special_price]
    ...    discount_value=${discount_value_1}
    ...    discount_type=price
    ...    price=@{data_value1}[2]

    @{expect_skus_detail}=    Create List    ${expect_sku_detail_1}
    Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail    ${expect_skus_detail}

    #.... verify campaign 2
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click discount product button    ${camp_name2}
    Discount campaign - Wait Until Page Contains Discount Product Table

    &{expect_sku_detail_2}=    Create Dictionary    name=&{product-disc-2}[sku_name]
    ...    net_price=&{product-disc-2}[normal_price]
    ...    special_price=&{product-disc-2}[special_price]
    ...    discount_value=${discount_value_2}
    ...    discount_type=price
    ...    price=@{data_value2}[2]

    @{expect_skus_detail}=    Create List    ${expect_sku_detail_2}
    Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail    ${expect_skus_detail}

    #.... verify campaign 3
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click discount product button    ${camp_name3}
    Discount campaign - Wait Until Page Contains Discount Product Table

    &{expect_sku_detail_3}=    Create Dictionary    name=&{product-disc-3}[sku_name]
    ...    net_price=&{product-disc-3}[normal_price]
    ...    special_price=&{product-disc-3}[special_price]
    ...    discount_value=${discount_value_3}
    ...    discount_type=price
    ...    price=@{data_value3}[2]

    @{expect_skus_detail}=    Create List    ${expect_sku_detail_3}
    Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail    ${expect_skus_detail}

    [Teardown]    Run Keywords    Run keyword If    "${camp_name1}" != "${EMPTY}"    Delete campaign - delete by campaign name    ${camp_name1}
    ...    AND    Run keyword If    "${camp_name2}" != "${EMPTY}"    Delete campaign - delete by campaign name    ${camp_name2}
    ...    AND    Run keyword If    "${camp_name3}" != "${EMPTY}"    Delete campaign - delete by campaign name    ${camp_name3}
    ...    AND    Close All Browsers

TC_iTM_03481 duplication record(campaign ID/sku/Discount price) - Fail
    [Tags]    TC_iTM_03481    ready    regression    phoenix    WLS_High
    ## Prerequisite ##
    #.. Create Discount Campaign
    ${app_name}=    Set Variable    iTruemart
    ${camp_type}=    Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=    Set Variable    percent
    ${start_period}=    Get Date From Today As PCMS Format    1 day
    ${end_period}=    Get Date From Today As PCMS Format    2 day
    ${product_name_list}=    Create List    &{product-disc-1}[name]
    ${camp_name}=    Set Variable    ${EMPTY}
    ${camp_name}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    20
    @{data_value2}=     Create List     ${camp_id}      &{product-disc-1}[sku]    20
    @{data}=            Create List     ${data_name}        ${data_value1}      ${data_value2}

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    2

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Generate failed record(s) in result
    #### [failed row number in csv], [camp_id], [sku_id], [discount_price], [status]
    ${data_value1}=    Create List    2    @{data_value1}    ${status_fail_duplicate_campaignid_sku_and_discount}
    ${data_value2}=    Create List    3    @{data_value2}    ${status_fail_duplicate_campaignid_sku_and_discount}

    @{result}=        Create List     ${data_value1}     ${data_value2}
    #.. Verify Upload Result
    Mass Price Product - verify fail result    ${message_fail}    ${result}

TC_iTM_03482 not input Discount price - Fail
    [Tags]    TC_iTM_03482    ready    regression    phoenix    WLS_Low
    ## Prerequisite ##
    #.. Create Discount Campaign
    ${app_name}=    Set Variable    iTruemart
    ${camp_type}=    Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=    Set Variable    percent
    ${start_period}=    Get Date From Today As PCMS Format    1 day
    ${end_period}=    Get Date From Today As PCMS Format    2 day
    ${product_name_list}=    Create List    &{product-disc-1}[name]
    ${camp_name}=    Set Variable    ${EMPTY}
    ${camp_name}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    ${EMPTY}
    @{data}=            Create List     ${data_name}        ${data_value1}

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    1

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Generate failed record(s) in result
    #### [failed row number in csv], [camp_id], [sku_id], [discount_price], [status]
    ${data_value1}=    Create List    2    @{data_value1}    ${status_fail_mass_discount_empty}
    @{result}=        Create List     ${data_value1}
    #.. Verify Upload Result
    Mass Price Product - verify fail result    ${message_fail}    ${result}

TC_iTM_03483 not input SKU - Fail
    [Tags]    TC_iTM_03483    ready    regression    phoenix    WLS_Low
    ## Prerequisite ##
    #.. Create Discount Campaign
    ${app_name}=    Set Variable    iTruemart
    ${camp_type}=    Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=    Set Variable    percent
    ${start_period}=    Get Date From Today As PCMS Format    1 day
    ${end_period}=    Get Date From Today As PCMS Format    2 day
    ${product_name_list}=    Create List    &{product-disc-1}[name]
    ${camp_name}=    Set Variable    ${EMPTY}
    ${camp_name}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    20
    @{data_value2}=     Create List     ${camp_id}      &{product-disc-2}[sku]    20
    @{data_value3}=     Create List     ${camp_id}      ${EMPTY}                  20
    @{data}=            Create List     ${data_name}        ${data_value1}    ${data_value2}    ${data_value3}

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    1

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Generate failed record(s) in result
    #### [failed row number in csv], [camp_id], [sku_id], [discount_price], [status]
    ${data_value3}=    Create List    4    @{data_value3}    ${status_fail_mass_sku_empty}
    @{result}=        Create List     ${data_value3}
    #.. Verify Upload Result
    Mass Price Product - verify fail result    ${message_fail}    ${result}

TC_iTM_03484 not input Campaign ID - Fail
    [Tags]    TC_iTM_03484    ready    regression    phoenix    WLS_Low
    ## Prerequisite ##
    #.. Create Discount Campaign
    ${app_name}=    Set Variable    iTruemart
    ${camp_type}=    Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=    Set Variable    percent
    ${start_period}=    Get Date From Today As PCMS Format    1 day
    ${end_period}=    Get Date From Today As PCMS Format    2 day
    ${product_name_list}=    Create List    &{product-disc-1}[name]
    ${camp_name}=    Set Variable    ${EMPTY}
    ${camp_name}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${EMPTY}       ,&{product-disc-1}[sku]     20
    @{data_value2}=     Create List     ${camp_id}     &{product-disc-2}[sku]     20
    @{data_value3}=     Create List     ${camp_id}     &{product-disc-3}[sku]     20
    @{data}=            Create List     ${data_name}     ${data_value1}    ${data_value2}    ${data_value3}

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    1

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Generate failed record(s) in result
    #### [failed row number in csv], [camp_id], [sku_id], [discount_price], [status]
    ${data_value1}=    Create List    2    ${EMPTY}    &{product-disc-1}[sku]    20    ${status_fail_mass_campaign_id_empty}
    @{result}=        Create List     ${data_value1}
    #.. Verify Upload Result
    Mass Price Product - verify fail result    ${message_fail}    ${result}

TC_iTM_03485 not input SKU and Discount Price - Fail
    [Tags]    TC_iTM_03485    ready    regression    phoenix    WLS_Low
    ## Prerequisite ##
    #.. Create Discount Campaign
    ${app_name}=    Set Variable    iTruemart
    ${camp_type}=    Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=    Set Variable    percent
    ${start_period}=    Get Date From Today As PCMS Format    1 day
    ${end_period}=    Get Date From Today As PCMS Format    2 day
    ${product_name_list}=    Create List    &{product-disc-1}[name]
    ${camp_name}=    Set Variable    ${EMPTY}
    ${camp_name}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    20
    @{data_value2}=     Create List     ${camp_id}      ${EMPTY}                  ${EMPTY}
    @{data_value3}=     Create List     ${camp_id}      &{product-disc-3}[sku]    20
    @{data}=            Create List     ${data_name}        ${data_value1}    ${data_value2}    ${data_value3}

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    1

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Generate failed record(s) in result
    #### [failed row number in csv], [camp_id], [sku_id], [discount_price], [status]
    ${data_value2}=    Create List    3    @{data_value2}    ${status_fail_mass_sku_and_discount_empty}
    @{result}=        Create List     ${data_value2}
    #.. Verify Upload Result
    Mass Price Product - verify fail result    ${message_fail}    ${result}

TC_iTM_03486 not input Campaign ID and Discount Price - Fail
    [Tags]    TC_iTM_03486   ready    regression    phoenix    WLS_Low
    ## Prerequisite ##
    #.. Create Discount Campaign
    ${app_name}=    Set Variable    iTruemart
    ${camp_type}=    Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=    Set Variable    percent
    ${start_period}=    Get Date From Today As PCMS Format    1 day
    ${end_period}=    Get Date From Today As PCMS Format    2 day
    ${product_name_list}=    Create List    &{product-disc-1}[name]
    ${camp_name}=    Set Variable    ${EMPTY}
    ${camp_name}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)      Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    20
    @{data_value2}=     Create List     ${camp_id}      &{product-disc-2}[sku]    20
    @{data_value3}=     Create List     ${EMPTY}        ,&{product-disc-3}[sku],    ${EMPTY}
    @{data}=            Create List     ${data_name}        ${data_value1}    ${data_value2}    ${data_value3}

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    1

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Generate failed record(s) in result
    #### [failed row number in csv], [camp_id], [sku_id], [discount_price], [status]
    ${data_value3}=    Create List    4    ${EMPTY}    &{product-disc-3}[sku]    ${EMPTY}    ${status_fail_mass_campaign_id_and_discount_empty}
    @{result}=        Create List     ${data_value3}
    #.. Verify Upload Result
    Mass Price Product - verify fail result    ${message_fail}    ${result}

TC_iTM_03487 not input Campaign ID and SKU - Fail
    [Tags]    TC_iTM_03487    ready    regression    phoenix    WLS_Low
    ## Prerequisite ##
    #.. Create Discount Campaign
    ${app_name}=    Set Variable    iTruemart
    ${camp_type}=    Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=    Set Variable    percent
    ${start_period}=    Get Date From Today As PCMS Format    1 day
    ${end_period}=    Get Date From Today As PCMS Format    2 day
    ${product_name_list}=    Create List    &{product-disc-1}[name]
    ${camp_name}=    Set Variable    ${EMPTY}
    ${camp_name}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${EMPTY}        ${EMPTY}                  ,,20
    @{data_value2}=     Create List     ${camp_id}      &{product-disc-2}[sku]    20
    @{data_value3}=     Create List     ${camp_id}      &{product-disc-3}[sku]    20
    @{data}=            Create List     ${data_name}        ${data_value1}    ${data_value2}    ${data_value3}

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    1

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Generate failed record(s) in result
    #### [failed row number in csv], [camp_id], [sku_id], [discount_price], [status]
    ${data_value1}=    Create List    2    ${EMPTY}    ${EMPTY}    20    ${status_fail_mass_campaign_id_and_sku_empty}
    @{result}=        Create List     ${data_value1}
    #.. Verify Upload Result
    Mass Price Product - verify fail result    ${message_fail}    ${result}

TC_iTM_03488 empty row - Fail
    [Tags]    TC_iTM_03488    ready    regression    phoenix    WLS_Low
    ## Prerequisite ##
    #.. Create Discount Campaign
    ${app_name}=    Set Variable    iTruemart
    ${camp_type}=    Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=    Set Variable    percent
    ${start_period}=    Get Date From Today As PCMS Format    1 day
    ${end_period}=    Get Date From Today As PCMS Format    2 day
    ${product_name_list}=    Create List    &{product-disc-1}[name]
    ${camp_name}=    Set Variable    ${EMPTY}
    ${camp_name}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    #.. Generate CSV file to be uploaded
    ${coll_null}=    Set Variable
    ${coll_null_blank}=    Convert To String    ${coll_null}
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    20
    @{data_value2}=     Create List     ${EMPTY}        ${EMPTY}                  ${EMPTY}
    @{data_value3}=     Create List     ${camp_id}      &{product-disc-3}[sku]    20
    @{data}=            Create List     ${data_name}        ${data_value1}    ${data_value2}    ${data_value3}

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    1

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Generate failed record(s) in result
    #### [failed row number in csv], [camp_id], [sku_id], [discount_price], [status]
    ${data_value2}=    Create List    3    @{data_value2}    ${status_fail_mass_row_empty}
    @{result}=        Create List     ${data_value2}
    #.. Verify Upload Result
    Mass Price Product - verify fail result    ${message_fail}    ${result}

TC_iTM_03489 input not be integer on Discount Price - Fail
    [Tags]    TC_iTM_03489    ready    regression    phoenix    WLS_Low
    ## Prerequisite ##
    #.. Create Discount Campaign
    ${app_name}=    Set Variable    iTruemart
    ${camp_type}=    Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=    Set Variable    percent
    ${start_period}=    Get Date From Today As PCMS Format    1 day
    ${end_period}=    Get Date From Today As PCMS Format    2 day
    ${product_name_list}=    Create List    &{product-disc-1}[name]
    ${camp_name}=    Set Variable    ${EMPTY}
    ${camp_name}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    20.23
    @{data_value2}=     Create List     ${camp_id}      &{product-disc-2}[sku]    CC
    @{data_value3}=     Create List     ${camp_id}      &{product-disc-3}[sku]    0
    @{data_value4}=     Create List     ${camp_id}      &{product-disc-4}[sku]    "3,000"
    @{data}=            Create List     ${data_name}        ${data_value1}    ${data_value2}    ${data_value3}    ${data_value4}

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    4

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Generate failed record(s) in result
    #### [failed row number in csv], [camp_id], [sku_id], [discount_price], [status]
    ${data_value1}=    Create List    2    @{data_value1}    ${status_fail_discount_decimal}
    ${data_value2}=    Create List    3    @{data_value2}    ${status_fail_discount_text}
    ${data_value3}=    Create List    4    @{data_value3}    ${status_fail_discount_zero}
    #.. Need to remove double quote for discount price to be expected result
    ${data_value4}=    Create List    5    ${camp_id}      &{product-disc-4}[sku]    3,000    ${status_fail_discount_text}
    @{result}=        Create List     ${data_value1}    ${data_value2}    ${data_value3}    ${data_value4}
    #.. Verify Upload Result
    Mass Price Product - verify fail result    ${message_fail}    ${result}

TC_iTM_03490 input Campaign ID not exist in system - Fail
    [Tags]    TC_iTM_03490    ready    regression    phoenix    WLS_Low
    ## Prerequisite ##
    #.. Create Discount Campaign
    ${app_name}=    Set Variable    iTruemart
    ${camp_type}=    Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=    Set Variable    percent
    ${start_period}=    Get Date From Today As PCMS Format    1 day
    ${end_period}=    Get Date From Today As PCMS Format    2 day
    ${product_name_list}=    Create List    &{product-disc-1}[name]
    ${camp_name}=    Set Variable    ${EMPTY}
    ${camp_name}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    10
    @{data_value2}=     Create List     ${camp_id}      &{product-disc-2}[sku]    10
    @{data_value3}=     Create List     111111111       &{product-disc-3}[sku]    10
    @{data}=            Create List     ${data_name}        ${data_value1}    ${data_value2}    ${data_value3}

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    1

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Generate failed record(s) in result
    #### [failed row number in csv], [camp_id], [sku_id], [discount_price], [status]
    ${data_value3}=    Create List    4    @{data_value3}    ${status_fail_mass_campaign_id_not_exist}
    @{result}=        Create List     ${data_value3}
    #.. Verify Upload Result
    Mass Price Product - verify fail result    ${message_fail}    ${result}

TC_iTM_03491 input SKU not exist in system - Fail
    [Tags]    regression    Product    mass_price_&_product    phoenix    TC_iTM_03491    ready    WLS_Low
    ${app_name}=          Set Variable    iTruemart
    ${camp_type}=         Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=     Set Variable    percent
    ${start_period}=      Get Date From Today As PCMS Format    1 day
    ${end_period}=        Get Date From Today As PCMS Format    2 day
    ${product_name_list}=    Create List    &{product-disc-1}[name]    &{product-disc-2}[name]
    ${camp_name}=            Set Variable    ${EMPTY}

    ## create campaign ##
    ${camp_name}=            Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    ## Generate CSV file to be uploaded ##
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    20
    @{data_value2}=     Create List     ${camp_id}      PHEON1111111              20
    @{data_value3}=     Create List     ${camp_id}      &{product-disc-3}[sku]    20
    @{data}=            Create List     ${data_name}        ${data_value1}      ${data_value2}      ${data_value3}

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    1

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Generate failed record(s) in result
    #### [failed row number in csv], [camp_id], [sku_id], [discount_price], [status]
    ${data_value2}=    Create List    3    @{data_value2}    ${text_invalid_inventory_id}
    @{result}=    Create List    ${data_value2}
    #.. Verify Upload Result
    Mass Price Product - verify fail result    ${message_fail}    ${result}

TC_iTM_03492 the same sku exist under two overlapped campaigns - Fail
    [Tags]    regression    Product    mass_price_&_product    phoenix    ready    TC_iTM_03492    WLS_High
    ${app_name}=          Set Variable    iTruemart
    ${camp_type}=         Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=     Set Variable    percent
    ${start_period}=      Get Date From Today As PCMS Format    1 day
    ${end_period}=        Get Date From Today As PCMS Format    2 day
    ${product_name_list1}=     Create List    &{product-disc-1}[name]    &{product-disc-2}[name]
    ${product_name_list2}=    Create List    &{product-disc-3}[name]
    ${camp_name}=            Set Variable    ${EMPTY}

    ## create campaign1 ##
    ${camp_name1}=            Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id1}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name1}
    Discount campaign - Select Products to Campaign    ${product_name_list1}
    Edit campaign - code and name and description    ${camp_name1}    TEST_CAMP_1
    ${camp_name1}=    Set Variable    TEST_CAMP_1

    ## create campaign2 ##
    ${camp_name2}=             Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id2}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name2}
    Discount campaign - Select Products to Campaign    ${product_name_list2}
    Edit campaign - code and name and description    ${camp_name2}    TEST_CAMP_2
    ${camp_name2}=    Set Variable    TEST_CAMP_2

    ## Generate CSV file to be uploaded ##
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id2}      &{product-disc-2}[sku]    20
    @{data}=            Create List     ${data_name}    ${data_value1}

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ## Provide message success with row number ##
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    1
    ${message_fail_sku_overlap}=    Replace String Using Regexp    ${text_sku_overlapped_campaign}    \\?\\?.+\\?\\?    ${camp_id1}
    ${result}=    Create List    2    @{data_value1}    ${message_fail_sku_overlap}
    @{result}=    Create List    ${result}

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}
    Mass Price Product - verify fail result    ${message_fail}    ${result}

    [Teardown]    Run Keywords    Run keyword If    "${camp_name1}" != "${EMPTY}"    Delete campaign - delete by campaign name    ${camp_name1}
    ...    AND    Run keyword If    "${camp_name2}" != "${EMPTY}"    Delete campaign - delete by campaign name    ${camp_name2}
    ...    AND    Close All Browsers

TC_iTM_03493 Normal Price < Campaign Price - Fail
    [Tags]    regression    Product    mass_price_&_product    phoenix    ready    TC_iTM_03493    WLS_High
    ${app_name}=          Set Variable    iTruemart
    ${camp_type}=         Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=     Set Variable    percent
    ${start_period}=      Get Date From Today As PCMS Format    1 day
    ${end_period}=        Get Date From Today As PCMS Format    2 day
    ${product_name_list}=     Create List    &{product-disc-1}[name]
    ${camp_name}=             Set Variable    ${EMPTY}

    ## Create campaign ##
    ${camp_name}=     Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    ## Generate CSV file to be uploaded ##
    ${discount_value}=     Evaluate    &{product-disc-1}[normal_price] + 100
    @{data_name}=       Create List     Campaign ID      SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    ${discount_value}
    @{data}=            Create List     ${data_name}     ${data_value1}

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    # ${filename}=        Get file name from canonical path    ${file_upload}

    ## Provide message success with row number ##
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    1
    ${data_value1}=    Create List    2    @{data_value1}    ${text_special_price_greater_than_discount}
    @{result}=    Create List    ${data_value1}

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}
    Mass Price Product - verify fail result    ${message_fail}    ${result}

TC_iTM_03494 Normal Price = Campaign Price - Fail
    [Tags]    regression    Product    mass_price_&_product    phoenix    ready    TC_iTM_03494    WLS_High
    ${app_name}=          Set Variable    iTruemart
    ${camp_type}=         Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=     Set Variable    percent
    ${start_period}=      Get Date From Today As PCMS Format    1 day
    ${end_period}=        Get Date From Today As PCMS Format    2 day
    ${product_name_list}=     Create List    &{product-disc-1}[name]
    ${camp_name}=             Set Variable    ${EMPTY}

    ## Create campaign ##
    ${camp_name}=     Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    ## Generate CSV file to be uploaded ##
    @{data_name}=       Create List     Campaign ID      SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    &{product-disc-1}[normal_price]
    @{data}=            Create List     ${data_name}     ${data_value1}
    Log To Console    ${data}
    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}

    ## Provide message success with row number ##
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    1
    ${data_value1}=    Create List    2    @{data_value1}    ${text_special_price_greater_than_discount}
    @{result}=    Create List    ${data_value1}

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}
    Mass Price Product - verify fail result    ${message_fail}    ${result}

TC_iTM_03495 Normal Price > Special Price and Special Price < Campaign Price - Fail
    [Tags]    regression    Product    mass_price_&_product    phoenix    ready    TC_iTM_03495    WLS_High
    ${app_name}=          Set Variable    iTruemart
    ${camp_type}=         Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=     Set Variable    percent
    ${start_period}=      Get Date From Today As PCMS Format    1 day
    ${end_period}=        Get Date From Today As PCMS Format    2 day
    ${product_name_list}=     Create List    &{product-disc-1}[name]
    ${camp_name}=             Set Variable    ${EMPTY}

    ## Create campaign ##
    ${camp_name}=     Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    ## Generate CSV file to be uploaded ##
    ${discount_value}=        Evaluate    &{product-disc-1}[special_price] + 50
    @{data_name}=       Create List     Campaign ID      SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]     ${discount_value}
    @{data}=            Create List     ${data_name}     ${data_value1}
    Log To Console    ${data}
    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}

    ## Provide message success with row number ##
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    1
    ${data_value1}=    Create List    2    @{data_value1}    ${text_special_price_greater_than_discount}
    @{result}=    Create List    ${data_value1}

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}
    Mass Price Product - verify fail result    ${message_fail}    ${result}

TC_iTM_03496 Campaign Price < 1 Bath - Fail
    [Tags]    regression    Product    mass_price_&_product     itma-s122032    ready    phoenix    WLS_High
    #.. Create Discount Campaign
    ${app_name}=    Set Variable    iTruemart
    ${camp_type}=    Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=    Set Variable    percent
    ${start_period}=    Get Date From Today As PCMS Format    1 day
    ${end_period}=    Get Date From Today As PCMS Format    2 day
    ${product_name_list}=    Create List    &{product-disc-1}[name]
    ${camp_name}=    Set Variable    ${EMPTY}
    ${camp_name}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    0
    @{data}=            Create List     ${data_name}        ${data_value1}

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ## Provide message success with row number ##
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    1
    ${data_value1}=    Create List    2    @{data_value1}    ${text_discount_price_less_than_zero}
    @{result}=    Create List    ${data_value1}

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}
    Mass Price Product - verify fail result    ${message_fail}    ${result}

TC_iTM_03497 upload campaingn price when Normal Price > Campaign Price - Success
    [Tags]    regression    Product    mass_price_&_product     itma-s122033    ready    phoenix    WLS_High
    ## Prerequisite ##
    #.. Create Discount Campaign
    ${app_name}=    Set Variable    iTruemart
    ${camp_type}=    Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=    Set Variable    percent
    ${start_period}=    Get Date From Today As PCMS Format    1 day
    ${end_period}=    Get Date From Today As PCMS Format    2 day
    ${product_name_list}=    Create List    &{product-disc-1}[name]    &{product-disc-2}[name]
    ${camp_name}=    Set Variable    ${EMPTY}
    ${camp_name}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    81
    @{data}=            Create List     ${data_name}        ${data_value1}
    ${discount_value_1}=      Evaluate    &{product-disc-1}[normal_price] - @{data_value1}[2]

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    1

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Verify Upload Result
    Mass Price Product - verify upload result message    ${message_success}
    Mass Price Product - User click back button to mass upload price and product page

    #.. Verify Upload History
    ${display_name_top_bar}=    Get display name in top menu
    ${result_row_from_web}=    Get upload history result from web page    ${filename}    ${display_name_top_bar}

    ${num_all_history}=    All history of mass upload
    Check upload history result with DB    @{result_row_from_web}    ${num_all_history}    ${history_camp_price_prod_db}

    ${username_in_history}=    Set Variable    ${result_row_from_web[1]}
    Check user in history same the user in top menu    ${username_in_history}    ${display_name_top_bar}

    Check all row in history    ${num_all_history}
    Sleep    1s
    Mass Price Product - Delete history record by username after upload success    ${username_in_history}    ${filename}

    #.. Verify Discount Product Table
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click discount product button    ${camp_name}
    Discount campaign - Wait Until Page Contains Discount Product Table

    &{expect_sku_detail_1}=    Create Dictionary    name=&{product-disc-1}[sku_name]
    ...    net_price=&{product-disc-1}[normal_price]
    ...    special_price=&{product-disc-1}[special_price]
    ...    discount_value=${discount_value_1}
    ...    discount_type=price
    ...    price=@{data_value1}[2]

    @{expect_skus_detail}=    Create List    ${expect_sku_detail_1}
    Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail    ${expect_skus_detail}

TC_iTM_03498 upload campaingn price when Normal Price > Special Price and Special Price > Campaign Price - Success
    [Tags]    regression    Product    mass_price_&_product     itma-s122034    ready    phoenix    WLS_High
    ## Prerequisite ##
    #.. Create Discount Campaign
    ${app_name}=    Set Variable    iTruemart
    ${camp_type}=    Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=    Set Variable    percent
    ${start_period}=    Get Date From Today As PCMS Format    1 day
    ${end_period}=    Get Date From Today As PCMS Format    2 day
    ${product_name_list}=    Create List    &{product-disc-1}[name]    &{product-disc-2}[name]
    ${camp_name}=    Set Variable    ${EMPTY}
    ${camp_name}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    81
    @{data}=            Create List     ${data_name}        ${data_value1}
    ${discount_value_1}=      Evaluate    &{product-disc-1}[normal_price] - @{data_value1}[2]

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    1

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Verify Upload Result
    Mass Price Product - verify upload result message    ${message_success}
    Mass Price Product - User click back button to mass upload price and product page

    #.. Verify Upload History
    ${display_name_top_bar}=    Get display name in top menu
    ${result_row_from_web}=    Get upload history result from web page    ${filename}    ${display_name_top_bar}

    ${num_all_history}=    All history of mass upload
    Check upload history result with DB    @{result_row_from_web}    ${num_all_history}    ${history_camp_price_prod_db}

    ${username_in_history}=    Set Variable    ${result_row_from_web[1]}
    Check user in history same the user in top menu    ${username_in_history}    ${display_name_top_bar}

    Check all row in history    ${num_all_history}
    Sleep    1s
    Mass Price Product - Delete history record by username after upload success    ${username_in_history}    ${filename}

    #.. Verify Discount Product Table
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click discount product button    ${camp_name}
    Discount campaign - Wait Until Page Contains Discount Product Table

    &{expect_sku_detail_1}=    Create Dictionary    name=&{product-disc-1}[sku_name]
    ...    net_price=&{product-disc-1}[normal_price]
    ...    special_price=&{product-disc-1}[special_price]
    ...    discount_value=${discount_value_1}
    ...    discount_type=price
    ...    price=@{data_value1}[2]

    @{expect_skus_detail}=    Create List    ${expect_sku_detail_1}
    Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail    ${expect_skus_detail}

TC_iTM_03499 upload campaingn price when Normal Price > Special Price and Special Price = Campaign Price - Success
    [Tags]    regression    Product    mass_price_&_product     itma-s122035    ready    phoenix    WLS_High
    ## Prerequisite ##
    #.. Create Discount Campaign
    ${app_name}=    Set Variable    iTruemart
    ${camp_type}=    Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=    Set Variable    percent
    ${start_period}=    Get Date From Today As PCMS Format    1 day
    ${end_period}=    Get Date From Today As PCMS Format    2 day
    ${product_name_list}=    Create List    &{product-disc-1}[name]    &{product-disc-2}[name]
    ${camp_name}=    Set Variable    ${EMPTY}
    ${camp_name}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    200
    @{data}=            Create List     ${data_name}        ${data_value1}
    ${discount_value_1}=      Evaluate    &{product-disc-1}[normal_price] - @{data_value1}[2]

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    1

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Verify Upload Result
    Mass Price Product - verify upload result message    ${message_success}
    Mass Price Product - User click back button to mass upload price and product page

    #.. Verify Upload History
    ${display_name_top_bar}=    Get display name in top menu
    ${result_row_from_web}=    Get upload history result from web page    ${filename}    ${display_name_top_bar}

    ${num_all_history}=    All history of mass upload
    Check upload history result with DB    @{result_row_from_web}    ${num_all_history}    ${history_camp_price_prod_db}

    ${username_in_history}=    Set Variable    ${result_row_from_web[1]}
    Check user in history same the user in top menu    ${username_in_history}    ${display_name_top_bar}

    Check all row in history    ${num_all_history}
    Sleep    1s
    Mass Price Product - Delete history record by username after upload success    ${username_in_history}    ${filename}

    #.. Verify Discount Product Table
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click discount product button    ${camp_name}
    Discount campaign - Wait Until Page Contains Discount Product Table

    &{expect_sku_detail_1}=    Create Dictionary    name=&{product-disc-1}[sku_name]
    ...    net_price=&{product-disc-1}[normal_price]
    ...    special_price=&{product-disc-1}[special_price]
    ...    discount_value=${discount_value_1}
    ...    discount_type=price
    ...    price=@{data_value1}[2]

    @{expect_skus_detail}=    Create List    ${expect_sku_detail_1}
    Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail    ${expect_skus_detail}

TC_iTM_03500 discount (% for iTrueMart page, Baht for DB) that is calculated to be integer properly - Success
    [Tags]    regression    Product    mass_price_&_product    phoenix    ready    TC_iTM_03500    WLS_High
    ${app_name}=          Set Variable    iTruemart
    ${camp_type}=         Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    20
    ${discount_type}=     Set Variable    percent
    ${start_period}=      Get Date From Today As PCMS Format    1 day
    ${end_period}=        Get Date From Today As PCMS Format    2 day
    ${edit_start_date}=      Get Date From Today As PCMS Format
    ${product_name_list}=    Create List    &{product-disc-4}[name]
    ${pkey}=     Set Variable    &{product-disc-4}[pkey]
    Log To Console    ${pkey}
    ${camp_name}=    Set Variable    ${EMPTY}

    ${camp_name}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-4}[sku]    250
    @{data}=            Create List     ${data_name}    ${data_value1}
    ${discount_value_1}=      Evaluate    &{product-disc-4}[normal_price] - @{data_value1}[2]

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ## Provide message success with row number ##
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    1

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}
    Mass Price Product - verify upload result message    ${message_success}
    Mass Price Product - User click back button to mass upload price and product page
    ${display_name_top_bar}=    Get display name in top menu
    ${result_row_from_web}=     Get upload history result from web page    ${filename}    ${display_name_top_bar}
    ${num_all_history}=    All history of mass upload
    Check upload history result with DB    @{result_row_from_web}    ${num_all_history}    ${history_camp_price_prod_db}

    ${username_in_history}=    Set Variable    ${result_row_from_web[1]}
    Check user in history same the user in top menu    ${username_in_history}    ${display_name_top_bar}

    Check all row in history    ${num_all_history}
    Sleep    1s
    Mass Price Product - Delete history record by username after upload success    ${username_in_history}    ${filename}
    ## Verify Discount Product Table ##
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click discount product button    ${camp_name}
    Discount campaign - Wait Until Page Contains Discount Product Table

    &{expect_sku_detail_1}=    Create Dictionary    name=&{product-disc-4}[sku_name]
    ...    net_price=&{product-disc-4}[normal_price]
    ...    special_price=&{product-disc-4}[special_price]
    ...    discount_value=${discount_value_1}
    ...    discount_type=price
    ...    price=@{data_value1}[2]

    @{expect_skus_detail}=    Create List    ${expect_sku_detail_1}
    Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail    ${expect_skus_detail}
    Edit campaign - period    ${camp_name}    ${edit_start_date}    ${end_period}
    ${product_name_pkey}=     Set Variable    &{product-disc-4}[name]-&{product-disc-4}[pkey]

    ${product_normal_price}    ${product_special_price}    ${product_discount_percent}=    Get Product Price Detail From Level D    ${product_name_pkey}

    ${percent_1}=    Evaluate    int((&{product-disc-4}[normal_price]-@{data_value1}[2])*100/&{product-disc-4}[normal_price])
    &{expected_price_1}    Create Dictionary    name_pkey=${product_name_pkey}    normal=&{product-disc-4}[normal_price]
    ...    special=@{data_value1}[2]    discount_percent=${percent_1}

    @{expected_prices}=    Create List    ${expected_price_1}
    : For    ${item}    IN    @{expected_prices}
    \    ${normal}    ${special}    ${percent}=    Get Product Price Detail From Level D    &{item}[name_pkey]
    \    Should Be Equal    '${normal}'    '&{item}[normal]'
    \    Should Be Equal    '${special}'    '&{item}[special]'
    \    Should Be Equal    '${percent}'    '&{item}[discount_percent]'

TC_iTM_03501 discount (% for iTrueMart page, Baht for DB) that is calculated to be decimal (decimal number is less than 0.5) properly
    [Tags]    regression    Product    mass_price_&_product    phoenix    ready    TC_iTM_03501    WLS_High
    ${app_name}=          Set Variable    iTruemart
    ${camp_type}=         Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=     Set Variable    percent
    ${start_period}=      Get Date From Today As PCMS Format    1 day
    ${end_period}=        Get Date From Today As PCMS Format    2 day
    ${edit_start_date}=      Get Date From Today As PCMS Format
    ${product_name_list}=    Create List    &{product-disc-4}[name]
    ${pkey}=     Set Variable    &{product-disc-4}[pkey]
    Log To Console    ${pkey}
    ${camp_name}=    Set Variable    ${EMPTY}

    ${camp_name}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-4}[sku]    294
    @{data}=            Create List     ${data_name}    ${data_value1}
    ${discount_value_1}=      Evaluate    &{product-disc-4}[normal_price] - @{data_value1}[2]

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ## Provide message success with row number ##
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    1

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}
    Mass Price Product - verify upload result message    ${message_success}
    Mass Price Product - User click back button to mass upload price and product page
    ${display_name_top_bar}=    Get display name in top menu
    ${result_row_from_web}=     Get upload history result from web page    ${filename}    ${display_name_top_bar}
    ${num_all_history}=    All history of mass upload
    Check upload history result with DB    @{result_row_from_web}    ${num_all_history}    ${history_camp_price_prod_db}

    ${username_in_history}=    Set Variable    ${result_row_from_web[1]}
    Check user in history same the user in top menu    ${username_in_history}    ${display_name_top_bar}

    Check all row in history    ${num_all_history}
    Sleep    1s
    Mass Price Product - Delete history record by username after upload success    ${username_in_history}    ${filename}
    ## Verify Discount Product Table ##
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click discount product button    ${camp_name}
    Discount campaign - Wait Until Page Contains Discount Product Table

    &{expect_sku_detail_1}=    Create Dictionary    name=&{product-disc-4}[sku_name]
    ...    net_price=&{product-disc-4}[normal_price]
    ...    special_price=&{product-disc-4}[special_price]
    ...    discount_value=${discount_value_1}
    ...    discount_type=price
    ...    price=@{data_value1}[2]

    @{expect_skus_detail}=    Create List    ${expect_sku_detail_1}
    Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail    ${expect_skus_detail}
    Edit campaign - period    ${camp_name}    ${edit_start_date}    ${end_period}

    ${product_name_pkey}=     Set Variable    &{product-disc-4}[name]-&{product-disc-4}[pkey]

    ${product_normal_price}    ${product_special_price}    ${product_discount_percent}=    Get Product Price Detail From Level D    ${product_name_pkey}

    ${percent_1}=    Evaluate    int((&{product-disc-4}[normal_price]-@{data_value1}[2])*100/&{product-disc-4}[normal_price])
    &{expected_price_1}    Create Dictionary    name_pkey=${product_name_pkey}    normal=&{product-disc-4}[normal_price]
    ...    special=@{data_value1}[2]    discount_percent=${percent_1}

    @{expected_prices}=    Create List    ${expected_price_1}
    : For    ${item}    IN    @{expected_prices}
    \    ${normal}    ${special}    ${percent}=    Get Product Price Detail From Level D    &{item}[name_pkey]
    \    Should Be Equal    '${normal}'     '&{item}[normal]'
    \    Should Be Equal    '${special}'    '&{item}[special]'
    \    Should Be Equal    '${percent}'    '&{item}[discount_percent]'

TC_iTM_03502 discount (% for iTrueMart page, Baht for DB) discount that is calculated to be decimal (decimal number is more than 0.5) properly
    [Tags]    regression    Product    mass_price_&_product    phoenix    ready     TC_iTM_03502    WLS_High
    ${app_name}=          Set Variable    iTruemart
    ${camp_type}=         Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=     Set Variable    percent
    ${start_period}=      Get Date From Today As PCMS Format    1 day
    ${end_period}=        Get Date From Today As PCMS Format    2 day
    ${edit_start_date}=      Get Date From Today As PCMS Format
    ${product_name_list}=    Create List    &{product-disc-4}[name]
    ${pkey}=     Set Variable    &{product-disc-4}[pkey]
    Log To Console    ${pkey}
    ${camp_name}=    Set Variable    ${EMPTY}

    ${camp_name}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-4}[sku]    296
    @{data}=            Create List     ${data_name}    ${data_value1}
    ${discount_value_1}=      Evaluate    &{product-disc-4}[normal_price] - @{data_value1}[2]

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ## Provide message success with row number ##
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    1

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}
    Mass Price Product - verify upload result message    ${message_success}
    Mass Price Product - User click back button to mass upload price and product page
    ${display_name_top_bar}=    Get display name in top menu
    ${result_row_from_web}=     Get upload history result from web page    ${filename}    ${display_name_top_bar}
    ${num_all_history}=    All history of mass upload
    Check upload history result with DB    @{result_row_from_web}    ${num_all_history}    ${history_camp_price_prod_db}

    ${username_in_history}=    Set Variable    ${result_row_from_web[1]}
    Check user in history same the user in top menu    ${username_in_history}    ${display_name_top_bar}

    Check all row in history    ${num_all_history}
    Sleep    1s
    Mass Price Product - Delete history record by username after upload success    ${username_in_history}    ${filename}
    ## Verify Discount Product Table ##
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click discount product button    ${camp_name}
    Discount campaign - Wait Until Page Contains Discount Product Table

    &{expect_sku_detail_1}=    Create Dictionary    name=&{product-disc-4}[sku_name]
    ...    net_price=&{product-disc-4}[normal_price]
    ...    special_price=&{product-disc-4}[special_price]
    ...    discount_value=${discount_value_1}
    ...    discount_type=price
    ...    price=@{data_value1}[2]

    @{expect_skus_detail}=    Create List    ${expect_sku_detail_1}
    Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail    ${expect_skus_detail}
    Edit campaign - period    ${camp_name}    ${edit_start_date}    ${end_period}

    ${product_name_pkey}=     Set Variable    &{product-disc-4}[name]-&{product-disc-4}[pkey]
    ${product_normal_price}    ${product_special_price}    ${product_discount_percent}=    Get Product Price Detail From Level D    ${product_name_pkey}

    ${percent_1}=    Evaluate    int((&{product-disc-4}[normal_price]-@{data_value1}[2])*100/&{product-disc-4}[normal_price])
    &{expected_price_1}    Create Dictionary    name_pkey=${product_name_pkey}    normal=&{product-disc-4}[normal_price]
    ...    special=@{data_value1}[2]    discount_percent=${percent_1}

    @{expected_prices}=    Create List    ${expected_price_1}
    : For    ${item}    IN    @{expected_prices}
    \    ${normal}    ${special}    ${percent}=    Get Product Price Detail From Level D    &{item}[name_pkey]
    \    Should Be Equal    '${normal}'     '&{item}[normal]'
    \    Should Be Equal    '${special}'    '&{item}[special]'
    \    Should Be Equal    '${percent}'    '&{item}[discount_percent]'

TC_iTM_03526 duplication record(campaign ID/sku) - Fail
    [Tags]    TC_iTM_03526    ready    regression    phoenix    WLS_High
    ## Prerequisite ##
    #.. Create Discount Campaign
    ${app_name}=    Set Variable    iTruemart
    ${camp_type}=    Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=    Set Variable    percent
    ${start_period}=    Get Date From Today As PCMS Format    1 day
    ${end_period}=    Get Date From Today As PCMS Format    2 day
    ${product_name_list}=    Create List    &{product-disc-1}[name]
    ${camp_name}=    Set Variable    ${EMPTY}
    ${camp_name}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}

    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id}      &{product-disc-1}[sku]    20
    @{data_value2}=     Create List     ${camp_id}      &{product-disc-1}[sku]    25
    @{data}=            Create List     ${data_name}        ${data_value1}        ${data_value2}

    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_fail}=    Replace String Using Regexp    ${message_fail_template}    \\?\\?.+\\?\\?    2

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Generate failed record(s) in result
    #### [failed row number in csv], [camp_id], [sku_id], [discount_price], [status]
    ${data_value1}=    Create List    2    @{data_value1}    ${status_fail_duplicate_campaign_id_and_sku}
    ${data_value2}=    Create List    3    @{data_value2}    ${status_fail_duplicate_campaign_id_and_sku}
    @{result}=        Create List     ${data_value1}    ${data_value2}
    #.. Verify Upload Result
    Mass Price Product - verify fail result    ${message_fail}    ${result}

TC_iTM_04807 To verify that product and price has been uploaded successfully if uploading to campaign that app id period are same
    [Tags]    TC_iTM_04807    ready    regression    phoenix    WLS_Medium
    ## Prerequisite ##
    #.. Create Discount Campaign for iTruemart
    ${app_name}=    Set Variable    iTruemart
    ${camp_type}=    Set Variable    discount(no icon)
    ${discount_value}=    Set Variable    50
    ${discount_type}=    Set Variable    percent
    ${start_period}=    Get Date From Today As PCMS Format    1 day
    ${end_period}=    Get Date From Today As PCMS Format    2 day
    ${product_name_list}=    Create List    &{product-disc-1}[name]    &{product-disc-2}[name]
    ${camp_name}=    Set Variable    ${EMPTY}
    ${camp_name}=    Create Discount Campaign for Test Cases    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}
    ...    ${start_period}    ${end_period}
    ${camp_id}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name}
    Discount campaign - Select Products to Campaign    ${product_name_list}
    Edit campaign - code and name and description    ${camp_name}    TEST_CAMP_ITM
    ${camp_name}=    Set Variable    TEST_CAMP_ITM

    #.. Create Discount Campaign for Exclusive Privilege
    ${app_name_ep}=    Set Variable    Exclusive Privilege
    ${camp_type_ep}=    Set Variable    discount(no icon)
    ${discount_value_ep}=    Set Variable    5
    ${discount_type_ep}=    Set Variable    percent
    ${start_period_ep}=    Get Date From Today As PCMS Format    1 day
    ${end_period_ep}=    Get Date From Today As PCMS Format    2 day
    ${product_name_list_ep}=    Create List    &{product-disc-1}[name]    &{product-disc-2}[name]
    ${camp_name_ep}=    Set Variable    ${EMPTY}
    ${camp_name_ep}=    Create Discount Campaign for Test Cases    ${app_name_ep}    ${camp_type_ep}    ${discount_value_ep}    ${discount_type_ep}
    ...    ${start_period_ep}    ${end_period_ep}
    ${camp_id_ep}=    Discount campaign - Get Campaign ID from Campaign Name    ${camp_name_ep}
    Discount campaign - Select Products to Campaign    ${product_name_list_ep}
    Edit campaign - code and name and description    ${camp_name_ep}    TEST_CAMP_EP
    ${camp_name_ep}=    Set Variable    TEST_CAMP_EP

    #.. Generate CSV file to be uploaded
    @{data_name}=       Create List     Campaign ID     SKU ID (Inventory ID)     Discount Price
    @{data_value1}=     Create List     ${camp_id_ep}      &{product-disc-1}[sku]    199
    @{data_value2}=     Create List     ${camp_id_ep}      &{product-disc-2}[sku]    99
    @{data_value3}=     Create List     ${camp_id_ep}      &{product-disc-4}[sku]    100
    @{data_value4}=     Create List     ${camp_id}      &{product-disc-1}[sku]    155
    @{data_value5}=     Create List     ${camp_id}      &{product-disc-2}[sku]    55
    @{data_value6}=     Create List     ${camp_id}      &{product-disc-4}[sku]    75
    @{data}=            Create List     ${data_name}    ${data_value1}    ${data_value2}    ${data_value3}    ${data_value4}    ${data_value5}    ${data_value6}
    ${discount_value_1}=      Evaluate    &{product-disc-1}[normal_price] - @{data_value1}[2]
    ${discount_value_2}=      Evaluate    &{product-disc-2}[normal_price] - @{data_value2}[2]
    ${discount_value_3}=      Evaluate    &{product-disc-4}[normal_price] - @{data_value3}[2]
    ${discount_value_4}=      Evaluate    &{product-disc-1}[normal_price] - @{data_value4}[2]
    ${discount_value_5}=      Evaluate    &{product-disc-2}[normal_price] - @{data_value5}[2]
    ${discount_value_6}=      Evaluate    &{product-disc-4}[normal_price] - @{data_value6}[2]
    ${path_file}=       Set campaign ID SKU ID and discount price in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    6

    ## Test Step ##
    Go to mass price and product menu
    User browse file for mass upload price and product    ${file_upload}

    #.. Verify Upload Result
    Mass Price Product - verify upload result message    ${message_success}
    Mass Price Product - User click back button to mass upload price and product page

    #.. Verify Upload History
    ${display_name_top_bar}=    Get display name in top menu
    ${result_row_from_web}=    Get upload history result from web page    ${filename}    ${display_name_top_bar}

    ${num_all_history}=    All history of mass upload
    Check upload history result with DB    @{result_row_from_web}    ${num_all_history}    ${history_camp_price_prod_db}

    ${username_in_history}=    Set Variable    ${result_row_from_web[1]}
    Check user in history same the user in top menu    ${username_in_history}    ${display_name_top_bar}

    Check all row in history    ${num_all_history}
    Sleep    1s
    Mass Price Product - Delete history record by username after upload success    ${username_in_history}    ${filename}

    #.. Verify Discount Product Table for EP campaign
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click discount product button    ${camp_name_ep}
    Discount campaign - Wait Until Page Contains Discount Product Table

    &{expect_sku_detail_1}=    Create Dictionary    name=&{product-disc-1}[sku_name]
    ...    net_price=&{product-disc-1}[normal_price]
    ...    special_price=&{product-disc-1}[special_price]
    ...    discount_value=${discount_value_1}
    ...    discount_type=price
    ...    price=@{data_value1}[2]

    &{expect_sku_detail_2}=    Create Dictionary    name=&{product-disc-2}[sku_name]
    ...    net_price=&{product-disc-2}[normal_price]
    ...    special_price=&{product-disc-2}[special_price]
    ...    discount_value=${discount_value_2}
    ...    discount_type=price
    ...    price=@{data_value2}[2]

    &{expect_sku_detail_3}=    Create Dictionary    name=&{product-disc-4}[sku_name]
    ...    net_price=&{product-disc-4}[normal_price]
    ...    special_price=&{product-disc-4}[special_price]
    ...    discount_value=${discount_value_3}
    ...    discount_type=price
    ...    price=@{data_value3}[2]

    @{expect_skus_detail_ep}=    Create List    ${expect_sku_detail_1}    ${expect_sku_detail_2}    ${expect_sku_detail_3}
    Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail    ${expect_skus_detail_ep}

    #.. Verify Discount Product Table for  iTrueMart campaign
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click discount product button    ${camp_name}
    Discount campaign - Wait Until Page Contains Discount Product Table

    &{expect_sku_detail_1}=    Create Dictionary    name=&{product-disc-1}[sku_name]
    ...    net_price=&{product-disc-1}[normal_price]
    ...    special_price=&{product-disc-1}[special_price]
    ...    discount_value=${discount_value_4}
    ...    discount_type=price
    ...    price=@{data_value4}[2]

    &{expect_sku_detail_2}=    Create Dictionary    name=&{product-disc-2}[sku_name]
    ...    net_price=&{product-disc-2}[normal_price]
    ...    special_price=&{product-disc-2}[special_price]
    ...    discount_value=${discount_value_5}
    ...    discount_type=price
    ...    price=@{data_value5}[2]

    &{expect_sku_detail_3}=    Create Dictionary    name=&{product-disc-4}[sku_name]
    ...    net_price=&{product-disc-4}[normal_price]
    ...    special_price=&{product-disc-4}[special_price]
    ...    discount_value=${discount_value_6}
    ...    discount_type=price
    ...    price=@{data_value6}[2]

    @{expect_skus_detail}=    Create List    ${expect_sku_detail_1}    ${expect_sku_detail_2}    ${expect_sku_detail_3}
    Discount campaign - Verify Product and Price on Discount Product Table by SKU(s) detail    ${expect_skus_detail}

    [Teardown]    Run Keywords    Run keyword If    "${camp_name}" != "${EMPTY}"    Delete campaign - delete by campaign name    ${camp_name}
    ...    AND    Run keyword If    "${camp_name_ep}" != "${EMPTY}"    Delete campaign - delete by campaign name    ${camp_name_ep}
    ...    AND    Close All Browsers

*** Keywords ***
Create Discount Campaign for Test Cases
    [Arguments]    ${app_name}    ${camp_type}    ${discount_value}    ${discount_type}    ${start_period}    ${end_period}
    ${tc_number}=    Get Test Case Number
    ${code}=    Set Variable    ${tc_number}
    ${name}=    Set Variable    ${tc_number}
    ${desc}=    Set Variable    ${tc_number}
    Run Keyword If    "${camp_type}" == "discount(no icon)"    Create campaign - discount(no icon)    ${app_name}    ${code}    ${name}    ${desc}    ${discount_value}    ${discount_type}    ${start_period}    ${end_period}
    ...    ELSE IF    "${camp_type}" == "discount(line true you)"    Create campaign - discount(line true you)    ${app_name}    ${code}    ${name}    ${desc}    ${discount_value}    ${discount_type}    ${start_period}    ${end_period}
    ...    ELSE IF    "${camp_type}" == "discount(line truemoveH)"    Create campaign - discount(line truemoveH)    ${app_name}    ${code}    ${name}    ${desc}    ${discount_value}    ${discount_type}    ${start_period}    ${end_period}
    ...    ELSE IF    "${camp_type}" == "everyday wow 1 bath"    Create campaign - everyday wow 1 bath    ${app_name}    ${code}    ${name}    ${desc}    ${discount_value}    ${discount_type}    ${start_period}    ${end_period}
    ...    ELSE IF    "${camp_type}" == "everyday wow"    Create campaign - everyday wow    ${app_name}    ${code}    ${name}    ${desc}    ${discount_value}    ${discount_type}    ${start_period}    ${end_period}
    Return From Keyword     ${name}
