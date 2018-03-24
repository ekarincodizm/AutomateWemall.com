*** Settings ***
Library           Selenium2Library
Resource          WebElement_Manage_PricePlan.robot
Resource          ../../../../Resource/Config/${env}/env_config.robot

*** Keywords ***
PricePlan - Go To Manage Price Plan
    Go To    ${PCMS_URL}/truemoveh/price-plan
    Wait Until Element Is Visible    ${Filter_PricePlanName}    60s

PricePlan - Click To Create Price Plan
    Wait Until Element Is Visible    ${Create_NewPricePlan}    60s
    Click Element    ${Create_NewPricePlan}

PricePlan - Apply Create Price Plan
    [Arguments]    ${Text_PricePlanName}    ${Text_PricePlanCode}    ${Text_PricePlanShortDesc}    ${Text_PricePlanLongDesc}
    Wait Until Element Is Visible    ${Input_PricePlanName}    60s
    Input Text    ${Input_PricePlanName}    ${Text_PricePlanName}
    Input Text    ${Input_PricePlanCode}    ${Text_PricePlanCode}
    Input Text    ${Input_PricePlanShortDesc}    ${Text_PricePlanShortDesc}
    Keywords_Manage_PricePlan.Input Long Description    ${Text_PricePlanLongDesc}
    Click Element    ${Btn_CreatePricePlan}

PricePlan - Assert Price Plan
    [Arguments]    ${Text_PricePlanName}
    Wait Until Element Is Visible    ${Filter_PricePlanName}    60s
    Input Text    ${Filter_PricePlanName}    ${Text_PricePlanName}
    Click Element    ${Btn_SearchPricePlan}
    ${Assert_PricePlan}=    get text    ${Assert_PricePlanName}
    Should Be Equal    ${Assert_PricePlan}    ${Text_PricePlanName}

Input Long Description
    [Arguments]    ${text}
    Execute JavaScript    CKEDITOR.instances["txtLongdescription"].setData("${text}")
