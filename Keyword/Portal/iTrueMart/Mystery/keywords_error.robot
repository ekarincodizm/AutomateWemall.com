*** Settings ***
Resource    ${CURDIR}/web_element_error.robot

*** Keywords ***
Mystery Error - Display Error Page
    Wait Until Element Is Visible           ${MysteryError_Modal}           30s
    Element Should Be Visible               ${MysteryError_Modal}