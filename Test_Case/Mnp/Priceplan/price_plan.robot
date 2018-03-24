*** Settings ***
Library    Selenium2Library
Library    OperatingSystem
Library    HttpLibrary.HTTP
Library    DateTime
Library    Collections

Resource    ${CURDIR}/../../../Resource/init.robot
Resource	${CURDIR}/../../../Keyword/Database/PCMS/Truemove_h/keywords_truemove_h.robot
Resource	${CURDIR}/../../../Keyword/Portal/PCMS/Manage_Price_Plan/WebElement_Manage_PricePlan.robot
Resource    ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource    ${CURDIR}/../../../Keyword/API/PCMS/Bundle/keywords_prepare_bundle.robot
Resource    ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot

*** Test Cases ***

Bundle Lv D
	[Tags]	tc1
	# Prepare steps (create priceplan, create propo (bundle), create group propo, map device to group propo)
	# Open Lv.D to check is priceplan available ?

	Prepare TruemoveH Product Bundle On PCMS
	#Prepare TruemoveH Product Bundle On CAMP

	# ${product_pkey}=    Set Variable    2985383347942
	# Open Browser    http://www.itruemart.com/products/iphone-6s-${product_pkey}.html    ${BROWSER}

	# Wait Until Element is ready and click    //html/body/div[6]/div/div[2]/div/div[1]/div[2]/div[2]/ul/li[3]/div[2]/ul/li[1]/a/img    60

	# Wait Until Element is ready and click    //html/body/div[6]/div/div[2]/div/div[1]/div[2]/div[2]/ul/li[4]/div[2]/ul/li[1]/a    60


	# # Wait Until Element is Visible    //*[@id='mnp-device-tab']    60

	# # Click Element    //*[@id='mnp-device-tab']

	# Wait Until Element is Visible    //*[@id="bundle-package-information"]    60
	# Execute Javascript    document.getElementById('chatbar').style.display = 'none';
	# Click Element    //*[@id="bundle-package-information"]

	# Sleep    5s

	[Teardown]    Close Browser
	#Delete TruemoveH Product Bundle On PCMS