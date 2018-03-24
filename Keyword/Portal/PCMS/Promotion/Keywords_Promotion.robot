*** Settings ***
Library           Selenium2Library
Library           String
Library           DatabaseLibrary
Library           DateTime
Library           ${CURDIR}/../../../../Python_Library/common.py
Library           ${CURDIR}/../../../../Python_Library/helper.py
Library           ${CURDIR}/../../../../Python_Library/DatabaseData.py
Library           ${CURDIR}/../../../../Python_Library/common/csvlibrary.py
Resource          ../../../Common/Keywords_Common.robot
Resource          ../../../Database/PCMS/Promotion_code/keywords_promotion_code.robot
Resource          WebElement_Promotion.robot
Resource           ${CURDIR}/keywords_prepare_promotion_code.robot

*** Variables ***

*** Keywords ***
Promotion - Fill Data to Create Promotion
    [Arguments]    ${Text_PromotionName}    ${Text_PromotionCode}    ${Text_Detail}    ${Text_Note}    ${Text_DiscountBath}
    Wait Until Element is ready and click    ${Create_Promotion}    10s
    Wait Until Element is ready and type    ${Promo_input_PromotionName}    ${Text_PromotionName}    10s
    Focus    ${Promo_input_PromotionCode}
    Wait Until Element is ready and type    ${Promo_input_PromotionCode}    ${Text_PromotionCode}    10s
    Wait Until Element is ready and click    ${Promo_start_datepicker}    10s
    Focus    ${Promo_Datepicker_Done}
    Wait Until Element is ready and click    ${Promo_Datepicker_Done}    10s
    Wait Until Element is ready and click    ${Promo_end_datepicker}    10s
    Wait Until Element is ready and click    ${Promo_Next_datepicker}    10s
    Focus    ${Promo_Date_datepicker}
    Wait Until Element is ready and click    ${Promo_Date_datepicker}    10s
    Focus    ${Promo_Datepicker_Done}
    Wait Until Element is ready and click    ${Promo_Datepicker_Done}    10s
    Keywords_Promotion.Input Description    ${Text_Detail}
    Wait Until Element is ready and type    ${Promo_input_PromotionNote}    ${Text_Note}    10s
    Wait Until Element is ready and click    ${Promo_DiscountPrice}    10s
    Wait Until Element is ready and type    ${Promo_input_DiscountPriceTextbox}    ${Text_DiscountBath}    10s
    Wait Until Element is ready and click    ${Promo_AllCart}    10s

Promotion - Select Unlimited Single Code to Create Promotion
    [Arguments]    ${Text_PromoCode}    ${Text_Prefix}
    Wait Until Element is ready and click    ${Single_Checkbox}    10s
    focus    ${Single_Input}
    Wait Until Element is ready and type    ${Single_Input}    ${Text_PromoCode}    10s
    Retry Single Code Time    ${Text_PromoCode}
    Wait Until Element is ready and click    ${Promo_UnlimitedTime}    10s
    Reattempt to Input Code prefix    ${Text_Prefix}

Promotion - Select Limited Single Code to Create Promotion
    [Arguments]    ${Text_PromoCode}    ${Text_Prefix}    ${Text_Limited}
    Wait Until Element is ready and click    ${Single_Checkbox}    10s
    focus    ${Single_Input}
    Wait Until Element is ready and type    ${Single_Input}    ${Text_PromoCode}    10s
    Retry Single Code Time    ${Text_PromoCode}
    Wait Until Element is ready and click    ${Promo_LimitedTime}    10s
    Wait Until Element is ready and type    ${Promo_Input_LimitedTime}    ${Text_Limited}    10s
    Reattempt to Input Code prefix    ${Text_Prefix}

Promotion - Select Unlimited VIP Code to Create Promotion
    [Arguments]    ${Text_PromoCode}    ${Text_Prefix}
    Wait Until Element is ready and click    ${VIP_Checkbox}    10s
    focus    ${VIP_Input}
    Wait Until Element is ready and type    ${VIP_Input}    ${Text_PromoCode}    10s
    Retry VIP Code Time    ${Text_PromoCode}
    Wait Until Element is ready and click    ${RadioVipCodeUnlimited_Locator}    10s
    Reattempt to Input Code prefix    ${Text_Prefix}

