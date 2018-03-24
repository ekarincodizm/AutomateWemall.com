*** Setting ***
Test Teardown     Run Keywords    Run keyword If    "${merchant_ids}" != "${EMPTY}"    Delete Merchant    ${merchant_ids}
...               AND    Run keyword If    "${merchant_alias_ids}" != "${EMPTY}"    Delete Merchant Alias    ${merchant_alias_ids}    # Resource    ${CURDIR}/../../../Resource/Config/${env}/env_config.robot
Force Tags        PDS_Collection_and_Merchant
Library           HttpLibrary.HTTP
Library           Collections
Library           DatabaseLibrary
Library           String
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/Database/PDS/keyword_merchant.robot
Resource          ${CURDIR}/../../../Keyword/API/PDS/pds_api_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PDS/Keywords_PDS_Common.robot

*** Variables ***
${merchant_ids}    ${EMPTY}
${merchant_alias_ids}    ${EMPTY}

*** Test Cases ***
TC_ITMWM_00661 - GET: /merchants - get all merchant and alias - success 200
    [Tags]    Success    API_Mercahnt    TC_ITMWM_00661    ready    phoenix
    ${merchant_alias_id_1}=    Create Merchant Alias in DB    "A-Merchant Alias"    "MA9999-1"    99
    ${merchant_alias_id_2}=    Create Merchant Alias in DB    "B-Merchant Alias"    "MA9999-2"    99
    ${merchant_shop_id}=    Create Merchant in DB    "A-Merchant Shop"    "MS9999"    "R"
    ${merchant_alias_ids}=    Create List    ${merchant_alias_id_1}    ${merchant_alias_id_2}
    ${merchant_ids}=    Create List    ${merchant_shop_id}
    ${response}=    Get All Merchant
    Verify Success Response Status Code and Message
    Verify Response Data From Get All Merchants

TC_ITMWM_00662 - GET: /merchants - get empty merchants - success 200
    [Tags]    success    API_Mercahnt    TC_ITMWM_00662    ready
    # Prerequisite: There is no any merchant alias and merchant(shops) on system
    ${response}=    Get All Merchant
    Verify Success Response Status Code and Message
    Verify Response is Empty Data From Get All Merchants

TC_ITMWM_00663 - GET: /merchants - get merchant only - success 200
    [Tags]    Success    API_Mercahnt    TC_ITMWM_00663    ready    phoenix
    ${merchant_shop_id_1}=    Create Merchant in DB    "A-Merchant Shop"    "MS9999-1"    "R"
    ${merchant_shop_id_2}=    Create Merchant in DB    "C-Merchant Shop"    "MS9999-2"    "M"
    ${merchant_shop_id_3}=    Create Merchant in DB    "B-Merchant Shop"    "MS9999-3"    "R"
    ${merchant_ids}=    Create List    ${merchant_shop_id_1}    ${merchant_shop_id_2}    ${merchant_shop_id_3}
    ${response}=    Get All Merchant
    Verify Success Response Status Code and Message
    Verify Response Data From Get All Merchants

TC_ITMWM_00664 - GET: /merchants - get alias only - success 200
    [Tags]    Success    API_Mercahnt    TC_ITMWM_00664    ready    phoenix
    ${merchant_alias_id_1}=    Create Merchant Alias in DB    "A-Merchant Alias"    "MA9999-1"    99
    ${merchant_alias_id_2}=    Create Merchant Alias in DB    "C-Merchant Alias"    "MA9999-2"    99
    ${merchant_alias_id_3}=    Create Merchant Alias in DB    "B-Merchant Alias"    "MA9999-3"    99
    ${merchant_alias_ids}=    Create List    ${merchant_alias_id_1}    ${merchant_alias_id_2}    ${merchant_alias_id_3}
    ${response} =    Get All Merchant
    Verify Success Response Status Code and Message
    Verify Response Data From Get All Merchants
