*** Settings ***
Resource    ${CURDIR}/web_element_begins.robot

*** Keywords ***
Mystery Begins - [Web] Open Begins Page
    Open Browser                ${ITM_URL}/mystery-begins           ${BROWSER}
    Set Window Size             ${1500}          ${800}

Mystery Begins - Click Next
    Wait Until Element Is Visible       ${MysteryBegins_btn_next}          15s
    Click Element                       ${MysteryBegins_btn_next}

Mystery Begins - [Web] Open Begins Page In Preview Mode
    Open Browser                ${ITM_URL}/mystery-begins?previews=LS2&no-cache=1           ${BROWSER}
    Set Window Size             ${1500}          ${800}

Mystery Begins - [Web] Open PCMS EDM Landing Page
    Login Pcms
    Mystery Data - Get Prefix EDM
    Go To    ${PCMS_URL}/edm/edit/${var_mystery_landing_edm_id}
    Wait Until Element is ready and click       //select[@name='status']//option[@value='N']        10s
    Click Element   //input[@type="submit"]
#    sleep       3s
#    Confirm Action

Mystery Begins - [Web] Open Term And Condition Page
    Open Browser    ${ITM_URL}/mystery-begins           ${BROWSER}
    Wait Until Element Is Visible       ${MysteryBegins_term_and_con}        20s
    Element Should Be Visible           ${MysteryBegins_term_and_con}
    Wait Until Element Is Visible       ${MysteryBegins_term_and_con}        20s
    Click Element           ${MysteryBegins_term_and_con}

Mystery Begins - [Web] Find Content Element
    Wait Until Element Is Visible       ${MysteryBegin_content}          15s
    Element Should Be Visible           ${MysteryBegin_content}
