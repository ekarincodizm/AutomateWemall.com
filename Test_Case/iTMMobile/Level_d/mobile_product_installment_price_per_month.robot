*** Settings ***
Resource   ${CURDIR}/../../../Resource/init.robot
Library   ${CURDIR}/../../../Python_Library/mnp_util.py

Resource   ${CURDIR}/../../../Keyword/Common/keywords_itruemart_common.robot
Resource   ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource   ${CURDIR}/../../../Keyword/Portal/PCMS/Payment_method/keywords_payment_method.robot
Resource   ${CURDIR}/../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Level_d_page/keywords_leveld_mobile.robot
Resource   ${CURDIR}/../../../Keyword/Database/PCMS/Product/keywords_product.robot


Test Setup   Initialize Test Cases

*** Keywords ***
Initialize Test Cases
	${dict}=   Create Dictionary   page=mobile_level_d
	Set Test Variable  ${TEST_VAR}   ${dict}

*** Test Cases ***
TC_iTM_02475 Price per month of product that has 1 installment period
	[Tags]  TC_iTM_02475  installment   level_d   mobile   ready
	[Teardown]   Close All Browsers
	Login Pcms
	Go To Set Payment Page
	Payment Method - User Enter Any Product On Search Box
	Payment Method - User Click Search Button
	User Click Edit Button First Product On Set Payment Channel Page
	User Unchoose All Payment Channel
	User Is Ticked Checkbox Installment
	#Payment Method - User Unselect All Bank
	Unchoose All Bank Installment
	Payment Method - User Select Bank KBank
	Payment Method - User Select Bank Kbank 10 Months Period
	#Payment Method - User Select Installment All Bank And 10 Month Period
	Payment Method - User Click Save Button With Installment

	# ${dict}=  Set Variable  ${TEST_VAR}
	# Set To Dictionary   ${dict}   product_slug=powerbank-20000-mah
	# Set To Dictionary   ${dict}   inv_id=TRAAA1112711
	# Set To Dictionary   ${dict}   product_pkey=2114204718210
	# Set Test Variable  ${TEST_VAR}   ${dict}

	Level D Mobile - Open Browser And Go To Level D Mobile
	Level D Mobile - User Select Style Options
	Level D Mobile - Get Level D Sale Price
	Level D Mobile - Installment Section Is Displayed
	Level D Mobile - Price Per Month Is Correctly Displayed

TC_iTM_02476 Price per month of product that has > 1 installment period
 	[Tags]   TC_iTM_02476   installment   level_d  mobile   ready
 	[Teardown]   Close All Browsers
 	Login Pcms
	Go To Set Payment Page
	Payment Method - User Enter Any Product On Search Box
	Payment Method - User Click Search Button
	User Click Edit Button First Product On Set Payment Channel Page
	User Unchoose All Payment Channel
	User Is Ticked Checkbox Installment
	Unchoose All Bank Installment
	Payment Method - User Select Bank KBank
	Payment Method - User Select Bank Kbank 10 Months Period
	Payment Method - User Select Bank Kbank 6 Months Period
	Payment Method - User Click Save Button With Installment

	# ${dict}=  Set Variable  ${TEST_VAR}
	# Set To Dictionary   ${dict}   product_slug=tempered-glass-screen-protector-freshgadget-for-ipad235
	# Set To Dictionary   ${dict}   inv_id=FRAAA1111111
	# Set To Dictionary   ${dict}   product_pkey=2448968431206
	# Set Test Variable  ${TEST_VAR}   ${dict}


	Level D Mobile - Open Browser And Go To Level D Mobile
	Level D Mobile - User Select Style Options
	Level D Mobile - Get Level D Sale Price
	Level D Mobile - Installment Section Is Displayed
	Level D Mobile - Price Per Month Is Correctly Displayed

TC_iTM_02477 Display price following selected variant
	[Tags]   TC_iTM_02477  installment  level_d  mobile   ready
	[Teardown]   Close All Browsers
	Get 1 Sku Is In Product That Other Sku Has Price Not Equal

	Level D Mobile - Open Browser Level D
	Level D Mobile - Select All Sku And Check Price Equal As Database


