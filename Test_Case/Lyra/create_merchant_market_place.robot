*** Settings ***
Resource          ${CURDIR}/../../Resource/init.robot
Resource          ${CURDIR}/../../Keyword/API/FMS/keywords_fms_create_supplier.robot
Resource          ${CURDIR}/../../Keyword/API/FMS/FMS_Create_SKU.robot
Resource          ../../Keyword/Features/Create_Product/Create_Product.robot
Resource          ${CURDIR}/../../Keyword/Database/PCMS/keyword_pcms.robot

*** Variables ***

*** Test Cases ***
Create SKU
    #Create Merchant Martker Place
    #    ${supplier_code}    Create Supplier Marketplace From FMS
    ${NewProductName}    Set Variable    TestLyra0005
    # ${NewProductName}
    ${SKUName}    ${BrandCode}    ${BrandID}    ${VariantType}    ${VariantNameTH}    ${VariantNameEN}    ${VariantOptionID}
    ...    ${CollectionPkey}    ${Key_Feature}    ${Description}    ${Caption}    ${Advantage}    ${SEOContent}
    ...    ${SEODescription}    ${SEOKeywords}    ${SEOTitle}    ${StyleText}    ${StyleType}    ${StyleColor}
    ...    ${SpecialPrice}    ${OldPrice}    ${paymentMethods1}    ${paymentMethods2}    ${Weight}    ${DimensionWidth}
    ...    ${DimensionUnit}    ${DimensionLength}    ${DimensionHeight}    ${Tag}    ${VariantStatus}    ${SortOrder}
    ...    ${Productstatus}    ${Stock_Quantity}    ${Stock_Note}    ${Stock_Total}    ${variance}    ${Text_Email}
    ...    ${Text_Name}    ${Text_Phone}    ${Text_Address}    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}
    ...    ${Text_Code}    ${BrandName}    ${Img_ID_Original}    Test Data for Create Product1
    ${SKU_ID}    FMS create sku with marketplace    "TH3495"    TestLyra0005    APAA
    ${MeterialID}=    Get Meterial ID frome DB by SKU ID    ${SKU_ID}
    Create New Product    ${SKUName}    ${NewProductName}    ${BrandID}    ${MeterialID}    ${VariantOptionID}    ${VariantType}
    ...    ${StyleText}    ${StyleType}    ${StyleColor}
    #Set allow cod with product name    ${NewProductName}    ##เพิ่ม set payment channel cod
    ${CollectionID}=    Get Collection ID by PKey    ${CollectionPkey}
    Log To Console    collection id=${CollectionID}
    ${ProductID}=    Set Product Collection    ${NewProductName}    ${CollectionID}
    ${pkey}=    Get pkey from DB by Product ID    ${ProductID}
    Set Product Content    ${Key_Feature}    ${Description}    ${Caption}    ${Advantage}    ${ProductID}    ${pkey}
    ...    ${Img_ID_Original}
    Set SEO Content    ${SEOContent}    ${SEODescription}    ${SEOKeywords}    ${SEOTitle}    ${ProductID}
    ${VariantID}=    Get Variant ID from DB by SKU ID    ${SKU_ID}
    Set Price    ${ProductID}    ${VariantID}    ${SpecialPrice}    ${OldPrice}
    Set Payment    ${ProductID}    ${paymentMethods1}    ${paymentMethods2}
    Set Shipping    ${ProductID}    ${VariantID}    ${Weight}    ${DimensionWidth}    ${DimensionUnit}    ${DimensionLength}
    ...    ${DimensionHeight}
    Set Tag    ${ProductID}    ${Tag}
    Approve Product    ${ProductID}    ${SKUName}    ${NewProductName}    ${BrandID}    ${Productstatus}
    Publish Product    ${ProductID}
    Increase Stock    ${SKU_ID}    ${Stock_Quantity}    ${Stock_Note}    ${Stock_Total}

Create SKU Retail
    [Tags]    mai
    ${SKU_ID}    FMS Create New SKU with retail    LyraFixS16PM10011    BRAAC
    log to Console    ${SKU_ID}

