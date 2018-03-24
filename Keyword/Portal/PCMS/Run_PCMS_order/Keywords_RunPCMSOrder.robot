*** Settings ***
Library           Selenium2Library
Library           String
Library           DatabaseLibrary
Resource          ../../../Common/Keywords_Common.robot
Resource          WebElement_RunPCMSOrder.robot

*** Keywords ***
Go to run pcms order page
    [Arguments]    ${PCMS_URL}=http://pcms.itruemart-dev.com
    Go To    ${PCMS_URL}/ordertogether/run-pcms-order
    Wait Until Element is ready and click    ${Run_Order_Process}    60
    Wait Until Element Is Visible    ${Order_Content}    100s

Run PCMS Order
    Go To    ${PCMS_URL}/ordertogether/run-pcms-order
    Wait Until Element is ready and click    ${Run_Order_Process}    60s
    Wait Until Element Is Visible    ${Order_Content}    100s
