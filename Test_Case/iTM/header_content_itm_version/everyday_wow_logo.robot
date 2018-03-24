# *** Settings ***
# Suite Setup         Run Keywords    Open Browser and Go to iTrueMart Portal
# Suite Teardown      Run Keywords    Close All Browsers
# Resource            ${CURDIR}/../../../Resource/init.robot
# Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/portal_page/portal_page_keywords.robot
# Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/Header/keywords_header.robot
# Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/Login/keywords_login.robot
# Test Template       Everyday Wow Logo

# *** Variables ***
# ${username}             robot01@mail.com
# ${user_display_name}    Robot01@mail.com
# ${password}             123456

# *** Test Cases ***
# TC_iTM_01547 - iTrueMart portal page header - Everyday Wow Logo (iTM_version)    ${ITM_URL}
#     [tags]    regression    iTM_header

# TC_iTM_01557 - Level C brand page header - Everyday Wow Logo (iTM_version)    ${ITM_URL}/brand/samsung-6931849325692.html
#     [tags]    regression    iTM_header

# TC_iTM_01567 - Level C category page header - Everyday Wow Logo (iTM_version)    ${ITM_URL}/category/hulk-3302288514534.html
#     [tags]    regression    iTM_header

# TC_iTM_01577 - Search page header - Everyday Wow Logo (iTM_version)    ${ITM_URL}/search2?q=Apple
#     [tags]    regression    iTM_header

# TC_iTM_01587 - Everyday Wow page header - Everyday Wow Logo (iTM_version)    ${ITM_URL}/everyday-wow
#     [tags]    regression    iTM_header

# TC_iTM_01597 - Order history page header - Everyday Wow Logo (iTM_version)    ${ITM_URL}/member/orders
#     [tags]    regression    iTM_header
#     [Setup]    Login User to iTrueMart    ${username}    ${password}
#     [Teardown]    Run Keywords    Click Log Out Link
#         ...    AND    Verify Register and Login Link Display
#         ...    AND    Location Should Contain    ${ITM_URL}/everyday-wow

# TC_iTM_01607 - Register page header - Everyday Wow Logo (iTM_version)    ${ITM_URL}/users/register    https
#     [tags]    regression    iTM_header

# TC_iTM_01617 - Member profile page header - Everyday Wow Logo (iTM_version)    ${ITM_URL}/member/profile
#     [tags]    regression    iTM_header
#     [Setup]    Login User to iTrueMart    ${username}    ${password}
#     [Teardown]    Run Keywords    Click Log Out Link
#         ...    AND    Verify Register and Login Link Display
#         ...    AND    Location Should Contain    ${ITM_URL}/everyday-wow

# TC_iTM_01627 - Login page header - Everyday Wow Logo (iTM_version)    ${ITM_URL}/auth/login    https
#     [tags]    regression    iTM_header

# TC_iTM_01637 - Forget password page header - Everyday Wow Logo (iTM_version)    ${ITM_URL}/forgot_password    https
#     [tags]    regression    iTM_header

# TC_iTM_01647 - Contact us page header - Everyday Wow Logo (iTM_version)    ${ITM_URL}/contact_us
#     [tags]    regression    iTM_header

# TC_iTM_01657 - Policy page header - Everyday Wow Logo (iTM_version)    ${ITM_URL}/policy/returnpolicy
#     [tags]    regression    iTM_header

# TC_iTM_01667 - Truemove H page header - Everyday Wow Logo (iTM_version)    ${ITM_URL}/truemove-h
#     [tags]    regression    iTM_header

# TC_iTM_01677 - Truemove H - Register page header - Everyday Wow Logo (iTM_version)    ${ITM_URL}/truemove-h/registration
#     [tags]    regression    iTM_header

# # TC_iTM_01697 - Support page header - Everyday Wow Logo (iTM_version)    ${ITM_SUPPORT_URL}
# #     [tags]    regression    iTM_header

# TC_iTM_01707 - MNP page header - Everyday Wow Logo (iTM_version)    ${ITM_URL}/truemove-h/MNP
#     [tags]    regression    iTM_header

# TC_iTM_01717 - MNP - Register page header - Everyday Wow Logo (iTM_version)    ${ITM_URL}/truemove-h/registration?inventory_id=APAAA1116211
#     [tags]    regression    iTM_header

# TC_iTM_01727 - Shop in Shop page header - Everyday Wow Logo (iTM_version)    ${ITM_URL}/shop/mnp
#     [tags]    regression    iTM_header

# TC_iTM_01737 - Fullcart page header - Everyday Wow Logo (iTM_version)    ${ITM_URL}/cart
#     [tags]    regression    iTM_header

# TC_iTM_01747 - Level D page header - Everyday Wow Logo (iTM_version)    ${ITM_URL}/products/smart-watch-mykronoz-zesplash-2624639764719.html
#     [tags]    regression    iTM_header

# # TC_iTM_01757 - Page not found page header - Everyday Wow Logo (iTM_version)    ${ITM_URL}/pageNotFound
# #     [tags]    regression    iTM_header

# *** Keywords ***
# Everyday Wow Logo
#     [Arguments]    ${full_url}    ${protocol}=http
#     Go to Specific URL    ${full_url}
#     Check Location Contain    ${full_url}    ${protocol}
#     Verify Everyday Wow Banner    ${protocol}
#     Click Everyday Wow Logo
#     Location Should Be    ${ITM_URL}/everyday-wow

