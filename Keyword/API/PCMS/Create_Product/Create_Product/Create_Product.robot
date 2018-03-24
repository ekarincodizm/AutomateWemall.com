*** Settings ***
Library           HttpLibrary.HTTP
Resource          ../../../../Database/PCMS/keyword_pcms.robot
Resource          ../../Stock/keywords_stock.robot
Resource          ../../../../Common/Keywords_Common.robot

*** Keywords ***
Generate Test Data for Create Product
    [Arguments]    ${brand_id}=145    ${variant_type}=6    ${variant_option_id}=858    ${collection_id}=331
    ${epoch_short}=    Get current epoch time short
    &{dict}=    Create Dictionary    new_product_name=E2E_${epoch_short}    sku_name=E2E_${epoch_short}    brand_name=TestE2E    brand_id=${brand_id}    variant_type=${variant_type}
    ...    variant_name_th=Color    variant_name_en=Color    variant_option_id=${variant_option_id}    collection_id=${collection_id}    key_feature=test e2e    description=test e2e
    ...    caption=test e2e    advantage=test e2e    seo_content=test e2e    seo_description=test e2e    seo_keywords=test e2e    seo_title=test e2e
    ...    style_text=Gold    style_type=color    style_color=Gold    special_price=600    old_price=1000    payment_methods1=1
    ...    payment_methods2=8    weight=15    dimension_width=45    dimension_unit=45    dimension_length=45    dimension_height=45
    ...    tag=Test,E2E    variant_status=active    sort_order=1    product_status=1    stock_quantity=1000    stock_note=test e2e
    ...    stock_total=1000    variance=${EMPTY}    text_email=TestE2E@mail.com    text_name=test    text_phone=0811111111    text_address=1111/1 AIA CAP Tower
    ...    text_cw_name=Test    text_cw_card_no=5555555555554444    text_cw_ccv=123    text_code=${EMPTY}    img_id_original=Loki1000x1000    #1.Credit Card (CCW) \ \ \ 2.Truemoney Ewallet (EW) \ \ \ 4.bank ATM (ATM) \ \ \ 5.IBANK (IBANK) \ \ \ 6.BANKTRANS (BKTRANS) \ \ \ 8.Counter service (CS) \ \ 11. \ Wallet by TrueMoney (TMN_WALLET)
    ...    #1 Active 2 inactive    #Variant Item (1,2,3)    #Promotion Code
    [Return]    ${dict}

Create Product Bypassing FMS
    [Arguments]    ${product}    ${shop_code}    ${shop_name}    ${sku_id}
    [Documentation]    This keyword simulate the request sent from FMS to PCMS when creating new SKU in FMS.
    ...    IMPORTANT: Product created by this keyword cannot be purchased since FMS has no information of the SKU;
    ...    therefore, this keyword should not be used for end-to-end test
    Create New Sku Bypass FMS    ${shop_code}    ${shop_name}    ${sku_id}    ${product.sku_name}    ${product.style_color}    ${product.brand_id}
    ...    ${product.special_price}    piece    ${EMPTY}    ${product.old_price}    ${EMPTY}    ${EMPTY}
    ${material_id}=    Get Meterial ID frome DB by SKU ID    ${SKU_ID}
    Create New Product    ${product.sku_name}    ${product.new_product_name}    ${product.brand_id}    ${material_id}    ${product.variant_option_id}    ${product.variant_type}
    ...    ${product.style_text}    ${product.style_type}    ${product.style_color}
    ${product_id}=    Set Product Collection    ${product.new_product_name}    ${product.collection_id}
    ${pkey}=    Get pkey from DB by Product ID    ${product_id}
    Set Product Content    ${product.key_feature}    ${product.description}    ${product.caption}    ${product.advantage}    ${product_id}    ${pkey}
    ...    ${product.img_id_original}
    Set SEO Content    ${product.seo_content}    ${product.seo_description}    ${product.seo_keywords}    ${product.seo_title}    ${product_id}
    ${variant_id}=    Get Variant ID from DB by SKU ID    ${SKU_ID}
    Set Price    ${product_id}    ${variant_id}    ${product.special_price}    ${product.old_price}
    Set Payment    ${product_id}    ${product.payment_methods1}    ${product.payment_methods2}
    Set Shipping    ${product_id}    ${variant_id}    ${product.weight}    ${product.dimension_width}    ${product.dimension_unit}    ${product.dimension_length}
    ...    ${product.dimension_height}
    Set Tag    ${product_id}    ${product.tag}
    Approve Product    ${product_id}    ${product.sku_name}    ${product.new_product_name}    ${product.brand_id}    ${product.product_status}
    Publish Product    ${product_id}
    Increase Stock    ${SKU_ID}    ${product.stock_quantity}    ${product.stock_note}    ${product.stock_total}

