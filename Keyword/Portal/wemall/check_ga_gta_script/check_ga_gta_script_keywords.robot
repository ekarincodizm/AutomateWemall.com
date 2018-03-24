*** Settings ***
Library         Selenium2Library
Resource        ${CURDIR}/../common/web_common_keywords.robot
Resource        ${CURDIR}/webelement_check_ga_gta_script.robot

*** Keywords ***
Open Wemall Browser
    Open Browser and Maximize Window    ${ITM_URL}    ${BROWSER}

Go To Storefront Page
    [Arguments]     ${shop_slug}
    Go To    ${WEMALL_WEB}/shop/${shop_slug}

Script Should Contain NoScript
    Page Should Contain Element    ${noscript}