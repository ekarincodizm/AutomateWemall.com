*** Variables ***
${PCMS_APP_KEY}    45311375168544
${BROWSER}        Google Chrome
${PDS_URL}        http://products-cms.itruemart-dev.com
${Wemall_URL}     http://www.wemall-dev.com
${Campaign_URL}    http://52.74.31.162/wm
${FMS_URL}        http://api-fms.aden-dev.asia
${Path-ImgFile}    C:\\git\\ITrueMart-Wemall\\Resource\\PIC
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
#${ITM_URL}       http://www.wemall-dev.com
${ITM_URL}        http://www.itruemart-dev.com
${ITM_URL_API}    www.itruemart-dev.com
${ITM_MOBILE_URL}    http://m.itruemart-dev.com
${ITM_MOBILE}     http://m.itruemart-dev.com
${ITM_URL_SSL}    https://www.itruemart-dev.com
${ITM_MOBILE_URL_SSL}    https://m.itruemart-dev.com
${PCMS_URL}       http://pcms.itruemart-dev.com
${PCMS_URL_HTTP}    pcms.itruemart-dev.com
${PCMS_URL_API}    pcms.itruemart-dev.com
${PCMS_URL_SSL}    https://pcms.itruemart-dev.com
${PCMS_PKEY}      /api/45311375168544
${PCMS_PORT}      80
${WEMALL_WEB}     http://www.wemall-dev.com
${API_GATEWAY_HOST}    apis-gateway.wemall-dev.com
${WEMALL_RESOURCE}    http://resource.wemall-dev.com
#${API_GATEWAY_URL}    http://apis.gateway.wemall-dev.com
${GENERAL_API_HOST}    ${API_GATEWAY_HOST}
${HTTP_PROTOCAL}    http
${GENERAL_API}    ${HTTP_PROTOCAL}://${API_GATEWAY_HOST}/gen/v1/
${CDN_SERVER}     //cdn.wemall-dev.com/
${PORTAL_API}     ${API_GATEWAY_HOST}
${PORTAL-HOST}    http://portal-cms.wemall-dev.com
${AAD_API_HOST}    ${API_GATEWAY_HOST}
${STOREFRONT-API}    http://${API_GATEWAY_HOST}${CSS_STOREFRONT}
${STOREFRONT-API-httpLib}    ${API_GATEWAY_HOST}
${STOREFRONT_CMS}    http://storefront-cms.wemall-dev.com
${ITM_URL}        http://www.itruemart-dev.com
${ITM_MOBILE_URL}    http://m.itruemart-dev.com
${ITM_URL_SSL}    https://www.itruemart-dev.com
${PCMS_URL}       http://pcms.itruemart-dev.com
${PCMS_URL_HTTP}    pcms.itruemart-dev.com
${PCMS_URL_API}    pcms.itruemart-dev.com
${PROTOCOL}       http
${PCMS_URL_SSL}    https://pcms.itruemart-dev.com
${PCMS_PKEY}      /api/45311375168544
${PCMS_PORT}      80
${GENERAL_API_HOST}    ${API_GATEWAY_HOST}
${HTTP_PROTOCAL}    http
${GENERAL_API}    ${HTTP_PROTOCAL}://${API_GATEWAY_HOST}/gen/v1/
${CDN_SERVER}     //cdn.wemall-dev.com/
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
${PCMS_API_URL}    pcms.itruemart-dev.com
#${PCMS_USERNAME}    devitm@itruemart.com
#${PCMS_PASSWORD}    1234567
${PCMS_USERNAME}    admin@domain.com
${PCMS_PASSWORD}    12345
${CAMP-PROTOCOL}    http
${CAMP-SSL-PROTOCOL}    https
${CAMP-PORT}      8080
${CAMP-TOP-LEVEL-DOMAIN}    campaign-api.wemall-dev.com:${CAMP-PORT}
${CAMP-HOST}      ${CAMP-PROTOCOL}://${CAMP-TOP-LEVEL-DOMAIN}
${CAMP-SSL-HOST}    ${CAMP-SSL-PROTOCOL}://${CAMP-TOP-LEVEL-DOMAIN}
${CAMP-API-PROMOTION-URI}    /api/v1/itm/promotions
${CAMP-API-PROMOTION-URL}    ${CAMP-HOST}${/}${CAMP-API-PROMOTION-URI}
${X-WM-ACCESSTOKEN}    x-wm-accesstoken
${X-WM-ACCESSTOKEN-VALUE}    eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJkbm0iOiJ0ZXN0IHRlc3QiLCJ1c3IiOiI0NSIsInR5cCI6Im1lcmMiLCJleHAiOjE0NTI1NzUyNjl9.hBieFE6J2nldW46QCpxdrK5ztn5E9psqbhrHRkTA5M3_ufp5dWmXSWyGRpOjvch6IFhXad-i6M3CINA2JvnZuaxuu-t7PXD_bYyX-3tfI9OrCP0uVmy4DZowIt92KxNZIcZ1IN7Mp_RcX7wJmpTaq05cySfaBFs89KcAloK6T4Q
${X-WM-REFRESHTOKEN}    x-wm-refreshtoken
${X-WM-REFRESHTOKEN-VALUE}    eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJ1c3IiOiI0NSIsInR5cCI6Im1lcmMiLCJleHAiOjE0NTUxNjM2Njl9.LUchcbJkRFbs-FgpETQ7hOSMeWzYL0oTb60K9rkJVD0gcmpV8IKOuuyBpbJTGxf0K7Deb6-3ycxgT4Umenx8zC7WdXMb-TnR3JF3X8DgYTAevdjLOfL11V3l2JS--vzElDNOoV8F5GLpiB_1e2FJdZgLhJm9fDQK8CLZXEsl5sQ
${CAMP-V1-LEVEL-DOMAIN}    apis-gateway.wemall-dev.com
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
#${FREEBIE-CAMPAIGN-ID}    2371
${FREEBIE-CAMPAIGN-ID}    10616
${FREEBIE-COLLECTION-ID}    339
${BUNDLE-CAMPAIGN-ID}    2297
#20161010  *** UPDATE URL Freebie
#${AAD-LOGIN-URI}    /authen
#${AAD-LOGIN-URI}    /authen/v1/tokens
${AAD-LOGIN-URI}    /authen/v1/tokens?grant_type=merchant
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
${FMS_API}        api2-fms.aden-dev.asia
${FMS_API_V1}     api-fms.aden-dev.asia
${FMS_API_USERNAME}    warehousepassword
${FMS_API_PASSWORD}    warehousepassword
${PRODUCT-REBUILD-STOCK}    product/rebuild-stock
${PRODUCT-REBUILD-STOCK-NO-VARIANT}    product/rebuild-stock-no-variant
${PRODUCT-REBUILD-STOCK-MOBILE}    products/rebuild-mobile-stocks
${default_inventoryID}    INAAC1112611
${default_inventoryID_tm}    URAAA1112711
#${default_inventoryID_cod}    URAAA1115411
${default_inventoryID_cod}    CHAAA1111511
${default_inventoryID_cs}    LOAAB1111111