Create New Sku Bypass FMS
    [Arguments]    ${shop_code}    ${shop_name}    ${sku}    ${name}    ${color}    ${brand}
    ...    ${special_price}    ${unit_type}    ${material_code}    ${selling_price}    ${cat_id}    ${size}
    [Documentation]    This keyword simulate the request sent from FMS to PCMS when creating new SKU in FMS.
    ...    IMPORTANT: Product created by this keyword cannot be purchased since FMS has no information of the SKU;
    ...    therefore, this keyword should not be used for end-to-end test
    Create Http Context    ${PCMS_API_URL}    http
    Set Request Header    Content-Type    application/json
    ${request_data}=    Set Variable    [{"shop_code": "${shop_code}","shop_name": "${shop_name}","sku": "${sku}","name": "${name}","color":"${color}", "brand": "${brand}","special_price": "${special_price}","unit_type": "${unit_type}","material_code": "${material_code}","selling_price": "${selling_price}","category_id": "${cat_id}","size": "${size}"}]
    Set Request Body    ${request_data}
    HttpLibrary.HTTP.POST    /api/v4/sku/create
    ${response}=    Get Response Body
    [Return]    ${response}

Create New Product
    [Arguments]    ${SKUName}    ${NewProductName}    ${BrandID}    ${MeterialID}    ${VariantOptionID}    ${VariantType}
    ...    ${StyleText}    ${StyleType}    ${StyleColor}
    [Documentation]    After the sku is created in FMS (or with the "Create New Sku Bypass FMS" keyword), this keyword
    ...    will pick that sku and create a product in PCMS.
    ...    BrandID, MaterialID, VariantOptionID, and VariantType must be existed value in the database
    Create Http Context    ${PCMS_URL_API}    http
    Set Request Header    Connection    keep-alive
    Set Request Header    Location    ${PCMS_URL}/products/new-material/index
    Set Request Body    email=${PCMS_USERNAME}&password=${PCMS_PASSWORD}
    HttpLibrary.HTTP.POST    /auth/login
    ${result}=    Get Response Body
    Follow Response
    ${status}    Get Response Status
    Should Start With    ${status}    200
    #Create New Product
    Set Request Header    Location    ${PCMS_URL}/products/new-material/index
    Log to console    create=create&line_sheet=${SKUName}&product_name=${NewProductName}&translate[title][en_US]=${SKUName}&action=Create&brand=${BrandID}
    Set Request Body    create=create&line_sheet=${SKUName}&product_name=${NewProductName}&translate[title][en_US]=${SKUName}&action=Create&brand=${BrandID}
    HttpLibrary.HTTP.POST    /products/new-material/index
    Follow Response
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    200
    #Choose Meterial
    Set Request Header    Location    ${PCMS_URL}/products/new-material/step3
    Set Request Body    id[]=${MeterialID}&pick=${MeterialID}
    HttpLibrary.HTTP.POST    /products/new-material/step2
    Follow Response
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    200
    #Manage Variant Type
    Set Request Header    Location    ${PCMS_URL}/products/new-material/step4
    Set Request Body    selectType[]=${VariantType}
    HttpLibrary.HTTP.POST    /products/new-material/step3
    Follow Response
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    200
    #Create Style Option
    Comment    Set Request Header    Location    ${PCMS_URL}/products/new-material/create-style-option/6
    Comment    Set Request Body    text=${StyleText}&meta_type=${StyleType}&meta_color=${StyleColor}
    Comment    HttpLibrary.HTTP.POST    /products/new-material/create-style-option/6
    Comment    ${result}=    Get Response Body
    Comment    ${status}    Get Response Status
    Comment    Should Start With    ${status}    200
    #Set Variant Option
    Set Request Header    Location    ${PCMS_URL}/products/new-material/summary
    Set Request Body    material_option[${MeterialID}][1]=${VariantOptionID}
    HttpLibrary.HTTP.POST    /products/new-material/step4
    Follow Response
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    200

