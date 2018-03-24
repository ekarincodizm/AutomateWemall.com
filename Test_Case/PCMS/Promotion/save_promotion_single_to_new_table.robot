*** Settings ***
Force Tags    WLS_Promotion
Library           HttpLibrary.HTTP
Library           Selenium2Library
Library           Collections
Library           String
Library           BuiltIn
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Promotion/keywords_prepare_promotion_code.robot

Suite Setup  Promotion - Create Campaign  ${campaign_name}   No
Suite Teardown      Run Keywords   promotion.Remove Campaign   ${campaign_name}   1
 ...    AND   Close All Browsers

*** Variables ***
${xpath-promotion-save-button}            //*[@id="btn-save"]
${campaign_name}  ANTMAN ROBOT CAMPAIGN

&{TC1}     name=TC1
    ...    promo_group=General
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=collection    # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=มือถือ และ แท็บเล็ต
    ...    dc_on_exclude_value=2261535516166
    ...    budget=PC1
    ...    card=${EMPTY}

&{TC2}     name=TC2
    ...    promo_group=General
    ...    type=multiple_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=collection    # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=มือถือ และ แท็บเล็ต
    ...    dc_on_exclude_value=2261535516166
    ...    budget=PC1
    ...    card=${EMPTY}

&{TC3}     name=TC3
    ...    promo_group=General
    ...    type=vip_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=collection    # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=มือถือ และ แท็บเล็ต
    ...    dc_on_exclude_value=2261535516166
    ...    budget=PC1
    ...    card=${EMPTY}

&{TC4}     name=TC4
    ...    promo_group=General
    ...    type=single_code    #  single_code / vip_code / multiple_code
    ...    usetime=10
    ...    userlimit=limited    #  limited / unlimited
    ...    time_per_user=1
    ...    minimum=0
    ...    dc_type=percent    #  price / percent
    ...    dc_value=10
    ...    dc_maximum=20
    ...    dc_cart=following    #  cart / following
    ...    dc_on_follow_type=collection    # variant / product / brand / collection / bundle
    ...    dc_on_follow_value=มือถือ และ แท็บเล็ต
    ...    dc_on_exclude_value=2261535516166
    ...    budget=PC1
    ...    card=${EMPTY}

*** Keywords ***
Get Promotion ID
    [Arguments]          ${campaign_name}        ${promotion_name}
    Connect DB ITM
    ${result}=           Query          SELECT `promotions`.`id` FROM `promotions` JOIN `campaigns` ON `campaigns`.`id` = `promotions`.`campaign_id` where `promotions`.`name` = '${promotion_name}' AND `campaigns`.`name` = '${campaign_name}' AND `campaigns`.`deleted_at` is NULL ORDER BY `promotions`.`created_at` DESC LIMIT 1
    Log To Console    ${result}
    [Return]        ${result[0][0]}

Count promotion_single_condition_effects
     [Arguments]         ${promotion_id}
     Connect DB ITM
     ${result}=     Query     SELECT COUNT(*) FROM `promotion_single_condition_effects` WHERE `promotion_id` = '${promotion_id}'
     Log To Console    ${result}
     [Return]       ${result[0][0]}

Count promotion_single_condition_excludes
     [Arguments]         ${promotion_id}
     Connect DB ITM
     ${result}=     Query     SELECT COUNT(*) FROM `promotion_single_condition_excludes` WHERE `promotion_id` = '${promotion_id}'
     Log To Console    ${result}
     [Return]       ${result[0][0]}

*** Test Cases ***
TC_ITMWM_05217 To verify that data of cart with condition is saved to new table if user create promotion code type as single
    [Tags]          Cha        TC_ITMWM_05217       Regression      Ready    WLS_High
    Login PCMS
    Go To Robot Campaign    ${campaign_name}
    #${promotion_id}=         Get Promotion ID    ${campaign_name}         ${TC1.name}
    ${coupon_code}=   Create Promotion   &{TC1}
    ${promotion_id}=         Get Promotion ID    ${campaign_name}         ${TC1.name}

    #Should Not Be Empty     ${promotion_id}
    ${effect}=      Count promotion_single_condition_effects          ${promotion_id}
    Should Be True         ${effect} > 0
    ${excludes}=    Count promotion_single_condition_excludes         ${promotion_id}
    Should Be True         ${excludes} > 0

TC_ITMWM_05218 To verify that data of cart with condition is not saved to new table if user create promotion code type as unique
    [Tags]    Cha    TC_ITMWM_05218       Regression      Ready    WLS_Medium
    Login PCMS
    Go To Robot Campaign    ${campaign_name}
    #${promotion_id}=         Get Promotion ID    ${campaign_name}         ${TC1.name}
    ${coupon_code}=   Create Promotion   &{TC2}
    ${promotion_id}=         Get Promotion ID    ${campaign_name}         ${TC2.name}

    #Should Not Be Empty     ${promotion_id}
    ${effect}=      Count promotion_single_condition_effects          ${promotion_id}
    Should Be Equal As Strings         "${effect}"    "0"
    ${excludes}=    Count promotion_single_condition_excludes         ${promotion_id}
    Should Be Equal As Strings         "${excludes}"    "0"


TC_ITMWM_05219 To verify that data of cart with condition is not saved to new table if user create promotion code type as VIP
    [Tags]    Cha    TC_ITMWM_05219       Regression      Ready    WLS_Medium
    Login PCMS
    Go To Robot Campaign    ${campaign_name}
    ${coupon_code}=   Create Promotion   &{TC3}
    ${promotion_id}=         Get Promotion ID    ${campaign_name}         ${TC3.name}

    #Should Not Be Empty     ${promotion_id}
    ${effect}=      Count promotion_single_condition_effects          ${promotion_id}
    Should Be Equal As Strings         "${effect}"    "0"
    ${excludes}=    Count promotion_single_condition_excludes         ${promotion_id}
    Should Be Equal As Strings         "${excludes}"    "0"

TC_ITMWM_05220 To verify that data of cart with condition is not saved to new table if user update promotion code type as single
    [Tags]    Cha    TC_ITMWM_05220       Regression      Ready    WLS_High
    Login PCMS
    Go To Robot Campaign    ${campaign_name}
    ${coupon_code}=   Create Promotion   &{TC4}
    ${promotion_id}=         Get Promotion ID    ${campaign_name}         ${TC4.name}
    ${effect1}=      Count promotion_single_condition_effects          ${promotion_id}
    Should Be True         ${effect1} > 0
    ${excludes1}=    Count promotion_single_condition_excludes         ${promotion_id}
    Should Be True         ${excludes1} > 0

    Go to                 ${PCMS_URL}/promotions/edit/${promotion_id}?campaign=true
    Wait Until Page Contains Element    ${xpath-promotion-save-button}    60s
    Click Element           ${xpath-promotion-save-button}
    ${effect2}=      Count promotion_single_condition_effects          ${promotion_id}
    Should Be True         ${effect1} > 0
    ${excludes2}=    Count promotion_single_condition_excludes         ${promotion_id}
    Should Be True         ${excludes1} > 0
    Should Be Equal As Integers    ${excludes1}    ${excludes2}
    Should Be Equal As Integers    ${effect1}    ${effect2}
