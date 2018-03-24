*** Variables ***
######### Common #########
${CAMPS-BROWSER}    Chrome
${CAMPS-SELENIUM-SPEED}    0.2

########## Host ##########
# ${CAMPS-HOST}    https://alpha-campaign-cms.itruemart-dev.com    #Alpha
# ${CAMPS-API}    alpha-apis-gateway.wemall-dev.com    #Alpha
# ${LOGIN-PAGE}    https://alpha-merchant.itruemart-dev.com/signin.html    #Alpha
# ${MERCHANT-API}    alpha-apis-gateway.wemall-dev.com    #Alpha

${CAMPS-HOST}    https://campaign-cms.itruemart-dev.com    #Staging
${CAMPS-API}     apis-gateway.wemall-dev.com       #Staging
${LOGIN-PAGE}    https://merchant.itruemart-dev.com/   #Staging
${MERCHANT-API}    apis-gateway.wemall-dev.com    #Staging

####### User Password #######
# ${USER-CAMPS}    stark
# ${PASSWORD-CAMPS}    starkpassword
${USER-CAMPS}    test
${PASSWORD-CAMPS}    password

########## Env Path ##########
${RESOURCE-PATH}    ${CURDIR}/../../../Resource
# ${RESOURCE-PATH}    C:\\Git\\itruemart-wemall\\Resource
${RESOURCE-IMAGE-PATH}    ${RESOURCE-PATH}/PIC


########## DB ############
${DB_HOSTNAME}    alpha-pcmsdb-ro.itruemart-dev.com
${DB_USERNAME}    stark_user
${DB_PASSWORD}    true1234
${DB_NAME}        pcms_db
${DB_CHARSET}     utf8
${DB_PORT}        3306

###########################
########### PCMS ###########
###########################
${g_loading_delay}    40
${g_loading_delay_short}    5
${g_promo_id}        ${EMPTY}
${g_code_group_id}         ${EMPTY}
${g_camp_id}    ${EMPTY}
${g_email_group_id}    ${EMPTY}
${g_camp_name}    ${EMPTY}
${g_flash_sale_id}    ${EMPTY}

####### Global Variable ######

# ${PCMS_PORT}          81
# .. Sandbox
# ${PCMS_URL}            http://stark-pcms.itruemart-dev.com:${PCMS_PORT}
# ${PCMS_URL_HTTP}       http://stark-pcms.itruemart-dev.com
# ${PCMS_URL_HTTP}       http://stark-pcms.itruemart-dev.com
# ${PCMS_API_URL}    stark-pcms.itruemart-dev.com:${PCMS_PORT}

${PCMS_URL}           http://alpha-pcms.itruemart-dev.com    #Alpha
${PCMS_URL_HTTP}      http://alpha-pcms.itruemart-dev.com    #Alpha
${PCMS_URL_HTTP}      http://alpha-pcms.itruemart-dev.com    #Alpha
${PCMS_API_URL}    alpha-pcms.itruemart-dev.com    #Alpha

# ${PCMS_URL}            http://pcms.itruemart-dev.com    #Staging
# ${PCMS_URL_HTTP}       http://pcms.itruemart-dev.com    #Staging
# ${PCMS_URL_HTTP}       http://pcms.itruemart-dev.com    #Staging
# ${PCMS_API_URL}    pcms.itruemart-dev.com    #Staging

${PCMS_USERNAME}    admin@domain.com
${PCMS_PASSWORD}    12345

${FMS_API}        api2-fms-alpha.aden-dev.com    #Alpha
# ${FMS_API}        api2-fms.aden-dev.com    #Staging
${FMS_API_USERNAME}    warehousepassword
${FMS_API_PASSWORD}    warehousepassword

# ${ITM_URL}            http://stark-www.itruemart-dev.com    #Sandbox
${ITM_URL}            http://alpha-www.itruemart-dev.com    #Alpha
# ${ITM_URL}            http://www.itruemart-dev.com    #Staging
${ITM_USERNAME}    starkautomate@gmail.com
${ITM_PASSWORD}    true1234!


${DISCOUNT_CODE}    STARKZ    #Alpha
@{products}    2838243483444    2774291547777    2451584365992    #Alpha

# ${DISCOUNT_CODE}    STARKM    #Staging
# @{products}    2979665620312    2431244352715    2968751175312    #Staging

####operation####
${sku_creates}         /api/key/v1/sku/creates
${supplier_creates}    /api/key/v1/supplier

@{VALID-VARIANT-FOR-FREEBIE}      ACAAA1112411    ACAAA1113511
