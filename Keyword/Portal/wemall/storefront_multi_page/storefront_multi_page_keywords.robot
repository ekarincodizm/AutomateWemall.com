*** Settings ***
Library         Selenium2Library
Library         ${CURDIR}/../../../../Python_Library/ExtendedSelenium/
Resource        ${CURDIR}/../common/web_common_keywords.robot
Resource        ${CURDIR}/webelement_storefront_page.robot
Resource        ${CURDIR}/../../../API/api_storefronts/storefront_keywords.robot

*** Variables ***
${logo_mobile}      jquery=div.product-storefront-body div.storefront-header div.storefront-logo

*** Keywords ***
Storefront Multi Page - Verify Mobile View
    Element Should Be Visible    ${logo_mobile}

Storefront Multi Page - Verify Web View
    Element Should Not Be Visible    ${logo_mobile}