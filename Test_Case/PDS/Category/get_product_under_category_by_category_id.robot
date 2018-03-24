*** Setting ***
Force Tags    WLS_PDS_Category
Library           HttpLibrary.HTTP
Library           Collections
Library           DatabaseLibrary
Library           String
Library           ${CURDIR}/../../../Python_Library/common.py
Library           ${CURDIR}/../../../Python_Library/FileKeyword.py
Library           ${CURDIR}/../../../Python_Library/common/csvlibrary.py
Library           ${CURDIR}/../../../Python_Library/common/uploadsoperation.py

Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/Database/PDS/keyword_categories.robot
Resource          ${CURDIR}/../../../Keyword/Database/PDS/keyword_products.robot
Resource          ${CURDIR}/../../../Keyword/Database/PDS/keyword_variant.robot
Resource          ${CURDIR}/../../../Keyword/API/PDS/pds_api_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PDS/Keywords_PDS_Common.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Product/keywords_product.robot

Test Teardown     Run keyword If    "${cate_id}" != "${EMPTY}"    Run Keywords    Log    ${cate_id}    AND    Permanent Delete Category By Category ID    ${cate_id}

*** Variables ***
${parent_id}    1
${cate_id}      ${EMPTY}

*** Test Cases ***

TC_ITMWM_05060 GET: /categories/:category_pkey/products - get category has no product by category id - success 200
    [Tags]    TC_ITMWM_05060    phoenix    ready    regression
    #..Prerequisite: There is category that has no product on system
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=               Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Success Response Status Code and Message
    ${cate_pkey}=    Get Category Pkey After Creating
    ${cate_id}=      Get Category ID After Creating
    ${data}=         Get Json Value and Convert to List    ${response}    /data
    ${is_category_code}=    Get From Dictionary    ${data}     category_code

    #..Test step
    ${response}=    Get Product Under Category By Category ID    ${cate_pkey}
    Verify Success Response Status Code and Message
    Verify Response is category that has no product    ${response}    ${is_category_code}

TC_ITMWM_05061 GET: /categories/:category_pkey/products - get category has product by category id - success 200
    [Tags]    TC_ITMWM_05061    phoenix    ready
    #..Prerequisite: There is category that has product on system
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=               Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Success Response Status Code and Message
    ${cate_pkey}=    Get Category Pkey After Creating
    ${cate_id}=      Get Category ID After Creating

    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cate_pkey}    &{product-disc-5}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}
    Set Test Variable    ${response_code}       @{response}[0]
    Set Test Variable    ${response_content}    @{response}[1]

    ${expected_total_rows}=    Set Variable    1
    &{display_item_1}=    Create Dictionary    category_key=@{data_value1}[0]    product_key=@{data_value1}[1]    status=Success
    &{expected_display}=    Create Dictionary    2=&{display_item_1}
    Verify Success Response Status Code and Content From Add/Replace Products To Categories    ${expected_total_rows}    ${expected_display}

    #..Test Steps
    ${response}=    Get Product Under Category By Category ID    ${cate_pkey}
    Verify Success Response Status Code and Message
    @{product_pkey_list}=    Create List
    Append To List    ${product_pkey_list}   @{data_value1}[1]
    Verify Response From API GET Product     ${response}    ${product_pkey_list}

