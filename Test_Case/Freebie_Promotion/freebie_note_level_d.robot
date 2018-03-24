*** Settings ***
Library           Selenium2Library
Resource          ../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../Resource/Config/app_config.robot
Resource          ${CURDIR}/../../Resource/init.robot
Resource          ${CURDIR}/../../Keyword/Portal/AAD/AAD_common/keywords_aad.robot    # CAMP
Resource          ${CURDIR}/../../Keyword/Portal/CAMP/CAMP_Freebie/keywords_freebie.robot
Resource          ${CURDIR}/../../Keyword/Portal/CAMP/CAMP_common/Keywords_CAMP_Common.robot
Resource          ${CURDIR}/../../Keyword/Database/PCMS/Freebie/keywords_prepare_data_level_d.robot
Resource          ${CURDIR}/../../Keyword/Features/Freebie/keywords_level_d_web.robot
Resource          ${CURDIR}/../../Keyword/API/PCMS/Product/update_stock.robot

*** Variables ***
${PRODUCT_URL}        XXXX--2302748481913
${FREEBIE_ELEMENT}    .freebie_note ul li
${EXPECTED_COLOR}     rgb(237, 28, 36)
${CSS_COLOR_ATTR}     color
${start_normal}       9
${start_free}         11


*** Keywords ***
Prepare Freebie
    Set Inventory Id Product Main And Freebie 1Variant
    Get Main Product 1Variant A
    Get Free Product 1Variant B
    Check Current Stock Level D Main Product
    Check Current Stock Level D Free Product
    Check Promotions Freebie On Camp And Delete All By Inventory Id    ${var_freebie_main_1VariantA}
    Set Freebie On Camp Level D    2    1
    Set Remaining Level D Main Product    10
    Set Remaining Level D Free Product    10
    Rebuild Stock No Variant
    Log  ${var_freebie_main_1VariantA}
    Sleep    15s

Setup Browser
    Open Browser    ${ITM_URL}    chrome
    Set Window Position    ${0}    ${0}
    Set Window Size    ${1440}    ${900}

Verfify Freebie Text should be red color
    [Arguments]    ${URL}
    Sleep   15s
    Go to    ${URL}
    ${real_url}=    Get Location
    Go to     ${real_url}?no-cache=1
    Wait Until Element Is Visible   jquery=${FREEBIE_ELEMENT}    10
    ${ACTUAL_COLOR}    Execute Javascript    return window.jQuery("${FREEBIE_ELEMENT}").css("${CSS_COLOR_ATTR}")
    Should Contain    ${ACTUAL_COLOR}    ${EXPECTED_COLOR}

*** Test Cases ***
TC_ITMWM_05827 Change color Freebie terms&Condition text from black to red.
    [Tags]              FreebieColor        regression
    [Template]          Verfify Freebie Text should be red color
    [Setup]             Run Keywords    Setup Browser    AND    Prepare Freebie
    [Teardown]          Run Keywords    Restore Remaining And Promotion Level D    AND     Close All Browsers
# # url
    ${Wemall_URL}/products/${PRODUCT_URL}.html
    ${Wemall_URL}/en/products/${PRODUCT_URL}.html
    ${WEMALL_MOBILE}/products/${PRODUCT_URL}.html
    ${WEMALL_MOBILE}/en/products/${PRODUCT_URL}.html
