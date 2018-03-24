*** Settings ***
Resource        ${CURDIR}/../../../../Keyword/Portal/wemall-mobile/login/webelement_login.robot

*** Keywords ***
WM Mobile Login - Display Login Page
	Wait Until Page Contains Element    ${wm_m_login_submit_btn}   20
    Page Should Contain Element         ${wm_m_login_submit_btn}


WM Mobile Login - Click Register Button
	Wait Until Page Contains Element    ${wm_m_regis_btn}   20
    Page Should Contain Element         ${wm_m_regis_btn}
