*** Setting ***
Force Tags        WLS_Admin_Permission
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Features/Create_Product/Create_Product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/User_Role/Keywords_User_Role.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Mass_upload_product_collection/keywords_mass_upload_product_collection.robot

Test Setup        Login Pcms
Test Teardown     Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_password_mass}
    ...    AND    Clear User Role By Name    ${user_role_group}

*** Variables ***
#group role
${user_role_group}              acl mass upload product collection group
#role
${dashboard_view}               dashboard_view
${view_product_list}            product_view-list
${manage_product_collection}    product_mass-upload-collection-on

#user
${pcms_email_mass}              mass_upload_product_collection@flash.com
${pcms_display_name_mass}       flash
${pcms_password_mass}           12345
${text_cannot_mass}             You don't have permission to access this page.
${text_header_cannot_access}    Can't access.

${file_upload}                  ${CURDIR}/../../../Resource/TestData/Collection/csv_file/product2collection_collection_not_exist.csv
${message_success}            Mass upload completed. 2 row(s) processed.

*** Test Cases ***
TC_iTM_02465 - Can upload collection on product(manage(1))
    [Tags]    Category    Collection    Admin_permissioning    Product    Mass_Upload    TC_iTM_02465    regression    flash    WLS_High
    [Documentation]    User permission is inherit.
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${dashboard_view}     ${manage_product_collection}
    PCMS Set Permission In Role   ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_mass}    ${pcms_display_name_mass}    ${pcms_password_mass}    ${user_role_group}
    Close Browser

    Login Pcms    ${pcms_email_mass}    ${pcms_password_mass}
    Go to mass upload product collection menu
    ${filename}=    User download template
    Check template is correctly    ${filename}

TC_iTM_02466 - Cannot upload collection on product(manage(0))
    [Tags]    Category     Collection     Admin_permissioning    TC_iTM_02466    ready    regression    flash    WLS_Medium
    [Documentation]     User permission is inherit. manage(0)
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${dashboard_view}    ${view_product_list}
    PCMS Set Permission In Role   ${user_role_group}    @{permission_list}

    @{permission_list}=    Create List    ${manage_product_collection}
    PCMS Unset Permission In Role   ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_mass}    ${pcms_display_name_mass}    ${pcms_password_mass}    ${user_role_group}
    Close Browser

    Login Pcms    ${pcms_email_mass}    ${pcms_password_mass}
    Cannot see mass upload product collection menu


TC_iTM_02467 - Can upload collection on product(user role = 1/group role = 0)
    [Documentation]    To verify that user have permission to view for mass upload product collection so user should view only.
    [Tags]    Category    Collection    Admin_permissioning    TC_iTM_02467    regression    flash    WLS_Medium

    ## prepare data mass upload
    ${level1_collection_pkey}=    Set Variable    1122334455
    ${level2_collection_pkey}=    Set Variable    11223344551

    ${level1_collection_id}=    Create collection level1 for mass upload    0    ${level1_collection_pkey}
    ${level2_collection_id}=    Create collection level2 for mass upload    ${level1_collection_id}    ${level2_collection_pkey}
    ${product1_pkey}=       Insert product with retail type
    ${product2_pkey}=       Insert product with marketplace type

    @{data_name}=       Create List     Product Key         Collection Key
    @{data_value1}=     Create List     ${product1_pkey}    ${level2_collection_pkey}
    @{data_value2}=     Create List     ${product2_pkey}    ${level2_collection_pkey}
    @{data}=            Create List     ${data_name}        ${data_value1}      ${data_value2}
    Log To Console     ${data}
    ${path_file}=      Set product key and collection key in file csv product collection     ${data}
    Log To Console     path_file::${path_file}
    ${file_upload}=       common.Get Canonical Path    ${path_file}

    Log To Console     file_upload::${file_upload}

    ${filename}=    Get file name from canonical path    ${file_upload}

    ### test step ACL ####
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${dashboard_view}    ${view_product_list}
    PCMS Set Permission In Role   ${user_role_group}    @{permission_list}
    @{permission_list}=    Create List    ${manage_product_collection}
    PCMS Unset Permission In Role   ${user_role_group}    @{permission_list}

    PCMS Created User    ${pcms_email_mass}    ${pcms_display_name_mass}    ${pcms_password_mass}    ${user_role_group}
    @{permission_list}=    Create List     ${manage_product_collection}
    PCMS Set Permission For User    ${pcms_email_mass}    @{permission_list}
    Close Browser

    Login Pcms    ${pcms_email_mass}    ${pcms_password_mass}
    Go to mass upload product collection menu
    User browse file for mass upload product collection     ${file_upload}
    Mass upload product collection - Message success is displayed    ${message_success}

TC_iTM_02468 - Can not see mass pload product collection menu(user role= 0/group role = 0)
    [Documentation]    To verify that user have permission to manage collection for mass upload product to collection only so user cannot operate the action.
    [Tags]    Category    Collection    Admin_permissioning    TC_iTM_02468     regression    ready    flash    WLS_Medium
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${dashboard_view}    ${view_product_list}
    PCMS Set Permission In Role   ${user_role_group}    @{permission_list}

    @{permission_list}=    Create List    ${manage_product_collection}
    PCMS Unset Permission In Role   ${user_role_group}    @{permission_list}

    PCMS Created User    ${pcms_email_mass}    ${pcms_display_name_mass}    ${pcms_password_mass}    ${user_role_group}
    @{permission_list}=    Create List    ${manage_product_collection}
    PCMS Unset Permission For User    ${pcms_email_mass}    @{permission_list}
    Close Browser

    Login Pcms    ${pcms_email_mass}    ${pcms_password_mass}
    Cannot see mass upload product collection menu

TC_iTM_02469 - Can not see mass upload product collection menu(user role = 0/group role = 1)
    [Documentation]    To verify that user have permission to view product for mass upload product collection so user should view product mass upload product collection only.
    [Tags]    Category    Collection    Admin_permissioning    TC_iTM_02469    regression    ready    flash    WLS_Medium
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${dashboard_view}    ${manage_product_collection}    ${view_product_list}
    PCMS Set Permission In Role   ${user_role_group}    @{permission_list}

    PCMS Created User    ${pcms_email_mass}    ${pcms_display_name_mass}    ${pcms_password_mass}    ${user_role_group}
    @{permission_list}=    Create List    ${manage_product_collection}
    PCMS Unset Permission For User    ${pcms_email_mass}    @{permission_list}
    Close Browser

    Login Pcms    ${pcms_email_mass}    ${pcms_password_mass}
    Cannot see mass upload product collection menu


TC_iTM_02470 - Can upload collection on product(user role = 1/role group = 1)
    [Documentation]    To verify that user have permission to view product for mass upload product collection so user should view product mass upload only.
    [Tags]    Category    Collection    Admin_permissioning    TC_iTM_02470    regression    flash    WLS_Medium
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${dashboard_view}    ${view_product_list}    ${manage_product_collection}
    PCMS Set Permission In Role   ${user_role_group}    @{permission_list}

    PCMS Created User    ${pcms_email_mass}    ${pcms_display_name_mass}    ${pcms_password_mass}    ${user_role_group}
    @{permission_list}=    Create List    ${manage_product_collection}
    PCMS Set Permission For User    ${pcms_email_mass}    @{permission_list}
    Close Browser

    Login Pcms    ${pcms_email_mass}    ${pcms_password_mass}
    Go to mass upload product collection menu
    ${filename}=    User download template
    Check template is correctly    ${filename}