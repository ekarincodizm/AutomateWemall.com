*** Settings ***
Library           Selenium2Library
Library           Collections
Library           String
Library           ${CURDIR}/../../../../Python_Library/Freebie.py
Library           ${CURDIR}/../../../../Python_Library/DatabaseData.py

*** Keywords ***
Set Inventory Id Product Main And Freebie 1Variant
    ${start}=    Convert To Integer    ${start_normal}
    ${main1VariantA}=    Py Get Inventory No Style Options    ${start}
    ${1VariantA}=    Get From Dictionary    ${main1VariantA}    inventory_id
    Set Test Variable    ${var_freebie_main_1VariantA}    ${1VariantA}
    ${startB}=    Evaluate    ${start}+5
    ${main1VariantB}=    Py Get Inventory No Style Options    ${startB}
    ${1VariantB}=    Get From Dictionary    ${main1VariantB}    inventory_id
    Set Test Variable    ${var_freebie_main_1VariantB}    ${1VariantB}
    ${startC}=    Evaluate    ${startB}+5
    ${main1VariantC}=    Py Get Inventory No Style Options    ${startC}
    ${1VariantC}=    Get From Dictionary    ${main1VariantC}    inventory_id
    Set Test Variable    ${var_freebie_main_1VariantC}    ${1VariantC}

Set Inventory Id Product Main With Specific Variant And Freebie 1Variant
    [Arguments]    ${variant}
    ${start}=    Convert To Integer    ${start_normal}
    ${main1VariantA}=    Set Variable    ${variant}
    ${1VariantA}=    Get From Dictionary    ${main1VariantA}    inventory_id
    Set Test Variable    ${var_freebie_main_1VariantA}    ${1VariantA}
    ${startB}=    Evaluate    ${start}+5
    ${main1VariantB}=    Py Get Inventory No Style Options    ${startB}
    ${1VariantB}=    Get From Dictionary    ${main1VariantB}    inventory_id
    Set Test Variable    ${var_freebie_main_1VariantB}    ${1VariantB}
    ${startC}=    Evaluate    ${startB}+5
    ${main1VariantC}=    Py Get Inventory No Style Options    ${startC}
    ${1VariantC}=    Get From Dictionary    ${main1VariantC}    inventory_id
    Set Test Variable    ${var_freebie_main_1VariantC}    ${1VariantC}

Set Inventory Id Product Main And Freebie More Than 1Variant
    ${start}=    Convert To Integer    ${start_normal}
    ${main4Variant}=    Py Get Inventory Has Style Options    1    4    ${start}
    ${main4_product_pkey}=    Get From Dictionary    ${main4Variant}    product_pkey
    ${main4_product_id}=    Get From Dictionary    ${main4Variant}    product_id
    ${4VariantA}=    Py Get Inventory By Product Id    ${main4_product_id}    0
    ${4VariantB}=    Py Get Inventory By Product Id    ${main4_product_id}    1
    ${4VariantC}=    Py Get Inventory By Product Id    ${main4_product_id}    2
    ${4VariantD}=    Py Get Inventory By Product Id    ${main4_product_id}    3
    Set Test Variable    ${var_freebie_main_4VariantA}    ${4VariantA}
    Set Test Variable    ${var_freebie_main_4VariantB}    ${4VariantB}
    Set Test Variable    ${var_freebie_main_4VariantC}    ${4VariantC}
    Set Test Variable    ${var_freebie_main_4VariantD}    ${4VariantD}

Set Inventory Id Product Main And Freebie More Than 1Variant Has Installment Kbank
    ${main4Variant}=    py_get_inventory_has_style_options_has_installment    1    4    1    active    kbank
    ...    10
    ${main4_product_pkey}=    Get From Dictionary    ${main4Variant}    product_pkey
    ${main4_product_id}=    Get From Dictionary    ${main4Variant}    product_id
    ${4VariantA}=    Py Get Inventory By Product Id    ${main4_product_id}    0
    ${4VariantB}=    Py Get Inventory By Product Id    ${main4_product_id}    1
    ${4VariantC}=    Py Get Inventory By Product Id    ${main4_product_id}    2
    ${4VariantD}=    Py Get Inventory By Product Id    ${main4_product_id}    3
    Set Test Variable    ${var_freebie_main_4VariantA}    ${4VariantA}
    Set Test Variable    ${var_freebie_main_4VariantB}    ${4VariantB}
    Set Test Variable    ${var_freebie_main_4VariantC}    ${4VariantC}
    Set Test Variable    ${var_freebie_main_4VariantD}    ${4VariantD}

