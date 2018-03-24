*** Settings ***
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           OperatingSystem
Library           String
Library           DateTime
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Orders/keywords_orders.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Self_Service/keywords_common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Self_Service/Main_form/keywords_main_form.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Self_Service/Report_problem/keywords_report_problem.robot
Resource          ${CURDIR}/../../../Keyword/Common/keywords_itruemart_common.robot
Resource          ${CURDIR}/../../../Keyword/Common/keywords_date.robot

#Suite Teardown    Close All Browsers
*** Variables ***
${Topic_Order_Problem_Following}    3
${SS_Blackpather_Email}             blackpantherautomate@gmail.com
${SS_Email_Test}                    caramelappletini@gmail.com


*** Test Cases ***
TC_ITMWM_04073 Display error message if a shopper input email of following report problem form is not exist in system
    [Tags]      regression      ready       ITMMZ-1483      X-Support-2016S15
    Open Browser                                ${WEMALL_URL}
    SS Common - Click Live Chat Button
    SS Main Form - Display Main Form
    SS Main Form - Select Topic                 ${Topic_Order_Problem_Following}
    SS Main Form - Input Email                  aaa@hotmail.com
    SS Main Form - Input Order Id               100003570
    SS Main Form - Click Next Step
    SS Report Problem - Display Not Found Problem
    [Teardown]      Run Keywords    Close Browser

TC_ITMWM_04074 Display error message if a shopper input order id of following report problem form is not exist in system
    [Tags]      regression      ready       ITMMZ-1483      X-Support-2016S15
    Open Browser                                ${WEMALL_URL}
    SS Common - Click Live Chat Button
    SS Main Form - Display Main Form
    SS Main Form - Select Topic                 ${Topic_Order_Problem_Following}
    SS Main Form - Input Email                  ${SS_Blackpather_Email}
    SS Main Form - Input Order Id               1
    SS Main Form - Click Next Step
    SS Report Problem - Display Not Found Problem
    [Teardown]      Run Keywords    Close Browser

TC_ITMWM_04075 Following report problem with order does not report problem
    [Tags]      regression      ready       ITMMZ-1483      X-Support-2016S15
    Open Browser                                ${WEMALL_URL}
    SS Common - Click Live Chat Button
    SS Main Form - Display Main Form
    SS Main Form - Select Topic                 ${Topic_Order_Problem_Following}
    SS Main Form - Input Email                  ${SS_Blackpather_Email}
    SS Main Form - Input Order Id               100037016
    SS Main Form - Click Next Step
    SS Report Problem - Display Not Found Problem
    [Teardown]      Run Keywords    Close Browser

TC_ITMWM_04077 Following report problem shows item in ticket when click link expand
    [Tags]      regression      ready       ITMMZ-1483      X-Support-2016S15
    Open Browser                                ${WEMALL_URL}
    SS Common - Click Live Chat Button
    SS Main Form - Display Main Form
    SS Main Form - Select Topic                 ${Topic_Order_Problem_Following}
    SS Main Form - Input Email                  ${SS_Email_Test}
    SS Main Form - Input Order Id               100012111
    SS Main Form - Click Next Step
    SS Report Problem - Display Report Problem
    [Teardown]      Run Keywords    Close Browser

TC_ITMWM_04079 Return to live chat main menu when click back from following report problem
    [Tags]      regression      ready       ITMMZ-1483      X-Support-2016S15
    Open Browser                                ${WEMALL_URL}
    SS Common - Click Live Chat Button
    SS Main Form - Display Main Form
    SS Main Form - Select Topic                 ${Topic_Order_Problem_Following}
    SS Main Form - Input Email                  ${SS_Email_Test}
    SS Main Form - Input Order Id               100012111
    SS Main Form - Click Next Step
    SS Report Problem - Back To Main Menu
    [Teardown]      Run Keywords    Close Browser