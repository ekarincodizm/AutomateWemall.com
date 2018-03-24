# *** Settings ***
# Test Setup          Open Browser Size and Go to Specific URL    ${WEMALL_WEB}
# # Test Teardown       Run Keywords    Close All Browsers
# # Suite Teardown      Run Keywords    Close All Browsers
# Resource            ${CURDIR}/../../../Resource/init.robot
# # Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/portal_page/portal_page_keywords.robot
# # Resource            ${CURDIR}/../../../Keyword/Portal/wemall/header/keywords_wemall_header.robot
# # # Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/Cart Light Box/Keywords_CartLightBox.robot
# # Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/Full_cart/keywords_full_cart.robot
# # # Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
# # Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_d_page/WebElement_LevelD.robot
# # Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/Cart_light_box/WebElement_CartLightBox.robot
# # Test Template       Cart Badge Icon

# *** Variables ***
# # ${username}             robot10@mail.com
# # ${user_display_name}    Robot10@mail.com
# # ${password}             123456

# *** Test Cases ***
# TC_WMALL_xxxxx - Level C brand page header - Cart Badge Icon (WeMall_version)
#     Log To Console    TEST


# *** Keywords ***
# # Cart Badge Icon
# #     [Arguments]    ${full_url}    ${mode}    ${protocol}=http
# #     Run Keyword If     '${mode}' == 'yes'    Have Cart Light Box    ${full_url}    ${protocol}
# #     Run Keyword If     '${mode}' == 'no'    Do Not Have Cart Light Box    ${full_url}    ${protocol}

# # Have Cart Light Box
# #     [Arguments]    ${full_url}    ${protocol}=http
# #     keywords_wemall_header.Go to Specific URL    ${full_url}
# #     Check Location Contain    ${full_url}    ${protocol}
# #     Check Cart Badge Quantity    0
# #     Click Cart Box Button
# #     Check Location Contain    ${WEMALL_WEB}/cart    http
# #     Verify Cart Light Box is Empty
# #     Add Product to Cart    2143121994478
# #     keywords_wemall_header.Go to Specific URL    ${full_url}
# #     Sleep    5s
# #     Check Cart Badge Quantity    1
# #     # Login User to iTrueMart    ${username}    ${password}
# #     Add Product to Cart    2895992581809
# #     keywords_wemall_header.Go to Specific URL    ${full_url}
# #     Sleep    5s
# #     Check Cart Badge Quantity    2
# #     Click Cart Box Button
# #     Check Location Contain    ${WEMALL_WEB}/cart    http
# #     Verify Cart Light Box is Not Empty

# # Do Not Have Cart Light Box
# #     [Arguments]    ${full_url}    ${protocol}=http
# #     keywords_wemall_header.Go to Specific URL    ${full_url}
# #     Sleep    5s
# #     Check Location Contain    ${full_url}    ${protocol}
# #     Verify Cart icon Do Not Show

# # Add Product to Cart
# #     [Arguments]    ${product_pkey}
# #     Go to Level D by Pkey    ${product_pkey}
# #     Wait Until Element is Visible    ${LvD_Add_to_Cart}    30s
# #     Click Add to Cart
# #     Verify Cart Light Box is Not Empty

# # Go to Level D by Pkey
# #     [Arguments]    ${product_pkey}
# #     Go to    ${WEMALL_WEB}/products/${product_pkey}.html

# # Click Add to Cart
# #     Wait Until Element is Visible    jquery=.box_status.active.box-status-has-stock    30s
# #     Wait Until Element is Visible    ${LvD_Add_to_Cart}    30s
# #     Click Element    ${LvD_Add_to_Cart}

# # Verify Cart Light Box is Not Empty
# #     Wait Until Element Is Visible    ${cart_light_box_popup}    15s
# #     Wait Until Page Does Not Contain Element    ${cart_light_box_popup}:contains("กำลังโหลดรายการ...")    30s
# #     Wait Until Element Is Visible    ${product_in_cart_list}    15s


# Open Browser Size and Go to Specific URL
#     [Arguments]    ${full_url}
#     Open Browser    ${full_url}   ${BROWSER}    None
#     Set Window Position    ${0}    ${0}
#     Set Window Size    ${720}    ${900}
