*** Settings ***
Library           Selenium2Library
Library           String
Library           DatabaseLibrary
Resource          ../../../Resource/WebElement/PC1_And_PC3/PCMS.robot
Library           RequestsLibrary
Resource          ../../Portal/PCMS/Campaign/Keywords_Campaign.robot
Resource          ../../Portal/PCMS/Promotion/Keywords_Promotion.robot

*** Keywords ***

Go To Create Promotion page and Create Promotion with Single Code and PC1(Example)
    [Arguments]    ${Text_PromotionName}    ${Text_PromotionCode}    ${Text_Detail}    ${Text_Note}    ${Text_DiscountBath}    ${Text_SingleCode}
    ...    ${Text_Prefix}
    Comment    Comment    Go To    http://pcms-report.itruemart-dev.com/promotions/350
    Sleep    5s
    Promotion - Fill Data to Create Promotion    ${Text_PromotionName}    ${Text_PromotionCode}    ${Text_Detail}    ${Text_Note}    ${Text_DiscountBath}
    Promotion - Select Unlimited Single Code to Create Promotion    ${Text_SingleCode}    ${Text_Prefix}
    Promotion - Select PC1 to Create Promotion
    Promotion - Save Promotion

Go To Create Promotion page and Create Promotion with Single Code and PC3(Example)
    [Arguments]    ${Text_PromotionName}    ${Text_PromotionCode}    ${Text_Detail}    ${Text_Note}    ${Text_DiscountBath}    ${Text_SingleCode}
    ...    ${Text_Prefix}
    Sleep    5s
    Promotion - Fill Data to Create Promotion    ${Text_PromotionName}    ${Text_PromotionCode}    ${Text_Detail}    ${Text_Note}    ${Text_DiscountBath}
    Promotion - Select Unlimited Single Code to Create Promotion    ${Text_SingleCode}    ${Text_Prefix}
    Promotion - Select PC3 to Create Promotion
    Promotion - Save Promotion

Go To Create Promotion page and Create Promotion with Unique Code and PC1(Example)
    [Arguments]    ${Text_PromotionName}    ${Text_PromotionCode}    ${Text_Detail}    ${Text_Note}    ${Text_DiscountBath}    ${Text_SingleCode}
    ...    ${Text_Prefix}
    Sleep    5s
    Promotion - Fill Data to Create Promotion    ${Text_PromotionName}    ${Text_PromotionCode}    ${Text_Detail}    ${Text_Note}    ${Text_DiscountBath}
    Promotion - Select Unique Code to Create Promotion    ${Text_SingleCode}    ${Text_Prefix}
    Promotion - Select PC1 to Create Promotion
    Promotion - Save Promotion

Go To Create Promotion page and Create Promotion with Unique Code and PC3(Example)
    [Arguments]    ${Text_PromotionName}    ${Text_PromotionCode}    ${Text_Detail}    ${Text_Note}    ${Text_DiscountBath}    ${Text_SingleCode}
    ...    ${Text_Prefix}
    Sleep    5s
    Promotion - Fill Data to Create Promotion    ${Text_PromotionName}    ${Text_PromotionCode}    ${Text_Detail}    ${Text_Note}    ${Text_DiscountBath}
    Promotion - Select Unique Code to Create Promotion    ${Text_SingleCode}    ${Text_Prefix}
    Promotion - Select PC3 to Create Promotion
    Promotion - Save Promotion

Go To Create Promotion page and Create Promotion with VIP Code and PC3(Example)
    [Arguments]    ${Text_PromotionName}    ${Text_PromotionCode}    ${Text_Detail}    ${Text_Note}    ${Text_DiscountBath}    ${Text_SingleCode}
    ...    ${Text_Prefix}
    Sleep    5s
    Promotion - Fill Data to Create Promotion    ${Text_PromotionName}    ${Text_PromotionCode}    ${Text_Detail}    ${Text_Note}    ${Text_DiscountBath}
    Promotion - Select Limited VIP Code to Create Promotion    ${Text_SingleCode}    ${Text_Prefix}
    Promotion - Select PC3 to Create Promotion
    Promotion - Save Promotion
    Promotion - Upload VIP excel file

