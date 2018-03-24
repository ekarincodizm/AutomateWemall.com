*** Settings ***
Library           Selenium2Library
Library           HttpLibrary.HTTP
Resource          ${CURDIR}/../../../../Resource/init.robot
Resource          ${CURDIR}/../../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../../Keyword/API/PCMS/Shop/keywords_shop.robot
Resource          ${CURDIR}/../../../../Keyword/API/PCMS/Sku/keywords_sku.robot
Resource          webelement_create_new_material.robot
Library           ${CURDIR}/../../../../Python_Library/product.py
Library           ${CURDIR}/../../../../Python_Library/sku_library.py
Library           ${CURDIR}/../../../../Python_Library/product.py

*** Keyword ***
Prepare Two Shop
    [Arguments]    ${shop_code_1}=Robot1    ${shop_name_1}=RobotShopName1    ${shop_code_2}=Robot2    ${shop_name_2}=RobotShopName2
    API Shop - Create Shop    ${shop_code_1}    ${shop_name_1}
    API Shop - Create Shop    ${shop_code_2}    ${shop_name_2}

Delete Two Shop
    [Arguments]    ${shop_code_1}=Robot1    ${shop_code_2}=Robot2
    Delete Shop By Shop Code    ${shop_code_1}
    Delete Shop By Shop Code    ${shop_code_2}

Delete Imported Two Sku
    [Arguments]    ${sku_1}=RobotSku1    ${sku_2}=RobotSku2
    Delete Imported Sku By sku_id    ${sku_1}
    Delete Imported Sku By sku_id    ${sku_2}

Delete Imported Sku
    [Arguments]    ${sku_1}=RobotSku1
    Delete Imported Sku By sku_id    ${sku_1}

Delete Two Variants
    [Arguments]    ${sku_1}=RobotSku1    ${sku_2}=RobotSku2
    Delete Variant By sku_id    ${sku_1}
    Delete Variant By sku_id    ${sku_2}

Prepare Sku In Different Shop
    Create New Sku    [{"shop_code": "Robot1","shop_name": "RobotShopName1","sku": "RobotSku1","name": "RobotSku1","color": null,"brand": "APAAA","special_price": "10.00","unit_type": "piece","material_code": "","selling_price": "20.00","category_id": "-","size": null}]
    Create New Sku    [{"shop_code": "Robot2","shop_name": "RobotShopName2","sku": "RobotSku2","name": "RobotSku2","color": null,"brand": "APAAA","special_price": "10.00","unit_type": "piece","material_code": "","selling_price": "20.00","category_id": "-","size": null}]

Prepare Sku In Same Shop
    Create New Sku    [{"shop_code": "Robot1","shop_name": "RobotShopName1","sku": "RobotSku1","name": "RobotSku1","color": null,"brand": "APAAA","special_price": "10.00","unit_type": "piece","material_code": "","selling_price": "20.00","category_id": "-","size": null}]
    Create New Sku    [{"shop_code": "Robot1","shop_name": "RobotShopName1","sku": "RobotSku2","name": "RobotSku2","color": null,"brand": "APAAA","special_price": "10.00","unit_type": "piece","material_code": "","selling_price": "20.00","category_id": "-","size": null}]

Click Choose Product
    Click Element    ${xpath-choose-button}

Search Sku List
    [Arguments]    ${sku}=(1) RobotSku1
    Input Text    ${xpath-search-textbox}    ${sku}
    Click Element    ${xpath-search-textbox}

Search Sku List For New Product
    [Arguments]    ${sku}=(1) RobotSku1
    Input Text    ${xpath-search-textbox-on-new-product-page}    ${sku}

Click Search Button
    Click Element    ${xpath-search-button}

Click Add New Material
    [Arguments]    ${xpath-add-button}=//*[@id="search_result"]/tr[1]/td[4]/button[2]
    Wait Until Element Is Visible    ${xpath-add-button}
    Click Element    ${xpath-add-button}

Click Manage New Material Button
    Click Element    ${xpath-manage-button}

Click Create New Product Tab
    Click Element    ${xpath-create-tap}

Fill Product Detail
    [Arguments]    ${product-name}=RobotProduct    ${brand-name}=Apple
    Input Text    ${xpath-product-name-textbox}    ${product-name}
    Input Text    ${xpath-product-name-textbox-us}    ${product-name}
    Input Text    ${xpath-brand-name-textbox}    ${brand-name}
    Click Element    ${xpath-create-button}

Add Product Style
    [Arguments]    ${value}=1
    Click Element    ${xpath-add-style-button}
    Select From List By Value    ${xpath-select-type}    ${value}
    Click Next Button

