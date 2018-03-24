*** Setting ***
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           BuiltIn
Library           String
Library           Collections
Library           DatabaseLibrary
Library           ${CURDIR}/../../../Python_Library/common.py
Library           ${CURDIR}/../../../Python_Library/FileKeyword.py
Library           ${CURDIR}/../../../Python_Library/common/uploadsoperation.py
Library           ${CURDIR}/../../../Python_Library/common/csvlibrary.py
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/API/PDS/pds_api_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/User_Role/Keywords_User_Role.robot
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PDS/Keywords_PDS_Mass_Upload_Product_To_Category.robot
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PDS/Keywords_PDS_Common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Category_Merchant/keywords_category.robot
Resource          ${CURDIR}/../../../Keyword/API/PDS/pds_api_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PDS/webelement_PCMS_Category_Mass_Upload_Product.robot
Test Setup        Run Keywords    Login Pcms    AND    Maximize Browser Window

*** Variables ***
#group
${user_role_group}                 manage mass upload product category
#role
${category_manage_mass_upload}     category_mass-upload-product

#user
${pcms_email_manage_mass_upload}    phoenix_manage_mass_upload@test.com
${pcms_display_name_manage_cate}    phoenix
${pcms_password_manage_cate}        12345

#data
${parent_id}    1
${cat_id}       ${EMPTY}
${message_success_template}         Uploaded ??number?? product(s) successfully.
${text_cannot_access}               You don't have permission to access this page.
${text_header_cannot_access}        Can't access.
${select_merchant_label}            Merchant-phoenix ( WP9999 )
${cate_name}                        catephoenix
${cate_name_trans}                  catephoenixEN
${expected_slug}                    catephoenixen
${text_cannot_access}        You don't have permission to access this page.
${text_header_cannot_access}    Can't access.
#${expected_cannot_access1}           Can't access.
#${expected_cannot_access2}           You don't have permission to access this page.

*** Test Cases ***
test_01 Mass upload: User can view and manage category
    [Documentation]    role-manage = allow    user manage = inherite
    [Tags]    phoenix   manage_mass_product_category    ready
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${category_manage_mass_upload}
    PCMS Set Permission In Role   ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_manage_mass_upload}    ${pcms_display_name_manage_cate}    ${pcms_password_manage_cate}    ${user_role_group}
    Close Browser

    Login Pcms    ${pcms_email_manage_mass_upload}    ${pcms_password_manage_cate}

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
    @{data}=           Create List    ${data_name}    ${data_value1}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    Go To Mass Upload Product To Category Page
    Mass Upload Product to Category - Select Upload Action    add
    Mass Upload Product to Category - Choose File For Mass Upload Product    ${file_upload}
    Mass Upload Product to Category - Click Upload Button

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    1
    Mass Upload Product to Category - Verify Alert For File Verification Result    ${message_success}

    ##.. Provide file verification result
    @{file_ver_data_value1}=    Create List    2    @{data_value1}    Success
    @{file_ver_result}=         Create List    @{file_ver_data_value1}
    Mass Upload Product to Category - Verify File Verification Result    ${file_ver_result}

    ##.. Verify product under category via GET API
    ${expected_product_list}=    Create List    @{data_value1}[1]
    Mass Upload Product to Category - Category Should Have Product(s)    ${cat_pkey}    ${expected_product_list}

    [Teardown]     Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_manage_mass_upload}
    ...    AND    Clear User Role By Name    ${user_role_group}
    ...    AND    Run keyword If    "${cat_id}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id}

test_02 Mass upload: User can not view and manage category
    [Documentation]    role-manage = not allow     user manage = inherite
    [Tags]    phoenix      ready
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${category_manage_mass_upload}
    PCMS Unset Permission In Role    ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_manage_mass_upload}    ${pcms_display_name_manage_cate}    ${pcms_password_manage_cate}    ${user_role_group}
    Close Browser

    Login Pcms    ${pcms_email_manage_mass_upload}    ${pcms_password_manage_cate}
    Go To         ${PCMS_URL}/categories/mass-upload
    Sleep    5s
#    User do not have permission to access this page    ${expected_cannot_access}
    User do not have permission to access this page    ${text_header_cannot_access}\n${text_cannot_access}

    [Teardown]     Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_manage_mass_upload}
    ...    AND    Clear User Role By Name    ${user_role_group}

