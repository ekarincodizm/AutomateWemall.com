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
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/Database/PDS/keyword_categories.robot
Resource          ${CURDIR}/../../../Keyword/API/PDS/pds_api_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PDS/Keywords_PDS_Common.robot
Resource          ${CURDIR}/../../../Resource/init.robot
Test Teardown     Run keyword If    "${cat_id}" != "${EMPTY}"    Run Keywords    Log    ${cat_id}    AND    Permanent Delete Category By Category ID    ${cat_id}

*** Variables ***
${parent_id}     1
${cat_id}        ${EMPTY}

*** Test Cases ***
TC_ITMWM_05040 POST: /products/categories - Add product into category via mass upload - success 200
    [Tags]    TC_ITMWM_05040    regression    ready    phoenix
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    ${cat_pkey}=     Get Category Pkey After Creating
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data_value2}=    Create List    ${cat_pkey}       &{product-disc-2}[pkey]
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

TC_ITMWM_05041 PUT: /products/categories - Replace existing product into category via mass upload - success 200
    [Tags]    TC_ITMWM_05041    regression    ready    phoenix
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    ${cat_pkey}=     Get Category Pkey After Creating
    # Prerequisite: There are some products in category
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data_value2}=    Create List    ${cat_pkey}       &{product-disc-2}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}

    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data_value2}=    Create List    ${cat_pkey}       &{product-disc-2}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    @{response}=    Replace Products To Categories    ${file_upload}
    Set Test Variable    ${response_code}       @{response}[0]
    Set Test Variable    ${response_content}    @{response}[1]

    ${expected_total_rows}=    Set Variable    2
    &{display_item_1}=    Create Dictionary    category_key=@{data_value1}[0]    product_key=@{data_value1}[1]    status=Success
    &{display_item_2}=    Create Dictionary    category_key=@{data_value2}[0]    product_key=@{data_value2}[1]    status=Success
    &{expected_display}=    Create Dictionary    2=&{display_item_1}    3=&{display_item_2}
    Verify Success Response Status Code and Content From Add/Replace Products To Categories    ${expected_total_rows}    ${expected_display}

TC_ITMWM_05042 PUT: /products/categories - Replace existing product and add product into category via mass upload - success 200
    [Tags]    TC_ITMWM_05042    regression    ready    phoenix
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    ${cat_pkey}=     Get Category Pkey After Creating
    # Prerequisite: There are some products in category
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data_value2}=    Create List    ${cat_pkey}       &{product-disc-2}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}

    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data_value2}=    Create List    ${cat_pkey}       &{product-disc-2}[pkey]
    @{data_value3}=    Create List    ${cat_pkey}       &{product-disc-3}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}    ${data_value3}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    @{response}=    Replace Products To Categories    ${file_upload}
    Set Test Variable    ${response_code}       @{response}[0]
    Set Test Variable    ${response_content}    @{response}[1]

    ${expected_total_rows}=    Set Variable    3
    &{display_item_1}=    Create Dictionary    category_key=@{data_value1}[0]    product_key=@{data_value1}[1]    status=Success
    &{display_item_2}=    Create Dictionary    category_key=@{data_value2}[0]    product_key=@{data_value2}[1]    status=Success
    &{display_item_3}=    Create Dictionary    category_key=@{data_value3}[0]    product_key=@{data_value3}[1]    status=Success
    &{expected_display}=    Create Dictionary    2=&{display_item_1}    3=&{display_item_2}    4=&{display_item_3}
    Verify Success Response Status Code and Content From Add/Replace Products To Categories    ${expected_total_rows}    ${expected_display}

TC_ITMWM_05043 PUT: /products/categories - Replace and delete existing product into category via mass upload - success 200
    [Tags]    TC_ITMWM_05043    regression    ready    phoenix
    # Prerequisite: There is a category
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    ${cat_pkey}=     Get Category Pkey After Creating
    # Prerequisite: There are some products in category
    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data_value2}=    Create List    ${cat_pkey}       &{product-disc-2}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    @{response}=    Add Products To Categories    ${file_upload}

    #.. Generate CSV file to be uploaded
    @{data_name}=      Create List    Category Key    Product Key
    @{data_value1}=    Create List    ${cat_pkey}       &{product-disc-1}[pkey]
    @{data_value2}=    Create List    ${cat_pkey}       &{product-disc-3}[pkey]
    @{data}=           Create List    ${data_name}    ${data_value1}    ${data_value2}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    @{response}=    Replace Products To Categories    ${file_upload}
    Set Test Variable    ${response_code}       @{response}[0]
    Set Test Variable    ${response_content}    @{response}[1]

    ${expected_total_rows}=    Set Variable    2
    &{display_item_1}=    Create Dictionary    category_key=@{data_value1}[0]    product_key=@{data_value1}[1]    status=Success
    &{display_item_2}=    Create Dictionary    category_key=@{data_value2}[0]    product_key=@{data_value2}[1]    status=Success
    &{expected_display}=    Create Dictionary    2=&{display_item_1}    3=&{display_item_2}
    Verify Success Response Status Code and Content From Add/Replace Products To Categories    ${expected_total_rows}    ${expected_display}
