*** Variables ***
${PCMS_APP_KEY}    45311375168544
${PDS_URL}        http://products-cms.itruemart-dev.com
${Campaign_URL}    http://52.74.31.162/wm
${FMS_URL}        http://api-fms-alpha.aden-dev.com
${Path-ImgFile}    C:\\git\\ITrueMart-Wemall\\Resource\\PIC
${PDS_API_URL}    http://products-api.wemall-dev.com:8080
${FMS}            http://alpha-products-api.wemall-dev.com
${Merchant_API_URL}    http://apis-gateway.wemall-dev.com
${AAD_API}        http://apis-gateway.wemall-dev.com
${AAD_PORTAL}     http://admin.itruemart-dev.com
${MC_URL}         http://merchant.itruemart-dev.com
${Shop_in_Shop_Page}    http://www.wemall-dev.com/shop
${Storefront_Menu}    http://storefront-cms.wemall-dev.com/#/storefrontManagement/    # /Web or /Mobile
${AAD_database}    staging-aad-db.wemall-dev.com
${AAD_database_Authz}    authz-db.wemall-dev.com
${CAMP_URL}       http://campaign-cms.itruemart-dev.com
${API_GATEWAY}    http://apis-gateway.wemall-dev.com


${ITM_URL}      http://antman-www.itruemart-dev.com
${ITM_URL_API}    antman-www.itruemart-dev.com
${ITM_MOBILE_URL}   http://antman-m.itruemart-dev.com
${ITM_MOBILE}       http://antman-m.itruemart-dev.com
${ITM_URL_SSL}   http://antman-www.itruemart-dev.com
${ITM_USERNAME}    robotautomate@gmail.com
${ITM_PASSWORD}    true1234
${PCMS_URL}    http://antman-pcms.itruemart-dev.com:81
${PCMS_URL_API}    antman-pcms.itruemart-dev.com:81
${PCMS_URL_SSL}    http://antman-pcms.itruemart-dev.com:81
${PCMS_PKEY}    /api/45311375168544
${PCMS_APP_KEY}    45311375168544
${PCMS_PORT}    80
# ${FB_USERNAME}    emailtesting54321@gmail.com
# ${FB_PASSWORD}    true1234


${PCMS_API_URL}    antman-pcms.itruemart-dev.com:81
${PCMS_USERNAME}    admin@domain.com
${PCMS_PASSWORD}    12345
${CAMP-HOST-API}    alpha-campaign-api.wemall-dev.com:8080
${CAMP-DELETE-CAMPAIGN-URI}  /api/v1/itm/campaigns
${CAMP-CREATE-CAMPAIGN-URI}  /api/v1/itm/campaigns
${CAMP-CREATE-PROMOTION-URI}  /api/v1/itm/promotions
${CAMP-BUILD-URI}  /api/v1/itm/promotions/build

${CAMP-PROTOCOL}     http
${CAMP-SSL-PROTOCOL}    https
${CAMP-PORT}        8080
${CAMP-TOP-LEVEL-DOMAIN}       alpha-campaign-api.wemall-dev.com:${CAMP-PORT}
${CAMP-HOST}       ${CAMP-PROTOCOL}://${CAMP-TOP-LEVEL-DOMAIN}
${CAMP-SSL-HOST}     ${CAMP-SSL-PROTOCOL}://${CAMP-TOP-LEVEL-DOMAIN}

${CAMP-API-PROMOTION-URI}   /api/v1/itm/promotions
${CAMP-API-PROMOTION-URL}      ${CAMP-HOST}${/}${CAMP-API-PROMOTION-URI}

