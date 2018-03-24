*** Variables ***
#### Promotion List Elements
${PROMO-SEARCH-ID-FIELD}    //*[@id='promotionId']
${PROMO-SEARCH-NAME-FIELD}    //*[@id='promotionName']
${PROMO-SEARCH-TYPE-SELECT}    //*[@id='promotionTypeSelect']
#### Create Promotion Template
${CREATE-PROMOTION-BUTTON}    //*[@id="createPromotionBtn"]
${CREATE-PROMOTION-FREEBIE-BUTTON}    //*[@id='createBtn0']
${CREATE-PROMOTION-BUNDLE-BUTTON}    //*[@id='createBtn1']
${CREATE-PROMOTION-MNP-BUTTON}    //*[@id='createBtn2']
${CREATE-PROMOTION-DISCOUNT-BY-CODE-BUTTON}    //*[@id='createBtn3']
#### Promotion Rule
## Freebie
${PROMO-CRITERIA-TYPE-SELECT}    //*[@id='criteriaTypeSelect']
# ${PROMO-CRITERIA-VALUE-FIELD}     //*[@id='criteriaValues']
${PROMO-CRITERIA-VALUE-FIELD}     //*[@id='criteriaValuesDiv']/div/input
${PROMO-CRITERIA-VALUE-SPAN}     //*[@id='criteriaValuesDiv']/div/span
${PROMO-MIN-QUANTITY-RADIO-SPAN}    //*[@id='minTotalQuantitySpan']
${PROMO-MIN-QUANTITY-FIELD}    //*[@id='minTotalQuantity']
${PROMO-MIN-VALUE-RADIO-SPAN}    //*[@id='minTotalValueSpan']
${PROMO-MIN-VALUE-FIELD}    //*[@id='minTotalValue']
${PROMO-FREE-TYPE-OR-RADIO-SPAN}    //*[@id='promotionTemplate']/div[19]/div/div/div[1]/label/span
${PROMO-FREE-TYPE-AND-RADIO-SPAN}    //*[@id='promotionTemplate']/div[19]/div/div/div[2]/label/span
${PROMO-FREE-VARIANT-FIELD}    //*[@id='freeVariant1']
# ${PROMO-FREE-VARIANT-SPAN}    //*[@id='freeVariantQuantity1']
${PROMO-FREE-QUANTITY-FIELD}    //*[@id='freeVariantQuantity1']
${PROMO-REPEAT-FIELD}    //*[@id='repeat']
${PROMO-FREEBIE-NOTE-FIELD}    //input[@id='freebieNote']
${PROMO-FREEBIE-NOTE-TRANS1-FIELD}    //input[@id='freebieNoteTranslation']
${PROMO-FREEBIE-IMG-LVC-DESKTOP-DIV}    //*[@id='lvCDropzoneDiv']/div
${PROMO-FREEBIE-IMG-LVC-DESKTOP-INPUT}    //input[@id='lvCDropzoneInput']
${PROMO-FREEBIE-IMG-LVC-DESKTOP-MSG-PARAG}    //p[@id='lvCValidateMessage']
${PROMO-FREEBIE-IMG-LVC-DESKTOP-TRANS1-DIV}    //*[@id='lvCTransDropzoneDiv']/div
${PROMO-FREEBIE-IMG-LVC-DESKTOP-TRANS1-INPUT}    //input[@id='lvCTransDropzoneInput']
${PROMO-FREEBIE-IMG-LVC-DESKTOP-TRANS1-MSG-PARAG}    //p[@id='lvCTransValidateMessage']
${PROMO-FREEBIE-IMG-LVC-MOBILE-DIV}    //*[@id='lvCMobileDropzoneDiv']/div
${PROMO-FREEBIE-IMG-LVC-MOBILE-INPUT}    //input[@id='lvCMobileDropzoneInput']
${PROMO-FREEBIE-IMG-LVC-MOBILE-MSG-PARAG}    //p[@id='lvCMobileValidateMessage']
${PROMO-FREEBIE-IMG-LVC-MOBILE-TRANS1-DIV}    //*[@id='lvCMobileTransDropzoneDiv']/div
${PROMO-FREEBIE-IMG-LVC-MOBILE-TRANS1-INPUT}    //input[@id='lvCMobileTransDropzoneInput']
${PROMO-FREEBIE-IMG-LVC-MOBILE-TRANS1-MSG-PARAG}    //p[@id='lvCMobileTransValidateMessage']
${PROMO-FREEBIE-IMG-LVD-DESKTOP-DIV}    //*[@id='lvDDropzoneDiv']/div
${PROMO-FREEBIE-IMG-LVD-DESKTOP-INPUT}    //input[@id='lvDDropzoneInput']
${PROMO-FREEBIE-IMG-LVD-DESKTOP-MSG-PARAG}    //p[@id='lvDValidateMessage']
${PROMO-FREEBIE-IMG-LVD-DESKTOP-TRANS1-DIV}    //*[@id='lvDTransDropzoneDiv']/div
${PROMO-FREEBIE-IMG-LVD-DESKTOP-TRANS1-INPUT}    //input[@id='lvDTransDropzoneInput']
${PROMO-FREEBIE-IMG-LVD-DESKTOP-TRANS1-MSG-PARAG}    //p[@id='lvDTransValidateMessage']
${PROMO-FREEBIE-IMG-LVD-MOBILE-DIV}    //*[@id='lvDMobileDropzoneDiv']/div
${PROMO-FREEBIE-IMG-LVD-MOBILE-INPUT}    //input[@id='lvDMobileDropzoneInput']
${PROMO-FREEBIE-IMG-LVD-MOBILE-MSG-PARAG}    //p[@id='lvDMobileValidateMessage']
${PROMO-FREEBIE-IMG-LVD-MOBILE-TRANS1-DIV}    //*[@id='lvDMobileTransDropzoneDiv']/div
${PROMO-FREEBIE-IMG-LVD-MOBILE-TRANS1-INPUT}    //input[@id='lvDMobileTransDropzoneInput']
${PROMO-FREEBIE-IMG-LVD-MOBILE-TRANS1-MSG-PARAG}    //p[@id='lvDMobileTransValidateMessage']
#### MODAL TO CONFIRM FREEBIE CRITERIA VARIANT
${DUPLICATE-FREEBIE-CRITERIA-VARIANT-TABLE}    xpath=//table[@id='duplicatedFreebieCriteriaTable']
#### MODAL TO CONFIRM Flashsale Product Variant
${DUPLICATE-FLASHSALE-PRODUCT-TABLE}    xpath=//table[@id='duplicatedWowProductTable']
## MNP & Bundle
${PROMO-BUNDLE-MNP-NOTE-FILED}    //*[@id='cke_noteLocal']
${PROMO-TRANS1-BUNDLE-MNP-NOTE-FILED}    //*[@id='cke_noteEN']
${PROMO-MNP-PRIMARY-VARIANT-FIELD}		//*[@id='primaryVariantsDiv']/div/input

