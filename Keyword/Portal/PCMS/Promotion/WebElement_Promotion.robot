*** Variables ***
&{XPATH_PCMS_PROMOTION}   btn_start_datepicker=//*[@id="start_datepicker"]
 ...   btn_end_datepicker=//*[@id="end_datepicker"]
 ...   btn_close_datepicker=//*[contains(@class, "ui-datepicker-close")]
 ...   btn_next_datepicker=//a[contains(@class,"ui-datepicker-next")]
 ...   btn_prev_datepicker=//a[contains(@class,"ui-datepicker-prev")]

${Promo_Group_List}    id=promotion_group
${Create_Promotion}    //*[@class="btn-group"]/a
${Promo_input_PromotionName}    //*[@id="name"]
${Promo_start_datepicker}    //*[@name="start_date"]
${Promo_Datepicker_Done}    //button[contains(text(),'Done')]
${Promo_end_datepicker}    //*[@name="end_date"]
${Promo_Next_datepicker}    //*[@class="ui-icon ui-icon-circle-triangle-e"]
${Promo_Date_datepicker}    //*[@class="ui-datepicker-calendar"]//a[contains(text(),'17')]
${Promo_input_PromotionCode}    //*[@id="code"]
${Promo_input_PromotionNote}    //*[@name="note"]
${Single_Checkbox}    //*[@class='single_code coupon-display']
${Single_Input}    //*[@class='ssmall single_code-used_times pcms-numeric']
${Code_Prefix}    //*[@id='code_prefix']
${Code_Prefix_Random}    name=conditions[promotion_code][0][end_with]
${Unique_Checkbox}    //*[@class='multiple_code']
${Unique_Input}    //*[@class='ssmall multiple_code-count pcms-numeric']
${PC1_Checkbox}    //*[@value="PC1"]
${PC3_Checkbox}    //*[@value="PC3"]
${Promo_DiscountPrice}    //*[@id="type-discount-price"]
${Promo_DiscountPercent}    //*[@id="type-discount-percent"]
${Promo_input_DiscountPriceTextbox}    //*[@id="discount-baht"]
${Promo_input_DiscountPercentTextbox}    //*[@id="discount-percent"]
${Promo_AllCart}    //*[@name="effects[discount][on]"]
${Promo_CartWithConditions}    //*[@name="effects[discount][on]" and @value="following"]
${Promo_SavePromotion}    //*[@id="test"]
${Promo_UnlimitedTime}    //*[@id="promotion-condition"]/div//div[contains(@class,'grid_6')]/input[contains(@value,'unlimited')]
${Promo_LimitedTime}    //*[@id="promotion-condition"]/div//div[contains(@class,'grid_6')]/input[@id='radio_single_code_limited']
${Promo_Input_LimitedTime}    //*[@id="promotion-condition"]/div//div[contains(@class,'grid_6')]/input[@id='text_single_code_time_per_user']
${VIP_Checkbox}    //*[@class="vip_code coupon-display"]
${VIP_Input}      //*[@class="ssmall vip_code-used_times pcms-numeric"]
${CartWithCon_Selcet}    //*[@id="effect-discount-which"]
${CartWithCon_Option}    //*[@id="effect-discount-which"]/option[@value="REPLACE_ME"]
${CartWithCon_Browse}    //*[@id="effects-discount-following_items-popup"]
${CartWithCon_Popup}       //*[@id="popup-manage-dialog-effects-discount-following_items"]
${CartWithCon_Popup_iframe}      jquery=#iframe-manage-items[src*="/collection"]
${CartWithCon_Collection_Header}      jquery=span:contains("Collection")
${CartWithCon_Checkbox_Collection}      //*[@id="REPLACE_ME"]
${CartWithCon_Btn_Add}      jquery=input.btn.btn-primary.add
${CartWithCon_Exclude_Browse}    //*[@id="effects-exclude_product-following_items-popup"]
${CartWithCon_Exclude_Popup}       //*[@id="popup-manage-dialog-effects-exclude_product-following_items"]
${CartWithCon_Exclude_Popup_iframe}      jquery=#iframe-manage-items[src*="/exclude"]
${CartWithCon_Exclude_Checkbox}      //*[@value="REPLACE_ME"]
${CartWithCon_Exclude_Header}      jquery=th:contains("Product Name")
${ManagePromo_Search}       //label[contains(text(),'Search')]/input[@type="text"]
${ManagePromo_First_View_Btn}      //a[contains(@href, "/promotions/view")][1]
${ViewPromo_Code_Text} 	   //table[@class="coupon-list"]/tbody/tr[1]/td[1]
${CheckBoxSpecificDate_Locator}    //*[@id="checkbox_specific_date"]
${SpecificStartTime_Locator}    //*[@id="start_time"]
${SpecificEndTime_Locator}    //*[@id="end_time"]
${FileSpecificDate_Locator}    //*[@id="file_specific_date"]
${RadioVipCodeUnlimited_Locator}    //*[@id="radio_vip_code_unlimited"]
${RadioVipCodeLimited_Locator}    //*[@id="radio_vip_code_limited"]
${PromotionUploadImportFile_Locator}    //*[@id="promotion-upload-import-file"]
${BtnSubmitUploadVip_Locator}    //*[@id="btn-submit-upload"]
${BtnUploadDoneVip_Locator}    //*[@id="btn-upload-done"]
${EffectDiscountFollowingItemsPopup_Locator}    //*[@id="effects-discount-following_items-popup"]
${CartWithCon_Variant_iFrame}      jquery=#iframe-manage-items[src*="/variant"]
${CartWithCon_Brand_iFrame}      jquery=#iframe-manage-items[src*="/brand"]
${CartWithCon_Product_iFrame}      jquery=#iframe-manage-items[src*="/product"]
${CartWithCon_Collection_iFrame}      jquery=#iframe-manage-items[src*="/collection"]
${ManageItemsProductName_Locator}    //*[@id="product"]
${ManageItemsCollectionName_Locator}    //*[@id="popup-manage-items-collection"]
${ManageItemsSearchVariantButton_Locator}    //*[@id="popup-manage-items-variant"]/div/form/div/div[10]/input[1]
${ManageItemsSelectFirstVariant_Locator}    //*[@id="popup-manage-items-variant"]/div/table[1]/tbody/tr[2]/td[5]/label/input
${ManageItemsAddVariantButton_Locator}    //*[@id="popup-manage-items-variant"]/div/div[2]/input
${ManageItemsAddBrandButton_Locator}    //*[@id="popup-manage-items-brand"]/div/input
${ManageItemsInputBrand_Locator}    //*[@id="popup-manage-items-brand"]/div/span/input
${ManageItemsAddProductButton_Locator}    //*[@id="popup-manage-items-product"]/div/div[2]/input
${ManageItemsSearchProductButton_Locator}    //*[@id="popup-manage-items-product"]/div/form/div/div[10]/input[1]
${ManageItemsSearchCollectionButton_Locator}    //*[@id="popup-manage-items-collection"]/div/form/div/div[10]/input[1]
#${ManageItemsSelectFirstProduct_Locator}    //*[@id="popup-manage-items-product"]/div/table[1]/tbody/tr/td[6]/label/input
${ManageItemsSelectFirstProduct_Locator}    //*[@id="product"]