TC_ITMWM_05063 GET: /categories/:category_pkey/products - get category that has 1-5 sub category level by category ID - success 200
    [Tags]    TC_ITMWM_05063    phoenix    regression    ready
    #..Prerequisite: There is category that has product on system
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}

    #..create level1
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name               "${tc_number}-1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name_translate     "${tc_number}-1-EN"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    1    ${file_data}
    ${cat_id_1}=       Get Category ID After Creating
    ${cate_pkey_1}=    Get Category Pkey After Creating

    #..create level2
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name               "${tc_number}-1-2"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name_translate     "${tc_number}-1-2-EN"
    Remove From Dictionary    ${CATEGORY_CREATE_JSON}    image_url_desktop
    Remove From Dictionary    ${CATEGORY_CREATE_JSON}    image_url_mobile
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response1}=    Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1_2}=       Get Category ID After Creating
    ${cate_pkey_1_2}=    Get Category Pkey After Creating

    #..create level3
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name               "${tc_number}-1-2-3"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name_translate     "${tc_number}-1-2-3-EN"
    Remove From Dictionary    ${CATEGORY_CREATE_JSON}    image_url_desktop
    Remove From Dictionary    ${CATEGORY_CREATE_JSON}    image_url_mobile
    ${file_data}=      Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response1-2}=    Create Category    ${cat_id_1_2}    ${file_data}
    ${cat_id_1_2_3}=       Get Category ID After Creating
    ${cate_pkey_1_2_3}=    Get Category Pkey After Creating

    #..create level4_1
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name               "${tc_number}-1-2-3-4_1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name_translate     "${tc_number}-1-2-3-4_1-EN"
    ${file_data}=      Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response1-3}=    Create Category    ${cat_id_1_2_3}    ${file_data}
    ${cat_id_1_2_3_4-1}=       Get Category ID After Creating
    ${cate_pkey_1_2_3_4-1}=    Get Category Pkey After Creating

    #..create level4_2
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name               "${tc_number}-1-2-3-4_2"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name_translate     "${tc_number}-1-2-3-4_2-EN"
    ${file_data}=      Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response1-3}=    Create Category    ${cat_id_1_2_3}    ${file_data}
    ${cat_id_1_2_3_4-2}=       Get Category ID After Creating
    ${cate_pkey_1_2_3_4-2}=    Get Category Pkey After Creating

    #..create level5
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name               "${tc_number}-1-2-3-4-5"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name_translate     "${tc_number}-1-2-3-4-5-EN"
    ${file_data}=      Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response1-4}=    Create Category    ${cat_id_1_2_3_4-2}    ${file_data}
    ${cat_id_1_2_3_4_5}=       Get Category ID After Creating
    ${cate_pkey_1_2_3_4_5}=    Get Category Pkey After Creating

    #..create level6
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name               "${tc_number}-1-2-3-4-5-6"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name_translate     "${tc_number}-1-2-3-4-5-6-EN"
    ${file_data}=       Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response1-5}=     Create Category    ${cat_id_1_2_3_4_5}    ${file_data}
    ${cat_id_1_2_3_4_5_6}=       Get Category ID After Creating
    ${cate_pkey_1_2_3_4_5_6}=    Get Category Pkey After Creating

    #..Uploaded product into category
    #...Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key                Product Key
    @{data_value1}=    Create List    ${cate_pkey_1_2_3_4_5_6}    &{product-disc-5}[pkey]
    @{data_value2}=    Create List    ${cate_pkey_1_2_3_4-2}      &{product-disc-6}[pkey]
    @{data_value3}=    Create List    ${cate_pkey_1_2_3_4-1}      &{product-disc-7}[pkey]
    @{data_value4}=    Create List    ${cate_pkey_1_2_3_4_5_6}    &{product-disc-8}[pkey]    #->inactive status
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}    ${data_value3}    ${data_value4}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}
    Set Test Variable    ${response_code}       @{response}[0]
    Set Test Variable    ${response_content}    @{response}[1]

    ${expected_total_rows}=    Set Variable    4
    &{display_item_1}=    Create Dictionary    category_key=@{data_value1}[0]    product_key=@{data_value1}[1]    status=Success
    &{display_item_2}=    Create Dictionary    category_key=@{data_value2}[0]    product_key=@{data_value2}[1]    status=Success
    &{display_item_3}=    Create Dictionary    category_key=@{data_value3}[0]    product_key=@{data_value3}[1]    status=Success
    &{display_item_4}=    Create Dictionary    category_key=@{data_value4}[0]    product_key=@{data_value4}[1]    status=Success
    &{expected_display}=    Create Dictionary    2=&{display_item_1}    3=&{display_item_2}    4=&{display_item_3}    5=&{display_item_4}
    Verify Success Response Status Code and Content From Add/Replace Products To Categories    ${expected_total_rows}    ${expected_display}

    #..test step
    #...cate level3
    ${response}=    Get Product Under Category By Category ID    ${cate_pkey_1}    ?display_option=product&sort_by=discount&order=desc
    Verify Success Response Status Code and Message
    Verify number of data          ${response}    3
    Verify total number of data    ${response}    3
    Verify page                    ${response}    1
    Verify total page              ${response}    1
    Verify is last page            ${response}    true

    @{product_pkey_list}=    Create List
    Append To List    ${product_pkey_list}   @{data_value1}[1]    @{data_value2}[1]    @{data_value3}[1]
    Verify Response From API GET Product     ${response}    ${product_pkey_list}

    #...Cate level2
    ${response}=    Get Product Under Category By Category ID    ${cate_pkey_1_2}    ?display_option=product
    Verify Success Response Status Code and Message
    Verify number of data          ${response}    3
    Verify total number of data    ${response}    3
    Verify page                    ${response}    1
    Verify total page              ${response}    1
    Verify is last page            ${response}    true

    @{product_pkey_list}=    Create List
    Append To List    ${product_pkey_list}   @{data_value1}[1]    @{data_value2}[1]    @{data_value3}[1]
    Verify Response From API GET Product     ${response}    ${product_pkey_list}

    #...Cate level3
    ${response}=    Get Product Under Category By Category ID    ${cate_pkey_1_2_3}    ?display_option=product
    Verify Success Response Status Code and Message
    Verify number of data          ${response}    3
    Verify total number of data    ${response}    3
    Verify page                    ${response}    1
    Verify total page              ${response}    1
    Verify is last page            ${response}    true

    @{product_pkey_list}=    Create List
    Append To List    ${product_pkey_list}   @{data_value1}[1]    @{data_value2}[1]    @{data_value3}[1]
    Verify Response From API GET Product     ${response}    ${product_pkey_list}

    #...Cate level4-1
    ${response}=    Get Product Under Category By Category ID    ${cate_pkey_1_2_3_4-1}    ?display_option=product
    Verify Success Response Status Code and Message
    Verify number of data          ${response}    1
    Verify total number of data    ${response}    1
    Verify page                    ${response}    1
    Verify total page              ${response}    1
    Verify is last page            ${response}    true

    @{product_pkey_list}=    Create List
    Append To List    ${product_pkey_list}    @{data_value3}[1]
    Verify Response From API GET Product     ${response}    ${product_pkey_list}

    #...Cate level4-2
    ${response}=    Get Product Under Category By Category ID    ${cate_pkey_1_2_3_4-2}    ?display_option=product
    Verify Success Response Status Code and Message
    Verify number of data          ${response}    2
    Verify total number of data    ${response}    2
    Verify page                    ${response}    1
    Verify total page              ${response}    1
    Verify is last page            ${response}    true

    @{product_pkey_list}=    Create List
    Append To List    ${product_pkey_list}     @{data_value1}[1]    @{data_value2}[1]
    Verify Response From API GET Product     ${response}    ${product_pkey_list}

    #...Cate level5
    ${response}=    Get Product Under Category By Category ID    ${cate_pkey_1_2_3_4_5}    ?display_option=product
    Verify Success Response Status Code and Message
    Verify number of data          ${response}    1
    Verify total number of data    ${response}    1
    Verify page                    ${response}    1
    Verify total page              ${response}    1
    Verify is last page            ${response}    true

    @{product_pkey_list}=    Create List
    Append To List    ${product_pkey_list}     @{data_value1}[1]
    Verify Response From API GET Product     ${response}    ${product_pkey_list}

    #...Cate level6
    ${response}=    Get Product Under Category By Category ID    ${cate_pkey_1_2_3_4_5_6}    ?display_option=product
    Verify Success Response Status Code and Message
    Verify number of data          ${response}    1
    Verify total number of data    ${response}    1
    Verify page                    ${response}    1
    Verify total page              ${response}    1
    Verify is last page            ${response}    true

    @{product_pkey_list}=    Create List
    Append To List    ${product_pkey_list}     @{data_value1}[1]
    Verify Response From API GET Product     ${response}    ${product_pkey_list}

    [Teardown]    Run Keywords    Run keyword If    "${cat_id_1_2_3_4_5_6}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_2_3_4_5_6}    AND    Run keyword If    "${cat_id_1_2_3_4_5}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_2_3_4_5}\
    ...    AND    Run keyword If    "${cat_id_1_2_3_4-2}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_2_3_4-2}\
    ...    AND    Run keyword If    "${cat_id_1_2_3_4-1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_2_3_4-1}\
    ...    AND    Run keyword If    "${cat_id_1_2_3}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_2_3}\
    ...    AND    Run keyword If    "${cat_id_1_2}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_2}\
    ...    AND    Run keyword If    "${cat_id_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1}


