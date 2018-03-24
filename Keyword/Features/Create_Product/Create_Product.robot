*** Settings ***
Library           HttpLibrary.HTTP
Resource          ../../Database/PCMS/keyword_pcms.robot
Resource          ../../API/FMS/FMS_Create_SKU.robot
Resource          ../../API/FMS/keywords_fms_create_supplier.robot
Resource          ../../API/PCMS/Create_product/Create_product/Create_Product.robot
Library           ../../../Python_Library/DatabaseData.py

*** Keywords ***
Create Product Merket Place one variant
    [Arguments]    ${NewProductName}
    # ${NewProductName}
    ${SKUName}    ${BrandCode}    ${BrandID}    ${VariantType}    ${VariantNameTH}    ${VariantNameEN}    ${VariantOptionID}
    ...    ${CollectionPkey}    ${Key_Feature}    ${Description}    ${Caption}    ${Advantage}    ${SEOContent}
    ...    ${SEODescription}    ${SEOKeywords}    ${SEOTitle}    ${StyleText}    ${StyleType}    ${StyleColor}
    ...    ${SpecialPrice}    ${OldPrice}    ${paymentMethods1}    ${paymentMethods2}    ${Weight}    ${DimensionWidth}
    ...    ${DimensionUnit}    ${DimensionLength}    ${DimensionHeight}    ${Tag}    ${VariantStatus}    ${SortOrder}
    ...    ${Productstatus}    ${Stock_Quantity}    ${Stock_Note}    ${Stock_Total}    ${variance}    ${Text_Email}
    ...    ${Text_Name}    ${Text_Phone}    ${Text_Address}    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}
    ...    ${Text_Code}    ${BrandName}    ${Img_ID_Original}    Test Data for Create Product
    ${supplier_code}=    Create Supplier Marketplace From FMS
    ${SKU_ID}=    FMS create sku with marketplace    ${supplier_code}    ${SKUName}    ${BrandCode}
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
    [Return]    ${pkey}    ${SKU_ID}

Create Product Merket Place one variant choose collection
    [Arguments]    ${NewProductName}    ${Collection_Pkey}
    # ${NewProductName}
    ${SKUName}    ${BrandCode}    ${BrandID}    ${VariantType}    ${VariantNameTH}    ${VariantNameEN}    ${VariantOptionID}
    ...    ${CollectionPkey}    ${Key_Feature}    ${Description}    ${Caption}    ${Advantage}    ${SEOContent}
    ...    ${SEODescription}    ${SEOKeywords}    ${SEOTitle}    ${StyleText}    ${StyleType}    ${StyleColor}
    ...    ${SpecialPrice}    ${OldPrice}    ${paymentMethods1}    ${paymentMethods2}    ${Weight}    ${DimensionWidth}
    ...    ${DimensionUnit}    ${DimensionLength}    ${DimensionHeight}    ${Tag}    ${VariantStatus}    ${SortOrder}
    ...    ${Productstatus}    ${Stock_Quantity}    ${Stock_Note}    ${Stock_Total}    ${variance}    ${Text_Email}
    ...    ${Text_Name}    ${Text_Phone}    ${Text_Address}    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}
    ...    ${Text_Code}    ${BrandName}    ${Img_ID_Original}    Test Data for Create Product
    ${supplier_code}=    Create Supplier Marketplace From FMS
    Log To Console    supplier code=${supplier_code}
    ${SKU_ID}=    FMS create sku with marketplace    ${supplier_code}    ${SKUName}    ${BrandCode}
    ${MeterialID}=    Get Meterial ID frome DB by SKU ID    ${SKU_ID}
    Create New Product    ${SKUName}    ${NewProductName}    ${BrandID}    ${MeterialID}    ${VariantOptionID}    ${VariantType}
    ...    ${StyleText}    ${StyleType}    ${StyleColor}
    #Set allow cod with product name    ${NewProductName}    ##เพิ่ม set payment channel cod
    ${CollectionID}=    Get Collection ID by PKey    ${Collection_Pkey}
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
    [Return]    ${pkey}    ${SKU_ID}

