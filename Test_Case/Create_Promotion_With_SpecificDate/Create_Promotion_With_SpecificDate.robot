*** Settings ***
Test Teardown     Close Browser
Resource          ${CURDIR}/../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Log-in/Keywords_LoginPage.robot
Resource          ${CURDIR}/../../Resource/Config/Storm/Env_config.robot
Resource          ${CURDIR}/../../Resource/Config/Storm/database.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Cart_Light_Box/Keywords_CartLightBox.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Mini Cart/Keywords_MiniCart.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Cart_Pop_Up/Keywords_CartPopUp.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/User_Information_Page/Keywords_UserInformationPage.robot
Resource          ../../Keyword/Features/User_login/User_login.robot
Resource          ../../Keyword/Features/PC1_And_PC3/PCMS.robot
Resource          ../../Keyword/Features/PC1_And_PC3/ITM.robot
Resource          ../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ../../Keyword/Features/Sanity_test/Keywords_Sanity_Production.robot
Resource          ../../Keyword/API/CAMP_API/keyword_camp.txt
Resource          ../../Keyword/Features/Create_Promotion/Create_Promotion.robot

*** Variables ***
${Product_Pkey}    2613442373522
${Product_Pkey2}    2653599985921
${Text_ProductName}    เลนส์ เทเลซูม 12X iPhone 4/4S
${Text_EmptyCart}    ไม่พบสินค้าในตะกร้า
${Text_ProductName2}    เลนส์ เทเลซูม 12X Samsung Galaxsy S3
${VariantName}    iPhone
${BrandName}    @home

*** Test Cases ***
TEMPX
    [TAGS]    ready    specific    TEMPX
    ${Epoch}=    Get current epoch time
    ${EpochShort}=    Get current epoch time short
    ${CampaignName_Text}    Set Variable    THNS_${Epoch}
    ${PromotionName_Text}    Set Variable    THNS_${Epoch}
    ${PromotionCode_Text}    Set Variable    WMSTORM140
    ${Detail_Text}    Set Variable    Thanos Detail
    ${Note_Text}    Set Variable    Thanos Note
    ${CodeCanBeUseTime_Text}    Set Variable    ${EpochShort}
    ${Prefix_Text}    Set Variable    THNS
    ${DiscountBath_Text}    Set Variable    140
    ${SpecificStartTime_Text}    Set Variable    12:00
    ${SpecificEndTime_Text}    Set Variable    13:00

    #.. Generate Specific CSV file to be uploaded
    ${CurrentDate}=    Get Current Date    result_format=%Y-%m-%d
    @{SpecificDateDataName}=       Create List     Specific Date
    @{SpecificDateDataValue1}=     Create List     ${CurrentDate}
    @{SpecificDate_Datas}=            Create List     ${SpecificDateDataName}    ${SpecificDateDataValue1}

    Login Pcms
    Go To Create Campaign page and Create Campaign    ${CampaignName_Text}    ${Detail_Text}    ${Note_Text}
    TestFeature    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}    ${CodeCanBeUseTime_Text}    ${Prefix_Text}    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}    ${SpecificDate_Datas}    ${Text_ProductName}