${X-WM-ACCESSTOKEN}            x-wm-accesstoken
${X-WM-ACCESSTOKEN-VALUE}      eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJkbm0iOiJ0ZXN0IHRlc3QiLCJ1c3IiOiI0NSIsInR5cCI6Im1lcmMiLCJleHAiOjE0NTI1NzUyNjl9.hBieFE6J2nldW46QCpxdrK5ztn5E9psqbhrHRkTA5M3_ufp5dWmXSWyGRpOjvch6IFhXad-i6M3CINA2JvnZuaxuu-t7PXD_bYyX-3tfI9OrCP0uVmy4DZowIt92KxNZIcZ1IN7Mp_RcX7wJmpTaq05cySfaBFs89KcAloK6T4Q
${X-WM-REFRESHTOKEN}            x-wm-refreshtoken
${X-WM-REFRESHTOKEN-VALUE}      eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJ1c3IiOiI0NSIsInR5cCI6Im1lcmMiLCJleHAiOjE0NTUxNjM2Njl9.LUchcbJkRFbs-FgpETQ7hOSMeWzYL0oTb60K9rkJVD0gcmpV8IKOuuyBpbJTGxf0K7Deb6-3ycxgT4Umenx8zC7WdXMb-TnR3JF3X8DgYTAevdjLOfL11V3l2JS--vzElDNOoV8F5GLpiB_1e2FJdZgLhJm9fDQK8CLZXEsl5sQ

${CAMP-V1-LEVEL-DOMAIN}    alpha-apis-gateway.wemall-dev.com
${CAMP-V1-HOST}    ${CAMP-PROTOCOL}://${CAMP-V1-LEVEL-DOMAIN}
${CAMP-V1-CREATE-MNP-URI}    /cmp/v1/itm/promotions
${CAMP-V1-BUILD-MNP-URI}    ${CAMP-V1-CREATE-MNP-URI}/build
${CAMP-V1-CREATE-MNP-URL}    ${CAMP-V1-HOST}/${CAMP-V1-CREATE-MNP-URI}
${CAMP-V1-CREATE-FREEBIE-URI}    /cmp/v1/itm/promotions
${CAMP-V1-BUILD-FREEBIE-URI}    ${CAMP-V1-CREATE-FREEBIE-URI}/build
${CAMP-V1-CREATE-CAMPAIGNS-URI}    /cmp/v1/itm/campaigns
${CAMP-V1-CREATE-PROMOTIONS-URI}    /cmp/v1/itm/promotions
${CAMP-V1-BUILD-PROMOTIONS-URI}    ${CAMP-V1-CREATE-PROMOTIONS-URI}/build
${CAMP-V1-GET-BUNDLE-URI}    /api/v1/promotions/bundles
${CAMP-V1-GET-FREEBIE-URI}    /api/v1/itm/promotions/freebie/
${FREEBIE-CAMPAIGN-ID}    5709
${FREEBIE-COLLECTION-ID}    339
${BUNDLE-CAMPAIGN-ID}    6814

# ${CAMP-V1-LEVEL-DOMAIN}        alpha-campaign-api.wemall-dev.com:${CAMP-PORT}
# ${CAMP-V1-HOST}                ${CAMP-PROTOCOL}://${CAMP-V1-LEVEL-DOMAIN}
# ${CAMP-V1-CREATE-MNP-URI}      /api/v1/itm/promotions
# ${CAMP-V1-BUILD-MNP-URI}       ${CAMP-V1-CREATE-MNP-URI}/build
# ${CAMP-V1-CREATE-MNP-URL}      ${CAMP-V1-HOST}/${CAMP-V1-CREATE-MNP-URI}

# ${CAMP-V1-CREATE-FREEBIE-URI}    /cmp/v1/itm/promotions
# ${CAMP-V1-BUILD-FREEBIE-URI}       ${CAMP-V1-CREATE-FREEBIE-URI}/build

# ${CAMP-V1-CREATE-CAMPAIGNS-URI}    /cmp/v1/itm/campaigns

# ${CAMP-V1-CREATE-PROMOTIONS-URI}    /api/v1/itm/promotions
# ${CAMP-V1-BUILD-PROMOTIONS-URI}       ${CAMP-V1-CREATE-PROMOTIONS-URI}/build
# ${CAMP-V1-GET-BUNDLE-URI}           /api/v1/promotions/bundles
# ${FREEBIE-CAMPAIGN-ID}        2371
# ${BUNDLE-CAMPAIGN-ID}         2297

${CAMP-HOST-API}    alpha-campaign-api.wemall-dev.com:8080
${CAMP-DELETE-CAMPAIGN-URI}  /api/v1/itm/campaigns
${CAMP-CREATE-CAMPAIGN-URI}  /api/v1/itm/campaigns
${CAMP-CREATE-PROMOTION-URI}  /api/v1/itm/promotions
${CAMP-BUILD-URI}  /api/v1/itm/promotions/build