Create Product Retail one variant choose collection
    [Arguments]    ${NewProductName}    ${Collection_Pkey}
    # ${NewProductName}
    ${SKUName}    ${BrandCode}    ${BrandID}    ${VariantType}    ${VariantNameTH}    ${VariantNameEN}    ${VariantOptionID}
    ...    ${CollectionPkey}    ${Key_Feature}    ${Description}    ${Caption}    ${Advantage}    ${SEOContent}
    ...    ${SEODescription}    ${SEOKeywords}    ${SEOTitle}    ${StyleText}    ${StyleType}    ${StyleColor}
    ...    ${SpecialPrice}    ${OldPrice}    ${paymentMethods1}    ${paymentMethods2}    ${Weight}    ${DimensionWidth}
    ...    ${DimensionUnit}    ${DimensionLength}    ${DimensionHeight}    ${Tag}    ${VariantStatus}    ${SortOrder}
    ...    ${Productstatus}    ${Stock_Quantity}    ${Stock_Note}    ${Stock_Total}    ${variance}    ${Text_Email}
    ...    ${Text_Name}    ${Text_Phone}    ${Text_Address}    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}
    ...    ${Text_Code}    ${BrandName}    ${Img_ID_Original}    Test Data for Create Product
    Log To Console    brand code=${BrandCode}
    ${SKU_ID}=    FMS Create New SKU with retail    ${SKUName}    ${BrandCode}
    ${MeterialID}=    Get Meterial ID frome DB by SKU ID    ${SKU_ID}
    Log To Console    brand id=${BrandID}
    Create New Product    ${SKUName}    ${NewProductName}    ${BrandID}    ${MeterialID}    ${VariantOptionID}    ${VariantType}
    ...    ${StyleText}    ${StyleType}    ${StyleColor}
    ${CollectionID}=    Get Collection ID by PKey    ${Collection_Pkey}
    Log To Console    collection_id=${CollectionID}
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
    [Return]    ${pkey}    ${SKU_ID}

Create Product Retail one variant
    [Arguments]    ${NewProductName}
    # ${NewProductName}
    ${SKUName}    ${BrandCode}    ${BrandID}    ${VariantType}    ${VariantNameTH}    ${VariantNameEN}    ${VariantOptionID}
    ...    ${CollectionPkey}    ${Key_Feature}    ${Description}    ${Caption}    ${Advantage}    ${SEOContent}
    ...    ${SEODescription}    ${SEOKeywords}    ${SEOTitle}    ${StyleText}    ${StyleType}    ${StyleColor}
    ...    ${SpecialPrice}    ${OldPrice}    ${paymentMethods1}    ${paymentMethods2}    ${Weight}    ${DimensionWidth}
    ...    ${DimensionUnit}    ${DimensionLength}    ${DimensionHeight}    ${Tag}    ${VariantStatus}    ${SortOrder}
    ...    ${Productstatus}    ${Stock_Quantity}    ${Stock_Note}    ${Stock_Total}    ${variance}    ${Text_Email}
    ...    ${Text_Name}    ${Text_Phone}    ${Text_Address}    ${Text_CWName}    ${Text_CWCardNo}    ${Text_CWCCV}
    ...    ${Text_Code}    ${BrandName}    ${Img_ID_Original}    Test Data for Create Product
    Log To Console    brand code=${BrandCode}
    ${SKU_ID}=    FMS Create New SKU with retail    ${SKUName}    ${BrandCode}
    ${MeterialID}=    Get Meterial ID frome DB by SKU ID    ${SKU_ID}
    Log To Console    brand id=${BrandID}
    Create New Product    ${SKUName}    ${NewProductName}    ${BrandID}    ${MeterialID}    ${VariantOptionID}    ${VariantType}
    ...    ${StyleText}    ${StyleType}    ${StyleColor}
    ${CollectionID}=    Get Collection ID by PKey    ${CollectionPkey}
    Log To Console    collection_id=${CollectionID}
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
    [Return]    ${pkey}    ${SKU_ID}

