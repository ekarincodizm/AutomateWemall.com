*** Settings ***
Library         String
Library         Selenium2Library
Library         ${CURDIR}/../../../../Python_Library/ExtendedSelenium/
Resource        ${CURDIR}/../../wemall/common/web_common_keywords.robot
Resource        ${CURDIR}/../common/mobile_common_keywords.robot
Resource        ${CURDIR}/webelement_storefront_page.robot

*** Keywords ***
Open Storefront
    [Arguments]    ${STOREFRONT_NAME}
    Open Mobile Browser     ${WEMALL_WEB}/shop/${STOREFRONT_NAME}   ${BROWSER}

Go To Storefront Mobile Page
    [Arguments]     ${shop_slug}
    Open Mobile Browser    ${WEMALL_WEB}/shop/${shop_slug}    ${BROWSER}    ${PAGE_ALIAS}
    Wait Until Angular Ready    60s

Go To Storefront Mobile Page - Secondary Language
    [Arguments]     ${shop_slug}
    Open Mobile Browser    ${WEMALL_WEB}/en/shop/${shop_slug}    ${BROWSER}    ${PAGE_ALIAS}
    Wait Until Angular Ready    60s

Change URL To Storefront Mobile Page
    [Arguments]     ${shop_slug}
    Go To   ${WEMALL_WEB}/shop/${shop_slug}
    Wait Until Location Contains        ${WEMALL_WEB}/shop/${shop_slug}
    Wait Until Angular Ready    30s
    Add Cookie      is_mobile  true
    Reload Page
    Wait Until Angular Ready    60s
    Wait Until Page Contains Element    css=html
    Wait Until Page Contains Element    css=div.storefront-logo

Change URL To Storefront Mobile Page - Secondary Language
    [Arguments]     ${shop_slug}
    Go To    ${WEMALL_WEB}/en/shop/${shop_slug}
    Wait Until Location Contains        ${WEMALL_WEB}/en/shop/${shop_slug}
    Wait Until Angular Ready    30s
    Add Cookie      is_mobile  true
    Reload Page
    Wait Until Angular Ready    60s
    Wait Until Page Contains Element    css=html
    Wait Until Page Contains Element    css=div.storefront-logo

Switch To Storefront Mobile Page
    Switch Browser    ${PAGE_ALIAS}

Close Storefront Mobile Page
    Switch To Storefront Mobile Page
    Close Window

Verify Storefront Header
    Wait Until Angular Ready    30s
    Page Should Contain Image     ${storefrontHeader}

Verify Storefront Logo
    Wait Until Angular Ready    30s
    Page Should Contain Image     ${storefrontLogo}

Verify Storefront Banner
    Wait Until Angular Ready    30s
    Page Should Contain Element     ${storefrontBanner}
    Locator Should Match X Times    ${owlItem}      ${times}

Verify Storefront Title
    [Arguments]    ${title}
    Wait Until Angular Ready    30s
    Page Should Contain     ${title}

Verify Storefront Menu
    Wait Until Angular Ready    30s
    Click Hamburger Button
    Page Should Contain Element     ${storefrontMenuHeader}
    Page Should Contain Element     ${storefrontMenuBody}
    Click To Next Level

    Click Close Button
    Wait Until Page Does Not Contain Element         ${showMenu}        1

Verify Storefront Mobile Menu Data Does Not Exist
    Page Should Not Contain Element    ${button-hamburger}

Verify Storefront Mobile Menu Data
    [Arguments]    ${lang}    ${allMenuData}
#   Verify menu level 1
    Wait Until Element Is Visible    ${button-hamburger}    10s
    Click Element    ${button-hamburger}
    Wait Until Element Is Visible    ${storefrontMenuLv1}    3s
    ${menuLv1Elements}=    Get Webelements    ${storefrontMenuLv1}
    ${actualLength}=    Get Length    ${menuLv1Elements}
    ${expectedLength}=    Get Length    ${allMenuData}
    Should Be Equal As Integers    ${expectedLength}    ${actualLength}
    :FOR    ${index}    IN RANGE    ${actualLength}
    \    ${menuData}=    Set Variable    @{allMenudata}[${index}]
    # \    ${menuLv1Element}=    Get Text    @{menuLv1Elements}[${index}]
    \    ${menuLv1Element}=    Set Variable    @{menuLv1Elements}[${index}]
    \    Element Should Contain    ${menuLv1Element}    ${menuData.name${lang}}
    \    Run Keyword If    '${menuData.link${lang}}' and ${menuData.children} == ${None}    Should Start With    ${menuLv1Element.get_attribute("href")}    ${menuData.link${lang}}
    \    ...    ELSE    Should Be Equal    ${menuLv1Element.get_attribute("href")}    ${None}
#   Verify menu level 2
    \    Verify Storefront Mobile Menu Data Lv2    ${lang}    ${menuLv1Element}    ${menuData.children}

