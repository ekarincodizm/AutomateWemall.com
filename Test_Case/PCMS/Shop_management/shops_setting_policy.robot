*** Settings ***
Force Tags    WLS_Shop
Library     Selenium2Library
Library     HttpLibrary.HTTP
Library     Collections
Library     OperatingSystem

Resource    ${CURDIR}/../../../Resource/init.robot
Library     ${CURDIR}/../../../Python_Library/shop_setting_policy.py
Resource    ${CURDIR}/../../../Keyword/Portal/PCMS/Shop/keywords_setting_policy.robot
Resource    ${CURDIR}/../../../Keyword/Portal/PCMS/Shop/keywords_shop.robot
Resource    ${CURDIR}/../../../Keyword/Portal/PCMS/Shop/web_element_setting_policy.robot
Resource    ${CURDIR}/../../../Keyword/Portal/PCMS/Shop/web_element_shop.robot
Resource    ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource    ${CURDIR}/../../../Keyword/API/PCMS/Shop/keywords_shop.robot
Resource    ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot


Test Setup      Prepare Test Case
Test Teardown   End Test Case

*** Keywords ***
Prepare Test Case
	${result}=   API Shop - Create Shop   ${shop_code}   ${shop_name}
	Log to console   ${result}

End Test Case
	Delete Shop By Shop Code   ${shop_code}
	Close All Browsers

*** Variables ***
${shop_code}   ROBOTCODE
${shop_name}   Robot Shop Name
${delivery_policy_title_th}     Delivery Policy Title Thai
${delivery_policy_title_us}     Delivery Policy Title English
${delivery_policy_detail_th}    Delivery Policy Detail Thai
${delivery_policy_detail_us}    Delivery Policy Detail English

${return_policy_title_th}       Return Policy Title Thai
${return_policy_title_us}       Return Policy Title English
${return_policy_detail_th}      Return Policy Detail Thai
${return_policy_detail_us}      Return Policy Detail English

${refund_policy_title_th}       Refund Policy Title Thai
${refund_policy_title_us}       Refund Policy Title English
${refund_policy_detail_th}      Refund Policy Detail Thai
${refund_policy_detail_us}      Refund Policy Detail English


*** Test Cases ***
TC_iTM_01787 Display manage policy button on shop management
	[Tags]  TC_iTM_01787  ITMA-2855  shop_policy  shop_setting_policy  setting_policy  manage_policy  itma-s72016  pcms  regression  ready
	Login Pcms
	Go To Shop Management
	Display Policy Button In Shop Management

TC_iTM_01788 Display blank field when click manage policy button
	[Tags]  TC_iTM_01788  ITMA-2855  shop_policy  shop_setting_policy  setting_policy  manage_policy  itma-s72016  pcms  regression  ready
	Login Pcms
	Go To Shop Management
	Display Policy Button In Shop Management
	Search Shop Name in Shop Management     ${shop_name}
	Click Shop Policy Button By Shop Code   ${shop_code}
	Display Shop Setting Policy
	Display Save Button In Setting Policy
	Display Shop Code And Shop Name As Readonly
	Display Correct Shop Code And Shop Name In Setting Policy   ${shop_code}   ${shop_name}
	Display Setting Policy Blank Form

# TC_iTM_01789 Do not enter any fields Show error message and data not save
# 	[Tags]  TC3  TC_iTM_01789  ITMA-2855  shop_policy  shop_setting_policy  setting_policy  manage_policy  itma-s72016  pcms  regression  ready
# 	Login Pcms
# 	Go To Shop Management
# 	Display Policy Button In Shop Management
# 	Search Shop Name in Shop Management     ${shop_name}
# 	Click Shop Policy Button By Shop Code   ${shop_code}
# 	Display New Shop Setting Policy
# 	Setting Policy - User Click Save Button
# 	# Display Shop Setting Policy
# 	# Not Display Setting Policy Success




