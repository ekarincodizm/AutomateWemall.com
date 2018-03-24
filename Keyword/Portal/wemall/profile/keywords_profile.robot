*** Settings ***
Resource    ${CURDIR}/web_elements_profile.robot

*** Keywords ***

Profile - Full Name Is Changed
	Selenium2Library.Wait Until Element Is Visible  ${XPATH_PROFILE.txt_full_name}   ${TIMEOUT}
	${full_name}=   Selenium2Library.Get Value    ${XPATH_PROFILE.txt_full_name}
	Should Be Equal As Strings    ${full_name}   ${TEST_VAR.full_name_edit}


Profile - Profile Page Is Displayed
	Selenium2Library.Location Should Contain   /member/profile
	Selenium2Library.Wait Until Element Is Visible   ${XPATH_PROFILE.lbl_header}   ${TIMEOUT}
	Selenium2Library.Page Should Contain Element   ${XPATH_PROFILE.lbl_header}

Profile - User Leave Blank Full Name
	Selenium2Library.Wait Until Element Is Visible   ${XPATH_PROFILE.txt_full_name}   ${TIMEOUT}
	Selenium2Library.Input Text    ${XPATH_PROFILE.txt_full_name}   ${EMPTY}

Profile - User Enter Full Name
	[Arguments]   ${full_name}
	Selenium2Library.Wait Until Element Is Visible   ${XPATH_PROFILE.txt_full_name}   ${TIMEOUT}
	Selenium2Library.Input Text    ${XPATH_PROFILE.txt_full_name}   ${full_name}

Profile - User Change Full Name
	Selenium2Library.Wait Until Element Is Visible   ${XPATH_PROFILE.txt_full_name}   ${TIMEOUT}
	${full_name}=   Selenium2Library.Get Value   ${XPATH_PROFILE.txt_full_name}
	Wemall Common - Assign Value To Test Variable   full_name  ${full_name}
	Wemall Common - Assign Value To Test Variable   full_name_edit   ${full_name}-edit-1
	Profile - User Enter Full Name   ${full_name}-edit-1

Profile - User Select Province
	[Arguments]  ${province_name}
	Selenium2Library.Wait Until Element Is Visible   ${XPATH_PROFILE.cbo_province}   ${TIMEOUT}
	Selenium2Library.Click Element    ${XPATH_PROFILE.cbo_province}/option[text()="${province_name}"]
	Selenium2Library.Wait Until Page Does Not Contain Element  ${XPATH_PROFILE.cbo_district}/option[@value="0"]  ${TIMEOUT}
	Selenium2Library.Wait Until Page Does Not Contain Element  ${XPATH_PROFILE.cbo_sub_district}/option[@value="0"]  ${TIMEOUT}

Profile - User Select First District
	Selenium2Library.Wait Until Page Contains Element   ${XPATH_PROFILE.cbo_district}/option[1]   ${TIMEOUT}
	Selenium2Library.Click Element  ${XPATH_PROFILE.cbo_district}/option[1]

Profile - User Select First Sub District
	Selenium2Library.Wait Until Page Contains Element   ${XPATH_PROFILE.cbo_sub_district}/option[1]  ${TIMEOUT}
	Selenium2Library.Click Element  ${XPATH_PROFILE.cbo_sub_district}/option[1]


Profile - User Enter Zipcode
	[Arguments]    ${zipcode}
	Selenium2Library.Wait Until Element Is Visible  ${XPATH_PROFILE.txt_zipcode}  ${TIMEOUT}
	Selenium2Library.Input Text   ${XPATH_PROFILE.txt_zipcode}   ${zipcode}

Profile - User Enter Address
	[Arguments]   ${address}
	Selenium2Library.Wait Until Element Is Visible  ${XPATH_PROFILE.txt_address}   ${TIMEOUT}
	Selenium2Library.Input Text   ${XPATH_PROFILE.txt_address}   ${address}

