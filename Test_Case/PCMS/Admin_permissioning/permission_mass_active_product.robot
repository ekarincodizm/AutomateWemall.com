*** Setting ***
Force Tags        WLS_Admin_Permission
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/User_Role/Keywords_User_Role.robot
Resource          ${CURDIR}/../../../Keyword/Features/Create_Product/Create_Product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Mass_active_product/keywords_mass_active_product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Keywords_Product.robot

Test Setup        Login Pcms
Test Teardown     Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_mass_active}
    ...    AND    Clear User Role By Name    ${role_group_name}

*** Variables ***
#group role
${role_group_name}                   acl mass active product group

#role
${dashboard_view}                    dashboard_view
${view_product_list}                 product_view-list
${mass_active_product}               product_mass-active

#user
${pcms_email_mass_active}                 flash_mass_active_product@test.com
${pcms_display_name_mass_active}     flash
${pcms_password_mass_active}         12345
${text_cannot_mass_active}                You don't have permission to access this page.
${text_header_cannot_access}         Can't access.

${result_verify_success}       Mass active products completed. 1 row(s) processed.

${product_name_marketplace_1}      product test mass active product marketplace1
${collection_key}                  9123456789123
# ${file_upload}                  ${CURDIR}/../../../Resource/TestData/Collection/csv_file/product2collection_collection_not_exist.csv

*** Test Cases ***
TC_iTM_02770 - Can upload active product - Success
    [Tags]    TC_iTM_02770    ready    flash    regression    WLS_High
    [Documentation]    Group role-view = 1(User permission is inherit.)
    PCMS Created User Role    ${role_group_name}
    @{permission_list}=    Create List    ${dashboard_view}    ${mass_active_product}
    PCMS Set Permission In Role   ${role_group_name}    @{permission_list}
    PCMS Created User    ${pcms_email_mass_active}    ${pcms_display_name_mass_active}    ${pcms_password_mass_active}    ${role_group_name}
    Close Browser

    Login Pcms    ${pcms_email_mass_active}    ${pcms_password_mass_active}

    Create collection
    ${pkey}=       Insert products by name and collection with marketplace type     ${product_name_marketplace_1}    ${collection_key}
    Log To Console      ${pkey}

    @{data_name}=       Create List     Product Key
    @{data_value}=     Create List     ${pkey}
    @{data}=     Create List     ${data_name}     ${data_value}
    Log To Console     data=${data}

    ${path_file}=      Set product key in file csv product collection     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    Go to mass active product menu
    User browse file for mass active product collection     ${file_upload}
    Mass active product result is displayed    ${result_verify_success}

TC_iTM_02771 - Cannot see mass active product menu(so cannot operate the action)
    [Tags]    TC_iTM_02771    ready    flash    regression    WLS_Medium
    [Documentation]    Group role (view) = 0
    PCMS Created User Role    ${role_group_name}
    @{permission_list}=    Create List    ${dashboard_view}    ${view_product_list}
    PCMS Set Permission In Role   ${role_group_name}    @{permission_list}

    @{permission_list}=    Create List    ${mass_active_product}
    PCMS Unset Permission In Role   ${role_group_name}    @{permission_list}
    PCMS Created User    ${pcms_email_mass_active}    ${pcms_display_name_mass_active}    ${pcms_password_mass_active}    ${role_group_name}
    Close Browser

    Login Pcms    ${pcms_email_mass_active}    ${pcms_password_mass_active}
    Cannot see mass active product menu