# TC_iTM_01790 Enter some fields and click save button
# 	[Tags]  TC4  TC_iTM_01790  ITMA-2855  shop_policy  shop_setting_policy  setting_policy  manage_policy  itma-s72016  pcms  regression  ready
# 	Login Pcms
# 	Go To Shop Management
# 	Display Policy Button In Shop Management
# 	Search Shop Name in Shop Management     ${shop_name}
# 	Click Shop Policy Button By Shop Code   ${shop_code}
# 	Display New Shop Setting Policy
# 	Fill Data In Setting Policy Form: Delivery Time   1   7
# 	Fill Data In Setting Policy Form: TH Policy  delivery_th_title
# 	 ...  return_th_title
# 	 ...  refund_th_title
# 	 ...  ${EMPTY}
# 	 ...  ${EMPTY}
# 	 ...  ${EMPTY}
# 	Setting Policy - User Click Save Button
# 	Display Shop Setting Policy
# 	Display Setting Policy Error: TH Deliver Policy Detail Is Required
# 	Display Setting Policy Error: TH Return Policy Detail Is Required
# 	Display Setting Policy Error: TH Refund Policy Detail Is Required

TC_iTM_01791 Enter fields delivery min = 0, max = 0
	[Tags]  TC5  TC_iTM_01791  ITMA-2855  shop_policy  shop_setting_policy  setting_policy  manage_policy  itma-s72016  pcms  regression  ready
	Login Pcms
	Go To Shop Management
	Display Policy Button In Shop Management
	Search Shop Name in Shop Management     ${shop_name}
	Click Shop Policy Button By Shop Code   ${shop_code}
	Display New Shop Setting Policy
	Fill Data In Setting Policy Form: Delivery Time   0   0
	Fill Data In Setting Policy Form: TH Policy
	Setting Policy - User Click Save Button
	Display Shop Setting Policy
	Display Setting Policy Error: Delivery Time Min Is Zero
	Display Setting Policy Error: Delivery Time Max Is Zero

TC_iTM_01792 Enter fields delivery min > max
	[Tags]  TC6  TC_iTM_01792  ITMA-2855  shop_policy  shop_setting_policy  setting_policy  manage_policy  itma-s72016  pcms  regression  ready
	Login Pcms
	Go To Shop Management
	Display Policy Button In Shop Management
	Search Shop Name in Shop Management     ${shop_name}
	Click Shop Policy Button By Shop Code   ${shop_code}
	Display New Shop Setting Policy
	Fill Data In Setting Policy Form: Delivery Time   5   1
	Fill Data In Setting Policy Form: TH Policy
	Setting Policy - User Click Save Button
	Display Shop Setting Policy
	Display Setting Policy Error: Delivery Time Min Is More Than Delivery Time Max

TC_iTM_01793 Enter all required fields TH and delivery min = delivery max
	[Tags]  TC7  TC_iTM_01793  ITMA-2855  shop_policy  shop_setting_policy  setting_policy  manage_policy  itma-s72016  pcms  regression  ready
	Login Pcms
	Go To Shop Management
	Display Policy Button In Shop Management
	Search Shop Name in Shop Management     ${shop_name}
	Click Shop Policy Button By Shop Code   ${shop_code}
	Display New Shop Setting Policy
	Fill Data In Setting Policy Form: Delivery Time   1   1
	Fill Data In Setting Policy Form: TH Policy
	Setting Policy - User Click Save Button
	Display Shop Setting Policy
	Display Setting Policy Success

TC_iTM_01794 Enter all required fields TH + EN and delivery min < delivery max
	[Tags]  TC8  TC_iTM_01794  ITMA-2855  shop_policy  shop_setting_policy  setting_policy  manage_policy  itma-s72016  pcms  regression  ready
	Login Pcms
	Go To Shop Management
	Display Policy Button In Shop Management
	Search Shop Name in Shop Management     ${shop_name}
	Click Shop Policy Button By Shop Code   ${shop_code}
	Display New Shop Setting Policy
	Fill Data In Setting Policy Form: Delivery Time   1   3
	Fill Data In Setting Policy Form: TH Policy
	Fill Data In Setting Policy Form: EN Policy
	Setting Policy - User Click Save Button
	Display Shop Setting Policy
	Display Setting Policy Success