Go To Create Promotion page and Create Promotion with Single Code Till Selected Specificdate And Time Example
    [Arguments]    ${Text_PromotionName}    ${Text_PromotionCode}    ${Text_Detail}    ${Text_Note}    ${Text_DiscountBath}    ${Text_SingleCode}
    ...    ${Text_Prefix}    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}
    Sleep    5s
    Promotion - Fill Data to Create Promotion    ${Text_PromotionName}    ${Text_PromotionCode}    ${Text_Detail}    ${Text_Note}    ${Text_DiscountBath}
    Promotion - Select SpecificDate to Create Promotion
    Promotion - Fill SpecificTime to Create Promotion    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}
    Promotion - Create file for mass upload specific promotion
    Promotion - Select Unlimited Single Code to Create Promotion    100    THNS
    Promotion - Save Promotion

Go To Create Promotion Page And Create Specific Promotion With Unlimited VIP Code
    [Arguments]    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}    ${CodeCanBeUseTime_Text}
    ...    ${Prefix_Text}    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}    ${SpecificDate_Datas}
    Sleep    1s
    Promotion - Fill Data to Create Promotion    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}
    Promotion - Select Unlimited VIP Code to Create Promotion    ${CodeCanBeUseTime_Text}    ${Prefix_Text}
    Promotion - Select SpecificDate to Create Promotion
    Promotion - Fill SpecificTime to Create Promotion    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}
    ${SpecificDatePathFile}=    Promotion - Set Specific Promotion in CSV    ${SpecificDate_Datas}
    Promotion - Browse file for mass upload Specific Promotion    ${SpecificDatePathFile}

    Promotion - Save Promotion
    Promotion - Upload VIP E-mail With Excel

Go To Create Promotion Page And Create Specific Promotion With Limited VIP Code
    [Arguments]    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}    ${CodeCanBeUseTime_Text}
    ...    ${Prefix_Text}    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}    ${SpecificDate_Datas}
    Sleep    1s
    Promotion - Fill Data to Create Promotion    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}
    Promotion - Select Limited VIP Code to Create Promotion    ${CodeCanBeUseTime_Text}    ${Prefix_Text}
    Promotion - Select SpecificDate to Create Promotion
    Promotion - Fill SpecificTime to Create Promotion    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}
    ${SpecificDatePathFile}=    Promotion - Set Specific Promotion in CSV    ${SpecificDate_Datas}
    Promotion - Browse file for mass upload Specific Promotion    ${SpecificDatePathFile}
    Promotion - Save Promotion
    Promotion - Upload VIP E-mail With Excel

Create - VIP code - Unlimited - On cart with specific date and time condition if specific date
    [Arguments]    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}    ${CodeCanBeUseTime_Text}
    ...    ${Prefix_Text}    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}    ${SpecificDate_Datas}
    Sleep    1s
    Promotion - Fill Data to Create Promotion    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}
    Promotion - Select Unlimited VIP Code to Create Promotion    ${CodeCanBeUseTime_Text}    ${Prefix_Text}
    Promotion - Select SpecificDate to Create Promotion
    Promotion - Fill SpecificTime to Create Promotion    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}
    ${SpecificDatePathFile}=    Promotion - Set Specific Promotion in CSV    ${SpecificDate_Datas}
    Promotion - Browse file for mass upload Specific Promotion    ${SpecificDatePathFile}
    Promotion - Select Effects On Cart
    Promotion - Save Promotion
    Promotion - Upload VIP E-mail With Excel

Create - VIP code - Unlimited - Cart with Condition-variant and upload specific date and time condition
    [Arguments]    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}    ${CodeCanBeUseTime_Text}
    ...    ${Prefix_Text}    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}    ${SpecificDate_Datas}    ${VariantName}
    Sleep    1s
    Promotion - Fill Data to Create Promotion    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}
    Promotion - Select Unlimited VIP Code to Create Promotion    ${CodeCanBeUseTime_Text}    ${Prefix_Text}
    Promotion - Select SpecificDate to Create Promotion
    Promotion - Fill SpecificTime to Create Promotion    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}
    ${SpecificDatePathFile}=    Promotion - Set Specific Promotion in CSV    ${SpecificDate_Datas}
    Promotion - Browse file for mass upload Specific Promotion    ${SpecificDatePathFile}

    Promotion - Select Effects On Cart With Conditions Variant    ${VariantName}

    Promotion - Save Promotion
    Promotion - Upload VIP E-mail With Excel

