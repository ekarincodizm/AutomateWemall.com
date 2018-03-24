*** Setting ***
Force Tags        WLS_Admin_Permission
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/User_Role/Keywords_User_Role.robot
Resource          ${CURDIR}/../../../Keyword/Features/Create_Product/Create_Product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Mass_inactive_product/keywords_mass_inactive_product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Keywords_Product.robot

Test Setup        Login Pcms
Test Teardown     Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_mass_inactive}
    ...    AND    Clear User Role By Name    ${role_group_name}

*** Variables ***
#group role
${role_group_name}                   acl mass inactive product group

#role
${dashboard_view}                    dashboard_view
${view_product_list}                 product_view-list
${mass_inactive_product}               product_mass-inactive

#user
${pcms_email_mass_inactive}              flash_mass_inactive_product@test.com
${pcms_display_name_mass_inactive}       flash
${pcms_password_mass_inactive}             12345
${text_cannot_mass_inactive}               You don't have permission to access this page.
${text_header_cannot_access}             Can't access.

${result_verify_success}                 Mass inactive products completed. 1 row(s) processed.

${product_name_marketplace_1}            product test mass inactive product marketplace1
${collection_key}                        9987654321123
# ${file_upload}                  ${CURDIR}/../../../Resource/TestData/Collection/csv_file/product2collection_collection_not_exist.csv

*** Test Cases ***
TC_iTM_02776 - Can upload inactive product - Success
    [Tags]    TC_iTM_02776    ready    flash    regression    WLS_High
    [Documentation]    Group role-view = 1(User permission is inherit.)
    PCMS Created User Role    ${role_group_name}
    @{permission_list}=    Create List    ${dashboard_view}    ${mass_inactive_product}
    PCMS Set Permission In Role   ${role_group_name}    @{permission_list}
    PCMS Created User    ${pcms_email_mass_inactive}    ${pcms_display_name_mass_inactive}    ${pcms_password_mass_inactive}    ${role_group_name}
    Close Browser

    Login Pcms    ${pcms_email_mass_inactive}    ${pcms_password_mass_inactive}

    Create collection
    ${pkey}=       Insert products by name and collection with marketplace type     ${product_name_marketplace_1}    ${collection_key}
    Log To Console      ${pkey}

    @{data_name}=       Create List     Product Key
    @{data_value}=     Create List     ${pkey}
    @{data}=     Create List     ${data_name}     ${data_value}
    Log To Console     data=${data}

    ${path_file}=      Set product key in file csv product collection     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    Go to mass inactive product menu
    User browse file for mass inactive product collection     ${file_upload}
    Mass inactive product result is displayed    ${result_verify_success}

TC_iTM_02777 - Cannot see mass inactive product menu(so cannot operate the action)
    [Tags]    TC_iTM_02777    ready    flash    regression    WLS_Medium
    [Documentation]    Group role (view) = 0
    PCMS Created User Role    ${role_group_name}
    @{permission_list}=    Create List    ${dashboard_view}    ${view_product_list}
    PCMS Set Permission In Role   ${role_group_name}    @{permission_list}

    @{permission_list}=    Create List    ${mass_inactive_product}
    PCMS Unset Permission In Role   ${role_group_name}    @{permission_list}
    PCMS Created User    ${pcms_email_mass_inactive}    ${pcms_display_name_mass_inactive}    ${pcms_password_mass_inactive}    ${role_group_name}
    Close Browser

    Login Pcms    ${pcms_email_mass_inactive}    ${pcms_password_mass_inactive}
    Cannot see mass inactive product menu

