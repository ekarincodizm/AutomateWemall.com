*** Settings ***
Library           Selenium2Library
Library           Collections
Library           String
Library           ${CURDIR}/../../../../Python_Library/Freebie.py
Library           ${CURDIR}/../../../../Python_Library/DatabaseData.py

*** Keywords ***
Get InventoryID Main Product From Variant
    ${variant}=    py_get_pkey_main_product_from_variant
    ${pkey}=    Get From Dictionary    ${variant}    product_pkey
    ${inventoryid}=    Get From Dictionary    ${variant}    inventory_id
    Set Test Variable    ${Variable_Freebie_Main_Inventory_ID}    ${inventoryid}
    Set Test Variable    ${Variable_Freebie_Main_Pkey}    ${pkey}
    ${style}=    py_get_multiple_style_options_pkey    ${inventoryid}
    ${stylepkey}=    Get From Dictionary    ${style}    style1
    Log to console    Style PKey1=${stylepkey}
    Set Test Variable    ${Variable_Style_PKEY_1}    ${stylepkey}

Get InventoryID Main Product2 From Variant
    ${variant}=    py_get_pkey_main_product2_from_variant
    ${pkey}=    Get From Dictionary    ${variant}    product_pkey
    ${inventoryid}=    Get From Dictionary    ${variant}    inventory_id
    Set Test Variable    ${Variable_Freebie_Main_Inventory_ID_2}    ${inventoryid}
    Set Test Variable    ${Variable_Freebie_Main_Pkey_2}    ${pkey}
    ${style}=    py_get_multiple_style_options_pkey    ${inventoryid}
    ${stylepkey}=    Get From Dictionary    ${style}    style1
    Log to console    Style PKey2=${stylepkey}
    Set Test Variable    ${Variable_Style_PKEY_P2}    ${stylepkey}

Get InventoryID Freebie From Variant
    ${variant}=    py_get_pkey_freebie_from_variant    ${start_free}
    ${inventoryid}=    Get From Dictionary    ${variant}    inventory_id
    ${pkey}=    Get From Dictionary    ${variant}    pkey
    Set Test Variable    ${Variable_Freebie_Inventory_ID}    ${inventoryid}
    Set Test Variable    ${Variable_Freebie_Free_Pkey}    ${pkey}

Get InventoryID Freebie Product D From Variant
    ${variant}=    py_get_pkey_freebie_from_variant_D    ${start_free}
    ${inventoryid}=    Get From Dictionary    ${variant}    inventory_id
    ${pkey}=    Get From Dictionary    ${variant}    pkey
    Set Test Variable    ${Variable_Freebie_Inventory_ID_D}    ${inventoryid}
    Set Test Variable    ${Variable_Freebie_Free_Pkey_D}    ${pkey}

Get InventoryID Freebie AS Draft From Variant
    ${variant}=    py_get_pkey_freebie_draft_from_variant
    ${inventoryid}=    Get From Dictionary    ${variant}    inventory_id
    ${pkey}=    Get From Dictionary    ${variant}    pkey
    Set Test Variable    ${Variable_Freebie_Inventory_ID}    ${inventoryid}
    Set Test Variable    ${Variable_Freebie_Free_Pkey}    ${pkey}

Get InventoryID Freebie AS Draft No App
    ${variant}=    py_get_pkey_freebie_1active_2disable_product_as_draft_no_apps
    ${inventoryid}=    Get From Dictionary    ${variant}    inventory_id
    ${pkey}=    Get From Dictionary    ${variant}    pkey
    Set Test Variable    ${Variable_Freebie_Inventory_ID}    ${inventoryid}
    Set Test Variable    ${Variable_Freebie_Free_Pkey}    ${pkey}

Get InventoryID Freebie AS Draft App is iTruemart
    ${variant}=    py_get_pkey_freebie_1active_2disable_product_as_draft_collection_is_itruemart
    ${inventoryid}=    Get From Dictionary    ${variant}    inventory_id
    ${pkey}=    Get From Dictionary    ${variant}    pkey
    Set Test Variable    ${Variable_Freebie_Inventory_ID}    ${inventoryid}
    Set Test Variable    ${Variable_Freebie_Free_Pkey}    ${pkey}

