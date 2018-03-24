*** Settings ***
Resource          ${CURDIR}/../../../../Keyword/Database/PCMS//Truemove_h/keywords_truemove_h.robot
Resource          ${CURDIR}/../../../../Keyword/Database/PCMS/Cart/keywords_cart.robot
Resource          ${CURDIR}/../../../../Keyword/API/PCMS/Bundle/keywords_prepare_bundle.robot
*** Keywords ***
TruemoveH Common - Random Id Card
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
    [Return]            ${var_random_id_card}

TruemoveH Common - Check hold expired date is 100Years
    [Arguments]         ${fact_datetime}
    ${datetime_now}=            Get Current Date            result_format=datetime
    ${yearnow}=                 Convert To Integer          ${datetime_now.year}
    ${yearnow_100}=             Evaluate                    ${yearnow}+100
    ${fact_datetime}=           Convert Date	            ${fact_datetime}         datetime
    ${fact_year}=               Convert To Integer	        ${fact_datetime.year}
    Should Be Equal As Integers         ${yearnow_100}          ${fact_year}