Create - VIP code - Unlimited - Cart with Condition-brand and upload specific date and time condition
    [Arguments]    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}    ${CodeCanBeUseTime_Text}
    ...    ${Prefix_Text}    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}    ${SpecificDate_Datas}    ${BrandName}
    Sleep    1s
    Promotion - Fill Data to Create Promotion    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}
    Promotion - Select Unlimited VIP Code to Create Promotion    ${CodeCanBeUseTime_Text}    ${Prefix_Text}
    Promotion - Select SpecificDate to Create Promotion
    Promotion - Fill SpecificTime to Create Promotion    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}
    ${SpecificDatePathFile}=    Promotion - Set Specific Promotion in CSV    ${SpecificDate_Datas}
    Promotion - Browse file for mass upload Specific Promotion    ${SpecificDatePathFile}
    Promotion - Select Effects On Cart With Conditions Brand    ${BrandName}
    Promotion - Save Promotion
    Promotion - Upload VIP E-mail With Excel

Create - VIP code - Limited - Cart with Condition-brand exclude product and upload specific date and time condition
    [Arguments]    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}    ${CodeCanBeUseTime_Text}
    ...    ${Prefix_Text}    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}    ${SpecificDate_Datas}    ${BrandName}
    Sleep    1s
    Promotion - Fill Data to Create Promotion    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}
    Promotion - Select Limited VIP Code to Create Promotion    ${CodeCanBeUseTime_Text}    ${Prefix_Text}
    Promotion - Select SpecificDate to Create Promotion
    Promotion - Fill SpecificTime to Create Promotion    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}
    ${SpecificDatePathFile}=    Promotion - Set Specific Promotion in CSV    ${SpecificDate_Datas}
    Promotion - Browse file for mass upload Specific Promotion    ${SpecificDatePathFile}
    Promotion - Select Effects On Cart With Conditions Brand    ${BrandName}
    Promotion - Select Exclude Products
    #Promotion - Save Promotion
    #Promotion - Upload VIP E-mail With Excel

Create - VIP code - Unlimited - Cart with Condition-product and upload specific date and time condition
    [Arguments]    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}    ${CodeCanBeUseTime_Text}
    ...    ${Prefix_Text}    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}    ${SpecificDate_Datas}    ${ProductName}
    Sleep    1s
    Promotion - Fill Data to Create Promotion    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}
    Promotion - Select Unlimited VIP Code to Create Promotion    ${CodeCanBeUseTime_Text}    ${Prefix_Text}
    Promotion - Select SpecificDate to Create Promotion
    Promotion - Fill SpecificTime to Create Promotion    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}
    ${SpecificDatePathFile}=    Promotion - Set Specific Promotion in CSV    ${SpecificDate_Datas}
    Promotion - Browse file for mass upload Specific Promotion    ${SpecificDatePathFile}
    Promotion - Select Effects On Cart With Conditions Product    ${ProductName}
    Promotion - Save Promotion
    Promotion - Upload VIP E-mail With Excel

Create - VIP code - Unlimited - Cart with Condition-product exclude variant and upload specific date and time condition
   [Arguments]    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}    ${CodeCanBeUseTime_Text}
    ...    ${Prefix_Text}    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}    ${SpecificDate_Datas}    ${ProductName}
    Sleep    1s
    Promotion - Fill Data to Create Promotion    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}
    Promotion - Select Unlimited VIP Code to Create Promotion    ${CodeCanBeUseTime_Text}    ${Prefix_Text}
    Promotion - Select SpecificDate to Create Promotion
    Promotion - Fill SpecificTime to Create Promotion    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}
    ${SpecificDatePathFile}=    Promotion - Set Specific Promotion in CSV    ${SpecificDate_Datas}
    Promotion - Browse file for mass upload Specific Promotion    ${SpecificDatePathFile}
    Promotion - Select Effects On Cart With Conditions Product    ${ProductName}
    Promotion - Select Exclude Variants
    # Promotion - Save Promotion
    # Promotion - Upload VIP E-mail With Excel