TC_ITMWM_05065 GET: /categories/:category_pkey/products - get category for display_option = product with limit - success 200
    [Tags]    TC_ITMWM_05065    phoenix    regression    ready
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cate_id}=       Get Category ID After Creating
    ${cate_pkey}=     Get Category Pkey After Creating
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cate_pkey}    &{product-disc-5}[pkey]
    @{data_value2}=    Create List    ${cate_pkey}    &{product-disc-6}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    @{response}=    Add Products To Categories    ${file_upload}
    Set Test Variable    ${response_code}       @{response}[0]
    Set Test Variable    ${response_content}    @{response}[1]

    ${expected_total_rows}=    Set Variable    2
    &{display_item_1}=    Create Dictionary    category_key=@{data_value1}[0]    product_key=@{data_value1}[1]    status=Success
    &{display_item_2}=    Create Dictionary    category_key=@{data_value2}[0]    product_key=@{data_value2}[1]    status=Success
    &{expected_display}=    Create Dictionary    2=&{display_item_1}    3=&{display_item_2}
    Verify Success Response Status Code and Content From Add/Replace Products To Categories    ${expected_total_rows}    ${expected_display}

    #..Test Steps
    ${response}=    Get Product Under Category By Category ID    ${cate_pkey}    ?display_option=product&limit=1
    Verify Success Response Status Code and Message
    Verify number of data          ${response}    1
    Verify total number of data    ${response}    2
    Verify page                    ${response}    1
    Verify total page              ${response}    2
    Verify is last page            ${response}    false
    @{product_pkey_list}=    Create List
    Append To List    ${product_pkey_list}   @{data_value1}[1]
    Verify Response From API GET Product     ${response}    ${product_pkey_list}


TC_ITMWM_05066 GET: /categories/:category_pkey/products - get category for display_option = product with page and limit - success 200
    [Tags]    TC_ITMWM_05066    phoenix    regression    ready
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cate_id}=       Get Category ID After Creating
    ${cate_pkey}=     Get Category Pkey After Creating
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cate_pkey}    &{product-disc-5}[pkey]
    @{data_value2}=    Create List    ${cate_pkey}    &{product-disc-6}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    @{response}=    Add Products To Categories    ${file_upload}
    Set Test Variable    ${response_code}       @{response}[0]
    Set Test Variable    ${response_content}    @{response}[1]

    ${expected_total_rows}=    Set Variable    2
    &{display_item_1}=    Create Dictionary    category_key=@{data_value1}[0]    product_key=@{data_value1}[1]    status=Success
    &{display_item_2}=    Create Dictionary    category_key=@{data_value2}[0]    product_key=@{data_value2}[1]    status=Success
    &{expected_display}=    Create Dictionary    2=&{display_item_1}    3=&{display_item_2}
    Verify Success Response Status Code and Content From Add/Replace Products To Categories    ${expected_total_rows}    ${expected_display}

    #..Test Steps
    ${response}=    Get Product Under Category By Category ID    ${cate_pkey}    ?display_option=product&page=1&limit=1
    Verify Success Response Status Code and Message
    ${number_of_data}=          Get Json Value    ${response}    /data/number_of_data
    ${total_number_of_data}=    Get Json Value    ${response}    /data/total_number_of_data
    ${page}=                    Get Json Value    ${response}    /data/page
    ${total_page}=              Get Json Value    ${response}    /data/total_page
    ${is_last_page}=            Get Json Value    ${response}    /data/is_last_page
    Should Be Equal As Numbers    ${number_of_data}          1
    Should Be Equal As Numbers    ${total_number_of_data}    2
    Should Be Equal As Numbers    ${page}                    1
    Should Be Equal As Numbers    ${total_page}              2
    Should Be Equal               ${is_last_page}            false
    @{product_pkey_list}=    Create List
    Append To List    ${product_pkey_list}   @{data_value1}[1]
    Verify Response From API GET Product     ${response}    ${product_pkey_list}

    ${response}=    Get Product Under Category By Category ID    ${cate_pkey}    ?display_option=product&page=2&limit=1
    Verify Success Response Status Code and Message
    Verify number of data          ${response}    1
    Verify total number of data    ${response}    2
    Verify page                    ${response}    2
    Verify total page              ${response}    2
    Verify is last page            ${response}    true
    @{product_pkey_list}=    Create List
    Append To List    ${product_pkey_list}   @{data_value2}[1]
    Verify Response From API GET Product     ${response}    ${product_pkey_list}

