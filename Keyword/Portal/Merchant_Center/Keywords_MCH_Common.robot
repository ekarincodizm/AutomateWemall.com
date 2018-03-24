*** Settings ***
Resource    WebElement_MCH_Common.robot

*** Keywords ***
MCH Common - Open Merchant Center Page And Login
    [Arguments]    ${username}=test    ${password}=password
    Open Browser    ${MERCHANT_CENTER_URL}    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    ${login_button}    15s
    Input Text    ${username_field}       ${username}
    Input Password    ${password_field}       ${password}
    Click Element    ${login_button}

MCH Common - Go To Merchant Center Report Page
    [Arguments]    ${wait_time}=20
    # Go To    ${MERCHANT_REPORT_URL}
    Wait Until Page Contains Element     //*[@id="MERCHANT_CENTER_MENU_6"]/a[contains(., 'Report')]    ${wait_time}
    Click Element    //*[@id="MERCHANT_CENTER_MENU_6"]/a[contains(., 'Report')]
    Sleep    1s
    Click Element    //*[@id="MERCHANT_CENTER_SUB_MENU_7"]/a[contains(., 'Merchant Report')]
    Sleep    1s
    Wait Until Element Contains    ${header_title}    Merchant Report    ${wait_time}

MCH Common - Upload stock menu is visible
    Element Should Be Visible    ${mass_upload_virtual_stock_menu}