TC_iTM_01795 Found data when click edit button from manage policy button
	[Tags]  TC9  TC_iTM_01795  ITMA-2855  shop_policy  shop_setting_policy  setting_policy  manage_policy  itma-s72016  pcms  regression  ready
	Login Pcms
	Go To Shop Management
	Display Policy Button In Shop Management
	Search Shop Name in Shop Management     ${shop_name}
	Click Shop Policy Button By Shop Code   ${shop_code}
	Display New Shop Setting Policy
	Fill Data In Setting Policy Form: Delivery Time   1   3
	Fill Data In Setting Policy Form: TH Policy
	Fill Data In Setting Policy Form: EN Policy
	Setting Policy - User Click Save Button
	Display Setting Policy Success

	Fill Data In Setting Policy Form: Delivery Time   2   5
	Fill Data In Setting Policy Form: TH Policy  delivery_th_title_1
	 ...  return_th_title_1
	 ...  refund_th_title_1
	 ...  delivery_th_detail_1
	 ...  return_th_detail_1
	 ...  refund_th_detail_1
	Fill Data In Setting Policy Form: EN Policy  delivery_en_title_1
	 ...  return_en_title_1
	 ...  refund_en_title_1
	 ...  delivery_en_detail_1
	 ...  return_en_detail_1
	 ...  refund_en_detail_1
	Setting Policy - User Click Save Button
	Display Shop Setting Policy
	Display Setting Policy Success

	Display Data In Setting Policy Form: Delivery Time As Input   2   5
	Display Data In Setting Policy Form: TH Policy As Input  delivery_th_title_1
	 ...  return_th_title_1
	 ...  refund_th_title_1
	 ...  delivery_th_detail_1
	 ...  return_th_detail_1
	 ...  refund_th_detail_1
	Display Data In Setting Policy Form: EN Policy As Input  delivery_en_title_1
	 ...  return_en_title_1
	 ...  refund_en_title_1
	 ...  delivery_en_detail_1
	 ...  return_en_detail_1
	 ...  refund_en_detail_1

TC_iTM_05354 Do Not Enter Delivery Max and Enter Delivery Min
	[Tags]   TC_iTM_05354   ITMA-20855  shop_policy  validate   error  regression
	Login Pcms
	Go To Shop Management
	Display Policy Button In Shop Management
	Search Shop Name In Shop Management   ${shop_name}
	Click Shop Policy Button By Shop Code   ${shop_code}
	Display New Shop Setting Policy
	Setting Policy - User Enter Delivery Min    5
	Setting Policy - User Click Save Button
	Display Shop Setting Policy
	Not Display Setting Policy Success

TC_iTM_05355 Do Not Enter Delivery Policy Title Thai
	[Tags]   TC_iTM_05355   ITMA-2855  shop_policy  validate   error  regression
	Login Pcms
	Go To Shop Management
	Display Policy Button In Shop Management
	Search Shop Name In Shop Management   ${shop_name}
	Click Shop Policy Button By Shop Code   ${shop_code}
	Display New Shop Setting Policy
	Setting Policy - User Enter Delivery Min  3
	Setting Policy - User Enter Delivery Max  5
	Setting Policy - User Click Save Button
	Display Shop Setting Policy
	Not Display Setting Policy Success