Set Inventory Id Product Main And Freebie More Than 1Variant Allow COD
    ${main4Variant}=    py_get_inventory_has_style_options_allow_cod    1    4    1
    ${main4_product_pkey}=    Get From Dictionary    ${main4Variant}    product_pkey
    ${main4_product_id}=    Get From Dictionary    ${main4Variant}    product_id
    ${4VariantA}=    Py Get Inventory By Product Id    ${main4_product_id}    0
    ${4VariantB}=    Py Get Inventory By Product Id    ${main4_product_id}    1
    ${4VariantC}=    Py Get Inventory By Product Id    ${main4_product_id}    2
    ${4VariantD}=    Py Get Inventory By Product Id    ${main4_product_id}    3
    Set Test Variable    ${var_freebie_main_4VariantA}    ${4VariantA}
    Set Test Variable    ${var_freebie_main_4VariantB}    ${4VariantB}
    Set Test Variable    ${var_freebie_main_4VariantC}    ${4VariantC}
    Set Test Variable    ${var_freebie_main_4VariantD}    ${4VariantD}

Set Inventory Id Product Main And Freebie More Than 1Variant Has CS
    ${main4Variant}=    py_get_inventory_has_style_options_has_cs    1    4    2
    ${main4_product_pkey}=    Get From Dictionary    ${main4Variant}    product_pkey
    ${main4_product_id}=    Get From Dictionary    ${main4Variant}    product_id
    ${4VariantA}=    Py Get Inventory By Product Id    ${main4_product_id}    0
    ${4VariantB}=    Py Get Inventory By Product Id    ${main4_product_id}    1
    ${4VariantC}=    Py Get Inventory By Product Id    ${main4_product_id}    2
    ${4VariantD}=    Py Get Inventory By Product Id    ${main4_product_id}    3
    Set Test Variable    ${var_freebie_main_4VariantA}    ${4VariantA}
    Set Test Variable    ${var_freebie_main_4VariantB}    ${4VariantB}
    Set Test Variable    ${var_freebie_main_4VariantC}    ${4VariantC}
    Set Test Variable    ${var_freebie_main_4VariantD}    ${4VariantD}

Get 2Product Same Collection
    ${start}=    Convert To Integer    ${start_normal}
    ${data_products}=    py_get_2inventory_ids_same_collection_diff_product    ${start}
    ${products1}=    Get From List    ${data_products}    0
    ${products2}=    Get From List    ${data_products}    1
    ${products3}=    Get From List    ${data_products}    2
    ${inventory_id1}=    Get From Dictionary    ${products1}    inventory_id
    ${collection_name1}=    Get From Dictionary    ${products1}    collection_name
    ${inventory_id2}=    Get From Dictionary    ${products2}    inventory_id
    ${collection_name2}=    Get From Dictionary    ${products2}    collection_name
    ${inventory_id3}=    Get From Dictionary    ${products3}    inventory_id
    ${collection_name3}=    Get From Dictionary    ${products3}    collection_name
    Set Test Variable    ${var_freebie_normal_same_collectionA}    ${inventory_id1}
    Set Test Variable    ${var_freebie_normal_same_collectionB}    ${inventory_id2}
    Set Test Variable    ${var_freebie_normal_same_collectionC}    ${inventory_id3}
    Set Test Variable    ${var_freebie_collection_name}    ${collection_name1}

Set Variable Freebie Product By Products
    [Arguments]    ${products}
    ${product}=    Get From List    ${products}    0
    ${pkey}=    Get From Dictionary    ${product}    pkey
    ${inventory_id}=    Get From Dictionary    ${product}    inventory_id
    Set Test Variable    ${var_freebie_free_level_d_pkey}    ${pkey}
    Set Test Variable    ${var_freebie_free_level_d_inventory}    ${inventory_id}
    Log to console    ${var_freebie_free_level_d_inventory}