Promotion - Select Limited VIP Code to Create Promotion
    [Arguments]    ${Text_PromoCode}    ${Text_Prefix}
    Wait Until Element is ready and click    ${VIP_Checkbox}    10s
    focus    ${VIP_Input}
    Wait Until Element is ready and type    ${VIP_Input}    ${Text_PromoCode}    10s
    Retry VIP Code Time    ${Text_PromoCode}
    Wait Until Element is ready and click    ${RadioVipCodeLimited_Locator}    10s
    Reattempt to Input Code prefix    ${Text_Prefix}

Promotion - Select Unique Code to Create Promotion
    [Arguments]    ${Text_PromoCode}    ${Text_Prefix}
    Click Element    ${Unique_Checkbox}
    Input Text    ${Unique_Input}    ${Text_PromoCode}
    Retry Unique Code Time    ${Text_PromoCode}
    Input Text    ${Code_Prefix}    ${Text_Prefix}

Promotion - Select PC1 to Create Promotion
    Click Element    ${PC1_Checkbox}

Promotion - Select PC3 to Create Promotion
    Click Element    ${PC3_Checkbox}

Promotion - Upload VIP excel file
    Wait Until Element Is Visible    //*[@id="btn-submit-upload"]    60s
    Choose File    //*[@id="promotion-upload-import-file"]    ${Path-excel_file}\\promotions-vip-email-example.xlsx
    Wait Until Element is ready and click    //*[@id="btn-submit-upload"]    60s
    Wait Until Element Is Not Visible    //*[@id="upload-loading"]    60s
    Wait Until Element Is Visible    //*[@id="upload_import_result_label"]    60s
    Wait Until Element is ready and click    //*[@id="btn-upload-done"]    60s

Promotion - Save Promotion
    Wait Until Element is ready and click    ${Promo_SavePromotion}    60s

Input Description
    [Arguments]    ${text}
    Execute JavaScript    CKEDITOR.instances["description"].setData("${text}")

Input Random Chars
    [Arguments]    ${random_chars}
    Wait Until Element Is Visible    ${Code_Prefix_Random}    60s
    Input Text    ${Code_Prefix_Random}    ${random_chars}

Retry Single Code Time
    [Arguments]    ${Text_PromoCode}
    ${validate_Single}    Get Value    ${Single_Input}
    ${present_Single}=    Run Keyword And Return Status    Should Be Empty    ${validate_Single}
    Run Keyword If    ${present_Single}    Reattempt to Input Single Code Time    ${Text_PromoCode}

Retry VIP Code Time
    [Arguments]    ${Text_PromoCode}
    ${validate_Single}    Get Value    ${VIP_Input}
    ${present_Single}=    Run Keyword And Return Status    Should Be Empty    ${validate_Single}
    Run Keyword If    ${present_Single}    Reattempt to Input Single Code Time    ${Text_PromoCode}

Retry Unique Code Time
    [Arguments]    ${Text_PromoCode}
    ${validate_Unique}    Get Value    ${Unique_Input}
    ${present_Unique}=    Run Keyword And Return Status    Should Be Empty    ${validate_Unique}
    Run Keyword If    ${present_Unique}    Reattempt to Input Unique Code Time    ${Text_PromoCode}

Reattempt to Input Single Code Time
    [Arguments]    ${Text_PromoCode}
    : FOR    ${INDEX}    IN RANGE    0    10
    \    Input Text    ${Single_Input}    ${Text_PromoCode}
    \    Click Element    ${Single_Checkbox}
    \    ${validate_Single}    Get Text    ${Single_Input}
    \    ${empty_present}    Run Keyword And Return Status    Should Be Empty    ${validate_Single}
    \    Run Keyword If    ${empty_present}==${False}    Exit For Loop

Reattempt to Input Code prefix
    [Arguments]    ${Text_Prefix}
    : FOR    ${INDEX}    IN RANGE    0    10
    \    Input Text    ${Code_Prefix}    ${Text_Prefix}
    \    Click Element    ${Code_Prefix}
    \    ${validate_prefix}    Get Text    ${Code_Prefix}
    \    ${empty_present}    Run Keyword And Return Status    Should Be Empty    ${validate_prefix}
    \    Run Keyword If    ${empty_present}==${False}    Exit For Loop

