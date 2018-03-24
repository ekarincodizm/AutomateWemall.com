*** Settings ***
Suite Teardown    Close All Browsers
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           OperatingSystem
Library           String
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Mystery/keywords_register_form.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Mystery/keywords_begins.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Mystery/keywords_error.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Mystery/keywords_complete_page.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Mystery/keywords_prepare_data.robot
Resource          ${CURDIR}/../../../Keyword/Features/Mystery/keywords_register_form.robot

*** Variables ***
${var_data_email}        blackpantherautomate@gmail.com
${var_data_firstname}    Blackpanther
${var_data_lastname}     Automate
${var_data_gender}       female
${var_data_tel}          0800000000

*** Test Cases ***
TC_iTM_03193 : Display complete page when register privilege success
    [Tags]  TC_iTM_03193    regression      ready       ITMMZ-1439      Support-2016S12  blackpanther
    Mystery Register - [Web] Open Register Form Bypass Recaptcha
    Mystery Data - Delete Automate Data
    Mystery Data - Get Prediction Item
    Mystery Data - Get Prediction Sub By Prediction Item Id             ${var_mystery_prediction_item_id}
    Mystery Register - Input First Name         ${var_data_firstname}
    Mystery Register - Input Last Name          ${var_data_lastname}
    Mystery Register - Input Tel                ${var_data_tel}
    Mystery Register - Select Gender
    Mystery Register - Select Birth Date
    Mystery Register - Input Email              ${var_data_email}
    Mystery Register - Input Prediction         ${var_mystery_prediction_item_id}
    Mystery Register - Click Submit
    Mystery Complete - Display Title Caption
    Mystery Complete - Display Customer Name as Test Data
    Mystery Complete - Display Customer Color as Test Data
    Mystery Complete - Display Prediciton All Image Main
    Mystery Complete - Display Long Description
    Mystery Complete - Display Button Share with Facebook

TC_iTM_03194 : Complete page redirect to mystery landing page when enter direct URL
    [Tags]  TC_iTM_03194    regression      ready       ITMMZ-1439      Support-2016S12  blackpanther
    Open Browser            ${WEMALL_URL}/mystery-begins/complete
    Sleep                   5s
    Location Should Be      ${WEMALL_URL}/mystery-begins