Get Pkey From Variant
    py_get_productid_variant    ${Variable_Freebie_Main_Inventory_ID}
    ${pkey}=    Get From Dictionary    ${product}    pkey
    Log To Console    ${pkey}

Get InventoryID Freebie 1Active 2Disable From Variant
    ${variant}=    py_get_pkey_freebie_1active_2disable_from_variant
    ${inventoryid}=    Get From Dictionary    ${variant}    inventory_id
    ${pkey}=    Get From Dictionary    ${variant}    pkey
    Set Test Variable    ${Variable_Freebie_Inventory_ID}    ${inventoryid}
    Set Test Variable    ${Variable_Freebie_Free_Pkey}    ${pkey}
    ${style}=    py_get_multiple_style_options_pkey    ${inventoryid}
    ${stylepkey}=    Get From Dictionary    ${style}    style1
    Log to console    ${stylepkey}
    Set Test Variable    ${Variable_Style_PKEY_2}    ${stylepkey}

Get InventoryID Freebie 1Active 2Disable Product Status Is Approved From Variant
    ${variant}=    py_get_pkey_freebie_1active_2disable_status_is_approved_from_variant
    ${inventoryid}=    Get From Dictionary    ${variant}    inventory_id
    Set Test Variable    ${Variable_Freebie_Inventory_ID}    ${inventoryid}

Get InventoryID Freebie 1Active 2Disable Product Status Is Draft From Variant
    ${variant}=    py_get_pkey_freebie_1active_2disable_product_as_draft_from_variant
    ${inventoryid}=    Get From Dictionary    ${variant}    inventory_id
    Set Test Variable    ${Variable_Freebie_Inventory_ID}    ${inventoryid}

Get Product B 1Active 2Disable From Variant
    ${variant}=    py_get_pkey_freebie_1active_2disable_from_variant
    ${inventoryid}=    Get From Dictionary    ${variant}    inventory_id
    ${pkey}=    Get From Dictionary    ${variant}    pkey
    Set Test Variable    ${Variable_Freebie_Main_Inventory_ID_2}    ${inventoryid}
    Set Test Variable    ${Variable_Freebie_Main_Pkey_2}    ${pkey}
    Log to console    ${Variable_Freebie_Main_Pkey_2}
    ${style}=    py_get_multiple_style_options_pkey    ${inventoryid}
    ${stylepkey}=    Get From Dictionary    ${style}    style1
    Log to console    ${stylepkey}
    Set Test Variable    ${Variable_Style_PKEY_2}    ${stylepkey}

Get Inventory ID From FMS
    ${variant}=    py_get_inventory_id_from_fms
    ${inventoryid}=    Get From Dictionary    ${variant}    sku_id
    Set Test Variable    ${Variable_Freebie_Inventory_ID}    ${inventoryid}
    Log to console    Freebie from FMS= ${Variable_Freebie_Inventory_ID}

Update Inventory ID Is Disable
    [Arguments]    ${inv}
    Log to console    freebie.keyword = ${inv}
    py_update_variantid_is_disable    ${inv}

Get Main Product A
    ${variant}=    py_get_main_product_have_1_variant_active    ${start_normal}
    ${pkey}=    Get From Dictionary    ${variant}    pkey
    ${inventoryid}=    Get From Dictionary    ${variant}    inventory_id
    Set Test Variable    ${Variable_Main_Product_A}    ${inventoryid}
    Set Test Variable    ${Variable_Main_Pkey}    ${pkey}

Get Main Product A Random
    ${start}=    Evaluate    random.randint(10, 30)    modules=random
    ${variant}=    py_get_inventory_no_style_options    ${start}
    ${inventoryid}=    Get From Dictionary    ${variant}    inventory_id
    ${pkey}=    Get From Dictionary    ${variant}    product_pkey
    Set Test Variable    ${Variable_Main_Product_A}    ${inventoryid}
    Set Test Variable    ${Variable_Main_Pkey}    ${pkey}