Create Set Property Product
    [Tags]    mai1
    ${NewProductName}    Set Variable    LyraFixS16PM10011
    ${SKU_ID}            Set Variable    BRAAC1116111

    ${SKUName}    ${BrandCode}    ${BrandID}    ${VariantType}    ${VariantNameTH}    ${VariantNameEN}    ${VariantOptionID}
    ...    ${CollectionPkey}    ${Key_Feature}    ${Description}    ${Caption}    ${Advantage}    ${SEOContent}
    ...    ${SEODescription}    ${SEOKeywords}    ${SEOTitle}    ${StyleText}    ${StyleType}    ${StyleColor}
    ...    ${SpecialPrice}    ${OldPrice}    ${paymentMethods1}    ${paymentMethods2}    ${Weight}    ${DimensionWidth}
    ...    ${DimensionUnit}    ${DimensionLength}    ${DimensionHeight}    ${Tag}    ${VariantStatus}    ${SortOrder}
    ...    ${Productstatus}    ${Stock_Quantity}    ${Stock_Note}    ${Stock_Total}    ${variance}    ${Text_Email}
    ...    ${Text_Name}    ${Text_Phone}    ${Text_Address}    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}
    ...    ${Text_Code}    ${BrandName}    ${Img_ID_Original}    Test Data for Create Product1

    ${CollectionID}=    Get Collection ID by PKey    ${CollectionPkey}
    Log To Console    collection id=${CollectionID}
    ${ProductID}=    Set Product Collection    ${NewProductName}    ${CollectionID}
    ${pkey}=    Get pkey from DB by Product ID    ${ProductID}
    Set Product Content    ${Key_Feature}    ${Description}    ${Caption}    ${Advantage}    ${ProductID}    ${pkey}
    ...    ${Img_ID_Original}
    Set SEO Content    ${SEOContent}    ${SEODescription}    ${SEOKeywords}    ${SEOTitle}    ${ProductID}
    ${VariantID}=    Get Variant ID from DB by SKU ID    ${SKU_ID}
    Set Price    ${ProductID}    ${VariantID}    ${SpecialPrice}    ${OldPrice}
    Set Payment    ${ProductID}    ${paymentMethods1}    ${paymentMethods2}
    Set Shipping    ${ProductID}    ${VariantID}    ${Weight}    ${DimensionWidth}    ${DimensionUnit}    ${DimensionLength}
    ...    ${DimensionHeight}
    Set Tag    ${ProductID}    ${Tag}
    Approve Product    ${ProductID}    ${SKUName}    ${NewProductName}    ${BrandID}    ${Productstatus}
    Publish Product    ${ProductID}
    Increase Stock    ${SKU_ID}    ${Stock_Quantity}    ${Stock_Note}    ${Stock_Total}

create
    [Tags]    mai2
    ${NewProductName}    Set Variable    LyraFixS16PM10012
    #${SKU_ID}            Set Variable    BRAAR1114511
    ${SKUName}    ${BrandCode}    ${BrandID}    ${VariantType}    ${VariantNameTH}    ${VariantNameEN}    ${VariantOptionID}
    ...    ${CollectionPkey}    ${Key_Feature}    ${Description}    ${Caption}    ${Advantage}    ${SEOContent}
    ...    ${SEODescription}    ${SEOKeywords}    ${SEOTitle}    ${StyleText}    ${StyleType}    ${StyleColor}
    ...    ${SpecialPrice}    ${OldPrice}    ${paymentMethods1}    ${paymentMethods2}    ${Weight}    ${DimensionWidth}
    ...    ${DimensionUnit}    ${DimensionLength}    ${DimensionHeight}    ${Tag}    ${VariantStatus}    ${SortOrder}
    ...    ${Productstatus}    ${Stock_Quantity}    ${Stock_Note}    ${Stock_Total}    ${variance}    ${Text_Email}
    ...    ${Text_Name}    ${Text_Phone}    ${Text_Address}    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}
    ...    ${Text_Code}    ${BrandName}    ${Img_ID_Original}    Test Data for Create Product1

    ${SKU_ID}    FMS Create New SKU with retail    LyraFixS16PM10011    BRAAC
    ${MeterialID}=    Get Meterial ID frome DB by SKU ID    ${SKU_ID}
    Create New Product    ${SKUName}    ${NewProductName}    ${BrandID}    ${MeterialID}    ${VariantOptionID}    ${VariantType}
    ...    ${StyleText}    ${StyleType}    ${StyleColor}
    Set allow cod with product name    ${NewProductName}    ##เพิ่ม set payment channel cod
    ${CollectionID}=    Get Collection ID by PKey    ${CollectionPkey}
    Log To Console    collection id=${CollectionID}
    ${ProductID}=    Set Product Collection    ${NewProductName}    ${CollectionID}
    ${pkey}=    Get pkey from DB by Product ID    ${ProductID}x
    Set Product Content    ${Key_Feature}    ${Description}    ${Caption}    ${Advantage}    ${ProductID}    ${pkey}
    ...    ${Img_ID_Original}
    Set SEO Content    ${SEOContent}    ${SEODescription}    ${SEOKeywords}    ${SEOTitle}    ${ProductID}
    ${VariantID}=    Get Variant ID from DB by SKU ID    ${SKU_ID}
    Set Price    ${ProductID}    ${VariantID}    ${SpecialPrice}    ${OldPrice}
    Set Payment    ${ProductID}    ${paymentMethods1}    ${paymentMethods2}
    Set Shipping    ${ProductID}    ${VariantID}    ${Weight}    ${DimensionWidth}    ${DimensionUnit}    ${DimensionLength}
    ...    ${DimensionHeight}
    Set Tag    ${ProductID}    ${Tag}
    Approve Product    ${ProductID}    ${SKUName}    ${NewProductName}    ${BrandID}    ${Productstatus}
    Publish Product    ${ProductID}
    Increase Stock    ${SKU_ID}    ${Stock_Quantity}    ${Stock_Note}    ${Stock_Total}


