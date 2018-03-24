*** Settings ***
Resource        ${CURDIR}/../../../../Keyword/Portal/wemall-mobile/portal/webelement_portal.robot

*** Keywords ***
WM Mobile Portal - Click Switch Language To EN
	Wait Until Element Is Visible       ${wm_m_menu}   20
    Click Element                       ${wm_m_menu}
	Wait Until Element Is Visible       ${wm_m_en}   20
	Click Element                       ${wm_m_en}

WM Mobile Portal - Click Menu To Login
	Wait Until Element Is Visible       ${wm_m_menu}   20
    Click Element                       ${wm_m_menu}
	Wait Until Element Is Visible       ${wm_m_login_btn}   20
	Click Element                       ${wm_m_login_btn}

WM Mobile Portal - Click Menu To Register
	Wait Until Element Is Visible       ${wm_m_menu}   20
    Click Element                       ${wm_m_menu}
	Wait Until Element Is Visible       ${wm_m_regis_btn}   20
	Click Element                       ${wm_m_regis_btn}

WM Mobile Portal - Display Header And Footer
	Wait Until Page Contains Element    ${wm_m_header}   20
	Wait Until Page Contains Element    ${wm_m_footer}   20
    Page Should Contain Element         ${wm_m_header}
    Page Should Contain Element         ${wm_m_footer}

WM Mobile Portal - Display Hilight Banner
	Wait Until Page Contains Element    ${wm_m_hilight_banner}   20
    Page Should Contain Element         ${wm_m_hilight_banner}

WM Mobile Portal - Display Showroom
	Wait Until Page Contains Element    ${wm_m_showroom}   20
    Page Should Contain Element         ${wm_m_showroom}

