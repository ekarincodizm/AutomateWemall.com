*** Settings ***
Library             Selenium2Library

*** Keywords ***
Open WM Everyday Wow Page
	[Arguments]  ${lang}=th
	Run Keyword If   '${lang}'=='th'   Open Browser   ${WEMALL_URL}/everyday-wow   ${BROWSER}
	 ...      ELSE   Open Browser   ${WEMALL_URL}/${lang}/everyday-wow   ${BROWSER}