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
    ...    ${Text_Code}    ${BrandName}    ${Img_ID_Original}    Test Data for Create Product
    #Test Step
    ${SKU_ID}=    FMS Create New SKU with retail    ${SKUName}    ${BrandName}
    ${MeterialID}=    Get Meterial ID frome DB by SKU ID    ${SKU_ID}
    Log To Console    mat=${MeterialID}
    Create New Product    ${SKUName}    ${NewProductName}    ${BrandID}    ${MeterialID}    ${VariantOptionID}    ${VariantType}
    ...    ${StyleText}    ${StyleType}    ${StyleColor}
    ${ProductID}=    Set Product Collection    ${NewProductName}    ${CollectionID}
    ${pkey}=    Get pkey from DB by Product ID    ${ProductID}
    Set Product Content    ${Key_Feature}    ${Description}    ${Caption}    ${Advantage}    ${ProductID}    ${pkey}
    ...    ${Img_ID_Original}
    Comment    Set SEO Content    ${SEOContent}    ${SEODescription}    ${SEOKeywords}    ${SEOTitle}    ${ProductID}
    Comment    Set Price    ${ProductID}    ${MeterialID}    ${SpecialPrice}    ${OldPrice}
    Comment    Set Payment    ${ProductID}    ${paymentMethods1}    ${paymentMethods2}
    Comment    Set Shipping    ${ProductID}    ${MeterialID}    ${Weight}    ${DimensionWidth}    ${DimensionUnit}
    ...    ${DimensionLength}    ${DimensionHeight}
    #SET ALLOW COD    ${}
    Set Tag    ${ProductID}    ${Tag}
    Approve Product    ${ProductID}    ${SKUName}    ${NewProductName}    ${BrandID}    ${Productstatus}
    Publish Product    ${ProductID}
    Increase Stock    ${SKU_ID}    ${Stock_Quantity}    ${Stock_Note}    ${Stock_Total}
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

Create Product and verify user can purchase product successful with Credit Card
    #Test Data
    ${NewProductName}    ${SKUName}    ${BrandID}    ${VariantType}    ${VariantNameTH}    ${VariantNameEN}    ${VariantOptionID}
    ...    ${CollectionID}    ${Key_Feature}    ${Description}    ${Caption}    ${Advantage}    ${SEOContent}
    ...    ${SEODescription}    ${SEOKeywords}    ${SEOTitle}    ${StyleText}    ${StyleType}    ${StyleColor}
    ...    ${SpecialPrice}    ${OldPrice}    ${paymentMethods1}    ${paymentMethods2}    ${Weight}    ${DimensionWidth}
    ...    ${DimensionUnit}    ${DimensionLength}    ${DimensionHeight}    ${Tag}    ${VariantStatus}    ${SortOrder}
    ...    ${Productstatus}    ${Stock_Quantity}    ${Stock_Note}    ${Stock_Total}    ${variance}    ${Text_Email}
    ...    ${Text_Name}    ${Text_Phone}    ${Text_Address}    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}
    ...    ${Text_Code}    ${BrandName}    ${Img_ID_Original}    Test Data for Create Product
    #Test Step
    ${SKU_ID}=    FMS Create New SKU with retail    ${SKUName}    ${BrandName}
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
    ${ProductURL}=    Set Variable    ${ITM_URL}/products/item-${pkey}.html
    #Verify user can purchase this product
    Open Browser    ${ProductURL}    chrome
    ${order_id}=    Guest buy Product with CC payment    ${ProductURL}    ${variance}    ${Text_Email}    ${Text_Name}    ${Text_Phone}
    ...    ${Text_Address}    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}    ${Text_Code}
    #Log
    log    Product Name = ${NewProductName}
    log    SKU ID = ${SKU_ID}
    log    PKey = ${pkey}
    log    Order ID = ${order_id}
    log    Product ID = ${ProductID}
    [Teardown]    close browser