Reattempt to Input VIP Code Time
    [Arguments]    ${Text_PromoCode}
    : FOR    ${INDEX}    IN RANGE    0    10
    \    Input Text    ${Single_Input}    ${Text_PromoCode}
    \    Click Element    ${Single_Checkbox}
    \    ${validate_Single}    Get Text    ${VIP_Input}
    \    ${empty_present}    Run Keyword And Return Status    Should Be Empty    ${validate_Single}
    \    Run Keyword If    ${empty_present}==${False}    Exit For Loop

Reattempt to Input Unique Code Time
    [Arguments]    ${Text_PromoCode}
    : FOR    ${INDEX}    IN RANGE    0    10
    \    Input Text    ${Unique_Input}    ${Text_PromoCode}
    \    Click Element    ${Unique_Checkbox}
    \    ${validate_Unique}    Get Text    ${Unique_Input}
    \    ${empty_present}    Run Keyword And Return Status    Should Be Empty    ${validate_Unique}
    \    Run Keyword If    ${empty_present}==${False}    Exit For Loop

Promotion - Remove Promotion By Campaign Name And Promotion Name
    [Arguments]    ${campaign_name}    ${promotion_name}
    Remove Promotion By Name And Campaign    ${campaign_name}    ${promotion_name}

Promotion - Select Discount Percent
    [Arguments]    ${Text_DiscountPercent}
    Wait Until Element is ready and click    ${Promo_DiscountPercent}    10s
    Wait Until Element is ready and type    ${Promo_input_DiscountPercentTextbox}    ${Text_DiscountPercent}    10s

Promotion - Select Effects On Cart
    Wait Until Element is ready and click    ${Promo_AllCart}    10s

Promotion - Select Effects On Cart With Conditions
    [Arguments]    ${effect_discount_which}
    Wait Until Element is ready and click    ${Promo_CartWithConditions}    15s
    Select From List    ${CartWithCon_Selcet}    ${effect_discount_which}

Promotion - Select Effect Collection
    [Arguments]    @{collections}
    Wait Until Element is ready and click    ${CartWithCon_Browse}    15s
    Wait Until Element Is Visible    ${CartWithCon_Popup}
    Select Frame    ${CartWithCon_Popup_iframe}
    Wait Until Page Contains Element    ${CartWithCon_Collection_Header}    10s
    : FOR    ${collection}    IN    @{collections}
    \    ${Collection_Checkbox}=    Replace String    ${CartWithCon_Checkbox_Collection}    REPLACE_ME    ccb${collection}
    \    Log To Console    ${Collection_Checkbox}
    \    Wait Until Element Is Visible    ${Collection_Checkbox}
    \    Click Element    ${Collection_Checkbox}
    Click Element    ${CartWithCon_Btn_Add}
    Unselect Frame

Promotion - Select Effect Exclude Products
    [Arguments]    @{exclude_products}
    Wait Until Element is ready and click    ${CartWithCon_Exclude_Browse}    15s
    Wait Until Element Is Visible    ${CartWithCon_Exclude_Popup}
    Select Frame    ${CartWithCon_Exclude_Popup_iframe}
    Wait Until Page Contains Element    ${CartWithCon_Exclude_Header}    10s
    : FOR    ${product_pkey}    IN    @{exclude_products}
    \    ${product_pkey}=    Convert To String    ${product_pkey}
    \    ${Product_Checkbox}=    Replace String    ${CartWithCon_Exclude_Checkbox}    REPLACE_ME    ${product_pkey}
    \    Log To Console    ${Product_Checkbox}
    \    Wait Until Element Is Visible    ${Product_Checkbox}
    \    Click Element    ${Product_Checkbox}
    Click Element    ${CartWithCon_Btn_Add}
    Unselect Frame

# Get Code From Promotion
#     [Arguments]    ${promotion_name}
#     Wait Until Page Contains Element    ${ManagePromo_Search}    60
#     Input Text    ${ManagePromo_Search}    ${promotion_name}
#     Wait Until Page Contains Element    ${ManagePromo_First_View_Btn}    60
#     ${url}=    Selenium2Library.Get Element Attribute    ${ManagePromo_First_View_Btn}@href
#     Click Element    ${ManagePromo_First_View_Btn}
#     Select Window    url=${url}
#     Wait Until Page Contains Element    ${ViewPromo_Code_Text}    60
#     ${code}=    Get Text    ${ViewPromo_Code_Text}
#     Return From Keyword    ${code}

