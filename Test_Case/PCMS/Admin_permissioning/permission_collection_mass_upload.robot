*** Setting ***
Force Tags        WLS_Admin_Permission
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/User_Role/Keywords_User_Role.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Collection/keyword_collection.robot
Test Setup        Login Pcms
Test Teardown     Run Keywords    Close All Browsers
    ...    AND    Clear User By Email    ${pcms_email_mass}
    ...    AND    Clear User Role By Name    ${user_role_group}

*** Variables ***
${user_role_group}     mass upload product2collection

#role
${dashboard_view}       dashboard_view
${collection_view}      collection_view
${collection_manage}    collection_manage
${collection_mass_upload_view}      collection-mass-upload_view
${collection_mass_upload_manage}    collection-mass-upload_manage

#user
${pcms_email_mass}           flash@test.com
${pcms_display_name_mass}    flash
${pcms_password_mass}        12345
${text_cannot_access}        You don't have permission to access this page.
${text_header_cannot_access}    Can't access.

${file_upload}               ${CURDIR}/../../../Resource/TestData/Collection/csv_file/product2collection_collection_not_exist.csv

*** Test Cases ***
TC_iTM_01351 - Can view and can upload - Success
    [Documentation]    To verify that user have permission to view and manage collecion for mass upload product to collection so user should view and manage product correctly.
    ...    Note: view(1)/manage(1) -> User permission is inherit.
    [Tags]    Category    Collection    Admin_permissioning    TC_iTM_01351    ready    regression    flash    WLS_High
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${dashboard_view}    ${collection_view}    ${collection_manage}    ${collection_mass_upload_view}     ${collection_mass_upload_manage}
    PCMS Set Permission In Role   ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_mass}    ${pcms_display_name_mass}    ${pcms_password_mass}    ${user_role_group}

    #..test step
    Login Pcms    ${pcms_email_mass}    ${pcms_password_mass}
    Go to mass upload menu
    All history of mass upload
    User browse file for upload product to cate    ${file_upload}
    Result when collection doest not exist in system

TC_iTM_01780 - Can view but cannot upload - Success
    [Documentation]    To verify that user have permission to view for mass upload product to collection so user should view only.Note: view(1)/manage(0)
    [Tags]    Category    Collection    Admin_permissioning    TC_iTM_01780    ready    regression    flash    WLS_High
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${dashboard_view}    ${collection_view}    ${collection_manage}    ${collection_mass_upload_view}
    PCMS Set Permission In Role   ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_mass}    ${pcms_display_name_mass}    ${pcms_password_mass}    ${user_role_group}
    Close Browser

    Login Pcms    ${pcms_email_mass}    ${pcms_password_mass}
    Go to mass upload menu
    All history of mass upload
    User browse file for upload product to cate    ${file_upload}
    Message cannot access is displayed    ${text_cannot_access}
    Header messege cannot access is displayed    ${text_header_cannot_access}
    Location varify

TC_iTM_01781 - Cannot view and can manage(so cannot operate the action)
    [Documentation]    To verify that user have permission to manage collection for mass upload product to collection only so user cannot operate the action.
    ...    Note: view(0)/manage(1)
    [Tags]    Category    Collection    Admin_permissioning    TC_iTM_01781    ready    regression    flash    WLS_Medium
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${dashboard_view}    ${collection_view}    ${collection_manage}    ${collection_mass_upload_manage}
    PCMS Set Permission In Role   ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_mass}    ${pcms_display_name_mass}    ${pcms_password_mass}    ${user_role_group}

    Close Browser
    Login Pcms    ${pcms_email_mass}    ${pcms_password_mass}
    Go to mass upload menu
    Message cannot access is displayed    ${text_cannot_access}
    Header messege cannot access is displayed    ${text_header_cannot_access}
    Location mass upload

TC_iTM_01782 - Cannot view and cannot manage(so cannot operate the action)
    [Documentation]    To verify that user have not permission to view and manage collection for mass upload product to collection so user cannot view nad manage collection for mass upload product to collection.
    ...    Note: view(0)/manage(0)
    [Tags]    Category    Collection    Admin_permissioning    TC_iTM_01782    ready    regression    flash    WLS_Medium
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${dashboard_view}    ${collection_view}    ${collection_manage}
    PCMS Set Permission In Role   ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_mass}    ${pcms_display_name_mass}    ${pcms_password_mass}    ${user_role_group}

    Close Browser
    Login Pcms    ${pcms_email_mass}    ${pcms_password_mass}
    Go to mass upload menu
    Message cannot access is displayed    ${text_cannot_access}
    Header messege cannot access is displayed    ${text_header_cannot_access}
    Location mass upload

