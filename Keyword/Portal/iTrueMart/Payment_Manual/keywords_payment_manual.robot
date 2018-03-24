*** Settings ***
Resource        ${CURDIR}/../../../../Keyword/Portal/iTrueMart/Payment_Manual/web_element_payment_manual.robot

*** Keywords ***
Display Payment Manual Page
	Wait Until Element Is Visible   ${manual_container}
	Element Should Be Visible       ${manual_container}

Select Payment Manual Page
	[Arguments]   ${lang}=th   ${URL}=${ITM_URL}
	Run Keyword If  '${lang}'=='th'  Select Window  url=${URL}/payment-manual
	 ...      ELSE  Select Window   url=${URL}/${lang}/payment-manual
