*** Settings ***
Library           Selenium2Library
Library           Collections
Library           String
Library           ${CURDIR}/../../../Python_Library/product.py
Resource          ../../Mobile/Mobile_iTrueMart/Mobile_Level_d_page/WebElement_LevelD.robot

*** Keywords ***
Level D Mobile - Go To Level D With Sku
    ${inv_id}=    Get From Dictionary    ${TEST_VAR}    inv_id
    ${product_pkey}=    Get Product Pkey    ${inv_id}
    Go To    ${ITM_MOBILE_URL}/products/items-${product_pkey}.html

Open Level D Main Product Mobile
    Go To    ${ITM_MOBILE_URL}/products/item-${var_freebie_main_level_d_pkey}.html

Open Level D Main2 Product Mobile
    Go To    ${ITM_MOBILE_URL}/products/item-${var_freebie_main2_level_d_pkey}.html

Open Level D Free Product Mobile
    Go To    ${ITM_MOBILE_URL}/products/item-${var_freebie_free_level_d_pkey}.html

Open Level D Main Product No Cache Mobile
    Go To    ${ITM_MOBILE_URL}/products/content/${var_freebie_main_level_d_pkey}?no-cache=1
    Sleep    1
    Go To    ${ITM_MOBILE_URL}/products/item-${var_freebie_main_level_d_pkey}.html?no-cache=1

Open Level D Main2 Product No Cache Mobile
    Go To    ${ITM_MOBILE_URL}/products/content/${var_freebie_main2_level_d_pkey}?no-cache=1
    Sleep    1
    Go To    ${ITM_MOBILE_URL}/products/item-${var_freebie_main2_level_d_pkey}.html?no-cache=1

Open Level D Main3 Product No Cache Mobile
    Go To    ${ITM_MOBILE_URL}/products/content/${var_freebie_main3_level_d_pkey}?no-cache=1
    Sleep    1
    Go To    ${ITM_MOBILE_URL}/products/item-${var_freebie_main2_level_d_pkey}.html?no-cache=1

Open Level D Free Product No Cache Mobile
    Go To    ${ITM_MOBILE_URL}/products/content/${var_freebie_free_level_d_pkey}?no-cache=1
    Sleep    1
    Go To    ${ITM_MOBILE_URL}/products/item-${var_freebie_free_level_d_pkey}.html?no-cache=1

Rebuild Stock More Than 1Variant Mobile
    Go To    ${ITM_MOBILE_URL}/${PRODUCT-REBUILD-STOCK-MOBILE}/${var_freebie_main_level_d_inventory}/?pkey=${var_freebie_main_level_d_pkey}&product_promotion=normal&debugger=1
    Wait Until Element Is Visible    //pre[@class="-kint"]    15s

Rebuild Stock No Variant Mobile
    Go To    ${ITM_MOBILE_URL}/${PRODUCT-REBUILD-STOCK-MOBILE}/${var_freebie_main_level_d_inventory}/?pkey=${var_freebie_main_level_d_pkey}&product_promotion=normal&debugger=1
    Wait Until Element Is Visible    //pre[@class="-kint"]    15s

Rebuild Stock No Variant Main2 Mobile
    Go To    ${ITM_MOBILE_URL}/${PRODUCT-REBUILD-STOCK-MOBILE}/${var_freebie_main2_level_d_inventory}/?pkey=${var_freebie_main2_level_d_pkey}&product_promotion=normal&debugger=1
    Wait Until Element Is Visible    //pre[@class="-kint"]    15s

Choose Style Option Main Level D Main Product Mobile
    Wait Until Element Is Visible    ${XPATH_LEVEL_D_MOBILE.div_style_type}    15s
    ${main_style}=    Convert To String    ${var_freebie_main_level_d_style1}
    ${element_main_style}=    Replace String    ${XPATH_LEVEL_D_MOBILE.btn_style_option_pkey}    ^^style-option-pkey^^    ${main_style}
    Log To Console    ${element_main_style}
    Wait Until Element Is Visible    ${element_main_style}    15s
    Click Element    ${element_main_style}
    Wait Until Element Is Not Visible    ${LvD_LoadingImg}

Choose Style Option Main Level D Main2 Product Mobile
    Wait Until Element Is Visible    ${XPATH_LEVEL_D_MOBILE.div_style_type}    15s
    ${main_style}=    Convert To String    ${var_freebie_main2_level_d_style1}
    ${element_main_style}=    Replace String    ${XPATH_LEVEL_D_MOBILE.btn_style_option_pkey}    ^^style-option-pkey^^    ${main_style}
    Wait Until Element Is Visible    ${element_main_style}    15s
    Click Element    ${element_main_style}
    Wait Until Element Is Not Visible    ${LvD_LoadingImg}

