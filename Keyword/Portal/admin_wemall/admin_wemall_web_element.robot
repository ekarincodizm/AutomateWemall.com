*** Variables ***
##### Login Page
${input_username_login}             jquery=#login-username
${input_password_login}             jquery=#login-password
${button_login_admin_wemall}        jquery=#btn-login
${button_add_user_enable}           jquery=#btnCreateUser@disabled

##### User List Page
${button_create_user}               jquery=#btnCreateUser
${user_list_menu_button}            jquery=#userListMenu
${user_list_input_shop}             jquery=md-autocomplete[md-search-text=shop] input
${user_list_search_btn}             jquery=#searchBtn
${user_list_loading}                jquery=div.loading-container

##### User Create Page
${input_username_user_create}           jquery=#inputUsername
${input_first_name_user_create}         jquery=#inputFirstName
${input_last_name_user_create}          jquery=#inputLastName
${input_email_user_create}              jquery=#inputEmail
${input_password_user_create}           jquery=#inputPassword
${input_repassword_user_create}         jquery=#inputReEnterPassword
${button_save_and_next}                 jquery=#createUser
${invalid_text}                         jquery=span.select:visible
${tab_userinfo_active}                  xpath=//ul/li[@class='active']/a[text()='User Information']
${tab_role_active}                      xpath=//ul/li[@class='active']/a[contains(text(),'Role')]

##### User Role Page
${role_search_button}                   jquery=#searchRoleId
${role_tab}                             jquery=#myTab5 li:eq(1)@class
${role_autocomplete_shopName}           jquery=md-autocomplete[md-search-text=shopName]
${role_input_shopName}                  jquery=md-autocomplete[md-search-text=shopName] input
${role_search_btn}                      jquery=#searchRoleId
${role_assign_btn}                      jquery=#assignButton1
${role_msgbox}                          jquery=msgbox div.outterMsgBox
${role_msgbox_header}                   jquery=msgbox div.outterMsgBox div.widget-header span.widget-caption
${role_msgbox_body}                     jquery=msgbox div.outterMsgBox div.widget-body


##### Manage User
${edit_butom_0}                         jquery=.btn-info:eq(0)
${input_username}                       jquery=#userName
${username_info}                        jquery=.header-title h1 span
${input_username_info}                  jquery=#inputUsername
${manage_role_tab}                      jquery=#role_tab

