*** Settings ***
Force Tags    WLS_Promotion
Library           Selenium2Library
Resource          ${CURDIR}/../../../Resource/Init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Promotion/keywords_mass_price_product.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Promotion/keywords_export_campaign_price_and_product.robot
Test Setup        Login Pcms
Test Teardown     Close All Browsers

*** Variables ***

*** Test Cases ***
TC_iTM_03467 - Downloaded templete of mass upload product and price for discount campaign - Success
    [Tags]    regression     Success    TC_iTM_03467    ready   phoenix    WLS_Medium
    Go to mass price and product menu
    ${filename}=    Download template
    Check template is correctly    ${filename}