*** Settings ***
Library    Collections
Library    HttpLibrary.HTTP
Library    ${CURDIR}/../../../../Python_Library/message_library.py
Library    ${CURDIR}/../../../../Python_Library/variant_library.py

Resource   ../../../../Resource/Config/${env}/env_config.robot
Resource   web_element_test_mail_form_order.robot

*** Keywords ***
Check Mail Form Order - Open Web Site For Check
    [Arguments]     ${order_id}
    Login Pcms
    Go To    ${PCMS_URL}/test/testmailfromorder
    Input Text    name=orderid    ${var_mail_sms_order_id}
    Click Element   //input[@type="submit"]
#    Log To Console      Order_id:${order_id}
