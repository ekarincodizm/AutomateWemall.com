# *** Settings ***
# Suite Setup         Run Keywords    Open Browser and Go to iTrueMart Portal
# Suite Teardown      Run Keywords    Close All Browsers
# Resource            ${CURDIR}/../../../Resource/init.robot
# Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/portal_page/portal_page_keywords.robot
# Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/Header/keywords_header.robot
# Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/Login/keywords_login.robot
# Test Template       Switch Language

# *** Variables ***
# ${username}             robot01@mail.com
# ${user_display_name}    Robot01@mail.com
# ${password}             123456

# *** Test Cases ***
# TC_iTM_01546 - iTrueMart portal page header - Switch Language (iTM_version)    ${ITM_URL}    ${EMPTY}    /
#     [tags]    regression    iTM_header

# TC_iTM_01556 - Level C brand page header - Switch Language (iTM_version)    ${ITM_URL}/brand/samsung-6931849325692.html    /brand/samsung-6931849325692.html    /brand/samsung-6931849325692.html
#     [tags]    regression    iTM_header

# TC_iTM_01566 - Level C category page header - Switch Language (iTM_version)    ${ITM_URL}/category/hulk-3302288514534.html    /category/hulk-3302288514534.html    /category/hulk-3302288514534.html
#     [tags]    regression    iTM_header

# TC_iTM_01576 - Search page header - Switch Language (iTM_version)    ${ITM_URL}/search2?q=Apple    /search2?q=Apple    /search2?q=Apple
#     [tags]    regression    iTM_header

# TC_iTM_01586 - Everyday Wow page header - Switch Language (iTM_version)    ${ITM_URL}/everyday-wow    /everyday-wow    /everyday-wow
#     [tags]    regression    iTM_header

# TC_iTM_01596 - Order history page header - Switch Language (iTM_version)    ${ITM_URL}/member/orders    /member/orders    /member/orders
#     [tags]    regression    iTM_header
#     [Setup]    Login User to iTrueMart    ${username}    ${password}
#     [Teardown]    Run Keywords    Click Log Out Link
#         ...    AND    Verify Register and Login Link Display
#         ...    AND    Location Should Contain    /auth/login

# TC_iTM_01606 - Register page header - Switch Language (iTM_version)    ${ITM_URL}/users/register    /users/register    /users/register    https
#     [tags]    regression    iTM_header

# TC_iTM_01616 - Member profile page header - Switch Language (iTM_version)    ${ITM_URL}/member/profile    /member/profile    /member/profile
#     [tags]    regression    iTM_header
#     [Setup]    Login User to iTrueMart    ${username}    ${password}
#     [Teardown]    Run Keywords    Click Log Out Link
#         ...    AND    Verify Register and Login Link Display
#         ...    AND    Location Should Contain    /auth/login

# TC_iTM_01626 - Login page header - Switch Language (iTM_version)    ${ITM_URL}/auth/login    /auth/login    /auth/login    https
#     [tags]    regression    iTM_header

# TC_iTM_01636 - Forget password page header - Switch Language (iTM_version)    ${ITM_URL}/forgot_password    /forgot_password    /forgot_password    https
#     [tags]    regression    iTM_header

# TC_iTM_01646 - Contact us page header - Switch Language (iTM_version)    ${ITM_URL}/contact_us    /contact_us    /contact_us
#     [tags]    regression    iTM_header

# TC_iTM_01656 - Policy page header - Switch Language (iTM_version)    ${ITM_URL}/policy/returnpolicy    /policy/returnpolicy    /policy/returnpolicy
#     [tags]    regression    iTM_header

# TC_iTM_01666 - Truemove H page header - Switch Language (iTM_version)    ${ITM_URL}/truemove-h    /truemove-h    /truemove-h
#     [tags]    regression    iTM_header

# TC_iTM_01676 - Truemove H - Register page header - Switch Language (iTM_version)    ${ITM_URL}/truemove-h/registration    /truemove-h/registration    /truemove-h/registration
#     [tags]    regression    iTM_header

# # TC_iTM_01696 - Support page header - Switch Language (iTM_version)    ${ITM_SUPPORT_URL}
# #     [tags]    regression    iTM_header

# TC_iTM_01706 - MNP page header - Switch Language (iTM_version)    ${ITM_URL}/truemove-h/MNP    /truemove-h/MNP    /truemove-h/MNP
#     [tags]    regression    iTM_header

# TC_iTM_01716 - MNP - Register page header - Switch Language (iTM_version)    ${ITM_URL}/truemove-h/registration?inventory_id=APAAA1116211    /truemove-h/registration?inventory_id=APAAA1116211    /truemove-h/registration?inventory_id=APAAA1116211
#     [tags]    regression    iTM_header

# TC_iTM_01726 - Shop in Shop page header - Switch Language (iTM_version)    ${ITM_URL}/shop/mnp    /shop/mnp    /shop/mnp
#     [tags]    regression    iTM_header

# TC_iTM_01736 - Fullcart page header - Switch Language (iTM_version)    ${ITM_URL}/cart    /cart    /cart
#     [tags]    regression    iTM_header

# TC_iTM_01746 - Level D page header - Switch Language (iTM_version)    ${ITM_URL}/products/smart-watch-mykronoz-zesplash-2624639764719.html    /products/smart-watch-mykronoz-zesplash-2624639764719.html    /products/smart-watch-mykronoz-zesplash-2624639764719.html
#     [tags]    regression    iTM_header

# # TC_iTM_01756 - Page not found page header - Switch Language (iTM_version)    ${ITM_URL}/pageNotFound    /pageNotFound    /pageNotFound
# #     [tags]    regression    iTM_header

# *** Keywords ***
# Switch Language
#     [Arguments]    ${full_url}    ${EN_url}    ${TH_url}    ${protocol}=http
#     Go to Specific URL    ${full_url}
#     Check Location Contain    ${full_url}    ${protocol}
#     Verify Language Button    ${protocol}
#     Switch to EN Language
#     Verify Switch to EN    ${EN_url}    ${protocol}
#     Switch to TH Language
#     Verify Switch to TH    ${TH_url}    ${protocol}