TC_iTM_02778 - User can manage mass inactive product - group role(allow)/user role(allow)
    [Tags]    TC_iTM_02778    ready    flash    regression    WLS_Medium
    PCMS Created User Role    ${role_group_name}
    @{permission_list}=    Create List    ${dashboard_view}    ${mass_inactive_product}
    PCMS Set Permission In Role   ${role_group_name}    @{permission_list}

    PCMS Created User    ${pcms_email_mass_inactive}    ${pcms_display_name_mass_inactive}    ${pcms_password_mass_inactive}    ${role_group_name}
    @{permission_list}=    Create List    ${mass_inactive_product}
    PCMS Set Permission For User    ${pcms_email_mass_inactive}    @{permission_list}
    Close Browser

    Login Pcms    ${pcms_email_mass_inactive}    ${pcms_password_mass_inactive}
    Create collection
    ${pkey}=       Insert products by name and collection with marketplace type     ${product_name_marketplace_1}    ${collection_key}
    Log To Console      ${pkey}

    @{data_name}=       Create List     Product Key
    @{data_value}=     Create List     ${pkey}
    @{data}=     Create List     ${data_name}     ${data_value}
    Log To Console     data=${data}

    ${path_file}=      Set product key in file csv product collection     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    Go to mass inactive product menu
    User browse file for mass inactive product collection     ${file_upload}
    Mass inactive product result is displayed    ${result_verify_success}

TC_iTM_02779 - User can use mass inactive product(cross role permission) - group role(not allow)/user role(allow)
    [Tags]    TC_iTM_02779    ready    flash    regression    WLS_Medium
    PCMS Created User Role    ${role_group_name}
    @{permission_list}=    Create List    ${dashboard_view}
    PCMS Set Permission In Role   ${role_group_name}    @{permission_list}
    PCMS Created User    ${pcms_email_mass_inactive}    ${pcms_display_name_mass_inactive}    ${pcms_password_mass_inactive}    ${role_group_name}

    @{permission_list}=    Create List    ${mass_inactive_product}
    PCMS Set Permission For User    ${pcms_email_mass_inactive}    @{permission_list}
    Close Browser

    Login Pcms    ${pcms_email_mass_inactive}    ${pcms_password_mass_inactive}
    Create collection
    ${pkey}=       Insert products by name and collection with marketplace type     ${product_name_marketplace_1}    ${collection_key}
    Log To Console      ${pkey}

    @{data_name}=       Create List     Product Key
    @{data_value}=     Create List     ${pkey}
    @{data}=     Create List     ${data_name}     ${data_value}
    Log To Console     data=${data}

    ${path_file}=      Set product key in file csv product collection     ${data}
    ${file_upload}=    common.Get Canonical Path    ${path_file}

    Go to mass inactive product menu
    User browse file for mass inactive product collection     ${file_upload}
    Mass inactive product result is displayed    ${result_verify_success}

TC_iTM_02780 - Use cannot use mass inactive product(cross role permission) - group role(allow)/user role(not allow)
    [Tags]    TC_iTM_02780    ready    flash    regression    WLS_Medium
    PCMS Created User Role    ${role_group_name}
    @{permission_list}=    Create List    ${dashboard_view}    ${mass_inactive_product}    ${view_product_list}
    PCMS Set Permission In Role   ${role_group_name}    @{permission_list}
    PCMS Created User    ${pcms_email_mass_inactive}    ${pcms_display_name_mass_inactive}    ${pcms_password_mass_inactive}    ${role_group_name}

    @{permission_list}=    Create List    ${mass_inactive_product}
    PCMS Unset Permission For User    ${pcms_email_mass_inactive}    @{permission_list}
    Close Browser

    Login Pcms    ${pcms_email_mass_inactive}    ${pcms_password_mass_inactive}
    Cannot see mass inactive product menu

TC_iTM_02781 - Cannot use mass inactive product(cross role permission) - group role(not allow)/user role(not allow)
    [Tags]    TC_iTM_02781    ready    flash    regression    WLS_Medium
    [Documentation]    user-view = 0/ role-view = 0
    PCMS Created User Role    ${role_group_name}
    @{permission_list}=    Create List    ${dashboard_view}    ${view_product_list}
    PCMS Set Permission In Role   ${role_group_name}    @{permission_list}

    @{permission_list}=    Create List     ${mass_inactive_product}
    PCMS Unset Permission In Role   ${role_group_name}    @{permission_list}
    PCMS Created User    ${pcms_email_mass_inactive}    ${pcms_display_name_mass_inactive}    ${pcms_password_mass_inactive}    ${role_group_name}

    @{permission_list}=    Create List    ${mass_inactive_product}
    PCMS Unset Permission For User    ${pcms_email_mass_inactive}    @{permission_list}
    Close Browser

    Login Pcms    ${pcms_email_mass_inactive}    ${pcms_password_mass_inactive}
    Cannot see mass inactive product menu
