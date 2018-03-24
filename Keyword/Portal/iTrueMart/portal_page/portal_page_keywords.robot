*** Settings ***
Library           Selenium2Library
Resource          ${CURDIR}/../../../../Keyword/Portal/iTrueMart/portal_page/web_element_portal_page.robot
Resource          ../../../Common/keywords_wemall_common.robot

*** Keywords ***
Portal - Click Return Policy
    Wait Until Element Is Visible    ${lk_return_policy}    20
    Click Element    ${lk_return_policy}

Portal - Click Delivery Policy
    Wait Until Element Is Visible    ${lk_delivery_policy}    20
    Click Element    ${lk_delivery_policy}

Portal - Click Money Back Policy
    Wait Until Element Is Visible    ${lk_moneyback_policy}    20
    Click Element    ${lk_moneyback_policy}

Portal - Click Payment Manual
    Wait Until Element Is Visible    ${lk_payment_manual}    20
    Click Element    ${lk_payment_manual}

Open Browser and Go to iTrueMart Portal
    Open Browser    ${ITM_URL}    ${BROWSER}    None
    Set Window Position    ${0}    ${0}
    Maximize Browser Window
    Wait Until Element Is Visible    jquery=.header__contact

Open Browser and Go to iTrueMart EN Portal
    Open Browser    ${ITM_URL}/en    ${BROWSER}    None
    Set Window Position    ${0}    ${0}
    Maximize Browser Window
    Wait Until Element Is Visible    jquery=.header__contact

Open iTrueMart Portal
    [Arguments]    ${lang}=th
    Log to console    ITM_URL=${ITM_URL}
    Run Keyword If    '${lang}'=='th'    Open Browser    ${ITM_URL}    ${BROWSER}
    ...    ELSE    Open Browser    ${ITM_URL}/${lang}    ${BROWSER}

Go to iTrueMart Portal
    Go to    ${ITM_URL}

Open Browser and Go to Specific URL
    [Arguments]    ${full_url}
    Open Browser    ${full_url}    ${BROWSER}    None
    Comment    Set Window Position    ${0}    ${0}
    # Maximize Browser Window
    Set Window Size    ${1440}    ${900}
    Wemall Common - Close Live Chat

Go to Order Tracking Page
    Go to    ${ITM_URL}/member/orders

Go to EN Order Tracking Page
    Go to    ${ITM_URL}/en/member/orders

Display Hilight Banner
    Wait Until Page Contains Element    ${hilight_banner}
    Page Should Contain Element    ${hilight_banner}

Display Accordion Banner
    Wait Until Page Contains Element    ${accordion_banner}
    Page Should Contain Element    ${accordion_banner}

Display Showroom
    Wait Until Page Contains Element    ${displayed_showroom}
    Page Should Contain Element    ${displayed_showroom}

Verify Portal Element
    [Arguments]    ${portal_url}
    Go To With Cache Version    ${portal_url}
    Page Should Contain Element    jquery=.home__top_banner    #banner
    Page Should Contain Element    jquery=.home__container    #content
    Page Should Contain Element    jquery=.home__policy_banner    #policy
    Page Should Contain Element    jquery=.footer__bg_main-link    #footer
    Page Should Contain Element    jquery=.footer__bg_social    #footer_social
    Page Should Contain Element    jquery=.footer__bg_bottom    #footer_cybersource