Select Style
    [Arguments]    ${color_1}=Dark gray    ${color_2}=Blue madras    ${xpath-style_1}=//*[contains(text(),"RobotSku1")]/../td[4]/span/input    ${xpath-style_2}=//*[contains(text(),"RobotSku2")]/../td[4]/span/input
    Input Text    ${xpath-style_1}    ${color_1}
    Input Text    ${xpath-style_2}    ${color_2}

Page Should Contain New Sku
    [Arguments]    ${sku_1}=RobotSku1    ${sku_2}=RobotSku2
    Wait Until Page Contains    ${sku_1}
    Page Should Contain    ${sku_1}
    Page Should Contain    ${sku_2}

Element Should Contain Shop Detail With Different Shops
    [Arguments]    ${shop_name_1}=RobotShopName1    ${shop_name_2}=RobotShopName2    ${xpath_col_1}=//*[text()="RobotSku1"]/../td[5]    ${xpath_col_2}=//*[text()="RobotSku2"]/../td[5]
    Element Should Contain    ${xpath_col_1}    ${shop_name_1}
    Element Should Contain    ${xpath_col_2}    ${shop_name_2}

Element Should Contain Shop Detail With Same Shops
    [Arguments]    ${shop_name_1}=RobotShopName1    ${xpath-sku_1}=//*[text()="RobotSku1"]/../td[5]    ${xpath-sku_2}=//*[text()="RobotSku2"]/../td[5]
    Element Should Contain    ${xpath-sku_1}    ${shop_name_1}
    Element Should Contain    ${xpath-sku_2}    ${shop_name_1}

Click Select Button With 2 Skus
    [Arguments]    ${xpath-sku_1}=//*[text()="RobotSku1"]/../td[1]    ${xpath-sku_2}=//*[text()="RobotSku2"]/../td[1]
    Click Element    ${xpath-sku_1}
    Click Element    ${xpath-sku_2}

Click Select Button On Variant Which Has No Shop
    [Arguments]    ${xpath-sku_1}=//*[text()="RobotSku1"]/../td[1]
    Click Element    ${xpath-sku_1}

Click Next Button
    Click Element    ${xpath-next-button}

Page Should Contain Error Message On Variant
    [Arguments]    ${message}=SKUs must be in the same shop.
    Page Should Contain    ${message}

Page Should Contain Error Message On Variant Which Has No Shop
    Page Should Contain Error Message On Variant    No shop is linked to SKU(s).

Select Color
    [Arguments]    ${color_1}=Dark gray    ${color_2}=Blue madras    ${size_1}=37    ${size_2}=37    ${xpath-variant-color_1}=//*[contains(text(),"RobotSku1")]/../td[4]/span/input    ${xpath-variant-size_1}=//*[contains(text(),"RobotSku1")]/../td[5]/span/input
    ...    ${xpath-variant-color_2}=//*[contains(text(),"RobotSku2")]/../td[4]/span/input    ${xpath-variant-size_2}=//*[contains(text(),"RobotSku2")]/../td[5]/span/input
    Input Text    ${xpath-variant-color_1}    ${color_1}
    Input Text    ${xpath-variant-size_1}    ${size_1}
    Input Text    ${xpath-variant-color_2}    ${color_2}
    Input Text    ${xpath-variant-size_2}    ${size_2}

Page Should New Variant
    [Arguments]    ${color_1}=Dark gray    ${color_2}=Blue madras    ${size_1}=37    ${size_2}=37    ${xpath-variant-color_1}=//*[contains(text(), "Dark gray")]/../td[4]    ${xpath-variant-size_1}=//*[contains(text(), "Dark gray")]/../td[5]
    ...    ${xpath-variant-color_2}=//*[contains(text(), "Blue madras")]/../td[4]    ${xpath-variant-size_2}=//*[contains(text(), "Blue madras")]/../td[5]
    Selenium2Library.Element Text Should Be    ${xpath-variant-color_1}    ${color_1}
    Selenium2Library.Element Text Should Be    ${xpath-variant-size_1}    ${size_1}
    Selenium2Library.Element Text Should Be    ${xpath-variant-color_2}    ${color_2}
    Selenium2Library.Element Text Should Be    ${xpath-variant-size_2}    ${size_2}

Delete Product By Product Title
    [Arguments]    ${product-name}=RobotProduct
    Delete Product By Title    ${product-name}