Verify Storefront Mobile Menu Data Lv2
    [Arguments]    ${lang}    ${menuLv1Element}    ${menuLv2Data}
    Return From Keyword If    ${menuLv2Data} == ${None}
    Wait Until Element Is Visible    ${button-hamburger}    10s
    Click Element    ${menuLv1Element}
    Wait Until Element Is Visible    ${storefrontMenuLv2}    3s
    ${menuLv2Elements}=    Get Webelements    ${storefrontMenuLv2}
    ${actualLength}=    Get Length    ${menuLv2Elements}
    ${expectedLength}=    Get Length    ${menuLv2Data}
    ${menuLv2Length}=    Evaluate    ${actualLength}-1
    Should Be Equal As Integers    ${expectedLength}    ${menuLv2Length}
    :FOR    ${index}    IN RANGE    ${menuLv2Length}
    \    ${actualIndex}=    Evaluate    ${index}+1
    \    ${menuData}=    Set Variable    @{menuLv2Data}[${index}]
    \    ${menuLv2Element}=    Set Variable    @{menuLv2Elements}[${actualIndex}]
    \    Element Should Contain    ${menuLv2Element}    ${menuData.name${lang}}
    \    Should Start With    ${menuLv2Element.get_attribute("href")}    ${menuData.link${lang}}
    Click Element    @{menuLv2Elements}[0]

Verify Storefront Mobile Menu Data Primary Language
    [Arguments]    ${allMenuData}
    Verify Storefront Mobile Menu Data    Th    ${allMenuData}

Verify Storefront Mobile Menu Data Secondary Language
    [Arguments]    ${allMenuData}
    Verify Storefront Mobile Menu Data    En    ${allMenuData}

Verify Storefront Dot
    Wait Until Angular Ready    30s
    Click Dot Button
    Page Should Contain Element     ${storefrontMenuModal}
    Click Close Button
    Wait Until Page Does Not Contain Element         ${storefrontMenuModal}        1

Verify Storefront Footer Menu
     Wait Until Angular Ready    30s
     Click Footer Button
     Element Should Be Visible          ${copyright}

Verify Storefront Contents
    Wait Until Angular Ready    30s
    Page Should Contain Element     ${storefrontMainContent}

Verify Storefront Footer
    Wait Until Angular Ready    30s
    Page Should Contain Element     ${storefrontFooter}

Click To Next Level
    Click Element   ${to-next-level}

Click Hamburger Button
    Click Element    ${button-hamburger}
    Wait Until Element Is Enabled   ${storefrontMenuHeader}    1

Click Dot Button
    Click Element    ${button-dot}
    Wait Until Element Is Enabled    ${storefrontMenuModal}    1

Click Footer Button
    Click Element    ${button-footer}
    Wait Until Element Is Enabled    ${button-footer}       1

Click Close Button
    Click Element    ${button-close}

Banner Mobile Not Should Be Show
    Page Should Not Contain Element     jquery=div.wm-store-highlight-banner

Banner Mobile Amount Dot Should Be
    [Arguments]     ${amount}
    ${list}=    Get WebElements    ${banner_storefront_index}
    Length Should Be   ${list}    ${amount}

Banner Mobile Should Not Show Carousel Dot
    ${list}=    Get WebElements    jquery=div.owl-dots.disabled
    Length Should Be   ${list}    1

Banner Mobile Should Show Carousel Dot
    ${list}=    Get WebElements    jquery=div.owl-dots:not(.disabled)
    Length Should Be   ${list}    1

Banner Mobile Image Carousel By Index Should Contain
    [Arguments]     ${Index}    ${value}
    Banner Mobile Element Attribute By Index Should Contain    ${Index}    img    src     ${value}

Banner Mobile Alt Carousel By Index Should be Equal
    [Arguments]     ${Index}    ${value}
    Banner Mobile Element Attribute By Index Should be Equal    ${Index}    img    alt     ${value}

Banner Mobile Link Carousel By Index Should be Equal
    [Arguments]     ${Index}    ${value}
    Locator Should Match X Times    ${banner_storefront_index}:eq(${Index}) a[href='${value}']     1

Banner Mobile Target Carousel By Index Should be Equal
    [Arguments]     ${Index}    ${value}
    Banner Mobile Element Attribute By Index Should be Equal    ${Index}    a    target     ${value}

Banner Mobile Element Attribute By Index Should be Equal
    [Arguments]     ${Index}    ${tag}    ${attrName}    ${expected_value}
    # ${element}=    Get WebElement    ${banner_storefront_index}:eq(${Index}) ${tag}
    # ${actual_value}=    Set Variable    ${element.get_attribute('${attrName}')}
    ${actual_value}=    Selenium2Library.Get Element Attribute    ${banner_storefront_index}:eq(${Index}) ${tag}@${attrName}
    Should Be Equal As Strings   ${actual_value}    ${expected_value}

Banner Mobile Element Attribute By Index Should Contain
    [Arguments]     ${Index}    ${tag}    ${attrName}    ${expected_value}
    # ${element}=    Get WebElement    ${banner_storefront_index}:eq(${Index}) ${tag}
    # ${actual_value}=     Set Variable    ${element.get_attribute('${attrName}')}
    ${actual_value}=    Selenium2Library.Get Element Attribute    ${banner_storefront_index}:eq(${Index}) ${tag}@${attrName}
    Should Contain  ${actual_value}    ${expected_value}
