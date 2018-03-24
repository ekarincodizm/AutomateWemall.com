*** Settings ***
Library             Selenium2Library
Library             ${CURDIR}/../../../../Python_Library/ExtendedSelenium/
Resource            ${CURDIR}/webelement_manage_shop_content.robot

*** Keywords ***
Click Publish for Content Storefront page
    Wait Until Angular Ready    30s
    Wait Until Element Is Visible    ${PUBLISH_BUTTON}    10s
    Click Element and Wait Angular Ready    ${PUBLISH_BUTTON}

Click Save for Content Storefront page
    Wait Until Angular Ready    30s
    Wait Until Element Is Visible    ${SAVE_BUTTON}    10s
    Click Element and Wait Angular Ready    ${SAVE_BUTTON}

Click Preview Thai for Content Storefront page
    Wait Until Angular Ready    30s
    Wait Until Element Is Visible    ${PREVIEW_THAI_BUTTON}    10s
    Click Element and Wait Angular Ready    ${PREVIEW_THAI_BUTTON}

Click Preview English for Content Storefront page
    Wait Until Angular Ready    30s
    Wait Until Element Is Visible    ${PREVIEW_ENG_BUTTON}    10s
    Click Element and Wait Angular Ready    ${PREVIEW_ENG_BUTTON}

Wait For Success Content Storefront page
    Wait Until Page Contains Element    ${ALERT_SUCCESS}    60
    Wait Until Element Contains     ${ALERT_SUCCESS}    ${SAVE_SUCCESS}    60

Wait For Publish Content Storefront page
    Wait Until Page Contains Element    ${ALERT_SUCCESS}    60
    Wait Until Element Contains     ${ALERT_SUCCESS}    ${PUBLISH_SUCCEED}    60

Wait For Error Content Storefront page
    Wait Until Page Contains Element    ${ALERT_ERROR}    60
    Wait Until Element Contains     ${ALERT_ERROR}      ${ERROR_MESSAGE}    60

Input Image to Ckditor for TH Language
    Wait Until Page Contains Element    ${IMG_ICONTH}    60
    Click Element and Wait Angular Ready    ${IMG_ICONTH}
    sleep    1
    Wait Until Page Contains Element    ${IMG_INPUTFIELDTH}    60
    sleep    1
    Input Text       ${IMG_INPUTFIELDTH}    ${IMG_PIC}
    Wait Until Page Contains Element    ${OK_ICONTH}    60
    Click Element and Wait Angular Ready    ${OK_ICONTH}

Input Image to Ckditor for EN Language
   Wait Until Page Contains Element    ${IMG_ICONEN}    60
   Click Element and Wait Angular Ready    ${IMG_ICONEN}
   sleep    1
   Wait Until Page Contains Element    ${IMG_INPUTFIELDTH}    60
   sleep    1
   Input Text       ${IMG_INPUTFIELDEN}    ${IMG_PIC}
   Wait Until Page Contains Element    ${OK_ICONEN}    60
   Click Element and Wait Angular Ready    ${OK_ICONEN}

Add Image
   [Arguments]    ${imageFileNameTag}    ${imagePath}
   ${canonicalPath}=    Get Canonical Path    ${imagePath}
   Choose File    ${imageFileNameTag}    ${canonicalPath}
