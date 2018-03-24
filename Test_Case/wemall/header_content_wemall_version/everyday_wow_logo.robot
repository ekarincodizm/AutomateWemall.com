# *** Settings ***
# Suite Setup         Open Browser and Go to Specific URL    ${WEMALL_WEB}
# Suite Teardown      Run Keywords    Close All Browsers
# Resource            ${CURDIR}/../../../Resource/init.robot
# Resource            ${CURDIR}/../../../Keyword/Portal/iTrueMart/portal_page/portal_page_keywords.robot
# Resource            ${CURDIR}/../../../Keyword/Portal/wemall/header/keywords_wemall_header.robot
# Test Template       Everyday Wow Logo

# *** Variables ***
# ${username}             robot01@mail.com
# ${user_display_name}    Robot01@mail.com
# ${password}             123456

# *** Test Cases ***
# TC_WMALL_01433 - Level C brand page header - Everyday Wow Logo (WeMall_version)    ${WEMALL_WEB}/brand/samsung-6931849325692.html
#     [tags]    regression    wemall_header

# # TC_WMALL_01443 - Level C category page header - Everyday Wow Logo (WeMall_version)    ${WEMALL_WEB}/category/hulk-3302288514534.html
# #     [tags]    regression    wemall_header

# TC_WMALL_01443 - Level C category page header - Everyday Wow Logo (WeMall_version)    ${WEMALL_WEB}/category/hulk-category-3302288514534.html
#     [tags]    regression    wemall_header

# TC_WMALL_01453 - Search page header - Everyday Wow Logo (WeMall_version)    ${WEMALL_WEB}/search2?q=Apple
#     [tags]    regression    wemall_header

# TC_WMALL_01463 - Everyday Wow page header - Everyday Wow Logo (WeMall_version)    ${WEMALL_WEB}/everyday-wow
#     [tags]    regression    wemall_header

# TC_WMALL_01512 - Login header - Everyday Wow Logo (WeMall_version)   ${WEMALL_WEB}/auth/login    http    yes
#    [tags]    regression    wemall_header

# TC_WMALL_01513 - Register header - Everyday Wow Logo (WeMall_version)   ${WEMALL_WEB}/users/register    http    yes
#    [tags]    regression    wemall_header

# TC_WMALL_01514 - Level D header - Everyday Wow Logo (WeMall_version)   ${WEMALL_WEB}/products/casio-enticer-mtd-1066b-1a2vdf-2155655390889.html    http    yes
#    [tags]    regression    wemall_header

# TC_WMALL_01654 - Wemall Portal page header - Everyday Wow Logo (WeMall_version)    ${WEMALL_WEB}    http
#     [tags]    regression    wemall_header

# TC_WMALL_01655 - Wemall Stronfront page header - Everyday Wow Logo (WeMall_version)    ${WEMALL_WEB}/shop/itruemart-x4    http    yes
#     [tags]    regression    wemall_header

# TC_WMALL_01672 - Forgot Password page header - Everyday Wow Logo (WeMall_version)    ${WEMALL_WEB}/forgot_password    http    yes
#     [tags]    regression    wemall_header

# *** Keywords ***
# Everyday Wow Logo
#     [Arguments]    ${full_url}    ${protocol}=http    ${header-type3}=no
#     Go to Specific URL    ${full_url}
#     Run Keyword If    '${header-type3}' == 'yes'    Mouse Over On Hamburger
#     Check Location Contain    ${full_url}    ${protocol}
#     Verify Everyday Wow Banner    ${protocol}
#     Click Everyday Wow Logo
#     Location Should Be    ${WEMALL_WEB}/everyday-wow