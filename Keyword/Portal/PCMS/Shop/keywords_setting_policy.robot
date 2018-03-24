*** Settings ***
Resource   web_element_setting_policy.robot

*** Keywords ***
Display Shop Setting Policy
	Location Should Contain   /policy-maps/shop

Display New Shop Setting Policy
	Display Shop Setting Policy
	Display Setting Policy Blank Form

Display Save Button In Setting Policy
	Wait Until Element Is Visible   ${setting_policy.btn_save}   20
	Element Should Be Visible       ${setting_policy.btn_save}

Display Shop Code And Shop Name As Readonly
	Wait Until Element Is Visible   ${setting_policy.txt_shop_code}   20
	Wait Until Element Is Visible   ${setting_policy.txt_shop_name}   20
	${r_shop_code}=  Selenium2Library.Get Element Attribute   ${setting_policy.txt_shop_code}@readonly
	${r_shop_name}=  Selenium2Library.Get Element Attribute   ${setting_policy.txt_shop_name}@readonly
	Should Be Equal   '${r_shop_code}'   'true'
	Should Be Equal   '${r_shop_name}'   'true'

Display Correct Shop Code And Shop Name In Setting Policy
	[Arguments]  ${shop_code}  ${shop_name}
	Wait Until Element Is Visible   ${setting_policy.txt_shop_code}   20
	Wait Until Element Is Visible   ${setting_policy.txt_shop_name}   20
	${txt_shop_code}=    Get Value   ${setting_policy.txt_shop_code}
	${txt_shop_name}=    Get Value   ${setting_policy.txt_shop_name}
	Should Be Equal   '${shop_code}'   '${txt_shop_code}'
	Should Be Equal   '${shop_name}'   '${txt_shop_name}'

Display Setting Policy Blank Form
	Wait Until Element Is Visible   ${setting_policy.txt_shop_code}          20
	Wait Until Element Is Visible   ${setting_policy.txt_shop_name}          20
	Wait Until Element Is Visible   ${setting_policy.txt_delivery_min_day}   20
	Wait Until Element Is Visible   ${setting_policy.txt_delivery_max_day}   20
	Wait Until Element Is Visible   ${setting_policy.txt_th_delivery_title}     20
	Wait Until Element Is Visible   ${setting_policy.txt_th_return_title}       20
	Wait Until Element Is Visible   ${setting_policy.txt_th_refund_title}       20
	Wait Until Element Is Visible   ${setting_policy.txt_us_delivery_title}     20
	Wait Until Element Is Visible   ${setting_policy.txt_us_return_title}       20
	Wait Until Element Is Visible   ${setting_policy.txt_us_refund_title}       20
	Wait Until Element Is Visible   ${setting_policy.txt_th_delivery_detail}    20
	Wait Until Element Is Visible   ${setting_policy.txt_th_return_detail}      20
	Wait Until Element Is Visible   ${setting_policy.txt_th_refund_detail}      20
	Wait Until Element Is Visible   ${setting_policy.txt_us_delivery_detail}    20
	Wait Until Element Is Visible   ${setting_policy.txt_us_return_detail}      20
	Wait Until Element Is Visible   ${setting_policy.txt_us_refund_detail}      20

	${delivery_min}=      Get Text   ${setting_policy.txt_delivery_min_day}
	${delivery_max}=      Get Text   ${setting_policy.txt_delivery_max_day}
	${delivery_th_title}=    Get Text   ${setting_policy.txt_th_delivery_title}
	${return_th_title}=      Get Text   ${setting_policy.txt_th_return_title}
	${refund_th_title}=      Get Text   ${setting_policy.txt_th_refund_title}
	${delivery_us_title}=    Get Text   ${setting_policy.txt_us_delivery_title}
	${return_us_title}=      Get Text   ${setting_policy.txt_us_return_title}
	${refund_us_title}=      Get Text   ${setting_policy.txt_us_refund_title}
	${delivery_th_detail}=   Get Text From CKEditor   ${setting_policy.txt_th_delivery_detail}
	${return_th_detail}=     Get Text From CKEditor   ${setting_policy.txt_th_return_detail}
	${refund_th_detail}=     Get Text From CKEditor   ${setting_policy.txt_th_refund_detail}
	${delivery_us_detail}=   Get Text From CKEditor   ${setting_policy.txt_us_delivery_detail}
	${return_us_detail}=     Get Text From CKEditor   ${setting_policy.txt_us_return_detail}
	${refund_us_detail}=     Get Text From CKEditor   ${setting_policy.txt_us_refund_detail}

	Should Be Equal       ${delivery_min}             ${EMPTY}
	Should Be Equal       ${delivery_max}             ${EMPTY}
	Should Be Equal       ${delivery_th_title}        ${EMPTY}
	Should Be Equal       ${return_th_title}          ${EMPTY}
	Should Be Equal       ${refund_th_title}          ${EMPTY}
	Should Be Equal       ${delivery_us_title}        ${EMPTY}
	Should Be Equal       ${return_us_title}          ${EMPTY}
	Should Be Equal       ${refund_us_title}          ${EMPTY}
	Should Be Equal       ${delivery_th_detail}       ${EMPTY}
	Should Be Equal       ${return_th_detail}         ${EMPTY}
	Should Be Equal       ${refund_th_detail}         ${EMPTY}
	Should Be Equal       ${delivery_us_detail}       ${EMPTY}
	Should Be Equal       ${return_us_detail}         ${EMPTY}
	Should Be Equal       ${refund_us_detail}         ${EMPTY}

