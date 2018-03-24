*** Variables ***
${PDS_URL}        http://products-cms.itruemart-dev.com
${Wemall_URL}     http://www.wemall-dev.com
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
#http://apis-gateway.wemall-dev.com/cps/v1/static-contents/portal-footer/draft

######### API #########
${PORTAL_API}                   sandbox-portal-api.wemall-dev.com
${STOREFRONT-API}               http://sandbox-storefront-api.wemall-dev.com/${CSS_STOREFRONT}
${STOREFRONT-API-httpLib}       sandbox-storefront-api.wemall-dev.com
${AAD_API}                      sandbox-authen.wemall-dev.com
${GENERAL_API}                  http://apis-gateway.wemall-dev.com/gen/v1/

### POINT SERVICE ###
${POINT_URL}    http://sandbox-point-cms.itruemart-dev.com
${POINT_API_URL_HTTP}    http://api.point.loc
${POINT_API_URL}    api.point.loc
${POINT_API_URL_AUTHEN}    /v1/authen
${POINT_API_URL_REQUEST_TOKEN}    /v1/request-token
${POINT_API_URL_GET_FORM}    /v1/get-form-verify
${POINT_API_URL_CANCEL_TOKEN}    /v1/cancel-token
${POINT_API_URL_GET_REDEEM}    /v1/redeem

######### WWW #########
${STOREFRONT_CMS}           http://sandbox-storefront-cms.wemall-dev.com
${PORTAL-HOST}              http://sandbox-portal-cms.wemall-dev.com
${WEMALL_WEB}               http://sandbox-www.wemall-dev.com

######### Operation (Direct) #########
${Tokens_API}           /v1/tokens
${CSS_STOREFRONT}       /v3/storefronts/
${CSS_SHOP}             /v3/shops/
${MEGAMENUS}            /v1/mega-menus/
${MERCHANT_ZONES}       /v1/merchant-zones/
${STATIC_CONTENTS}      /v1/static-contents/
${SHOWROOMS}            /v1/showrooms/
${TEMPLATES}            /v1/templates/
${MENUBARS}             /v1/menubars/
${MERCHANT}             /v1/merchants/
${RETAIL}               retail
${SLUG}                 slug/

${ITM_URL}      http://docker-www.itruemart-local.com
${PCMS_URL}    http://pcms.itruemart.loc
${PCMS_URL_HTTP}    www.pcms.loc
${PCMS_URL_SSL}    https://pcms.itruemart.loc
${PCMS_PKEY}    /api/45311375168544
${PCMS_PORT}    80


${PCMS_API_URL}    pcms.itruemart.loc
${PCMS_USERNAME}    devitm@itruemart.com
${PCMS_PASSWORD}    1234567

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

${CAMP-V1-LEVEL-DOMAIN}        alpha-campaign-api.wemall-dev.com:${CAMP-PORT}
${CAMP-V1-HOST}                ${CAMP-PROTOCOL}://${CAMP-V1-LEVEL-DOMAIN}
${CAMP-V1-CREATE-MNP-URI}      /api/v1/itm/promotions
${CAMP-V1-BUILD-MNP-URI}       ${CAMP-V1-CREATE-MNP-URI}/build
${CAMP-V1-CREATE-MNP-URL}      ${CAMP-V1-HOST}/${CAMP-V1-CREATE-MNP-URI}

${CAMP-V1-CREATE-FREEBIE-URI}    /cmp/v1/itm/promotions
${CAMP-V1-BUILD-FREEBIE-URI}       ${CAMP-V1-CREATE-FREEBIE-URI}/build

${CAMP-V1-CREATE-CAMPAIGNS-URI}    /cmp/v1/itm/campaigns

${CAMP-V1-CREATE-PROMOTIONS-URI}    /api/v1/itm/promotions
${CAMP-V1-BUILD-PROMOTIONS-URI}       ${CAMP-V1-CREATE-PROMOTIONS-URI}/build
${CAMP-V1-GET-BUNDLE-URI}           /api/v1/promotions/bundles
${FREEBIE-CAMPAIGN-ID}        2371
${BUNDLE-CAMPAIGN-ID}         2297

${AAD-LOGIN-URI}    /authen
${AAD-USERNAME}    test
${AAD-PASSWORD}    password
${AAD-HOST-API}   alpha-apis-gateway.wemall-dev.com
${AAD-HEADER}         application/x-www-form-urlencoded
${AAD-LOGIN-URL}    http://alpha-apis-gateway.wemall-dev.com/authen
${AAD-GET-ACCESS-TOKEN-URL}  http://alpha-apis-gateway.wemall-dev.com/authen/v1/tokens

${ADMIN_WEMALL}                 http://local-admin.itruemart-dev.com/

### SELF-SERVICE ###
${SELF_SERVICE_URL_MOBILE}    http://selfservice.loc/mobile/main