Set Product Collection
    [Arguments]    ${NewProductName}    ${CollectionID}
    Create Http Context    ${PCMS_URL_API}    http
    Set Request Header    Connection    keep-alive
    #Login
    Set Request Header    Location    ${PCMS_URL}/products/new-material/index
    Set Request Body    email=${PCMS_USERNAME}&password=${PCMS_PASSWORD}
    HttpLibrary.HTTP.POST    /auth/login
    ${result}=    Get Response Body
    Follow Response
    ${status}    Get Response Status
    Should Start With    ${status}    200
    #Query Product ID from DB
    Connect DB ITM
    ${ProductID}=    Query    SELECT ID FROM `products` where `title` = '${NewProductName}'
    log    ${ProductID[0][0]}
    #Set Product Collection
    Set Request Header    Location    ${PCMS_URL}/products/collection
    Set Request Body    collection[]=${CollectionID}
    HttpLibrary.HTTP.POST    /products/collection/set/${ProductID[0][0]}?return-collection=
    Follow Response
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    200
    [Return]    ${ProductID[0][0]}

Set Product Content
    [Arguments]    ${Key_Feature}    ${Description}    ${Caption}    ${Advantage}    ${ProductID}    ${pkey}
    ...    ${Img_ID_Original}
    Create Http Context    ${PCMS_URL_API}    http
    Set Request Header    Connection    keep-alive
    #Login
    Set Request Header    Location    ${PCMS_URL}/products/new-material/index
    Set Request Body    email=${PCMS_USERNAME}&password=${PCMS_PASSWORD}
    HttpLibrary.HTTP.POST    /auth/login
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    302
    Follow Response
    #Set Product Content
    Set Request Header    Location    ${PCMS_URL}/products/set-content
    Set Request Body    key_feature=<p>${Key_Feature}<p>&description=<p>${Description}<p>&caption=${Caption}&advantage=${Advantage}&media-set=6
    HttpLibrary.HTTP.POST    /products/set-content/edit/${ProductID}
    Follow Response
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    200
    Insert Image from Attachment table to Media Contents Table    ${pkey}    ${ProductID}    ${Img_ID_Original}
    #Query Pri Revision ID from DB
    Connect DB ITM
    ${ContentRevisionID}=    Query    SELECT id FROM `revisions` where`revisionable_id` ='${ProductID}'
    log    ${ContentRevisionID[0][0]}
    #Approve Content
    Set Request Header    Location    ${PCMS_URL}/products/approve
    Set Request Body    status=approved
    HttpLibrary.HTTP.POST    /products/approve/detail/${ProductID}/${ContentRevisionID[0][0]}
    Follow Response
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    200

Set SEO Content
    [Arguments]    ${SEOContent}    ${SEODescription}    ${SEOKeywords}    ${SEOTitle}    ${ProductID}
    Create Http Context    ${PCMS_URL_API}    http
    Set Request Header    Connection    keep-alive
    Set Request Body    seo_content=<p>${SEOContent}<p>&seo_description=${SEODescription}&seo_keywords=${SEOKeywords}&seo_title=${SEOTitle}&seoable_id=${ProductID}&seoable_type=Product
    HttpLibrary.HTTP.POST    /seo/edit
    Follow Response
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    200

