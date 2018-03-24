*** Settings ***
Library           ../../../Python_Library/holidays_library.py

*** Keywords ***
Create Holiday
	# ex. ${created_at}   2015-06-04
	[Arguments]   ${created_at}   ${deleted_at}=None
	${deleted_at}=   Set Variable If    '${deleted_at}'=='None'    ${created_at}   ${deleted_at}
	${holiday_id}=   Py Insert Holidays   ${created_at}   ${deleted_at}
	Set Test Variable   ${TV_holiday_id}   ${holiday_id}

Remove Holiday
	[Arguments]   ${holiday_id}=${TV_holiday_id}
	Py Delete Holidays   ${holiday_id}