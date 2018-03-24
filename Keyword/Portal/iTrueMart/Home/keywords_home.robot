*** Settings ***
Library    Selenium2Library

*** Keywords ***
Home - Open Browser Itruemart
	Open Browser    ${ITM_URL}    ${BROWSER}

Home - Go To Itruemart En
	Go To    ${ITM_URL}/en