test_03 Mass upload: User can view and manage category(role-manage = not allow, user manage = allow)
    [Documentation]    role-manage = allow    user manage = allow
    [Tags]    phoenix     manage_mass_product_category    ready
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${category_manage_mass_upload}
    PCMS Set Permission In Role    ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_manage_mass_upload}    ${pcms_display_name_manage_cate}    ${pcms_password_manage_cate}    ${user_role_group}
    @{permission_list}=    Create List    ${category_manage_mass_upload}
    PCMS Set Permission For User      ${pcms_email_manage_mass_upload}     @{permission_list}
    Close Browser

    Login Pcms    ${pcms_email_manage_mass_upload}    ${pcms_password_manage_cate}
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
    @{data}=           Create List    ${data_name}    ${data_value1}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    Go To Mass Upload Product To Category Page
    Mass Upload Product to Category - Select Upload Action    add
    Mass Upload Product to Category - Choose File For Mass Upload Product    ${file_upload}
    Mass Upload Product to Category - Click Upload Button

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    1
    Mass Upload Product to Category - Verify Alert For File Verification Result    ${message_success}

    ##.. Provide file verification result
    @{file_ver_data_value1}=    Create List    2    @{data_value1}    Success
    @{file_ver_result}=         Create List    @{file_ver_data_value1}
    Mass Upload Product to Category - Verify File Verification Result    ${file_ver_result}

    ##.. Verify product under category via GET API
    ${expected_product_list}=    Create List    @{data_value1}[1]
    Mass Upload Product to Category - Category Should Have Product(s)    ${cat_pkey}    ${expected_product_list}

    [Teardown]     Run Keywords    Close All Browsers
    ...    AND    Permanent Delete Category By Category ID    ${cat_id}
    ...    AND    Clear User By Email    ${pcms_email_manage_mass_upload}
    ...    AND    Clear User Role By Name    ${user_role_group}

test_04 Mass upload: User can not view and manage category(role-manage = not allow/ user manage = not allow)
    [Documentation]    role-manage = not allow    user manage = not allow
    [Tags]    phoenix     manage_mass_product_category    ready
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List      ${category_manage_mass_upload}
    PCMS Unset Permission In Role    ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_manage_mass_upload}    ${pcms_display_name_manage_cate}    ${pcms_password_manage_cate}    ${user_role_group}
    @{permission_list}=    Create List    ${category_manage_mass_upload}
    PCMS Unset Permission For User    ${pcms_email_manage_mass_upload}     @{permission_list}
    Close Browser

    Login Pcms    ${pcms_email_manage_mass_upload}    ${pcms_password_manage_cate}
    Go To         ${PCMS_URL}/categories/merchant-categories
    Sleep    5s
    Capture Page Screenshot
    #User do not have permission to access this page    ${expected_cannot_access}
    User do not have permission to access this page    ${text_header_cannot_access}\n${text_cannot_access}

    [Teardown]     Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_manage_mass_upload}
    ...    AND    Clear User Role By Name    ${user_role_group}

test_05 Mass upload: User can view and manage category(role-manage = not allow, user manage = allow)
    [Documentation]    role-manage = not allow     user manage = allow
    [Tags]    manage_mass_product_category     regression    ready
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${category_manage_mass_upload}
    PCMS Unset Permission In Role      ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_manage_mass_upload}    ${pcms_display_name_manage_cate}    ${pcms_password_manage_cate}    ${user_role_group}

    @{permission_list}=    Create List    ${category_manage_mass_upload}
    PCMS Set Permission For User      ${pcms_email_manage_mass_upload}     @{permission_list}
    Close Browser

    Login Pcms    ${pcms_email_manage_mass_upload}    ${pcms_password_manage_cate}
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
    @{data}=           Create List    ${data_name}    ${data_value1}
    ${path_file}=      Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    #..Test Steps
    Go To Mass Upload Product To Category Page
    Mass Upload Product to Category - Select Upload Action    add
    Mass Upload Product to Category - Choose File For Mass Upload Product    ${file_upload}
    Mass Upload Product to Category - Click Upload Button

    ##.. Provide message success with row number
    ${message_success}=    Replace String Using Regexp    ${message_success_template}    \\?\\?.+\\?\\?    1
    Mass Upload Product to Category - Verify Alert For File Verification Result    ${message_success}

    ##.. Provide file verification result
    @{file_ver_data_value1}=    Create List    2    @{data_value1}    Success
    @{file_ver_result}=         Create List    @{file_ver_data_value1}
    Mass Upload Product to Category - Verify File Verification Result    ${file_ver_result}

    ##.. Verify product under category via GET API
    ${expected_product_list}=    Create List    @{data_value1}[1]
    Mass Upload Product to Category - Category Should Have Product(s)    ${cat_pkey}    ${expected_product_list}

    [Teardown]     Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_manage_mass_upload}
    ...    AND    Clear User Role By Name    ${user_role_group}
    ...    AND    Run keyword If    "${cat_id}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id}

test_06 Mass upload: User can not view and manage category(role-manage = Allow, user manage = Not allow)
    [Documentation]    role-manage = Allow      user manage = Not allow
    [Tags]    phoenix     ready
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${category_manage_mass_upload}
    PCMS Set Permission In Role    ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_manage_mass_upload}    ${pcms_display_name_manage_cate}    ${pcms_password_manage_cate}    ${user_role_group}
    @{permission_list}=    Create List    ${category_manage_mass_upload}
    PCMS Unset Permission For User    ${pcms_email_manage_mass_upload}     @{permission_list}
    Close Browser

    Login Pcms    ${pcms_email_manage_mass_upload}    ${pcms_password_manage_cate}
    Go To         ${PCMS_URL}/categories/merchant-categories
    Sleep    5s
    Capture Page Screenshot
    #User do not have permission to access this page    ${expected_cannot_access}
    User do not have permission to access this page    ${text_header_cannot_access}\n${text_cannot_access}

    [Teardown]     Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_manage_mass_upload}
    ...    AND    Clear User Role By Name    ${user_role_group}
