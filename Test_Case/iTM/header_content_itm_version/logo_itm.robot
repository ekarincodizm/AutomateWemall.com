# *** Settings ***
# Suite Setup         Run Keywords    Open Browser and Go to iTrueMart Portal
# Suite Teardown      Run Keywords    Close All Browsers
# Resource            ${CURDIR}/../../../Resource/init.robot
# Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/portal_page/portal_page_keywords.robot
# Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/Header/keywords_header.robot
# Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/Login/keywords_login.robot
# Test Template       Logo redirect to homepage

# *** Variables ***
# ${username}             robot01@mail.com
# ${user_display_name}    Robot01@mail.com
# ${password}             123456

# *** Test Cases ***
# TC_iTM_01541 - iTrueMart portal page header - Logo redirect to homepage (iTM_version)    ${ITM_URL}
#     [tags]    regression    iTM_header

# TC_iTM_01551 - Level C brand page header - Logo redirect to homepage (iTM_version)    ${ITM_URL}/brand/samsung-6931849325692.html
#     [tags]    regression    iTM_header

# TC_iTM_01561 - Level C category page header - Logo redirect to homepage (iTM_version)    ${ITM_URL}/category/hulk-3302288514534.html
#     [tags]    regression    iTM_header

# TC_iTM_01571 - Search page header - Logo redirect to homepage (iTM_version)    ${ITM_URL}/search2?q=Apple
#     [tags]    regression    iTM_header

# TC_iTM_01581 - Everyday Wow page header - Logo redirect to homepage (iTM_version)    ${ITM_URL}/everyday-wow
#     [tags]    regression    iTM_header

# TC_iTM_01591 - Order history page header - Logo redirect to homepage (iTM_version)    ${ITM_URL}/member/orders
#     [tags]    regression    iTM_header
#     [Setup]    Login User to iTrueMart    ${username}    ${password}
#     [Teardown]    Run Keywords    Click Log Out Link
#         ...    AND    Verify Register and Login Link Display
#         ...    AND    Location Should Contain    ${ITM_URL}/

# TC_iTM_01601 - Register page header - Logo redirect to homepage (iTM_version)    ${ITM_URL}/users/register    https
#     [tags]    regression    iTM_header

# TC_iTM_01611 - Member profile page header - Logo redirect to homepage (iTM_version)    ${ITM_URL}/member/profile
#     [tags]    regression    iTM_header
#     [Setup]    Login User to iTrueMart    ${username}    ${password}
#     [Teardown]    Run Keywords    Click Log Out Link
#         ...    AND    Verify Register and Login Link Display
#         ...    AND    Location Should Contain    ${ITM_URL}/

# TC_iTM_01621 - Login page header - Logo redirect to homepage (iTM_version)    ${ITM_URL}/auth/login    https
#     [tags]    regression    iTM_header

# TC_iTM_01631 - Forget password page header - Logo redirect to homepage (iTM_version)    ${ITM_URL}/forgot_password    https
#     [tags]    regression    iTM_header

# TC_iTM_01641 - Contact us page header - Logo redirect to homepage (iTM_version)    ${ITM_URL}/contact_us
#     [tags]    regression    iTM_header

# TC_iTM_01651 - Policy page header - Logo redirect to homepage (iTM_version)    ${ITM_URL}/policy/returnpolicy
#     [tags]    regression    iTM_header

# TC_iTM_01661 - Truemove H page header - Logo redirect to homepage (iTM_version)    ${ITM_URL}/truemove-h
#     [tags]    regression    iTM_header

# TC_iTM_01671 - Truemove H - Register page header - Logo redirect to homepage (iTM_version)    ${ITM_URL}/truemove-h/registration
#     [tags]    regression    iTM_header

# # TC_iTM_01691 - Support page header - Logo redirect to homepage (iTM_version)    ${ITM_SUPPORT_URL}
# #     [tags]    regression    iTM_header

# TC_iTM_01701 - MNP page header - Logo redirect to homepage (iTM_version)    ${ITM_URL}/truemove-h/MNP
#     [tags]    regression    iTM_header

# TC_iTM_01711 - MNP - Register page header - Logo redirect to homepage (iTM_version)    ${ITM_URL}/truemove-h/registration?inventory_id=APAAA1116211
#     [tags]    regression    iTM_header

# TC_iTM_01721 - Shop in Shop page header - Logo redirect to homepage (iTM_version)    ${ITM_URL}/shop/mnp
#     [tags]    regression    iTM_header

# TC_iTM_01731 - Fullcart page header - Logo redirect to homepage (iTM_version)    ${ITM_URL}/cart
#     [tags]    regression    iTM_header

# TC_iTM_01741 - Level D page header - Logo redirect to homepage (iTM_version)    ${ITM_URL}/products/smart-watch-mykronoz-zesplash-2624639764719.html
#     [tags]    regression    iTM_header

# # TC_iTM_01751 - Page not found page header - Logo redirect to homepage (iTM_version)    ${ITM_URL}/pageNotFound
# #     [tags]    regression    iTM_header

# *** Keywords ***
# Logo redirect to homepage
#     [Arguments]    ${full_url}    ${protocol}=http
#     Go to Specific URL    ${full_url}
#     Check Location Contain    ${full_url}    ${protocol}
#     Verify iTM Logo    ${protocol}
#     Click iTM Logo
#     Location Should Be    ${ITM_URL}/