Test Data for Create Product
    ${epoch_short}=    Get current epoch time short
    # ${NewProductName}    Set Variable    Product_For_Flash_Test_Automate2
    ${SKUName}    Set Variable    Flash_${epoch_short}
    ${BrandName}    Set Variable    Accessorize
    ${BrandCode}    Set Variable    ACAAC
    ${BrandID}    Set Variable    560
    #AZAAA
    ${VariantType}    Set Variable    1
    ${VariantNameTH}    Set Variable    Color
    ${VariantNameEN}    Set Variable    Color
    ${VariantOptionID}    Set Variable    90
    ${CollectionPkey}    Set Variable    11111
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
    #...    ${NewProductName}
    [Return]    ${SKUName}    ${BrandCode}    ${BrandID}    ${VariantType}    ${VariantNameTH}    ${VariantNameEN}
    ...    ${VariantOptionID}    ${CollectionPkey}    ${Key_Feature}    ${Description}    ${Caption}    ${Advantage}
    ...    ${SEOContent}    ${SEODescription}    ${SEOKeywords}    ${SEOTitle}    ${StyleText}    ${StyleType}
    ...    ${StyleColor}    ${SpecialPrice}    ${OldPrice}    ${paymentMethods1}    ${paymentMethods2}    ${Weight}
    ...    ${DimensionWidth}    ${DimensionUnit}    ${DimensionLength}    ${DimensionHeight}    ${Tag}    ${VariantStatus}
    ...    ${SortOrder}    ${Productstatus}    ${Stock_Quantity}    ${Stock_Note}    ${Stock_Total}    ${variance}
    ...    ${Text_Email}    ${Text_Name}    ${Text_Phone}    ${Text_Address}    ${Text_CWName}    ${Text_CWCardNo}
    ...    ${Text_CWCCV}    ${Text_Code}    ${BrandName}    ${Img_ID_Original}

Insert collection
    ${CollectionPkey}    Set Variable    11111
    ${total_row_colelction}=    Get collection row    ${CollectionPkey}
    Log To Console    insert coll log=${total_row_colelction}
    Run Keyword If    ${total_row_colelction} == 0    Run Keywords    Log To Console    test=1
    ...    AND    insert_collection_for_create_prod

Get collection row
    [Arguments]    ${CollectionPkey}
    Connect DB ITM
    ${total_row_colelction}=    Query    SELECT count(id) FROM `collections` where`pkey` ='${CollectionPkey}'
    #log    ${total_row_colelction}
    Log To Console    test=${total_row_colelction[0][0]}
    [Return]    ${total_row_colelction[0][0]}

Get Collection ID by PKey
    [Arguments]    ${CollectionPkey}
    Connect DB ITM
    ${CollectionID}=    Query    SELECT id FROM `collections` where`pkey` ='${CollectionPkey}'
    #log    ${CollectionID[0][0]}
    [Return]    ${CollectionID[0][0]}

Get product id form product pkey
    [Arguments]    ${product_pkey}
    Connect DB ITM
    ${product_id}=    Query    SELECT id FROM `products` where`pkey` ='${product_pkey}'
    #log    ${total_row_product}
    Log To Console    product_id=${product_id[0][0]}
    [Return]    ${product_id[0][0]}

Get product row form product
    [Arguments]    ${product_name}
    Connect DB ITM
    ${total_row_product}=    Query    SELECT count(id) FROM `products` where`title` ='${product_name}'
    #log    ${total_row_product}
    Log To Console    test=${total_row_product[0][0]}
    [Return]    ${total_row_product[0][0]}

Get pkey product by product name
    [Arguments]    ${product_name}
    Connect DB ITM
    ${pkey}=    Query    SELECT pkey FROM `products` where`title` ='${product_name}'
    #log    ${total_row_product}
    Log To Console    product pkey=${pkey[0][0]}
    [Return]    ${pkey[0][0]}

Get product name by product key
    [Arguments]    ${product_key}
    Connect DB ITM
    ${product_name}=    Query    SELECT title FROM `products` where `pkey` ='${product_key}'
    #log    ${total_row_product}
    Log To Console    product name=${product_name[0][0]}
    [Return]    ${product_name[0][0]}

Get product key delete at
    Connect DB ITM
    ${product_pkey}=    Query    SELECT pkey FROM `products` where `deleted_at` is not null LIMIT 1 ;
    #log    ${CollectionID[0][0]}
    [Return]    ${product_pkey[0][0]}