Set Variable Freebie Product And Status By Products
    [Arguments]    ${products}
    ${product}=    Get From List    ${products}    0
    ${variant_id}=    Get From Dictionary    ${product}    variant_id
    ${product_id}=    Get From Dictionary    ${product}    product_id
    ${pkey}=    Get From Dictionary    ${product}    pkey
    ${inventory_id}=    Get From Dictionary    ${product}    inventory_id
    ${product_status}=    Get From Dictionary    ${product}    product_status
    ${product_active}=    Get From Dictionary    ${product}    product_active
    ${variant_status}=    Get From Dictionary    ${product}    variant_status
    Set Test Variable    ${var_freebie_free_level_d_variant_id}    ${variant_id}
    Set Test Variable    ${var_freebie_free_level_d_product_id}    ${product_id}
    Set Test Variable    ${var_freebie_free_level_d_pkey}    ${pkey}
    Set Test Variable    ${var_freebie_free_level_d_inventory}    ${inventory_id}
    Set Test Variable    ${var_freebie_free_level_d_product_status}    ${product_status}
    Set Test Variable    ${var_freebie_free_level_d_product_active}    ${product_active}
    Set Test Variable    ${var_freebie_free_level_d_variant_status}    ${variant_status}
    Log to console    free_pkey=${var_freebie_free_level_d_pkey}
    Log to console    free_inventory_id=${var_freebie_free_level_d_inventory}
    Log to console    free_product_id=${var_freebie_free_level_d_product_id}
    Log to console    free_product_status=${var_freebie_free_level_d_product_status}
    Log to console    free_product_active=${var_freebie_free_level_d_product_active}
    Log to console    free_variant_status=${var_freebie_free_level_d_variant_status}

Get Free Product Status Active Content Approved Variant Status InActive
    ${products}=    py_get_product_by_content_status_and_active    approved    1    disable    0
    Set Variable Freebie Product By Products    ${products}

Get Free Product Status Active Content Approved Variant Status Active
    ${products}=    py_get_product_by_content_status_and_active    approved    1    active    0
    Set Variable Freebie Product By Products    ${products}

Get Free Product Status Active Content Publish Variant Status InActive
    ${products}=    py_get_product_by_content_status_and_active    publish    1    disable    0
    Set Variable Freebie Product By Products    ${products}

Get Free Product Status Active Content Publish Variant Status Active
    ${products}=    py_get_product_by_content_status_and_active    publish    1    active    0
    Set Variable Freebie Product By Products    ${products}

Get Free Product Status Active Content Draft Variant Status InActive
    ${products}=    py_get_product_by_content_status_and_active    draft    1    disable    0
    Set Variable Freebie Product By Products    ${products}

Get Free Product Status Active Content Draft Variant Status Active
    ${products}=    py_get_product_by_content_status_and_active    draft    1    active    0
    Set Variable Freebie Product By Products    ${products}

Get Free Product Status InActive Content Approve Variant Status Active
    ${products}=    py_get_product_by_content_status_and_active    approved    0    active    0
    Set Variable Freebie Product By Products    ${products}

Get Free Product Status InActive Content Publish Variant Status Active
    ${products}=    py_get_product_by_content_status_and_active    publish    0    active    0
    Set Variable Freebie Product By Products    ${products}

Get Free Product Status InActive Content Draft No Collection
    ${start}=    Convert To Integer    ${start_free}
    ${products}=    py_get_product_no_collections    draft    0    active    ${start}
    Set Variable Freebie Product By Products    ${products}

Get Free Product Status InActive Content Draft Collection Is Itruemart
    ${start}=    Convert To Integer    ${start_free}
    ${products}=    py_get_product_has_collection_app_itruemart    draft    0    active    ${start}
    Set Variable Freebie Product By Products    ${products}

Get Free Product Status InActive Content Draft Variant Status Active
    ${products}=    py_get_product_by_content_status_and_active    draft    0    active    0
    Set Variable Freebie Product By Products    ${products}

Get Free Product Status InActive Content Draft
    ${products}=    py_get_product_by_content_status_and_active    draft    0    active    0
    Set Variable Freebie Product By Products    ${products}

Get Free Product Status InActive Content Draft Has Collection Not Publish On Itruemart
    ${products}=    py_get_product_has_collections_no_apps    draft    0    active    0
    Set Variable Freebie Product By Products    ${products}