Choose Style Option Main Level D Main3 Product Mobile
    Wait Until Element Is Visible    ${XPATH_LEVEL_D_MOBILE.div_style_type}    15s
    ${main_style}=    Convert To String    ${var_freebie_main3_level_d_style1}
    ${element_main_style}=    Replace String    ${XPATH_LEVEL_D_MOBILE.btn_style_option_pkey}    ^^style-option-pkey^^    ${main_style}
    Wait Until Element Is Visible    ${element_main_style}    15s
    Click Element    ${element_main_style}
    Wait Until Element Is Not Visible    ${LvD_LoadingImg}

Button Add To Cart Enable Mobile
    Wait Until Element Is Visible    ${XPATH_LEVEL_D_MOBILE.btn_add_to_cart_enable}    15s
    Element Should Be Visible    ${XPATH_LEVEL_D_MOBILE.btn_add_to_cart_enable}

Button Add To Cart Disabled Mobile
    Wait Until Element Is Visible    ${XPATH_LEVEL_D_MOBILE.btn_add_to_cart_disable}    15s
    Element Should Be Visible    ${XPATH_LEVEL_D_MOBILE.btn_add_to_cart_disable}

Freebie Image Mobile TH Display
    Wait Until Element Is Visible    ${XPATH_LEVEL_D_MOBILE.img_freebie_th}    15s
    Element Should Be Visible    ${XPATH_LEVEL_D_MOBILE.img_freebie_th}

Freebie Image Mobile EN Display
    Wait Until Element Is Visible    ${XPATH_LEVEL_D_MOBILE.img_freebie_en}    15s
    Element Should Be Visible    ${XPATH_LEVEL_D_MOBILE.img_freebie_en}

Freebie Image Mobile TH Not Display
    Wait Until Element Is Not Visible    ${XPATH_LEVEL_D_MOBILE.img_freebie_th}    15s
    Element Should Not Be Visible    ${XPATH_LEVEL_D_MOBILE.img_freebie_th}

Freebie Image Mobile EN Not Display
    Wait Until Element Is Not Visible    ${XPATH_LEVEL_D_MOBILE.img_freebie_en}    15s
    Element Should Not Be Visible    ${XPATH_LEVEL_D_MOBILE.img_freebie_en}

Freebie Image Mobile TH Display Main
    ${element}=    Replace String    ${XPATH_LEVEL_D_MOBILE.img_freebie_id_th}    ^^promotion_id^^    ${var_freebie_promotion_id}
    Wait Until Element Is Visible    ${element}    15s
    Element Should Be Visible    ${element}

Freebie Image Mobile EN Display Main
    ${element}=    Replace String    ${XPATH_LEVEL_D_MOBILE.img_freebie_id_en}    ^^promotion_id^^    ${var_freebie_promotion_id}
    Wait Until Element Is Visible    ${element}    15s
    Element Should Be Visible    ${element}

Freebie Image Mobile TH Display Main2
    ${element}=    Replace String    ${XPATH_LEVEL_D_MOBILE.img_freebie_id_th}    ^^promotion_id^^    ${var_freebie_main2_promotion_id}
    Wait Until Element Is Visible    ${element}    15s
    Element Should Be Visible    ${element}

Freebie Image Mobile EN Display Main2
    ${element}=    Replace String    ${XPATH_LEVEL_D_MOBILE.img_freebie_id_en}    ^^promotion_id^^    ${var_freebie_main2_promotion_id}
    Wait Until Element Is Visible    ${element}    15s
    Element Should Be Visible    ${element}

Freebie Image Mobile TH Display Main3
    ${element}=    Replace String    ${XPATH_LEVEL_D_MOBILE.img_freebie_id_th}    ^^promotion_id^^    ${var_freebie_main3_promotion_id}
    Wait Until Element Is Visible    ${element}    15s
    Element Should Be Visible    ${element}

Freebie Image Mobile EN Display Main3
    ${element}=    Replace String    ${XPATH_LEVEL_D_MOBILE.img_freebie_id_en}    ^^promotion_id^^    ${var_freebie_main3_promotion_id}
    Wait Until Element Is Visible    ${element}    15s
    Element Should Be Visible    ${element}