TC_ITMWM_05067 GET: /categories/:category_pkey/products - get category for display_option = product with sort_by = publish - success 200
    [Tags]    TC_ITMWM_05067    phoenix    regression    ready
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cate_id}=       Get Category ID After Creating
    ${cate_pkey}=     Get Category Pkey After Creating
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cate_pkey}    &{product-disc-5}[pkey]
    @{data_value2}=    Create List    ${cate_pkey}    &{product-disc-6}[pkey]
    @{data_value3}=    Create List    ${cate_pkey}    &{product-disc-7}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}    ${data_value3}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}
    Set Test Variable    ${response_code}       @{response}[0]
    Set Test Variable    ${response_content}    @{response}[1]

    ${expected_total_rows}=    Set Variable    3
    &{display_item_1}=    Create Dictionary    category_key=@{data_value1}[0]    product_key=@{data_value1}[1]    status=Success
    &{display_item_2}=    Create Dictionary    category_key=@{data_value2}[0]    product_key=@{data_value2}[1]    status=Success
    &{display_item_3}=    Create Dictionary    category_key=@{data_value3}[0]    product_key=@{data_value3}[1]    status=Success
    &{expected_display}=    Create Dictionary    2=&{display_item_1}    3=&{display_item_2}    4=&{display_item_3}
    Verify Success Response Status Code and Content From Add/Replace Products To Categories    ${expected_total_rows}    ${expected_display}

    #..Test Steps
    ${response}=    Get Product Under Category By Category ID    ${cate_pkey}    ?display_option=product&sort_by=publish
    Verify Success Response Status Code and Message
    Verify number of data          ${response}    3
    Verify total number of data    ${response}    3
    Verify page                    ${response}    1
    Verify total page              ${response}    1
    Verify is last page            ${response}    true

    Verify Sort By Published At     ${response}
    # ${expected_sorting_pkey}=    Create List    @{data_value1}[1]    @{data_value2}[1]    @{data_value3}[1]
    @{product_pkey_list}=    Create List
    Append To List    ${product_pkey_list}   @{data_value1}[1]    @{data_value2}[1]    @{data_value3}[1]
    Verify Response From API GET Product     ${response}    ${product_pkey_list}
    # ${result_pkey}=    Verify Sorting by Product Pkey    ${response}    3
    # Lists Should Be Equal    ${result_pkey}    ${expected_sorting_pkey}

TC_ITMWM_05068 GET: /categories/:category_pkey/products - get category for display_option = product with sort_by = update - success 200
    [Tags]    TC_ITMWM_05068    phoenix    regression    ready
    #..Prerequisite: There is category that has product on system
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cate_id}=       Get Category ID After Creating
    ${cate_pkey}=     Get Category Pkey After Creating
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cate_pkey}    &{product-disc-5}[pkey]
    @{data_value2}=    Create List    ${cate_pkey}    &{product-disc-6}[pkey]
    @{data_value3}=    Create List    ${cate_pkey}    &{product-disc-7}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}    ${data_value3}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}
    Set Test Variable    ${response_code}       @{response}[0]
    Set Test Variable    ${response_content}    @{response}[1]

    ${expected_total_rows}=    Set Variable    3
    &{display_item_1}=    Create Dictionary    category_key=@{data_value1}[0]    product_key=@{data_value1}[1]    status=Success
    &{display_item_2}=    Create Dictionary    category_key=@{data_value2}[0]    product_key=@{data_value2}[1]    status=Success
    &{display_item_3}=    Create Dictionary    category_key=@{data_value3}[0]    product_key=@{data_value3}[1]    status=Success
    &{expected_display}=    Create Dictionary    2=&{display_item_1}    3=&{display_item_2}    4=&{display_item_3}
    Verify Success Response Status Code and Content From Add/Replace Products To Categories    ${expected_total_rows}    ${expected_display}

    #..Test Steps
    ${response}=    Get Product Under Category By Category ID    ${cate_pkey}    ?display_option=product&sort_by=update
    Verify Success Response Status Code and Message
    Verify number of data          ${response}    3
    Verify total number of data    ${response}    3
    Verify page                    ${response}    1
    Verify total page              ${response}    1
    Verify is last page            ${response}    true

    Verify Sort By Updated At    ${response}
    @{product_pkey_list}=    Create List
    Append To List    ${product_pkey_list}   @{data_value1}[1]    @{data_value2}[1]    @{data_value3}[1]
    Verify Response From API GET Product     ${response}    ${product_pkey_list}

