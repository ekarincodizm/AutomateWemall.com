*** Settings ***
Library     Selenium2Library
Library     HttpLibrary.HTTP
Library     Collections
Library     OperatingSystem
Library     String

Resource    ${CURDIR}/../../../Resource/init.robot
Resource    ${CURDIR}/../../../Keyword/API/PCMS/Send_Email_SMS/keywords_send_email_sms.robot

*** Variables ***
${Order_Shipped_has_Tracking_TH}             100057774
${Order_Deliverd_has_Tracking_EN}            100057775
${Order_Shipped_no_Tracking}                 100058105

*** Test Cases ***
TC_ITMWM_06864 - API tracking no. send email&sms success when system send valid order id and can be resend again [TH]
    [Tags]   TC_ITMWM_06864   regression   ready   ITMMZ-1527   X-Support-2016S19
    PCMS API Send Email SMS - Call Api Resend Tracking             ${Order_Shipped_has_Tracking_TH}
    Should Be Equal        ${var_send_msg_tracking_code}           200
    Should Contain         ${var_send_msg_tracking_message}        200 OK

TC_ITMWM_06865 - API tracking no. send email&sms success when system send valid order id and can be resend again [EN]
    [Tags]   TC_ITMWM_06865   regression   ready   ITMMZ-1527   X-Support-2016S19
    PCMS API Send Email SMS - Call Api Resend Tracking             ${Order_Deliverd_has_Tracking_EN}
    Should Be Equal        ${var_send_msg_tracking_code}           200
    Should Contain         ${var_send_msg_tracking_message}        200 OK

TC_ITMWM_06866 - API tracking no. send email&sms success when system send valid order id which no tracking no.
    [Tags]   TC_ITMWM_06866   regression   ready   ITMMZ-1527   X-Support-2016S19
    PCMS API Send Email SMS - Call Api Resend Tracking             ${Order_Shipped_no_Tracking}
    Should Be Equal        ${var_send_msg_tracking_code}           200
    Should Contain         ${var_send_msg_tracking_message}        200 OK

TC_ITMWM_06868 - API tracking no. return error response message when system does not send value of order_id node
    [Tags]   TC_ITMWM_06868   regression   ready   ITMMZ-1527   X-Support-2016S19
    PCMS API Send Email SMS - Call Api Resend Tracking             ${EMPTY}
    Should Be Equal        ${var_send_msg_tracking_code}           400
    Should Contain         ${var_send_msg_tracking_message}        Order Id is required field.

TC_ITMWM_06869 - API tracking no. return error response message when system does not send value of order_id = null
    [Tags]   TC_ITMWM_06869   regression   ready   ITMMZ-1527   X-Support-2016S19
    PCMS API Send Email SMS - Call Api Resend Tracking             null
    Should Be Equal        ${var_send_msg_tracking_code}           400
    Should Contain         ${var_send_msg_tracking_message}        Order Id is invalid.

TC_ITMWM_06870 - API tracking no. return error response message when system send order id is not existing in system
    [Tags]   TC_ITMWM_06870   regression   ready   ITMMZ-1527   X-Support-2016S19
    PCMS API Send Email SMS - Call Api Resend Tracking             2
    Should Be Equal        ${var_send_msg_tracking_code}           400
    Should Contain         ${var_send_msg_tracking_message}        No query results for model [Order].

TC_ITMWM_06871 - API tracking no. return error response message when system send invalid order_id node
    [Tags]   TC_ITMWM_06871   regression   ready   ITMMZ-1527   X-Support-2016S19
    PCMS API Send Email SMS - Call Api Resend Tracking             PCMS100041054
    Should Be Equal        ${var_send_msg_tracking_code}           400
    Should Contain         ${var_send_msg_tracking_message}        Order Id is invalid.

TC_ITMWM_06872 - API tracking no. return error response message when system send space with order_id node
    [Tags]   TC_ITMWM_06872   regression   ready   ITMMZ-1527   X-Support-2016S19
    PCMS API Send Email SMS - Call Api Resend Tracking             1000%2041054
    Should Be Equal        ${var_send_msg_tracking_code}           400
    Should Contain         ${var_send_msg_tracking_message}        Order Id is invalid.





