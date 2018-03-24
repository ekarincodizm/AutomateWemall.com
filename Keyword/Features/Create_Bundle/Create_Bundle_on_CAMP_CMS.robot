*** Settings ***
Resource          ../../Portal/CAMP/CAMP_Bundle/Keywords_CAMP_Bundle.robot

*** Keywords ***
Create Bundle Promotion
    [Arguments]    ${Text_BundleName}    ${Text_BundleShortDesc}    ${Text_BundleDesc}    ${Text_BundleStart}    ${Text_BundleEnd}    ${Text_BundleNote}
    ...    ${Text_PrimaryVariant}    ${Text_VariantDiscountPercent}    ${Text_BundleVariant}    ${Text_BundleDiscountPercent}
    Bundle - Create Bundle    ${Text_BundleName}    ${Text_BundleShortDesc}    ${Text_BundleDesc}    ${Text_BundleStart}    ${Text_BundleEnd}    ${Text_BundleNote}
    ...    ${Text_PrimaryVariant}    ${Text_VariantDiscountPercent}    ${Text_BundleVariant}    ${Text_BundleDiscountPercent}
    Keywords_CAMP_Bundle.Click build button