Display Setting Policy Error: Delivery Time Min Is Zero
	Wait Until Element Is Visible   ${setting_policy.dialog_err}     20
	Wait Until Element Is Visible   ${setting_policy.dialog_err}/p   20
	Element Should Be Visible       ${setting_policy.dialog_err}/p[contains(text(),"${setting_policy_msg.err_delivery_min_zero}")]

Display Setting Policy Error: Delivery Time Max Is Zero
	Wait Until Element Is Visible   ${setting_policy.dialog_err}      20
	Wait Until Element Is Visible   ${setting_policy.dialog_err}/p    20
	Element Should Be Visible       ${setting_policy.dialog_err}/p[contains(text(),"${setting_policy_msg.err_delivery_max_zero}")]

Display Setting Policy Error: Delivery Time Min Is More Than Delivery Time Max
	Wait Until Element Is Visible   ${setting_policy.dialog_err}      20
	Wait Until Element Is Visible   ${setting_policy.dialog_err}/p    20
	Element Should Be Visible       ${setting_policy.dialog_err}/p[contains(text(),"${setting_policy_msg.err_max_lt_min}")]

Display Setting Policy Error: TH Deliver Policy Detail Is Required
	Wait Until Element Is Visible   ${setting_policy.dialog_err}      20
	Wait Until Element Is Visible   ${setting_policy.dialog_err}/p    20
	Element Should Be Visible       ${setting_policy.dialog_err}/p[contains(text(),"${setting_policy_msg.err_delivery_policy_req}")]

Display Setting Policy Error: TH Return Policy Detail Is Required
	Wait Until Element Is Visible   ${setting_policy.dialog_err}      20
	Wait Until Element Is Visible   ${setting_policy.dialog_err}/p    20
	Element Should Be Visible       ${setting_policy.dialog_err}/p[contains(text(),"${setting_policy_msg.err_return_policy_req}")]

Display Setting Policy Error: TH Refund Policy Detail Is Required
	Wait Until Element Is Visible   ${setting_policy.dialog_err}      20
	Wait Until Element Is Visible   ${setting_policy.dialog_err}/p    20
	Element Should Be Visible       ${setting_policy.dialog_err}/p[contains(text(),"${setting_policy_msg.err_refund_policy_req}")]

