*** Settings ***
Force Tags    WLS_Manage_Shop
Suite Setup       Prepare Footer And Open Browser
Suite Teardown    Run Keywords    Prepare New Footer And Close All Browser
# Test Template     Clear Cache Page Footer
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/portal_page/portal_page_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/footer/keywords_wemall_footer.robot
Resource          ${CURDIR}/../../../Keyword/API/api_storefronts/storefront_keywords.robot


*** Variables ***
${WEMALL_WEB2}     http://resource.wemall-dev.com
${temp_footer_draft_json}       ${CURDIR}/../../../Resource/TestData/portals/footer/temp_footer_draft.json
${temp_footer_publish_json}     ${CURDIR}/../../../Resource/TestData/portals/footer/temp_footer_publish.json


*** Test Cases ***
# TC_WMALL_01719 ITM page clear cache footer (WeMall_version)                    ${WEMALL_WEB}/itruemart/     ${platform_web}     ${language_th}      ${version_published}
#     [Tags]    regression    wemall_footer

# TC_WMALL_01719 Portal page clear cache footer (WeMall_version)                 ${WEMALL_RESOURCE}/     ${platform_web}     ${language_th}      ${version_published}
#     [Tags]    regression    wemall_footer

# ### English Version ####
# TC_WMALL_01719 Portal resource page clear cache footer (WeMall_English version)              ${WEMALL_RESOURCE}/en/    ${platform_web}     ${language_en}      ${version_published}
#     [Tags]    regression    wemall_footer

# TC_WMALL_01719 Portal page clear cache footer (WeMall English_version)           ${WEMALL_WEB}/en/      ${platform_web}     ${language_en}      ${version_published}
#     [Tags]    regression    wemall_footer

# TC_WMALL_01719 ITM page clear cache footer (WeMall_English version)              ${WEMALL_WEB}/en/itruemart     ${platform_web}     ${language_en}      ${version_published}
#     [Tags]    regression    wemall_footer

TC_WMALL_01719
    [Documentation]    ITM page clear cache footer
    [Tags]    regression    wemall_footer    WLS_Medium
    Clear Cache Page Footer    ${WEMALL_WEB}/itruemart/     ${platform_web}     ${language_th}      ${version_published}
    Clear Cache Page Footer    ${WEMALL_RESOURCE}/     ${platform_web}     ${language_th}      ${version_published}
    Clear Cache Page Footer    ${WEMALL_RESOURCE}/en/    ${platform_web}     ${language_en}      ${version_published}
    Clear Cache Page Footer    ${WEMALL_WEB}/en/      ${platform_web}     ${language_en}      ${version_published}
    Clear Cache Page Footer    ${WEMALL_WEB}/en/itruemart     ${platform_web}     ${language_en}      ${version_published}

*** Keywords ***
Clear Cache Page Footer
    [Arguments]    ${full_url}    ${platform}     ${language}     ${version}      ${protocol}=http
    Verify Footer Page    ${full_url}
    Verify Link On Footer Page With Api data     ${platform}     ${language}     ${version}
    Prepare Footer Data By Called API       ${temp_footer_draft_json}
    Prepare Footer Data By Called API       ${temp_footer_publish_json}
    Verify Footer Page    ${full_url}?preview=678e45fa792c0a865d0eaee1b19e834d
    Verify Link On Footer Page With Api data     ${platform}     ${language}     draft
    Verify Footer Page    ${full_url}
    Sleep                 2s
    Verify Link On Footer Page With Api data     ${platform}     ${language}     ${version}


Prepare Footer And Open Browser
    Comment    We need to prepare a draft version before publish version because the API will copy from a draft to a publish version
    Prepare Footer Data By Called API       ${json_footer_draft}
    Prepare Footer Data By Called API       ${json_footer_publish}
    Open Browser and Go to Specific URL     ${ITM_URL}

Prepare New Footer And Close All Browser
    Prepare Footer Data By Called API       ${json_footer_draft2}
    Prepare Footer Data By Called API       ${json_footer_publish2}
    Close All Browsers