Get Main Product C Random
    ${start}=    Evaluate    random.randint(31, 50)    modules=random
    ${variant}=    Py Get Inventory No Style Options    ${start}
    ${inventoryid}=    Get From Dictionary    ${variant}    inventory_id
    ${pkey}=    Get From Dictionary    ${variant}    product_pkey
    Set Test Variable    ${Variable_Main_Product_C}    ${inventoryid}
    Set Test Variable    ${Variable_Main_Pkey_C}    ${pkey}

Get Main Product C
    ${variant}=    Py Get Inventory No Style Options    ${start_normal_c}
    ${inventoryid}=    Get From Dictionary    ${variant}    inventory_id
    ${pkey}=    Get From Dictionary    ${variant}    product_pkey
    Set Test Variable    ${Variable_Main_Product_C}    ${inventoryid}
    Set Test Variable    ${Variable_Main_Pkey_C}    ${pkey}

Get Main Product B
    ${variant}=    py_get_main_product_have_1_variant_active_b    ${start_normal_b}
    ${pkey}=    Get From Dictionary    ${variant}    pkey
    ${inventoryid}=    Get From Dictionary    ${variant}    inventory_id
    Set Test Variable    ${Variable_Main_Product_B}    ${inventoryid}
    Set Test Variable    ${Variable_Main_Pkey_B}    ${pkey}
    Log To Console    pkey_b=${Variable_Main_Pkey_B}

Get Main Product Fix
    [Arguments]    ${inventoryid}
    ${pkey}=    get_product_pkey    ${inventoryid}
    Set Test Variable    ${Variable_Main_Product_A}    ${inventoryid}
    Set Test Variable    ${Variable_Main_Pkey}    ${pkey}

Get Main Product B Fix
    [Arguments]    ${inventoryid}
    ${pkey}=    get_product_pkey    ${inventoryid}
    Set Test Variable    ${Variable_Main_Product_B}    ${inventoryid}
    Set Test Variable    ${Variable_Main_Pkey_B}    ${pkey}

Get Main Product Have 3 Variant Inactive
    ${variant}=    py_get_main_product_have_3_variant_Inactive    ${start_3variant}
    ${inventoryid}=    Get From Dictionary    ${variant}    inventory_id
    ${pkey}=    Get From Dictionary    ${variant}    pkey
    Set Test Variable    ${Variable_Main_Product_Inactive}    ${inventoryid}
    Set Test Variable    ${Variable_Main_Product_Pkey_Inactive}    ${pkey}
    ${style}=    py_get_multiple_style_options_pkey    ${inventoryid}
    ${stylepkey}=    Get From Dictionary    ${style}    style1
    Set Test Variable    ${Variable_Style_PKEY_Inactive}    ${stylepkey}

Get Main Product Have 3 Variant Inactive B
    ${start}=    Evaluate    ${start_3variant}+1
    ${variant}=    py_get_main_product_have_3_variant_Inactive_b    ${start}
    ${inventoryid}=    Get From Dictionary    ${variant}    inventory_id
    ${pkey}=    Get From Dictionary    ${variant}    pkey
    Set Test Variable    ${Variable_Main_Product_B}    ${inventoryid}
    Set Test Variable    ${Variable_Main_Pkey_B}    ${pkey}
    ${style}=    py_get_multiple_style_options_pkey    ${inventoryid}
    ${stylepkey}=    Get From Dictionary    ${style}    style1
    Set Test Variable    ${Variable_Style_PKEY_B}    ${stylepkey}

Get InventoryID Freebie Have 3 Variant
    ${variant}=    py_get_pkey_freebie_have_3_variant
    ${inventoryid}=    Get From Dictionary    ${variant}    inventory_id
    ${pkey}=    Get From Dictionary    ${variant}    pkey
    Set Test Variable    ${Variable_Freebie_Inventory_ID}    ${inventoryid}
    Set Test Variable    ${Variable_Freebie_Free_Pkey}    ${pkey}

Get Main Wow Product A
    ${pkey}=    py_freebie_get_wow_product_pkey
    Log To Console    ${pkey}
    ${inventoryid}=    get_inventory_by_pkey    ${pkey}
    Set Test Variable    ${Variable_Main_Product_A}    ${inventoryid}
    Set Test Variable    ${Variable_Main_Pkey}    ${pkey}