Get Code From Promotion With Number
    [Arguments]    ${promotion_name}    ${code_no}
    Wait Until Page Contains Element    ${xpath-search-field}    60
    Input Text    ${xpath-search-field}    ${promotion_name}
    Wait Until Page Contains Element    ${ManagePromo_First_View_Btn}    60
    ${url}= Selenium2Library.Get Element Attribute    ${ManagePromo_First_View_Btn}@href
    Click Element    ${ManagePromo_First_View_Btn}
    Select Window    url=${url}
    Wait Until Page Contains Element    ${ViewPromo_Code_Text}    60
    ${code}=    Get Text    xpath=//table[@class="coupon-list"]/tbody/tr[${code_no}]/td[1]
    Return From Keyword    ${code}

Promotion - Select SpecificDate to Create Promotion
    Click Element    ${CheckBoxSpecificDate_Locator}

Promotion - Fill SpecificTime to Create Promotion
    [Arguments]    ${SpecificStartTime_Text}    ${SpecificEndTime_Text}
    Focus    ${SpecificStartTime_Locator}
    Wait Until Element is ready and type    ${SpecificStartTime_Locator}    ${SpecificStartTime_Text}    10s
    Focus    ${SpecificEndTime_Locator}
    Wait Until Element is ready and type    ${SpecificEndTime_Locator}    ${SpecificEndTime_Text}    10s

Promotion - Browse file for mass upload Specific Promotion
    [Arguments]    ${PathFile}
    ${CanonicalPath}=    common.Get Canonical Path    ${PathFile}
    Choose File          ${FileSpecificDate_Locator}    ${CanonicalPath}

Promotion - Set Specific Promotion in CSV
    [Arguments]    ${Data}
    ${PathFile}=     Set Variable     ${CURDIR}/../../../../Resource/TestData/Promotion/SpecificDate/csv/mass_upload_specific_date.csv
    csvlibrary.create_file    ${PathFile}    ${Data}
    [Return]     ${PathFile}

Promotion - Upload VIP E-mail With Excel
    ${PathFile}=     Set Variable     ${CURDIR}/../../../../Resource/TestData/Promotion/VIP_Email/excel/promotions-vip-email-example.xlsx
    ${CanonicalPath}=    common.Get Canonical Path    ${PathFile}
    Choose File          ${PromotionUploadImportFile_Locator}    ${CanonicalPath}
    Wait Until Element is ready and click    ${BtnSubmitUploadVip_Locator}    10s
    Wait Until Element is ready and click    ${BtnUploadDoneVip_Locator}    10s

Promotion - Create file for mass upload specific promotion
    ${date}=            Get Current Date    result_format=%Y-%m-%d
    @{data_name}=       Create List     Specific Date
    @{data_value1}=     Create List     ${date}
    @{data}=            Create List     ${data_name}        ${data_value1}
    ${pathFile}=        Set Variable     ${CURDIR}/../../../../Resource/TestData/Promotion/SpecificDate/csv/mass_upload_specific_date.csv
    csvlibrary.create_file    ${pathFile}    ${data}
    ${file_upload}=     common.Get Canonical Path    ${pathFile}
    ${filename}=        Get file name from canonical path    ${file_upload}
    Choose File          ${FileSpecificDate_Locator}    ${file_upload}

Promotion - Select Effects On Cart With Conditions Variant
    [Arguments]    ${VariantName}
    Wait Until Element is ready and click    ${Promo_CartWithConditions}    15s
    Select From List    ${CartWithCon_Selcet}    Variant
    Wait Until Element is ready and click    ${EffectDiscountFollowingItemsPopup_Locator}    15s
    Wait Until Element Is Visible    ${CartWithCon_Popup}
    Select Frame    ${CartWithCon_Variant_iFrame}
    Wait Until Page Contains Element    ${ManageItemsProductName_Locator}    10s
    Input Text    ${ManageItemsProductName_Locator}    ${VariantName}
    Wait Until Element is ready and click    ${ManageItemsSearchVariantButton_Locator}    15s
    Wait Until Element is ready and click    ${ManageItemsSelectFirstVariant_Locator}    15s
    Wait Until Element is ready and click    ${ManageItemsAddVariantButton_Locator}    15s
    Unselect Frame

