*** Settings ***
Library          ${CURDIR}/../../../../Python_Library/jsonLibrary.py
Resource         ${CURDIR}/../../../../Keyword/API/common/api_keywords.robot
Resource         ${CURDIR}/../../../../Keyword/Portal/wemall/wemall_portal/webelement_portal_page.robot
Library          ${CURDIR}/../../../../Python_Library/common.py
Library          OperatingSystem
Library          Collections
Library          HttpLibrary.HTTP
Resource         ${CURDIR}/../../../API/api_portals/showrooms_keywords.robot
Library          Selenium2Library
Library          ${CURDIR}/../../../../Python_Library/ExtendedSelenium/

*** Variables ***
${DRAFT}                draft
${PUBLISHED}            published
${module_key}           portal
${megamenu_moblie}      jquery=h3.lb-section-title.ng-binding.ng-scope

*** Keywords ***
Verify Showroom
    [Arguments]    ${module_key}    ${showroom_id}    ${version}    ${lang}
    Verify Showroom Data    ${module_key}    ${showroom_id}    ${version}    ${lang}
    Verify Showroom Textlink Data    ${showroom_id}    ${version}    ${lang}
    Verify Showroom Brand Data    ${showroom_id}    ${version}    ${lang}

Verify Showroom Brand Data
    [Arguments]    ${showroom_id}    ${version}    ${lang}
    GET Showroom Brand Data    ${showroom_id}    ${version}
    ${body}=            Get Response Body
    ${raw_data_dict}=    Convert json to Dict    ${body}
    ${raw_data_dict}=    Get From Dictionary     ${raw_data_dict}    data
    ${brands}=    Get From Dictionary     ${raw_data_dict}    ${lang}
    ${length}=    Get Length    ${brands}
    :FOR    ${index}    IN RANGE    0    ${length}
    \    ${expSortIndex}=    Get From Dictionary    ${brands[${index}]}    sort_index
    \    ${expTitle}=    Get From Dictionary    ${brands[${index}]}    title
    \    ${expSrcWeb}=    Get From Dictionary    ${brands[${index}]}    src_web
    \    ${expLinkUrl}=    Get From Dictionary    ${brands[${index}]}    link_url
    \    ${expLinkTarget}=    Get From Dictionary    ${brands[${index}]}    link_target
    \    ${acLinkUrl}=    Selenium2Library.Get Element Attribute    jquery=#floor-${showroom_id} .owl-stage .owl-item:not(.cloned):eq(${expSortIndex/4}) a:eq(${expSortIndex%4})@href
    \    ${acLinkTarget}=    Selenium2Library.Get Element Attribute    jquery=#floor-${showroom_id} .owl-stage .owl-item:not(.cloned):eq(${expSortIndex/4}) a:eq(${expSortIndex%4})@target
    \    ${acSrcWeb}=    Selenium2Library.Get Element Attribute    jquery=#floor-${showroom_id} .owl-stage .owl-item:not(.cloned):eq(${expSortIndex/4}) a:eq(${expSortIndex%4}) img@src
    \    ${acTitle}=    Selenium2Library.Get Element Attribute    jquery=#floor-${showroom_id} .owl-stage .owl-item:not(.cloned):eq(${expSortIndex/4}) a:eq(${expSortIndex%4}) img@alt
    \    Should Contain    ${acLinkUrl}    ${expLinkUrl}
    \    Should Be Equal    ${acLinkTarget}    ${expLinkTarget}
    \    Should Contain    ${acSrcWeb}    ${expSrcWeb}
    \    Should Be Equal    ${acTitle}    ${expTitle}

