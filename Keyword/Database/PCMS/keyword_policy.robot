*** Settings ***
Library           DatabaseLibrary
Library           String
Resource          ${CURDIR}../../../../Resource/Config/${ENV}/env_config.robot
Resource          ${CURDIR}../../../../Resource/Config/${ENV}/database.robot
Resource          ../../Common/Keywords_Common.robot

*** Keywords ***
Get Policy Data from DB by Shop ID
    [Arguments]    ${shop_id}
    Connect DB ITM
    ${delivery_min_day}=    Query    SELECT delivery_min_day FROM `policy_maps` where `ref_id` = '${shop_id}'
    ${delivery_max_day}=    Query    SELECT delivery_max_day FROM `policy_maps` where `ref_id` = '${shop_id}'
	Return From Keyword    ${delivery_min_day[0][0]}    ${delivery_max_day[0][0]}
