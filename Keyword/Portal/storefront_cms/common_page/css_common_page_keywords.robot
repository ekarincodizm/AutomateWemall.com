*** Settings ***
Resource            ${CURDIR}/../../wemall/common/web_common_keywords.robot
Resource            ${CURDIR}/webelement_common.robot
Resource            ${CURDIR}/../shop_management_page/webelement_shop_management_page.robot
Library             String
Library             Selenium2Library
Library             ${CURDIR}/../../../../Python_Library/ExtendedSelenium/
Library             ${CURDIR}/../../../../Python_Library/common.py

*** Keywords ***
Open Browser and Go to Web Storefront
    [Arguments]     ${shop_slug}
    Open Browser    ${WEMALL_WEB}/shop/${shop_slug}    Chrome

Go to Storefront Window Path
    [Arguments]     ${shop_slug}
    Go To    ${WEMALL_WEB}/shop/${shop_slug}

Go to Storefront Window Path En
    [Arguments]     ${shop_slug}
    Go To    ${WEMALL_WEB}/en/shop/${shop_slug}

Back to Merchant List Page
    Wait Until Element Is Visible    ${link_shop_list_page}    2s
    Click Element and Wait Angular Ready    ${link_shop_list_page}

Back to Shop List Page
    Wait Until Element Is Visible    ${link_shop_list_page}    2s
    Click Element and Wait Angular Ready    ${link_shop_list_page}

Back to Storefront Management Page
    Wait Until Element Is Visible    ${link_storefront_management_page}    2s
    Click Element and Wait Angular Ready    ${link_storefront_management_page}

Verify Window Preview Storefront Mobile TH Contains
    [Arguments]     ${shop_slug}    ${jquerySelector}    ${innerHtml}
    Select Window    url=${WEMALL_WEB}/shop/${shop_slug}?${PRIVIEW_TOKEN}&${MOBILE_TOKEN}
    Wait Until Angular Ready    60s
    Page Should Contain Element    jquery=${jquerySelector} img[src="${innerHtml}"]

Verify Window Preview Storefront Web TH Contains
    [Arguments]     ${shop_slug}    ${jquerySelector}    ${innerHtml}
    Select Window    url=${WEMALL_WEB}/shop/${shop_slug}?${PRIVIEW_TOKEN}
    Wait Until Angular Ready    60s
    Page Should Contain Element    jquery=${jquerySelector} img[src="${innerHtml}"]

Verify Window Storefront Mobile TH Contains
    [Arguments]     ${shop_slug}    ${jquerySelector}    ${innerHtml}
    Select Window    url=${WEMALL_WEB}/shop/${shop_slug}
    Wait Until Angular Ready    60s
    Page Should Contain Element    jquery=${jquerySelector} img[src="${innerHtml}"]

Verify Window Storefront Web TH Contains
    [Arguments]     ${shop_slug}    ${jquerySelector}    ${innerHtml}
    Select Window    url=${WEMALL_WEB}/shop/${shop_slug}
    Wait Until Angular Ready    60s
    Page Should Contain Element    jquery=${jquerySelector} img[src="${innerHtml}"]

Verify Window Preview Storefront Mobile EN Contains
    [Arguments]     ${shop_slug}    ${jquerySelector}    ${innerHtml}
    Select Window    url=${WEMALL_WEB}${SECONDARY_PATH}/shop/${shop_slug}?${PRIVIEW_TOKEN}&${MOBILE_TOKEN}
    Wait Until Angular Ready    60s
    Page Should Contain Element    jquery=${jquerySelector} img[src="${innerHtml}"]

Verify Window Preview Storefront Web EN Contains
    [Arguments]     ${shop_slug}    ${jquerySelector}    ${innerHtml}
    Select Window    url=${WEMALL_WEB}${SECONDARY_PATH}/shop/${shop_slug}?${PRIVIEW_TOKEN}
    Wait Until Angular Ready    60s
    Page Should Contain Element    jquery=${jquerySelector} img[src="${innerHtml}"]

Verify Window Storefront Mobile EN Contains
    [Arguments]     ${shop_slug}    ${jquerySelector}    ${innerHtml}
    # Select Window    url=${WEMALL_WEB}${SECONDARY_PATH}/shop/${shop_slug}?${PRIVIEW_TOKEN}&${MOBILE_TOKEN}
    Select Window    url=${WEMALL_WEB}${SECONDARY_PATH}/shop/${shop_slug}
    Wait Until Angular Ready    60s
    Page Should Contain Element    jquery=${jquerySelector} img[src="${innerHtml}"]

Verify Window Storefront Web EN Contains
    [Arguments]     ${shop_slug}    ${jquerySelector}    ${innerHtml}
    Select Window    url=${WEMALL_WEB}${SECONDARY_PATH}/shop/${shop_slug}
    Wait Until Angular Ready    60s
    Page Should Contain Element    jquery=${jquerySelector} img[src="${innerHtml}"]