Verify Showroom Textlink Data
    [Arguments]    ${showroom_id}    ${version}    ${lang}
    GET Showroom Textlink Data    ${showroom_id}    ${version}
    ${body}=            Get Response Body
    ${raw_data_dict}=    Convert json to Dict    ${body}
    ${raw_data_dict}=    Get From Dictionary     ${raw_data_dict}    data
    ${textlinks}=    Get From Dictionary     ${raw_data_dict}    ${lang}
    ${length}=    Get Length    ${textlinks}
    :FOR    ${index}    IN RANGE    0    ${length}
    \    ${expSortIndex}=    Get From Dictionary    ${textlinks[${index}]}    sort_index
    \    ${expText}=    Get From Dictionary    ${textlinks[${index}]}    text
    \    ${expLinkUrl}=    Get From Dictionary    ${textlinks[${index}]}    link_url
    \    ${expLinkTarget}=    Get From Dictionary    ${textlinks[${index}]}    link_target
    \    ${acLinkUrl}=    Selenium2Library.Get Element Attribute    jquery=#floor-${showroom_id} ul.menu-floor li:eq(${expSortIndex-1}) a@href
    \    ${acLinkTarget}=    Selenium2Library.Get Element Attribute    jquery=#floor-${showroom_id} ul.menu-floor li:eq(${expSortIndex-1}) a@target
    \    Selenium2Library.Element Text Should Be    jquery=#floor-${showroom_id} ul.menu-floor li:eq(${expSortIndex-1})    ${expText}
    \    Should Contain    ${acLinkUrl}    ${expLinkUrl}
    \    Should Be Equal    ${acLinkTarget}    ${expLinkTarget}

Verify Showroom Data
    [Arguments]    ${module_key}    ${showroom_id}    ${version}    ${lang}
    GET Showroom Data    ${module_key}    ${version}
    ${body}=            Get Response Body
    ${raw_data_dict}=    Convert json to Dict    ${body}
    ${raw_data_dict}=    Get From Dictionary     ${raw_data_dict}    data
    ${lang_data_dict}=    Get From Dictionary     ${raw_data_dict}    ${lang}
    ${showroom_data}=    Get From Dictionary     ${lang_data_dict}    ${showroom_id}
    ${awesome_font}=    Get From Dictionary     ${showroom_data}    awesome_font
    ${color_rgb}=    Get From Dictionary     ${showroom_data}    color_rgb
    ${title}=    Get From Dictionary     ${showroom_data}    title
    ${link_url}=    Get From Dictionary     ${showroom_data}    link_url

    #Check Icon
    Element Should Be Visible    jquery=#floor-${showroom_id} span.${awesome_font}
    #check title
    Selenium2Library.Element Text Should Be    jquery=#floor-${showroom_id} span.title-floor    ${title}
    #check bgcolor
    ${style}=    Selenium2Library.Get Element Attribute    jquery=#floor-${showroom_id} .wm-title-floor-box@style
    #check link
    ${aclinkUrl}=    Selenium2Library.Get Element Attribute    jquery=#floor-${showroom_id} .wm-title-floor-box a@href
    Should Be Equal    ${aclinkUrl}    ${aclinkUrl}

    #Check Banners
    ${banners}=    Get From Dictionary    ${showroom_data}    banners
    ${bannerKeys}=    Get Dictionary Keys    ${banners}
    ${bTitleList}=    Create List
    ${bSrcWebList}=    Create List
    ${bLinkTargetList}=    Create List
    ${bLinkUrlList}=    Create List
    ${length}=    Get Length    ${bannerKeys}
    :FOR    ${index}    IN RANGE    0    ${length}
    \    ${banner}=    Get From Dictionary    ${banners}    ${bannerKeys[${index}]}
    \    ${bTitle}=    Get From Dictionary    ${banner}    title
    \    ${bSrcWeb}=    Get From Dictionary    ${banner}    src_web
    \    ${bLinkTarget}=    Get From Dictionary    ${banner}    link_target
    \    ${bLinkUrl}=    Get From Dictionary    ${banner}    link_url
    \    Append To List    ${bTitleList}    ${bTitle}
    \    Append To List    ${bSrcWebList}    ${bSrcWeb}
    \    Append To List    ${bLinkTargetList}    ${bLinkTarget}
    \    Append To List    ${bLinkUrlList}    ${bLinkUrl}

    ${aBanner}=    Get Webelements    jquery=#floor-${showroom_id} .wm-showroom .banner
    ${aTitleList}=    Create List
    ${aSrcWebList}=    Create List
    ${aLinkTargetList}=    Create List
    ${aLinkUrlList}=    Create List
    ${length}=    Get Length    ${aBanner}
    :FOR    ${index}    IN RANGE    0    ${length}
    \    ${aTitle}=    Selenium2Library.Get Element Attribute    jquery=#floor-${showroom_id} .wm-showroom .banner:eq(${index}) img@alt
    \    ${aSrcWeb}=    Selenium2Library.Get Element Attribute    jquery=#floor-${showroom_id} .wm-showroom .banner:eq(${index}) img@src
    \    ${aLinkTarget}=    Selenium2Library.Get Element Attribute    jquery=#floor-${showroom_id} .wm-showroom .banner:eq(${index}) a@target
    \    ${aLinkUrl}=    Selenium2Library.Get Element Attribute    jquery=#floor-${showroom_id} .wm-showroom .banner:eq(${index}) a@href
    \    Should Be Equal    ${aTitle}    ${bTitleList[${index}]}
    \    Should Contain    ${aSrcWeb}    ${bSrcWebList[${index}]}
    \    Should Be Equal    ${aLinkTarget}    ${bLinkTargetList[${index}]}
    \    Should Contain    ${aLinkUrl}    ${bLinkUrlList[${index}]}