Display Setting Policy Success
	Wait Until Element Is Visible   ${setting_policy.dialog_success}      20
	Wait Until Element Is Visible   ${setting_policy.dialog_success}/p    20
	Element Should Be Visible       ${setting_policy.dialog_success}/p[contains(text(),"${setting_policy_msg.success_create}")]

Not Display Setting Policy Success
	Wait Until Element Is Not Visible   ${setting_policy.dialog_success}      20
	Wait Until Element Is Not Visible   ${setting_policy.dialog_success}/p    20
	Element Should Not Be Visible       ${setting_policy.dialog_success}/p[contains(text(),"${setting_policy_msg.success_create}")]

Fill Data In Setting Policy Form: Delivery Time
	[Arguments]  ${delivery_min}=1  ${delivery_max}=7
	Wait Until Element Is Visible   ${setting_policy.txt_delivery_min_day}   ${delivery_min}
	Wait Until Element Is Visible   ${setting_policy.txt_delivery_max_day}   ${delivery_max}
	Input Text   ${setting_policy.txt_delivery_min_day}   ${delivery_min}
	Input Text   ${setting_policy.txt_delivery_max_day}   ${delivery_max}

Fill Data In Setting Policy Form: TH Policy
	[Arguments]
	 ...  ${delivery_title}=Robot_th_delivery_title
	 ...  ${return_title}=Robot_th_return_title
	 ...  ${refund_title}=Robot_th_refund_title
	 ...  ${delivery_detail}=Robot_th_delivery_detail
	 ...  ${return_detail}=Robot_th_return_detai
	 ...  ${refund_detail}=Robot_th_refund_detai

	Wait Until Element Is Visible   ${setting_policy.txt_th_delivery_title}     20
	Wait Until Element Is Visible   ${setting_policy.txt_th_return_title}       20
	Wait Until Element Is Visible   ${setting_policy.txt_th_refund_title}       20
	Wait Until Element Is Visible   ${setting_policy.txt_th_delivery_detail}    20
	Wait Until Element Is Visible   ${setting_policy.txt_th_return_detail}      20
	Wait Until Element Is Visible   ${setting_policy.txt_th_refund_detail}      20

	Input Text   ${setting_policy.txt_th_delivery_title}     ${delivery_title}
	Input Text   ${setting_policy.txt_th_return_title}       ${return_title}
	Input Text   ${setting_policy.txt_th_refund_title}       ${refund_title}
	Input Text To CKEditor   ${setting_policy.txt_th_delivery_detail}    ${delivery_detail}
	Input Text To CKEditor   ${setting_policy.txt_th_return_detail}      ${return_detail}
	Input Text To CKEditor   ${setting_policy.txt_th_refund_detail}      ${refund_detail}

Fill Data In Setting Policy Form: EN Policy
	[Arguments]
	 ...  ${delivery_title}=Robot_us_delivery_title
	 ...  ${return_title}=Robot_us_return_title
	 ...  ${refund_title}=Robot_us_refund_title
	 ...  ${delivery_detail}=Robot_us_delivery_detail
	 ...  ${return_detail}=Robot_us_return_detail
	 ...  ${refund_detail}=Robot_us_refund_detail

	Wait Until Element Is Visible   ${setting_policy.txt_us_delivery_title}     20
	Wait Until Element Is Visible   ${setting_policy.txt_us_return_title}       20
	Wait Until Element Is Visible   ${setting_policy.txt_us_refund_title}       20
	Wait Until Element Is Visible   ${setting_policy.txt_us_delivery_detail}    20
	Wait Until Element Is Visible   ${setting_policy.txt_us_return_detail}      20
	Wait Until Element Is Visible   ${setting_policy.txt_us_refund_detail}      20

	Input Text   ${setting_policy.txt_us_delivery_title}     ${delivery_title}
	Input Text   ${setting_policy.txt_us_return_title}       ${return_title}
	Input Text   ${setting_policy.txt_us_refund_title}       ${refund_title}
	Input Text To CKEditor   ${setting_policy.txt_us_delivery_detail}    ${delivery_detail}
	Input Text To CKEditor   ${setting_policy.txt_us_return_detail}      ${return_detail}
	Input Text To CKEditor   ${setting_policy.txt_us_refund_detail}      ${refund_detail}