TC_ITMWM_05069 GET: /categories/:category_pkey/products - get category for display_option = product with sort_by = price - success 200
    [Tags]    TC_ITMWM_05069    phoenix    regression    ready
    #..Prerequisite: There is category that has product on system
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cate_id}=      Get Category ID After Creating
    ${cate_pkey}=    Get Category Pkey After Creating
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cate_pkey}    &{product-disc-5}[pkey]
    @{data_value2}=    Create List    ${cate_pkey}    &{product-disc-6}[pkey]
    @{data_value3}=    Create List    ${cate_pkey}    &{product-disc-7}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}    ${data_value3}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}
    Set Test Variable    ${response_code}       @{response}[0]
    Set Test Variable    ${response_content}    @{response}[1]

    ${expected_total_rows}=    Set Variable    3
    &{display_item_1}=    Create Dictionary    category_key=@{data_value1}[0]    product_key=@{data_value1}[1]    status=Success
    &{display_item_2}=    Create Dictionary    category_key=@{data_value2}[0]    product_key=@{data_value2}[1]    status=Success
    &{display_item_3}=    Create Dictionary    category_key=@{data_value3}[0]    product_key=@{data_value3}[1]    status=Success
    &{expected_display}=    Create Dictionary    2=&{display_item_1}    3=&{display_item_2}    4=&{display_item_3}
    Verify Success Response Status Code and Content From Add/Replace Products To Categories    ${expected_total_rows}    ${expected_display}

    #..Test Steps1
    ${response}=    Get Product Under Category By Category ID    ${cate_pkey}    ?display_option=product&sort_by=price
    Verify Success Response Status Code and Message
    Verify number of data          ${response}    3
    Verify total number of data    ${response}    3
    Verify page                    ${response}    1
    Verify total page              ${response}    1
    Verify is last page            ${response}    true

    Verify Sort By Price Order By ASC     ${response}
    @{product_pkey_list}=    Create List
    Append To List    ${product_pkey_list}   @{data_value1}[1]    @{data_value2}[1]    @{data_value3}[1]
    Verify Response From API GET Product     ${response}    ${product_pkey_list}

    #..Test Steps2
    ${response}=    Get Product Under Category By Category ID    ${cate_pkey}    ?display_option=product&sort_by=price&order=desc
    Verify Success Response Status Code and Message
    Verify number of data          ${response}    3
    Verify total number of data    ${response}    3
    Verify page                    ${response}    1
    Verify total page              ${response}    1
    Verify is last page            ${response}    true

    Verify Sort By Price Order By DESC    ${response}
    @{product_pkey_list}=    Create List
    Append To List    ${product_pkey_list}   @{data_value1}[1]    @{data_value2}[1]    @{data_value3}[1]
    Verify Response From API GET Product     ${response}    ${product_pkey_list}

TC_ITMWM_05070 GET: /categories/:category_pkey/products - get category for display_option = product with sort_by = %discount - success 200
    [Tags]    TC_ITMWM_05070    phoenix    regression    ready
    #..Prerequisite: There is category that has product on system
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cate_id}=      Get Category ID After Creating
    ${cate_pkey}=    Get Category Pkey After Creating
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cate_pkey}    &{product-disc-5}[pkey]
    @{data_value2}=    Create List    ${cate_pkey}    &{product-disc-6}[pkey]
    @{data_value3}=    Create List    ${cate_pkey}    &{product-disc-7}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}    ${data_value3}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}
    Set Test Variable    ${response_code}       @{response}[0]
    Set Test Variable    ${response_content}    @{response}[1]

    ${expected_total_rows}=    Set Variable    3
    &{display_item_1}=    Create Dictionary    category_key=@{data_value1}[0]    product_key=@{data_value1}[1]    status=Success
    &{display_item_2}=    Create Dictionary    category_key=@{data_value2}[0]    product_key=@{data_value2}[1]    status=Success
    &{display_item_3}=    Create Dictionary    category_key=@{data_value3}[0]    product_key=@{data_value3}[1]    status=Success
    &{expected_display}=    Create Dictionary    2=&{display_item_1}    3=&{display_item_2}    4=&{display_item_3}
    Verify Success Response Status Code and Content From Add/Replace Products To Categories    ${expected_total_rows}    ${expected_display}

    #..Test Steps1
    ${response}=    Get Product Under Category By Category ID    ${cate_pkey}    ?display_option=product&sort_by=discount
    Verify Success Response Status Code and Message
    Verify number of data          ${response}    3
    Verify total number of data    ${response}    3
    Verify page                    ${response}    1
    Verify total page              ${response}    1
    Verify is last page            ${response}    true

    Verify Sort By Percent Discoount Order By ASC     ${response}
    @{product_pkey_list}=    Create List
    Append To List    ${product_pkey_list}   @{data_value1}[1]    @{data_value2}[1]    @{data_value3}[1]
    Verify Response From API GET Product     ${response}    ${product_pkey_list}

    #..Test Steps1
    ${response}=    Get Product Under Category By Category ID    ${cate_pkey}    ?display_option=product&sort_by=discount&order=desc
    Verify Success Response Status Code and Message
    Verify number of data          ${response}    3
    Verify total number of data    ${response}    3
    Verify page                    ${response}    1
    Verify total page              ${response}    1
    Verify is last page            ${response}    true

    Verify Sort By Percent Discoount Order By DESC     ${response}
    @{product_pkey_list}=    Create List
    Append To List    ${product_pkey_list}   @{data_value1}[1]    @{data_value2}[1]    @{data_value3}[1]
    Verify Response From API GET Product     ${response}    ${product_pkey_list}

TC_ITMWM_05071 GET: /categories/:category_pkey/products - get category for display_option = product with status = active - success 200
    [Tags]    TC_ITMWM_05071    phoenix    regression    ready
    #..Prerequisite: There is category that has product on system
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=               Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Success Response Status Code and Message
    ${cate_pkey}=    Get Category Pkey After Creating
    ${cate_id}=      Get Category ID After Creating

    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cate_pkey}    &{product-disc-5}[pkey]
    @{data_value2}=    Create List    ${cate_pkey}    &{product-disc-6}[pkey]
    @{data_value3}=    Create List    ${cate_pkey}    &{product-disc-8}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}    ${data_value3}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}
    Set Test Variable    ${response_code}       @{response}[0]
    Set Test Variable    ${response_content}    @{response}[1]
    Verify Success Response Status Code and Message From Add/Replace Products To Categories

    #..Test Steps
    ${response}=    Get Product Under Category By Category ID    ${cate_pkey}    ?display_option=product&status=active
    Verify Success Response Status Code and Message
    @{product_pkey_list}=    Create List
    Append To List    ${product_pkey_list}   @{data_value1}[1]   @{data_value2}[1]
    Verify Response From API GET Product     ${response}    ${product_pkey_list}

