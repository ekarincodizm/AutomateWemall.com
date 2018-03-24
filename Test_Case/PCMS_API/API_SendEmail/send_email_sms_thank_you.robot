*** Settings ***
Library     Selenium2Library
Library     HttpLibrary.HTTP
Library     Collections
Library     OperatingSystem
Library     String

Resource    ${CURDIR}/../../../Resource/init.robot
Resource    ${CURDIR}/../../../Keyword/API/PCMS/Send_Email_SMS/keywords_send_email_sms.robot

*** Variables ***
${Order_CCW_Success_TH}                     100058235
${Order_Installment_Success_TH}             100058265
${Order_CS_Success_TH}                      100058412
${Order_COD_Success_TH}                     100058383
${Order_CCW_Success_EN}                     100058467
${Order_Installment_Success_EN}             100058495
${Order_CS_Success_EN}                      100058479
${Order_COD_Success_EN}                     100058508
${Order_CCW_Failed_TH}                      100058781
${Order_Installment_Failed_TH}              100058783
${Order_CCW_Failed_EN}                      100058785
${Order_Installment_Failed_EN}              100058786

*** Test Cases ***
TC_ITMWM_06831 - [CCW] API send email&sms success when system send valid order id [success][TH]
    [Tags]   TC_ITMWM_06831   regression   ready   ITMMZ-1526   X-Support-2016S19
    PCMS API Send Email SMS - Call Api Resend Thank You            ${Order_CCW_Success_TH}
    Should Be Equal        ${var_send_msg_tracking_code}           200
    Should Contain         ${var_send_msg_tracking_message}        200 OK

TC_ITMWM_06832 - [Installment] API send email&sms success when system send valid order id [success][TH]
    [Tags]   TC_ITMWM_06832   regression   ready   ITMMZ-1526   X-Support-2016S19
    PCMS API Send Email SMS - Call Api Resend Thank You            ${Order_Installment_Success_TH}
    Should Be Equal        ${var_send_msg_tracking_code}           200
    Should Contain         ${var_send_msg_tracking_message}        200 OK

TC_ITMWM_06836 - [CS] API send email&sms success when system send valid order id [success][TH]
    [Tags]   TC_ITMWM_06836   regression   ready   ITMMZ-1526   X-Support-2016S19
    PCMS API Send Email SMS - Call Api Resend Thank You            ${Order_CS_Success_TH}
    Should Be Equal        ${var_send_msg_tracking_code}           200
    Should Contain         ${var_send_msg_tracking_message}        200 OK

TC_ITMWM_06837 - [COD] API send email&sms success when system send valid order id [success][TH]
    [Tags]   TC_ITMWM_06837   regression   ready   ITMMZ-1526   X-Support-2016S19
    PCMS API Send Email SMS - Call Api Resend Thank You            ${Order_COD_Success_TH}
    Should Be Equal        ${var_send_msg_tracking_code}           200
    Should Contain         ${var_send_msg_tracking_message}        200 OK

TC_ITMWM_06840 - [CCW] API send email&sms success when system send valid order id [success][EN]
    [Tags]   TC_ITMWM_06840   regression   ready   ITMMZ-1526   X-Support-2016S19
    PCMS API Send Email SMS - Call Api Resend Thank You            ${Order_CCW_Success_EN}
    Should Be Equal        ${var_send_msg_tracking_code}           200
    Should Contain         ${var_send_msg_tracking_message}        200 OK

TC_ITMWM_06841 - [Installment] API send email&sms success when system send valid order id [success][EN]
    [Tags]   TC_ITMWM_06841   regression   ready   ITMMZ-1526   X-Support-2016S19
    PCMS API Send Email SMS - Call Api Resend Thank You            ${Order_Installment_Success_EN}
    Should Be Equal        ${var_send_msg_tracking_code}           200
    Should Contain         ${var_send_msg_tracking_message}        200 OK

TC_ITMWM_06845 - [CS] API send email&sms success when system send valid order id [success][EN]
    [Tags]   TC_ITMWM_06845   regression   ready   ITMMZ-1526   X-Support-2016S19
    PCMS API Send Email SMS - Call Api Resend Thank You            ${Order_CS_Success_EN}
    Should Be Equal        ${var_send_msg_tracking_code}           200
    Should Contain         ${var_send_msg_tracking_message}        200 OK

