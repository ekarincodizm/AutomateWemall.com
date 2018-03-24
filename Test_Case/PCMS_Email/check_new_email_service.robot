*** Settings ***
Resource          ../../Keyword/Common/Keywords_Common.robot
Resource          ../../Keyword/Features/Create_Order/Create_order.txt
Resource          ../../Keyword/Portal/PCMS/Orders/Keywords_Orders.robot
Resource          ../../Keyword/Portal/PCMS/Email/Keywords_Verify_Send_Email.robot

*** Variables ***
${email-guest}    Jirakit_run@hotmail.com


*** Test Cases ***
TC_1_To verify that after create online order, thank you email is sent to customer.
    [Tags]    TC1
    [Teardown]      Close All Browsers
#    ${order_id}=    Guest Buy Product Success with CCW      ${email-guest}      ${default_inventoryID}
#    Log To Console       order_id = ${order_id}
    ${order_id}     Set Variable    3001784
    ${order_data}=  Order - Get Order data   ${order_id}
    Email - Verify email     ${order_id}  ${order_data}   2   thankyou-page

TC_2_To verify that after create online order, shipped email is sent to customer.
    [Tags]    TC2
    [Teardown]      Close All Browsers
    ${order_id}=    Guest Buy Product Success with CCW      ${email-guest}      ${default_inventoryID}
    Log To Console       order_id = ${order_id}

TC_3_To verify that after create offline order, thank you email is sent to customer.
    [Tags]    TC3
    [Teardown]      Close All Browsers
    ${order_id}=    Guest Buy Product Success with CCW      ${email-guest}      ${default_inventoryID}
    Log To Console       order_id = ${order_id}

TC_4_To verify that after create offline order, payment success email is sent to customer.
    [Tags]    TC4
    [Teardown]      Close All Browsers
    ${order_id}=    Guest Buy Product Success with CCW      ${email-guest}      ${default_inventoryID}
    Log To Console       order_id = ${order_id}

TC_5_To verify that after create COD order, thank you email is sent an email from SES service to customer successfully.
    [Tags]    TC5
    [Teardown]      Close All Browsers
    ${order_id}=    Guest Buy Product Success with CCW      ${email-guest}      ${default_inventoryID}
    Log To Console       order_id = ${order_id}

TC_6_To verify that after 3PL send delivered status, delivered email is sent to customer.
    [Tags]    TC6
    [Teardown]      Close All Browsers
    ${order_id}=    Guest Buy Product Success with CCW      ${email-guest}      ${default_inventoryID}
    Log To Console       order_id = ${order_id}

TC_7_To verify that send notify in order track menu send an email successfully.
    [Tags]    TC7
    [Teardown]      Close All Browsers
    ${order_id}=    Guest Buy Product Success with CCW      ${email-guest}      ${default_inventoryID}
    Log To Console       order_id = ${order_id}

TC_8_To verify that mass upload tracking function send an email successfully.
    [Tags]    TC8
    [Teardown]      Close All Browsers
    ${order_id}=    Guest Buy Product Success with CCW      ${email-guest}      ${default_inventoryID}
    Log To Console       order_id = ${order_id}