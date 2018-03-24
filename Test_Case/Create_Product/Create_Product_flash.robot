*** Settings ***
Library           HttpLibrary.HTTP
Resource          ../../Keyword/API/PCMS/Create_Product/Create_Product/Create_Product.robot
Resource          ../../Keyword/Common/Keywords_Common.robot
Resource          ../../Keyword/Database/PCMS/keyword_pcms.robot
Library           String
Library           OperatingSystem
Resource          ../../Resource/Config/${env}/env_config.robot
Resource          ../../Keyword/Database/PCMS/keyword_pcms.robot
Resource          ../../Keyword/API/PCMS/Stock/keywords_stock.robot
Resource          ../../Keyword/Features/Create_Order/Create_order.txt
Resource          ../../Keyword/API/FMS/FMS_Create_SKU.robot
Resource          ../../Keyword/Portal/PCMS/Login/keywords_login.robot

*** Test Cases ***
Create Product and displayed on Level D
    #Test Data
    ${NewProductName}    ${SKUName}    ${BrandID}    ${VariantType}    ${VariantNameTH}    ${VariantNameEN}    ${VariantOptionID}
    ...    ${CollectionID}    ${Key_Feature}    ${Description}    ${Caption}    ${Advantage}    ${SEOContent}
    ...    ${SEODescription}    ${SEOKeywords}    ${SEOTitle}    ${StyleText}    ${StyleType}    ${StyleColor}
    ...    ${SpecialPrice}    ${OldPrice}    ${paymentMethods1}    ${paymentMethods2}    ${Weight}    ${DimensionWidth}
    ...    ${DimensionUnit}    ${DimensionLength}    ${DimensionHeight}    ${Tag}    ${VariantStatus}    ${SortOrder}
    ...    ${Productstatus}    ${Stock_Quantity}    ${Stock_Note}    ${Stock_Total}    ${variance}    ${Text_Email}
    ...    ${Text_Name}    ${Text_Phone}    ${Text_Address}    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}
    ...    ${Text_Code}    ${BrandName}    ${Img_ID_Original}    ${SKU_ID}     Test Data for Create Product
    ${MeterialID}=    Get Meterial ID frome DB by SKU ID    ${SKU_ID}
    Create New Product    ${SKUName}    ${NewProductName}    ${BrandID}    ${MeterialID}    ${VariantOptionID}    ${VariantType}
    ...    ${StyleText}    ${StyleType}    ${StyleColor}
    ${ProductID}=    Set Product Collection    ${NewProductName}    ${CollectionID}
    ${pkey}=    Get pkey from DB by Product ID    ${ProductID}
    Set Product Content    ${Key_Feature}    ${Description}    ${Caption}    ${Advantage}    ${ProductID}    ${pkey}
    ...    ${Img_ID_Original}
    Set SEO Content    ${SEOContent}    ${SEODescription}    ${SEOKeywords}    ${SEOTitle}    ${ProductID}
    Set Price    ${ProductID}    ${MeterialID}    ${SpecialPrice}    ${OldPrice}
    Set Payment    ${ProductID}    ${paymentMethods1}    ${paymentMethods2}
    Set Shipping    ${ProductID}    ${MeterialID}    ${Weight}    ${DimensionWidth}    ${DimensionUnit}    ${DimensionLength}
    ...    ${DimensionHeight}
    Set Tag    ${ProductID}    ${Tag}
    Approve Product    ${ProductID}    ${SKUName}    ${NewProductName}    ${BrandID}    ${Productstatus}
    Publish Product    ${ProductID}
    Increase Stock    ${SKU_ID}    ${Stock_Quantity}    ${Stock_Note}    ${Stock_Total}

*** Keywords ***
Test Data for Create Product
    ${NewProductName}    Set Variable    Flash-03-1-111
    ${SKU_ID}    Set Variable    ABAAA1116311
    ${SKUName}    Set Variable    Flash-03
    ${BrandName}    Set Variable    Accessorize
    ${BrandID}    Set Variable    560
    ${VariantType}   Set Variable     6
    ${ProductURL}=    Set Variable    ${ITM_URL}/products/item-${pkey}.html
    #Verify user can purchase this product
    Open Browser    ${ProductURL}    chrome
    Maximize Browser Window
    sleep    10s
    log    Product Name = ${NewProductName}
    log    SKU ID = ${SKU_ID}
    log    PKey = ${pkey}
    log    Product ID = ${ProductID}
    [Teardown]    close browser