TC_ITMWM_06846 - [COD] API send email&sms success when system send valid order id [success][EN]
    [Tags]   TC_ITMWM_06846   regression   ready   ITMMZ-1526   X-Support-2016S19
    PCMS API Send Email SMS - Call Api Resend Thank You            ${Order_COD_Success_EN}
    Should Be Equal        ${var_send_msg_tracking_code}           200
    Should Contain         ${var_send_msg_tracking_message}        200 OK

TC_ITMWM_06849 - [CCW] API send email&sms success when system send valid order id [failed][TH]
    [Tags]   TC_ITMWM_06849   regression   ready   ITMMZ-1526   X-Support-2016S19
    PCMS API Send Email SMS - Call Api Resend Thank You            ${Order_CCW_Failed_TH}
    Should Be Equal        ${var_send_msg_tracking_code}           200
    Should Contain         ${var_send_msg_tracking_message}        200 OK

TC_ITMWM_06850 - [Installment] API send email&sms success when system send valid order id [failed][TH]
    [Tags]   TC_ITMWM_06850   regression   ready   ITMMZ-1526   X-Support-2016S19
    PCMS API Send Email SMS - Call Api Resend Thank You            ${Order_Installment_Failed_TH}
    Should Be Equal        ${var_send_msg_tracking_code}           200
    Should Contain         ${var_send_msg_tracking_message}        200 OK

TC_ITMWM_06852 - [CCW] API send email&sms success when system send valid order id [failed][EN]
    [Tags]   TC_ITMWM_06852   regression   ready   ITMMZ-1526   X-Support-2016S19
    PCMS API Send Email SMS - Call Api Resend Thank You            ${Order_CCW_Failed_EN}
    Should Be Equal        ${var_send_msg_tracking_code}           200
    Should Contain         ${var_send_msg_tracking_message}        200 OK

TC_ITMWM_06853 - [Installment] API send email&sms success when system send valid order id [failed][EN]
    [Tags]   TC_ITMWM_06853   regression   ready   ITMMZ-1526   X-Support-2016S19
    PCMS API Send Email SMS - Call Api Resend Thank You            ${Order_Installment_Failed_EN}
    Should Be Equal        ${var_send_msg_tracking_code}           200
    Should Contain         ${var_send_msg_tracking_message}        200 OK

TC_ITMWM_06854 - API return error response message when system does not send value of order_id node
    [Tags]   TC_ITMWM_06854   regression   ready   ITMMZ-1526   X-Support-2016S19
    PCMS API Send Email SMS - Call Api Resend Thank You            ${EMPTY}
    Should Be Equal        ${var_send_msg_tracking_code}           400
    Should Contain         ${var_send_msg_tracking_message}        Order Id is required field.

TC_ITMWM_06855 - API return error response message when system does not send value of order_id = null
    [Tags]   TC_ITMWM_06855   regression   ready   ITMMZ-1526   X-Support-2016S19
    PCMS API Send Email SMS - Call Api Resend Thank You            null
    Should Be Equal        ${var_send_msg_tracking_code}           400
    Should Contain         ${var_send_msg_tracking_message}        Order Id is invalid.

TC_ITMWM_06856 - API return error response message when system send invalid order_id node
    [Tags]   TC_ITMWM_06856   regression   ready   ITMMZ-1526   X-Support-2016S19
    PCMS API Send Email SMS - Call Api Resend Thank You            PCMS100041054
    Should Be Equal        ${var_send_msg_tracking_code}           400
    Should Contain         ${var_send_msg_tracking_message}        Order Id is invalid.

TC_ITMWM_06857 - API return error response message when system send space with order_id node
    [Tags]   TC_ITMWM_06857   regression   ready   ITMMZ-1526   X-Support-2016S19
    PCMS API Send Email SMS - Call Api Resend Thank You            1000%2041054
    Should Be Equal        ${var_send_msg_tracking_code}           400
    Should Contain         ${var_send_msg_tracking_message}        Order Id is invalid.