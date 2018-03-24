*** Settings ***
Library           Selenium2Library
Library           String
Resource          ../../../../Resource/Env_config.robot
Resource          ../../../Common/Keywords_Common.robot
Resource          WebElement_CartPopUp.robot

*** Variables ***

*** Keywords ***
Assert Add cart fail
    [Arguments]    ${expect_message}=เราพบข้อผิดพลาดในการแสดงข้อมูลสินค้ารายการนี้ กรุณากลับเข้ามาใหม่ภายหลังค่ะ
    Wait Until Element Is Visible    ${Cart_Popup_Header}    15
    ${message}    Get Text    ${Cart_Popup_Header}
    Should Be Equal    ${message}    ไม่สามารถเพิ่มสินค้าได้
    ${message}    Get Text    ${Cart_Popup_message}
    Should Be Equal    ${message}    ${expect_message}

Close add cart pop up
    Wait Until Element is ready and click    ${Cart_Popup_Close_Button}    30
    Wait Until Element Is Not Visible    ${Cart_Popup_Close_Button}
