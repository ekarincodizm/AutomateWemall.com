*** Settings ***
Library    Selenium2Library
Library    HttpLibrary.HTTP

# Suite Setup    Run Keywords    Open Browser  http://www    Click      xxxxx
# Suite Teardown  xx
# Test Setup    xxx
# Test Teardown   xxxx


*** Test Cases ***
TC_iTM_00211 First Test Case

	Log To Console   First Test Case

	${r}=   Plus Number  1  2
	#${expect}=   Set Variable  3
	Should Be Equal As Integers   ${r}   ${expect}
	[Teardown]    xxxx

Test Open Browser
	[Tags]   calculate  regression
	Open Browser    http://www.calculateforfree.com/   Chrome
	Click Element   name=calc1
	Click Element   name=plus
	Click Element   name=calc2
	Click Element   name=equal
	${answer}=   Get Value    name=answer
	Should Be Equal As Integers   ${answer}   3

Test Open PCMS
	[Tags]  pcms   regression
	Open Browser    http://pcms.itruemart-dev.com   Chrome

	Input Text   name=email     admin@domain.com
	Input Text   name=password    12345
	Click Element    //input[@value="Login"]
	#Location Should Contain    #logged_in

Test Open iTRuemart
	[Tags]   itruemart
	Open Browser   http://www.itruemart-dev.com    Chrome

	Wait Until Element Is Visible   //span[@class="icon-user"]    60s
	Element Should Be Visible    //span[@class="icon-user"]

Test API
	[Tags]   API
	Create Http Context   pcms.itruemart-dev.com    http
	GET   /api/45311375168544/collections?limit=1
	${status}=  Get Response Status
	Log to console   ${status}
	${body}=   Get Response Body
	${code}=   Get Json Value   ${body}   /code
	Log To console   ${code}

	#Should Be Equal As Strings   ${code}

	${pkey}=   Get Json Value   ${body}   /data/0/pkey
	#${L}=   Get Length   ${data}
	#og to console   ${L}
	Log to console   pkey=${pkey}
	Should Be Equal As Integers  ${pkey}    3778827517882


Test Open New Tab
	[Tags]   open_new_tab
	Open Browser   http://www.google.co.th   Chrome
	Open New Tab    http://www.wemall.com



*** Variables ***
${expect}   3

*** Keywords ***
Open New Tab
	[Arguments]   ${url}
	Execute JavaScript    window.open('${url}', 'New Tab');

Plus Number
	[Arguments]  ${n1}  ${n2}
	${result}=  Evaluate   ${n1} + ${n2}

	[Return]   ${result}