Insert product with marketplace type
    ${ProductName}    Set Variable    THOR_robot_cs
    ${total_row_product}=    Get product row form product    ${ProductName}
    Log To Console    insert coll log=${total_row_product}
    Run Keyword If    ${total_row_product} == 0    Run Keywords    Log To Console    test loop
    ...    AND    Create Product Merket Place one variant    ${ProductName}
    ${pkey}=    Get pkey product by product name    ${ProductName}
    [Return]    ${pkey}

Insert another product with marketplace type
    ${ProductName}    Set Variable    Product For stark Test Automate merket place5
    ${total_row_product}=    Get product row form product    ${ProductName}
    Log To Console    insert coll log=${total_row_product}
    Run Keyword If    ${total_row_product} == 0    Run Keywords    Log To Console    test loop
    ...    AND    Create Product Merket Place one variant    ${ProductName}
    ${pkey}=    Get pkey product by product name    ${ProductName}
    [Return]    ${pkey}

Insert product with retail type
    ${ProductName}    Set Variable    THOR_robot_cs
    ${total_row_product}=    Get product row form product    ${ProductName}
    Log To Console    insert coll log=${total_row_product}
    Run Keyword If    ${total_row_product} == 0    Run Keywords    Log To Console    test loop
    ...    AND    Create Product Retail one variant    ${ProductName}
    ${pkey}=    Get pkey product by product name    ${ProductName}
    Log To Console    pkey retail=${pkey}
    [Return]    ${pkey}

Insert another product with retail type
    ${ProductName}    Set Variable    Product For stark Test Automate retail5
    ${total_row_product}=    Get product row form product    ${ProductName}
    Log To Console    insert coll log=${total_row_product}
    Run Keyword If    ${total_row_product} == 0    Run Keywords    Log To Console    test loop
    ...    AND    Create Product Retail one variant    ${ProductName}
    ${pkey}=    Get pkey product by product name    ${ProductName}
    Log To Console    pkey retail=${pkey}
    [Return]    ${pkey}

Insert products by name with marketplace type
    [Arguments]    ${ProductName}
    ${total_row_product}=    Get product row form product    ${ProductName}
    Log To Console    insert coll log=${total_row_product}
    Run Keyword If    ${total_row_product} == 0    Run Keywords    Log To Console    test loop
    ...    AND    Create Product Merket Place one variant    ${ProductName}
    ${pkey}=    Get pkey product by product name    ${ProductName}
    [Return]    ${pkey}

Insert products by name with retail type
    [Arguments]    ${ProductName}
    ${total_row_product}=    Get product row form product    ${ProductName}
    Log To Console    insert coll log=${total_row_product}
    Run Keyword If    ${total_row_product} == 0    Run Keywords    Log To Console    test loop
    ...    AND    Create Product Retail one variant    ${ProductName}
    ${pkey}=    Get pkey product by product name    ${ProductName}
    Log To Console    pkey retail=${pkey}
    [Return]    ${pkey}

Insert products by name and collection with marketplace type
    [Arguments]    ${ProductName}    ${collection_key}
    ${total_row_product}=    Get product row form product    ${ProductName}
    Log To Console    insert coll log=${total_row_product}
    Run Keyword If    ${total_row_product} == 0    Run Keywords    Log To Console    test loop
    ...    AND    Create Product Merket Place one variant choose collection    ${ProductName}    ${collection_key}
    ${pkey}=    Get pkey product by product name    ${ProductName}
    Log To Console    market place=${pkey}
    [Return]    ${pkey}

Insert products by name and collection with retail type
    [Arguments]    ${ProductName}    ${collection_key}
    ${total_row_product}=    Get product row form product    ${ProductName}
    Log To Console    insert coll log=${total_row_product}
    Run Keyword If    ${total_row_product} == 0    Run Keywords    Log To Console    test loop
    ...    AND    Create Product Retail one variant choose collection    ${ProductName}    ${collection_key}
    ${pkey}=    Get pkey product by product name    ${ProductName}
    Log To Console    pkey retail=${pkey}
    [Return]    ${pkey}