TC_ITMWM_05072 GET: /categories/:category_pkey/products - get category for display_option = product with status = inactive - success 200
    [Tags]    TC_ITMWM_05072    phoenix    regression    ready
    #..Prerequisite: There is category that has product on system
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=               Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Success Response Status Code and Message
    ${cate_pkey}=    Get Category Pkey After Creating
    ${cate_id}=      Get Category ID After Creating

    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cate_pkey}    &{product-disc-5}[pkey]
    @{data_value2}=    Create List    ${cate_pkey}    &{product-disc-6}[pkey]
    @{data_value3}=    Create List    ${cate_pkey}    &{product-disc-8}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}    ${data_value3}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}
    Set Test Variable    ${response_code}       @{response}[0]
    Set Test Variable    ${response_content}    @{response}[1]
    Verify Success Response Status Code and Message From Add/Replace Products To Categories

    #..Test Steps
    ${response}=    Get Product Under Category By Category ID    ${cate_pkey}    ?display_option=product&status=inactive
    Verify Success Response Status Code and Message
    @{product_pkey_list}=    Create List
    Append To List    ${product_pkey_list}   @{data_value3}[1]
    Verify Response From API GET Product     ${response}    ${product_pkey_list}

TC_ITMWM_05075 GET: /categories/:category_pkey/products - get category for display_option = product with limit, page, publish, status = active and order = desc - success 200
    [Tags]    TC_ITMWM_05075    phoenix    regression     ready
    #..Prerequisite: There is category that has product on system
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cate_id}=      Get Category ID After Creating
    ${cate_pkey}=    Get Category Pkey After Creating
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cate_pkey}    &{product-disc-5}[pkey]
    @{data_value2}=    Create List    ${cate_pkey}    &{product-disc-6}[pkey]
    @{data_value3}=    Create List    ${cate_pkey}    &{product-disc-7}[pkey]
    @{data_value4}=    Create List    ${cate_pkey}    &{product-disc-8}[pkey]    #->inactive status
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}    ${data_value3}    ${data_value4}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}
    Set Test Variable    ${response_code}       @{response}[0]
    Set Test Variable    ${response_content}    @{response}[1]

    ${expected_total_rows}=    Set Variable    4
    &{display_item_1}=    Create Dictionary    category_key=@{data_value1}[0]    product_key=@{data_value1}[1]    status=Success
    &{display_item_2}=    Create Dictionary    category_key=@{data_value2}[0]    product_key=@{data_value2}[1]    status=Success
    &{display_item_3}=    Create Dictionary    category_key=@{data_value3}[0]    product_key=@{data_value3}[1]    status=Success
    &{display_item_4}=    Create Dictionary    category_key=@{data_value4}[0]    product_key=@{data_value4}[1]    status=Success
    &{expected_display}=    Create Dictionary    2=&{display_item_1}    3=&{display_item_2}    4=&{display_item_3}    5=&{display_item_4}
    Verify Success Response Status Code and Content From Add/Replace Products To Categories    ${expected_total_rows}    ${expected_display}

    #..Test Steps1
    ${response}=    Get Product Under Category By Category ID    ${cate_pkey}    ?display_option=product&limit=2&page=1&sort_by=publish&status=active&order=asc
    Verify Success Response Status Code and Message
    Verify number of data          ${response}    2
    Verify total number of data    ${response}    3
    Verify page                    ${response}    1
    Verify total page              ${response}    2
    Verify is last page            ${response}    false

    Verify Sort By Published At     ${response}    asc
    @{product_pkey_list}=    Create List
    Append To List    ${product_pkey_list}   @{data_value1}[1]    @{data_value3}[1]
    Verify Response From API GET Product     ${response}    ${product_pkey_list}

    #..Test Steps2
    ${response}=    Get Product Under Category By Category ID    ${cate_pkey}    ?display_option=product&limit=2&page=2&sort_by=publish&status=active&order=asc
    Verify Success Response Status Code and Message
    Verify number of data          ${response}    1
    Verify total number of data    ${response}    3
    Verify page                    ${response}    2
    Verify total page              ${response}    2
    Verify is last page            ${response}    true

    Verify Sort By Price Order By ASC     ${response}
    @{product_pkey_list}=    Create List
    Append To List    ${product_pkey_list}   @{data_value2}[1]
    Verify Response From API GET Product     ${response}    ${product_pkey_list}

TC_ITMWM_05076 GET: /categories/:category_pkey/products - get category for display_option = product with limit, page, price, status = inactive and order = asc - success 200
    [Tags]     TC_ITMWM_05076    phoenix    regression     ready
    #..Prerequisite: There is category that has product on system
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cate_id}=      Get Category ID After Creating
    ${cate_pkey}=    Get Category Pkey After Creating
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cate_pkey}    &{product-disc-5}[pkey]
    @{data_value2}=    Create List    ${cate_pkey}    &{product-disc-8}[pkey]    #->inactive status
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}
    Set Test Variable    ${response_code}       @{response}[0]
    Set Test Variable    ${response_content}    @{response}[1]

    ${expected_total_rows}=    Set Variable    2
    &{display_item_1}=    Create Dictionary    category_key=@{data_value1}[0]    product_key=@{data_value1}[1]    status=Success
    &{display_item_2}=    Create Dictionary    category_key=@{data_value2}[0]    product_key=@{data_value2}[1]    status=Success
    &{expected_display}=    Create Dictionary    2=&{display_item_1}    3=&{display_item_2}
    Verify Success Response Status Code and Content From Add/Replace Products To Categories    ${expected_total_rows}    ${expected_display}

    #..Test Steps1
    ${response}=    Get Product Under Category By Category ID    ${cate_pkey}    ?display_option=product&limit=1&page=1&sort_by=price&status=inactive&order=asc
    Verify Success Response Status Code and Message
    Verify number of data          ${response}    1
    Verify total number of data    ${response}    1
    Verify page                    ${response}    1
    Verify total page              ${response}    1
    Verify is last page            ${response}    true

    @{product_pkey_list}=    Create List
    Append To List    ${product_pkey_list}   @{data_value2}[1]
    Verify Product Inactive Status Between Data From Response and DB    ${response}    ${product_pkey_list}

