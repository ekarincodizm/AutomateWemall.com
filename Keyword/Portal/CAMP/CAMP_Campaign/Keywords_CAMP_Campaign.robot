*** Settings ***
Library           Selenium2Library
Resource          ../../../Common/Keywords_Common.robot

*** Keywords ***
Campaign - Create Campaign
    [Arguments]    ${Text_CampaignName}    ${Text_CampaignDetail}    ${Text_CampaignStart}    ${Text_CampaignEnd}
    : FOR    ${INDEX}    IN RANGE    0    6
    \    ${isCampSidebarVisible}    Run Keyword And Return Status    Wait Until Element Is Visible    //*[@id="/itm/create-campaignSidebar"]/span/span[2]    5
    \    Run Keyword If    ${isCampSidebarVisible}==False    Click Element    //*[@id="submitBtn"]
    \    Exit For Loop If    ${isCampSidebarVisible}==True
    Click Element    //*[@id="/itm/create-campaignSidebar"]/span/span[2]
    Input Text    //*[@id="nameLocal"]    ${Text_CampaignName}
    Input Text    //*[@id="detail"]    ${Text_CampaignDetail}
    Click Element    //*[@id="enabled"]
    Click Element    //*[@id="period"]
    Input Text    //*[@id="createCampaignTemplate"]/div[9]/div[1]/div[1]/input    ${Text_CampaignStart}
    Input Text    //*[@id="createCampaignTemplate"]/div[9]/div[2]/div[1]/input    ${Text_CampaignEnd}
    Click Element    //*[@id="createCampaignTemplate"]/div[9]/div[3]/div/button[1]
    Click Element    //*[@id="submitBtn"]
    ${Confirm_popup}    Run Keyword And Return Status    Element Should Be Visible    //*[@id="modalConfirmBtn"][contains(text(),"Confirm")]
    Run Keyword If    ${Confirm_popup}    Confirm to use existed campaign

Campaign - Select Campaign for create Promotion
    [Arguments]    ${Text_CampaignName}
    ${element_Table_CampaignName}=    Replace String    //*[contains(@class,'table table-hover')]//tbody//tr/td[4][contains(text(),'REPLACE_ME')]/../td[9]/div    REPLACE_ME    ${Text_CampaignName}
    Wait Until Element Is Visible    ${element_Table_CampaignName}    20s
    ${element_Table_CampaignID}=    Replace String    //*[contains(@class,'table table-hover')]//tbody//tr/td[4][contains(text(),'REPLACE_ME')]/../td[3]    REPLACE_ME    ${Text_CampaignName}
    ${campaign_id}    Get Text    ${element_Table_CampaignID}
    Click Element    ${element_Table_CampaignName}
    [Return]    ${campaign_id}

Confirm to use existed campaign
    Wait Until Element is ready and click    //*[@id="modalConfirmBtn"][contains(text(),"Confirm")]    60s