Verify Showroom Mobile
    [Arguments]    ${module_key}    ${showroom_id}    ${version}    ${lang}
    Verify Showroom Data Mobile    ${module_key}    ${showroom_id}    ${version}    ${lang}
    Verify Showroom Brand Data mobile    ${showroom_id}    ${version}    ${lang}

Verify Showroom Data Mobile
    [Arguments]    ${module_key}    ${showroom_id}    ${version}    ${lang}
    GET Showroom Data    ${module_key}    ${version}
    ${body}=            Get Response Body
    ${raw_data_dict}=    Convert json to Dict    ${body}
    ${raw_data_dict}=    Get From Dictionary     ${raw_data_dict}    data
    ${lang_data_dict}=    Get From Dictionary     ${raw_data_dict}    ${lang}
    ${showroom_data}=    Get From Dictionary     ${lang_data_dict}    ${showroom_id}
    ${awesome_font}=    Get From Dictionary     ${showroom_data}    awesome_font
    ${color_rgb}=    Get From Dictionary     ${showroom_data}    color_rgb
    ${title}=    Get From Dictionary     ${showroom_data}    title
    ${link_url}=    Get From Dictionary     ${showroom_data}    link_url
    ${sort_index}=    Get From Dictionary     ${showroom_data}    sort_index

    #Check Icon
    Element Should Be Visible    jquery=div.wm-floor-box>div:eq(${sort_index-1}) span.${awesome_font}
    #check title
    Selenium2Library.Element Text Should Be    jquery=div.wm-floor-box>div:eq(${sort_index-1}) span.title-text    ${title}
    #check link
    ${aclinkUrl}=    Selenium2Library.Get Element Attribute    jquery=div.wm-floor-box>div:eq(${sort_index-1}) a.tab-top@href
    Should Be Equal    ${aclinkUrl}    ${aclinkUrl}

    ${banners}=    Get From Dictionary    ${showroom_data}    banners
    #banner-big
    ${banner}=     Get From Dictionary    ${banners}    1
    ${BLinkUrl}=    Selenium2Library.Get Element Attribute    jquery=div.wm-floor-box>div:eq(${sort_index-1}) .banner-big a@href
    ${BSrcWeb}=    Selenium2Library.Get Element Attribute    jquery=div.wm-floor-box>div:eq(${sort_index-1}) .banner-big img@src
    ${expLinkUrl}=    Get From Dictionary     ${banner}    link_url
    ${expSrcWeb}=    Get From Dictionary     ${banner}    src_mobile
    Should Contain    ${BSrcWeb}    ${expSrcWeb}
    Should Contain    ${BLinkUrl}    ${expLinkUrl}

    #banner-v
    ${banner}=     Get From Dictionary    ${banners}    7
    ${BLinkUrl}=    Selenium2Library.Get Element Attribute    jquery=div.wm-floor-box>div:eq(${sort_index-1}) .showroom .banner-v a@href
    ${BSrcWeb}=    Selenium2Library.Get Element Attribute    jquery=div.wm-floor-box>div:eq(${sort_index-1}) .showroom .banner-v img@src
    ${expLinkUrl}=    Get From Dictionary     ${banner}    link_url
    ${expSrcWeb}=    Get From Dictionary     ${banner}    src_mobile
    Should Contain    ${BSrcWeb}    ${expSrcWeb}
    Should Contain    ${BLinkUrl}    ${expLinkUrl}

    #mini-showroom
    :FOR    ${index}    IN RANGE    0    2
    \    ${key}=    Convert To String    ${index+2}
    \    ${banner}=     Get From Dictionary    ${banners}    ${key}
    \    ${BLinkUrl}=    Selenium2Library.Get Element Attribute    jquery=div.wm-floor-box>div:eq(${sort_index-1}) .showroom .mini-showroom .item:eq(${index}) a@href
    \    ${BSrcWeb}=    Selenium2Library.Get Element Attribute    jquery=div.wm-floor-box>div:eq(${sort_index-1}) .showroom .mini-showroom .item:eq(${index}) img@src
    \    ${expLinkUrl}=    Get From Dictionary     ${banner}    link_url
    \    ${expSrcWeb}=    Get From Dictionary     ${banner}    src_mobile
    \    Should Contain    ${BSrcWeb}    ${expSrcWeb}
    \    Should Contain    ${BLinkUrl}    ${expLinkUrl}

