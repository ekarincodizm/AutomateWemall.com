*** Settings ***
Library   ${CURDIR}/../../../Python_Library/message.py


*** Keywords ***
Email Has Been Sent To Customer Success
	[Arguments]   ${email}
	Get Email From Message   ${email}

