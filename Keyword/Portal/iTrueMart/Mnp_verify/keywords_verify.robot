*** Settings
Resource   ${CURDIR}/web_element_mnp_verify.robot
Resource   ${CURDIR}/../../../../Resource/TestData/Mnp/verify_test_data.robot

*** Keyword ***

User Enter Mobile No
	[Arguments]  ${mobile_no}
	Wait Until Element Is Visible  ${XPATH_VERIFY.txt_mobile}  20s
	Input Text  ${XPATH_VERIFY.txt_mobile}  ${mobile_no}

User Enter Id Card
	[Arguments]  ${idcard}
	Wait Until Element Is Visible   ${XPATH_VERIFY.txt_thai_id}  30s
	Input Text  ${XPATH_VERIFY.txt_thai_id}  ${idcard}


User Select Valid Birthdate
	# ${valid-year}=   Get Valid Year
	# ${month}=   Get Valid Month
	# ${valid-day}=   Get Valid Day

	# ${valid-thai-month}=  Get From Dictionary  ${FULL_THAI_MONTH}  ${month}
	# Execute Javascript   document.getElementById('birthDate').value='${valid-day} ${valid-thai-month} ${valid-year}'
	Wait Until Element Is Visible  ${XPATH_VERIFY.txt_birth_date}  10s
	Click Element   ${XPATH_VERIFY.txt_birth_date}
    Wait Until Element Is Visible   ${XPATH_VERIFY.cld_birth_date}
    Sleep   0.5s
    #Click Element   ${XPATH_VERIFY.cld_select_birth_day}/td[${MNP_REGISTER.SAMPLE_DATA.cld_birth_day}]
    Click Element  ${XPATH_VERIFY.cld_select_birth_day}/td[${DATA_MNP.VERIFY_SAMPLE_DATA.cld_birth_day}]
    Sleep   0.5s


User Click Verify Button
	Wait Until Element Is Visible   ${XPATH_VERIFY.btn_verify}    30s
	Click Element  ${XPATH_VERIFY.btn_verify}

User Click Link Next Operate
	Wait Until Element Is Visible  ${XPATH_VERIFY.btn_verify_register}   30s
	Click Element   ${XPATH_VERIFY.btn_verify_register}