TC_iTM_02772 - User can manage mass active product - group role(allow)/user role(allow)
    [Tags]    TC_iTM_02772    ready    flash    regression    WLS_Medium
    PCMS Created User Role    ${role_group_name}
    @{permission_list}=    Create List    ${dashboard_view}    ${mass_active_product}
    PCMS Set Permission In Role   ${role_group_name}    @{permission_list}

    PCMS Created User    ${pcms_email_mass_active}    ${pcms_display_name_mass_active}    ${pcms_password_mass_active}    ${role_group_name}
    @{permission_list}=    Create List    ${mass_active_product}
    PCMS Set Permission For User    ${pcms_email_mass_active}    @{permission_list}
    Close Browser

    Login Pcms    ${pcms_email_mass_active}    ${pcms_password_mass_active}
    Create collection
    ${pkey}=       Insert products by name and collection with marketplace type     ${product_name_marketplace_1}    ${collection_key}
    Log To Console      ${pkey}

    @{data_name}=       Create List     Product Key
    @{data_value}=     Create List     ${pkey}
    @{data}=     Create List     ${data_name}     ${data_value}
    Log To Console     data=${data}

    ${path_file}=      Set product key in file csv product collection     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    Go to mass active product menu
    User browse file for mass active product collection     ${file_upload}
    Mass active product result is displayed    ${result_verify_success}

TC_iTM_02773 - User can use mass active product(cross role permission) - group role(not allow)/user role(allow
    [Tags]    TC_iTM_02773    ready    flash    regression    WLS_Medium
    Set Selenium Speed    0.1
    PCMS Created User Role    ${role_group_name}
    @{permission_list}=    Create List    ${dashboard_view}
    PCMS Set Permission In Role   ${role_group_name}    @{permission_list}
    PCMS Created User    ${pcms_email_mass_active}    ${pcms_display_name_mass_active}    ${pcms_password_mass_active}    ${role_group_name}

    @{permission_list}=    Create List    ${mass_active_product}
    PCMS Set Permission For User    ${pcms_email_mass_active}    @{permission_list}
    Close Browser

    Login Pcms    ${pcms_email_mass_active}    ${pcms_password_mass_active}
    Create collection
    ${pkey}=       Insert products by name and collection with marketplace type     ${product_name_marketplace_1}    ${collection_key}
    Log To Console      ${pkey}

    @{data_name}=       Create List     Product Key
    @{data_value}=     Create List     ${pkey}
    @{data}=     Create List     ${data_name}     ${data_value}
    Log To Console     data=${data}

    ${path_file}=      Set product key in file csv product collection     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    Go to mass active product menu
    User browse file for mass active product collection     ${file_upload}
    Mass active product result is displayed    ${result_verify_success}

TC_iTM_02774 - Use cannot use mass active product(cross role permission) - group role(allow)/user role(not allow)
    [Tags]    TC_iTM_02774    ready    flash    regression    WLS_Medium
    Set Selenium Speed    0.3
    PCMS Created User Role    ${role_group_name}
    @{permission_list}=    Create List    ${dashboard_view}    ${mass_active_product}    ${view_product_list}
    PCMS Set Permission In Role   ${role_group_name}    @{permission_list}
    PCMS Created User    ${pcms_email_mass_active}    ${pcms_display_name_mass_active}    ${pcms_password_mass_active}    ${role_group_name}

    @{permission_list}=    Create List    ${mass_active_product}
    PCMS Unset Permission For User    ${pcms_email_mass_active}    @{permission_list}
    Close Browser

    Login Pcms    ${pcms_email_mass_active}    ${pcms_password_mass_active}
    Cannot see mass active product menu

TC_iTM_02775 - Cannot use mass active product collection(cross role permission) - group role(not allow)/user role(not allow)
    [Tags]    TC_iTM_02775    ready    flash    regression    WLS_Medium
    [Documentation]    user-view = 0/ role-view = 0
    Set Selenium Speed    0.3
    PCMS Created User Role    ${role_group_name}
    @{permission_list}=    Create List    ${dashboard_view}    ${view_product_list}
    PCMS Set Permission In Role   ${role_group_name}    @{permission_list}

    @{permission_list}=    Create List     ${mass_active_product}
    PCMS Unset Permission In Role   ${role_group_name}    @{permission_list}
    PCMS Created User    ${pcms_email_mass_active}    ${pcms_display_name_mass_active}    ${pcms_password_mass_active}    ${role_group_name}

    @{permission_list}=    Create List    ${mass_active_product}
    PCMS Unset Permission For User    ${pcms_email_mass_active}    @{permission_list}
    Close Browser

    Login Pcms    ${pcms_email_mass_active}    ${pcms_password_mass_active}
    Cannot see mass active product menu