Profile - User Enter Mobile No
	[Arguments]   ${mobile_no}
	Selenium2Library.Wait Until Element Is Visible   ${XPATH_PROFILE.txt_mobile_no}   ${TIMEOUT}
	Selenium2Library.Input Text   ${XPATH_PROFILE.txt_mobile_no}   ${mobile_no}

Profile - User Enter Email
	[Arguments]   ${email}
	Selenium2Library.Wait Until Element Is Visible  ${XPATH_PROFILE.txt_email}   ${TIMEOUT}
	Selenium2Library.Input Text  ${XPATH_PROFILE.txt_email}   ${email}

Profile - User Click Save Button
	Selenium2Library.Wait Until Element Is Visible  ${XPATH_PROFILE.btn_save}   ${TIMEOUT}
	Selenium2Library.Click Element   ${XPATH_PROFILE.btn_save}


Profile - User Select Province As Bangkok
	Selenium2Library.Wait Until Element Is Visible   ${XPATH_PROFILE.cbo_province}   ${TIMEOUT}
	Selenium2Library.Click Element  ${XPATH_PROFILE.cbo_province}/option[text()="กรุงเทพมหานคร"]
	Selenium2Library.Wait Until Page Does Not Contain Element  ${XPATH_PROFILE.cbo_district}/option[@value="0"]  ${TIMEOUT}
	Selenium2Library.Wait Until Page Does Not Contain Element  ${XPATH_PROFILE.cbo_sub_district}/option[@value="0"]  ${TIMEOUT}

Profile - User Select District As Suanluang
	Selenium2Library.Wait Until Page Contains Element  ${XPATH_PROFILE.cbo_district}/option[text()="สวนหลวง"]  ${TIMEOUT}
	Selenium2Library.Click Element   ${XPATH_PROFILE.cbo_province}/option[text()="สวนหลวง"]

Profile - User Select Sub District As Suanluang
	Selenium2Library.Wait Until Page Contains Element   ${XPATH_PROFILE.cbo_sub_district}   ${TIMEOUT}
	Selenium2Library.Click Element   ${XPATH_PROFILE.cbo_sub_district}/option[text()="สวนหลวง"]

Profile - User Enter Zipcode As 10250
	Selenium2Library.Wait Until Page Contains Element   ${XPATH_PROFILE.txt_zipcode}  ${TIMEOUT}
	Selenium2Library.Input Text   ${XPATH_PROFILE.txt_zipcode}   10250

Profile - Error Full Name Required Is Displayed
	Selenium2Library.Wait Until Element Is Visible   ${XPATH_PROFILE.div_modal_content}  ${TIMEOUT}
	Selenium2Library.Wait Until Element Is Visible   ${XPATH_PROFILE.div_modal_body}   ${TIMEOUT}
	${message}=   Selenium2Library.Get Text   ${XPATH_PROFILE.div_modal_body}
	Should Be Equal As Strings   ${message}   ${MSG_PROFILE.full_name_is_required}

Profile - Error Province Required Is Displayed
	Selenium2Library.Wait Until Element Is Visible   ${XPATH_PROFILE.div_modal_content}  ${TIMEOUT}
	Selenium2Library.Wait Until Element Is Visible   ${XPATH_PROFILE.div_modal_body}   ${TIMEOUT}
	${message}=   Selenium2Library.Get Text   ${XPATH_PROFILE.div_modal_body}
	Should Be Equal As Strings   ${message}   ${MSG_PROFILE.province_is_required}

Profile - Error Address Required Is Displayed
	Selenium2Library.Wait Until Element Is Visible   ${XPATH_PROFILE.div_modal_content}  ${TIMEOUT}
	Selenium2Library.Wait Until Element Is Visible   ${XPATH_PROFILE.div_modal_body}   ${TIMEOUT}
	${message}=   Selenium2Library.Get Text   ${XPATH_PROFILE.div_modal_body}
	Should Be Equal As Strings   ${message}   ${MSG_PROFILE.address_is_required}

