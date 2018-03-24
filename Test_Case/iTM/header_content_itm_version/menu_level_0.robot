# *** Settings ***
# Suite Setup         Run Keywords    Open Browser and Go to iTrueMart Portal
# Suite Teardown      Run Keywords    Close All Browsers
# Resource            ${CURDIR}/../../../Resource/init.robot
# Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/portal_page/portal_page_keywords.robot
# Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/Header/keywords_header.robot
# Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/Login/keywords_login.robot
# Test Template       Menu Level 0

# *** Variables ***
# ${username}             robot01@mail.com
# ${user_display_name}    Robot01@mail.com
# ${password}             123456

# *** Test Cases ***
# TC_iTM_01549 - iTrueMart portal page header - Menu Level 0 (iTM_version)    ${ITM_URL}
#     [tags]    regression    iTM_header

# TC_iTM_01559 - Level C brand page header - Menu Level 0 (iTM_version)    ${ITM_URL}/brand/samsung-6931849325692.html
#     [tags]    regression    iTM_header

# TC_iTM_01569 - Level C category page header - Menu Level 0 (iTM_version)    ${ITM_URL}/category/hulk-3302288514534.html
#     [tags]    regression    iTM_header

# TC_iTM_01579 - Search page header - Menu Level 0 (iTM_version)    ${ITM_URL}/search2?q=Apple
#     [tags]    regression    iTM_header

# TC_iTM_01589 - Everyday Wow page header - Menu Level 0 (iTM_version)    ${ITM_URL}/everyday-wow
#     [tags]    regression    iTM_header

# TC_iTM_01599 - Order history page header - Menu Level 0 (iTM_version)    ${ITM_URL}/member/orders
#     [tags]    regression    iTM_header
#     [Setup]    Login User to iTrueMart    ${username}    ${password}
#     [Teardown]    Run Keywords    Click Log Out Link
#         ...    AND    Verify Register and Login Link Display
#         ...    AND    Location Should Contain    /auth/login
# TC_iTM_01609 - Register page header - Menu Level 0 (iTM_version)    ${ITM_URL}/users/register    https
#     [tags]    regression    iTM_header

# TC_iTM_01619 - Member profile page header - Menu Level 0 (iTM_version)    ${ITM_URL}/member/profile
#     [tags]    regression    iTM_header
#     [Setup]    Login User to iTrueMart    ${username}    ${password}
#     [Teardown]    Run Keywords    Click Log Out Link
#         ...    AND    Verify Register and Login Link Display
#         ...    AND    Location Should Contain    /auth/login
# TC_iTM_01629 - Login page header - Menu Level 0 (iTM_version)    ${ITM_URL}/auth/login    https
#     [tags]    regression    iTM_header

# TC_iTM_01639 - Forget password page header - Menu Level 0 (iTM_version)    ${ITM_URL}/forgot_password    https
#     [tags]    regression    iTM_header

# TC_iTM_01649 - Contact us page header - Menu Level 0 (iTM_version)    ${ITM_URL}/contact_us
#     [tags]    regression    iTM_header

# TC_iTM_01659 - Policy page header - Menu Level 0 (iTM_version)    ${ITM_URL}/policy/returnpolicy
#     [tags]    regression    iTM_header

# TC_iTM_01669 - Truemove H page header - Menu Level 0 (iTM_version)    ${ITM_URL}/truemove-h
#     [tags]    regression    iTM_header

# TC_iTM_01679 - Truemove H - Register page header - Menu Level 0 (iTM_version)    ${ITM_URL}/truemove-h/registration
#     [tags]    regression    iTM_header

# # TC_iTM_01699 - Support page header - Menu Level 0 (iTM_version)    ${ITM_SUPPORT_URL}
# #     [tags]    regression    iTM_header

# TC_iTM_01709 - MNP page header - Menu Level 0 (iTM_version)    ${ITM_URL}/truemove-h/MNP
#     [tags]    regression    iTM_header

# TC_iTM_01719 - MNP - Register page header - Menu Level 0 (iTM_version)    ${ITM_URL}/truemove-h/registration?inventory_id=APAAA1116211
#     [tags]    regression    iTM_header

# TC_iTM_01729 - Shop in Shop page header - Menu Level 0 (iTM_version)    ${ITM_URL}/shop/mnp
#     [tags]    regression    iTM_header

# TC_iTM_01739 - Fullcart page header - Menu Level 0 (iTM_version)    ${ITM_URL}/cart
#     [tags]    regression    iTM_header

# TC_iTM_01749 - Level D page header - Menu Level 0 (iTM_version)    ${ITM_URL}/products/smart-watch-mykronoz-zesplash-2624639764719.html
#     [tags]    regression    iTM_header

# # TC_iTM_01759 - Page not found page header - Menu Level 0 (iTM_version)    ${ITM_URL}/pageNotFound
# #     [tags]    regression    iTM_header

# *** Keywords ***
# Menu Level 0
#     [Arguments]    ${full_url}    ${protocol}=http
#     Go to Specific URL    ${full_url}
#     Check Location Contain    ${full_url}    ${protocol}
#     Verify Menu Bar Display