Display Data In Setting Policy Form: Delivery Time As Input
	[Arguments]  ${ex_delivery_min}=1  ${ex_delivery_max}=7
	Wait Until Element Is Visible   ${setting_policy.txt_delivery_min_day}   20
	Wait Until Element Is Visible   ${setting_policy.txt_delivery_max_day}   20

	${delivery_min}=      Get Value   ${setting_policy.txt_delivery_min_day}
	${delivery_max}=      Get Value   ${setting_policy.txt_delivery_max_day}

	Should Be Equal       '${delivery_min}'             '${ex_delivery_min}'
	Should Be Equal       '${delivery_max}'             '${ex_delivery_max}'

Display Data In Setting Policy Form: TH Policy As Input
	[Arguments]
	 ...  ${delivery_title}=Robot_th_delivery_title
	 ...  ${return_title}=Robot_th_return_title
	 ...  ${refund_title}=Robot_th_refund_title
	 ...  ${delivery_detail}=Robot_th_delivery_detail
	 ...  ${return_detail}=Robot_th_return_detail
	 ...  ${refund_detail}=Robot_th_refund_detail

	Wait Until Element Is Visible   ${setting_policy.txt_th_delivery_title}     20
	Wait Until Element Is Visible   ${setting_policy.txt_th_return_title}       20
	Wait Until Element Is Visible   ${setting_policy.txt_th_refund_title}       20
	Wait Until Element Is Visible   ${setting_policy.txt_th_delivery_detail}    20
	Wait Until Element Is Visible   ${setting_policy.txt_th_return_detail}      20
	Wait Until Element Is Visible   ${setting_policy.txt_th_refund_detail}      20

	${delivery_th_title}=    Get Value   ${setting_policy.txt_th_delivery_title}
	${return_th_title}=      Get Value   ${setting_policy.txt_th_return_title}
	${refund_th_title}=      Get Value   ${setting_policy.txt_th_refund_title}
	${delivery_th_detail}=   Get Text From CKEditor   ${setting_policy.txt_th_delivery_detail}
	${return_th_detail}=     Get Text From CKEditor   ${setting_policy.txt_th_return_detail}
	${refund_th_detail}=     Get Text From CKEditor   ${setting_policy.txt_th_refund_detail}

	Should Be Equal       '${delivery_th_title}'        '${delivery_title}'
	Should Be Equal       '${return_th_title}'          '${return_title}'
	Should Be Equal       '${refund_th_title}'          '${refund_title}'
	Should Be Equal       '${delivery_th_detail}'       '${delivery_detail}'
	Should Be Equal       '${return_th_detail}'         '${return_detail}'
	Should Be Equal       '${refund_th_detail}'         '${refund_detail}'

