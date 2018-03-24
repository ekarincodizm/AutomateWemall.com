*** Settings ***
Library    ${CURDIR}/../../Python_Library/helper_datetime.py


*** Variables ***
&{short_thai_month}   01=ม.ค.  02=ก.พ.  03=มี.ค.  04=เม.ย.  05=พ.ค.  06=มิ.ย.
 ...  07=ก.ค.  08=ส.ค.  09=ก.ย.  10=ต.ค.  11=พ.ย.  12=ธ.ค.

&{thai_month}   01=มกราคม  02=กุมภาพันธ์  03=มีนาคม  04=เมษายน  05=พฤษภาคม  06=มิถุนายน
 ...  07=กรกฎาคม  08=สิงหาคม  09=กันยายน  10=ตุลาคม  11=พฤศจิกายน  12=ธันวาคม


*** Keywords ***

Convert Day Add Zero Prefix
	[Arguments]   ${number}
	${number}=  Helper Convert To String  ${number}
	${length_day}=   Get Length  ${number}
	${return}=  Run Keyword If   '${length_day}' == '1'  Set Variable  0${number}
	...   ELSE  Set Variable   ${number}
	Return From Keyword   ${return}

Convert Month Add Zero Prefix
	[Arguments]   ${number}
	${number}=   Helper Convert To String  ${number}
	${length_month}=   Get Length  ${number}
	${return}=  Run Keyword If   '${length_month}' == '1'  Set Variable  0${number}
	...   ELSE  Set Variable   ${number}
	Return From Keyword   ${return}

Get Date By Adding Days
	[Arguments]    ${add_day}=0
	${current_date} =    Get Current Date
	${date} =    Add Time To Date    ${current_date}    ${add_day} days
	Return From Keyword    ${date}

# Get Adding Date
# 	[Arguments]   ${date}=None   ${add_days}=1
# 	${current_date}=    Get Current Date
# 	Run Keyword If   '${date}' == 'None'   Return From Keyword  ${current_date}

# 	${date}=  Add Time To Date   ${date}   ${add_days} days
# 	[Return]   ${date}

Helper Date - Get Sla Time
	[Arguments]   ${current_date}=None  ${min}=None  ${max}=None

	date_by_adding_business_days

Helper Date - Get Holidays
	${holidays}=   Get Holidays
	Log To Console   ${holidays}

Convert Year to Thai Year
    [Arguments]   ${number}
    ${thai_year}=          Evaluate            ${number}+543
    Return From Keyword    ${thai_year}

Get Short Year
    [Arguments]   ${string}
    ${string}=              Convert To String   ${string}
    ${short_year}=          Get Substring       ${string}       2
    Return From Keyword     ${short_year}

#27 มิ.ย. 59 17:39:16
Convert Datetime to thai format
   [Arguments]      ${datetime}         ${short_year}=true
   ${datetime}=             Convert Date		                                ${datetime}         datetime
   ${day_}=                 keywords_date.Convert Day Add Zero Prefix           ${datetime.day}
   ${month}=                keywords_date.Convert Month Add Zero Prefix         ${datetime.month}
   ${month_}=               Get From Dictionary       ${short_thai_month}       ${month}
   ${year}=                 Convert Year to Thai Year           ${datetime.year}
   ${year_}=                Run Keyword If     '${short_year}' == 'true'      Get Short Year      ${year}
   	...   ELSE              Convert To String           ${year}

   ${hour_}=                DateTime Add Zero Prefix        	${datetime.hour}
   ${minute_}=              DateTime Add Zero Prefix        	${datetime.minute}
   ${second_}=              DateTime Add Zero Prefix        	${datetime.second}
   ${new_datetime}=         Convert To String       ${day_} ${month_} ${year_} ${hour_}:${minute_}:${second_}
   Log To Console           ${new_datetime}
   Return From Keyword      ${new_datetime}

DateTime Add Zero Prefix
	[Arguments]             ${number}
	${number}=              Convert To String       ${number}
	${length_number}=       Get Length              ${number}
	${return}=              Run Keyword If          '${length_number}' == '1'      Convert To String       0${number}
	...   ELSE              Convert To String       ${number}
	Return From Keyword     ${return}

# Get User ID
# 	Go To   ${HOST}/test/user
# 	Wait Until Element Is Visible   //i[1]
# 	${group}=   Get Text   //i[1]
# 	Log to console   ${group}
# 	${idx}=   Set Variable If   ${group} == "guest"   2   3
# 	${user_type}=   Set Variable If   ${group} == "guest"   non-user   user
# 	${user_id}=   Get Text   //i[${idx}]
# 	${user_id}=   Remove String   ${user_id}   "
# 	Set Test Variable   ${TV_user_type}   ${user_type}
# 	Set Test Variable   ${TV_user_id}   ${user_id}
# 	Set Test Variable   ${TV_user_group}   ${group}
# 	Log to console   user_id=${TV_user_id}

# Get User Type By User ID
# 	[Arguments]    ${user_id}=${TV_user_id}
# 	${length} =   Get Length   ${user_id}
# 	${user_type}=   Set Variable If   ${length} == "13"   non-user   user
# 	Set Test Variable   ${TV_user_type}   ${user_type}
# 	[Return]   ${user_type}