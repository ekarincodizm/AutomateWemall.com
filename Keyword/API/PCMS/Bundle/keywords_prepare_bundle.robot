*** Settings ***
Library           HttpLibrary.HTTP
Resource          ${CURDIR}/../../../Common/keywords_itruemart_common.robot
Resource          ${CURDIR}/../../../Database/PCMS/Truemove_h/keywords_truemove_h.robot

Resource          ${CURDIR}/../../../Portal/CAMP/CAMP_Bundle/keywords_bundle.robot

#Resource          ${CURDIR}/../../Resources/Config/${ENV}/api_config.txt

*** Keywords ***
Get TruemoveH Mobile Id
    [Arguments]    ${province_id}=None    ${type_number}=None    ${inventory_id}=None    ${price_plan_id}=None
    Create Http Context         ${WEMALL_API}     http
    Next Request Should Succeed
    # Log To Console   >>Get TruemoveH Mobile Id url=${WEMALL_API}${truemoveh-all-mobile-b3}?province_id=${province_id}&type_number=${type_number}&inventory_id=${inventory_id}&price_plan_id=${price_plan_id}
    HttpLibrary.HTTP.GET        ${truemoveh-all-mobile-b3}?province_id=${province_id}&type_number=${type_number}&inventory_id=${inventory_id}&price_plan_id=${price_plan_id}
    ${response}=                Get Response Body
    Log To Console   >>Get TruemoveH Mobile Id response=${response}
    Log TO console   ${truemoveh-all-mobile-b3}?province_id=${province_id}&type_number=${type_number}&inventory_id=${inventory_id}&price_plan_id=${price_plan_id}
    ${mobile_id}=               Get Json Value          ${response}             /data/0/id
    ${mobile_id}=               Convert To Integer      ${mobile_id}
    Set Test Variable           ${var_tmh_mobile_id}    ${mobile_id}
    Log to console              mobile_bundle=${var_tmh_mobile_id}

Get TruemoveH Mobile Id For Sim
    [Arguments]    ${province_id}=None    ${type_number}=None
    Create Http Context      ${WEMALL_API}     http
    Next Request Should Succeed
    HttpLibrary.HTTP.GET     ${truemoveh-all-mobile}?province_id=${province_id}&type_number=${type_number}
    ${response}=            Get Response Body
    ${mobile_id}=           Get Json Value        ${response}             /data/0/id
    ${mobile}=              Get Json Value        ${response}             /data/0/mobile
    ${mobile_id}=           Convert To Integer    ${mobile_id}
    ${mobile}=              Replace String Using Regexp    ${mobile}    "    ${EMPTY}
    Set Test Variable     ${var_tmh_sim_mobile_id}      ${mobile_id}
    Set Test Variable     ${var_tmh_sim_mobile}         ${mobile}
    Log to console        mobile_sim=${var_tmh_sim_mobile_id}
    Log to console        mobile=${var_tmh_sim_mobile}

Random Id Card
    ${first_number}=                Evaluate    random.randint(1, 8)    modules=random
    ${second_number}=               Evaluate    random.randint(0, 9)    modules=random
    ${third_number}=                Evaluate    random.randint(0, 9)    modules=random
    ${fourth_number}=               Evaluate    random.randint(0, 9)    modules=random
    ${fifth_number}=                Evaluate    random.randint(0, 9)    modules=random
    ${sixth_number}=                Evaluate    random.randint(0, 9)    modules=random
    ${seventh_number}=              Evaluate    random.randint(0, 9)    modules=random
    ${eighth_number}=               Evaluate    random.randint(0, 9)    modules=random
    ${ninth_number}=                Evaluate    random.randint(0, 9)    modules=random
    ${tenth_number}=                Evaluate    random.randint(0, 9)    modules=random
    ${eleventh_number}=             Evaluate    random.randint(0, 9)    modules=random
    ${twelfth_number}=              Evaluate    random.randint(0, 9)    modules=random

    ${sum_all}=        Evaluate    (((${first_number}*13)+(${second_number}*12)+(${third_number}*11)+(${fourth_number}*10)+(${fifth_number}*9)+(${sixth_number}*8)+(${seventh_number}*7)+(${eighth_number}*6)+(${ninth_number}*5)+(${tenth_number}*4)+(${eleventh_number}*3)+(${twelfth_number}*2))%11)-11

    ${sum_all}=                 Convert To String     ${sum_all}
    ${thirteenth_number}=       Get Substring       ${sum_all}      -1

    Set Test Variable    ${var_random_id_card}    ${first_number}${second_number}${third_number}${fourth_number}${fifth_number}${sixth_number}${seventh_number}${eighth_number}${ninth_number}${tenth_number}${eleventh_number}${twelfth_number}${thirteenth_number}

    Log To Console    var_random_id_card : ${var_random_id_card}

Prepare TruemoveH Product Bundle On CAMP
    Create Bundle Promotion On Camp     ${var_tmh_product_device_inventory_id}   ${var_tmh_device_sub_inventory_id}

Prepare TruemoveH Product Bundle On CAMP 2
    Create Bundle Promotion On Camp 2    ${var_tmh_product_device_inventory_id}   ${var_tmh_device_sub_inventory_id}   1

Delete TruemoveH Product Bundle On CAMP
    Delete Promotion On Camp            ${var_camp_bundle_prodmotion_id}