TC_iTM_05356 Do Not Enter Delivery Policy Detail Thai
	[Tags]   TC_iTM_05356   ITMA-2855  shop_policy  validate   error  regression
	Login Pcms
	Go To Shop Management
	Display Policy Button In Shop Management
	Search Shop Name In Shop Management   ${shop_name}
	Click Shop Policy Button By Shop Code   ${shop_code}
	Display New Shop Setting Policy
	Setting Policy - User Enter Delivery Min  3
	Setting Policy - User Enter Delivery Max  5
	Setting Policy - User Enter Delivery Policy Title Thai    ${delivery_policy_title_th}
	Setting Policy - User Click Save Button
	Display Shop Setting Policy
	Not Display Setting Policy Success

TC_iTM_05357 Do Not Enter Any Policy title
	[Tags]   TC_iTM_05357   ITMA-2855  shop_policy  validate   error  regression
	Login Pcms
	Go To Shop Management
	Display Policy Button In Shop Management
	Search Shop Name In Shop Management   ${shop_name}
	Click Shop Policy Button By Shop Code   ${shop_code}
	Display New Shop Setting Policy
	Setting Policy - User Enter Delivery Min  3
	Setting Policy - User Enter Delivery Max  5
	Setting Policy - User Enter Delivery Policy Title Thai    ${delivery_policy_title_th}
	#Setting Policy - User Enter Delivery Policy Detail Thai  ${delivery_policy_detail_th}
	Setting Policy - User Enter Return Policy Title Thai   ${return_policy_title_th}
	Setting Policy - User Enter Refund Policy TItle Thai   ${refund_policy_title_th}
	Setting Policy - User Click Save Button
	Setting Policy - Display Error Message
	Setting Policy - Error Message Contains Delivery Policy Is Required
	Setting Policy - Error Message Contains Return Policy Is Required
	Setting Policy - Error Message Contains Refund Policy Is required

TC_iTM_05358 Do Not Enter Return And Refund Policy Detail Thai
	[Tags]  TC_iTM_05358  ITMA-2855  shop_policy  validate   error  regression
	Login Pcms
	Go To Shop Management
	Display Policy Button In Shop Management
	Search Shop Name In Shop Management   ${shop_name}
	Click Shop Policy Button By Shop Code   ${shop_code}
	Display New Shop Setting Policy
	Setting Policy - User Enter Delivery Min  3
	Setting Policy - User Enter Delivery Max  5
	Setting Policy - User Enter Delivery Policy Title Thai    ${delivery_policy_title_th}
	Setting Policy - User Enter Delivery Policy Detail Thai  ${delivery_policy_detail_th}
	Setting Policy - User Enter Return Policy Title Thai   ${return_policy_title_th}
	Setting Policy - User Enter Refund Policy TItle Thai   ${refund_policy_title_th}
	Setting Policy - User Click Save Button
	Setting Policy - Display Error Message
	Setting Policy - Error Message Contains Return And Refund Policy Is Required


TC_iTM_05359 - Do Not Enter Refund Policy Detail Thai
	[Tags]  TC_iTM_05359  ITMA-2855  shop_policy  validate  error  regression
	Login Pcms
	Go To Shop Management
	Display Policy Button In Shop Management
	Search Shop Name In Shop Management   ${shop_name}
	Click Shop Policy Button By Shop Code   ${shop_code}
	Display New Shop Setting Policy
	Setting Policy - User Enter Delivery Min  3
	Setting Policy - User Enter Delivery Max  5
	Setting Policy - User Enter Delivery Policy Title Thai    ${delivery_policy_title_th}
	Setting Policy - User Enter Delivery Policy Detail Thai  ${delivery_policy_detail_th}
	Setting Policy - User Enter Return Policy Title Thai   ${return_policy_title_th}
	Setting Policy - User Enter Return Policy Detail Thai  ${delivery_policy_detail_th}
	Setting Policy - User Enter Refund Policy TItle Thai   ${refund_policy_title_th}
	Setting Policy - User Click Save Button
	Setting Policy - Display Error Message
	Setting Policy - Error Message Contains Refund Policy Is Required

