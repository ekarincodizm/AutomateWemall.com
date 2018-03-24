*** Settings ***
Library           HttpLibrary.HTTP
Resource          ../../Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Resource/init.robot

*** Keywords ***
FMS Create New SKU
    [Arguments]    ${SKUName}    ${BrandCode}
    HttpLibrary.HTTP.Set Basic Auth    ${FMS_API_USERNAME}    ${FMS_API_PASSWORD}
    Create Http Context    ${FMS_API_V1}    http
    Set Request Header    Content-Type    application/json
    Set Request Body    [{"BU":"BTH001","SKU":{"primary_cat":"C340000000000","sub_cat":"C170800000000","brand_id":"${BrandCode}","product_name":"${SKUName}","model":"","color":"","size_variant":"","package_dimension":"","product_dimension":"","selling_price":"555","special_price":"111","package_weight":"","product_weight":"","product_owner_email":"","uom_code":"ea","bu_code":"BTH001"},"ROW":"0"}]
    HttpLibrary.HTTP.POST    /api/key/v1/sku/creates
    ${resp}=    Get Response Body
    ${SKU_resp}=    Get Json Value    ${resp}    /data/0/sku_id
    ${SKU_ID}=    Parse Json    ${SKU_resp}
    [Return]    ${SKU_ID}

FMS Create New SKU with retail
    [Arguments]    ${SKUName}    ${BrandCode}
    HttpLibrary.HTTP.Set Basic Auth    ${FMS_API_USERNAME}    ${FMS_API_PASSWORD}
    Create Http Context    ${FMS_API_V1}    http
    Set Request Header    Content-Type    application/json
    Set Request Body    [{"BU":"BTH001","SKU":{"primary_cat":"C340000000000","sub_cat":"C170800000000","brand_id":"${BrandCode}","product_name":"${SKUName}","model":"","color":"","size_variant":"","package_dimension":"","product_dimension":"","selling_price":"555","special_price":"111","package_weight":"","product_weight":"","product_owner_email":"","uom_code":"ea","bu_code":"BTH001"},"ROW":"0"}]
    HttpLibrary.HTTP.POST    /api/key/v1/sku/creates
    ${resp}=    Get Response Body
    ${SKU_resp}=    Get Json Value    ${resp}    /data/0/sku_id
    ${SKU_ID}=    Parse Json    ${SKU_resp}
    [Return]    ${SKU_ID}

FMS create sku with marketplace
    [Arguments]    ${supplier_code}    ${SKUName}    ${BrandCode}
    Create Http Context    ${FMS_API_V1}    http
    Set Request Header    Content-Type    application/json
    Set Request Body    [{"BU":"BTH001","MAT":{"sku_id":"","supplier_code":${supplier_code},"stock_type":"MD","stock_level":"","supplier_sku":"Test_By_Flash","upc_ian":"1","warranty":"SauThang","package_content":"Brick","cost":"125","unit":"1"},"SKU":{"primary_cat":"C340000000000","sub_cat":"C170800000000","brand_id":"${BrandCode}","product_name":"${SKUName}","size_variant":"","package_dimension":"","product_dimension":"","selling_price":"123","special_price":"100","package_weight":"","product_weight":"","product_owner_email":"Email@gmail.com","uom_code":"ea","bu_code":"BTH001","model":"","color":""},"ROW":"1"}]
    HttpLibrary.HTTP.POST    ${sku_created}
    ${resp}=    Get Response Body
    ${SKU_resp}=    Get Json Value    ${resp}    /data/0/sku_id
    ${SKU_ID}=    Parse Json    ${SKU_resp}
    Log To Console    sku_id=${SKU_ID}
    [Return]    ${SKU_ID}