Create - VIP code - Limited - Cart with Condition-product exclude variant and upload specific date and time condition
   [Arguments]    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}    ${CodeCanBeUseTime_Text}
    ...    ${Prefix_Text}    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}    ${SpecificDate_Datas}    ${ProductName}
    Sleep    1s
    Promotion - Fill Data to Create Promotion    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}
    Promotion - Select Limited VIP Code to Create Promotion    ${CodeCanBeUseTime_Text}    ${Prefix_Text}
    Promotion - Select SpecificDate to Create Promotion
    Promotion - Fill SpecificTime to Create Promotion    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}
    ${SpecificDatePathFile}=    Promotion - Set Specific Promotion in CSV    ${SpecificDate_Datas}
    Promotion - Browse file for mass upload Specific Promotion    ${SpecificDatePathFile}
    Promotion - Select Effects On Cart With Conditions Product    ${ProductName}
    Promotion - Select Exclude Variants
    # Promotion - Save Promotion
    # Promotion - Upload VIP E-mail With Excel

Create - VIP code - Limited - Cart with Condition-product and upload specific date and time condition
   [Arguments]    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}    ${CodeCanBeUseTime_Text}
    ...    ${Prefix_Text}    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}    ${SpecificDate_Datas}    ${ProductName}
    Sleep    1s
    Promotion - Fill Data to Create Promotion    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}
    Promotion - Select Limited VIP Code to Create Promotion    ${CodeCanBeUseTime_Text}    ${Prefix_Text}
    Promotion - Select SpecificDate to Create Promotion
    Promotion - Fill SpecificTime to Create Promotion    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}
    ${SpecificDatePathFile}=    Promotion - Set Specific Promotion in CSV    ${SpecificDate_Datas}
    Promotion - Browse file for mass upload Specific Promotion    ${SpecificDatePathFile}
    Promotion - Select Effects On Cart With Conditions Product    ${ProductName}
    # Promotion - Save Promotion
    # Promotion - Upload VIP E-mail With Excel

Create - VIP code - Limited - Cart with Condition-variant and upload specific date and time condition
    [Arguments]    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}    ${CodeCanBeUseTime_Text}
    ...    ${Prefix_Text}    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}    ${SpecificDate_Datas}    ${VariantName}
    Sleep    1s
    Promotion - Fill Data to Create Promotion    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}
    Promotion - Select Limited VIP Code to Create Promotion    ${CodeCanBeUseTime_Text}    ${Prefix_Text}
    Promotion - Select SpecificDate to Create Promotion
    Promotion - Fill SpecificTime to Create Promotion    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}
    ${SpecificDatePathFile}=    Promotion - Set Specific Promotion in CSV    ${SpecificDate_Datas}
    Promotion - Browse file for mass upload Specific Promotion    ${SpecificDatePathFile}

    Promotion - Select Effects On Cart With Conditions Variant    ${VariantName}

    Promotion - Save Promotion
    Promotion - Upload VIP E-mail With Excel

Create - VIP code - Unlimited - Cart with Condition-brand exclude product and upload specific date and time condition
     [Arguments]    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}    ${CodeCanBeUseTime_Text}
    ...    ${Prefix_Text}    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}    ${SpecificDate_Datas}    ${BrandName}
    Sleep    1s
    Promotion - Fill Data to Create Promotion    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}
    Promotion - Select Unlimited VIP Code to Create Promotion    ${CodeCanBeUseTime_Text}    ${Prefix_Text}
    Promotion - Select SpecificDate to Create Promotion
    Promotion - Fill SpecificTime to Create Promotion    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}
    ${SpecificDatePathFile}=    Promotion - Set Specific Promotion in CSV    ${SpecificDate_Datas}
    Promotion - Browse file for mass upload Specific Promotion    ${SpecificDatePathFile}
    Promotion - Select Effects On Cart With Conditions Brand Exlude Product    ${BrandName}
    Promotion - Select Exclude Products
    Promotion - Save Promotion
    Promotion - Upload VIP E-mail With Excel

