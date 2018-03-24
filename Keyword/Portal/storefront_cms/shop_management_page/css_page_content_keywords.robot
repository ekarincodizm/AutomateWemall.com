*** Settings ***
Library             Selenium2Library
Library             ${CURDIR}/../../../../Python_Library/ExtendedSelenium/
Resource            ${CURDIR}/../../wemall/common/web_common_keywords.robot
Resource            ${CURDIR}/../../../API/common/api_keywords.robot
Resource            ${CURDIR}/../../../API/api_storefronts/storefront_keywords.robot
Resource            ${CURDIR}/../../../API/api_storefronts/api_shops_keywords.robot
Resource            ${CURDIR}/../shop_list_page/webelement_shop_list_page.robot
Resource            ${CURDIR}/webelement_shop_management_page.robot
Resource            ${CURDIR}/css_pages_list_table_keywords.robot
Library             ${CURDIR}/../../../API/api_storefronts/storefront.py

*** Variables ***
${contentLinkText}              Content

*** Keywords ***
Storefront CMS Page Content - Verify Page Content
    [Arguments]         ${site_view}     ${version}      ${page_id}          ${content}
    ${content_response}=    Get Storefront      ${STOREFRONT-API}    ${page_id}    ${site_view}    ${version}       content     mode=raw    getData=True
    ${data}=        Get From Dictionary     ${content_response}     data
    ${data}=        Get From Dictionary     ${data}     content
    ${data}=        Get From Dictionary     ${data}     data
    ${data}=        Get From Dictionary     ${data}     name
    ${data}=        Get From Dictionary     ${data}     content
    Should Contain       ${data}        ${content}

Storefront CMS Page Content - Verify Page Content EN
    [Arguments]         ${site_view}     ${version}      ${page_id}          ${content}
    ${content_response}=    Get Storefront      ${STOREFRONT-API}    ${page_id}    ${site_view}    ${version}       content     mode=raw    getData=True
    ${data}=        Get From Dictionary     ${content_response}     data
    ${data}=        Get From Dictionary     ${data}     content
    ${data}=        Get From Dictionary     ${data}     data
    ${data}=        Get From Dictionary     ${data}     name_translation
    ${data}=        Get From Dictionary     ${data}     content
    Should Contain       ${data}        ${content}



    
