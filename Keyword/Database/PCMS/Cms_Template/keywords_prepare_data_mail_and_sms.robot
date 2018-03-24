*** Settings ***
Library                 ${CURDIR}/../../../../Python_Library/product.py
Library                 ${CURDIR}/../../../../Python_Library/message_library.py
Library                 ${CURDIR}/../../../../Python_Library/DatabaseData.py

*** Keywords ***
Cms Template Prepare Data - Get Product Installment
    ${product}=             py_get_product_normal_has_installment       ${product_start}   kbank   10
    ${inventory_id}=        Get From Dictionary        ${product}      inventory_id
    ${product_pkey}=        Get From Dictionary        ${product}      product_pkey
    Set Test Variable       ${var_mail_sms_product_inventory_id}         ${inventory_id}
    Set Test Variable       ${var_mail_sms_product_pkey}                 ${product_pkey}

Cms Template Prepare Data - Get Product COD
    ${product}=             py_get_product_normal_allow_cod       ${product_start}
    ${inventory_id}=        Get From Dictionary        ${product}      inventory_id
    ${product_pkey}=        Get From Dictionary        ${product}      product_pkey
    Set Test Variable       ${var_mail_sms_product_inventory_id}         ${inventory_id}
    Set Test Variable       ${var_mail_sms_product_pkey}                 ${product_pkey}

Cms Template Prepare Data - Set Product
    ${Product}=       py_get_product_normal       ${product_start}
    ${inventory_id}=           Get From Dictionary        ${Product}         inventory_id
    ${product_pkey}=           Get From Dictionary        ${Product}         product_pkey
    Set Test Variable       ${var_mail_sms_product_inventory_id}           ${inventory_id}
    Set Test Variable       ${var_mail_sms_product_pkey}           ${product_pkey}

Cms Template Prepare Data - Set Product Counter Service
    ${Product}=       py_get_product_normal_with_payment       8
    Log To Console   ${Product}
    ${inventory_id}=           Get From Dictionary        ${Product}         inventory_id
    ${product_pkey}=           Get From Dictionary        ${Product}         product_pkey
    Set Test Variable       ${var_mail_sms_product_inventory_id}           ${inventory_id}
    Set Test Variable       ${var_mail_sms_product_pkey}           ${product_pkey}