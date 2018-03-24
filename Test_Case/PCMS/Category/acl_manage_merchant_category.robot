*** Setting ***
Force Tags    WLS_PCMS_Category
Library           Selenium2Library
Library           ${CURDIR}/../../../Keyword/Portal/PCMS/Category_Merchant/keywords_category.py
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/User_Role/Keywords_User_Role.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Category_Merchant/keywords_description_tab.robot
Resource          ${CURDIR}/../../../Keyword/Portal/CAMPS/CAMPS_Common/Keywords_CAMPS_Common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Category_Merchant/keywords_category.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Category_Merchant/keywords_display_tab.robot
Test Setup        Login Pcms

*** Variables ***
#group
${user_role_group}     manage category
#role
${category_manage}     category_manage

#user
${pcms_email_manage_cate}           phoenix_manage_cate@test.com
${pcms_display_name_manage_cate}    phoenix
${pcms_password_manage_cate}        12345

#data
${text_cannot_access}               You don't have permission to access this page.
${text_header_cannot_access}        Can't access.
${select_merchant_label}            Merchant-phoenix ( WP9999 )
${cate_name}                        catephoenix
${cate_name_trans}                  catephoenixEN
${expected_slug}                    catephoenixen

*** Test Cases ***

TC_ITMWM_05142 User can view and manage category
    [Documentation]    role-manage = allow    user manage = inherite
    [Tags]    regression    TC_ITMWM_05142    acl    phoenix   manage_category    ready    WLS_Medium
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${category_manage}
    PCMS Set Permission In Role   ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_manage_cate}    ${pcms_display_name_manage_cate}    ${pcms_password_manage_cate}    ${user_role_group}
    Close Browser

    Login Pcms    ${pcms_email_manage_cate}    ${pcms_password_manage_cate}
    Go To         ${PCMS_URL}/categories/merchant-categories
    Sleep    5s
    Merchant Category Management - Select Category          ${select_merchant_label}
    Sleep    2s
    Merchant Category Description - Create New Category Merchant    ${select_merchant_label}    ${cate_name}    ${cate_name_trans}
    sleep   2s
    Merchant Category - Verify New Category    WP9999    catephoenix     catephoenixEN     1    1   0     inactive
    ${res_idcategory}=    Merchant Category Management Display - Extract Id From Url
    Go To    ${PCMS_URL}/categories/merchant-categories
    Sleep    5s
    Merchant Category Management - Select Category          ${select_merchant_label}
    Sleep    2s
    ${id_cat}=    Merchant Category - Get ID Category by Category name (Level1)    ${cate_name}
    Merchant Category Management - Edit Category    ${id_cat}
    Merchant Category Description - Verify Slug On Description Tab    ${expected_slug}

    [Teardown]     Run Keywords    Close All Browsers
    ...    AND    Permanent Delete Category By Category ID    ${res_idcategory}
    ...    AND    Clear User By Email    ${pcms_email_manage_cate}
    ...    AND    Clear User Role By Name    ${user_role_group}

TC_ITMWM_05143 User can not view and manage category
    [Documentation]    role-manage = not allow     user manage = inherite
    [Tags]    regression    TC_ITMWM_05143    acl    phoenix     manage_category    ready    WLS_Medium
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${category_manage}
    PCMS Unset Permission In Role    ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_manage_cate}    ${pcms_display_name_manage_cate}    ${pcms_password_manage_cate}    ${user_role_group}
    Close Browser

    Login Pcms    ${pcms_email_manage_cate}    ${pcms_password_manage_cate}
    Go To         ${PCMS_URL}/categories/merchant-categories
    Sleep    5s
    User do not have permission to access this page    ${text_header_cannot_access}\n${text_cannot_access}

    [Teardown]     Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_manage_cate}
    ...    AND    Clear User Role By Name    ${user_role_group}

TC_ITMWM_05144 User can view and manage category
    [Documentation]    role-manage = allow    user manage = allow
    [Tags]    regression    TC_ITMWM_05144    acl    phoenix     manage_category    ready    WLS_Medium
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${category_manage}
    PCMS Set Permission In Role    ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_manage_cate}    ${pcms_display_name_manage_cate}    ${pcms_password_manage_cate}    ${user_role_group}
    @{permission_list}=    Create List    ${category_manage}
    PCMS Set Permission For User      ${pcms_email_manage_cate}     @{permission_list}
    Close Browser

    Login Pcms    ${pcms_email_manage_cate}    ${pcms_password_manage_cate}
    Go To         ${PCMS_URL}/categories/merchant-categories
    Sleep    5s
    Merchant Category Management - Select Category          ${select_merchant_label}
    Sleep    2s
    Merchant Category Description - Create New Category Merchant    ${select_merchant_label}    ${cate_name}    ${cate_name_trans}
    sleep   2s
    Merchant Category - Verify New Category    WP9999    catephoenix     catephoenixEN     1    1   0     inactive
    ${res_idcategory}=    Merchant Category Management Display - Extract Id From Url
    Go To    ${PCMS_URL}/categories/merchant-categories
    Sleep    5s
    Merchant Category Management - Select Category          ${select_merchant_label}
    Sleep    2s
    ${id_cat}=    Merchant Category - Get ID Category by Category name (Level1)    ${cate_name}
    Merchant Category Management - Edit Category    ${id_cat}
    Merchant Category Description - Verify Slug On Description Tab    ${expected_slug}

    [Teardown]     Run Keywords    Close All Browsers
    ...    AND    Permanent Delete Category By Category ID    ${res_idcategory}
    ...    AND    Clear User By Email    ${pcms_email_manage_cate}
    ...    AND    Clear User Role By Name    ${user_role_group}

