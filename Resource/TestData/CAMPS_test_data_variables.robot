*** Variables ***
@{MONTHS}         Month    Jan    Feb    Mar    Apr    May    Jun
...               Jul    Aug    Sep    Oct    Nov    Dec
@{DAYS}           Day    Sunday    Monday    Tuesday    Wednesday    Thursday    Friday
...               Saturday
## USER and PASSWORD ##
${VALID-USERNAME}    user
${VALID-PASSWORD}    password
##################
@{VALID-VARIANT}      AAAA111111    BBBB222222    CCCC333333    DDDD444444    EEEE555555    FFFF666666    GGGG777777
...               HHHH888888    IIII999999    JJJJ101010    JJJJ111111
@{VALID-BRAND}    Apple    Samsung    Asus    Nivea    LG    Etude    ELF    Fuji    Casio    Panasonic    iRobot
@{VALID-CAT}    Beauty    Gadget    Electronics    Watch    Mobile    House    Personal    Television    Camera    Health    Baby
@{VALID-COL}    Beauty    Gadget    Electronics    Watch    Mobile    House    Personal    Television    Camera    Health    Baby
${VALID-PROMO-NAME}    Test Promotion Sale Discount Free สุดคุ้ม !!
${VALID-PROMO-DESC}    Test Promotion Description:<br />line1<br />line2<br />line3 line3 line3<br />line4 with very long text longggggggg longgggggggggggggg textttttttttttttttttttttt<br />ทดสอบภาษาไทย โปรโมชั่น ลดราคา เซลล์ รับของแถมฟรีๆ !!<br />..END..
${VALID-EMAIL-GROUP-DESC}    Test รายละเอียด\nแบบสั้น
${VALID-SHORT-PROMO-DESC}    Test รายละเอียด\nแบบสั้น
${VALID-BUNDLE-NOTE}    <strong>หมายเหตุ</strong><br />Bundle Note<br />จำกัดสิทธิ์การซื้อสินค้า 1 ชิ้นต่อ 1 ตระกร้า
${VALID-FREEBIE-NOTE}    หมายเหตุเพิ่มเติม, please notice
${VALID-DISCOUNT-CODE}    AAAAAA

@{VALID-PRIMARY-VARIANT}    PPPP111111    PPPP222222    PPPP333333    PPPP444444
@{VALID-PRIMARY-VARIANTS}    PPPP111111,PPPP222222
@{VALID-BUNDLE-VARIANT}    SIM1    SIM2    SIM3    SIM4    SIM5    SIM6
@{VALID-FLASH-SALE-VARIANT}    ACAAB1111111    ACAAB1111211    ACAAB1111311
@{VALID-FLASH-SALE-VARIANTS-ONE-PRODUCT}    ANAAA1111711    ANAAA1111211    ANAAA1111311
${EQUAL-PRICE-FLASH-SALE-VARIANT}    TRAAA1112111
&{VALID-APP-ID}    1=iTruemart    6=Exclusive Privilege    9=TruemoveH
@{VALID-FLASH-SALE-PAYMENT}    WALLET   ONLINE_BANKING    INSTALLMENT    CCW    COUNTER_SERVICE    COD
@{VALID-FLASH-SALE-PARTNER}    none    line    truemoveh    trueyou
@{VALID-FLASH-SALE-TYPE}    All    WOW Banner    WOW Extra

&{VALID-FLASH-SALE-PRODUCT-1}    pkey=2428076992894    name=Enjoy 5200
&{VALID-FLASH-SALE-PRODUCT-2}    pkey=2159606493470    name=Enjoy 7800
&{VALID-FLASH-SALE-PRODUCT-3}    pkey=2191142217400    name=Candy 5200

@{criteria_typesPromotion}    Category    Brand    Variant    Collection    Cart
@{criteria_typesFreebie}    Category    Brand    Variant
@{VALID-COLLECTION}    COLL1111    COLL2222    COLL3333    COLL4444    COLL5555    COLL6666    COLL7777    COLL8888    COLL9999    COLL1010    COLL1011
@{VALID-PRODUCT}    PROD1111    PROD2222    PROD3333    PROD4444    PROD5555    PROD6666    PROD7777    PROD8888    PROD9999    PROD1010    PROD1011
## DEAL DATA ##
@{criteria_types}    Collection     Category    Brand    Product    Variant
${dealColls}        @{VALID-COLLECTION}[0],@{VALID-COLLECTION}[1],@{VALID-COLLECTION}[2]
${dealCATs}        @{VALID-CAT}[0],@{VALID-CAT}[1],@{VALID-CAT}[2]
${dealBrands}      @{VALID-BRAND}[0],@{VALID-BRAND}[1]
${dealProds}        @{VALID-PRODUCT}[1],@{VALID-PRODUCT}[2]
${dealVARs}        @{VALID-VARIANT}[1],@{VALID-VARIANT}[2]
${exclColls}        @{VALID-COLLECTION}[9],@{VALID-COLLECTION}[10]
${exclCATs}        @{VALID-CAT}[9],@{VALID-CAT}[10]
${exclBrands}      @{VALID-BRAND}[9],@{VALID-BRAND}[10]
${exclProds}        @{VALID-PRODUCT}[9],@{VALID-PRODUCT}[10]
${exclVARs}        @{VALID-VARIANT}[9],@{VALID-VARIANT}[10]


# ${VALID-CAMPAIGN-NAME}    Test Campaign แคมเปญ!!
# ${VALID-CAMPAIGN-DETAIL}    รายละเอียดแคมเปญ\nTest Promotion Detail:\nline1\nline2\nline3 line3 line3\nline4 with very long text longggggggg longgggggggggggggg textttttttttttttttttttttt\nทดสอบภาษาไทย !!\n..END..
${VALID-CAMPAIGN-NAME}    Test Campaign !!
${VALID-CAMPAIGN-DETAIL}    Test Promotion Detail:\nline1\nline2\nline3 line3 line3\nline4 with very long text longggggggg longgggggggggggggg textttttttttttttttttttttt\n !!\n..END..

@{VALID-GENCODE-TYPE}    unlimited    limited
${101-CHARACTERS}    cnumrcenknvcghwdbjxzbrsyvnzuuliukodxfzdwjpnugtmrhyfpasmgaiboeqkhrdaebzxioxqzsrxpjwiubjhaxbzatsrwmpnps

${CSV-FILE-REPLACE-LIST}    ${RESOURCE-PATH}/csv_file_existing_list.csv
${CSV-FILE-DUPLICATE-LIST}    ${RESOURCE-PATH}/csv_file_duplicate.csv
${CSV-FILE-WRONG-FORMAT-LIST}    ${RESOURCE-PATH}/csv_file_wrong_format.csv
${EXPORT-EMAIL-FILE}    ${RESOURCE-PATH}/exported_vip_email
