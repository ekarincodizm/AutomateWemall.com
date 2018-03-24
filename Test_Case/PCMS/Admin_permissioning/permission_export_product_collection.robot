*** Setting ***
Force Tags        WLS_Admin_Permission
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/User_Role/Keywords_User_Role.robot
Resource          ${CURDIR}/../../../Keyword/Features/Create_Product/Create_Product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Export_product_collection/keywords_export_product_collection.robot

Test Setup        Login Pcms
Test Teardown     Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_export}
    ...    AND    Clear User Role By Name    ${role_group_name}

*** Variables ***
#group role
${role_group_name}                   acl export product collection group

#role
${dashboard_view}                    dashboard_view
${view_product_list}                 product_view-list
${export_product_collection}         product_export-collection-on

#user
${pcms_email_export}            flash_product_collection@test.com
${pcms_display_name_export}     flash
${pcms_password_export}         12345
${text_cannot_export}           You don't have permission to access this page.
${text_header_cannot_access}    Can't access.

${result_verify}         Upload passed. Please waiting download
${result_success}        Download success
# ${file_upload}                  ${CURDIR}/../../../Resource/TestData/Collection/csv_file/product2collection_collection_not_exist.csv

*** Test Cases ***
TC_iTM_02459 - Can export product collection - Success
    [Tags]    Category    Collection    Admin_permissioning    Product    TC_iTM_02459    regression    ready    flash    WLS_High
    [Documentation]    Group role-view = 1(User permission is inherit.)
    PCMS Created User Role    ${role_group_name}
    @{permission_list}=    Create List    ${dashboard_view}    ${export_product_collection}
    PCMS Set Permission In Role   ${role_group_name}    @{permission_list}
    PCMS Created User    ${pcms_email_export}    ${pcms_display_name_export}    ${pcms_password_export}    ${role_group_name}
    Close Browser

    Login Pcms    ${pcms_email_export}    ${pcms_password_export}

    Insert collection
    ${pkey}=        Insert product with retail type
    ${pkey1}=       Insert product with retail type
    ${pkey2}=       Insert product with marketplace type
    @{data_name}=       Create List     Product Key
    @{data_value1}=     Create List     ${pkey1}
    @{data_value2}=     Create List     ${pkey2}
    @{data}=     Create List     ${data_name}     ${data_value1}     ${data_value2}
    Log To Console     ${data}

    ${path_file}=      Set product key in file csv product collection     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    Go to export product collection menu
    User browse file for upload export product collection     ${file_upload}
    Upload result is displayed    ${result_verify}
    downloaded result is displayed    ${result_success}
    ${cookies}    Get Cookies
    check file download    ${cookies}


TC_iTM_02460 - Cannot export collection on Product(so cannot operate the action)
    [Tags]    Category    Collection    Admin_permissioning    Product    TC_iTM_02460    regression    ready    flash    WLS_Medium
    [Documentation]    Group role (view) = 0
    PCMS Created User Role    ${role_group_name}
    @{permission_list}=    Create List    ${dashboard_view}    ${view_product_list}
    PCMS Set Permission In Role   ${role_group_name}    @{permission_list}

    @{permission_list}=    Create List    ${export_product_collection}
    PCMS Unset Permission In Role   ${role_group_name}    @{permission_list}
    PCMS Created User    ${pcms_email_export}    ${pcms_display_name_export}    ${pcms_password_export}    ${role_group_name}
    Close Browser

    Login Pcms    ${pcms_email_export}    ${pcms_password_export}
    Cannot see export product collection menu

