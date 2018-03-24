*** Settings ***
Library         Selenium2Library
Library         HttpLibrary.HTTP
Library         Collections
Library         OperatingSystem

Resource        ${CURDIR}/../../../Resource/init.robot
Resource        ${CURDIR}/../../../Keyword/Database/PCMS/Mystery/keywords_prepare_data.robot
Resource        ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/Mystery/keywords_begins.robot
Resource        ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot

*** Variables ***
${prefix_landing}       mystery-landing

*** Test Cases ***
TC_iTM_03154: Create content in EDM for mystery landing page
    [Tags]   TC_iTM_03154   regression   ready   ITMMZ-1437   Support-2016S12   EDM  blackpanther
    Mystery Begins - [Web] Open Begins Page
    Mystery Begins - Click Next
    Mystery Begins - [Web] Find Content Element
    [Teardown]      Run Keywords    Close Browser

TC_iTM_03155: Create content in EDM for mystery landing page in preview mode
    [Tags]   TC_iTM_03155   regression   ready   ITMMZ-1437   Support-2016S12   EDM  blackpanther
    Mystery Begins - [Web] Open Begins Page In Preview Mode
    Mystery Begins - [Web] Find Content Element
    [Teardown]      Run Keywords    Close Browser

TC_iTM_03156: Display mystery landing page although EDM is disable
    [Tags]   TC_iTM_03156   regression   ready   ITMMZ-1437   Support-2016S12   EDM  blackpanther
    Mystery Begins - [Web] Open PCMS EDM Landing Page
#    sleep       5s
    Mystery Begins - [Web] Open Begins Page
    Mystery Begins - Click Next
    Mystery Begins - [Web] Find Content Element
    [Teardown]      Run Keywords    Close Browser

TC_iTM_03465: Display Term&Condition page in the new tab after click link
    [Tags]   TC_iTM_03465   regression   ready   ITMMZ-1437   Support-2016S12  blackpanther
    Mystery Begins - [Web] Open Term And Condition Page
    Sleep                          10s
    Select Window                  url=http://support.wemall.com/?id=895505&title=%25e0%25b9%2580%25e0%25b8%2587%25e0%25b8%25ad%25e0%25b8%2599%25e0%25b9%2584%25e0%25b8%2582%25e0%25b8%2581%25e0%25b8%25b2%25e0%25b8%25a3%25e0%25b8%25a3%25e0%25b8%25a7%25e0%25b8%25a1%25e0%25b8%2581%25e0%25b8%2588%25e0%25b8%2581%25e0%25b8%25a3%25e0%25b8%25a3%25e0%25b8%25a1%252dThe%252dMystery%252dBegins%252d%25e0%25b8%2596%25e0%25b8%25ad%25e0%25b8%2594%25e0%25b8%25a3%25e0%25b8%25ab%25e0%25b8%25aa%252dSecret%252dCode%252d%25e0%25b8%25a3%25e0%25b8%259a%25e0%25b8%25a3%25e0%25b8%25b2%25e0%25b8%2587%25e0%25b8%25a7%25e0%25b8%25a5%25e0%25b8%25a1%25e0%25b8%25a5%25e0%25b8%2584%25e0%25b8%25b2%25e0%25b8%25a3%25e0%25b8%25a7%25e0%25b8%25a1%25e0%25b8%2581%25e0%25b8%25a7%25e0%25b8%25b2%252d300000%252d%25e0%25b8%259a%25e0%25b8%25b2%25e0%25b8%2597
    [Teardown]      Run Keywords    Close Browser