TC_ITMWM_05077 GET: /categories/:category_pkey/products - get category for display_option = product with non-filter - success 200
    [Tags]    TC_ITMWM_05077    phoenix    regression
    #..Prerequisite: There is category that has product on system
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cate_id}=      Get Category ID After Creating
    ${cate_pkey}=    Get Category Pkey After Creating
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cate_pkey}    &{product-disc-5}[pkey]
    @{data_value2}=    Create List    ${cate_pkey}    &{product-disc-6}[pkey]
    @{data_value3}=    Create List    ${cate_pkey}    &{product-disc-7}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}    ${data_value3}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}
    Set Test Variable    ${response_code}       @{response}[0]
    Set Test Variable    ${response_content}    @{response}[1]

    ${expected_total_rows}=    Set Variable    3
    &{display_item_1}=    Create Dictionary    category_key=@{data_value1}[0]    product_key=@{data_value1}[1]    status=Success
    &{display_item_2}=    Create Dictionary    category_key=@{data_value2}[0]    product_key=@{data_value2}[1]    status=Success
    &{display_item_3}=    Create Dictionary    category_key=@{data_value3}[0]    product_key=@{data_value3}[1]    status=Success
    &{expected_display}=    Create Dictionary    2=&{display_item_1}    3=&{display_item_2}    4=&{display_item_3}
    Verify Success Response Status Code and Content From Add/Replace Products To Categories    ${expected_total_rows}    ${expected_display}

    #..Test Steps
    ${response}=    Get Product Under Category By Category ID    ${cate_pkey}    ?display_option=product
    Verify Success Response Status Code and Message
    Verify number of data          ${response}    3
    Verify total number of data    ${response}    3
    Verify page                    ${response}    1
    Verify total page              ${response}    1
    Verify is last page            ${response}    true

    @{product_pkey_list}=    Create List
    Append To List    ${product_pkey_list}   @{data_value1}[1]    @{data_value2}[1]    @{data_value3}[1]
    Verify Response From API GET Product     ${response}    ${product_pkey_list}

TC_ITMWM_05078 GET: /categories/:category_pkey/products - get category by non-existing category ID - fail 404
    [Tags]    TC_ITMWM_05078    phoenix    ready    regression
    #..Prerequisite: There is category that has no product on system
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cate_id}=      Get Category ID After Creating
    ${cate_pkey}=    Get Category Pkey After Creating
    ${non_cate_pkey}=    Evaluate    ${cate_pkey}+100
    #..Test Steps
    ${response}=    Get Product Under Category By Category ID    ${non_cate_pkey}    ?display_option=product
    Verify Fail Response Status Code and Message    404    error    Not found category

TC_ITMWM_05079 GET: /categories/:category_pkey/products - get category that was deleted by category ID - fail 404
    [Tags]    TC_ITMWM_05079    phoenix    ready    regression
    #..Prerequisite: There is category that has product on system
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cate_id}=      Get Category ID After Creating
    ${cate_pkey}=    Get Category Pkey After Creating
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cate_pkey}    &{product-disc-5}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}
    Set Test Variable    ${response_code}       @{response}[0]
    Set Test Variable    ${response_content}    @{response}[1]

    ${expected_total_rows}=    Set Variable    1
    &{display_item_1}=    Create Dictionary    category_key=@{data_value1}[0]    product_key=@{data_value1}[1]    status=Success
    &{expected_display}=    Create Dictionary    2=&{display_item_1}
    Verify Success Response Status Code and Content From Add/Replace Products To Categories    ${expected_total_rows}    ${expected_display}

    #.. delete category
    Delete Category By Category ID    ${cate_id}

    #..Test Steps
    Get Product Under Category By Category ID    ${cate_pkey}    ?display_option=product
    Verify Fail Response Status Code and Message    404    error    Not found category

TC_ITMWM_05080 GET: /categories/:category_pkey/products - get category by String - fail 400
    [Tags]     TC_ITMWM_05080    phoenix    ready    regression
    #..Prerequisite: There is category that has product on system
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cate_id}=      Get Category ID After Creating
    ${cate_pkey}=    Get Category Pkey After Creating
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cate_pkey}    &{product-disc-5}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}
    Set Test Variable    ${response_code}       @{response}[0]
    Set Test Variable    ${response_content}    @{response}[1]

    ${expected_total_rows}=    Set Variable    1
    &{display_item_1}=    Create Dictionary    category_key=@{data_value1}[0]    product_key=@{data_value1}[1]    status=Success
    &{expected_display}=    Create Dictionary    2=&{display_item_1}
    Verify Success Response Status Code and Content From Add/Replace Products To Categories    ${expected_total_rows}    ${expected_display}

    #..Test Steps
    ${response}=    Get Product Under Category By Category ID    C01    ?display_option=product
    Verify Fail Response Status Code and Message    400    error    Pkey length must be 14

    ${response}=    Get Product Under Category By Category ID    ()_&*    ?display_option=product
    Verify Fail Response Status Code and Message    400    error    Pkey length must be 14

    ${response}=    Get Product Under Category By Category ID    ${SPACE}${cate_pkey}    ?display_option=product
    Verify Fail Response Status Code and Message    400    error    Pkey length must be 14

    ${response}=    Get Product Under Category By Category ID    %20${cate_pkey}    ?display_option=product
    Verify Fail Response Status Code and Message    400    error    Pkey length must be 14


