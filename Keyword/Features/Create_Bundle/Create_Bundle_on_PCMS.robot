*** Setting ***
Library           Selenium2Library
Library           Collections
Library           RequestsLibrary
Resource          ../../../Resource/Env_config.robot
Resource          ../../../Keyword/Common/Keywords_Common.robot
Resource          ../../../Keyword/Portal/PCMS/Manage_Proposition/Keywords_Manage_Proposition.robot
Resource          ../../../Keyword/Portal/PCMS/Group_Proposition_Management/Keywords__GroupProposition.robot
Resource          ../../../Keyword/Portal/PCMS/Manage_Price_Plan/Keywords_Manage_PricePlan.robot
Resource          ../../../Keyword/Portal/PCMS/Manage_Proposition/Keywords_Manage_Proposition.robot
Resource          ../../../Keyword/Portal/PCMS/Mapping_Product_Device_and_Group_Proposition/Keywords_Mapping_ProductAndGroupProposition.robot
Resource          ../../../Keyword/Database/PCMS/keyword_pcms.robot
Resource          ../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ../../Portal/PCMS/Manage_Proposition/Keywords_Manage_Proposition.robot
Resource          ../../Portal/PCMS/Group_Proposition_Management/Keywords__GroupProposition.robot
Resource          ../../Portal/PCMS/Mapping_Product_Device_and_Group_Proposition/Keywords_Mapping_ProductAndGroupProposition.robot

*** Keywords ***
Create Price Plan
    [Arguments]    ${Text_PricePlanName}    ${Text_PricePlanCode}    ${Text_PricePlanShortDesc}    ${Text_PricePlanlongDesc}
    PricePlan - Go To Manage Price Plan
    PricePlan - Click To Create Price Plan
    PricePlan - Apply Create Price Plan    ${Text_PricePlanName}    ${Text_PricePlanCode}    ${Text_PricePlanShortDesc}    ${Text_PricePlanlongDesc}
    PricePlan - Assert Price Plan    ${Text_PricePlanName}

Create Proposition
    [Arguments]    ${Text_PropositionName}    ${Text_SubPropositionName}    ${Text_SubPropositionCode}    ${Text_SubPropositionNASCode}    ${Text_SubPropositionMonth}    ${Text_SubPropositionPenalty}
    ...    ${Text_SubPropositionShortDesc}    ${Text_SubPropositionLongDesc}    ${Text_PricePlanName}    ${Text_PricePlanCode}
    Proposition - Go To Manage Proposition
    Proposition - Select Proposition and click Sub Proposition    ${Text_PropositionName}
    Proposition - Create New Sub proposition
    Proposition - Apply Create Sub Proposition    ${Text_SubPropositionName}    ${Text_SubPropositionCode}    ${Text_SubPropositionNASCode}    ${Text_SubPropositionMonth}    ${Text_SubPropositionPenalty}    ${Text_SubPropositionShortDesc}
    ...    ${Text_SubPropositionLongDesc}
    Proposition - Filter Sub Proposition    ${Text_SubPropositionName}
    Proposition - Select Sub Proposition and click Price Plan    ${Text_SubPropositionName}
    Proposition - Map Proposition and Price plan    ${Text_PricePlanName}    ${Text_PricePlanCode}

Create Group Proposition
    [Arguments]    ${Text_GroupPropositionName}    ${Text_GroupPropositionDesc}    ${Text_SubPropositionName}
    GroupProposition - Go to Group Proposition
    GroupProposition - Click to Create New Group Proposition
    GroupProposition - Apply Create Group Proposition    ${Text_GroupPropositionName}    ${Text_GroupPropositionDesc}
    GroupProposition - Filter Group Name    ${Text_GroupPropositionName}
    GroupProposition - Select Group Proposition and click proposition to MAP    ${Text_GroupPropositionName}
    GroupProposition - Map Group Proposition and Propositoon    ${Text_SubPropositionName}

Mapping Product Device and Group Proposition
    [Arguments]    ${Text_DeviceName}    ${Text_GroupPropositionName}
    MappingProductAndGroup - Go To Mapping Product And Group
    MappingProductAndGroup - Click to Create New Mapping
    MappingProductAndGroup - Search And Mapping Product    ${Text_DeviceName}    ${Text_GroupPropositionName}