${default_inventoryID_retail}    WDAAA1114411
${default_inventoryID_market_place}    LAAAD1111211

# staging freebie campaign_id=9059
${default_inventoryID_A_with_freebie}        MIAAA1112111
${default_inventoryID_C_with_freebie}        MIAAA1113211
${default_inventoryID_B_freebie_for_inv_A}   MIAAA1111811
${default_inventoryID_D_freebie_for_inv_C}   MIAAA1113111

${inventoryID_inst_fail}       GOAAC1111411
${CAMP-HOST-API}    campaign-api.wemall-dev.com:8080
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
${CAMP-DELETE-CAMPAIGN-URI}    /api/v1/itm/campaigns
${CAMP-CREATE-CAMPAIGN-URI}    /api/v1/itm/campaigns
${CAMP-CREATE-PROMOTION-URI}    /api/v1/itm/promotions
${CAMP-BUILD-URI}    /api/v1/itm/promotions/build
############################
#########         CAMPS    ##########
############################
######### Common #########
${CAMPS-BROWSER}    Chrome
${CAMPS-SELENIUM-SPEED}    0.2
########## Host ##########
${CAMPS-HOST}     http://campaign-cms.itruemart-dev.com    #Staging
${CAMPS-API}      apis-gateway.wemall-dev.com    #Staging
${LOGIN-PAGE}     http://merchant.itruemart-dev.com/    #Staging
${MERCHANT-API}    apis-gateway.wemall-dev.com    #Staging
####### User Password #######
${USER-CAMPS}     test
${PASSWORD-CAMPS}    password
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
${CAMP_USERNAME}    test
${CAMP_PASSWORD}    password
${ITM_USERNAME}    starkautomate@gmail.com
${ITM_PASSWORD}    true1234!
${Path-excel_file}    C:\\git\\ITrueMart-Wemall\\Resource\\TestData
${WEMALL_URL}     http://www.wemall-dev.com
${WEMALL_API}     www.wemall-dev.com
${WEMALL_URL_SSL}    https://www.wemall-dev.com
${WEMALL_MOBILE}    http://m.wemall-dev.com
${WEMALL_MOBILE_URL}    http://m.wemall-dev.com
${WEMALL_MOBILE_URL_SSL}    https://m.wemall-dev.com
${WEMALL_ITM}     http://www.wemall-dev.com/itruemart
${BOOKING_URL}    http://booking.wemall-dev.com
${BOOKING_LEVEL_DOMAIN}     booking.wemall-dev.com
${BOOKING_IMAGE_PRODUCT_URL}    assets/layouts/iphone-se/products
#### Merchant LV.C Category #####
${cat_slug_pkey}    mobiles-32174784433147
${SHOP_LYRA_ROBOT}    lyra-test
${merchant_slug}       lyra-test
${cat_pkey_lyra}      32174784433147
${product_pkey_p_01}     2544974044658
${product_pkey_outofstock}     2624118541212
${xpath_product_no_1}     //*[@id="wrapper_content"]/div/div[4]/div[3]/div[1]/div/a/span[2]/span[2]