Promotion - Select Effects On Cart With Conditions Brand
    [Arguments]    ${BrandName}
    Wait Until Element is ready and click    ${Promo_CartWithConditions}    15s
    Select From List    ${CartWithCon_Selcet}    Brand
    Wait Until Element is ready and click    ${EffectDiscountFollowingItemsPopup_Locator}    15s
    Wait Until Element Is Visible    ${CartWithCon_Popup}
    Select Frame    ${CartWithCon_Brand_iFrame}
    Wait Until Page Contains Element    ${ManageItemsInputBrand_Locator}    10s
    Input Text    ${ManageItemsInputBrand_Locator}    ${BrandName}
    Wait Until Element is ready and click    ${ManageItemsAddBrandButton_Locator}    15s
    Unselect Frame

Promotion - Select Effects On Cart With Conditions Product
    [Arguments]    ${ProductName}
    Wait Until Element is ready and click    ${Promo_CartWithConditions}    15s
    Select From List    ${CartWithCon_Selcet}    Product
    Wait Until Element is ready and click    ${EffectDiscountFollowingItemsPopup_Locator}    15s
    Wait Until Element Is Visible    ${CartWithCon_Popup}
    Select Frame    ${CartWithCon_Product_iFrame}
    Wait Until Page Contains Element    ${ManageItemsProductName_Locator}    10s
    Input Text    ${ManageItemsProductName_Locator}    ${ProductName}
    Wait Until Element is ready and click    ${ManageItemsSearchProductButton_Locator}    15s
    Wait Until Element is ready and click    ${ManageItemsSelectFirstProduct_Locator}    15s
    Wait Until Element is ready and click    ${ManageItemsAddProductButton_Locator}    15s
    Unselect Frame

Promotion - Select Effects On Cart With Conditions Collection
    Wait Until Element is ready and click    ${Promo_CartWithConditions}    15s
    Select From List    ${CartWithCon_Selcet}    Collection
    Wait Until Element is ready and click    ${EffectDiscountFollowingItemsPopup_Locator}    15s
    Wait Until Element Is Visible    ${CartWithCon_Popup}
    Select Frame    ${CartWithCon_Collection_iFrame}
    Wait Until Page Contains Element    ${ManageItemsCollectionName_Locator}    10s
    Wait Until Element is ready and click    ${ManageItemsSelectFirstCollection_Locator}    15s
    Wait Until Element is ready and click    ${ManageItemsAddCollectionButton_Locator}    15s
    Unselect Frame

Promotion - Select Exclude Products
    Wait Until Element is ready and click    ${CartWithCon_Exclude_Browse}    15s
    Wait Until Element Is Visible    ${CartWithCon_Exclude_Popup}
    Select Frame    ${CartWithCon_Exclude_Popup_iframe}
    Wait Until Page Contains Element    ${CartWithCon_Exclude_Header}    10s
    Wait Until Element is ready and click    ${EffectExcludeProductsPopup_Locator}    15s
    Wait Until Element is ready and click    ${ManageItemsAddExcludeProductsButton_Locator}    15s
    Unselect Frame

Promotion - Select Exclude Variants
    Wait Until Element is ready and click    ${EffectExcludeVariantsBrowse_Locator}    15s
    Wait Until Element Is Visible    ${EffectExcludeVariantsPopup_Locator}
    Select Frame    //*[@id="iframe-manage-items"]
#    Select Frame    ${CartWithCon_Product_iFrame}
#    Wait Until Page Contains Element    ${CartWithCon_Exclude_Header}    10s
    Sleep    15s
    Wait Until Element is ready and click     ${EffectExcludeVariantSelectFirst_Locator}     15s
#    : FOR    ${product_pkey}    IN    @{exclude_pkeys}
#    \    ${product_pkey}=    Convert To String    ${product_pkey}
#    \    ${Product_Checkbox}=    Replace String    ${CartWithCon_Exclude_Checkbox}    REPLACE_ME    ${product_pkey}
#    \    Log To Console    ${Product_Checkbox}
#    \    Wait Until Element Is Visible    ${Product_Checkbox}
#    \    Click Element    ${Product_Checkbox}

