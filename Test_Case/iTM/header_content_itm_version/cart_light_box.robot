# *** Settings ***
# Suite Teardown    Run Keywords    Close All Browsers
# Test Setup        Run Keywords    Open Browser and Go to iTrueMart Portal
# Test Teardown     Run Keywords    Close All Browsers
# Test Template     Cart Light Box
# Resource          ${CURDIR}/../../../Resource/init.robot
# Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/portal_page/portal_page_keywords.robot
# Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Header/keywords_header.robot
# Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Login/keywords_login.robot
# Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Cart_light_box/Keywords_CartLightBox.robot
# Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
# Library           ${CURDIR}/../../../Python_Library/DatabaseData.py

# *** Variables ***
# ${username}       robot01@mail.com
# ${user_display_name}    Robot01@mail.com
# ${password}       123456

# *** Test Cases ***
# TC_iTM_01543 - iTrueMart portal page header - Cart Light Box (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}    yes

# TC_iTM_01553 - Level C brand page header - Cart Light Box (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/brand/samsung-6931849325692.html    yes

# TC_iTM_01563 - Level C category page header - Cart Light Box (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/category/hulk-3302288514534.html    yes

# TC_iTM_01573 - Search page header - Cart Light Box (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/search2?q=Apple    yes

# TC_iTM_01583 - Everyday Wow page header - Cart Light Box (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/everyday-wow    yes

# TC_iTM_01593 - Order history page header - Cart Light Box (iTM_version)
#     [Tags]    regression    iTM_header
#     [Setup]    Run Keywords    Open Browser and Go to iTrueMart Portal
#     ...    AND    Login User to iTrueMart    ${username}    ${password}
#     ${ITM_URL}/member/orders    yes
#     [Teardown]    Run Keywords    Clear Product in Cart
#     ...    AND    Click Log Out Link
#     ...    AND    Verify Register and Login Link Display
#     ...    AND    Location Should Contain    /auth/login

# TC_iTM_01603 - Register page header - Cart Light Box (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/users/register    yes    https

# TC_iTM_01613 - Member profile page header - Cart Light Box (iTM_version)
#     [Tags]    regression    iTM_header
#     [Setup]    Run Keywords    Open Browser and Go to iTrueMart Portal
#     ...    AND    Login User to iTrueMart    ${username}    ${password}
#     ${ITM_URL}/member/profile    yes
#     [Teardown]    Run Keywords    Clear Product in Cart
#     ...    AND    Click Log Out Link
#     ...    AND    Verify Register and Login Link Display
#     ...    AND    Location Should Contain    /auth/login

# TC_iTM_01623 - Login page header - Cart Light Box (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/auth/login    yes    https

# TC_iTM_01633 - Forget password page header - Cart Light Box (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/forgot_password    yes    https

# TC_iTM_01643 - Contact us page header - Cart Light Box (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/contact_us    yes

# TC_iTM_01653 - Policy page header - Cart Light Box (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/policy/returnpolicy    yes

# TC_iTM_01663 - Truemove H page header - Cart Light Box (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/truemove-h    yes

# TC_iTM_01673 - Truemove H - Register page header - Cart Light Box (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/truemove-h/registration    yes

#     # TC_iTM_01693 - Support page header - Cart Light Box (iTM_version)    ${ITM_SUPPORT_URL}
#     #    [tags]    regression    iTM_header

# TC_iTM_01703 - MNP page header - Cart Light Box (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/truemove-h/MNP    yes

# TC_iTM_01713 - MNP - Register page header - Cart Light Box (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/truemove-h/registration?inventory_id=APAAA1116211    yes

# TC_iTM_01723 - Shop in Shop page header - Cart Light Box (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/shop/mnp    yes

# TC_iTM_01733 - Fullcart page header - Cart Light Box (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/cart    no

# TC_iTM_01743 - Level D page header - Cart Light Box (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/products/smart-watch-mykronoz-zesplash-2624639764719.html    yes

# # TC_iTM_01753 - Page not found page header - Cart Light Box (iTM_version)
# #     [Tags]    regression    iTM_header
# #     ${ITM_URL}/pageNotFound    yes

# *** Keywords ***
# Cart Light Box
#     [Arguments]    ${full_url}    ${mode}    ${protocol}=http
#     Run Keyword If    '${mode}' == 'yes'    Have Cart Light Box    ${full_url}    ${protocol}
#     Run Keyword If    '${mode}' == 'no'    Do Not Have Cart Light Box    ${full_url}    ${protocol}

# Have Cart Light Box
#     [Arguments]    ${full_url}    ${protocol}=http
#     Go to Specific URL    ${full_url}
#     Check Location Contain    ${full_url}    ${protocol}
#     Check Cart Badge Quantity    0
#     Click Cart Box Button
#     Verify Cart Light Box is Empty
#     Add Product to Cart    2143121994478
#     Go to Specific URL    ${full_url}
#     Check Cart Badge Quantity    1
#     # Login User to iTrueMart    ${username}    ${password}
#     Add Product to Cart    2895992581809
#     Go to Specific URL    ${full_url}
#     Check Cart Badge Quantity    2
#     Click Cart Box Button
#     Keywords_CartLightBox.Verify Cart Light Box is Not Empty
#     Close Cart Light Box

# Do Not Have Cart Light Box
#     [Arguments]    ${full_url}    ${protocol}=http
#     Go to Specific URL    ${full_url}
#     Check Location Contain    ${full_url}    ${protocol}
#     Verify Cart icon Do Not Show

# Clear Product in Cart
#     Click Cart Box Button
#     Sleep    3s
#     Delete Specific Item in Cart Light Box    TRAAB1111911
#     Sleep    3s
#     Delete Specific Item in Cart Light Box    LEAAC1111511
#     Close Cart Light Box
