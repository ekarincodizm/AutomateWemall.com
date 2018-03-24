# *** Settings ***
# Suite Setup       Run Keywords    Open Browser and Go to iTrueMart Portal
# Suite Teardown    Run Keywords    Close All Browsers
# Test Template     Search Product
# Resource          ${CURDIR}/../../../Resource/init.robot
# Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/portal_page/portal_page_keywords.robot
# Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Header/keywords_header.robot
# Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Search_page/Keywords_SearchPage.robot
# Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Login/keywords_login.robot

# *** Variables ***
# ${username}       robot01@mail.com
# ${user_display_name}    Robot01@mail.com
# ${password}       123456

# *** Test Cases ***
# TC_iTM_01542 - iTrueMart portal page header - Search Product (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}

# TC_iTM_01552 - Level C brand page header - Search Product (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/brand/samsung-6931849325692.html

# TC_iTM_01562 - Level C category page header - Search Product (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/category/hulk-3302288514534.html

# TC_iTM_01572 - Search page header - Search Product (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/search2?q=Apple

# TC_iTM_01582 - Everyday Wow page header - Search Product (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/everyday-wow

# TC_iTM_01592 - Order history page header - Search Product (iTM_version)
#     [Tags]    regression    iTM_header
#     [Setup]    Login User to iTrueMart    ${username}    ${password}
#     ${ITM_URL}/member/orders
#     [Teardown]    Run Keywords    Click Log Out Link
#     ...    AND    Verify Register and Login Link Display
#     ...    AND    Location Should Contain    /search2?q=iphone

# TC_iTM_01602 - Register page header - Search Product (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/users/register    https

# TC_iTM_01612 - Member profile page header - Search Product (iTM_version)
#     [Tags]    regression    iTM_header
#     [Setup]    Login User to iTrueMart    ${username}    ${password}
#     ${ITM_URL}/member/profile
#     [Teardown]    Run Keywords    Click Log Out Link
#     ...    AND    Verify Register and Login Link Display
#     ...    AND    Location Should Contain    /search2?q=iphone

# TC_iTM_01622 - Login page header - Search Product (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/auth/login    https

# TC_iTM_01632 - Forget password page header - Search Product (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/forgot_password    https

# TC_iTM_01642 - Contact us page header - Search Product (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/contact_us

# TC_iTM_01652 - Policy page header - Search Product (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/policy/returnpolicy

# TC_iTM_01662 - Truemove H page header - Search Product (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/truemove-h

# TC_iTM_01672 - Truemove H - Register page header - Search Product (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/truemove-h/registration
#     # TC_iTM_01692 - Support page header - Search Product (iTM_version)    ${ITM_SUPPORT_URL}
#     #    [tags]    regression    iTM_header

# TC_iTM_01702 - MNP page header - Search Product (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/truemove-h/MNP

# TC_iTM_01712 - MNP - Register page header - Search Product (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/truemove-h/registration?inventory_id=APAAA1116211

# TC_iTM_01722 - Shop in Shop page header - Search Product (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/shop/mnp

# TC_iTM_01732 - Fullcart page header - Search Product (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/cart

# TC_iTM_01742 - Level D page header - Search Product (iTM_version)
#     [Tags]    regression    iTM_header
#     ${ITM_URL}/products/2854712898105.html
#     # TC_iTM_01752 - Page not found page header - Search Product (iTM_version)
#     #    [Tags]    regression    iTM_header
#     #    ${ITM_URL}/pageNotFound

# *** Keywords ***
# Search Product
#     [Arguments]    ${full_url}    ${protocol}=http
#     Go to Specific URL    ${full_url}
#     Check Location Contain    ${full_url}    ${protocol}
#     Verify Search Box Exist
#     Verify Autosuggestion    iphone
#     Search Product in iTM    iphone
#     Verify Search Result Label    iphone
#     Verify Search Text Box and Page Will Redirect to Search Page    iphone