Create Product and verify user can purchase product successful with COD
    #Test Data
    ${NewProductName}    ${SKUName}    ${BrandID}    ${VariantType}    ${VariantNameTH}    ${VariantNameEN}    ${VariantOptionID}
    ...    ${CollectionID}    ${Key_Feature}    ${Description}    ${Caption}    ${Advantage}    ${SEOContent}
    ...    ${SEODescription}    ${SEOKeywords}    ${SEOTitle}    ${StyleText}    ${StyleType}    ${StyleColor}
    ...    ${SpecialPrice}    ${OldPrice}    ${paymentMethods1}    ${paymentMethods2}    ${Weight}    ${DimensionWidth}
    ...    ${DimensionUnit}    ${DimensionLength}    ${DimensionHeight}    ${Tag}    ${VariantStatus}    ${SortOrder}
    ...    ${Productstatus}    ${Stock_Quantity}    ${Stock_Note}    ${Stock_Total}    ${variance}    ${Text_Email}
    ...    ${Text_Name}    ${Text_Phone}    ${Text_Address}    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}
    ...    ${Text_Code}    ${BrandName}    ${Img_ID_Original}    Test Data for Create Product
    #Test Step
    ${SKU_ID}=    FMS Create New SKU with retail    ${SKUName}    ${BrandName}
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
    ${ProductURL}=    Set Variable    ${ITM_URL}/products/item-${pkey}.html
    #Verify user can purchase this product
    Open Browser    ${ProductURL}    chrome
    ${order_id}=    Guest buy Product with COD payment    ${ProductURL}    ${variance}    ${Text_Email}    ${Text_Name}    ${Text_Phone}
    ...    ${Text_Address}
    #Log
    log    Product Name = ${NewProductName}
    log    SKU ID = ${SKU_ID}
    log    PKey = ${pkey}
    log    Order ID = ${order_id}
    log    Product ID = ${ProductID}
    [Teardown]    close browser

Insert Image from S3 to Attachments Table
    ${Img_ID_Original}    ${Img_Scale_Original}    ${Img_Path_Original}    ${Img_Name_Original}    ${Img_Location_Original}    ${Img_Size_Original}    ${Img_Mime_Original}
    ...    ${Img_Dimension_Original}    ${Img_ID_M}    ${Img_ID_Original}    ${Img_Scale_M}    ${Img_Path_M}    ${Img_Name_M}
    ...    ${Img_Location_M}    ${Img_Size_M}    ${Img_Mime_M}    ${Img_Dimension_M}    ${Img_ID_L}    ${Img_ID_Original}
    ...    ${Img_Scale_L}    ${Img_Path_L}    ${Img_Name_L}    ${Img_Location_L}    ${Img_Size_L}    ${Img_Mime_L}
    ...    ${Img_Dimension_L}    ${Img_ID_XL}    ${Img_ID_Original}    ${Img_Scale_XL}    ${Img_Path_XL}    ${Img_Name_XL}
    ...    ${Img_Location_XL}    ${Img_Size_XL}    ${Img_Mime_XL}    ${Img_Dimension_XL}    ${Img_ID_S}    ${Img_ID_Original}
    ...    ${Img_Scale_S}    ${Img_Path_S}    ${Img_Name_S}    ${Img_Location_S}    ${Img_Size_S}    ${Img_Mime_S}
    ...    ${Img_Dimension_S}    ${Img_ID_Square}    ${Img_ID_Original}    ${Img_Scale_Square}    ${Img_Path_Square}    ${Img_Name_Square}
    ...    ${Img_Location_Square}    ${Img_Size_Square}    ${Img_Mime_Square}    ${Img_Dimension_Square}    Test Data for insert image
    Insert Image from S3 to Attachments Table    ${Img_ID_Original}    ${Img_Scale_Original}    ${Img_Path_Original}    ${Img_Name_Original}    ${Img_Location_Original}    ${Img_Size_Original}
    ...    ${Img_Mime_Original}    ${Img_Dimension_Original}    ${Img_ID_M}    ${Img_ID_Original}    ${Img_Scale_M}    ${Img_Path_M}
    ...    ${Img_Name_M}    ${Img_Location_M}    ${Img_Size_M}    ${Img_Mime_M}    ${Img_Dimension_M}    ${Img_ID_L}
    ...    ${Img_ID_Original}    ${Img_Scale_L}    ${Img_Path_L}    ${Img_Name_L}    ${Img_Location_L}    ${Img_Size_L}
    ...    ${Img_Mime_L}    ${Img_Dimension_L}    ${Img_ID_XL}    ${Img_ID_Original}    ${Img_Scale_XL}    ${Img_Path_XL}
    ...    ${Img_Name_XL}    ${Img_Location_XL}    ${Img_Size_XL}    ${Img_Mime_XL}    ${Img_Dimension_XL}    ${Img_ID_S}
    ...    ${Img_ID_Original}    ${Img_Scale_S}    ${Img_Path_S}    ${Img_Name_S}    ${Img_Location_S}    ${Img_Size_S}
    ...    ${Img_Mime_S}    ${Img_Dimension_S}    ${Img_ID_Square}    ${Img_ID_Original}    ${Img_Scale_Square}    ${Img_Path_Square}
    ...    ${Img_Name_Square}    ${Img_Location_Square}    ${Img_Size_Square}    ${Img_Mime_Square}    ${Img_Dimension_Square}