Display Data In Setting Policy Form: EN Policy As Input
	[Arguments]
	 ...  ${delivery_title}=Robot_us_delivery_title
	 ...  ${return_title}=Robot_us_return_title
	 ...  ${refund_title}=Robot_us_refund_title
	 ...  ${delivery_detail}=Robot_us_delivery_detail
	 ...  ${return_detail}=Robot_us_return_detail
	 ...  ${refund_detail}=Robot_us_refund_detail

	Wait Until Element Is Visible   ${setting_policy.txt_us_delivery_title}     20
	Wait Until Element Is Visible   ${setting_policy.txt_us_return_title}       20
	Wait Until Element Is Visible   ${setting_policy.txt_us_refund_title}       20
	Wait Until Element Is Visible   ${setting_policy.txt_us_delivery_detail}    20
	Wait Until Element Is Visible   ${setting_policy.txt_us_return_detail}      20
	Wait Until Element Is Visible   ${setting_policy.txt_us_refund_detail}      20

	${delivery_us_title}=    Get Value   ${setting_policy.txt_us_delivery_title}
	${return_us_title}=      Get Value   ${setting_policy.txt_us_return_title}
	${refund_us_title}=      Get Value   ${setting_policy.txt_us_refund_title}
	${delivery_us_detail}=   Get Text From CKEditor   ${setting_policy.txt_us_delivery_detail}
	${return_us_detail}=     Get Text From CKEditor   ${setting_policy.txt_us_return_detail}
	${refund_us_detail}=     Get Text From CKEditor   ${setting_policy.txt_us_refund_detail}

	Should Be Equal       '${delivery_us_title}'        '${delivery_title}'
	Should Be Equal       '${return_us_title}'          '${return_title}'
	Should Be Equal       '${refund_us_title}'          '${refund_title}'
	Should Be Equal       '${delivery_us_detail}'       '${delivery_detail}'
	Should Be Equal       '${return_us_detail}'         '${return_detail}'
	Should Be Equal       '${refund_us_detail}'         '${refund_detail}'

#Click Save Button In Setting Policy
Setting Policy - User Click Save Button
	Wait Until Element Is Visible   ${setting_policy.btn_save}   20
	Click Element                   ${setting_policy.btn_save}

Setting Policy - User Enter Delivery Min
	[Arguments]   ${delivery_min}
	Wait Until Element Is Visible   ${setting_policy.txt_delivery_min_day}   10s
	Input Text   ${setting_policy.txt_delivery_min_day}   ${delivery_min}


Setting Policy - User Enter Delivery Max
	[Arguments]   ${delivery_max}
	Wait Until Element Is Visible   ${setting_policy.txt_delivery_max_day}   10s
	Input Text   ${setting_policy.txt_delivery_max_day}   ${delivery_max}

Setting Policy - User Enter Delivery Policy Title Thai
	[Arguments]   ${delivery_policy_thai}
	Wait Until Element Is Visible  ${setting_policy.txt_th_delivery_title}   10s
	Input Text    ${setting_policy.txt_th_delivery_title}   ${delivery_policy_thai}

Setting Policy - User Enter Delivery Policy Detail Thai
	[Arguments]   ${delivery_policy_thai}
	Wait Until Element Is Visible  ${setting_policy.txt_th_delivery_detail}   10s
	Input Text To CKEditor    ${setting_policy.txt_th_delivery_detail}   ${delivery_policy_thai}

Setting Policy - User Enter Return Policy Title Thai
	[Arguments]   ${return_policy}
	Wait Until Element Is Visible  ${setting_policy.txt_th_return_title}   10s
	Input Text    ${setting_policy.txt_th_return_title}   ${return_policy}

Setting Policy - User Enter Return Policy Detail Thai
	[Arguments]   ${return_policy}
	Wait Until Element Is Visible  ${setting_policy.txt_th_return_detail}   10s
	Input Text To CKEditor    ${setting_policy.txt_th_return_detail}   ${return_policy}
