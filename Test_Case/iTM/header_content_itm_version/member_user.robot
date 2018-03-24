# *** Settings ***
# Suite Setup       Run Keywords    Open Browser and Go to iTrueMart Portal
# Suite Teardown    Run Keywords    Close All Browsers
# Test Template     Member User
# Resource          ${CURDIR}/../../../Resource/init.robot
# Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/portal_page/portal_page_keywords.robot
# Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Header/keywords_header.robot
# Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Search_page/Keywords_SearchPage.robot
# Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Login/keywords_login.robot
# Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/member_profile/keywords_member_profile.robot
# Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Order_History/keywords_order_history.robot

# *** Variables ***
# ${username}       robot01@mail.com
# ${user_display_name}    Robot01@mail.com
# ${password}       123456

# *** Test Cases ***
# TC_iTM_01545 - iTrueMart portal page header - Member User (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}    ${ITM_URL}

# TC_iTM_01555 - Level C brand page header - Member User (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/brand/samsung-6931849325692.html    ${ITM_URL}/brand/samsung-6931849325692.html

# TC_iTM_01565 - Level C category page header - Member User (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/category/hulk-3302288514534.html    ${ITM_URL}/category/hulk-3302288514534.html

# TC_iTM_01575 - Search page header - Member User (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/search2?q=Apple    ${ITM_URL}/search2

# TC_iTM_01585 - Everyday Wow page header - Member User (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/everyday-wow    ${ITM_URL}/everyday-wow

# TC_iTM_01595 - Order history page header - Member User (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/member/orders    www.itruemart-dev.com%2Fmember%2Forders    https    ${ITM_URL}

# TC_iTM_01605 - Register page header - Member User (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/users/register    ${ITM_URL}/users/register    https    ${ITM_URL}

# TC_iTM_01615 - Member profile page header - Member User (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/member/profile    www.itruemart-dev.com/member/profile    https    ${ITM_URL}

# TC_iTM_01625 - Login page header - Member User (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/auth/login    ${ITM_URL}/auth/login    https    ${ITM_URL}

# TC_iTM_01635 - Forget password page header - Member User (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/forgot_password    ${ITM_URL}/forgot_password    https    /forgot_password

# TC_iTM_01645 - Contact us page header - Member User (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/contact_us    ${ITM_URL}/contact_us

# TC_iTM_01655 - Policy page header - Member User (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/policy/returnpolicy    ${ITM_URL}/policy/returnpolicy

# TC_iTM_01665 - Truemove H page header - Member User (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/truemove-h    ${ITM_URL}/truemove-h

# TC_iTM_01675 - Truemove H - Register page header - Member User (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/truemove-h/registration    ${ITM_URL}/truemove-h/registration
#     # TC_iTM_01695 - Support page header - Member User (iTM_version)    ${ITM_SUPPORT_URL}
#     #    [tags]    regression    iTM_header

# TC_iTM_01705 - MNP page header - Member User (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/truemove-h/MNP    ${ITM_URL}/truemove-h/MNP

# TC_iTM_01715 - MNP - Register page header - Member User (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/truemove-h/registration?inventory_id=APAAA1116211    ${ITM_URL}/truemove-h/registration

# TC_iTM_01725 - Shop in Shop page header - Member User (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/shop/mnp    ${ITM_URL}/shop/mnp

# TC_iTM_01735 - Fullcart page header - Member User (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/cart    ${ITM_URL}/cart

# TC_iTM_01745 - Level D page header - Member User (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/products/smart-watch-mykronoz-zesplash-2624639764719.html    ${ITM_URL}/products/smart-watch-mykronoz-zesplash-2624639764719.html

# # TC_iTM_01755 - Page not found page header - Member User (iTM_version)
# #     [Tags]    regression    iTM_header
# #     ${ITM_URL}/pageNotFound    ${ITM_URL}/pageNotFound

# *** Keywords ***
# Member User
#     [Arguments]    ${full_url}    ${expected_url}    ${protocol}=http    ${expected_url2}=${expected_url}
#     Go to Specific URL    ${full_url}
#     Check Location Contain    ${expected_url}    ${protocol}
#     Login User to iTrueMart    ${username}    ${password}
#     Verify Register and Login Link Not Display
#     Verify User Display Name    ${user_display_name}
#     Check Location Contain    ${expected_url2}    http
#     Click User Profile Link
#     Verify Member User Account    ${user_display_name}
#     Go to Specific URL    ${full_url}
#     Click Order History Link
#     Verify Order History Page Exist
#     Go to Specific URL    ${full_url}
#     # Click New Member Coupon Link
#     # Verify New Member Coupon Page
#     # Go to Specific URL    ${full_url}
#     [Teardown]    Run Keywords    Click Log Out Link
#     ...    AND    Verify Register and Login Link Display
#     ...    AND    Check Location Contain    ${expected_url2}    ${protocol}
