*** Settings ***
Library         Selenium2Library
Library         HttpLibrary.HTTP
Library         Collections
Library         OperatingSystem

Resource        ${CURDIR}/../../../Resource/init.robot
Resource        ${CURDIR}/../../../Keyword/Database/PCMS/Mystery/keywords_prepare_data.robot
Resource        ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource        ${CURDIR}/../../../Keyword/Portal/PCMS/Mystery/keywords_register_privilege.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/Mystery/keywords_register_form.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/Mystery/keywords_complete_page.robot
Resource        ${CURDIR}/../../../Keyword/Features/Mystery/keywords_register_form.robot

*** Variables ***
${var_data_email}        blackpantherautomate@gmail.com
${var_data_firstname}    Blackpanther
${var_data_lastname}     Automate
${var_data_gender}       male
${var_data_tel}          0800000000

*** Test Cases ***
TC_iTM_03186: Register secret code success case
    [Tags]   TC_iTM_03186   regression  ready  ITMMZ-1441  Support-2016S11  blackpanther
    Mystery Register Privilege - [Web] Input Register Form And Use Bypass Recaptcha
    Mystery Register Privilege - Check
    [Teardown]      Run Keywords    Close Browser
