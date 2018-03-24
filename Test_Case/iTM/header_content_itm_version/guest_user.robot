# *** Settings ***
# Suite Setup         Run Keywords    Open Browser and Go to iTrueMart Portal
# Suite Teardown      Run Keywords    Close All Browsers
# Resource            ${CURDIR}/../../../Resource/init.robot
# Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/portal_page/portal_page_keywords.robot
# Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/Header/keywords_header.robot
# Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/Login/keywords_login.robot
# Test Template       Guest User

# *** Variables ***
# ${username}             robot01@mail.com
# ${user_display_name}    Robot01@mail.com
# ${password}             123456

# *** Test Cases ***
# TC_iTM_01544 - iTrueMart portal page header - Guest User (iTM_version)    ${ITM_URL}
#     [tags]    regression    iTM_header

# TC_iTM_01554 - Level C brand page header - Guest User (iTM_version)    ${ITM_URL}/brand/samsung-6931849325692.html
#     [tags]    regression    iTM_header

# TC_iTM_01564 - Level C category page header - Guest User (iTM_version)    ${ITM_URL}/category/hulk-3302288514534.html
#     [tags]    regression    iTM_header

# TC_iTM_01574 - Search page header - Guest User (iTM_version)    ${ITM_URL}/search2?q=Apple
#     [tags]    regression    iTM_header

# TC_iTM_01584 - Everyday Wow page header - Guest User (iTM_version)    ${ITM_URL}/everyday-wow
#     [tags]    regression    iTM_header

# TC_iTM_01604 - Register page header - Guest User (iTM_version)    ${ITM_URL}/users/register    https
#     [tags]    regression    iTM_header

# TC_iTM_01624 - Login page header - Guest User (iTM_version)    ${ITM_URL}/auth/login    https
#     [tags]    regression    iTM_header

# TC_iTM_01634 - Forget password page header - Guest User (iTM_version)    ${ITM_URL}/forgot_password    https
#     [tags]    regression    iTM_header

# TC_iTM_01644 - Contact us page header - Guest User (iTM_version)    ${ITM_URL}/contact_us
#     [tags]    regression    iTM_header

# TC_iTM_01654 - Policy page header - Guest User (iTM_version)    ${ITM_URL}/policy/returnpolicy
#     [tags]    regression    iTM_header

# TC_iTM_01664 - Truemove H page header - Guest User (iTM_version)    ${ITM_URL}/truemove-h
#     [tags]    regression    iTM_header

# TC_iTM_01674 - Truemove H - Register page header - Guest User (iTM_version)    ${ITM_URL}/truemove-h/registration
#     [tags]    regression    iTM_header

# # TC_iTM_01691 - Support page header - Guest User (iTM_version)    ${ITM_SUPPORT_URL}
# #     [tags]    regression    iTM_header

# TC_iTM_01704 - MNP page header - Guest User (iTM_version)    ${ITM_URL}/truemove-h/MNP
#     [tags]    regression    iTM_header

# TC_iTM_01714 - MNP - Register page header - Guest User (iTM_version)    ${ITM_URL}/truemove-h/registration?inventory_id=APAAA1116211
#     [tags]    regression    iTM_header

# TC_iTM_01724 - Shop in Shop page header - Guest User (iTM_version)    ${ITM_URL}/shop/mnp
#     [tags]    regression    iTM_header

# TC_iTM_01734 - Fullcart page header - Guest User (iTM_version)    ${ITM_URL}/cart
#     [tags]    regression    iTM_header

# TC_iTM_01744 - Level D page header - Guest User (iTM_version)    ${ITM_URL}/products/smart-watch-mykronoz-zesplash-2624639764719.html
#     [tags]    regression    iTM_header

# # TC_iTM_01754 - Page not found page header - Guest User (iTM_version)    ${ITM_URL}/pageNotFound
# #     [tags]    regression    iTM_header

# *** Keywords ***
# Guest User
#     [Arguments]    ${full_url}    ${protocol}=http
#     Go to Specific URL    ${full_url}
#     Check Location Contain    ${full_url}    ${protocol}
#     Verify Register and Login Link Display