TC_iTM_01783 - Can view and upload(cross role permission) - Success
    [Documentation]    To verify that user have permission to view and manage collecion for mass upload product to collection so user should view and manage product correctly.
    ...    Condition:
    ...    - User privilege can view and manage collection mass upload.
    ...    - User role permission cannot view and manage collection mass upload.
    ...    user-view = 1/user-manage = 1
    ...    role-view = 0/role-manage = 0
    [Tags]    Category    Collection    Admin_permissioning    TC_iTM_01783    ready    regression    flash    WLS_Medium
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${dashboard_view}    ${collection_view}    ${collection_manage}
    PCMS Set Permission In Role   ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_mass}    ${pcms_display_name_mass}    ${pcms_password_mass}    ${user_role_group}

    @{permission_list}=    Create List    ${collection_mass_upload_view}     ${collection_mass_upload_manage}
    PCMS Set Permission For User    ${pcms_email_mass}    @{permission_list}

    Close Browser
    Login Pcms    ${pcms_email_mass}    ${pcms_password_mass}
    Go to mass upload menu
    All history of mass upload
    User browse file for upload product to cate    ${file_upload}
    Result when collection doest not exist in system

TC_iTM_01784 - Can view only(cross between user permission and role permission
    [Documentation]    To verify that user have permission to view collecion for mass upload product to collection so user should view collection mass upload only.
    ...    Condition:
    ...    - User privilege can view collection mass upload only.
    ...    - User role permission(group) cannot view and manage collecion mass upload.
    ...    user-view = 1/user-manage = 0,  role-view = 0/role-manage = 0
    [Tags]    Category    Collection    Admin_permissioning    TC_iTM_01784    ready    regression    flash    WLS_Medium
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${dashboard_view}    ${collection_view}    ${collection_manage}
    PCMS Set Permission In Role   ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_mass}    ${pcms_display_name_mass}    ${pcms_password_mass}    ${user_role_group}

    @{permission_list}=    Create List    ${collection_mass_upload_view}
    PCMS Set Permission For User    ${pcms_email_mass}    @{permission_list}

    Close Browser
    Login Pcms    ${pcms_email_mass}    ${pcms_password_mass}
    Go to mass upload menu
    All history of mass upload
    User browse file for upload product to cate    ${file_upload}
    Message cannot access is displayed    ${text_cannot_access}
    Header messege cannot access is displayed    ${text_header_cannot_access}
    Location varify

TC_iTM_01785 - Can view only(cross between user permission and role permission
    [Documentation]    To verify that user have permission to view collection for mass upload product to collection so user should view collection mass upload product only.
    ...    Condition:
    ...    - User privilege can view collection mass upload only.
    ...    - User role permission(group) can view and manage collection mass upload.
    ...    user-view = 1/user-manage = 0,    role-view = 1/role-manage = 1
    [Tags]    Category    Collection    Admin_permissioning    TC_iTM_01785    ready    regression    flash    WLS_Medium
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${dashboard_view}    ${collection_view}    ${collection_manage}    ${collection_mass_upload_view}     ${collection_mass_upload_manage}
    PCMS Set Permission In Role   ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_mass}    ${pcms_display_name_mass}    ${pcms_password_mass}    ${user_role_group}

    @{permission_list}=    Create List    ${collection_mass_upload_view}
    PCMS Set Permission For User    ${pcms_email_mass}    @{permission_list}
    @{permission_list}=    Create List    ${collection_mass_upload_manage}
    PCMS Unset Permission For User    ${pcms_email_mass}    @{permission_list}
    Close Browser

    Login Pcms    ${pcms_email_mass}    ${pcms_password_mass}
    Go to mass upload menu
    All history of mass upload
    User browse file for upload product to cate    ${file_upload}
    Message cannot access is displayed    ${text_cannot_access}
    Header messege cannot access is displayed    ${text_header_cannot_access}
    Location varify

TC_iTM_01786 - Cannot view and manage(cross between user permission and role permission
    [Documentation]    To verify that user have permission to view collecion for mass upload product to collection so user should view collection mass upload only.
    ...    Condition:
    ...    - User privilege can manage collection mass upload.
    ...    - User role permission can view and manage collection mass upload.
    ...    user-view = 0/user-manage = 1, role-view = 1/role-manage = 1
    [Tags]    Category    Collection    Admin_permissioning    TC_iTM_01786    ready    regression    flash    WLS_Medium
    PCMS Created User Role    ${user_role_group}
    @{permission_list}=    Create List    ${dashboard_view}    ${collection_view}    ${collection_manage}    ${collection_mass_upload_view}     ${collection_mass_upload_manage}
    PCMS Set Permission In Role   ${user_role_group}    @{permission_list}
    PCMS Created User    ${pcms_email_mass}    ${pcms_display_name_mass}    ${pcms_password_mass}    ${user_role_group}

    @{permission_list}=    Create List    ${collection_mass_upload_manage}
    PCMS Set Permission For User    ${pcms_email_mass}    @{permission_list}
    @{permission_list}=    Create List    ${collection_mass_upload_view}
    PCMS Unset Permission For User    ${pcms_email_mass}    @{permission_list}
    Close Browser

    Login Pcms    ${pcms_email_mass}    ${pcms_password_mass}
    Go to mass upload menu
    Message cannot access is displayed    ${text_cannot_access}
    Header messege cannot access is displayed    ${text_header_cannot_access}
    Location mass upload