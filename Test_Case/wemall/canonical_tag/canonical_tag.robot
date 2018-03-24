*** Settings ***
Suite Setup       Open Browser and Maximize Window    ${WEMALL_WEB}    ${BROWSER}
Suite Teardown    Run Keywords    Close All Browsers

Test Template     Verify Canonical Tag
Library          Selenium2Library

Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/header/keywords_wemall_header.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/seo/canonical_tag.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/common/web_common_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall-mobile/common/mobile_common_keywords.robot

*** Variables ***
&{desktop_url}
...    portal=${WEMALL_WEB}/
...    storefront=${WEMALL_WEB}/shop/canon
...    brand=${WEMALL_WEB}/brand/aiko-6158699057219.html
...    category=${WEMALL_WEB}/category/all-mobile-tablet-3193015175820.html
...    wow=${WEMALL_WEB}/everyday-wow
...    search=${WEMALL_WEB}/search2?q=iphone
...    level_d=${WEMALL_WEB}/products/aiko-ak-125gs-5549-stone-skunk-v.2-2557653043206.html
...    itm_shop=${WEMALL_WEB}/itruemart
...    contact_us=${WEMALL_WEB}/contact_us

&{mobile_url}
...    portal=${WEMALL_MOBILE}/
...    storefront=${WEMALL_MOBILE}/shop/canon
...    brand=${WEMALL_MOBILE}/brand/aiko-6158699057219.html
...    category=${WEMALL_MOBILE}/category/all-mobile-tablet-3193015175820.html
...    wow=${WEMALL_MOBILE}/everyday-wow
...    search=${WEMALL_MOBILE}/search2?q=iphone
...    level_d=${WEMALL_MOBILE}/products/aiko-ak-125gs-5549-stone-skunk-v.2-2557653043206.html
...    itm_shop=${WEMALL_MOBILE}/itruemart
...    contact_us=${WEMALL_MOBILE}/contact_us

${no_cache}    no-cache=1
${preview}     preview=678e45fa792c0a865d0eaee1b19e834d

*** Test Cases ***
### Desktop ###
TC_WMALL_01729 Desktop - Portal Page should Show Mobile Alternate Tag            ${desktop_url.portal}        ${FALSE}    ${mobile_url.portal}
    [Tags]    canonical_tag    desktop    regression

TC_WMALL_01730 Desktop - Storefront Page should Show Mobile Alternate Tag        ${desktop_url.storefront}    ${FALSE}    ${mobile_url.storefront}
    [Tags]    canonical_tag    desktop    regression

TC_WMALL_01731 Desktop - Brand Page should Show Mobile Alternate Tag             ${desktop_url.brand}         ${FALSE}    ${mobile_url.brand}
    [Tags]    canonical_tag    desktop    regression

TC_WMALL_01732 Desktop - Category Page should Show Mobile Alternate Tag          ${desktop_url.category}      ${FALSE}    ${mobile_url.category}
    [Tags]    canonical_tag    desktop    regression

TC_WMALL_01733 Desktop - Wow Page should Show Mobile Alternate Tag               ${desktop_url.wow}           ${FALSE}    ${mobile_url.wow}
    [Tags]    canonical_tag    desktop    regression

TC_WMALL_01734 Desktop - Search Page should Show Mobile Alternate Tag            ${desktop_url.search}        ${FALSE}    ${mobile_url.search}
    [Tags]    canonical_tag    desktop    regression

TC_WMALL_01735 Desktop - Level D Page should Show Mobile Alternate Tag           ${desktop_url.level_d}       ${FALSE}    ${mobile_url.level_d}
    [Tags]    canonical_tag     desktop    regression

TC_WMALL_01736 Desktop - iTruemart Shop Page should Show Mobile Alternate Tag    ${desktop_url.itm_shop}      ${FALSE}    ${mobile_url.itm_shop}
    [Tags]    canonical_tag    desktop    regression

TC_WMALL_01737 Desktop - Contact Us Page should Show Mobile Alternate Tag        ${desktop_url.contact_us}    ${FALSE}    ${mobile_url.contact_us}
    [Tags]    canonical_tag    desktop    regression

### Mobile ###
TC_WMALL_01738 Mobile - Portal Page should Show Desktop Canonical Tag            ${mobile_url.portal}         ${TRUE}     ${desktop_url.portal}portal/page1
    [Tags]    canonical_tag    mobile    regression

TC_WMALL_01739 Mobile - Storefront Page should Show Desktop Canonical Tag        ${mobile_url.storefront}     ${TRUE}     ${desktop_url.storefront}
    [Tags]    canonical_tag    mobile    regression

