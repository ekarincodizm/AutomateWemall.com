*** Settings ***
Library           Selenium2Library
Resource          ${CURDIR}/../../../../Keyword/Portal/iTrueMart/Everyday_wow/web_element_everyday_wow.robot

*** Keywords ***
Open ITM Everyday Wow Page
	[Arguments]  ${lang}=th
	Run Keyword If   '${lang}'=='th'   Open Browser   ${ITM_URL}/everyday-wow   ${BROWSER}
	 ...      ELSE   Open Browser   ${ITM_URL}/${lang}/everyday-wow   ${BROWSER}

Display Everyday Wow Page
	Wait Until Element Is Visible   ${wow_wrapper}
	Element Should Be Visible       ${wow_wrapper}