Create - VIP code - Limited - On cart with upload specific date and time condition
     [Arguments]    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}    ${CodeCanBeUseTime_Text}
    ...    ${Prefix_Text}    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}    ${SpecificDate_Datas}
    Sleep    1s
    Promotion - Fill Data to Create Promotion    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}
    Promotion - Select Limited VIP Code to Create Promotion    ${CodeCanBeUseTime_Text}    ${Prefix_Text}
    Promotion - Select SpecificDate to Create Promotion
    Promotion - Fill SpecificTime to Create Promotion    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}
    ${SpecificDatePathFile}=    Promotion - Set Specific Promotion in CSV    ${SpecificDate_Datas}
    Promotion - Browse file for mass upload Specific Promotion    ${SpecificDatePathFile}
    Promotion - Save Promotion
    Promotion - Upload VIP E-mail With Excel

TestFeature
     [Arguments]    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}    ${CodeCanBeUseTime_Text}
    ...    ${Prefix_Text}    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}    ${SpecificDate_Datas}    ${ProductName}
    Sleep    1s
    Promotion - Fill Data to Create Promotion    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}
    Promotion - Select Unlimited VIP Code to Create Promotion    ${CodeCanBeUseTime_Text}    ${Prefix_Text}
    Promotion - Select SpecificDate to Create Promotion
    Promotion - Fill SpecificTime to Create Promotion    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}
    ${SpecificDatePathFile}=    Promotion - Set Specific Promotion in CSV    ${SpecificDate_Datas}
    Promotion - Browse file for mass upload Specific Promotion    ${SpecificDatePathFile}
    Promotion - Select Effects On Cart With Conditions Product    ${ProductName}
    # Promotion - Save Promotion
    # Promotion - Upload VIP E-mail With Excel

Create - VIP code - Unlimited - Cart with Condition-collection and upload specific date and time condition
    [Arguments]    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}    ${CodeCanBeUseTime_Text}
    ...    ${Prefix_Text}    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}    ${SpecificDate_Datas}
    Sleep    1s
    Promotion - Fill Data to Create Promotion    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}
    Promotion - Select Unlimited VIP Code to Create Promotion    ${CodeCanBeUseTime_Text}    ${Prefix_Text}
    Promotion - Select SpecificDate to Create Promotion
    Promotion - Fill SpecificTime to Create Promotion    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}
    ${SpecificDatePathFile}=    Promotion - Set Specific Promotion in CSV    ${SpecificDate_Datas}
    Promotion - Browse file for mass upload Specific Promotion    ${SpecificDatePathFile}
    Promotion - Select Effects On Cart With Conditions Collection
    # Promotion - Save Promotion
    # Promotion - Upload VIP E-mail With Excel

Create - VIP code - Unlimited - Cart with Condition-collection exclude product and upload specific date and time condition
    [Arguments]    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}    ${CodeCanBeUseTime_Text}
    ...    ${Prefix_Text}    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}    ${SpecificDate_Datas}
    Sleep    1s
    Promotion - Fill Data to Create Promotion    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}
    Promotion - Select Unlimited VIP Code to Create Promotion    ${CodeCanBeUseTime_Text}    ${Prefix_Text}
    Promotion - Select SpecificDate to Create Promotion
    Promotion - Fill SpecificTime to Create Promotion    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}
    ${SpecificDatePathFile}=    Promotion - Set Specific Promotion in CSV    ${SpecificDate_Datas}
    Promotion - Browse file for mass upload Specific Promotion    ${SpecificDatePathFile}
    Promotion - Select Effects On Cart With Conditions Collection
    Promotion - Select Exclude Products
    # Promotion - Save Promotion
    # Promotion - Upload VIP E-mail With Excel

