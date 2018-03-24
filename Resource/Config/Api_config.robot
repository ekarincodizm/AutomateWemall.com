*** Settings ****
Resource    ${CURDIR}/${ENV}/Endpoints.robot

*** Variables ***
${PCMS_API_URL}  ${PCMS_URL}${PCMS_PKEY}
${API_PRODUCT_URL}    ${PCMS_URL}${PCMS_PKEY}/products/
${API_BRAND_URL}    ${PCMS_URL}${PCMS_PKEY}/brands
${API_SHOP_URL}    ${PCMS_URL}/v4/shop