TC_ITMWM_05145 User can not view and manage category
    [Documentation]    role-manage = not allow    user manage = not allow
    [Tags]    regression    TC_ITMWM_05145    acl    phoenix     manage_category    ready    WLS_Medium
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List      ${category_manage}
    PCMS Unset Permission In Role    ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_manage_cate}    ${pcms_display_name_manage_cate}    ${pcms_password_manage_cate}    ${user_role_group}
    @{permission_list}=    Create List    ${category_manage}
    PCMS Unset Permission For User    ${pcms_email_manage_cate}     @{permission_list}
    Close Browser

    Login Pcms    ${pcms_email_manage_cate}    ${pcms_password_manage_cate}
    Go To         ${PCMS_URL}/categories/merchant-categories
    Sleep    5s
    User do not have permission to access this page    ${text_header_cannot_access}\n${text_cannot_access}

    [Teardown]     Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_manage_cate}
    ...    AND    Clear User Role By Name    ${user_role_group}

TC_ITMWM_05146 User can view and manage category (role-manage = not allow, user manage = allow)
    [Documentation]    role-manage = not allow     user manage = allow
    [Tags]    acl    phoenix     manage_category    TC_ITMWM_05146    regression    ready    WLS_Medium
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${category_manage}
    PCMS Unset Permission In Role      ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_manage_cate}    ${pcms_display_name_manage_cate}    ${pcms_password_manage_cate}    ${user_role_group}

    @{permission_list}=    Create List    ${category_manage}
    PCMS Set Permission For User      ${pcms_email_manage_cate}     @{permission_list}
    Close Browser

    Login Pcms    ${pcms_email_manage_cate}    ${pcms_password_manage_cate}
    Go To         ${PCMS_URL}/categories/merchant-categories
    Sleep    5s
    Merchant Category Management - Select Category          ${select_merchant_label}
    Sleep    2s
    Merchant Category Description - Create New Category Merchant    ${select_merchant_label}    ${cate_name}    ${cate_name_trans}
    sleep   2s
    Merchant Category - Verify New Category    WP9999    catephoenix     catephoenixEN     1    1   0     inactive
    ${res_idcategory}=    Merchant Category Management Display - Extract Id From Url
    Go To    ${PCMS_URL}/categories/merchant-categories
    Sleep    5s
    Merchant Category Management - Select Category          ${select_merchant_label}
    Sleep    2s
    ${id_cat}=    Merchant Category - Get ID Category by Category name (Level1)    ${cate_name}
    Merchant Category Management - Edit Category    ${id_cat}
    Merchant Category Description - Verify Slug On Description Tab    ${expected_slug}

    [Teardown]     Run Keywords    Close All Browsers
    ...    AND    Permanent Delete Category By Category ID    ${res_idcategory}
    ...    AND    Clear User By Email    ${pcms_email_manage_cate}
    ...    AND    Clear User Role By Name    ${user_role_group}

TC_ITMWM_05147 User can not view and manage category (role-manage = Allow, user manage = Not allow)
    [Documentation]    role-manage = Allow      user manage = Not allow
    [Tags]    acl    phoenix    manage_category    TC_ITMWM_05147    regression    ready    WLS_Medium
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${category_manage}
    PCMS Set Permission In Role    ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_manage_cate}    ${pcms_display_name_manage_cate}    ${pcms_password_manage_cate}    ${user_role_group}
    @{permission_list}=    Create List    ${category_manage}
    PCMS Unset Permission For User    ${pcms_email_manage_cate}     @{permission_list}
    Close Browser

    Login Pcms    ${pcms_email_manage_cate}    ${pcms_password_manage_cate}
    Go To         ${PCMS_URL}/categories/merchant-categories
    Sleep    5s
    User do not have permission to access this page    ${text_header_cannot_access}\n${text_cannot_access}

    [Teardown]     Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_manage_cate}
    ...    AND    Clear User Role By Name    ${user_role_group}