Create - VIP code - Limited - Cart with Condition-collection and upload specific date and time condition
    [Arguments]    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}    ${CodeCanBeUseTime_Text}
    ...    ${Prefix_Text}    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}    ${SpecificDate_Datas}
    Sleep    1s
    Promotion - Fill Data to Create Promotion    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}
    Promotion - Select Limited VIP Code to Create Promotion    ${CodeCanBeUseTime_Text}    ${Prefix_Text}
    Promotion - Select SpecificDate to Create Promotion
    Promotion - Fill SpecificTime to Create Promotion    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}
    ${SpecificDatePathFile}=    Promotion - Set Specific Promotion in CSV    ${SpecificDate_Datas}
    Promotion - Browse file for mass upload Specific Promotion    ${SpecificDatePathFile}
    Promotion - Select Effects On Cart With Conditions Collection
    # Promotion - Save Promotion
    # Promotion - Upload VIP E-mail With Excel

Create - VIP code - Limited - Cart with Condition-collection exclude product and upload specific date and time condition
    [Arguments]    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}    ${CodeCanBeUseTime_Text}
    ...    ${Prefix_Text}    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}    ${SpecificDate_Datas}
    Sleep    1s
    Promotion - Fill Data to Create Promotion    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}
    Promotion - Select Limited VIP Code to Create Promotion    ${CodeCanBeUseTime_Text}    ${Prefix_Text}
    Promotion - Select SpecificDate to Create Promotion
    Promotion - Fill SpecificTime to Create Promotion    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}
    ${SpecificDatePathFile}=    Promotion - Set Specific Promotion in CSV    ${SpecificDate_Datas}
    Promotion - Browse file for mass upload Specific Promotion    ${SpecificDatePathFile}
    Promotion - Select Effects On Cart With Conditions Collection
    Promotion - Select Exclude Products
    # Promotion - Save Promotion
    # Promotion - Upload VIP E-mail With Excel

Create - Single Code - Unlimited - On cart with upload specific date and time condition
    [Arguments]    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}    ${SingleCode_Text}
    ...    ${Prefix_Text}    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}    ${SpecificDate_Datas}
    Sleep    1s
    Promotion - Fill Data to Create Promotion    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}
    Promotion - Select Unlimited Single Code to Create Promotion    ${SingleCode_Text}    ${Prefix_Text}
    Promotion - Select SpecificDate to Create Promotion
    Promotion - Fill SpecificTime to Create Promotion    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}
    ${SpecificDatePathFile}=    Promotion - Set Specific Promotion in CSV    ${SpecificDate_Datas}
    Promotion - Browse file for mass upload Specific Promotion    ${SpecificDatePathFile}
    Promotion - Save Promotion

Create - Single Code - Unlimited - Cart with Condition-variant and upload specific date and time condition
    [Arguments]    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}    ${SingleCode_Text}
    ...    ${Prefix_Text}    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}    ${SpecificDate_Datas}    ${VariantName}
    Sleep    1s
    Promotion - Fill Data to Create Promotion    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}
    Promotion - Select Unlimited Single Code to Create Promotion    ${SingleCode_Text}    ${Prefix_Text}
    Promotion - Select SpecificDate to Create Promotion
    Promotion - Fill SpecificTime to Create Promotion    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}
    ${SpecificDatePathFile}=    Promotion - Set Specific Promotion in CSV    ${SpecificDate_Datas}
    Promotion - Browse file for mass upload Specific Promotion    ${SpecificDatePathFile}
    Promotion - Select Effects On Cart With Conditions Variant    ${VariantName}
    Promotion - Save Promotion

Create - Single Code - Unlimited - Cart with Condition-brand and upload specific date and time condition
    [Arguments]    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}    ${SingleCode_Text}
    ...    ${Prefix_Text}    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}    ${SpecificDate_Datas}    ${BrandName}
    Sleep    1s
    Promotion - Fill Data to Create Promotion    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}
    Promotion - Select Unlimited Single Code to Create Promotion    ${SingleCode_Text}    ${Prefix_Text}
    Promotion - Select SpecificDate to Create Promotion
    Promotion - Fill SpecificTime to Create Promotion    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}
    ${SpecificDatePathFile}=    Promotion - Set Specific Promotion in CSV    ${SpecificDate_Datas}
    Promotion - Browse file for mass upload Specific Promotion    ${SpecificDatePathFile}
    Promotion - Select Effects On Cart With Conditions Brand    ${BrandName}
    Promotion - Save Promotion