${MNP_IMAGE_PATH}       ${CURDIR}/../../../Resource/TestData/Mnp/images/image_profile.jpg

${default_inventoryID_cs_retail}    LOAAB1111111
${default_inventoryID_cs_market_place}    xxxxxx
${default_inventoryID_retail}    LOAAB1111111
#### PDS ####
${PDS_URL_API}    pds-api.wemall-dev.com
${PDS-API-URI}    /pds-api

#### Dynamoc Table Name #####
${STOREFRONT_SHOP_TABLE}    wms-s-dym-css-shops
${STOREFRONT_STOREFRONT_WEB_DRAFT_TABLE}         wms-s-dym-css-storefronts-web-draft
${STOREFRONT_STOREFRONT_WEB_PUBLISH_TABLE}       wms-s-dym-css-storefronts-mobile-draft
${STOREFRONT_STOREFRONT_MOBILE_DRAFT_TABLE}      wms-s-dym-css-storefronts-web
${STOREFRONT_STOREFRONT_MOBILE_PUBLISH_TABLE}    wms-s-dym-css-storefronts-mobile

${ADMIN_WEMALL}                 http://admin.itruemart-dev.com/

### MERCHANT_CENTER_URL ###
${MERCHANT_CENTER_URL}        http://merchant.itruemart-dev.com
${MERCHANT_REPORT_URL}        http://merchant-report.itruemart-dev.com
${MERCHANT_CENTER_URL_API}    http://web-api.wemall-dev.com

### POINT SERVICE ###
${POINT_URL}    http://point-cms.itruemart-dev.com

### API GATEWAY SUPERNUMBER ###
${SUPERNUMBER_API_GATEWAY}     api.itruemart-dev.com
${SP_API_KEY}    z9xvuMPGFT4isNx8cDBcx3s7MsVuqgMv2WucZYBJ