${AAD-LOGIN-URI}    /authen
${AAD-USERNAME}    test
${AAD-PASSWORD}    password
${AAD-HOST-API}   alpha-apis-gateway.wemall-dev.com
${AAD-HEADER}         application/x-www-form-urlencoded
${AAD-LOGIN-URL}    http://alpha-apis-gateway.wemall-dev.com/authen
${AAD-GET-ACCESS-TOKEN-URL}  http://alpha-apis-gateway.wemall-dev.com/authen/v1/tokens


${add-cart}		/api/v2/45311375168544/cart/add-item
${update-cart}		/api/v2/45311375168544/cart/add-item
${delete-cart}		/api/v2/45311375168544/cart/remove-item
${get-cart}			/api/v2/45311375168544/cart


${create-order}		/api/45311375168544/order/create


${showroom}			/api/45311375168544/showroom

${g_loading_delay}    40
${g_loading_delay_short}    5
${g_promo_id}     ${EMPTY}
${g_code_group_id}    ${EMPTY}
${g_camp_id}      ${EMPTY}
${g_email_group_id}    ${EMPTY}
${g_camp_name}    ${EMPTY}
${g_flash_sale_id}    ${EMPTY}
${RESOURCE-PATH}    ${CURDIR}/../../../Resource
${RESOURCE-IMAGE-PATH}    ${RESOURCE-PATH}/PIC

${truemoveh-registerinfo-save}    /api/45311375168544/truemoveh/registerinfo/save
${truemoveh-all-mobile-b3}   /truemove-h/api/all-mobile-b3
${truemoveh-all-mobile}   /truemove-h/api/all-mobile

${default_inventoryID_retail}                APAAA1116211               #valid with all payment channel
${default_inventoryID_market_place}          JBAAA1117811               #valid with all payment channel

# alpha freebie campaign_id=9376
${default_inventoryID_A_with_freebie}        MIAAA1112111
${default_inventoryID_C_with_freebie}        MIAAA1113211
${default_inventoryID_B_freebie_for_inv_A}   MIAAA1111811
${default_inventoryID_D_freebie_for_inv_C}   MIAAA1113111

&{URL_MNP}  LANDING=${ITM_URL}/truemove-h/MNP
 ...  LANDING_NOCACHE=${ITM_URL}/truemove-h/MNP?no-cache=1
 ...  LANDING_PREVIEW=${ITM_URL}/truemove-h/MNP?previews=LS2&no-cache=1
 ...  VERIFY=${ITM_URL}/truemove-h/MNP/verify
 ...  REGISTER=${ITM_URL}/truemove-h/MNP/register
 ...  HANDSET=${ITM_URL}/truemove-h/MNP/handset


&{URL_MNP_MOBILE}  LANDING=${ITM_MOBILE_URL}/truemove-h/MNP
 ...  LANDING_NOCACHE=${ITM_MOBILE_URL}/truemove-h/MNP?no-cache=1
 ...  LANDING_PREVIEW=${ITM_MOBILE_URL}/truemove-h/MNP?previews=LS2&no-cache=1
 ...  VERIFY=${ITM_MOBILE_URL}/truemove-h/MNP/verify
 ...  REGISTER=${ITM_MOBILE_URL}/truemove-h/MNP/register
 ...  HANDSET=${ITM_MOBILE_URL}/truemove-h/MNP/handset

&{URL_MNP_PROPO}    MANAGE_PROPO=${PCMS_URL}/truemoveh/proposition
 ...  CREATE_PROPO=${PCMS_URL}/truemoveh/proposition/create

&{URL_ITM}  CHECKOUT_STEP1=${ITM_URL_SSL}/checkout/step1
 ...   CHECKOUT_STEP2=${ITM_URL}/checkout/step2
 ...   CHECKOUT_STEP3=${ITM_URL_SSL}/checkout/step3
 ...   CHECKOUT_STEP1_CONTAIN=/checkout/step1
 ...   CHECKOUT_STEP2_CONTAIN=/checkout/step2
 ...   CHECKOUT_STEP3_CONTAIN=/checkout/step3

