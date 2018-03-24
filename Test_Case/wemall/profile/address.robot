*** Settings ***
Library    Selenium2Library
Resource   ${CURDIR}/../../../Resource/init.robot
Resource   ${CURDIR}/../../../Keyword/Portal/iTruemart/Login/keywords_login.robot
Resource   ${CURDIR}/../../../Keyword/Portal/wemall/profile/keywords_profile.robot

*** Variables ***

${full_name}     Robot Automated Full Name
${province}      กรุงเทพ
${zipcode}       10400
${address}       Robot Automated Address
${mobile}        0801234567
${email}         robotautomate@gmail.com


*** Test Cases ***
TC_iTM_03376 Update address at Profile page
	[Tags]  TC_iTM_03376  profile   address  success   regression   ready
	Given Wemall Common - Open Web Wemall Homepage
	and User Login From Header Bar
	and Header - User Move Mouse Over Link Profile
	and Header - Profile Sub Menu Is Displayed
	When Header - User Click Link Profile
	Then Profile - Profile Page Is Displayed

	When Profile - User Change Full Name
	and Wemall Common - Close Live Chat
	and Profile - User Click Save Button
	Then Profile - Full Name Is Changed
	[Teardown]   Selenium2Library.Close All Browsers

TC_iTM_03550 Cannot update address at Profile page
	[Tags]  TC_iTM_03550   profile   address  fail  error_message   regression    ready
	Given Wemall Common - Open Web Wemall Homepage
	and User Login From Header Bar
	and Header - User Move Mouse Over Link Profile
	and Header - Profile Sub Menu Is Displayed
	When Header - User Click Link Profile
	Then Profile - Profile Page Is Displayed

	Given Wemall Common - Close Live Chat
	When Profile - User Leave Blank Full Name
	and Profile - User Click Save Button
	Then Profile - Error Full Name Required Is Displayed

	When Profile - User Click Modal Ok Button
	Then Profile - Error Popup Is Closed

	Given Profile - User Enter Full Name    ${full_name}

	When Profile - User Leave Blank Province
	and Profile - User Click Save Button
	Then Profile - Error Province Required Is Displayed

	When Profile - User Click Modal Ok Button
	Then Profile - Error Popup Is Closed


	Given Profile - User Select Province As Bangkok

	When Profile - User Leave Blank Address
	and Profile - User Click Save Button
	THen Profile - Error Address Required Is Displayed

	When Profile - User Click Modal Ok Button
	Then Profile - Error Popup Is Closed

	Given Profile - User Enter Address   ${address}

	When Profile - User Leave Blank Zipcode
	and Profile - User Click Save Button
	Then Profile - Error Zipcode Required Is Displayed

	When Profile - USer Click Modal Ok Button
	Then Profile - Error Popup Is Closed

	Given Profile - User Enter Zipcode  ${zipcode}

	When Profile - User Leave Blank Mobile
	and Profile - User Click Save Button
	Then Profile - Error Mobile Required Is Displayed

	When Profile - User Click MOdal Ok Button
	Then Profile - Error Popup Is Closed

	Given Profile - User Enter Mobile No   ${mobile}

	When Profile - User Leave Blank Email
	and Profile - User Click Save Button
	Then Profile - Error Email Required Is Displayed

	When Profile - User Click Modal Ok Button
	Then Profile - Error Popup Is Closed

	[Teardown]   Selenium2Library.Close All Browsers
