*** Settings ***
Resource          ../../Keyword/Features/PC1_And_PC3/PCMS.robot
Resource          ../../Keyword/Common/Keywords_Common.robot
Resource          ../../Keyword/Features/PC1_And_PC3/ITM.robot
Resource          ../../Keyword/Portal/PCMS/Run_PCMS_order/Keywords_RunPCMSOrder.robot
Resource          ../../Keyword/Portal/PCMS/Receipt/Keywords_Receipts.robot
Resource          ../../Keyword/Portal/CAMP/CAMP_common/Keywords_CAMP_Common.robot
Resource          ../../Keyword/API/CAMP_API/keyword_camp.txt
Resource          ../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ../../Resource/init.robot

*** Testcases ***
TC_ITMWME2E_00177 - PC1-single code and effect on cart
    [Tags]    QCT    TEST_TAG
    ${epoch}=    Get current epoch time
    ${epoch_short}=    Get current epoch time short
    ${Text_CampaignName}    Set Variable    E2E_${epoch}
    ${Text_PromotionName}    Set Variable    E2E_${epoch}
    ${Text_PromotionCode}    Set Variable    ffsa
    ${Text_Detail}    Set Variable    test
    ${Text_Note}    Set Variable    test
    ${Text_SingleCode}    Set Variable    1
    ${Text_DiscountBath}    Set Variable    19
    ${Text_Prefix}    Set Variable    ${epoch_short}
    ${Text_Email}    Set Variable    e2e@gmail.com
    ${Text_Name}    Set Variable    e2e_test
    ${Text_Phone}    Set Variable    0911111111
    ${Text_Address}    Set Variable    test e2e
    ${Text_CWName}    Set Variable    test
    ${Text_CWCardNo}    Set Variable    5555555555554444
    ${Text_CWCCV}    Set Variable    123
    ${Text_Code}    Set Variable    111
    ${sap_material_code}    Set Variable    1234
    ${material_id}    Set Variable    1234
    ${Text_ProductName}    Set Variable    2413293614891
    ${variance}    Set Variable    1
    ${size}    Set Variable    ${EMPTY}
    ${inventory_id}    Set Variable    ELAAC1112611
    Stock - Increase Stock By Inventory Id    ${inventory_id}
    Login Pcms
    Go To Create Campaign page and Create Campaign    ${Text_CampaignName}    ${Text_Detail}    ${Text_Note}
    Go To Create Promotion page and Create Promotion with Single Code and PC1    ${Text_PromotionName}    ${Text_PromotionCode}    ${Text_Detail}    ${Text_Note}    ${Text_DiscountBath}    ${Text_SingleCode}
    ...    ${Text_Prefix}
    ${validate_CouponCode}    Verify Counpon Code    ${Text_PromotionName}
    ${Order_Id&Sale_ID}=    Purchase Item and Verify PC1    ${Text_PromotionName}    ${Text_Email}    ${Text_Name}    ${Text_Phone}    ${Text_Address}
    ...    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}    ${Text_ProductName}    ${validate_CouponCode}    ${variance}
    ${Order_Id}=    Get From List    ${Order_Id&Sale_ID}    0
    ${Sale_Id}=    Get From List    ${Order_Id&Sale_ID}    1
    Verify PC1    ${Order_Id}
    Change status to Picked and Packed with Order ID    ${Order_Id}    ${Sale_Id}    ${sap_material_code}    ${material_id}
    Change status to shipped with Order ID    ${Order_Id}    ${Sale_Id}    ${sap_material_code}    ${material_id}
    Run PCMS Order
    Receipt - Verify Receipt    ${Order_Id}
    [Teardown]    Run Keywords    close browser
    ...    AND    Delete Campaign by campaign name    ${Text_CampaignName}

