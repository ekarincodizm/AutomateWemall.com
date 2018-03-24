*** Settings ***
Resource   ${CURDIR}/../../../Resource/init.robot
Library   ${CURDIR}/../../../Python_Library/mnp_util.py


Resource   ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource   ${CURDIR}/../../../Keyword/Portal/PCMS/Payment_method/keywords_payment_method.robot
Resource   ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource   ${CURDIR}/../../../Keyword/Database/PCMS/Product/keywords_product.robot

Test Setup   Initialize Test Cases

*** Keywords ***
Initialize Test Cases
	${dict}=   Create Dictionary   page=mobile_level_d
	Set Test Variable  ${TEST_VAR}   ${dict}

*** Test Cases ***
TC_iTM_02480 Price per month of product that has 1 installment period
	[Tags]  TC_iTM_02480  installment   level_d   web  ready
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
	Payment Method - User Click Save Button With Installment

	# ${dict}=  Set Variable  ${TEST_VAR}
	# Set To Dictionary   ${dict}   product_slug=powerbank-20000-mah
	# Set To Dictionary   ${dict}   inv_id=TRAAA1112711
	# Set To Dictionary   ${dict}   product_pkey=2114204718210
	# Set Test Variable  ${TEST_VAR}   ${dict}

	Level D - Open Browser And Go To Level D
	Level D - User Select Style Options
	Level D - Get Level D Sale Price
	Level D - Installment Section Is Displayed
	Level D - Price Per Month Is Correctly Displayed

TC_iTM_02481 Price per month of product that has > 1 installment period
 	[Tags]   TC_iTM_02481   installment   level_d  web  ready
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
	# Set To Dictionary   ${dict}   product_slug=powerbank-20000-mah
	# Set To Dictionary   ${dict}   inv_id=TRAAA1112711
	# Set To Dictionary   ${dict}   product_pkey=2114204718210
	# Set Test Variable  ${TEST_VAR}   ${dict}


	Level D - Open Browser And Go To Level D
	Level D - User Select Style Options
	Level D - Get Level D Sale Price
	Level D - Installment Section Is Displayed
	Level D - Price Per Month Is Correctly Displayed

TC_iTM_02482 Display price following selected variant
	[Tags]   TC_iTM_02482  installment  level_d  ready
	Get 1 Sku Is In Product That Other Sku Has Price Not Equal

	Level D - Open Browser Level D
	Level D - Select All Sku And Check Price Equal As Database
	# Level D - User Select Style Options