## Discount By Code
${PROMO-CRITERIA-TYPE-SELECT}    //*[@id='criteriaTypeSelect']
${PROMO-CODE-GROUP-ID-FIELD}     //*[@id='codeGroupId']
${PROMO-MAX-DISCOUNT-FIELD}     //*[@id='maxDiscountValue']
${PROMO-EXCL-VARIANT-FIELD}   //*[@id="excludedVariantsDiv"]/div/input
${PROMO-EXCL-COLLECTION-FIELD}    //*[@id='excludedCollections']
${PROMO-EXCL-BRAND-FIELD}    //*[@id='excludedBrands']
${PROMO-EXCL-CATEGORY-FIELD}    //*[@id='excludedCategories']
${PROMO-PC1-RADIO-SPAN}    //*[@id='pc1RadioType']
${PROMO-PC3-RADIO-SPAN}    //*[@id='pc3RadioType']
${PROMO-MIN-TOTAL-FIELD}     //*[@id='minTotalValue']
${PROMO-PERCENT-RADIO-SPAN}    //*[@id='discountPercentSpan']
${PROMO-PERCENT-FIELD}    //*[@id='discountPercent' and @name='discountPercent']
${PROMO-BAHT-RADIO-SPAN}    //*[@id='discountFixedSpan']
${PROMO-BAHT-FIELD}    //*[@id='discountFixed' and @name='discountFixed']
${PROMO-SHOW-CODE-CHKBOX}    //*[@id='showCodeCheckbox']
${PROMO-SHOW-CODE-CHKBOX-SPAN}    //*[@id='showCodeSpan']
${PROMO-CODE-CRITERIA-VALUE-FIELD}    //*[@id="criteriaValuesDiv"]/div/input
${PROMO-SELECT-CODE-GROUP-BUTTON}    //*[@id='selectCodeGroupBtn']
${PROMO-CODE-GROUP-ID-FIELD}    //input[@id='codeGroupId']
