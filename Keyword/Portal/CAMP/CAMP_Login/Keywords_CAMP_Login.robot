*** Settings ***
Library           Selenium2Library

*** Keywords ***
Go To Camp CMS
    [Arguments]    ${Text_UserName}    ${Text_Password}
    Open Browser    http://merchant.itruemart-dev.com/    chrome
    Input Text    //*[@id="login-username"]    ${Text_UserName}
    Input Text    //*[@id="login-password"]    ${Text_Password}
    Click Element    //*[@id="btn-login"]
    Wait Until Element Is Visible    //*[@id="MERCHANT_CENTER_MENUS"]    60s
    Click Element    //*[@id="MERCHANT_CENTER_MENUS"]//a[contains(text(),'Promotion')]
    Wait Until Element Is Visible    //*[@id="submitBtn"]
    Click Element    //*[@id="submitBtn"]
