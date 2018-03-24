*** Variables ***
@{STARK_PRODUCTS}    2803442357317
@{VALID-VARIANT-FOR-FREEBIE}    ABAAA1116111    ABAAA1116811
${DISCOUNT_CODE}    STARKZ
@{PRODUCT-MATCH-FREEBIE}    2838243483444    2774291547777    2451584365992

@{PRODUCT-DISCOUNT-CAMPAIGN}    &{product-disc-1}    &{product-disc-2}    &{product-disc-3}    &{product-disc-4}
&{product-disc-1}    pkey=2819329275669    name=phoenix product2 retail    normal_price=300    special_price=200     sku=ACAAC1114711    sku_name=phoenix product2 retail (Gold)
&{product-disc-2}    pkey=2848095780821    name=phoenix product3 retail place    normal_price=200    special_price=101    sku=ACAAC1115311    sku_name=phoenix product3 retail place (Gold)
&{product-disc-3}    pkey=2692572383377    name=phoenix product1 retail    normal_price=1000    special_price=600     sku=ACAAC1114611    sku_name=phoenix product1 retail (Gold)
&{product-disc-4}    pkey=2363841963416    name=phoenix_wow_retail2    normal_price=500    special_price=${EMPTY}     sku=ACAAC1116211    sku_name=phoenix_wow_retail2 (Gold)

@{PRODUCT-CATEGORY}    &{product-disc-5}    &{product-disc-6}    &{product-disc-7}    &{product-disc-8}
&{product-disc-5}    pkey=2579416923793    name=product test mass active product marketplace1    normal_price=1000    special_price=600    sku=ACAAC1113711    sku_name=product test mass active product marketplace1 (Gold)
&{product-disc-6}    pkey=2954236583426    name=product test mass active product retail1    normal_price=1000    special_price=601    sku=ACAAC1113811    sku_name=product test mass active product retail1 (Gold)
&{product-disc-7}    pkey=2596075948810    name=phoenix team use : mobile case Fabric Iphone 4/4s    normal_price=990    special_price=390    sku=MOAAA1113711    sku_name=Moontech : mobile case Fabric Iphone 4/4s pink Iphone 4/4s
&{product-disc-8}    pkey=2846965419383    name=phoenix product    normal_price=1000    special_price=600    sku=ACAAC1116611   sku_name=phoenix product (Gold)

${MERCHANT_CODE}          TH3493
${MERCHANT_TYPE}          merchant
${ALIAS_MERCHANT_CODE}    AM00001
${ALIAS_MERCHANT_TYPE}    alias
&{CATEGORY_CREATE_JSON_TEMPLATE}    category_name="eiei"    category_name_translate="category_name_translate"
...    slug="slug"    status="active"    owner="${MERCHANT_CODE}"    owner_type="${MERCHANT_TYPE}"
...    image_url_desktop="desktop"    image_url_mobile="mobile"