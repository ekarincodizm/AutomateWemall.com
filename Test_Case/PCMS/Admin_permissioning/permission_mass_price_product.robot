*** Setting ***
Force Tags        WLS_Admin_Permission
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/User_Role/Keywords_User_Role.robot
Resource          ${CURDIR}/../../../Keyword/Features/Create_Product/Create_Product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Promotion/keywords_mass_price_product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Keywords_Product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Promotion/keywords_mass_price_product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Promotion/keywords_export_campaign_price_and_product.robot
# Resource          ${CURDIR}/../../../Resource/TestData/${env}/test_data.robot
Resource          ${CURDIR}/../../../Keyword/Portal/CAMPS/CAMPS_Common/Keywords_CAMPS_Common.robot
Resource          ${CURDIR}/../../../Keyword/Features/Discount_campaign/crud_everyday_wow.robot
Test Setup        Login Pcms

*** Variables ***
#group role
${role_group_name}              mass price product for campaign
${dashboard_view}               dashboard_view
${view_discount_campaign}       discount-campaign_view
${manage_discount_campaign}     discount-campaign_manage
${delete_discount_campaign}     discount-campaign_delete
${manage_mass_price_product}    discount-campaign_mass-upload-price-and-product-for

#user
${pcms_email_mass_price_product}            mass_price_product_discount_campaign@test.com
${pcms_display_name_mass_price_product}     flash
${pcms_password_mass_price_product}         12345
${text_cannot_mass_price_product}           You don't have permission to access this page.
${text_header_cannot_access}                Can't access.
${message_success}                          Mass upload completed. ??row?? row(s) processed.

${app_name}          iTruemart
${camp_type}         discount(no icon)
${discount_value}    50
${discount_type}     percent
${camp_name}         ${EMPTY}
*** Test Cases ***

TC_iTM_03519 To verify that user can manage mass price and product when apply user role with mass upload price and product for promotion permission = Allow but apply permission in user level = inherite.
    [Tags]    Admin_permissioning     Promotion    regression    ready     Mass_price_product Mass_upload    TC_iTM_03519    phoenix    WLS_Medium
    [Documentation]    User can access mass upload price and product for discount campaign - group role(allow)/user role(inherite)
    ...     group role(allow)/user role(inherite)
    PCMS Created User Role    ${role_group_name}
    @{permission_list}=    Create List    ${dashboard_view}     ${view_discount_campaign}    ${manage_mass_price_product}
    PCMS Set Permission In Role   ${role_group_name}    @{permission_list}
    PCMS Created User    ${pcms_email_mass_price_product}    ${pcms_display_name_mass_price_product}    ${pcms_password_mass_price_product}    ${role_group_name}

    ## Prerequisite ##
    #.. Create Discount Campaign ..#
    ${start_period}=      Get Date From Today As PCMS Format    11 day
    ${end_period}=        Get Date From Today As PCMS Format    12 day
    ${edit_start_date}=      Get Date From Today As PCMS Format
    ${product_name_list}=    Create List    &{product-disc-4}[name]
    ${pkey}=     Set Variable    &{product-disc-4}[pkey]

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
    Close Browser


    Login Pcms    ${pcms_email_mass_price_product}    ${pcms_password_mass_price_product}
    ## Provide message success with row number ##
    ${message_success}=    Replace String Using Regexp    ${message_success}    \\?\\?.+\\?\\?    1

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
    Mass Price Product - Delete history record by username after upload success    ${username_in_history}    ${filename}

    [Teardown]     Run Keywords    Run keyword If    "${camp_name}" != "${EMPTY}"
    ...    Close Browser
    ...    AND    Login Pcms
    ...    AND    Delete campaign - delete by campaign name    ${camp_name}
    ...    AND    Clear User By Email        ${pcms_email_mass_price_product}
    ...    AND    Clear User Role By Name    ${role_group_name}
    ...    AND    Close All Browsers

TC_iTM_03520 To verify that user can not access mass upload price and product for discount campaign when apply user role with mass upload price and product for promotion permission = Not allow but apply permission in user level = inherite.
    [Tags]    Admin_permissioning    Promotion    regression    ready     Mass_price_product Mass_upload    TC_iTM_03520    phoenix    WLS_Medium
    [Documentation]    Cannot access mass upload product and price menu(so cannot operate the action) - group role(not allow)/user role(inherite)
    ...     Note: group role(not allow)/user role(inherite)
    PCMS Created User Role    ${role_group_name}
    @{permission_list}=    Create List    ${dashboard_view}    ${view_discount_campaign}
    PCMS Set Permission In Role   ${role_group_name}    @{permission_list}

    @{permission_list}=    Create List    ${manage_mass_price_product}
    PCMS Unset Permission In Role   ${role_group_name}    @{permission_list}

    PCMS Created User    ${pcms_email_mass_price_product}    ${pcms_display_name_mass_price_product}    ${pcms_password_mass_price_product}    ${role_group_name}
    Close Browser

    Login Pcms    ${pcms_email_mass_price_product}    ${pcms_password_mass_price_product}
    Cannot see mass price and product menu
    Go To     ${PCMS_URL}/campaigns/mass-upload
    Mass Price Product - verify cannot access mass price and product for discount campaign menu    ${text_header_cannot_access}    ${text_cannot_mass_price_product}

    [Teardown]    Run Keywords    Clear User By Email        ${pcms_email_mass_price_product}
    ...    AND    Clear User Role By Name    ${role_group_name}
    ...    AND    Close All Browsers

