*** Settings ***
#Library    ${CURDIR}/../../../../Python_Library/


*** Keywords ***
Expect Success Api Apply Coupon
	[Arguments]   ${response}
	${status}=         Get From Dictionary   ${response}   status
	${code}=           Get From Dictionary   ${response}   code
	Should Be Equal   ${status}         success
	Should Be Equal As Numbers   ${code}           200

Expect Error Api Apply Coupon: 4119
	[Arguments]   ${response}
	${status}=         Get From Dictionary   ${response}   status
	${code}=           Get From Dictionary   ${response}   code
	${data}=           Get From Dictionary   ${response}   data
	${errorCode}=      Get From Dictionary   ${data}   errorCode
	${errorMessage}=   Get From Dictionary   ${data}   errorMessage
	Should Be Equal   ${status}         error
	Should Be Equal As Numbers   ${code}           200
	Should Be Equal As Numbers   ${errorCode}      4119
	Should Be Equal   ${errorMessage}   Promotion code is already in cart please remove promotion code first

Apply Coupon And Success
	[Arguments]   ${code}
	${result1}=   py_api_apply_coupon   ${TV_user_id}   ${TV_user_type}   ${code}
	Expect Success Api Apply Coupon   ${result1}

Apply Coupon And Error 4119
	[Arguments]   ${code}
	${result2}=   py_api_apply_coupon   ${TV_user_id}   ${TV_user_type}   ${code}
	Expect Error Api Apply Coupon: 4119   ${result2}