Set Price
    [Arguments]    ${ProductID}    ${VariantID}    ${SpecialPrice}    ${OldPrice}
    Create Http Context    ${PCMS_URL_API}    http
    Set Request Header    Connection    keep-alive
    #Login
    Set Request Header    Location    ${PCMS_URL}/products/new-material/index
    Set Request Body    email=${PCMS_USERNAME}&password=${PCMS_PASSWORD}
    HttpLibrary.HTTP.POST    /auth/login
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    302
    Follow Response
    #Set Price
    Set Request Header    Location    ${PCMS_URL}/products/set-price/edit/${ProductID}
    Set Request Body    special_price[${VariantID}]=${SpecialPrice}&old_price[${VariantID}]=${OldPrice}
    HttpLibrary.HTTP.POST    /products/set-price/edit/${ProductID}
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    302
    Follow Response
    #Query Pri Revision ID from DB
    Connect DB ITM
    ${PriceRevisionID}=    Query    SELECT id FROM `revisions` where`revisionable_id` ='${ProductID}'
    log    ${PriceRevisionID[0][0]}
    #Approve Price
    Set Request Header    Location    ${PCMS_URL}/products/approve
    Set Request Body    status=approved
    HttpLibrary.HTTP.POST    /products/approve/detail/${ProductID}/${PriceRevisionID[0][0]}
    Follow Response
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    200

Set Payment
    [Arguments]    ${ProductID}    ${paymentMethods1}    ${paymentMethods2}
    Create Http Context    ${PCMS_URL_API}    http
    Set Request Header    Connection    keep-alive
    Set Request Header    content-type    application/x-www-form-urlencoded
    #Login
    Set Request Header    Location    ${PCMS_URL}/products/new-material/index
    Set Request Body    email=${PCMS_USERNAME}&password=${PCMS_PASSWORD}
    HttpLibrary.HTTP.POST    /auth/login
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    302
    Follow Response
    #Set Payment
    Set Request Header    Location    ${PCMS_URL}/products/set-payment/edit/${ProductID}
    Set Request Header    Referer    ${PCMS_URL}/products/set-payment/edit/${ProductID}
    Set Request Body    paymentMethods[]=${paymentMethods1}&paymentMethods[]=${paymentMethods2}
    HttpLibrary.HTTP.POST    /products/set-payment/edit/${ProductID}
    Follow Response
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    200
    #Query Pri Revision ID from DB
    Connect DB ITM
    ${PaymentRevisionID}=    Query    SELECT id FROM `revisions` where`revisionable_id` ='${ProductID}'
    log    ${PaymentRevisionID[0][0]}
    #Approve Payment
    Set Request Header    Location    ${PCMS_URL}/products/approve
    Set Request Body    status=approved
    HttpLibrary.HTTP.POST    /products/approve/detail/${ProductID}/${PaymentRevisionID[0][0]}
    Follow Response
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    200

Set Shipping
    [Arguments]    ${ProductID}    ${VariantID}    ${Weight}    ${DimensionWidth}    ${DimensionUnit}    ${DimensionLength}
    ...    ${DimensionHeight}
    Create Http Context    ${PCMS_URL_API}    http
    Set Request Header    Connection    keep-alive
    #Login
    Set Request Header    Location    ${PCMS_URL}/products/new-material/index
    Set Request Body    email=${PCMS_USERNAME}&password=${PCMS_PASSWORD}
    HttpLibrary.HTTP.POST    /auth/login
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    302
    Follow Response
    #Set Shipping
    Set Request Header    Location    ${PCMS_URL}/products/set-shipping/edit/${ProductID}
    Set Request Body    weight[${VariantID}]=${Weight}&vid[${VariantID}]=${VariantID}&dimension_width[${VariantID}]=${DimensionWidth}&dimension_unit[${VariantID}]=${DimensionUnit}&dimension_length[${VariantID}]=${DimensionLength}&dimension_height[${VariantID}]=${DimensionHeight}
    HttpLibrary.HTTP.POST    /products/set-shipping/edit/${ProductID}
    ${result}=    Get Response Body
    Follow Response
    ${status}    Get Response Status
    Should Start With    ${status}    200