${ManageItemsSelectFirstCollection_Locator}    //*[@id="ccb339"]
${ManageItemsAddCollectionButton_Locator}    //*[@id="popup-manage-items-collection"]/div[2]/div/div[2]/input
${EffectExcludeProductsPopup_Locator}    //*[@id="popup-manage-items-exclude-product"]/div/table[1]/tbody/tr/td[4]/label/input
${ManageItemsAddExcludeProductsButton_Locator}    //*[@id="popup-manage-items-exclude-product"]/div/div[1]/input
${ManageItemsSelectFirstCollection_Locator}    //*[@id="popup-manage-items-collection"]/div[2]/div/div[1]/div/div/ul/li[2]/label
${ManageItemsAddCollectionButton_Locator}    //*[@id="popup-manage-items-collection"]/div[2]/div/div[2]/input
${EffectExcludeVariantsBrowse_Locator}    //*[@id="effects-exclude_variant-following_items-popup"]
${EffectExcludeVariantsPopup_Locator}    //*[@id="popup-manage-dialog-effects-exclude_variant-following_items"]
${EffectExcludeVariantsPopupHeader_Locator}    //*[@class="product-head"]
${EffectExcludeVariantSelectFirst_Locator}    //*[@id="popup-manage-items-exclude-variant"]/div/table/tbody/tr[2]/td[5]/label/input[@name type="checkbox"]
${ExcludeVariantButton_Locator}    //*[@id="effects-exclude_product-following_items-popup"]
${PopupManageItemsVariantCkeckbox_Locator}    //*[@id="popup-manage-items-exclude-product"]/div/div[1]/input
${PopupManageItemsExcludeButton_Locator}    //*[@id="popup-manage-items-exclude-product"]/div/div[1]/input
${Back_Button_On_View_Promotion_Detail}       //*[@class="btn pull-left"]

########## Condition Popup ##########
${btn_browse_conditions}        jquery=input#effects-discount-following_items-popup
${iframe_condition}             jquery=#iframe-manage-items
${iframe_condition_exclude}     jquery=#iframe-manage-items[src*="/exclude"]
${iframe_condition_collection}  jquery=#iframe-manage-items[src*="/collection"]
${iframe_condition_bundle}      jquery=#iframe-manage-items[src*="/bundle"]
${iframe_condition_variant}     jquery=#iframe-manage-items[src*="/variant"]
${iframe_condition_product}     jquery=#iframe-manage-items[src*="/product"]
${dd_condition_brands}          jquery=#popup-manage-items-brand
${btn_condition_add}            jquery=input.btn.btn-primary.add
${btn_condition_criteria_search}    jquery=.btn.btn-primary[value='Search']
${dd_condition_brands_expand}   jquery=span i.icon-chevron-down
${colletion_header}             jquery=span:contains("Collection")
${bundle_search_section}        jquery=#popup-manage-items-variant
${bundle_search_name}           jquery=#product

