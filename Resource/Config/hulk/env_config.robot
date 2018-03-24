*** Variables ***
######### Host #########
${GENERAL-API-HOST}         sandbox-general-api.wemall-dev.com
${GENERAL-API-PROTOCAL}     http
${GENERAL-API}              ${GENERAL-API-PROTOCAL}://${GENERAL-API-HOST}/v1/
${PORTAL_API}                   sandbox-portal-api.wemall-dev.com
${STOREFRONT-API}               http://sandbox-storefront-api.wemall-dev.com/${CSS_STOREFRONT}
${STOREFRONT-API-httpLib}       sandbox-storefront-api.wemall-dev.com
${STOREFRONT_CMS}           http://sandbox-storefront-cms.wemall-dev.com
${AAD_API}                  sandbox-authen.wemall-dev.com
${AAD_API_HOST}             sandbox-authen.wemall-dev.com
${CDN-SERVER}               //sandbox-cdn.wemall-dev.com/
${ITM_URL}                  http://hulk-www.wemall-dev.com
${ITM_MOBILE_URL}           http://hulk-m.wemall-dev.com
${WEMALL_URL}               http://hulk-www.wemall-dev.com
${WEMALL_MOBILE_URL}        http://hulk-www.wemall-dev.com
# ${ITM_SUPPORT_URL}          http://support-dev.itruemart.com/
${PCMS_URL}                 http://hulk-pcms.itruemart-dev.com:81
${PCMS_URL_HTTP}            hulk-pcms.itruemart-dev.com:81
${PCMS_URL_API}             hulk-pcms.itruemart-dev.com:81
${PORTAL-HOST}              http://sandbox-portal-cms.wemall-dev.com
${PORTAL_API}               sandbox-portal-api.wemall-dev.com
${WEMALL_WEB}               http://hulk-www.wemall-dev.com
${WEMALL_MOBILE}            http://hulk-m.wemall-dev.com
${WEMALL_RESOURCE}          http://hulk-resource.wemall-dev.com
${GENERAL-API-HOST}         sandbox-general-api.wemall-dev.com
${GENERAL-API-PROTOCAL}     http
${GENERAL_API}              ${GENERAL-API-PROTOCAL}://${GENERAL-API-HOST}/v1/
${PDS_URL_API}              alpha-pds-api.wemall-dev.com

${CAMP-PROTOCOL}    http
${CAMP-SSL-PROTOCOL}    https
${CAMP-PORT}      8080
${CAMP-TOP-LEVEL-DOMAIN}    alpha-campaign-api.wemall-dev.com:${CAMP-PORT}
${CAMP-HOST}      ${CAMP-PROTOCOL}://${CAMP-TOP-LEVEL-DOMAIN}
${CAMP-SSL-HOST}    ${CAMP-SSL-PROTOCOL}://${CAMP-TOP-LEVEL-DOMAIN}
${CAMP-API-PROMOTION-URI}    /api/v1/itm/promotions
${CAMP-API-PROMOTION-URL}    ${CAMP-HOST}${/}${CAMP-API-PROMOTION-URI}
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
${PRODUCT-REBUILD-STOCK}    product/rebuild-stock
${PRODUCT-REBUILD-STOCK-NO-VARIANT}    product/rebuild-stock-no-variant
${PRODUCT-REBUILD-STOCK-MOBILE}    products/rebuild-mobile-stocks


${AAD-LOGIN-URI}    /authen
${AAD-USERNAME}    test
${AAD-PASSWORD}    password
${AAD-HOST-API}   alpha-apis-gateway.wemall-dev.com
${AAD-HEADER}         application/x-www-form-urlencoded
${AAD-LOGIN-URL}    http://alpha-apis-gateway.wemall-dev.com/authen
${AAD-GET-ACCESS-TOKEN-URL}  http://alpha-apis-gateway.wemall-dev.com/authen/v1/tokens

######### Operation #########
${UPLOADS}          /v1/uploads/
${GEOLOCATIONS}     /v1/geolocations/
${PCMS_API_URL}     hulk-pcms.itruemart-dev.com:81
${PCMS_USERNAME}    admin@domain.com
${PCMS_PASSWORD}    12345
${PCMS_URL}    http://hulk-pcms.itruemart-dev.com:81
${PCMS_URL_API}    hulk-pcms.itruemart-dev.com
${PCMS_URL_SSL}    https://hulk-pcms.itruemart-dev.com
${PCMS_PKEY}    /api/45311375168544
${PCMS_PORT}    81
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

${CAMP_USERNAME}    test
${CAMP_PASSWORD}    password

${default_inventoryID}    INAAC1112611
${default_inventoryID_cod}    INAAC1112611
${default_inventoryID_cs}    LOAAB1111111

#### Dynamoc Table Name #####
${STOREFRONT_SHOP_TABLE}    wms-d-dym-css-shops
${STOREFRONT_STOREFRONT_WEB_DRAFT_TABLE}         wms-d-dym-css-storefronts-web-draft
${STOREFRONT_STOREFRONT_WEB_PUBLISH_TABLE}       wms-d-dym-css-storefronts-mobile-draft
${STOREFRONT_STOREFRONT_MOBILE_DRAFT_TABLE}      wms-d-dym-css-storefronts-web
${STOREFRONT_STOREFRONT_MOBILE_PUBLISH_TABLE}    wms-d-dym-css-storefronts-mobile