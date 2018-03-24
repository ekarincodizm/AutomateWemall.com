*** Settings ***
Library         Selenium2Library
Library         HttpLibrary.HTTP
Library         Collections
Library         OperatingSystem

Resource        ${CURDIR}/../../../Resource/init.robot
Resource        ${CURDIR}/../../../Keyword/Database/PCMS/Mystery/keywords_prepare_data.robot
Resource        ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/Mystery/keywords_secret.robot

*** Variables ***
${secret_code_false}        xxxxxxxxxx

*** Test Cases ***
TC_iTM_03208: Show error message if a member enter the wrong secret code
    [Tags]   TC_iTM_03208   regression   ready   ITMMZ-1443   Support-2016S11  blackpanther
    Mystery Secret - [Web] Open Secret Code Page
    Mystery Secret - [Web] Input Wrong Code
    [Teardown]      Run Keywords    Close Browser

TC_iTM_03209: Secret page decrypt secret code if a member enter the correct secret code after starting decryption secret code
    [Tags]   TC_iTM_03209   regression   ready   ITMMZ-1443   Support-2016S11  blackpanther
    Mystery Secret - [Web] Open Secret Code Page
    Mystery Data - Get Secret Code
    Mystery Secret - [Web] Input Correct Code
    [Teardown]      Run Keywords    Close Browser

TC_iTM_03211: Secret page decrypt secret code if a member enter the code has been used
    [Tags]   TC_iTM_03211   regression   ready   ITMMZ-1443   Support-2016S11  blackpanther
    Mystery Secret - [Web] Open Secret Code Page
    Mystery Data - Get Secret Code
    log to console      ${var_mystery_secret_code}
    Mystery Secret - [Web] Input Correct Code
    Mystery Secret - [Web] Open Secret Code Page
    log to console      ${var_mystery_secret_code}
    Mystery Secret - [Web] Input Correct Code
    [Teardown]      Run Keywords    Close Browser