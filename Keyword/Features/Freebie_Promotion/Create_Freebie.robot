*** Settings ***
Library           Selenium2Library
Library           String
# Resource          ../../../Resource/Env_config.robot
Resource          ../../../Resource/WebElement/CAMP/Camp_Freebie.robot
Resource          ../../Common/Keywords_Common.robot
Resource          ../../../Resource/WebElement/CAMP/Promotion_List.robot
Resource          ${CURDIR}/../../../Resource/Config/${ENV}/env_config.robot

*** Keywords ***
Go To Camp CMS
    Open Browser    ${MC_URL}    chrome
    Maximize Browser Window
    sleep    2s
    Input Text    //*[@id="login-username"]    ${CAMP_USERNAME}
    Input Text    //*[@id="login-password"]    ${CAMP_PASSWORD}
    Click Element    //*[@id="btn-login"]
    Wait Until Element Is Visible    //*[@id="MERCHANT_CENTER_MENUS"]    60s
    Click Element    //*[@id="MERCHANT_CENTER_MENUS"]//a[contains(text(),'Promotion')]
    sleep    3s
    Wait Until Element Is Visible    //*[@id="submitBtn"]    60s
    Click Element    //*[@id="submitBtn"]

Create Campaign
    [Arguments]    ${Text_CampaignName}    ${Text_CampaignDetail}    ${Text_CampaignStart}    ${Text_CampaignEnd}
    : FOR    ${INDEX}    IN RANGE    0    6
    \    ${isCampSidebarVisible}    Run Keyword And Return Status    Wait Until Element Is Visible    //*[@id="/itm/create-campaignSidebar"]    5
    \    Run Keyword If    ${isCampSidebarVisible}==False    Click Element    //*[@id="submitBtn"]
    \    Exit For Loop If    ${isCampSidebarVisible}==True
    Click Element    //*[@id="/itm/create-campaignSidebar"]
    Input Text    //*[@id="nameLocal"]    ${Text_CampaignName}
    Input Text    //*[@id="detail"]    ${Text_CampaignDetail}
    Click Element    //*[@id="enabled"]
    Click Element    //*[@id="period"]
    Input Text    //*[@id="createCampaignTemplate"]/div[9]/div[1]/div[1]/input    ${Text_CampaignStart}
    Input Text    //*[@id="createCampaignTemplate"]/div[9]/div[2]/div[1]/input    ${Text_CampaignEnd}
    Click Element    //*[@id="createCampaignTemplate"]/div[9]/div[3]/div/button[1]
    Click Element    //*[@id="submitBtn"]
    ${element_Table_CampaignName}=    Replace String    ${Promotion_Button_By_Campaignname}    REPLACE_ME    ${Text_CampaignName}
    Wait Until Element Is Visible    ${element_Table_CampaignName}    20s
    ${element_Table_CampaignID}=    Replace String    ${Campaing_ID_By_Campaignname}    REPLACE_ME    ${Text_CampaignName}
    ${campaign_id}    Get Text    ${element_Table_CampaignID}
    Click Element    ${element_Table_CampaignName}
    [Return]    ${campaign_id}

