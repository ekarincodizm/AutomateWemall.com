*** Settings ***
Force Tags        WLS_API_PCMS
Resource    ${CURDIR}/../../../Resource/init.robot
Resource    ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource    ${CURDIR}/../../../Keyword/API/PCMS/Product/keywords_product.robot
Resource    ${CURDIR}/../../../Keyword/API/PCMS/Shop/keywords_policy.robot
Resource    ${CURDIR}/../../../Keyword/API/PCMS/Shop/keywords_shop.robot

Library     ${CURDIR}/../../../Python_Library/truemoveh_library.py
Library     Selenium2Library
Library     HttpLibrary.HTTP
Library     Collections
Library     OperatingSystem
Library     String



*** Test Cases ***
TC_iTM_02203 API product returns global policy if merchant has no its own policy.
    [Tags]    TC_iTM_02203  ready   regression    WLS_High


    Given Merchant Data For Test
    AND Delete Merchant Policy By Merchant ID  ${merchant_id}


    AND Prepare Global Merchant Data
    #log to console   global_merchant_id=${global_merchant_id}

    When Api Return Data  ${global_merchant_id}

    Then Api Return Expected Merchant
    And Api Return Expected Policy



    [Teardown]  Insert Merchant Policy  ${backup_policy}


TC_iTM_02204 API product return merchant detail and policies of merchant if merchant has own policies
    [Tags]    TC_iTM_02204  ready   regression    WLS_High
    ${delivery_min}=    Set Variable  3
    ${delivery_max}=    Set Variable  5

    Given Merchant Data TH Only For Test

    When Merchant Delivery Min Is  ${delivery_min}
    And Merchant Delivery Max Is   ${delivery_max}
    And Api Return Data    ${merchant_id}

    Log to console  merchant_id=${merchant_id}

    Then Api Return Expected Merchant
    And Api Return Expected Delivery Min Is  ${delivery_min}
    And Api Return Expected Delivery Max Is  ${delivery_max}
    And Api Return Expected Policy TH Same EN

    [Teardown]    Run Keywords   Delete Merchant Policy By Merchant ID    ${merchant_id}
    ...    AND    Insert Merchant Policy    ${backup_policy}

TC_iTM_02205 API product return merchant detail and policies of merchant if merchant has own policies TH/EN
    [Tags]    TC_iTM_02205    ready     regression    WLS_Medium

    Given Merchant Data For Test

    When Api Return Data  ${merchant_id}

    Then Api Return Expected Merchant
    And Api Return Expected Policy

    [Teardown]  Rollback Merchant Policy Data

TC_iTM_02205 Set merchant delivery min = max
    [Tags]    TC_iTM_02205  ready       regression    WLS_Medium
    ${delivery_min}=            Set Variable  3
    ${delivery_max}=            Set Variable  3
    ${expected_delivery_min}=   Set Variable  3
    ${expected_delivery_max}=   Set Variable  3

    Test Case Merchant Delivery  ${delivery_min}  ${delivery_max}  ${expected_delivery_min}  ${expected_delivery_max}

    [Teardown]  Rollback Merchant Policy Data

TC_iTM_02204 Set merchant delivery min < max
    [Tags]    TC_iTM_02204    ready       regression    WLS_Medium
    ${delivery_min}=            Set Variable  3
    ${delivery_max}=            Set Variable  10
    ${expected_delivery_min}=   Set Variable  3
    ${expected_delivery_max}=   Set Variable  10

    Test Case Merchant Delivery  ${delivery_min}  ${delivery_max}  ${expected_delivery_min}  ${expected_delivery_max}

    [Teardown]  Rollback Merchant Policy Data

TC_iTM_02232 API product return min - max and policies of merchant if merchant has own policies
    [Tags]    TC_iTM_02232  ready   regression    WLS_Medium
    ${delivery_min}=            Set Variable  10
    ${delivery_max}=            Set Variable  3
    ${expected_delivery_min}=   Set Variable  10
    ${expected_delivery_max}=   Set Variable  10

    Test Case Merchant Delivery  ${delivery_min}  ${delivery_max}  ${expected_delivery_min}  ${expected_delivery_max}

    # [Teardown]  Rollback Merchant Policy Data

TC_iTM_02964 API return merchant_code_alias node when assign product A to alias XYZ
    [Tags]    TC_iTM_02964    ITMA-3093   ready     regression    WLS_Medium
    ${alias_name}=    Set Variable    XYZ
    ${merchant_code}=    Set Variable    XYZ_CODE

    Given Prepare Product Merchant Alias    ${alias_name}    ${merchant_code}
    Then Expect Product Alias Merchant    ${merchant_code}

    [Teardown]    Delete Merchant Alias And Product

TC_iTM_02965 API is not return merchant_code_alias node when not assign product A
    [Tags]    TC_iTM_02965    ITMA-3093   ready     regression    WLS_Medium
    ${alias_name}=    Set Variable    XYZ
    ${merchant_code}=    Set Variable    null

    Given Prepare Product Without Alias Merchant
    Then Expect Product Without Alias Merchant    ${merchant_code}
