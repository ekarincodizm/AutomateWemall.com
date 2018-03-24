*** Settings ***
Resource    ${CURDIR}/web_element_policy.robot

*** Keywords ***
Expect Policy Content
    [Arguments]    ${policy_content}
    ${actual_policy_content}=    Get Text    //div[@id="wrapper_content"]/div[@class="content"]
    Log To Console    Actual Text=${actual_policy_content}
    Should Be Equal As Strings    ${policy_content}    ${actual_policy_content}

Policy - Select Return Policy Page
	[Arguments]   ${lang}=th   ${URL}=${ITM_URL}
	Run Keyword If  '${lang}'=='th'  Select Window  url=${URL}${return_policy_uri}
	 ...      ELSE  Select Window   url=${URL}/${lang}${return_policy_uri}

Policy - Select Delivery Policy Page
	[Arguments]   ${lang}=th   ${URL}=${ITM_URL}
	Run Keyword If  '${lang}'=='th'  Select Window  url=${URL}${delivery_policy_uri}
	 ...      ELSE  Select Window   url=${URL}/${lang}${delivery_policy_uri}

Policy - Select Money Back Policy Page
	[Arguments]   ${lang}=th   ${URL}=${ITM_URL}
	Run Keyword If  '${lang}'=='th'  Select Window  url=${URL}${moneyback_policy_uri}
	 ...      ELSE  Select Window   url=${URL}/${lang}${moneyback_policy_uri}

Policy - Display Policy Page
	Wait Until Page Contains Element   ${POLICY.txt_content}   60
	Element Should Be Visible       ${POLICY.txt_content}