temp
    ${SKUName}    Set Variable    sonytestbig
    ${BrandName}    Set Variable    Sony
    ${SKU_ID}=    FMS Create New SKU    ${SKUName}    ${BrandName}
    Log To Console    ${SKU_ID}

*** Keywords ***
Test Data for Create Product
    ${epoch_short}=    Get current epoch time short
    ${NewProductName}    Set Variable    E2E_${epoch_short}
    ${SKUName}    Set Variable    E2E_${epoch_short}
    ${BrandName}    Set Variable    Sony
    ${BrandID}    Set Variable    145
    ${VariantType}    Set Variable    1
    ${VariantNameTH}    Set Variable    Color
    ${VariantNameEN}    Set Variable    Color
    ${VariantOptionID}    Set Variable    90
    ${CollectionID}    Set Variable    339
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
    ...    ${Text_CWCCV}    ${Text_Code}    ${BrandName}    ${Img_ID_Original}

Test Data for insert image
    ${Img_ID_Original}    Set Variable    Loki1000x1000
    ${Img_Scale_Original}    Set Variable    original
    ${Img_Path_Original}    Set Variable    /TestE2E/
    ${Img_Name_Original}    Set Variable    Loki1000x1000.png
    ${Img_Location_Original}    Set Variable    /TestE2E/Loki1000x1000.png
    ${Img_Size_Original}    Set Variable    83068
    ${Img_Mime_Original}    Set Variable    image/png
    ${Img_Dimension_Original}    Set Variable    1000x1000
    ${Img_ID_M}    Set Variable    Loki200x200_m
    ${Img_ID_Original}    Set Variable    Loki1000x1000
    ${Img_Scale_M}    Set Variable    m
    ${Img_Path_M}    Set Variable    /TestE2E/
    ${Img_Name_M}    Set Variable    Loki200x200_m.png
    ${Img_Location_M}    Set Variable    /TestE2E/Loki200x200_m.png
    ${Img_Size_M}    Set Variable    29416
    ${Img_Mime_M}    Set Variable    image/png
    ${Img_Dimension_M}    Set Variable    200x200
    ${Img_ID_L}    Set Variable    Loki350x350_l
    ${Img_ID_Original}    Set Variable    Loki1000x1000
    ${Img_Scale_L}    Set Variable    l
    ${Img_Path_L}    Set Variable    /TestE2E/
    ${Img_Name_L}    Set Variable    Loki350x350_l.png
    ${Img_Location_L}    Set Variable    /TestE2E/Loki350x350_l.png
    ${Img_Size_L}    Set Variable    76652
    ${Img_Mime_L}    Set Variable    image/png
    ${Img_Dimension_L}    Set Variable    350x350
    ${Img_ID_XL}    Set Variable    Loki1000x1000_xl
    ${Img_ID_Original}    Set Variable    Loki1000x1000
    ${Img_Scale_XL}    Set Variable    xl
    ${Img_Path_XL}    Set Variable    /TestE2E/
    ${Img_Name_XL}    Set Variable    Loki1000x1000_xl.png
    ${Img_Location_XL}    Set Variable    /TestE2E/Loki1000x1000_xl.png
    ${Img_Size_XL}    Set Variable    83068
    ${Img_Mime_XL}    Set Variable    image/png
    ${Img_Dimension_XL}    Set Variable    1000x1000
    ${Img_ID_S}    Set Variable    Loki64x64_s
    ${Img_ID_Original}    Set Variable    Loki1000x1000
    ${Img_Scale_S}    Set Variable    s
    ${Img_Path_S}    Set Variable    /TestE2E/
    ${Img_Name_S}    Set Variable    Loki64x64_s.png
    ${Img_Location_S}    Set Variable    /TestE2E/Loki64x64_s.png
    ${Img_Size_S}    Set Variable    4714
    ${Img_Mime_S}    Set Variable    image/png
    ${Img_Dimension_S}    Set Variable    64x64
    ${Img_ID_Square}    Set Variable    Loki150x150_square
    ${Img_ID_Original}    Set Variable    Loki1000x1000
    ${Img_Scale_Square}    Set Variable    square
    ${Img_Path_Square}    Set Variable    /TestE2E/
    ${Img_Name_Square}    Set Variable    Loki150x150_square.png
    ${Img_Location_Square}    Set Variable    /TestE2E/Loki150x150_square.png
    ${Img_Size_Square}    Set Variable    18153
    ${Img_Mime_Square}    Set Variable    image/png
    ${Img_Dimension_Square}    Set Variable    150x150
    [Return]    ${Img_ID_Original}    ${Img_Scale_Original}    ${Img_Path_Original}    ${Img_Name_Original}    ${Img_Location_Original}    ${Img_Size_Original}
    ...    ${Img_Mime_Original}    ${Img_Dimension_Original}    ${Img_ID_M}    ${Img_ID_Original}    ${Img_Scale_M}    ${Img_Path_M}
    ...    ${Img_Name_M}    ${Img_Location_M}    ${Img_Size_M}    ${Img_Mime_M}    ${Img_Dimension_M}    ${Img_ID_L}
    ...    ${Img_ID_Original}    ${Img_Scale_L}    ${Img_Path_L}    ${Img_Name_L}    ${Img_Location_L}    ${Img_Size_L}
    ...    ${Img_Mime_L}    ${Img_Dimension_L}    ${Img_ID_XL}    ${Img_ID_Original}    ${Img_Scale_XL}    ${Img_Path_XL}
    ...    ${Img_Name_XL}    ${Img_Location_XL}    ${Img_Size_XL}    ${Img_Mime_XL}    ${Img_Dimension_XL}    ${Img_ID_S}
    ...    ${Img_ID_Original}    ${Img_Scale_S}    ${Img_Path_S}    ${Img_Name_S}    ${Img_Location_S}    ${Img_Size_S}
    ...    ${Img_Mime_S}    ${Img_Dimension_S}    ${Img_ID_Square}    ${Img_ID_Original}    ${Img_Scale_Square}    ${Img_Path_Square}
    ...    ${Img_Name_Square}    ${Img_Location_Square}    ${Img_Size_Square}    ${Img_Mime_Square}    ${Img_Dimension_Square}
