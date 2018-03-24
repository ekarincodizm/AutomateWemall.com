*** Settings ***
Library           Selenium2Library
Library           String
Library           DatabaseLibrary
Resource          ../../../Common/Keywords_Common.robot
Resource          WebElement_Campaign.robot
Resource          ../../../../Resource/Config/${env}/env_config.robot

*** Variables ***

*** Keywords ***
Camp - Fill Data to Create Campaign
    [Arguments]    ${Text_CampaignName}    ${Text_Detail}    ${Text_Note}
    Go To    ${PCMS_URL}/campaigns/create
    Wait Until Element Is Visible    ${Camp_activate}    20s
    Input Text    ${Camp_Input_CampaignName}    ${Text_CampaignName}
    Input Detail    ${Text_Detail}
    Input Text    ${Camp_Input_note}    ${Text_Note}
    Click Element    ${Camp_start_datepicker}
    Focus    ${Camp_Datepicker_Done}
    Click Element    ${Camp_Datepicker_Done}
    Click Element    ${Camp_end_datepicker}
    Click Element    ${Camp_Next_datepicker}
    Focus    ${Camp_Date_datepicker}
    Click Element    ${Camp_Date_datepicker}
    Focus    ${Camp_Datepicker_Done}
    Click Element    ${Camp_Datepicker_Done}
    Click Element    ${Camp_activate}

Camp - Save Campaign
    Wait Until Element is ready and click    ${Camp_Save}    20s

Camp - Filter and select Campaing in Campaign list
    [Arguments]    ${Text_CampaignName}
    Wait Until Element is ready and type    ${Camp_Filter}    ${Text_CampaignName}    60s
    ${element_Table_CampaignName}=    Replace String    ${Camp_Table_Selected_Campaign}    REPLACE_ME    ${Text_CampaignName}
    Wait Until Element Is Visible    ${element_Table_CampaignName}    20s
    Click Element    ${element_Table_CampaignName}

Input Detail
    [Arguments]    ${text}
    Execute JavaScript    CKEDITOR.instances["detail"].setData("${text}")