&{URL_PCMS}   set_payment=${PCMS_URL}/products/set-payment
 ...  set_fee_config=${PCMS_URL}/shipping/set-fee-config
 ...  set_shipping=${PCMS_URL}/products/set-shipping
 ...  campaigns=${PCMS_URL}/campaigns
 ...  create_campaings=${PCMS_URL}/create/campaigns
 ...  discount_campaigns=${PCMS_URL}/discount-campaigns
 ...  create_discount_campaings=${PCMS_URL}/discount-campaings/create
 ...  set_payment=${PCMS_URL}/products/set-payment

${WWW_WEMALL}    antman-www.wemall-dev.com
${WEMALL_WEB}    http://antman-www.wemall-dev.com
${WEMALL_URL}    http://antman-www.wemall-dev.com
${WEMALL_URL_SSL}   https://antman-www.wemall-dev.com
${WEMALL_MOBILE}   http://antman-m.wemall-dev.com
${WEMALL_MOBILE_URL}   http://antman-m.wemall-dev.com
${WEMALL_MOBILE_URL_SSL}   https://antman-m.wemall-dev.com
${WEMALL_ITM}      http://antman-www.wemall-dev.com/itruemart


${API_GATEWAY_HOST}    alpha-apis-gateway.wemall-dev.com
#${WWW_WEMALL}    sandbox-www2.itruemart-dev.com
#${API_GATEWAY_HOST}    sandbox-storefront-api.wemall-dev.com
${WWW_WEMALL}    alpha-www2.itruemart-dev.com
${API_GATEWAY_HOST}    alpha-apis-gateway.wemall-dev.com
${STOREFRONT-API-httpLib}    ${API_GATEWAY_HOST}
#${CSS_STOREFRONT}       /v3/storefronts/
${CSS_STOREFRONT}       /css/v3/storefronts/
${CSS_SHOP}             /css/v3/shops/


####global variable####
${g_loading_delay}    40
${g_loading_delay_short}    5

${CAMP-V1-LEVEL-DOMAIN}        alpha-apis-gateway.wemall-dev.com
${CAMP-V1-HOST}                ${CAMP-PROTOCOL}://${CAMP-V1-LEVEL-DOMAIN}
${CAMP-V1-CREATE-MNP-URI}      /cmp/v1/itm/promotions
${CAMP-V1-BUILD-MNP-URI}       ${CAMP-V1-CREATE-MNP-URI}/build
${CAMP-V1-CREATE-MNP-URL}      ${CAMP-V1-HOST}/${CAMP-V1-CREATE-MNP-URI}
${CAMP-V1-CREATE-FREEBIE-URI}    /cmp/v1/itm/promotions
${CAMP-V1-BUILD-FREEBIE-URI}       ${CAMP-V1-CREATE-FREEBIE-URI}/build
${CAMP-V1-CREATE-CAMPAIGNS-URI}    /cmp/v1/itm/campaigns
${CAMP-V1-CREATE-PROMOTIONS-URI}    /cmp/v1/itm/promotions
${CAMP-V1-BUILD-PROMOTIONS-URI}       ${CAMP-V1-CREATE-PROMOTIONS-URI}/build
${CAMP-V1-GET-BUNDLE-URI}           /api/v1/promotions/bundles
${CAMP-V1-GET-FREEBIE-URI}           /api/v1/itm/promotions/freebie/


${PRODUCT-REBUILD-STOCK}    product/rebuild-stock
${PRODUCT-REBUILD-STOCK-NO-VARIANT}    product/rebuild-stock-no-variant
${PRODUCT-REBUILD-STOCK-MOBILE}    products/rebuild-mobile-stocks
@{PRODUCT-MATCH-FREEBIE}    2838243483444    2774291547777    2451584365992
${CHECKOUT_TIMEOUT}    10s
${WEMALL_API}     antman-www.wemall-dev.com
${PROTOCOL}        http

#### Dummy Inventory Id for creating order ####
${default_inventoryID}          INAAC1112611
${default_inventoryID_cod}      INAAC1112611
${default_inventoryID_cs}       LOAAB1111111

#### FMS ####
${FMS}            http://alpha-products-api.wemall-dev.com
${FMS_API}        api2-fms-alpha.aden-dev.com
${FMS_API_V1}            api-fms-alpha.aden-dev.com
${FMS_API_USERNAME}    warehousepassword
${FMS_API_PASSWORD}    warehousepassword
