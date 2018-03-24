*** Settings ***
Resource          WebElement_Manage_Proposition.robot
Library           Selenium2Library
Library           String
Resource          ../Manage_Price_Plan/Keywords_Manage_PricePlan.robot
Resource          ../../../../Resource/Config/${env}/env_config.robot

*** Keywords ***
Proposition - Go To Manage Proposition
    Go To    ${PCMS_URL}/truemoveh/proposition
    Wait Until Element Is Visible    ${Filter_PropositionName}

Proposition - Select Proposition and click Sub Proposition
    [Arguments]    ${Text_PropositionName}
    Wait Until Element Is Visible    ${Filter_PropositionName}    60s
    Input Text    ${Filter_PropositionName}    ${Text_PropositionName}
    Click Element    ${Btn_SearchProposition}
    ${element_Sub_Proposition}=    Replace String    //*[@id='tb-order']/tbody/tr[1]/td[2]/*[contains(text(),"REPLACE_ME")]/../../td[5]/a    REPLACE_ME    ${Text_PropositionName}
    Wait Until Element Is Visible    ${element_Sub_Proposition}    60s
    Click Element    ${element_Sub_Proposition}

Proposition - Create New Sub proposition
    Wait Until Element Is Visible    ${Create_NewSubProposition}    60s
    Click Element    ${Create_NewSubProposition}
    Wait Until Element Is Visible    ${Input_PropositionName}    60s

Proposition - Apply Create Sub Proposition
    [Arguments]    ${Text_SubPropositionName}    ${Text_SubPropositionCode}    ${Text_SubPropositionNASCode}    ${Text_SubPropositionMonth}    ${Text_SubPropositionPenalty}    ${Text_SubPropositionShortDesc}
    ...    ${Text_SubPropositionLongDesc}
    Wait Until Element Is Visible    ${Input_SubPropositionName}    60s
    Input Text    ${Input_SubPropositionName}    ${Text_SubPropositionName}
    Input Text    ${Input_SubPropositionCode}    ${Text_SubPropositionCode}
    Input Text    ${Input_SubPropositionNASCode}    ${Text_SubPropositionNASCode}
    Input Text    ${Input_SubPropositionMonth}    ${Text_SubPropositionMonth}
    Input Text    ${Input_SubPropositionPenalty}    ${Text_SubPropositionPenalty}
    Click Element    //*[@id="source_type_list"]
    Click Element    //*[@id="source_type_list"]/option[contains(text(),"BUNDLE")]
    Input Text    ${Input_SubPropositionShortDesc}    ${Text_SubPropositionShortDesc}
    Keywords_Manage_Proposition.Input Long Description    ${Text_SubPropositionLongDesc}
    Click Element    ${Btn_CreateSubProposition}

Proposition - Filter Sub Proposition
    [Arguments]    ${Text_SubPropositionName}
    Wait Until Element Is Visible    ${Filter_PropositionName}    60s
    Input Text    ${Filter_PropositionName}    ${Text_SubPropositionName}
    Click Element    ${Btn_SearchProposition}

Proposition - Select Sub Proposition and click Price Plan
    [Arguments]    ${Text_SubPropositionName}
    ${element_Table_Sub_Proposition}=    Replace String    //*[@id='tb-order']/tbody/tr[1]/td[2]/*[contains(text(),"REPLACE_ME")]/../../td[4]/a    REPLACE_ME    ${Text_SubPropositionName}
    Wait Until Element Is Visible    ${element_Table_Sub_Proposition}    60s
    Click Element    ${element_Table_Sub_Proposition}

Proposition - Map Proposition and Price plan
    [Arguments]    ${Text_PricePlanName}    ${Text_PricePlanCode}
    Wait Until Element Is Visible    ${Btn_Save}
    Select From List    ${List_PricePlan}    ${Text_PricePlanName} : ${Text_PricePlanCode}
    Click Element    ${Btn_Map}
    ${element_Selected}=    Replace String    ${Assert_PricePlan}    REPLACE_ME    ${Text_PricePlanName}
    Wait Until Element Is Visible    ${element_Selected}    60s
    Click Element    ${Btn_Save}

Input Long Description
    [Arguments]    ${text}
    Execute JavaScript    CKEDITOR.instances["txtLong"].setData("${text}")