Verify Showroom Brand Data Mobile
    [Arguments]    ${showroom_id}    ${version}    ${lang}
    GET Showroom Data    ${module_key}    ${version}
    ${body}=            Get Response Body
    ${raw_data_dict}=    Convert json to Dict    ${body}
    ${raw_data_dict}=    Get From Dictionary     ${raw_data_dict}    data
    ${lang_data_dict}=    Get From Dictionary     ${raw_data_dict}    ${lang}
    ${showroom_data}=    Get From Dictionary     ${lang_data_dict}    ${showroom_id}
    ${sort_index}=    Get From Dictionary     ${showroom_data}    sort_index

    GET Showroom Brand Data    ${showroom_id}    ${version}
    ${body}=            Get Response Body
    ${raw_data_dict}=    Convert json to Dict    ${body}
    ${raw_data_dict}=    Get From Dictionary     ${raw_data_dict}    data
    ${brands}=    Get From Dictionary     ${raw_data_dict}    ${lang}
    ${length}=    Get Length    ${brands}
    :FOR    ${index}    IN RANGE    0    ${length}
    \    ${expSortIndex}=    Get From Dictionary    ${brands[${index}]}    sort_index
    \    ${expSrcWeb}=    Get From Dictionary    ${brands[${index}]}    src_web
    \    ${expLinkUrl}=    Get From Dictionary    ${brands[${index}]}    link_url
    \    ${acSrcWeb}=    Selenium2Library.Get Element Attribute    jquery=div.wm-floor-box>div:eq(${sort_index-1}) .brand-list .item:eq(${expSortIndex}) img@src
    \    ${acLinkUrl}=    Selenium2Library.Get Element Attribute    jquery=div.wm-floor-box>div:eq(${sort_index-1}) .brand-list .item:eq(${expSortIndex}) a@href
    \    Should Contain    ${acSrcWeb}    ${expSrcWeb}
    \    Should Contain    ${acLinkUrl}    ${expLinkUrl}
