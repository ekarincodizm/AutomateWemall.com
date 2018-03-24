*** Settings ***
Library           Selenium2Library
Resource          WebElement__GroupProposition.robot
Library           String
Resource          ../../../../Resource/Config/${env}/env_config.robot

*** Keywords ***
GroupProposition - Go to Group Proposition
    Go To    ${PCMS_URL}/truemoveh/proposition-group
    Wait Until Element Is Visible    ${Input_PropositionGroupName}    60s

GroupProposition - Click to Create New Group Proposition
    Wait Until Element Is Visible    ${Btn_CreateNewGroupProposition}    60s
    Click Element    ${Btn_CreateNewGroupProposition}

GroupProposition - Apply Create Group Proposition
    [Arguments]    ${Text_GroupPropositionName}    ${Text_GroupPropositionDesc}
    Wait Until Element Is Visible    ${Input_GroupPropositionName}    60s
    Input Text    ${Input_GroupPropositionName}    ${Text_GroupPropositionName}
    Input Text    ${Input_GroupPropositionDesc}    ${Text_GroupPropositionDesc}
    Click Element    ${Btn_CreateGroupProposition}

GroupProposition - Filter Group Name
    [Arguments]    ${Text_GroupPropositionName}
    Wait Until Element Is Visible    ${Input_PropositionGroupName}    60s
    Input Text    ${Input_PropositionGroupName}    ${Text_GroupPropositionName}
    Click Element    ${Btn_Search}

GroupProposition - Select Group Proposition and click proposition to MAP
    [Arguments]    ${Text_GroupPropositionName}
    ${element_Table_Group_Proposition}=    Replace String    ${Link_ProrositionMap}    REPLACE_ME    ${Text_GroupPropositionName}
    Wait Until Element Is Visible    ${element_Table_Group_Proposition}    60s
    Click Element    ${element_Table_Group_Proposition}

GroupProposition - Map Group Proposition and Propositoon
    [Arguments]    ${Text_SubPropositionName}
    Wait Until Element Is Visible    ${Btn_Save}
    Select From List    ${List_Proposition}    ${Text_SubPropositionName}
    Click Element    ${Btn_Select}
    ${element_Selected}=    Replace String    ${Assert_PropositionMap}    REPLACE_ME    ${Text_SubPropositionName}
    Wait Until Element Is Visible    ${element_Selected}    60s
    Click Element    ${Btn_Save}
