*** Settings ***
Library     Selenium2Library
Resource    ${CURDIR}/webelement_manage_shop_header.robot

*** Keywords ***
Click Publish for Header Storefront page
    Click Element and Wait Angular Ready    ${PUBLISH_BUTTON}

Click Save for Header Storefront page
    Click Element and Wait Angular Ready    ${SAVE_BUTTON}

Click Preview Thai for Header Storefront page
    Click Element and Wait Angular Ready    ${PREVIEW_THAI_BUTTON}

Click Preview English for Header Storefront page
    Click Element and Wait Angular Ready    ${PREVIEW_ENG_BUTTON}

Wait For Success Header Storefront page
    Wait Until Element Contains     ${ALERT_SUCCESS}    ${SAVE_SUCCESS}    60

Wait For Error Header Storefront page
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