TC_ITMWM_05071 GET: /categories/:category_pkey/products - get category for display_option = product with status = active - success 200
    [Tags]    TC_ITMWM_05071    phoenix    ready
    #..Prerequisite: There is category that has product on system
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=               Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Success Response Status Code and Message
    ${cate_pkey}=    Get Category Pkey After Creating
    ${cate_id}=      Get Category ID After Creating

    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cate_pkey}    &{product-disc-5}[pkey]
    @{data_value2}=    Create List    ${cate_pkey}    &{product-disc-6}[pkey]
    @{data_value3}=    Create List    ${cate_pkey}    &{product-disc-8}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}    ${data_value3}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}
    Set Test Variable    ${response_code}       @{response}[0]
    Set Test Variable    ${response_content}    @{response}[1]
    Verify Success Response Status Code and Message From Add/Replace Products To Categories

    #..Test Steps
    ${response}=    Get Product Under Category By Category ID    ${cate_pkey}    ?display_option=product&status=active
    Verify Success Response Status Code and Message
    @{product_pkey_list}=    Create List
    Append To List    ${product_pkey_list}   @{data_value1}[1]   @{data_value2}[1]
    Verify Response From API GET Product     ${response}    ${product_pkey_list}

TC_ITMWM_05072 GET: /categories/:category_pkey/products - get category for display_option = product with status = inactive - success 200
    [Tags]    TC_ITMWM_05072    phoenix    ready
    #..Prerequisite: There is category that has product on system
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=               Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Success Response Status Code and Message
    ${cate_pkey}=    Get Category Pkey After Creating
    ${cate_id}=      Get Category ID After Creating

    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cate_pkey}    &{product-disc-5}[pkey]
    @{data_value2}=    Create List    ${cate_pkey}    &{product-disc-6}[pkey]
    @{data_value3}=    Create List    ${cate_pkey}    &{product-disc-8}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}    ${data_value3}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}
    Set Test Variable    ${response_code}       @{response}[0]
    Set Test Variable    ${response_content}    @{response}[1]
    Verify Success Response Status Code and Message From Add/Replace Products To Categories

    #..Test Steps
    ${response}=    Get Product Under Category By Category ID    ${cate_pkey}    ?display_option=product&status=inactive
    Verify Success Response Status Code and Message
    @{product_pkey_list}=    Create List
    Append To List    ${product_pkey_list}   @{data_value3}[1]
    Verify Product Inactive Status Between Data From Response and DB    ${response}    ${product_pkey_list}

TC_ITMWM_05073 GET: /categories/:category_pkey/products - get category for display_option = product with order = desc - success 200
    [Tags]    TC_ITMWM_05073    phoenix    regression
    #..Prerequisite: There is category that has product on system
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=               Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Success Response Status Code and Message
    ${cate_pkey}=    Get Category Pkey After Creating
    ${cate_id}=      Get Category ID After Creating

    ### update ###
    ## optional fields with values
    ${update_json}=    Create Dictionary    sort_by="update"
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    Update Category    ${cate_id}    ${file_data}
    Verify Success Response Status Code and Message

    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cate_pkey}    &{product-disc-5}[pkey]
    @{data_value2}=    Create List    ${cate_pkey}    &{product-disc-6}[pkey]
    @{data_value3}=    Create List    ${cate_pkey}    &{product-disc-8}[pkey]    #inactive status
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}    ${data_value3}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}
    Set Test Variable    ${response_code}       @{response}[0]
    Set Test Variable    ${response_content}    @{response}[1]
    Verify Success Response Status Code and Message From Add/Replace Products To Categories

    #..Test Steps
    ${response}=    Get Product Under Category By Category ID    ${cate_pkey}    ?display_option=product&order=desc
    Verify Success Response Status Code and Message
    @{product_pkey_list}=    Create List
    Append To List    ${product_pkey_list}   @{data_value1}[1]    @{data_value2}[1]
    Verify Response From API GET Product    ${response}    ${product_pkey_list}
    Verify Sort By Updated At    ${response}    desc

TC_ITMWM_05074 GET: /categories/:category_pkey/products - get category for display_option = product with order = asc - success 200
    [Tags]    TC_ITMWM_05074    phoenix    regression
    #..Prerequisite: There is category that has product on system
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=               Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Success Response Status Code and Message
    ${cate_pkey}=    Get Category Pkey After Creating
    ${cate_id}=      Get Category ID After Creating

    ### update ###
    ## optional fields with values
    ${update_json}=    Create Dictionary    sort_by="update"
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    Update Category    ${cate_id}    ${file_data}
    Verify Success Response Status Code and Message

    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cate_pkey}    &{product-disc-5}[pkey]
    @{data_value2}=    Create List    ${cate_pkey}    &{product-disc-6}[pkey]
    @{data_value3}=    Create List    ${cate_pkey}    &{product-disc-8}[pkey]    #inactive status
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}    ${data_value3}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}
    Set Test Variable    ${response_code}       @{response}[0]
    Set Test Variable    ${response_content}    @{response}[1]
    Verify Success Response Status Code and Message From Add/Replace Products To Categories

    #..Test Steps
    ${response}=    Get Product Under Category By Category ID    ${cate_pkey}    ?display_option=product&order=asc
    Verify Success Response Status Code and Message
    @{product_pkey_list}=    Create List
    Append To List    ${product_pkey_list}   @{data_value1}[1]    @{data_value2}[1]
    Verify Response From API GET Product    ${response}    ${product_pkey_list}
    Verify Sort By Updated At    ${response}    asc