*** Keywords ***
Test Data for Create Product
    ${NewProductName}    Set Variable    E2E2016420165926
    ${SKU_ID}    Set Variable    TestE2E11113
    ${SKUName}    Set Variable    E2E2016420165926
    ${BrandName}    Set Variable    Accessorize
    ${BrandID}    Set Variable    560
    ${VariantType}    Set Variable    6
    ${VariantNameTH}    Set Variable    Color
    ${VariantNameEN}    Set Variable    Color
    ${VariantOptionID}    Set Variable    858
    ${CollectionID}    Set Variable    331
    ${Key_Feature}    Set Variable    test e2e
    ${Description}    Set Variable    test e2e
    ${Caption}    Set Variable    test e2e
    ${Advantage}    Set Variable    test e2e
    ${SEOContent}    Set Variable    test e2e
    ${SEODescription}    Set Variable    test e2e
    ${SEOKeywords}    Set Variable    test e2e
    ${SEOTitle}    Set Variable    test e2e
    ${StyleText}    Set Variable    Gold
    ${StyleType}    Set Variable    color
    ${StyleColor}    Set Variable    Gold
    ${SpecialPrice}    Set Variable    600
    ${OldPrice}    Set Variable    1000

    ${paymentMethods1}    Set Variable    1    #1.Credit Card (CCW) \ \ \ 2.Truemoney Ewallet (EW) \ \ \ 4.bank ATM (ATM) \ \ \ 5.IBANK (IBANK) \ \ \ 6.BANKTRANS (BANKTRANS) \ \ \ 8.Counter service (CS) \ \ 11. \ Wallet by TrueMoney (TMN_WALLET)
    ${paymentMethods2}    Set Variable    8
    ${Weight}    Set Variable    15
    ${DimensionWidth}    Set Variable    45
    ${DimensionUnit}    Set Variable    45
    ${DimensionLength}    Set Variable    45
    ${DimensionHeight}    Set Variable    45
    ${Tag}    Set Variable    Test,E2E
    ${VariantStatus}    Set Variable    active
    ${SortOrder}    Set Variable    1
    ${Productstatus}    Set Variable    1    #1 Active 2 inactive
    ${Stock_Quantity}    Set Variable    1000
    ${Stock_Note}    Set Variable    test e2e
    ${Stock_Total}    Set Variable    1000
    ${variance}    Set Variable    ${EMPTY}    #Variant Item (1,2,3)
    ${Text_Email}    Set Variable    TestE2E@mail.com
    ${Text_Name}    Set Variable    test
    ${Text_Phone}    Set Variable    0811111111
    ${Text_Address}    Set Variable    1111/1 AIA CAP Tower
    ${Text_CWName}    Set Variable    Test
    ${Text_CWCardNo}    Set Variable    5555555555554444
    ${Text_CWCCV}    Set Variable    123
    ${Text_Code}    Set Variable    ${EMPTY}    #Promotion Code
    ${Img_ID_Original}    Set Variable    Loki1000x1000
    [Return]    ${NewProductName}    ${SKUName}    ${BrandID}    ${VariantType}    ${VariantNameTH}    ${VariantNameEN}
    ...    ${VariantOptionID}    ${CollectionID}    ${Key_Feature}    ${Description}    ${Caption}    ${Advantage}
    ...    ${SEOContent}    ${SEODescription}    ${SEOKeywords}    ${SEOTitle}    ${StyleText}    ${StyleType}
    ...    ${StyleColor}    ${SpecialPrice}    ${OldPrice}    ${paymentMethods1}    ${paymentMethods2}    ${Weight}
    ...    ${DimensionWidth}    ${DimensionUnit}    ${DimensionLength}    ${DimensionHeight}    ${Tag}    ${VariantStatus}
    ...    ${SortOrder}    ${Productstatus}    ${Stock_Quantity}    ${Stock_Note}    ${Stock_Total}    ${variance}
    ...    ${Text_Email}    ${Text_Name}    ${Text_Phone}    ${Text_Address}    ${Text_CWName}    ${Text_CWCardNo}
    ...    ${Text_CWCCV}    ${Text_Code}    ${BrandName}    ${Img_ID_Original}    ${SKU_ID}