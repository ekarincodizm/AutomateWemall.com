*** Settings ***
Resource   ${CURDIR}/../../../Resource/init.robot
Library   ${CURDIR}/../../../Python_Library/mnp_util.py
Resource   ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource   ${CURDIR}/../../../Keyword/Portal/PCMS/Payment_method/keywords_payment_method.robot
Resource   ${CURDIR}/../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Level_d_page/keywords_leveld_mobile.robot


Test Setup   Initialize Test Cases

*** Keywords ***
Initialize Test Cases
	${dict}=   Create Dictionary   page=mobile_level_d
	Set Test Variable  ${TEST_VAR}   ${dict}

*** Test Cases ***
TC_iTM_02475 Price per month of product that has 1 installment period
	[Tags]  TC_iTM_02475  installment   level_d   mobile
	#[Teardown]   Close Browser
	Login Pcms
	Go To Set Payment Page
	Payment Method - User Enter Any Product On Search Box
	User Click Edit Button First Product On Set Payment Channel Page
	User Unchoose All Payment Channel
	User Is Ticked Checkbox Installment
	#Payment Method - User Unselect All Bank
	Unchoose All Bank Installment
	Payment Method - User Select Bank KBank
	Payment Method - User Select Bank Kbank 10 Months Period
	#Payment Method - User Select Installment All Bank And 10 Month Period
	Payment Method - User Click Save Button With Installment

	Level D Mobile - Go To Level D Mobile With Sku

TC_iTM_02476 Price per month of product that has > 1 installment period
 	[Tags]   TC_iTM_02476   installment   level_d  mobile
 	Log to console    tc2

TC_iTM_02477 Display price following selected variant
	[Tags]   TC_iTM_02477  installment  level_d  mobile


