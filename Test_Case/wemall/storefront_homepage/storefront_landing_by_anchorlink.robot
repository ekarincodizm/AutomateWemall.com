*** Settings ***
Force Tags    WLS_Wemall_storefront_homepage
Suite Setup       Open Browser and Maximize Window    ${WEMALL_WEB}    ${BROWSER}
Suite Teardown    Run Keywords    Close All Browsers

Test Template     Verify Landing Page Storefront By Slug

Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/common/web_common_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall-mobile/common/mobile_common_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/header/keywords_wemall_header.robot

*** Variables ***

&{mobile_url}
...    storefront_th=${WEMALL_MOBILE}/shop/canon
...    storefront_en=${WEMALL_MOBILE}/en/shop/canon

${anchor_link}      ${EMPTY}#demo
${expected_logo}    http://cdn.wemall-dev.com/th/logo_mobile/5fbe304f-79e3-490f-b684-33cd7a052d9a_images/logo-130x130.jpg?v=c2aceaeb?2016-04-21%2010:01:29
${username}         robot05@mail.com
${password}         123456



*** Test Cases ***

### Mobile Guest ###
TC_WMALL_01755 Mobile - Landing Page Storefront TH    ${mobile_url.storefront_th}    ${FALSE}
    [Tags]    canonical_tag    mobile    regression    TC_WMALL_01755

TC_WMALL_01756 Mobile - Landing Page Storefront EN    ${mobile_url.storefront_en}    ${FALSE}
    [Tags]    canonical_tag    mobile    regression    TC_WMALL_01756

TC_WMALL_01757 Mobile - Landing Page Storefront TH By Anchor Link    ${mobile_url.storefront_th}${anchor_link}    ${FALSE}
    [Tags]    canonical_tag    mobile    regression    TC_WMALL_01757

TC_WMALL_01758 Mobile - Landing Page Storefront EN By Anchor Link    ${mobile_url.storefront_en}${anchor_link}    ${FALSE}
    [Tags]    canonical_tag    mobile    regression    TC_WMALL_01758

TC_WMALL_01759 Mobile - Landing Page Storefront TH By Wrong Anchor Link    ${mobile_url.storefront_th}#ABC    ${FALSE}
    [Tags]    canonical_tag    mobile    regression    TC_WMALL_01759

TC_WMALL_01760 Mobile - Landing Page Storefront EN By Wrong Anchor Link    ${mobile_url.storefront_en}#ABC    ${FALSE}
    [Tags]    canonical_tag    mobile    regression    TC_WMALL_01760

# ### Mobile Member ###
# TC_WMALL_XXXXX - Mobile - Member Landing Page Storefront TH    ${mobile_url.storefront_th}    ${TRUE}
#     [Tags]    canonical_tag    mobile    regression    TC_WMALL_XXX

# TC_WMALL_XXXXX - Mobile - Member Landing Page Storefront EN    ${mobile_url.storefront_en}    ${TRUE}
#     [Tags]    canonical_tag    mobile    regression    TC_WMALL_01738

# TC_WMALL_XXXXX - Mobile - Member Landing Page Storefront TH By Anchor Link    ${mobile_url.storefront_th}${anchor_link}    ${TRUE}
#     [Tags]    canonical_tag    mobile    regression    TC_WMALL_01738

# TC_WMALL_XXXXX - Mobile - Member Landing Page Storefront EN By Anchor Link    ${mobile_url.storefront_en}${anchor_link}    ${TRUE}
#     [Tags]    canonical_tag    mobile    regression    TC_WMALL_01738

# TC_WMALL_XXXXX - Mobile - Member Landing Page Storefront TH By Wrong Anchor Link    ${mobile_url.storefront_th}#ABC    ${TRUE}
#     [Tags]    canonical_tag    mobile    regression    TC_WMALL_01738

# TC_WMALL_XXXXX - Mobile - Member Landing Page Storefront EN By Wrong Anchor Link    ${mobile_url.storefront_en}#ABC    ${TRUE}
#     [Tags]    canonical_tag    mobile    regression    TC_WMALL_01738

*** Keywords ***
Verify Landing Page Storefront By Slug
    [Arguments]    ${full_url}    ${is_member}
    # Run Keyword If                ${is_member}
    # ...                           Run Keywords    Go To Storefront and Login User Wemall    ${full_url}    ${username}    ${password}    AND    Go To Wemall Mobile URL      ${full_url}
    # ...    ELSE                   Go To Wemall Mobile URL      ${full_url}
    Go To Wemall Mobile URL      ${full_url}
    Verify Logo Storefront Mobile

Verify Logo Storefront Mobile
    ${logo_shop}=    Get Element Attribute    jquery=.storefront-logo.ng-binding img @src
    Should Be Equal As Strings    ${logo_shop}    ${expected_logo}

Go To Storefront and Login User Wemall
    [Arguments]     ${full_url}     ${username}    ${password}
    Go To Wemall Desktop URL     ${full_url}
    Login User to WeMall    ${username}    ${password}

