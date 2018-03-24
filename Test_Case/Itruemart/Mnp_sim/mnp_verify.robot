*** Settings ***
Library     Selenium2Library
Library     HttpLibrary.HTTP
Library     Collections
Library     OperatingSystem
Library     ${CURDIR}/../../Python_Library/Math.py
Library     ${CURDIR}/../../Python_Library/Mnp_library.py
Resource    ${CURDIR}/../../../Resource/init.robot
Resource    ${CURDIR}/../../../Keywords/Common/common_keyword.robot
Resource    ${CURDIR}/../../../pcms-robot-ux/Keywords/Edm/edm_keyword.robot
Resource    ${CURDIR}/../../Resources/init.txt

Resource    ${CURDIR}/../../Resources/Page_objects/mnp_page_object.robot
Resource    ${CURDIR}/../../Keywords/Common_keyword.robot
Resource    ${CURDIR}/../../Keywords/Mnp_common_keyword.robot
Resource    ${CURDIR}/../../Keywords/Mnp_landing_keyword.robot
Resource    ${CURDIR}/../../Keywords/Mnp_keyword.robot

Test Setup  Run Keywords   Delete Campaign By Web Prefix   Delete Campaign By Mobile Prefix
Test Teardown  Close All Browsers

*** Keywords ***
Keyword1
	${result}=    Evaluate  1+1
	Set Test Variable    ${test-var}   ${result}
Keyword2
	Log To console   ${test-var}

*** Test Cases ***
POC
	[Tags]    poc_test_var
	Keyword1
	Keyword2

POC2
	[Tags]    poc_test_var
	Log to console   ${test-var}

TC1: Create EDM for mnp landing in desktop view
	[Tags]    TC1  create_landing  web  ready
	Login Pcms
	Go To EDM Page
	Go To Create Edm Page
	#Delete Campaign By Web Prefix
	User Enter Campaign Name
	User Enter Web Prefix
	User Select Campaign Type As Static
	User Click Save Button
	Display Edm Edit Page
	Campaign Name Display Same As Input
	Status Should Be Disable
	User Enter Description
	User Select Status As Enable
	User Click Save Button
	User Press Accept Alert
	Open MNP Web Landing Page No Cache
	Display Landing Page Desktop

TC2: Preview EDM for mnp landing in desktop view
	[Tags]    TC2  preview_landing  web  ready
	Login Pcms
	Go To EDM Page
	Go To Create Edm Page
	#Delete Campaign By Web Prefix
	User Enter Campaign Name
	User Enter Web Prefix
	User Select Campaign Type As Static
	User Click Save Button
	Display Edm Edit Page
	Campaign Name Display Same As Input
	Status Should Be Disable
	User Enter Description
	User Click Save Button
	User Press Accept Alert
	URL Display Save Data Success
	Open MNP Web Landing Page Preview
	Display Preview Landing Page Desktop

TC3: Create EDM for mnp landing in mobile view
	[Tags]    TC3  create_landing  mobile  ready
	Login Pcms
	Go To EDM Page
	Go To Create Edm Page
	#Delete Campaign By Mobile Prefix
	User Enter Campaign Name
	User Enter Mobile Prefix
	User Select Campaign Type As Static
	User Click Save Button
	Display Edm Edit Page
	Campaign Name Display Same As Input
	Status Should Be Disable
	User Enter Description
	User Select Status As Enable
	User Click Save Button
	User Press Accept Alert
	Open MNP Mobile Landing Page No Cache
	Display Landing Page

TC4: Preview EDM for mnp landing in mobile view
	[Tags]    TC4  preview_landing  mobile  ready
	Login Pcms
	Go To EDM Page
	Go To Create Edm Page
	Delete Campaign By Mobile Prefix
	User Enter Campaign Name
	User Enter Mobile Prefix
	User Select Campaign Type As Static
	User Click Save Button
	Display Edm Edit Page
	Campaign Name Display Same As Input
	Status Should Be Disable
	User Enter Description
	User Click Save Button
	User Press Accept Alert
	URL Display Save Data Success
	Open MNP Mobile Landing Page Preview
	Display Preview Landing Page Mobile

TC5 - 5.1 No content landing page should be no content
	[Tags]  TC1.1  create_landing   web   ready  no_content
	Delete Campaign By Web Prefix
	Open MNP Web Landing Page No Cache
	Display Landing Page Desktop No Content


TC5 - 5.2 Set Disable Landing Page should be no content
	[Tags]   TC1.2  create_landing  web   ready   no_content
	Login Pcms
	Go To EDM Page
	Go To Create Edm Page
	Delete Campaign By Web Prefix
	User Enter Campaign Name
	User Enter Web Prefix
	User Select Campaign Type As Static
	User Click Save Button
	Display Edm Edit Page
	Campaign Name Display Same As Input
	Status Should Be Disable
	User Enter Description
	User Select Status As Disable
	User Click Save Button
	User Press Accept Alert
	Open MNP Web Landing Page No Cache
	Display Landing Page Desktop No Content