TC_ITMWME2E_00180 - PC3-unique code and effect on cart
    [Tags]    QCT
    ${epoch}=    Get current epoch time
    ${epoch_short}=    Get current epoch time short
    ${Text_CampaignName}    Set Variable    E2E_${epoch}
    ${Text_PromotionName}    Set Variable    E2E_${epoch}
    ${Text_PromotionCode}    Set Variable    ffsa
    ${Text_Detail}    Set Variable    test
    ${Text_Note}    Set Variable    test
    ${Text_SingleCode}    Set Variable    1
    ${Text_DiscountBath}    Set Variable    19
    ${Text_Prefix}    Set Variable    ${epoch_short}
    ${Text_Email}    Set Variable    e2e@gmail.com
    ${Text_Name}    Set Variable    e2e_test
    ${Text_Phone}    Set Variable    0911111111
    ${Text_Address}    Set Variable    test e2e
    ${Text_CWName}    Set Variable    test
    ${Text_CWCardNo}    Set Variable    5555555555554444
    ${Text_CWCCV}    Set Variable    123
    ${Text_Code}    Set Variable    111
    ${sap_material_code}    Set Variable    1234
    ${material_id}    Set Variable    1234
    ${Text_ProductName}    Set Variable    2413293614891
    ${variance}    Set Variable    1
    ${size}    Set Variable    ${EMPTY}
    ${inventory_id}    Set Variable    ELAAC1112611
    Stock - Increase Stock By Inventory Id    ${inventory_id}
    Login Pcms
    Go To Create Campaign page and Create Campaign    ${Text_CampaignName}    ${Text_Detail}    ${Text_Note}
    Go To Create Promotion page and Create Promotion with Unique Code and PC3    ${Text_PromotionName}    ${Text_PromotionCode}    ${Text_Detail}    ${Text_Note}    ${Text_DiscountBath}    ${Text_SingleCode}
    ...    ${Text_Prefix}
    ${validate_CouponCode}    Verify Counpon Code    ${Text_PromotionName}
    ${Order_Id&Sale_ID}=    Purchase Item and Verify PC3    ${Text_PromotionName}    ${Text_Email}    ${Text_Name}    ${Text_Phone}    ${Text_Address}
    ...    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}    ${Text_ProductName}    ${validate_CouponCode}    ${variance}
    ${Order_Id}=    Get From List    ${Order_Id&Sale_ID}    0
    ${Sale_Id}=    Get From List    ${Order_Id&Sale_ID}    1
    Verify PC3    ${Order_Id}
    Change status to Picked and Packed with Order ID    ${Order_Id}    ${Sale_Id}    ${sap_material_code}    ${material_id}
    Change status to shipped with Order ID    ${Order_Id}    ${Sale_Id}    ${sap_material_code}    ${material_id}
    Run PCMS Order
    Receipt - Verify Receipt    ${Order_Id}
    [Teardown]    Run Keywords    close browser
    ...    AND    Delete Campaign by campaign name    ${Text_CampaignName}

*** Keywords ***
Prepare Campaign
    Post New Stock Data for Variant    SAAAB1127511    137    TEST ROBOT
    ${status} =    Run Keyword And Return Status    Exist ITrueMart Test Campaign
    Run Keyword If    '${status}' == 'True'    Clear Campaign
    ${camp_id} =    Create iTrueMart Test Campaign    HULK_TEST_CAMP    ROBOT Test    2016-01-01 00:00:00    2017-01-01 00:00:00    activate
    Create Single Code PC1 on Variants Test ITrueMart Promotion With Price    ${camp_id}    PC1 ON VAR    robottest    2016-01-01 00:00:00    2017-01-01 00:00:00    activate
    Create Single Code PC1 on Cart Test ITrueMart Promotion With Price    ${camp_id}    PC1 ON CART    robottest    2016-01-01 00:00:00    2017-01-01 00:00:00    activate
    Create Single Code PC3 on Variants Test ITrueMart Promotion With Price    ${camp_id}    PC3 ON VAR    robottest    2016-01-01 00:00:00    2017-01-01 00:00:00    activate
    Create Single Code PC3 on Cart Test ITrueMart Promotion With Price    ${camp_id}    PC3 ON CART    robottest    2016-01-01 00:00:00    2017-01-01 00:00:00    activate
    Open Browser    http://${ENV}-www.itruemart-dev.com/products/samsung-galaxy-note-4--2664786660556.html    ${BROWSER}

Clear Campaign
    Delete All Test ITrueMart Promotion
    Delete iTrueMart Test Campaign
    Close Browser