Get Info Main Product From InventoryId
    [Arguments]    ${inventory_id}
    ${pkey}    Get Inventory Pkey    ${inventory_id}
    Set Test Variable    ${var_freebie_main_level_d_pkey}    ${pkey}
    Set Test Variable    ${var_freebie_main_level_d_inventory}    ${inventory_id}
    Log to console    ${var_freebie_main_level_d_pkey}
    Log to console    ${var_freebie_main_level_d_inventory}

Get Info Main2 Product From InventoryId
    [Arguments]    ${inventory_id}
    ${pkey}    Get Inventory Pkey    ${inventory_id}
    Set Test Variable    ${var_freebie_main2_level_d_pkey}    ${pkey}
    Set Test Variable    ${var_freebie_main2_level_d_inventory}    ${inventory_id}
    Log to console    ${var_freebie_main2_level_d_pkey}
    Log to console    ${var_freebie_main2_level_d_inventory}

Get Info Main3 Product From InventoryId
    [Arguments]    ${inventory_id}
    ${pkey}    Get Inventory Pkey    ${inventory_id}
    Set Test Variable    ${var_freebie_main3_level_d_pkey}    ${pkey}
    Set Test Variable    ${var_freebie_main3_level_d_inventory}    ${inventory_id}
    Log to console    ${var_freebie_main3_level_d_pkey}
    Log to console    ${var_freebie_main3_level_d_inventory}

Get Info Free Product From InventoryId
    [Arguments]    ${inventory_id}
    ${pkey}    Get Inventory Pkey    ${inventory_id}
    Set Test Variable    ${var_freebie_free_level_d_pkey}    ${pkey}
    Set Test Variable    ${var_freebie_free_level_d_inventory}    ${inventory_id}
    Log to console    ${var_freebie_free_level_d_inventory}

Get Info Normal Product From InventoryId
    [Arguments]    ${inventory_id}
    ${pkey}    Get Inventory Pkey    ${inventory_id}
    ${title}=    Get Product Title    ${inventory_id}
    Set Test Variable    ${var_freebie_normal_level_d_pkey}    ${pkey}
    Set Test Variable    ${var_freebie_normal_level_d_inventory}    ${inventory_id}
    Set Test Variable    ${var_freebie_normal_level_d_product_title}    ${title}
    Log to console    normal:${var_freebie_normal_level_d_pkey}
    Log to console    normal:${var_freebie_normal_level_d_inventory}

Get Info Normal2 Product From InventoryId
    [Arguments]    ${inventory_id}
    ${pkey}    Get Inventory Pkey    ${inventory_id}
    ${title}=    Get Product Title    ${inventory_id}
    Set Test Variable    ${var_freebie_normal2_level_d_pkey}    ${pkey}
    Set Test Variable    ${var_freebie_normal2_level_d_inventory}    ${inventory_id}
    Set Test Variable    ${var_freebie_normal2_level_d_product_title}    ${title}
    Log to console    normal2:${var_freebie_normal2_level_d_pkey}
    Log to console    normal2:${var_freebie_normal2_level_d_inventory}

Get Style Option Main Product From InventoryId
    ${style}=    Py Get Multiple Style Options Pkey    ${var_freebie_main_level_d_inventory}
    ${style1}=    Get From Dictionary    ${style}    style1
    Set Test Variable    ${var_freebie_main_level_d_style1}    ${style1}

Get Style Option Main2 Product From InventoryId
    ${style}=    Py Get Multiple Style Options Pkey    ${var_freebie_main2_level_d_inventory}
    ${style1}=    Get From Dictionary    ${style}    style1
    Set Test Variable    ${var_freebie_main2_level_d_style1}    ${style1}

Get Style Option Main3 Product From InventoryId
    ${style}=    Py Get Multiple Style Options Pkey    ${var_freebie_main3_level_d_inventory}
    ${style1}=    Get From Dictionary    ${style}    style1
    Set Test Variable    ${var_freebie_main3_level_d_style1}    ${style1}

Get Style Option Normal Product From InventoryId
    ${style}=    Py Get Multiple Style Options Pkey    ${var_freebie_normal_level_d_inventory}
    ${style1}=    Get From Dictionary    ${style}    style1
    Set Test Variable    ${var_freebie_normal_level_d_style1}    ${style1}

Get Style Option Normal2 Product From InventoryId
    ${style}=    Py Get Multiple Style Options Pkey    ${var_freebie_normal2_level_d_inventory}
    ${style1}=    Get From Dictionary    ${style}    style1
    Set Test Variable    ${var_freebie_normal2_level_d_style1}    ${style1}
    #main products

