*** Keywords ***
Truemoveh Order Report - Go To Order Report
	[Arguments]   ${order_id}
	Go To    ${PCMS_URL}/truemoveh/verify?pcms_order_id=${order_id}

Truemoveh Order Report - User Click Approve Button
	Wait Until Element Is Visible   id=confirm-approve   30s
	Click Element   id=confirm-approve

Truemoveh Order Report - User Click Confirm
	Wait Until Element Is Visible    //button/span[text()="OK"]   30s
	Click Element    //button/span[text()="OK"]
	Sleep  2s