Set Tag
    [Arguments]    ${ProductID}    ${Tag}
    Create Http Context    ${PCMS_URL_API}    http
    Set Request Header    Connection    keep-alive
    #Login
    Set Request Header    Location    ${PCMS_URL}/products/new-material/index
    Set Request Body    email=${PCMS_USERNAME}&password=${PCMS_PASSWORD}
    HttpLibrary.HTTP.POST    /auth/login
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    302
    Follow Response
    #Set Tag
    Set Request Header    Location    ${PCMS_URL}/products/set-tag/edit/${ProductID}
    Set Request Header    Referer    ${PCMS_URL}/products/set-tag/edit/${ProductID}
    Set Request Body    tag=${Tag}
    HttpLibrary.HTTP.POST    /products/set-tag/edit/${ProductID}
    ${status}    Get Response Status
    Should Start With    ${status}    302

Approve Product
    [Arguments]    ${ProductID}    ${SKUName}    ${NewProductName}    ${BrandID}    ${Productstatus}
    Create Http Context    ${PCMS_URL_API}    http
    Set Request Header    Connection    keep-alive
    #Login
    Set Request Header    Location    ${PCMS_URL}/products/new-material/index
    Set Request Body    email=${PCMS_USERNAME}&password=${PCMS_PASSWORD}
    HttpLibrary.HTTP.POST    /auth/login
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    302
    Follow Response
    #Active Product
    Set Request Header    Location    ${PCMS_URL}/products/edit/${ProductID}
    Set Request Header    Referer    ${PCMS_URL}/products/edit/${ProductID}
    Set Request Body    title=${NewProductName}&translate[title][en_US]=${SKUName}&brand=${BrandID}&active=${Productstatus}
    HttpLibrary.HTTP.POST    /products/edit/${ProductID}
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    302
    Follow Response
    #Query Pri Revision ID from DB
    Connect DB ITM
    ${ApproveRevisionID}=    Query    SELECT id FROM `revisions` where`revisionable_id` ='${ProductID}'
    log    ${ApproveRevisionID[0][0]}
    #Approve Active
    Set Request Header    Location    ${PCMS_URL}/products/approve
    Set Request Header    Referer    ${PCMS_URL}/products/approve/detail/${ProductID}/${ApproveRevisionID[0][0]}
    Set Request Body    status=approved
    HttpLibrary.HTTP.POST    /products/approve/detail/${ProductID}/${ApproveRevisionID[0][0]}
    Follow Response
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    200

Publish Product
    [Arguments]    ${ProductID}
    Create Http Context    ${PCMS_URL_API}    http
    Set Request Header    Connection    keep-alive
    #Login
    Set Request Header    Location    ${PCMS_URL}/products/new-material/index
    Set Request Body    email=${PCMS_USERNAME}&password=${PCMS_PASSWORD}
    HttpLibrary.HTTP.POST    /auth/login
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    302
    Follow Response
    #Query Pri Revision ID from DB
    Connect DB ITM
    ${PublishRevisionID}=    Query    SELECT id FROM `revisions` where`revisionable_id` ='${ProductID}'
    log    ${PublishRevisionID[0][0]}
    #publish Product
    Set Request Header    Location    ${PCMS_URL}/products/approve/detail/${ProductID}/${PublishRevisionID[0][0]}
    Set Request Header    Referer    ${PCMS_URL}/products/approve/publish/${ProductID}/${PublishRevisionID[0][0]}
    HttpLibrary.HTTP.POST    /products/approve/publish/${ProductID}/${PublishRevisionID[0][0]}
    Follow Response
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    200

Set Price THOR
    [Arguments]    ${ProductID}    ${VariantID}    ${SpecialPrice}    ${OldPrice}
    Create Http Context    ${PCMS_URL_API}    http
    Set Request Header    Connection    keep-alive
    #Login
    Set Request Header    Location    ${PCMS_URL}/products/new-material/index
    Set Request Body    email=${PCMS_USERNAME}&password=${PCMS_PASSWORD}
    HttpLibrary.HTTP.POST    /auth/login
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    302
    Follow Response
    #Set Price
    Set Request Header    Location    ${PCMS_URL}/products/set-price/edit/${ProductID}
    Set Request Body    special_price[${VariantID}]=${SpecialPrice}&old_price[${VariantID}]=${OldPrice}
    HttpLibrary.HTTP.POST    /products/set-price/edit/${ProductID}
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    302
    Follow Response
    Approve Product THOR    ${ProductID}
    Publish Product THOR    ${ProductID}

