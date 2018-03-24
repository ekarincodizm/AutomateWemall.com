*** Settings ***
Library             String
Library             Selenium2Library
Library             OperatingSystem
Library             HttpLibrary.HTTP
Library             XML
Library             Collections
Resource            ${CURDIR}/webelement_wemall_footer.robot
Resource            ${CURDIR}/../keywords_common_for_wemall.robot
Resource            ${CURDIR}/../../../API/api_portals/staticcontents_keywords.robot

*** Variables ***
${portal-footer}            portal-footer
${version_draft}            draft
${version_published}        published
${platform_web}             web
${platform_mobile}          mobile
${language_th}              th_TH
${language_en}              en_US
${access_status_success}        success
${access_status_fail}           fail
${json_footer_draft}            ${CURDIR}/../../../../Resource/TestData/portals/footer/prepare_footer_draft.json
${json_footer_publish}          ${CURDIR}/../../../../Resource/TestData/portals/footer/prepare_footer_publish.json
${json_footer_draft2}            ${CURDIR}/../../../../Resource/TestData/portals/footer/prepare_footer_draft2.json
${json_footer_publish2}          ${CURDIR}/../../../../Resource/TestData/portals/footer/prepare_footer_publish2.json

*** Keywords ***
Verify Footer Page
    [Arguments]    ${full_url}
    Go to    ${full_url}
    Wait Until Element Is Visible    ${iwm_footer_id}

Prepare Footer Data By Called API
    [Arguments]    ${json_data_file}
    ${request_body}=    Get File    ${json_data_file}
    Log     ${request_body}
    Update Static Content By Json Data      ${portal-footer}    ${request_body}

Verify Link On Footer Page With Api data
    [Arguments]    ${platform}     ${language}     ${version}
    Wait Until Element Is Visible    ${iwm_footer_id}
    ${AllLinksCount}=    Get Matching Xpath Count    ${iwm_footer_a_tag}
    Comment    Log links count
    Log    ${AllLinksCount}
    Comment    Create a list to store link texts
    @{linkTextsList}    Create List
    Comment    Create a list to store href value, we cannot store in data dictionary because it have a problem to store Thai front.
    @{hrefList}         Create List
    Comment    Loop through all links and store links value that has length more than 1 character
    : FOR    ${INDEX}    IN RANGE     1     ${AllLinksCount}+1
    \    ${href}=           Selenium2Library.Get Element Attribute    xpath=(${iwm_footer_a_tag})[${INDEX}]@href
    \    ${link_text}=      Get Text                                  xpath=(${iwm_footer_a_tag})[${INDEX}]
    \    ${linklength}    Get Length    ${link_text}
    \    Append To List    ${linkTextsList}    ${link_text}
    \    Append To List    ${hrefList}    ${href}
    ${LinkSize}=    Get Length    ${linkTextsList}
    Get Footer Data From Api     ${version}     ${language}
    ${response_body}=      Get Response Body
    ${dataFromApi}=        Get Json Value    ${response_body}    /data/${language}/${platform}
    Log     ${dataFromApi}
    ${dataLenght}=         Get Length        ${dataFromApi}
    ${endPosition}=        Evaluate          ${dataLenght} - 1
    Comment    Remove a double qoute from a json string
    ${footerString}=        Get Substring    ${dataFromApi}     1       ${endPosition}
    Comment    Remove an escape character
    ${footerString2}=         Replace String     ${footerString}      \\"       "
    ${footerString3}=         Replace String     ${footerString2}     \\n       ${EMPTY}
    ${footerString4}=         Replace String     ${footerString3}     \\t       ${EMPTY}
    Comment    Pares json string to xml element
    ${xmlFormat}=    Parse XML      ${footerString4}
    Comment    Xpath format depend on the data format, Note the xpath of XML Lib is difference from normal xpath standard.
    ${children} =   Get Elements    ${xmlFormat}  */a
    ${childrenSize}=    Get Length    ${children}
    Should Be Equal     ${LinkSize}     ${childrenSize}
    Comment    Loop to compare a data between the data on page and data from API
    : FOR    ${listIndex}    IN RANGE     0     ${LinkSize}
    \    Log    ${listIndex}
    \    ${linkText}=       Get From List       ${linkTextsList}     ${listIndex}
    \    ${hrefValue}=      Get From List       ${hrefList}          ${listIndex}
    \    Log    ${linkText}
    \    Log    ${hrefValue}
    \    ${aElement}=            Get From List       ${children}     ${listIndex}
    \    Log    ${aElement.text}
    \    Log    ${aElement.attrib['href']}
    \    Should Be Equal     ${linkText}      ${aElement.text}
    \    Should Contain     ${hrefValue}     ${aElement.attrib['href']}
    \    Should End With    ${hrefValue}     ${aElement.attrib['href']}

Get Footer Data From Api
    [Arguments]    ${version}    ${lang}
    Get Static Content By content and version and lang      ${portal-footer}    ${version}    ${lang}