TC_WMALL_01740 Mobile - Brand Page should Show Desktop Canonical Tag             ${mobile_url.brand}          ${TRUE}     ${desktop_url.brand}
    [Tags]    canonical_tag    mobile    regression

TC_WMALL_01741 Mobile - Category Page should Show Desktop Canonical Tag          ${mobile_url.category}       ${TRUE}     ${desktop_url.category}
    [Tags]    canonical_tag    mobile    regression

TC_WMALL_01742 Mobile - Wow Page should Show Desktop Canonical Tag               ${mobile_url.wow}            ${TRUE}     ${desktop_url.wow}
    [Tags]    canonical_tag    mobile    regression

TC_WMALL_01743 Mobile - Search Page should Show Desktop Canonical Tag            ${mobile_url.search}         ${TRUE}     ${desktop_url.search}
    [Tags]    canonical_tag    mobile    regression

TC_WMALL_01744 Mobile - Level D Page should Show Desktop Canonical Tag           ${mobile_url.level_d}        ${TRUE}     ${desktop_url.level_d}
    [Tags]    canonical_tag    mobile    regression

TC_WMALL_01745 Mobile - iTruemart Shop Page should Show Desktop Canonical Tag    ${mobile_url.itm_shop}       ${TRUE}     ${desktop_url.itm_shop}
    [Tags]    canonical_tag    mobile    regression

TC_WMALL_01746 Mobile - Contact Us Page should Show Desktop Canonical Tag        ${mobile_url.contact_us}     ${TRUE}     ${desktop_url.contact_us}
    [Tags]    canonical_tag    mobile    regression

### Desktop No-Cache & Preview ###
TC_WMALL_01747 Desktop No Cache - Portal Page should Show Mobile Alternate Tag            ${desktop_url.portal}?${no_cache}&${preview}       ${FALSE}    ${mobile_url.portal}
    [Tags]    canonical_tag    desktop    no_cache    regression

TC_WMALL_01748 Desktop No Cache - Storefront Page should Show Mobile Alternate Tag        ${desktop_url.storefront}?${no_cache}&${preview}    ${FALSE}    ${mobile_url.storefront}
    [Tags]    canonical_tag    desktop    no_cache    regression

TC_WMALL_01749 Desktop No Cache - Wow Page should Show Mobile Alternate Tag               ${desktop_url.wow}?${no_cache}                      ${FALSE}    ${mobile_url.wow}
    [Tags]    canonical_tag    desktop    no_cache    regression

TC_WMALL_01750 Desktop No Cache - Search Page should Show Mobile Alternate Tag            ${desktop_url.search}&${no_cache}                   ${FALSE}    ${mobile_url.search}
    [Tags]    canonical_tag    desktop    no_cache    regression

TC_WMALL_01751 Desktop No Cache - iTruemart Shop Page should Show Mobile Alternate Tag    ${desktop_url.itm_shop}?${no_cache}                 ${FALSE}    ${mobile_url.itm_shop}
    [Tags]    canonical_tag    desktop    no_cache    regression

### Mobile No-Cache & Preview ###
TC_WMALL_01752 Mobile No Cache - Portal Page should Show Desktop Canonical Tag            ${mobile_url.portal}?${no_cache}&${preview}        ${TRUE}    ${desktop_url.portal}portal/page1
    [Tags]    canonical_tag    mobile    no_cache    regression

TC_WMALL_01753 Mobile No Cache - Storefront Page should Show Desktop Canonical Tag        ${mobile_url.storefront}?${no_cache}&${preview}     ${TRUE}    ${desktop_url.storefront}
    [Tags]    canonical_tag    mobile    no_cache    regression

TC_WMALL_01754 Mobile No Cache - Wow Page should Show Desktop Canonical Tag               ${mobile_url.wow}?${no_cache}                       ${TRUE}    ${desktop_url.wow}
    [Tags]    canonical_tag    mobile    no_cache    regression

*** Keywords ***
Verify Canonical Tag
    [Arguments]    ${full_url}    ${is_mobile}        ${expected_canonical}
    Run Keyword If                ${is_mobile}
    ...                           Go To Wemall Mobile URL      ${full_url}
    ...    ELSE                   Go To Wemall Desktop URL     ${full_url}
    Run Keyword If                ${is_mobile}
    ...                           Canonical Tag Should Be            ${expected_canonical}
    ...    ELSE                   One of Alternate Tags Should Be    ${expected_canonical}