Approve Product THOR
    [Arguments]    ${ProductID}
    Log To Console    ${PCMS_USERNAME}
    #Query Pri Revision ID from DB'
    Create Http Context    ${PCMS_URL_API}    http
    Set Request Header    Connection    keep-alive
    #Login
    Set Request Header    Location    ${PCMS_URL}/products/new-material/index
    Set Request Body    email=${PCMS_USERNAME}&password=${PCMS_PASSWORD}
    HttpLibrary.HTTP.POST    /auth/login
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    302
    Follow Response
    Connect DB ITM
    ${ApproveRevisionID}=    Query    SELECT id FROM `revisions` where`revisionable_id` ='${ProductID}' AND `status` = 'draft' ORDER BY id DESC LIMIT 0,1
    log    ${ApproveRevisionID[0][0]}
    Log to Console    ${ApproveRevisionID[0][0]}
    #Approve Active
    Set Request Header    Location    ${PCMS_URL}/products/approve
    Set Request Header    Referer    ${PCMS_URL}/products/approve/detail/${ProductID}/${ApproveRevisionID[0][0]}
    Set Request Body    status=approved
    HttpLibrary.HTTP.POST    /products/approve/detail/${ProductID}/${ApproveRevisionID[0][0]}
    Follow Response
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    200

Publish Product THOR
    [Arguments]    ${ProductID}
    Create Http Context    ${PCMS_URL_API}    http
    Set Request Header    Connection    keep-alive
    #Login
    Set Request Header    Location    ${PCMS_URL}/products/new-material/index
    Set Request Body    email=${PCMS_USERNAME}&password=${PCMS_PASSWORD}
    HttpLibrary.HTTP.POST    /auth/login
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    302
    Follow Response
    #Query Pri Revision ID from DB
    Connect DB ITM
    ${PublishRevisionID}=    Query    SELECT id FROM `revisions` where `revisionable_id` = '${ProductID}' AND `status` = 'approved' ORDER BY id DESC LIMIT 0,1
    log    ${PublishRevisionID[0][0]}
    #publish Product
    Set Request Header    Location    ${PCMS_URL}/products/approve/detail/${ProductID}/${PublishRevisionID[0][0]}
    Set Request Header    Referer    ${PCMS_URL}/products/approve/publish/${ProductID}/${PublishRevisionID[0][0]}
    HttpLibrary.HTTP.POST    /products/approve/publish/${ProductID}/${PublishRevisionID[0][0]}
    Follow Response
    ${result}=    Get Response Body
    ${status}    Get Response Status
    Should Start With    ${status}    200

Set Price From Inventory THOR
    [Arguments]    ${inventory_id}    ${special_price}    ${normal_price}
    ${product_id}    Get Product Id    ${inventory_id}
    ${variant_id}    Get Variant ID from DB by SKU ID    ${inventory_id}
    ${product_price}=    Query    SELECT id, price, normal_price FROM `variants` where`product_id` ='${product_id}' AND deleted_at IS NULL
    ${items}=    Get Length    ${product_price}
    : FOR    ${index}    IN RANGE    0    ${items}
    \    ${row}=    Get From List    ${product_price}    ${index}
    \    ${variant_id}=    Get From List    ${row}    0
    \    ${special_price_db}=    Get From List    ${row}    1
    \    ${normal_price_db}=    Get From List    ${row}    2
    \    ${special_price_db}=    Convert To String    ${special_price_db}
    \    ${normal_price_db}=    Convert To String    ${normal_price_db}
    \    Run Keyword If    ${special_price} != ${special_price_db} or ${normal_price} != ${normal_price_db}    Set Price THOR    ${product_id}    ${variant_id}    ${special_price}
    \    ...    ${normal_price}
