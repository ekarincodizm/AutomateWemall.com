*** Settings ***
Resource          ../../Keyword/API/FMS/keywords_fms_create_supplier.robot
Resource          ../../Keyword/API/FMS/FMS_Create_SKU.robot

*** Variables ***
${BrandID}     apple
${SKUNAME}     test_flash

*** Test Cases ***
Create Supplier
    [Tags]    001
    #Test Step

    ${supplier_code}=    Create Supplier Marketplace From FMS
    Log to console    Supplier Code1 = ${supplier_code}
    ${SKU_ID}=    FMS create sku with marketplace    ${supplier_code}    ${SKUName}    ${BrandID}
    Log To Console    ${SKU_ID}