# *** Settings ***
# Suite Setup         Run Keywords    Open Browser and Go to iTrueMart Portal
# Suite Teardown      Run Keywords    Close All Browsers
# Resource            ${CURDIR}/../../../Resource/init.robot
# Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/portal_page/portal_page_keywords.robot
# Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/Header/keywords_header.robot
# Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/Login/keywords_login.robot
# Test Template       Chat Online

# *** Variables ***
# ${username}             robot01@mail.com
# ${user_display_name}    Robot01@mail.com
# ${password}             123456

# *** Test Cases ***
# TC_iTM_01540 - iTrueMart portal page header - Chat Online (iTM_version)    ${ITM_URL}
#     [tags]    regression    iTM_header

# TC_iTM_01550 - Level C brand page header - Chat Online (iTM_version)    ${ITM_URL}/brand/samsung-6931849325692.html
#     [tags]    regression    iTM_header

# TC_iTM_01560 - Level C category page header - Chat Online (iTM_version)    ${ITM_URL}/category/hulk-3302288514534.html
#     [tags]    regression    iTM_header

# TC_iTM_01570 - Search page header - Chat Online (iTM_version)    ${ITM_URL}/search2?q=Apple
#     [tags]    regression    iTM_header

# TC_iTM_01580 - Everyday Wow page header - Chat Online (iTM_version)    ${ITM_URL}/everyday-wow
#     [tags]    regression    iTM_header

# TC_iTM_01590 - Order history page header - Chat Online (iTM_version)    ${ITM_URL}/member/orders
#     [tags]    regression    iTM_header
#     [Setup]    Login User to iTrueMart    ${username}    ${password}
#     [Teardown]    Run Keywords    Click Log Out Link
#         ...    AND    Verify Register and Login Link Display
#         ...    AND    Location Should Contain    /auth/login

# TC_iTM_01600 - Register page header - Chat Online (iTM_version)    ${ITM_URL}/users/register    https
#     [tags]    regression    iTM_header

# TC_iTM_01610 - Member profile page header - Chat Online (iTM_version)    ${ITM_URL}/member/profile
#     [tags]    regression    iTM_header
#     [Setup]    Login User to iTrueMart    ${username}    ${password}
#     [Teardown]    Run Keywords    Click Log Out Link
#         ...    AND    Verify Register and Login Link Display
#         ...    AND    Location Should Contain    /auth/login

# TC_iTM_01620 - Login page header - Chat Online (iTM_version)    ${ITM_URL}/auth/login    https
#     [tags]    regression    iTM_header

# TC_iTM_01630 - Forget password page header - Chat Online (iTM_version)    ${ITM_URL}/forgot_password    https
#     [tags]    regression    iTM_header

# TC_iTM_01640 - Contact us page header - Chat Online (iTM_version)    ${ITM_URL}/contact_us
#     [tags]    regression    iTM_header

# TC_iTM_01650 - Policy page header - Chat Online (iTM_version)    ${ITM_URL}/policy/returnpolicy
#     [tags]    regression    iTM_header

# TC_iTM_01660 - Truemove H page header - Chat Online (iTM_version)    ${ITM_URL}/truemove-h
#     [tags]    regression    iTM_header

# TC_iTM_01670 - Truemove H - Register page header - Chat Online (iTM_version)    ${ITM_URL}/truemove-h/registration
#     [tags]    regression    iTM_header

# # TC_iTM_01690 - Support page header - Chat Online (iTM_version)    ${ITM_SUPPORT_URL}
# #     [tags]    regression    iTM_header

# TC_iTM_01700 - MNP page header - Chat Online (iTM_version)    ${ITM_URL}/truemove-h/MNP
#     [tags]    regression    iTM_header

# TC_iTM_01710 - MNP - Register page header - Chat Online (iTM_version)    ${ITM_URL}/truemove-h/registration?inventory_id=APAAA1116211
#     [tags]    regression    iTM_header

# TC_iTM_01720 - Shop in Shop page header - Chat Online (iTM_version)    ${ITM_URL}/shop/mnp
#     [tags]    regression    iTM_header

# TC_iTM_01730 - Fullcart page header - Chat Online (iTM_version)    ${ITM_URL}/cart
#     [tags]    regression    iTM_header

# TC_iTM_01740 - Level D page header - Chat Online (iTM_version)    ${ITM_URL}/products/smart-watch-mykronoz-zesplash-2624639764719.html
#     [tags]    regression    iTM_header

# # TC_iTM_01750 - Page not found page header - Chat Online (iTM_version)    ${ITM_URL}/pageNotFound
# #     [tags]    regression    iTM_header

# *** Keywords ***
# Chat Online
#     [Arguments]    ${full_url}    ${protocol}=http
#     Go to Specific URL    ${full_url}
#     Check Location Contain    ${full_url}    ${protocol}
#     Verify Chat Online Link Display    ${protocol}
#     # Click Open Chat Online
#     # Verify Chat Online iFrame Display

