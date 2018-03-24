*** Variables ***
@{STARK_PRODUCTS}    2803442357317
@{VALID-VARIANT-FOR-FREEBIE}    ABAAA1116111    ABAAA1116811
${DISCOUNT_CODE}    STARKZ
@{PRODUCT-MATCH-FREEBIE}    2838243483444    2774291547777    2451584365992

@{PRODUCT-DISCOUNT-CAMPAIGN}    &{product-disc-1}    &{product-disc-2}    &{product-disc-3}    &{product-disc-4}
&{product-disc-1}    pkey=2819329275669    name=phoenix product2 retail    normal_price=300    special_price=200     sku=ACAAC1114711    sku_name=phoenix product2 retail (Gold)
&{product-disc-2}    pkey=2848095780821    name=phoenix product3 retail place    normal_price=200    special_price=101    sku=ACAAC1115311    sku_name=phoenix product3 retail place (Gold)
&{product-disc-3}    pkey=2692572383377    name=phoenix product1 retail    normal_price=1000    special_price=600     sku=ACAAC1114611    sku_name=phoenix product1 retail (Gold)
&{product-disc-4}    pkey=2539962330251    name=phoenix product market place    normal_price=500    special_price=${EMPTY}     sku=ACAAC1115411    sku_name=phoenix product market place (สีดำ, Free Size)

${MERCHANT_CODE}          TH3493
${MERCHANT_TYPE}          merchant

&{CATEGORY_CREATE_JSON_TEMPLATE}    category_name="eiei"    category_name_translate="category_name_translate"
...    slug="slug"    status="active"    owner="${MERCHANT_CODE}"    owner_type="${MERCHANT_TYPE}"
...    image_url_desktop="desktop"    image_url_mobile="mobile"

