*** Settings ***
Resource         ${CURDIR}/../../../API/api_portals/merchantzones_keywords.robot
Library          Selenium2Library
Library          ${CURDIR}/../../../../Python_Library/ExtendedSelenium/

*** Keywords ***

### Verify Merchant Zone Web ###

Verify Draft Data Merchant Zone On Portal Page
    [Arguments]    ${module_type}    ${lang}
    Get Merchant Zones By Module Type    ${module_type}
    ${response_body}=     Get Response Body
    Verify Merchant Zone Banner    ${response_body}    ${lang}
    Verify Merchant Group Of Merchant Zone    ${response_body}    ${lang}

Verify Publish Data Merchant Zone On Portal Page
    [Arguments]    ${module_type}    ${lang}
    Get Published Merchant Zones By Module Type    ${module_type}
    ${response_body}=     Get Response Body
    Verify Merchant Zone Banner    ${response_body}    ${lang}
    Verify Merchant Group Of Merchant Zone    ${response_body}    ${lang}

Verify Merchant Zone Banner
    [Arguments]    ${res}    ${lang}
    ${data1}=    Get Json Value    ${res}    /data/${lang}/banners
    ${dict}=    Convert json to Dict    ${data1}
    :FOR  ${key}  IN  @{dict}
    \   ${items}=     Get From Dictionary     ${dict}    ${key}
    \   ${link}    Get From Dictionary     ${items}    link_url
    \   Page Should Contain Element    jquery=.banner-v a[href="${link}"]
    \   ${src}      Get From Dictionary     ${items}    src_web
    \   Page Should Contain Element    jquery=.banner-v a img[src="${src}"]


Verify Merchant Group Of Merchant Zone
    [Arguments]    ${res}    ${lang}
    ${data2}=    Get Json Value    ${res}    /data/${lang}
    ${data2}=    Convert json to Dict    ${data2}
    # ${data3}=    Get Json Value    ${data2}    /groups
    ${data3}=     Get From Dictionary     ${data2}    groups
    ${data3}=    Convert To List    ${data3}
    ${length}=    Get Length    ${data3}
    :FOR    ${index}    IN RANGE    0    ${length}
    \   ${title}=    Get From Dictionary     ${data3[${index}]}    title
    \   Page Should Contain Element    jquery=.wm-title-floor-box ul li a:contains("${title}")
    \   Verify Merchant Group Brands By Group    ${data3[${index}]}
    \   Mouse Over    jquery=.wm-title-floor-box ul li a:contains("${title}")

Verify Merchant Group Brands By Group
    [Arguments]     ${group}
    Log    ${group}
    ${brands}=     Get From Dictionary     ${group}    brands
    ${length}=    Get Length    ${brands}
    :FOR    ${index}    IN RANGE    0    ${length}
    \   ${src_web}=    Get From Dictionary     ${brands[${index}]}    src_web
    \   Page Should Contain Element    jquery=.wm-content-floor .brand-item a img[src="${src_web}"]
    \   ${link}=    Get From Dictionary     ${brands[${index}]}    link_url
    \   ${sort_index}=    Get From Dictionary     ${brands[${index}]}    sort_index
    \   ${aLink}=    Selenium2Library.Get Element Attribute    jquery=.wm-content-floor .brand-item:eq(${sort_index-1}) a@href
    \   Should Contain    ${aLink}    ${link}

### Verify Merchant Zone Mobile ###

Verify Draft Data Merchant Zone On Mobile
    [Arguments]    ${module_type}    ${lang}
    Get Merchant Zones By Module Type    ${module_type}
    ${response_body}=     Get Response Body
    Verify Merchant Zone Banner Mobile    ${response_body}    ${lang}
    Verify Merchant Group Of Merchant Zone Mobile    ${response_body}    ${lang}

Verify Publish Data Merchant Zone On Mobile
    [Arguments]    ${module_type}    ${lang}
    Get Published Merchant Zones By Module Type    ${module_type}
    ${response_body}=     Get Response Body
    Verify Merchant Zone Banner Mobile    ${response_body}    ${lang}
    Verify Merchant Group Of Merchant Zone Mobile    ${response_body}    ${lang}

Verify Merchant Zone Banner Mobile
    [Arguments]    ${res}    ${lang}
    ${json_banner}=    Get Json Value    ${res}    /data/${lang}/banners
    ${banner_dic}=    Convert json to Dict    ${json_banner}
    :FOR  ${key}  IN  @{banner_dic}
    \   ${items}=     Get From Dictionary     ${banner_dic}    ${key}
    \   ${link}    Get From Dictionary     ${items}    link_url
    \   Page Should Contain Element    jquery=div.banner-v a.banner-v[ng-href="${link}"]
    \   ${src}      Get From Dictionary     ${items}    src_mobile
    \   Page Should Contain Element    jquery=div.banner-v a.banner-v img[ng-src="${src}"]


Verify Merchant Group Of Merchant Zone Mobile
    [Arguments]    ${res}    ${lang}
    ${json_lang}=    Get Json Value    ${res}    /data/${lang}
    ${dic_lang}=    Convert json to Dict    ${json_lang}
    ${dic_group}=     Get From Dictionary     ${dic_lang}    groups
    ${dic_group}=    Convert To List    ${dic_group}
    ${length}=    Get Length    ${dic_group}
    :FOR    ${index}    IN RANGE    0    ${length}
    \   Verify Merchant Group Brands By Group Mobile    ${dic_group[${index}]}

Verify Merchant Group Brands By Group Mobile
    [Arguments]     ${group}
    Log    ${group}
    ${brands}=     Get From Dictionary     ${group}    brands
    ${length}=    Get Length    ${brands}
    :FOR    ${index}    IN RANGE    0    ${length}
    \   ${src_mobile}=    Get From Dictionary     ${brands[${index}]}    src_mobile
    \   Page Should Contain Element    jquery=.brand-container li.item.ng-scope img[ng-src="${src_mobile}"]
    \   ${link}=    Get From Dictionary     ${brands[${index}]}    link_url
    \   ${sort_index}=    Get From Dictionary     ${brands[${index}]}    sort_index
    \   ${aLink}=    Selenium2Library.Get Element Attribute    jquery=.brand-container li.item.ng-scope:eq(${sort_index-1}) a@ng-href
    \   Should Contain    ${aLink}    ${link}