*** Keywords ***
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

Get Date Now Format Thai
    ${date} =	Get Current Date	result_format=datetime
    Get Thai Month      ${date.month}
    ${d}=     Convert To String   ${date.day}
    ${m}=     Convert To String   ${var_booking_thai_month}
    ${y}=     Evaluate   ${date.year}+543
    Set Test Variable   ${var_booking_thai_date_now}     ${d} ${m} ${y}

Get Date Now Format English
    ${date} =	Get Current Date	result_format=datetime
    Get English Month      ${date.month}
    ${d}=     Convert To String   ${date.day}
    ${m}=     Convert To String   ${var_booking_english_month}
    ${y}=     Convert To String   ${date.year}
    Set Test Variable   ${var_booking_english_date_now}     ${d} ${m} ${y}

Get Thai Month
    [Arguments]     ${month}
    Log To Console    ${month}
    ${thai_month}=    Run Keyword If   '${month}' == '1'  Convert To String    มกราคม
    ...   ELSE IF   '${month}' == '2'  Convert To String    กุมภาพันธ์
    ...   ELSE IF   '${month}' == '3'  Convert To String    มีนาคม
    ...   ELSE IF   '${month}' == '4'    Convert To String    เมษายน
    ...   ELSE IF   '${month}' == '5'  Convert To String    พฤษภาคม
    ...   ELSE IF   '${month}' == '6'  Convert To String    มิถุนายน
    ...   ELSE IF   '${month}' == '7'  Convert To String    กรกฎาคม
    ...   ELSE IF   '${month}' == '8'  Convert To String    สิงหาคม
    ...   ELSE IF   '${month}' == '9'  Convert To String    กันยายน
    ...   ELSE IF   '${month}' == '10'  Convert To String    ตุลาคม
    ...   ELSE IF   '${month}' == '11'  Convert To String    พฤศจิกายน
    ...   ELSE IF   '${month}' == '12'  Convert To String    ธันวาคม
    ...   ELSE  Convert To String  ${EMPTY}
    Set Test Variable   ${var_booking_thai_month}     ${thai_month}

Get English Month
    [Arguments]     ${month}
    ${english_month}=    Run Keyword If   '${month}' == '1'  Convert To String    January
    ...   ELSE IF   '${month}' == '2'  Convert To String    February
    ...   ELSE IF   '${month}' == '3'  Convert To String    March
    ...   ELSE IF   '${month}' == '4'    Convert To String    April
    ...   ELSE IF   '${month}' == '5'  Convert To String    May
    ...   ELSE IF   '${month}' == '6'  Convert To String    June
    ...   ELSE IF   '${month}' == '7'  Convert To String    July
    ...   ELSE IF   '${month}' == '8'  Convert To String    August
    ...   ELSE IF   '${month}' == '9'  Convert To String    September
    ...   ELSE IF   '${month}' == '10'  Convert To String    October
    ...   ELSE IF   '${month}' == '11'  Convert To String    November
    ...   ELSE IF   '${month}' == '12'  Convert To String    December
    ...   ELSE  Convert To String  ${EMPTY}
    Set Test Variable   ${var_booking_english_month}     ${english_month}

Change Format Date to Y-m-d
    [Arguments]     ${datetime}   ${plus_month}=0
    ${date}=	        Convert Date	        ${datetime}	  datetime
    ${month}=           Convert To Integer      ${date.month}
    ${new_month}=       Evaluate      ${plus_month}+${month}
    Return From Keyword     ${date.year}-${new_month}-${date.day}

Change Format Date to Y-m-d H:i:s
    [Arguments]     ${datetime}
    ${date} =	Convert Date	${datetime}	 datetime
    Return From Keyword     ${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}