x`
Setting Policy - User Enter Refund Policy Title Thai
	[Arguments]   ${refund_policy}
	Wait Until Element Is Visible  ${setting_policy.txt_th_refund_title}   10s
	Input Text    ${setting_policy.txt_th_refund_title}   ${refund_policy}

Setting Policy - User Enter Refund Policy Detail Thai
	[Arguments]   ${refund_policy}
	Wait Until Element Is Visible  ${setting_policy.txt_th_refund_detail}   10s
	Input Text To CKEditor    ${setting_policy.txt_th_refund_detail}   ${refund_policy}

###########
Setting Policy - User Enter Delivery Policy Title English
	[Arguments]   ${delivery_policy}
	Wait Until Element Is Visible  ${setting_policy.txt_us_delivery_title}   10s
	Input Text    ${setting_policy.txt_us_delivery_title}   ${delivery_policy}

Setting Policy - User Enter Delivery Policy Detail English
	[Arguments]   ${delivery_policy}
	Wait Until Element Is Visible  ${setting_policy.txt_us_delivery_detail}   10s
	Input Text To CKEditor    ${setting_policy.txt_us_delivery_detail}   ${delivery_policy}

Setting Policy - User Enter Return Policy Title English
	[Arguments]   ${return_policy}
	Wait Until Element Is Visible  ${setting_policy.txt_us_return_title}   10s
	Input Text    ${setting_policy.txt_us_return_title}   ${return_policy}

Setting Policy - User Enter Return Policy Detail English
	[Arguments]   ${return_policy}
	Wait Until Element Is Visible  ${setting_policy.txt_us_return_detail}   10s
	Input Text To CKEditor    ${setting_policy.txt_us_return_detail}   ${return_policy}

Setting Policy - User Enter Refund Policy Title English
	[Arguments]   ${refund_policy}
	Wait Until Element Is Visible  ${setting_policy.txt_us_refund_title}   10s
	Input Text    ${setting_policy.txt_us_refund_title}   ${refund_policy}

Setting Policy - User Enter Refund Policy Detail English
	[Arguments]   ${refund_policy}
	Wait Until Element Is Visible  ${setting_policy.txt_us_refund_detail}  10s
	Input Text To CKEditor    ${setting_policy.txt_us_refund_detail}   ${refund_policy}

Setting Policy - Display Error Message
	Wait Until Element Is Visible  ${setting_policy.dialog_err}   10s
	Element Should Be Visible   ${setting_policy.dialog_err}

Setting Policy - Error Message Contains Delivery And Return And Refund Policy Is Required
	Wait Until Element Is Visible   ${setting_policy.dialog_err}    10s

	Element Should Contain  ${setting_policy.dialog_err}/p[1]
	Element Should Contain  ${setting_policy.dialog_err}/p[2]   ${setting_policy_msg.err_return_policy_req}
	Element Should Contain  ${setting_policy.dialog_err}/p[3]   ${setting_policy_msg.err_refund_policy_req}


Setting Policy - Error Message Contains Return And Refund Policy Is Required
	Wait Until Element Is Visible   ${setting_policy.dialog_err}    10s
	Element Should Contain  ${setting_policy.dialog_err}/p[1]   ${setting_policy_msg.err_return_policy_req}
	Element Should Contain  ${setting_policy.dialog_err}/p[2]   ${setting_policy_msg.err_refund_policy_req}

Setting Policy - Error Message Contains Delivery And Refund Policy Is Required
	Wait Until Element Is Visible  ${setting_policy.dialog_err}   10s
	Element Should Contain  ${setting_policy.dialog_err}/p[1]  ${setting_policy_msg.err_delivery_policy_req}
	Element Should Contain  ${setting_policy.dialog_err}/p[2]  ${setting_policy_msg.err_refund_policy_req}



Setting Policy - Error Message Contains Delivery Policy Is Required
	Wait Until Element Is Visible  ${setting_policy.dialog_err}/p[1]  10s
	Element Should Contain  ${setting_policy.dialog_err}  ${setting_policy_msg.err_delivery_policy_req}

Setting Policy - Error Message Contains Return Policy Is Required
	Wait Until Element Is Visible  ${setting_policy.dialog_err}/p[1]  10s
	Element Should Contain  ${setting_policy.dialog_err}  ${setting_policy_msg.err_return_policy_req}

Setting Policy - Error Message Contains Refund Policy Is Required
	Wait Until Element Is Visible  ${setting_policy.dialog_err}/p[1]   10s
	Element Should Contain  ${setting_policy.dialog_err}  ${setting_policy_msg.err_refund_policy_req}