Promotion - Select Effects On Cart With Conditions Brand Exlude Product
    [Arguments]    ${BrandName}
    Wait Until Element is ready and click    ${Promo_CartWithConditions}    15s
    Select From List    ${CartWithCon_Selcet}    Brand
    Wait Until Element is ready and click    ${EffectDiscountFollowingItemsPopup_Locator}    15s
    Wait Until Element Is Visible    ${CartWithCon_Popup}
    Select Frame    ${CartWithCon_Brand_iFrame}
    Wait Until Page Contains Element    ${ManageItemsInputBrand_Locator}    10s
    Input Text    ${ManageItemsInputBrand_Locator}    ${BrandName}
    Wait Until Element is ready and click    ${ManageItemsAddBrandButton_Locator}    15s
    Unselect Frame

Promotion - Manage Display
    [Arguments]  ${promotion_id}  ${allow_display_on_web}=0  ${allow_thumbnail}=0
    ...  ${text_th}=${EMPTY}   ${text_en}=${EMPTY}   ${code_text_th}=${EMPTY}  ${code_text_en}=${EMPTY}
    ...  ${discount_th}=discount_th  ${discount_en}=discount_en
    ...  ${sort}=1

    Go To    ${PCMS_URL}/promotions/manage-display/${promotion_id}
    Wait Until Element Is Visible   id=allow_display_on_web    60s
    Run Keyword If   '${allow_display_on_web}' == '1'   Select Checkbox   id=allow_display_on_web
    Run Keyword If   '${allow_display_on_web}' == '1' and '${allow_thumbnail}' == '1'   Select Checkbox   id=allow_display_on_thumbnail

    Run Keyword If  '${allow_display_on_web}' == '1'   Input Text   id=title_text_th   ${text_th}
    Run Keyword If  '${allow_display_on_web}' == '1'  Input Text   id=title_text_en  ${text_en}
    Run Keyword If  '${allow_display_on_web}' == '1'  Input Text   id=code_text_th   ${code_text_th}
    Run Keyword If  '${allow_display_on_web}' == '1'   Input Text   id=code_text_en   ${code_text_en}
    Run Keyword If  '${allow_display_on_web}' == '1'  Input Text   id=discount_text_th   ${discount_th}
    Run Keyword If  '${allow_display_on_web}' == '1'  Input Text   id=discount_text_en   ${discount_en}
    Run Keyword If  '${allow_display_on_web}' == '1'  Input Text   id=sort   ${sort}
    Click Element   id=save_manage_display_btn

    Wemall Common - Success Message Is Display

Promotion - Go To Mass Upload Excluded Product
    [Arguments]   ${promotion_id}
    [Documentation]    Redirect to mass upload excluded product for this promotion
    ...   Arguments :
    ...       1. ${promotion_id}  - id of prmotion of set excluded product
    ...   Return  : Void

    Go To    ${PCMS_URL}/mass-upload-exclude-product-promotion-display/${promotion_id}

Promotion - Choose File For Mass Upload Excluded Product
    [Arguments]    ${list_products}         ${page_level}=Promotion_level_c
    [Documentation]
    ...   ** Description ** :
    ...      Create file csv from list and choose file for upload then click save button
    ...   Arguments :
    ...       1. List of product pkey
    ...   Return  : Void
    ...   Required :  CSV_Library

    ${header}=   Create List  Product Pkey
    ${product_list}=   Create List   ${header}
    Log TO Console   list_products=${list_products}
    ${length}=   Get Length  ${list_products}
    Log TO Console   length=${length}

    :FOR  ${index}  IN RANGE   0  ${length}
    \   Log To Console  index=${index}
    #\   ${product_pkey}=   Get From Dictionary   ${index}  product_pkey
    \   ${i}=   Evaluate   ${index} - 1
    \   Log To Console   list_products_in_loops=${list_products[${i}]}
    \   ${append_key}=   Create List    ${list_products[${i}]}
    \   Append To List   ${product_list}   ${append_key}

    Log TO console   product_list=${product_list}
    csvlibrary.Delete File   excluded_product.csv
    csvlibrary.Create file   excluded_product.csv   ${product_list}

    ${full_path}=   helper.get_canonical_path  ${CURDIR}/../../../../Test_Case/PCMS_API_get_promotion/${page_level}/excluded_product.csv
    Log To Console  full_path=${full_path}

    Choose File   id=file_upload   ${full_path}
    Click Element    id=btn_upload
    Wait Until Element Is Visible      //div[@class="alert alert-success"]