Create - Single Code - Unlimited - Cart with Condition-product and upload specific date and time condition
    [Arguments]    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}    ${SingleCode_Text}
    ...    ${Prefix_Text}    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}    ${SpecificDate_Datas}    ${ProductName}
    Sleep    1s
    Promotion - Fill Data to Create Promotion    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}
    Promotion - Select Unlimited Single Code to Create Promotion    ${SingleCode_Text}    ${Prefix_Text}
    Promotion - Select SpecificDate to Create Promotion
    Promotion - Fill SpecificTime to Create Promotion    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}
    ${SpecificDatePathFile}=    Promotion - Set Specific Promotion in CSV    ${SpecificDate_Datas}
    Promotion - Browse file for mass upload Specific Promotion    ${SpecificDatePathFile}
    Promotion - Select Effects On Cart With Conditions Product    ${ProductName}
    Promotion - Save Promotion

Create - Single Code - Unlimited - Cart with Condition-collection and upload specific date and time condition
    [Arguments]    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}    ${SingleCode_Text}
    ...    ${Prefix_Text}    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}    ${SpecificDate_Datas}
    Sleep    1s
    Promotion - Fill Data to Create Promotion    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}
    Promotion - Select Unlimited Single Code to Create Promotion    ${SingleCode_Text}    ${Prefix_Text}
    Promotion - Select SpecificDate to Create Promotion
    Promotion - Fill SpecificTime to Create Promotion    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}
    ${SpecificDatePathFile}=    Promotion - Set Specific Promotion in CSV    ${SpecificDate_Datas}
    Promotion - Browse file for mass upload Specific Promotion    ${SpecificDatePathFile}
    Promotion - Select Effects On Cart With Conditions Collection
    Promotion - Save Promotion

Create - Single Code - Unlimited - Cart with Condition-brand exclude product and upload specific date and time condition
     [Arguments]    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}    ${SingleCode_Text}
    ...    ${Prefix_Text}    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}    ${SpecificDate_Datas}    ${BrandName}
    Sleep    1s
    Promotion - Fill Data to Create Promotion    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}
    Promotion - Select Unlimited Single Code to Create Promotion    ${SingleCode_Text}    ${Prefix_Text}
    Promotion - Select SpecificDate to Create Promotion
    Promotion - Fill SpecificTime to Create Promotion    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}
    ${SpecificDatePathFile}=    Promotion - Set Specific Promotion in CSV    ${SpecificDate_Datas}
    Promotion - Browse file for mass upload Specific Promotion    ${SpecificDatePathFile}
    Promotion - Select Effects On Cart With Conditions Brand Exlude Product    ${BrandName}
    Promotion - Save Promotion

Create - Single Code - Unlimited - Cart with Condition-product exclude variant and upload specific date and time condition
    [Arguments]    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}    ${SingleCode_Text}
    ...    ${Prefix_Text}    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}    ${SpecificDate_Datas}    ${ProductName}
    Sleep    1s
    Promotion - Fill Data to Create Promotion    ${PromotionName_Text}    ${PromotionCode_Text}    ${Detail_Text}    ${Note_Text}    ${DiscountBath_Text}
    Promotion - Select Unlimited Single Code to Create Promotion    ${SingleCode_Text}    ${Prefix_Text}
    Promotion - Select SpecificDate to Create Promotion
    Promotion - Fill SpecificTime to Create Promotion    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}
    ${SpecificDatePathFile}=    Promotion - Set Specific Promotion in CSV    ${SpecificDate_Datas}
    Promotion - Browse file for mass upload Specific Promotion    ${SpecificDatePathFile}
    Promotion - Select Effects On Cart With Conditions Product    ${ProductName}
    Promotion - Select Exclude Variants
    Promotion - Save Promotion
