*** Settings ***
Library     Selenium2Library
Library     HttpLibrary.HTTP
Library     Collections
Library     OperatingSystem

Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Cart/keywords_cart.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Truemove_h/keywords_truemove_h.robot

*** Test Cases ***
TEST:ann
    [Tags]     test_ann
    TruemoveH - Delete TruemoveH Order Verifys By Mobile Number         0837333396
    TruemoveH - Get Product MNP Sim
    TruemoveH - Get Price Plan MNP Sim
    ${response}=        api_add_mnp_to_cart_v2       ${var_tmh_mnp_sim_inventory_id}       22465193        user        0837333396           3680134424831      ${var_tmh_price_plan_mnp_sim}           mnp
    ${code}=            Get From Dictionary          ${response}         code
    Log To Console          ${code}
    Log To Console          ${response}