TC_iTM_03545 To verify that user can not see manage mass price and product for campaign menu when apply user role with view discount campaign = Not allow, and mass upload price and product for Promotion = Allow and apply permission in user level with mass upload price and product for promotion = Inherite.
    [Tags]    Admin_permissioning    Promotion    regression    ready    Mass_price_product     Mass_upload    TC_iTM_03545    phoenix    WLS_Medium
    [Documentation]     Mass upload price and product permission under discount campaign view.
    PCMS Created User Role    ${role_group_name}
    @{permission_list}=    Create List    ${dashboard_view}    ${manage_mass_price_product}
    PCMS Set Permission In Role   ${role_group_name}    @{permission_list}

    PCMS Created User    ${pcms_email_mass_price_product}    ${pcms_display_name_mass_price_product}    ${pcms_password_mass_price_product}    ${role_group_name}
    Close Browser

    Login Pcms    ${pcms_email_mass_price_product}    ${pcms_password_mass_price_product}
    Cannot see promotion menu

    Go To     ${PCMS_URL}/campaigns/mass-upload
    Location Should Be    ${PCMS_URL}/campaigns/mass-upload

    [Teardown]    Run Keywords    Clear User By Email        ${pcms_email_mass_price_product}
    ...    AND    Clear User Role By Name    ${role_group_name}
    ...    AND    Close All Browsers

TC_iTM_03521 To verify that user can manage mass price and product when apply user role with mass upload price and product for promotion permission = Allow and apply permission in user level = Allow.
    [Tags]    Admin_permissioning    Promotion    regression    ready    Mass_price_product     Mass_upload    TC_iTM_03521    phoenix    WLS_High
    [Documentation]    group role(allow)/user role(allow)
    PCMS Created User Role    ${role_group_name}
    @{permission_list}=    Create List    ${view_discount_campaign}    ${manage_mass_price_product}
    PCMS Set Permission In Role   ${role_group_name}    @{permission_list}

    PCMS Created User    ${pcms_email_mass_price_product}    ${pcms_display_name_mass_price_product}    ${pcms_password_mass_price_product}    ${role_group_name}
    @{permission_list}=    Create List    ${manage_mass_price_product}
    PCMS Set Permission For User    ${pcms_email_mass_price_product}    @{permission_list}

    #.. Create Discount Campaign ..#
    ${start_period}=      Get Date From Today As PCMS Format    11 day
    ${end_period}=        Get Date From Today As PCMS Format    12 day
    ${edit_start_date}=      Get Date From Today As PCMS Format
    ${product_name_list}=    Create List    &{product-disc-4}[name]
    ${pkey}=     Set Variable    &{product-disc-4}[pkey]

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
    Close Browser


    Login Pcms    ${pcms_email_mass_price_product}    ${pcms_password_mass_price_product}
    ## Provide message success with row number ##
    ${message_success}=    Replace String Using Regexp    ${message_success}    \\?\\?.+\\?\\?    1

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
    Mass Price Product - Delete history record by username after upload success    ${username_in_history}    ${filename}

    [Teardown]     Run Keywords    Run keyword If    "${camp_name}" != "${EMPTY}"
    ...    Close Browser
    ...    AND    Login Pcms
    ...    AND    Delete campaign - delete by campaign name    ${camp_name}
    ...    AND    Clear User By Email        ${pcms_email_mass_price_product}
    ...    AND    Clear User Role By Name    ${role_group_name}
    ...    AND    Close All Browsers