Get Main Product 1Variant A
    Get Info Main Product From InventoryId    ${var_freebie_main_1VariantA}

Get Main Product 1Variant B
    Get Info Main Product From InventoryId    ${var_freebie_main_1VariantB}

Get Main2 Product 1Variant B
    Get Info Main2 Product From InventoryId    ${var_freebie_main_1VariantB}

Get Main Product 1Variant C
    Get Info Main Product From InventoryId    ${var_freebie_main_1VariantC}
    #free products

Get Free Product 1Variant A
    Get Info Free Product From InventoryId    ${var_freebie_main_1VariantA}

Get Free Product 1Variant B
    Get Info Free Product From InventoryId    ${var_freebie_main_1VariantB}

Get Free Product 1Variant C
    Get Info Free Product From InventoryId    ${var_freebie_main_1VariantC}
    #free products More Than 1Variant

Get Free Product 4Variant A
    Get Info Free Product From InventoryId    ${var_freebie_main_4VariantA}

Get Free Product 4Variant B
    Get Info Free Product From InventoryId    ${var_freebie_main_4VariantB}

Get Free Product 4Variant C
    Get Info Free Product From InventoryId    ${var_freebie_main_4VariantC}

Get Free Product 4Variant D
    Get Info Free Product From InventoryId    ${var_freebie_main_4VariantD}
    #main products More Than 1Variant

Get Main Product 4Variant A
    Get Info Main Product From InventoryId    ${var_freebie_main_4VariantA}

Get Main Product 4Variant B
    Get Info Main Product From InventoryId    ${var_freebie_main_4VariantB}

Get Main Product 4Variant C
    Get Info Main Product From InventoryId    ${var_freebie_main_4VariantC}

Get Main Product 4Variant D
    Get Info Main Product From InventoryId    ${var_freebie_main_4VariantD}
    #main2 products More Than 1Variant

Get Main2 Product 4Variant A
    Get Info Main2 Product From InventoryId    ${var_freebie_main_4VariantA}

Get Main2 Product 4Variant B
    Get Info Main2 Product From InventoryId    ${var_freebie_main_4VariantB}

Get Main2 Product 4Variant C
    Get Info Main2 Product From InventoryId    ${var_freebie_main_4VariantC}

Get Main2 Product 4Variant D
    Get Info Main2 Product From InventoryId    ${var_freebie_main_4VariantD}
    #main3 products More Than 1Variant

Get Main3 Product 4Variant A
    Get Info Main3 Product From InventoryId    ${var_freebie_main_4VariantA}

Get Main3 Product 4Variant B
    Get Info Main3 Product From InventoryId    ${var_freebie_main_4VariantB}

Get Main3 Product 4Variant C
    Get Info Main3 Product From InventoryId    ${var_freebie_main_4VariantC}

Get Main3 Product 4Variant D
    Get Info Main3 Product From InventoryId    ${var_freebie_main_4VariantD}

Get Main Product Variant
    [Arguments]    ${inventory_id}
    Get Info Main Product From InventoryId    ${inventory_id}

Get Main2 Product Variant
    [Arguments]    ${inventory_id}
    Get Info Main Product From InventoryId    ${inventory_id}

Get Free Product Variant
    [Arguments]    ${inventory_id}
    Get Info Free Product From InventoryId    ${inventory_id}
    #same collection

Get Main Product Same Collection A
    Get Info Main Product From InventoryId    ${var_freebie_normal_same_collectionA}

Get Main Product Same Collection B
    Get Info Main Product From InventoryId    ${var_freebie_normal_same_collectionB}

Get Normal Product Same Collection A
    Get Info Normal Product From InventoryId    ${var_freebie_normal_same_collectionA}

Get Normal Product Same Collection B
    Get Info Normal Product From InventoryId    ${var_freebie_normal_same_collectionB}

Get Normal2 Product Same Collection A
    Get Info Normal2 Product From InventoryId    ${var_freebie_normal_same_collectionA}

Get Normal2 Product Same Collection B
    Get Info Normal2 Product From InventoryId    ${var_freebie_normal_same_collectionB}

Get Normal2 Product Same Collection C
    Get Info Normal2 Product From InventoryId    ${var_freebie_normal_same_collectionC}