Page Should New Product With New Style
    [Arguments]    ${color_1}=Dark gray    ${color_2}=Blue madras    ${xpath-variant-color_1}=//*[contains(text(), "Dark gray")]/../td[4]    ${xpath-variant-color_2}=//*[contains(text(), "Blue madras")]/../td[4]
    Selenium2Library.Element Text Should Be    ${xpath-variant-color_1}    ${color_1}
    Selenium2Library.Element Text Should Be    ${xpath-variant-color_2}    ${color_2}

Select Brand For Create Product
    [Arguments]    ${xpath-brand-label}=//label[@for="brand"]/span/span[@data-original-title="Show All Items"]    ${xpath-brand-select-box}=//ul[@id="ui-id-3"]/li[1]
    Click Element    ${xpath-brand-label}
    Click Element    ${xpath-brand-select-box}

Wait Element Create New Product Step3
    [Arguments]    ${xpath-add-style}=//*[@class="btn add-type"]    ${location}=/products/new-material/step3
    Wait Until Element Is Visible    ${xpath-add-style}
    Location Should Contain    ${location}

Prepare Sku With No Shop Related To It
    insert_dummy_record_with_no_shop

Page Should Contain Alertbox
    [Arguments]    ${alert-message}=SKUs must be in the same merchant.
    Alert Should Be Present    ${alert-message}
    Choose Ok On Next Confirmation

Only One Checkbox Should Be Checked
    [Arguments]    ${xpath-sku_1-row}=//*[text()="RobotSku1"]/..    ${xpath-sku_2-row}=//*[text()="RobotSku2"]/..
    ${class-xpath-sku_1-row}=    Selenium2Library.Get Element Attribute    ${xpath-sku_1-row}@class
    ${class-xpath-sku_2-row}=    Selenium2Library.Get Element Attribute    ${xpath-sku_2-row}@class
    Should Contain    ${class-xpath-sku_1-row}    selected
    Should Not Contain    ${class-xpath-sku_2-row}    selected

Click Select All
    Click Element    id=select_all_material

Check Alert Message
    [Arguments]    ${xpath-selected-sku}=//*[@id="datatables_index"]/tbody/tr[1]/td[2]
    ${alert-message}=    Get Alert Message
    Should Contain    ${alert-message}    SKUs must be in the same merchant.
    ${selected-sku}=    Get Text    ${xpath-selected-sku}
    Should Not Contain    ${alert-message}    ${selected-sku}

Search Shop
    [Arguments]    ${merchant-code}=ITM
    Input Text    ${xpath-serach-button}    ${merchant-code}

Inserted Skus Which Have Different Shops Should Not Be Selected
    [Arguments]    ${inserted-shop_1}=Robot1    ${inserted-shop_2}=Robot2    ${xpath-sku_1-row}=//*[text()="RobotSku1"]/..    ${xpath-sku_2-row}=//*[text()="RobotSku2"]/..
    Search Shop    ${inserted-shop_1}
    ${class-xpath-sku_1-row}=    Selenium2Library.Get Element Attribute    ${xpath-sku_1-row}@class
    Should Not Contain    ${class-xpath-sku_1-row}    selected
    Search Shop    ${inserted-shop_2}
    ${class-xpath-sku_2-row}=    Selenium2Library.Get Element Attribute    ${xpath-sku_2-row}@class
    Should Not Contain    ${class-xpath-sku_2-row}    selected

Sku With No Shop Name Should Not Be Unselectable
    [Arguments]    ${select-element}=//*[text()="RobotSku1"]/../td[1]/input
    Element Should Be Disabled    ${select-element}

Check If Skus Are Sill In Waiting List On Dashboard
    [Arguments]    ${sku_1}=RobotSku1    ${sku_2}=RobotSku2
    Go To    ${PCMS_URL}
    Page Should Contain    ${sku_1}
    Page Should Contain    ${sku_2}

Not Found Record In Table Variant
    [Arguments]    ${sku_1}=RobotSku1    ${sku_2}=RobotSku2
    ${result}=    count_record_in_variant_by_skuID    ${sku_1}
    Should Be Equal As Numbers    ${result}    0
    ${result}=    count_record_in_variant_by_skuID    ${sku_2}
    Should Be Equal As Numbers    ${result}    0

Search Incomplete Product Which Has Color
    ${product_name}=    get_title_of_incomplete_product
    Input Text    ${xpath-product-name-input}    ${product_name}
    Click Search Button

Search Prepared Robot Sku
    [Arguments]    ${sku_code}=RobotSku1
    Input Text    ${xpath-sku-code-input}    ${sku_code}
    Click Search Button On Choose Meterial Page

Click Search Button On Choose Meterial Page
    Click Element    ${xpath-search-button-on-choose-material}
