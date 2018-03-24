*** Variables ***
${PDS_URL}        http://products-cms.itruemart-dev.com
${Wemall_URL}     http://www.wemall-dev.com
${Campaign_URL}    http://52.74.31.162/wm
${FMS_URL}        http://api-fms-alpha.aden-dev.com
${Path-ImgFile}    C:\\git\\ITrueMart-Wemall\\Resource\\PIC
${PDS_API_URL}    http://products-api.wemall-dev.com:8080
${FMS}            http://alpha-products-api.wemall-dev.com
${Merchant_API_URL}    http://alpha-apis-gateway.wemall-dev.com
${AAD_API}        http://alpha-apis-gateway.wemall-dev.com
${AAD_PORTAL}     http://admin.itruemart-dev.com
${MC_URL}         http://merchant.itruemart-dev.com
${Shop_in_Shop_Page}    http://www.wemall-dev.com/shop
${Storefront_Menu}    http://storefront-cms.wemall-dev.com/#/storefrontManagement/    # /Web or /Mobile
${AAD_database}    staging-aad-db.wemall-dev.com
${AAD_database_Authz}    authz-db.wemall-dev.com
${CAMP_URL}       http://campaign-cms.itruemart-dev.com
${API_GATEWAY}    http://alpha-apis-gateway.wemall-dev.com

${ITM_URL}      http://thor-www.itruemart-dev.com
${ITM_MOBILE_URL}   http://thor-m.itruemart-dev.com
${PCMS_URL}    http://thor-pcms.itruemart-dev.com:81
${PCMS_URL_SSL}    https://thor-pcms.itruemart-dev.com:81
${PCMS_PORT}    80
${PCMS_PKEY}    /api/45311375168544
${PCMS_APP_KEY}    45311375168544

${PCMS_URL_API}    thor-pcms.itruemart-dev.com:81
${BROWSER}    Google Chrome


${API_GATEWAY_HOST}    alpha-apis-gateway.wemall-dev.com
${GENERAL_API_HOST}    ${API_GATEWAY_HOST}
${HTTP_PROTOCAL}    http
${GENERAL_API}    ${HTTP_PROTOCAL}://${API_GATEWAY_HOST}/gen/v1/
${CDN_SERVER}     //cdn.wemall-dev.com/

### POINT SERVICE ###
${POINT_URL}    http://sandbox-point-cms.itruemart-dev.com

######### Operation #########
${UPLOADS}        /gen/v1/uploads/
${GEOLOCATIONS}    /gen/v1/geolocations/
${PCMS_API_URL}    thor-pcms.itruemart-dev.com
${PCMS_USERNAME}    admin@domain.com
${PCMS_PASSWORD}    12345

${RESOURCE-PATH}    ${CURDIR}/../../../Resource
# ${RESOURCE-PATH}    C:\\Git\\itruemart-wemall\\Resource
${RESOURCE-IMAGE-PATH}    ${RESOURCE-PATH}/PIC
${DOWNLOAD-PATH}    %{USERPROFILE}/Downloads

${CAMP-PROTOCOL}    http
${CAMP-SSL-PROTOCOL}    https
${CAMP-PORT}      8080
${CAMP-TOP-LEVEL-DOMAIN}       alpha-campaign-api.wemall-dev.com:${CAMP-PORT}
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
${CAMP-V1-GET-FREEBIE-URI}           /api/v1/itm/promotions/freebie/
${FREEBIE-CAMPAIGN-ID}        5709
${FREEBIE-COLLECTION-ID}    339
${BUNDLE-CAMPAIGN-ID}    6814
${AAD-LOGIN-URI}    /authen
${AAD-USERNAME}    test
${AAD-PASSWORD}    password
${AAD-HOST-API}    alpha-apis-gateway.wemall-dev.com
${AAD-HEADER}     application/x-www-form-urlencoded
${AAD-LOGIN-URL}    http://alpha-apis-gateway.wemall-dev.com/authen
${AAD-GET-ACCESS-TOKEN-URL}    http://alpha-apis-gateway.wemall-dev.com/authen/v1/tokens
${add-cart}       /api/v2/45311375168544/cart/add-item
${update-cart}    /api/v2/45311375168544/cart/add-item
${delete-cart}    /api/v2/45311375168544/cart/remove-item
${get-cart}       /api/v2/45311375168544/cart
${create-order}    /api/45311375168544/order/create
${showroom}       /api/45311375168544/showroom
${ORDER-TRACKING}                 /api/45311375168544/order-tracking/receive-status
${truemoveh-registerinfo-save}    /api/45311375168544/truemoveh/registerinfo/save
${truemoveh-all-mobile-b3}    /truemove-h/api/all-mobile-b3
${truemoveh-all-mobile}    /truemove-h/api/all-mobile
${FMS}            http://alpha-products-api.wemall-dev.com
${FMS_API}        api2-fms-alpha.aden-dev.com
# ${FMS_API_V1}            api-fms-alpha.aden-dev.com
${FMS_API_V1}            alp-api-fms.aden-dev.asia
${FMS_API_USERNAME}    warehousepassword
${FMS_API_PASSWORD}    warehousepassword
${inventory_id}     LOAAB1111111
${default_inventoryID}          INAAC1112611
${default_inventoryID_cod}      INAAC1112611
${default_inventoryID_cs}       LOAAB1111111
${inventoryID_inst_fail}       GOAAC1111411
#เมาส์พร้อมคีย์บอร์ด Logitech Wireless mouse MK240 (Black)
${FREEBIE-COLLECTION-ID}    339
${PRODUCT-REBUILD-STOCK}                product/rebuild-stock
${PRODUCT-REBUILD-STOCK-NO-VARIANT}     product/rebuild-stock-no-variant
${PRODUCT-REBUILD-STOCK-MOBILE}         products/rebuild-mobile-stocks@{PRODUCT-MATCH-FREEBIE}    2838243483444    2774291547777    2451584365992
@{PRODUCT-MATCH-FREEBIE}    2838243483444    2774291547777    2451584365992

${PROTOCOL}        http
### test data ###
${ITM_USERNAME}    starkautomate@gmail.com
${ITM_PASSWORD}    true1234!

### BOOKING ###
${BOOKING_URL}    http://thor-booking.itruemart-dev.com:82
${BOOKING_LEVEL_DOMAIN}    thor-booking.itruemart-dev.com:82