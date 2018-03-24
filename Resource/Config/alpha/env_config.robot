*** Variables ***
${PCMS_APP_KEY}    45311375168544
${PDS_URL}        http://alpha-products-cms.itruemart-dev.com
${Wemall_URL}     http://alpha-www.wemall-dev.com
${Campaign_URL}    http://52.74.31.162/wm
${FMS_URL}        http://api-fms-alpha.aden-dev.com
${Path-ImgFile}    C:\\git\\ITrueMart-Wemall\\Resource\\PIC
${FMS}            http://alpha-products-api.wemall-dev.com
${FMS_API}        alp-api2-fms.aden-dev.asia
${FMS_API_V1}      alp-api-fms.aden-dev.asia
${FMS_API_USERNAME}    warehousepassword
${FMS_API_PASSWORD}    warehousepassword
${Merchant_API_URL}    http://apis-gateway.wemall-dev.com
${AAD_API}        http://apis-gateway.wemall-dev.com
${AAD_PORTAL}     http://admin.itruemart-dev.com
${MC_URL}         http://alpha-campaign-cms.itruemart-dev.com
${Shop_in_Shop_Page}    http://alpha-www2.itruemart-dev.com/shop
${Storefront_Menu}    http://alpha-storefront-cms.wemall-dev.com/#/storefrontManagement/    # /Web or /Mobile
${AAD_database}    staging-aad-db.wemall-dev.com
${AAD_database_Authz}    authz-db.wemall-dev.com
${CAMP_URL}       http://campaign-cms.itruemart-dev.com
${API_GATEWAY}    http://alpha-apis-gateway.wemall-dev.com
${ITM_URL}        http://alpha-www.wemall-dev.com
${ITM_URL_API}    alpha-www.itruemart-dev.com
${ITM_MOBILE}     http://alpha-m.itruemart-dev.com
${ITM_MOBILE_URL}    http://alpha-m.itruemart-dev.com
${ITM_URL_SSL}    fhttps://alpha-www.itruemart-dev.com
${PCMS_URL}       http://alpha-pcms.itruemart-dev.com
${PCMS_URL_HTTP}    alpha-pcms.itruemart-dev.com
${PCMS_URL_API}    alpha-pcms.itruemart-dev.com
${PCMS_API_URL}    alpha-pcms.itruemart-dev.com
${PCMS_URL_SSL}    https://alpha-pcms.itruemart-dev.com
${PCMS_PKEY}      /api/45311375168544
${PCMS_PORT}      80
${PCMS_URL_API}    alpha-pcms.itruemart-dev.com
${API_GATEWAY_HOST}    alpha-apis-gateway.wemall-dev.com
${PORTAL_API}     ${API_GATEWAY_HOST}
${GENERAL_API_HOST}    ${API_GATEWAY_HOST}
${HTTP_PROTOCAL}    http
${GENERAL_API}    ${HTTP_PROTOCAL}://${API_GATEWAY_HOST}/gen/v1/
${CDN_SERVER}     //alpha-cdn.wemall-dev.com/
${AAD_API_HOST}    ${API_GATEWAY_HOST}
${STOREFRONT-API}    http://${API_GATEWAY_HOST}${CSS_STOREFRONT}
${STOREFRONT-API-httpLib}    ${API_GATEWAY_HOST}
${STOREFRONT_CMS}    http://alpha-storefront-cms.wemall-dev.com
${PORTAL-HOST}    http://alpha-portal-cms.wemall-dev.com
${WEMALL_RESOURCE}    http://alpha-resource.wemall-dev.com
######### Operation #########
${UPLOADS}        /gen/v1/uploads/
${GEOLOCATIONS}    /gen/v1/geolocations/
${sku_created}    /api/key/v1/sku/create_with_mat_marketplace/
${supplier_created}    /api/key/v1/supplier
${Tokens_API}     /authen/v1/tokens
${CSS_STOREFRONT}    /css/v3/storefronts/
${CSS_SHOP}       /css/v3/shops/
${MEGAMENUS}      /cps/v1/mega-menus/
${MERCHANT_ZONES}    /cps/v1/merchant-zones/
${STATIC_CONTENTS}    /cps/v1/static-contents/
${SHOWROOMS}      /cps/v1/showrooms/
${TEMPLATES}      /cps/v1/templates/
${MENUBARS}       /cps/v1/menubars/
${MERCHANT}       /mch/v1/merchants/
${RETAIL}         retail
${SLUG}           slug/
${PCMS_USERNAME}    admin@domain.com
${PCMS_PASSWORD}    12345
${AAD-LOGIN-URI}    /authen
${AAD-USERNAME}    test
${AAD-PASSWORD}    password
${AAD-HOST-API}    apis-gateway.wemall-dev.com
${AAD-HEADER}     application/x-www-form-urlencoded
${AAD-LOGIN-URL}    http://apis-gateway.wemall-dev.com/authen
${AAD-GET-ACCESS-TOKEN-URL}    http://apis-gateway.wemall-dev.com/authen/v1/tokens
${add-cart}       /api/v2/45311375168544/cart/add-item
${update-cart}    /api/v2/45311375168544/cart/add-item
${delete-cart}    /api/v2/45311375168544/cart/remove-item
${get-cart}       /api/v2/45311375168544/cart
${create-order}    /api/45311375168544/order/create
${showroom}       /api/45311375168544/showroom
${ORDER-TRACKING}    /api/45311375168544/order-tracking/receive-status
${order-live-agent}    /api/45311375168544/order-live-agent
${truemoveh-registerinfo-save}    /api/45311375168544/truemoveh/registerinfo/save
${truemoveh-all-mobile-b3}    /truemove-h/api/all-mobile-b3
${truemoveh-all-mobile}    /truemove-h/api/all-mobile
${RESEND-EMAIL-THANK-YOU}    /api/45311375168544/resend/thank-you
${RESEND-EMAIL-TRACKING}    /api/45311375168544/resend/tracking
${default_inventoryID}    INAAC1112611
#${default_inventoryID_cod}    URAAA1115411
${default_inventoryID_cod}    CHAAA1111511
${default_inventoryID_tm}    URAAA1112711
${default_inventoryID_cs}    LOAAB1111111
${default_inventoryID_retail}    WDAAA1114411
${default_inventoryID_market_place}    LAAAD1111211
# alpha freebie campaign_id=9376
${default_inventoryID_A_with_freebie}    MIAAA1112111
${default_inventoryID_C_with_freebie}    MIAAA1113211
${default_inventoryID_B_freebie_for_inv_A}    MIAAA1111811
${default_inventoryID_D_freebie_for_inv_C}    MIAAA1113111
${inventoryID_inst_fail}    GOAAC1111411
${CAMP-HOST-API}    alpha-campaign-api.wemall-dev.com:8080
${CAMP-DELETE-CAMPAIGN-URI}    /api/v1/itm/campaigns
${CAMP-CREATE-CAMPAIGN-URI}    /api/v1/itm/campaigns
${CAMP-CREATE-PROMOTION-URI}    /api/v1/itm/promotions
${CAMP-BUILD-URI}    /api/v1/itm/promotions/build
&{URL_MNP}        LANDING=${ITM_URL}/truemove-h/MNP    LANDING_NOCACHE=${ITM_URL}/truemove-h/MNP?no-cache=1    LANDING_PREVIEW=${ITM_URL}/truemove-h/MNP?previews=LS2&no-cache=1    VERIFY=${ITM_URL}/truemove-h/MNP/verify    REGISTER=${ITM_URL}/truemove-h/MNP/register    HANDSET=${ITM_URL}/truemove-h/MNP/handset
&{URL_MNP_MOBILE}    LANDING=${ITM_MOBILE_URL}/truemove-h/MNP    LANDING_NOCACHE=${ITM_MOBILE_URL}/truemove-h/MNP?no-cache=1    LANDING_PREVIEW=${ITM_MOBILE_URL}/truemove-h/MNP?previews=LS2&no-cache=1    VERIFY=${ITM_MOBILE_URL}/truemove-h/MNP/verify    REGISTER=${ITM_MOBILE_URL}/truemove-h/MNP/register    HANDSET=${ITM_MOBILE_URL}/truemove-h/MNP/handset
&{URL_MNP_PROPO}    MANAGE_PROPO=${PCMS_URL}/truemoveh/proposition    CREATE_PROPO=${PCMS_URL}/truemoveh/proposition/create
&{URL_ITM}        CHECKOUT_STEP1=${ITM_URL_SSL}/checkout/step1    CHECKOUT_STEP2=${ITM_URL}/checkout/step2    CHECKOUT_STEP3=${ITM_URL_SSL}/checkout/step3    CHECKOUT_STEP1_CONTAIN=/checkout/step1    CHECKOUT_STEP2_CONTAIN=/checkout/step2    CHECKOUT_STEP3_CONTAIN=/checkout/step3
&{URL_PCMS}       set_payment=${PCMS_URL}/products/set-payment    set_fee_config=${PCMS_URL}/shipping/set-fee-config    set_shipping=${PCMS_URL}/products/set-shipping    campaigns=${PCMS_URL}/campaigns    create_campaings=${PCMS_URL}/create/campaigns    discount_campaigns=${PCMS_URL}/discount-campaigns    create_discount_campaings=${PCMS_URL}/discount-campaings/create
...               set_payment=${PCMS_URL}/products/set-payment
############################
#########         CAMPS    ##########
############################
######### Common #########
${BROWSER}        Google Chrome
${CAMPS-BROWSER}    Chrome
${CAMPS-SELENIUM-SPEED}    0.2
########## Host ##########
${CAMPS-HOST}     http://alpha-campaign-cms.itruemart-dev.com    #Alpha
${CAMPS-API}      alpha-apis-gateway.wemall-dev.com    #Alpha
${LOGIN-PAGE}     http://alpha-merchant.itruemart-dev.com    #Alpha
${MERCHANT-API}    alpha-apis-gateway.wemall-dev.com    #Alpha
####### User Password #######
${USER-CAMPS}     test
${PASSWORD-CAMPS}    password
${CAMP_USERNAME}    test
${CAMP_PASSWORD}    password
${ITM_USERNAME}    starkautomate@gmail.com
${ITM_PASSWORD}    true1234!
${g_loading_delay}    40
${g_loading_delay_short}    5
${g_promo_id}     ${EMPTY}
${g_code_group_id}    ${EMPTY}
${g_camp_id}      ${EMPTY}
${g_email_group_id}    ${EMPTY}
${g_camp_name}    ${EMPTY}
${g_flash_sale_id}    ${EMPTY}
${RESOURCE-PATH}    ${CURDIR}/../../../Resource
# ${RESOURCE-PATH}    C:\\Git\\itruemart-wemall\\Resource
${RESOURCE-IMAGE-PATH}    ${RESOURCE-PATH}/PIC
# ${DOWNLOAD-PATH}    %{USERPROFILE}/Downloads
#### test data ####
@{products}       2838243483444    2774291547777    2451584365992
${CAMP-PROTOCOL}    http
${CAMP-SSL-PROTOCOL}    https
${CAMP-PORT}      8080
${CAMP-TOP-LEVEL-DOMAIN}    alpha-campaign-api.wemall-dev.com:${CAMP-PORT}
${CAMP-HOST}      ${CAMP-PROTOCOL}://${CAMP-TOP-LEVEL-DOMAIN}
${CAMP-SSL-HOST}    ${CAMP-SSL-PROTOCOL}://${CAMP-TOP-LEVEL-DOMAIN}
${CAMP-API-PROMOTION-URI}    /api/v1/itm/promotions
${CAMP-API-PROMOTION-URL}    ${CAMP-HOST}${/}${CAMP-API-PROMOTION-URI}
${X-WM-ACCESSTOKEN}    x-wm-accesstoken
${X-WM-ACCESSTOKEN-VALUE}    eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJkbm0iOiJ0ZXN0IHRlc3QiLCJ1c3IiOiI0NSIsInR5cCI6Im1lcmMiLCJleHAiOjE0NTI1NzUyNjl9.hBieFE6J2nldW46QCpxdrK5ztn5E9psqbhrHRkTA5M3_ufp5dWmXSWyGRpOjvch6IFhXad-i6M3CINA2JvnZuaxuu-t7PXD_bYyX-3tfI9OrCP0uVmy4DZowIt92KxNZIcZ1IN7Mp_RcX7wJmpTaq05cySfaBFs89KcAloK6T4Q
${X-WM-REFRESHTOKEN}    x-wm-refreshtoken
${X-WM-REFRESHTOKEN-VALUE}    eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJ1c3IiOiI0NSIsInR5cCI6Im1lcmMiLCJleHAiOjE0NTUxNjM2Njl9.LUchcbJkRFbs-FgpETQ7hOSMeWzYL0oTb60K9rkJVD0gcmpV8IKOuuyBpbJTGxf0K7Deb6-3ycxgT4Umenx8zC7WdXMb-TnR3JF3X8DgYTAevdjLOfL11V3l2JS--vzElDNOoV8F5GLpiB_1e2FJdZgLhJm9fDQK8CLZXEsl5sQ
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
${PRODUCT-REBUILD-STOCK}    product/rebuild-stock
${PRODUCT-REBUILD-STOCK-NO-VARIANT}    product/rebuild-stock-no-variant
${PRODUCT-REBUILD-STOCK-MOBILE}    products/rebuild-mobile-stocks
@{PRODUCT-MATCH-FREEBIE}    2838243483444    2774291547777    2451584365992
@{PRODUCT-MATCH-FREEBIE}    2838243483444    2774291547777    2451584365992
${WWW_WEMALL}     alpha-www2.itruemart-dev.com
# ${WWW_WEMALL}    antman-www.wemall-dev.com
${WEMALL_WEB}     http://alpha-www.wemall-dev.com
${BUNDLE-CAMPAIGN-ID}    6814
${PRODUCT-REBUILD-STOCK}    product/rebuild-stock
${PRODUCT-REBUILD-STOCK-NO-VARIANT}    product/rebuild-stock-no-variant
${PRODUCT-REBUILD-STOCK-MOBILE}    products/rebuild-mobile-stocks
@{PRODUCT-MATCH-FREEBIE}    2838243483444    2774291547777    2451584365992
${CHECKOUT_TIMEOUT}    10s
${WEMALL_URL}     http://alpha-www.wemall-dev.com
${WEMALL_API}     alpha-www.wemall-dev.com
${WEMALL_URL_SSL}    https://alpha-www.wemall-dev.com
${WEMALL_MOBILE}    http://alpha-m.wemall-dev.com
${WEMALL_MOBILE_URL}    http://alpha-m.wemall-dev.com
${WEMALL_MOBILE_URL_SSL}    https://alpha-m.wemall-dev.com
${WEMALL_ITM}     http://alpha-www.wemall-dev.com/itruemart
${PROTOCOL}       http
${BOOKING_URL}    https://alpha-booking.itruemart-dev.com
${BOOKING_LEVEL_DOMAIN}    alpha-booking.itruemart-dev.com
${BOOKING_IMAGE_PRODUCT_URL}    assets/layouts/iphone-se/products
#### PDS ####
${PDS_URL_API}    alpha-pds-api.wemall-dev.com
${PDS-API-URI}    /pds-api
${MNP_IMAGE_PATH}    ${CURDIR}/../../../Resource/TestData/Mnp/images/image_profile.jpg
#### Merchant LV.C Category #####
${cat_slug_pkey}    mobiles-32266229877531
${SHOP_LYRA_ROBOT}    lyra-test
${merchant_slug}       lyra-test
${cat_pkey_lyra}      32266229877531
${product_pkey_p_01}     2526812076359
${product_pkey_outofstock}     2419405631683
${xpath_product_no_1}    //*[@id="wrapper_content"]/div/div[4]/div[3]/div[1]/div/a/span[2]/span[2]
${MNP_IMAGE_PATH}    ${CURDIR}/../../../Resource/TestData/Mnp/images/image_profile.jpg
#### Dynamoc Table Name #####
${STOREFRONT_SHOP_TABLE}    wms-a-dym-css-shops
${STOREFRONT_STOREFRONT_WEB_DRAFT_TABLE}    wms-a-dym-css-storefronts-web-draft
${STOREFRONT_STOREFRONT_WEB_PUBLISH_TABLE}    wms-a-dym-css-storefronts-mobile-draft
${STOREFRONT_STOREFRONT_MOBILE_DRAFT_TABLE}    wms-a-dym-css-storefronts-web
${STOREFRONT_STOREFRONT_MOBILE_PUBLISH_TABLE}    wms-a-dym-css-storefronts-mobile
${ADMIN_WEMALL}    http://alpha-admin.itruemart-dev.com/
${MERCHANT_CENTER_URL}     http://alpha-merchant.itruemart-dev.com
${MERCHANT_REPORT_URL}     http://alpha-merchant-report.itruemart-dev.com

### POINT SERVICE ###
${POINT_URL}    http://alpha-point-cms.itruemart-dev.com

### API GATEWAY SUPERNUMBER ###
${SUPERNUMBER_API_GATEWAY}     alpha-api.itruemart-dev.com
${SP_API_KEY}    z9xvuMPGFT4isNx8cDBcx3s7MsVuqgMv2WucZYBJ

#### Merchant LV.C Category #####
${cat_slug_pkey}    mobiles-32266229877531
${SHOP_LYRA_ROBOT}    lyra-test
${merchant_slug}       lyra-test
${cat_pkey_lyra}      32266229877531
${product_pkey_p_01}     2526812076359
${product_pkey_outofstock}     2419405631683
${xpath_product_no_1}    //*[@id="wrapper_content"]/div/div[4]/div[3]/div[1]/div/a/span[2]/span[2]

### SELF-SERVICE ###
${SELF_SERVICE_URL}             http://selfservice.loc
${SELF_SERVICE_URL_HTTP}        selfservice.loc
${SELF_SERVICE_URL_MOBILE}      http://alpha-selfservice.wemall-dev.com/mobile/main
