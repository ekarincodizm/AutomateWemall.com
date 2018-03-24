*** Settings ***
Library           Selenium2Library
Library           String
Library           DatabaseLibrary
Resource          ../../../Resource/WebElement/PC1_And_PC3/PCMS.robot
Library           RequestsLibrary
Resource          ../../Portal/PCMS/Campaign/Keywords_Campaign.robot
Resource          ../../Portal/PCMS/Promotion/Keywords_Promotion.robot

*** Keywords ***
Go to PCMS
    Open Browser    http://pcms.itruemart-dev.com/campaigns/create    chrome
    Input Text    ${Login_Email}    devitm@itruemart.com
    Input Text    ${Login_Password}    1234567
    Click Element    ${Login_Button}

Go To Create Campaign page and Create Campaign
    [Arguments]    ${Text_CampaignName}    ${Text_Detail}    ${Text_Note}
    Camp - Fill Data to Create Campaign    ${Text_CampaignName}    ${Text_Detail}    ${Text_Note}
    Camp - Save Campaign
    Camp - Filter and select Campaing in Campaign list    ${Text_CampaignName}

Go To Create Promotion page and Create Promotion with Single Code and PC1
    [Arguments]    ${Text_PromotionName}    ${Text_PromotionCode}    ${Text_Detail}    ${Text_Note}    ${Text_DiscountBath}    ${Text_SingleCode}
    ...    ${Text_Prefix}
    Comment    Comment    Go To    http://pcms-report.itruemart-dev.com/promotions/350
    Sleep    5s
    Promotion - Fill Data to Create Promotion    ${Text_PromotionName}    ${Text_PromotionCode}    ${Text_Detail}    ${Text_Note}    ${Text_DiscountBath}
    Promotion - Select Unlimited Single Code to Create Promotion    ${Text_SingleCode}    ${Text_Prefix}
    Promotion - Select PC1 to Create Promotion
    Promotion - Save Promotion

Go To Create Promotion page and Create Promotion with Single Code and PC3
    [Arguments]    ${Text_PromotionName}    ${Text_PromotionCode}    ${Text_Detail}    ${Text_Note}    ${Text_DiscountBath}    ${Text_SingleCode}
    ...    ${Text_Prefix}
    Sleep    5s
    Promotion - Fill Data to Create Promotion    ${Text_PromotionName}    ${Text_PromotionCode}    ${Text_Detail}    ${Text_Note}    ${Text_DiscountBath}
    Promotion - Select Unlimited Single Code to Create Promotion    ${Text_SingleCode}    ${Text_Prefix}
    Promotion - Select PC3 to Create Promotion
    Promotion - Save Promotion

Go To Create Promotion page and Create Promotion with Unique Code and PC1
    [Arguments]    ${Text_PromotionName}    ${Text_PromotionCode}    ${Text_Detail}    ${Text_Note}    ${Text_DiscountBath}    ${Text_SingleCode}
    ...    ${Text_Prefix}
    Sleep    5s
    Promotion - Fill Data to Create Promotion    ${Text_PromotionName}    ${Text_PromotionCode}    ${Text_Detail}    ${Text_Note}    ${Text_DiscountBath}
    Promotion - Select Unique Code to Create Promotion    ${Text_SingleCode}    ${Text_Prefix}
    Promotion - Select PC1 to Create Promotion
    Promotion - Save Promotion

Go To Create Promotion page and Create Promotion with Unique Code and PC3
    [Arguments]    ${Text_PromotionName}    ${Text_PromotionCode}    ${Text_Detail}    ${Text_Note}    ${Text_DiscountBath}    ${Text_SingleCode}
    ...    ${Text_Prefix}
    Sleep    5s
    Promotion - Fill Data to Create Promotion    ${Text_PromotionName}    ${Text_PromotionCode}    ${Text_Detail}    ${Text_Note}    ${Text_DiscountBath}
    Promotion - Select Unique Code to Create Promotion    ${Text_SingleCode}    ${Text_Prefix}
    Promotion - Select PC3 to Create Promotion
    Promotion - Save Promotion

Go To Create Promotion page and Create Promotion with VIP Code and PC3
    [Arguments]    ${Text_PromotionName}    ${Text_PromotionCode}    ${Text_Detail}    ${Text_Note}    ${Text_DiscountBath}    ${Text_SingleCode}
    ...    ${Text_Prefix}
    Sleep    5s
    Promotion - Fill Data to Create Promotion    ${Text_PromotionName}    ${Text_PromotionCode}    ${Text_Detail}    ${Text_Note}    ${Text_DiscountBath}
    Promotion - Select Limited VIP Code to Create Promotion    ${Text_SingleCode}    ${Text_Prefix}
    Promotion - Select PC3 to Create Promotion
    Promotion - Save Promotion
    Promotion - Upload VIP excel file

Create Campaign and promotion discount code
    [Arguments]    ${Text_CampaignName}    ${Text_Detail}    ${Text_Note}    ${Text_PromotionName}    ${Text_PromotionCode}    ${Text_DiscountBath}
    ...    ${Text_SingleCode}    ${Text_Prefix}
    Login Pcms    ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    Go To Create Campaign page and Create Campaign    ${Text_CampaignName}    ${Text_Detail}    ${Text_Note}
    Go To Create Promotion page and Create Promotion with Single Code and PC1    ${Text_PromotionName}    ${Text_PromotionCode}    ${Text_Detail}    ${Text_Note}    ${Text_DiscountBath}    ${Text_SingleCode}
    ...    ${Text_Prefix}
    ${validate_CouponCode}    Verify Counpon Code    ${Text_PromotionName}
    Return From Keyword    ${validate_CouponCode}