Profile - Error Zipcode Required Is Displayed
	Selenium2Library.Wait Until Element Is Visible   ${XPATH_PROFILE.div_modal_content}  ${TIMEOUT}
	Selenium2Library.Wait Until Element Is Visible   ${XPATH_PROFILE.div_modal_body}   ${TIMEOUT}
	${message}=   Selenium2Library.Get Text   ${XPATH_PROFILE.div_modal_body}
	Should Be Equal As Strings   ${message}   ${MSG_PROFILE.zipcode_is_required}

Profile - Error Mobile Required Is Displayed
	Selenium2Library.Wait Until Element Is Visible   ${XPATH_PROFILE.div_modal_content}  ${TIMEOUT}
	Selenium2Library.Wait Until Element Is Visible   ${XPATH_PROFILE.div_modal_body}   ${TIMEOUT}
	${message}=   Selenium2Library.Get Text   ${XPATH_PROFILE.div_modal_body}
	Should Be Equal As Strings   ${message}   ${MSG_PROFILE.mobile_is_required}

Profile - Error Email Required Is Displayed
	Selenium2Library.Wait Until Element Is Visible   ${XPATH_PROFILE.div_modal_content}  ${TIMEOUT}
	Selenium2Library.Wait Until Element Is Visible   ${XPATH_PROFILE.div_modal_body}   ${TIMEOUT}
	${message}=   Selenium2Library.Get Text   ${XPATH_PROFILE.div_modal_body}
	Should Be Equal As Strings   ${message}   ${MSG_PROFILE.email_is_required}


Profile - User Click Modal Ok Button
	Selenium2Library.Wait Until Element Is Visible   ${XPATH_PROFILE.div_modal_content}  ${TIMEOUT}
	Selenium2Library.Wait Until Element Is Visible   ${XPATH_PROFILE.div_modal_body}   ${TIMEOUT}
	Selenium2Library.Wait Until Element Is Visible   ${XPATH_PROFILE.btn_modal_ok}   ${TIMEOUT}

	Selenium2Library.Click Element  ${XPATH_PROFILE.btn_modal_ok}

Profile - Error Popup Is Closed
	Selenium2Library.Wait Until Element Is Not Visible  ${XPATH_PROFILE.div_modal_content}   ${TIMEOUT}
	Selenium2Library.Element Should Not Be Visible   ${XPATH_PROFILE.div_modal_content}

Profile - User Leave Blank Province
	Selenium2Library.Wait Until Element Is VIsible   ${XPATH_PROFILE.cbo_province}  ${TIMEOUT}
	Selenium2Library.Click Element   ${XPATH_PROFILE.cbo_province}/option[@value="0"]
	#Selenium2Library.Wait Until Page Does Not Contain Element  ${XPATH_PROFILE.cbo_district}/option[@value="0"]  ${TIMEOUT}
	#Selenium2Library.Wait Until Page Does Not Contain Element  ${XPATH_PROFILE.cbo_sub_district}/option[@value="0"]  ${TIMEOUT}

Profile - User Leave Blank Address
	Selenium2Library.Wait Until Element Is VIsible   ${XPATH_PROFILE.txt_address}  ${TIMEOUT}
	Selenium2Library.Input Text   ${XPATH_PROFILE.txt_address}   ${EMPTY}

Profile - User Leave Blank Zipcode
	Selenium2Library.Wait Until Element Is VIsible   ${XPATH_PROFILE.txt_zipcode}  ${TIMEOUT}
	Selenium2Library.Input Text   ${XPATH_PROFILE.txt_zipcode}   ${EMPTY}

Profile - User Leave Blank Mobile
	Selenium2Library.Wait Until Element Is VIsible   ${XPATH_PROFILE.txt_mobile_no}  ${TIMEOUT}
	Selenium2Library.Input Text   ${XPATH_PROFILE.txt_mobile_no}   ${EMPTY}

Profile - User Leave Blank Email
	Selenium2Library.Wait Until Element Is VIsible   ${XPATH_PROFILE.txt_email}  ${TIMEOUT}
	Selenium2Library.Input Text   ${XPATH_PROFILE.txt_email}   ${EMPTY}