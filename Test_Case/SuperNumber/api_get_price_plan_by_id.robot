*** Settings ***
Force Tags     WLS_Supernumber     WLS_High
Library     Selenium2Library
Library     HttpLibrary.HTTP
Library     Collections
Library     requests
Library     String

Resource          ${CURDIR}/../../Resource/init.robot
Resource          ${CURDIR}/../../Keyword/Portal/PCMS/TruemoveH/keywords_super_number.robot
Resource          ${CURDIR}/../../Keyword/API/api_super_number/keyword_super_number_common.robot

*** Variable ***
${SP_ENV_PCMS}    Y


*** Test Cases ***
To verify that api get price plan by id return error response if send api without price plan id
    [Tags]    TC_ITMWM_07599    ready

    ${url_path}=    Set Variable    /api/v2/4904898372939/truemoveh/promotion/price-plan-by-id?id=${EMPTY}

    ${result}=    SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_200}

    SuperNumber - Verify Response Get Price Plan    ${result}    "id is required"    false

To verify that api get price plan by id return correct header code and does not return data node if send api with invalid price plan id
    [Tags]    TC_ITMWM_07600    ready

    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot

    ${price_plan_id_wrong}=    Set Variable    ABCD

    ${price_plan_id}=    Prepare Price Plan    ${unique_id}

    ${url_path}=    Set Variable    /api/v2/4904898372939/truemoveh/promotion/price-plan-by-id?id=${price_plan_id_wrong}

    ${result}=    SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_200}

    SuperNumber - Verify Response Get Price Plan    ${result}    "200 OK"    false

    [Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_id}

To verify that api get price plan by id return correct header code and does not return data node if send api with price plan id that not exist in system
    [Tags]    TC_ITMWM_07601    ready

    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot

    ${price_plan_id_wrong}=    Set Variable    999999999999999999

    ${price_plan_id}=    Prepare Price Plan    ${unique_id}

    ${url_path}=    Set Variable    /api/v2/4904898372939/truemoveh/promotion/price-plan-by-id?id=${price_plan_id_wrong}

    ${result}=    SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_200}

    SuperNumber - Verify Response Get Price Plan    ${result}    "200 OK"    false

    [Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_id}

To verify that api get price plan by id return correct data and header code if send api with valid price plan id
    [Tags]    TC_ITMWM_07602    ready

    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot

    ${price_plan_id}=    Prepare Price Plan    ${unique_id}

    ${url_path}=    Set Variable    /api/v2/4904898372939/truemoveh/promotion/price-plan-by-id?id=${price_plan_id}

    ${result}=    SuperNumber - Send Http Get Request    ${url_path}    ${RESULT_HEADER_200}

    SuperNumber - Verify Response Get Price Plan    ${result}    "${unique_id}"

    [Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_id}