*** Keywords ***
Test Data for Create Product1
    ${SKUName}    Set Variable    LyraFixS16PM10012
    ${BrandName}    Set Variable    BrandLyraS16
    ${BrandCode}    Set Variable    BRAAR
    ${BrandID}    Set Variable    925
    #AZAAA
    ${VariantType}    Set Variable    6
    ${VariantNameTH}    Set Variable    Color
    ${VariantNameEN}    Set Variable    Color
    ${VariantOptionID}    Set Variable    858
    ${CollectionPkey}    Set Variable    3783731534500
    ${Key_Feature}    Set Variable    test lyra
    ${Description}    Set Variable    test lyra
    ${Caption}    Set Variable    test lyra
    ${Advantage}    Set Variable    test lyra
    ${SEOContent}    Set Variable    test lyra
    ${SEODescription}    Set Variable    test lyra
    ${SEOKeywords}    Set Variable    test lyra
    ${SEOTitle}    Set Variable    test lyra
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
    ${Text_Email}    Set Variable    TestLYRA@mail.com
    ${Text_Name}    Set Variable    test
    ${Text_Phone}    Set Variable    0811111111
    ${Text_Address}    Set Variable    1111/1 AIA CAP Tower
    ${Text_CWName}    Set Variable    Test
    ${Text_CWCardNo}    Set Variable    5555555555554444
    ${Text_CWCCV}    Set Variable    123
    ${Text_Code}    Set Variable    ${EMPTY}    #Promotion Code
    ${Img_ID_Original}    Set Variable    Loki1000x1000
    #...    ${NewProductName}
    [Return]    ${SKUName}    ${BrandCode}    ${BrandID}    ${VariantType}    ${VariantNameTH}    ${VariantNameEN}
    ...    ${VariantOptionID}    ${CollectionPkey}    ${Key_Feature}    ${Description}    ${Caption}    ${Advantage}
    ...    ${SEOContent}    ${SEODescription}    ${SEOKeywords}    ${SEOTitle}    ${StyleText}    ${StyleType}
    ...    ${StyleColor}    ${SpecialPrice}    ${OldPrice}    ${paymentMethods1}    ${paymentMethods2}    ${Weight}
    ...    ${DimensionWidth}    ${DimensionUnit}    ${DimensionLength}    ${DimensionHeight}    ${Tag}    ${VariantStatus}
    ...    ${SortOrder}    ${Productstatus}    ${Stock_Quantity}    ${Stock_Note}    ${Stock_Total}    ${variance}
    ...    ${Text_Email}    ${Text_Name}    ${Text_Phone}    ${Text_Address}    ${Text_CWName}    ${Text_CWCardNo}
    ...    ${Text_CWCCV}    ${Text_Code}    ${BrandName}    ${Img_ID_Original}