### PROMOTION_CODE_DISPLAY
${category_url}                       lyras16category-3783731534500
${brand_url}                          brandlyras16-6869141742901
${wow_url}                            /everyday-wow-kate-wow
${search_url}                         /search2
${sorting_lv_c_category}              //*[@id='wrapper_content']/div/div[6]/div[1]/div/div[2]/div/div/select
${sorting_lv_c_brand}                 //*[@id='wrapper_content']/div[3]/div[1]/div/div[2]/div/div/select
#Product_Pkey
${pkey_sp16_01}                       2688933828936
${pkey_sp16_02}                       2988344469937
${pkey_sp16_03}                       2428393550385
${pkey_sp16_04}                       2151863997795
${pkey_sp16_05}                       2643543370475
${pkey_sp16_06}                       2139598831644
${pkey_sp16_07}                       2507514256382
${pkey_sp16_08}                       2639019184797
${pkey_sp16_09}                       2976056943976
${pkey_sp16_10}                       2302593259471
${pkey_sp16_12}                       2295261420979
#Product_Slug
${slug_sp16_01}                       lyrafixs16pm10001
${slug_sp16_02}                       lyrafixs16pm10002
${slug_sp16_03}                       lyrafixs16pm10003
${slug_sp16_04}                       lyrafixs16pm10004
${slug_sp16_05}                       lyrafixs16pm10005
${slug_sp16_06}                       lyrafixs16pm10006
${slug_sp16_07}                       lyrafixs16pm10007
${slug_sp16_08}                       lyrafixs16pm10008
${slug_sp16_09}                       lyrafixs16pm10009
${slug_sp16_10}                       lyrafixs16pm10010
${slug_sp16_12}                       lyrafixs16pm10012
${pkey_sp16_p02_v1}              21878453390888
#Option_Pkey
${pkey_sp16_p04_v1_op1}          21577853854309
${pkey_sp16_p04_v1_op2}          21322879042547
${pkey_sp16_p04_v2_op1}          21609892077930
${pkey_sp16_p04_v2_op2}          21784793599594
${pkey_sp16_p04_v3_op1}          21102123774974
${pkey_sp16_p04_v3_op2}          21892166438292
${pkey_sp16_p04_v4_op1}          21663838921217
${pkey_sp16_p04_v4_op2}          21811243817898
${pkey_sp16_p05_v1_op1}          21981005157569
${pkey_sp16_p05_v2_op1}          21609892077930
${pkey_sp16_p05_v3_op1}          21107971982928
${pkey_sp16_p06_v1_op1}          21326918537866
${pkey_sp16_p06_v2_op1}          21577853854309
${pkey_sp16_p06_v3_op1}          21609892077930
${pkey_sp16_p07_v1_op1}          21811243817898
${pkey_sp16_p07_v2_op1}          21784793599594
${pkey_sp16_p07_v3_op1}          21125772988850
${pkey_sp16_p07_v4_op1}          21322879042547
${pkey_sp16_p08_v1_op1}          21322879042547
${pkey_sp16_p08_v2_op1}          21784793599594
${pkey_sp16_p08_v3_op1}          21892166438292
${pkey_sp16_p08_v4_op1}          21811243817898
${pkey_sp16_p09_v1_op1}          21322879042547
${pkey_sp16_p09_v2_op1}          21784793599594
${pkey_sp16_p09_v3_op1}          21892166438292
${pkey_sp16_p09_v4_op1}          21811243817898
${pkey_sp16_p10_v1_op1}          21322879042547
${pkey_sp16_p10_v2_op1}          21784793599594
${pkey_sp16_p10_v3_op1}          21892166438292
${pkey_sp16_p10_v4_op1}          21811243817898
${pkey_sp16_p10_v5_op1}          21514346438213

### SELF-SERVICE ###
${SELF_SERVICE_URL}             http://selfservice.wemall-dev.com
${SELF_SERVICE_URL_HTTP}        selfservice.wemall-dev.com
${SELF_SERVICE_URL_MOBILE}      http://selfservice.wemall-dev.com/mobile/main

### LIVEAGENT ###
${LIVE_AGENT_URL}                   https://wemall.ladesk.com
${LIVE_AGENT_URL_API}               wemall.ladesk.com
${LIVE_AGENT_API_CONVERSATIONS}     /api/conversations