Should Contains Element in Storefront Page
    [Arguments]     ${storefront_url}    ${locator}
    Select Window    url=${storefront_url}
    Wait Until Angular Ready    60s
    Page Should Contain Element    ${locator}

Verify Window Preview Storefront Web TH Alignment Center
   [Arguments]     ${shop_slug}
    Select Window    url=${WEMALL_WEB}/shop/${shop_slug}?${PRIVIEW_TOKEN}
    Wait Until Angular Ready    60s
    Sleep    5s
    ${tableLayout}=    Get Webelement    jquery=.store-front-main-content > table
    ${expectedWidth}=    set variable    ${tableLayout.get_attribute('width')}
    ${calculateLeft}=    Convert To Number     ${expectedWidth}
    Wait Until Page Contains Element    jquery=.store-front-main-content > table[style*="height: 0px; margin-left: -${calculateLeft/2}px; left: 50%;"]    10
    Locator Should Match X Times    jquery=.store-front-main-content > table[style*="height: 0px; margin-left: -${calculateLeft/2}px; left: 50%;"]    1

Verify Window Preview Storefront Web EN Alignment Center
   [Arguments]     ${shop_slug}
    Select Window    url=${WEMALL_WEB}${SECONDARY_PATH}/shop/${shop_slug}?${PRIVIEW_TOKEN}
    Wait Until Angular Ready    60s
    Sleep    5s
    ${tableLayout}=    Get Webelement    jquery=.store-front-main-content > table
    ${expectedWidth}=    set variable    ${tableLayout.get_attribute('width')}
    ${calculateLeft}=    Convert To Number     ${expectedWidth}
    Wait Until Page Contains Element    jquery=.store-front-main-content > table[style*="height: 0px; margin-left: -${calculateLeft/2}px; left: 50%;"]    10
    Locator Should Match X Times    jquery=.store-front-main-content > table[style*="height: 0px; margin-left: -${calculateLeft/2}px; left: 50%;"]    1

Verify Window Preview Storefront Web TH Contains CSS
    [Arguments]     ${shop_slug}    ${shop_id}    ${site}    ${module}    ${match_count}
    Select Window    url=${WEMALL_WEB}/shop/${shop_slug}?${PRIVIEW_TOKEN}
    Wait Until Angular Ready    60s
    Wait Until Page Contains Element    jquery=link[href*='${module}/${shop_id}_${site}_css/${shop_id}.css']    5s
    Locator Should Match X Times    jquery=link[href*='${module}/${shop_id}_${site}_css/${shop_id}.css']    ${match_count}

Verify Window Preview Storefront Web EN Contains CSS
    [Arguments]     ${shop_slug}    ${shop_id}    ${site}    ${module}    ${match_count}
    Select Window    url=${WEMALL_WEB}${SECONDARY_PATH}/shop/${shop_slug}?${PRIVIEW_TOKEN}
    Wait Until Angular Ready    60s
    Wait Until Page Contains Element    jquery=link[href*='${module}/${shop_id}_${site}_css/${shop_id}.css']    5s
    Locator Should Match X Times    jquery=link[href*='${module}/${shop_id}_${site}_css/${shop_id}.css']    ${match_count}

Verify Window Preview Storefront Mobile TH Contains CSS
    [Arguments]     ${shop_slug}    ${shop_id}    ${site}    ${module}
    Select Window    url=${WEMALL_WEB}/shop/${shop_slug}?${PRIVIEW_TOKEN}&${MOBILE_TOKEN}
    Wait Until Angular Ready    60s
    Wait Until Page Contains Element    jquery=link[href*='${module}/${shop_id}_${site}_css/${shop_id}.css']    5s

Verify Window Preview Storefront Mobile EN Contains CSS
    [Arguments]     ${shop_slug}    ${shop_id}    ${site}    ${module}
    Select Window    url=${WEMALL_WEB}${SECONDARY_PATH}/shop/${shop_slug}?${PRIVIEW_TOKEN}&${MOBILE_TOKEN}
    Wait Until Angular Ready    60s
    Wait Until Page Contains Element    jquery=link[href*='${module}/${shop_id}_${site}_css/${shop_id}.css']    5s

Upload CSS
    [Arguments]    ${cssPath}
    ${canonicalPath}=    Get Canonical Path    ${cssPath}
    Choose File    ${INPUT_FILE_CSS}    ${canonicalPath}
    Log    ${INPUT_FILE_CSS}
#    Choose File    //div[@ng-model='fileUpload']    ${canonicalPath}
#    Wait Until Element Is Visible    ${FILE_CSS_UPLOADING}
#    Wait Until Element Is Not Visible    ${FILE_CSS_UPLOADING}    60s
    Sleep    5s
#    Wait Until Element Is Visible    ${FILE_LIST_CSS}    60s

Verify CSS Is Uploaded
    [Arguments]    ${shop_id}    ${module}
    Wait Until Element Is Visible    ${FILE_LIST_CSS}    60s
    ${actualCssUrl}=    Get Text    ${FILE_LIST_CSS}
    Should Contain    ${actualCssUrl}    /${shop_id}_${module}_css/${shop_id}.css


