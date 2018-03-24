*** Variables ***
@{STARK_PRODUCTS}    2679214459674
@{VALID-VARIANT-FOR-FREEBIE}    ACAAA1112411    ACAAA1113511
${DISCOUNT_CODE}    STARKM
# @{PRODUCT-MATCH-FREEBIE}    2557653043206    2937986234586    2322905080606
@{PRODUCT-MATCH-FREEBIE}    2979665620312    2431244352715    2968751175312
${DELETED-PRODUCT}    2414298584954
${NOT-EXISED-PRODUCT}    210111000111

@{PRODUCT-DISCOUNT-CAMPAIGN}    &{product-disc-1}    &{product-disc-2}    &{product-disc-3}    &{product-disc-4}
&{product-disc-1}    pkey=2563512551645    name=phoenix product2 retail    normal_price=300    special_price=200     sku=ACAAC1115711    sku_name=phoenix product2 retail (Gold)
&{product-disc-2}    pkey=2349072834557    name=phoenix product3 retail place    normal_price=200    special_price=101    sku=ACAAC1116311    sku_name=phoenix product3 retail place (Gold)
&{product-disc-3}    pkey=2223533067871    name=phoenix product1 retail    normal_price=1000    special_price=600     sku=ACAAC1115611    sku_name=phoenix product1 retail (Gold)
&{product-disc-4}    pkey=2945231567822    name=phoenix_wow_retail2    normal_price=500    special_price=${EMPTY}     sku=ACAAC1116811    sku_name=phoenix_wow_retail2 (Gold)

@{PRODUCT-CATEGORY}    &{product-disc-5}    &{product-disc-6}    &{product-disc-7}    &{product-disc-8}
&{product-disc-5}    pkey=2722937182848    name=product test mass active product marketplace1    normal_price=1000    special_price=600    sku=ACAAC1113911    sku_name=product test mass active product marketplace1 (Gold)
&{product-disc-6}    pkey=2626802264842    name=product test mass active product retail1    normal_price=1000    special_price=601    sku=ACAAC1114111    sku_name=product test mass active product retail1 (Gold)
&{product-disc-7}    pkey=2596075948810    name=phoenix team use : mobile case Fabric Iphone 4/4s    normal_price=990    special_price=390    sku=MOAAA1113711    sku_name=Moontech : mobile case Fabric Iphone 4/4s pink Iphone 4/4s
&{product-disc-8}    pkey=2346236053476    name=phoenix product    normal_price=1000    special_price=600    sku=ACAAC1116911    sku_name=phoenix product (Gold)

${MERCHANT_CODE}          ITM
${MERCHANT_TYPE}          merchant
${ALIAS_MERCHANT_CODE}    AM00004
${ALIAS_MERCHANT_TYPE}    alias

&{CATEGORY_CREATE_JSON_TEMPLATE}    category_name="eiei"    category_name_translate="category_name_translate"
...    slug="slug"    status="active"    owner="${MERCHANT_CODE}"    owner_type="${MERCHANT_TYPE}"
...    image_url_desktop="desktop"    image_url_mobile="mobile"
${SKU_SIM_SEER}    THOOR1111211