TC_iTM_02461 - Can export collection on product
    [Documentation]    User permission is inherit.(User-view = 1/Role-view = 1)
    [Tags]    Category    Collection    Admin_permissioning    Product    TC_iTM_02461    ready    flash    regression    WLS_Medium
    PCMS Created User Role    ${role_group_name}
    @{permission_list}=    Create List    ${dashboard_view}    ${export_product_collection}
    PCMS Set Permission In Role   ${role_group_name}    @{permission_list}

    PCMS Created User    ${pcms_email_export}    ${pcms_display_name_export}    ${pcms_password_export}    ${role_group_name}
    @{permission_list}=    Create List    ${export_product_collection}
    PCMS Set Permission For User    ${pcms_email_export}    @{permission_list}
    Close Browser

    Login Pcms    ${pcms_email_export}    ${pcms_password_export}
    Insert collection
    ${pkey}=        Insert product with retail type
    ${pkey1}=       Insert product with retail type
    ${pkey2}=       Insert product with marketplace type
    @{data_name}=       Create List     Product Key
    @{data_value1}=     Create List     ${pkey1}
    @{data_value2}=     Create List     ${pkey2}
    @{data}=     Create List     ${data_name}     ${data_value1}     ${data_value2}
    Log To Console     ${data}

    ${path_file}=      Set product key in file csv product collection     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    Go to export product collection menu
    User browse file for upload export product collection     ${file_upload}
    Upload result is displayed    ${result_verify}
    downloaded result is displayed    ${result_success}
    ${cookies}    Get Cookies
    check file download    ${cookies}


TC_iTM_02462 - Can export product collection(cross role permission) - Success
    [Tags]    Category     Collection     Admin_permissioning     Product    TC_iTM_02462    regression    ready    flash    WLS_Medium
    [Documentation]    Cross role permission(user-view = 1/ role-view = 0)
    PCMS Created User Role    ${role_group_name}
    @{permission_list}=    Create List    ${dashboard_view}
    PCMS Set Permission In Role   ${role_group_name}    @{permission_list}
    PCMS Created User    ${pcms_email_export}    ${pcms_display_name_export}    ${pcms_password_export}    ${role_group_name}

    @{permission_list}=    Create List    ${export_product_collection}
    PCMS Set Permission For User    ${pcms_email_export}    @{permission_list}
    Close Browser

    Login Pcms    ${pcms_email_export}    ${pcms_password_export}
    Insert collection
    ${pkey}=        Insert product with retail type
    ${pkey1}=       Insert product with retail type
    ${pkey2}=       Insert product with marketplace type
    @{data_name}=       Create List     Product Key
    @{data_value1}=     Create List     ${pkey1}
    @{data_value2}=     Create List     ${pkey2}
    @{data}=     Create List     ${data_name}     ${data_value1}     ${data_value2}
    Log To Console     ${data}

    ${path_file}=      Set product key in file csv product collection     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    Go to export product collection menu
    User browse file for upload export product collection     ${file_upload}
    Upload result is displayed    ${result_verify}
    downloaded result is displayed    ${result_success}
    ${cookies}    Get Cookies
    check file download    ${cookies}

TC_iTM_02463 - Cannot view product collection exported(cross between user permission and role permission
    [Tags]    Category     Collection     Admin_permissioning     Product    TC_iTM_02463    ready    regression    flash    WLS_Medium
    [Documentation]    user-view = 0/ role-view = 1
    PCMS Created User Role    ${role_group_name}
    @{permission_list}=    Create List    ${dashboard_view}    ${export_product_collection}    ${view_product_list}
    PCMS Set Permission In Role   ${role_group_name}    @{permission_list}
    PCMS Created User    ${pcms_email_export}    ${pcms_display_name_export}    ${pcms_password_export}    ${role_group_name}

    @{permission_list}=    Create List    ${export_product_collection}
    PCMS Unset Permission For User    ${pcms_email_export}    @{permission_list}
    Close Browser

    Login Pcms    ${pcms_email_export}    ${pcms_password_export}
    Cannot see export product collection menu

TC_iTM_02464 - Cannot export product collection(cross between user permission and role permission
    [Tags]    Category    Collection    Admin_permissioning     Product    TC_iTM_02464    ready    regression    flash    WLS_Medium
    [Documentation]    user-view = 0/ role-view = 0
    PCMS Created User Role    ${role_group_name}
    @{permission_list}=    Create List    ${dashboard_view}    ${view_product_list}
    PCMS Set Permission In Role   ${role_group_name}    @{permission_list}

    @{permission_list}=    Create List     ${export_product_collection}
    PCMS Unset Permission In Role   ${role_group_name}    @{permission_list}
    PCMS Created User    ${pcms_email_export}    ${pcms_display_name_export}    ${pcms_password_export}    ${role_group_name}

    @{permission_list}=    Create List    ${export_product_collection}
    PCMS Unset Permission For User    ${pcms_email_export}    @{permission_list}
    Close Browser

    Login Pcms    ${pcms_email_export}    ${pcms_password_export}
    Cannot see export product collection menu