TC_iTM_03522 To verify that user can manage mass upload price and product for discount campaign when apply user role with mass upload price and product for promotion permission = Not allow but apply permission in user level = Allow.
    [Tags]    Admin_permissioning     Promotion    regression    ready     Mass_price_product    Mass_upload    TC_iTM_03522    phoenix    WLS_High
    [Documentation]    group role(Not allow)/user role(allow)
    PCMS Created User Role    ${role_group_name}
    @{permission_list}=    Create List    ${dashboard_view}    ${view_discount_campaign}
    PCMS Set Permission In Role   ${role_group_name}    @{permission_list}    ${manage_discount_campaign}
    @{permission_list}=    Create List    ${manage_mass_price_product}
    PCMS Unset Permission In Role   ${role_group_name}    @{permission_list}

    PCMS Created User    ${pcms_email_mass_price_product}    ${pcms_display_name_mass_price_product}    ${pcms_password_mass_price_product}    ${role_group_name}
    @{permission_list}=    Create List          ${manage_mass_price_product}
    PCMS Set Permission For User    ${pcms_email_mass_price_product}     @{permission_list}

    ## Prerequisite ##
    #.. Create Discount Campaign ..#
    ${start_period}=      Get Date From Today As PCMS Format    11 day
    ${end_period}=        Get Date From Today As PCMS Format    12 day
    ${edit_start_date}=      Get Date From Today As PCMS Format
    ${product_name_list}=    Create List    &{product-disc-4}[name]
    ${pkey}=     Set Variable    &{product-disc-4}[pkey]

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
    Close Browser


    Login Pcms    ${pcms_email_mass_price_product}    ${pcms_password_mass_price_product}
    ## Provide message success with row number ##
    ${message_success}=    Replace String Using Regexp    ${message_success}    \\?\\?.+\\?\\?    1

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
    Mass Price Product - Delete history record by username after upload success    ${username_in_history}    ${filename}

    [Teardown]     Run Keywords    Run keyword If    "${camp_name}" != "${EMPTY}"
    ...    Close Browser
    ...    AND    Login Pcms
    ...    AND    Delete campaign - delete by campaign name    ${camp_name}
    ...    AND    Clear User By Email        ${pcms_email_mass_price_product}
    ...    AND    Clear User Role By Name    ${role_group_name}
    ...    AND    Close All Browsers

TC_iTM_03523 To verify that user can not access mass upload price and product for discount campaign when apply user role with mass upload price and product for promotion permission = Not allow and apply permission in user level = Not allow.
    [Tags]    Admin_permissioning    Promotion    regression    ready    Mass_price_product    Mass_upload    TC_iTM_03523    phoenix    WLS_High
    [Documentation]    group role(alllow)/user role(not allow)
    PCMS Created User Role    ${role_group_name}
    @{permission_list}=    Create List    ${dashboard_view}    ${view_discount_campaign}    ${manage_mass_price_product}
    PCMS Set Permission In Role   ${role_group_name}    @{permission_list}
    PCMS Created User    ${pcms_email_mass_price_product}    ${pcms_display_name_mass_price_product}    ${pcms_password_mass_price_product}    ${role_group_name}

    @{permission_list}=    Create List    ${manage_mass_price_product}
    PCMS Unset Permission For User    ${pcms_email_mass_price_product}    @{permission_list}
    Close Browser

    Login Pcms    ${pcms_email_mass_price_product}    ${pcms_password_mass_price_product}
    Cannot see mass price and product menu
    Go To     ${PCMS_URL}/campaigns/mass-upload
    Mass Price Product - verify cannot access mass price and product for discount campaign menu    ${text_header_cannot_access}    ${text_cannot_mass_price_product}

    [Teardown]    Run Keywords    Clear User By Email        ${pcms_email_mass_price_product}
    ...    AND    Clear User Role By Name    ${role_group_name}
    ...    AND    Close All Browsers

TC_iTM_03524 To verify that use can manage mass upload price and product for discount campaign when apply user role with mass upload price and product for promotion permission = Allow and apply permission in user level = Not allow.
    [Tags]    Admin_permissioning    Promotion    regression    ready     Mass_price_product    Mass_upload    TC_iTM_03524    phoenix    WLS_Medium
    [Documentation]    group role(alllow)/user role(not allow)
    PCMS Created User Role    ${role_group_name}
    @{permission_list}=    Create List    ${dashboard_view}    ${view_discount_campaign}
    PCMS Set Permission In Role   ${role_group_name}    @{permission_list}

    @{permission_list}=    Create List     ${manage_mass_price_product}
    PCMS Unset Permission In Role   ${role_group_name}    @{permission_list}
    PCMS Created User    ${pcms_email_mass_price_product}    ${pcms_display_name_mass_price_product}    ${pcms_password_mass_price_product}    ${role_group_name}

    @{permission_list}=    Create List    ${manage_mass_price_product}
    PCMS Unset Permission For User    ${pcms_email_mass_price_product}    @{permission_list}
    Close Browser

    Login Pcms    ${pcms_email_mass_price_product}    ${pcms_password_mass_price_product}
    Cannot see mass price and product menu
    Go To     ${PCMS_URL}/campaigns/mass-upload
    Mass Price Product - verify cannot access mass price and product for discount campaign menu    ${text_header_cannot_access}    ${text_cannot_mass_price_product}

    [Teardown]    Run Keywords    Clear User By Email        ${pcms_email_mass_price_product}
    ...    AND    Clear User Role By Name    ${role_group_name}
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