Create Freebie Promotion
    [Arguments]    ${Text_FreebieName}    ${Text_FreebieShortDesc}    ${Text_FreebieDesc}    ${Text_FreebieStart}    ${Text_FreebieEnd}    ${Text_Freebie_CategoryType}
    ...    ${Text_Freebie_Identifyer}    ${Text_PeriTem}    ${Text_FreeVariantID}    ${Text_FreeVariantQuantity}    ${Text_RepeatTime}    ${Text_Note}
    ...    ${img_160x80}    ${img_220x110}    ${img_320x160}
    Wait Until Element Is Visible    //*[@id="createPromotionBtn"]/span    60s
    Click Element    //*[@id="createPromotionBtn"]/span
    Click Element    //*[@id="createBtn0"]
    Wait Until Element Is Visible    //*[@id="nameLocal"]    60s
    Input Text    //*[@id="nameLocal"]    ${Text_FreebieName}
    Input Text    //*[@id="shortDescriptionLocal"]    ${Text_FreebieShortDesc}
    Create_Freebie.Input Description    ${Text_FreebieDesc}
    Click Element    //*[@id="period"]
    Input Text    //*[@id="promotionTemplate"]/div[34]/div[1]/div[1]/input    ${Text_FreebieStart}
    Input Text    //*[@id="promotionTemplate"]/div[34]/div[2]/div[1]/input    ${Text_FreebieEnd}
    Click Element    //*[@id="promotionTemplate"]/div[34]/div[3]/div/button[1]
    Click Element    //*[@id="enabled"]
    Click Element    //*[@id="criteriaTypeSelect"]
    ${element_freebie_CriteriaType}    Replace String    ${freebie_CriteriaType}    REPLACE_ME    ${Text_Freebie_CategoryType}
    Click Element    ${element_freebie_CriteriaType}
    Input Text    //*[@id="criteriaValuesDiv"]/div/input    ${Text_Freebie_Identifyer}
    Input Text    //*[@id="minTotalQuantity"]    ${Text_PeriTem}
    Input Text    //*[@id="freeVariant1"]    ${Text_FreeVariantID}
    Input Text    //*[@id="freeVariantQuantity1"]    ${Text_FreeVariantQuantity}
    Input Text    //*[@id="repeat"]    ${Text_RepeatTime}
    Input Text    //*[@id="freebieNote"]    ${Text_Note}
    Choose File    //*[@id="lvCDropzoneDiv"]/div/input    ${Path-ImgFile}${img_160x80}
    Choose File    //*[@id="lvCMobileDropzoneDiv"]/div/input    ${Path-ImgFile}${img_220x110}
    Choose File    //*[@id="lvDDropzoneDiv"]/div/input    ${Path-ImgFile}${img_320x160}
    Choose File    //*[@id="lvDMobileDropzoneDiv"]/div/input    ${Path-ImgFile}${img_320x160}
    Click Element    //*[@id="submitBtn"]
    ${element_Table_PromotionName}=    Replace String    //*[contains(@id,'promotionListTable')]//tbody//tr/td[5][contains(text(),'REPLACE_ME')]/../td[11]/button[1]    REPLACE_ME    ${Text_FreebieName}
    Wait Until Element Is Visible    ${element_Table_PromotionName}    60s

Input Description
    [Arguments]    ${text}
    Execute JavaScript    CKEDITOR.instances["descriptionLocal"].setData("${text}")

Click build button
    Wait Until Element is ready and click    ${CAMP_Build_Button}    30
    Wait Until Element is ready and click    ${CAMP_Build_Confirm_Button}    120

Create Campaign and Create Promotion Freebie
    ${element1}=    Create Dictionary    freeVARIANT=@{VALID-VARIANT-FOR-FREEBIE}[1]    quantity=1
    @{free_variants_list}=    Create List    ${element1}
    Open Camps Browser
    Go To Campaign for iTruemart Home Page
    Go To Create Campaign Page
    ${name}=    Get First Word From Sentence    ${TEST_NAME}
    Keywords_CAMPS_Campaign.Create Campaign    ${name}    ${name}    ${name}    ${name}    default    0
    ...    00    default    0    00    enable
    ${g_camp_id}=    Get Campaign ID
    Set Suite Variable    ${g_camp_id}
    Create Promotion Freebie    ${name}    ${name}    ${VALID-PROMO-DESC}    ${VALID-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}    ${VALID-SHORT-PROMO-DESC}
    ...    default    0    00    ${EMPTY}    0    00
    ...    enable    both    Variant    @{VALID-VARIANT-FOR-FREEBIE}[0]    item    1
    ...    1    ${true}    ${VALID-FREEBIE-NOTE}    ${VALID-FREEBIE-NOTE}    OR    @{free_variants_list}
    ${is_dup_free}=    Run Keyword And Return Status    Wait Until Modal Page Is Visible    ${g_loading_delay_short}
    Run Keyword If    ${is_dup_free}    Confirm To Create or Update Promotion With Duplicated Freebie Criteria Variant
    Wait Until Page Contains Promotion List under Campaign Table
    ${g_promo_id}=    Get Promotion ID
    Promotion Name Should Be As Test Case Number
    Promotion Live Status Should Be Equal    LIVE
    Build Drools
    # Delete If Created Promotion and Close All Browsers    ${g_promo_id}
