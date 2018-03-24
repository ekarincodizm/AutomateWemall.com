*** Settings ***
Resource          web_element_common.robot
Resource          ${CURDIR}/../../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Self_Service/Main_form/keywords_main_form.robot

*** Keywords ***
#SS Mobile Common - Display Live Chat Button
#    Wait Until Element Is Visible           ${Live_Chat_Btn}            15s
#    Element Should Be Visible               ${Live_Chat_Btn}
#
#SS Mobile Common - Click Live Chat Button
#    Wait Until Element Is Visible           ${Live_Chat_Btn}            15s
#    Sleep                                   5s
#    Click Element                           ${Live_Chat_Btn}
#
SS Mobile Common - Display Check Success Button
    Wait Until Element Is Visible           ${SS_Btn_SSsuccess}            15s
    Element Should Be Visible               ${SS_Btn_SSsuccess}

#SS Mobile Common - Display Submit Button
#    Wait Until Element Is Visible           ${SS_Btn_SSsubmit}            15s
#    Element Should Be Visible               ${SS_Btn_SSsubmit}

SS Mobile Common - Display Other Question Button
    Wait Until Element Is Visible           ${SS_Btn_SSOtherQ}            15s
    Element Should Be Visible               ${SS_Btn_SSOtherQ}

SS Mobile Common - Display Back Button
    Wait Until Element Is Visible           ${SS_Btn_SSback}            15s
    Element Should Be Visible               ${SS_Btn_SSback}

#SS Mobile Common - [Modal] Do not display Success Button
#    Element Should Not Be Visible           ${SS_Btn_SSsuccess}
#
#SS Mobile Common - [Modal] Do not display Submit Button
#    Element Should Not Be Visible           ${SS_Btn_SSsubmit}
#
#SS Mobile Common - [Modal] Do not display Live Chat Button
#    Element Should Not Be Visible           ${SS_Btn_SSliveChat}
#
#SS Mobile Common - [Modal] Do not display Back Button
#    Element Should Not Be Visible           ${SS_Btn_SSback}
#
SS Mobile Common - Open Self Service
    Open Browser                    ${SELF_SERVICE_URL_MOBILE}      ${BROWSER}
    Set Window Size	                ${400}      ${700}

SS Mobile Common - Open Self Service and Select Topic Order Tracking
    SS Mobile Common - Open Self Service
    SS Mobile Main Form - Display Title
    SS Mobile Main Form - Select Topic                ${Topic_Order_Tracking}
#
#SS Mobile Common - Open Wemall and Select Topic Order Problem
#    Open Browser                                ${WEMALL_URL}               ${BROWSER}
#    SS Mobile Common - Click Live Chat Button
#    SS Mobile Main Form - Display Title
#    SS Main Form - Select Topic                 ${Topic_Order_Problem}
#
#SS Mobile Common - Open Wemall and Select Topic Order Problem Following
#    Open Browser                                ${WEMALL_URL}               ${BROWSER}
#    SS Mobile Common - Click Live Chat Button
#    SS Mobile Main Form - Display Title
#    SS Main Form - Select Topic                 ${Topic_Order_Problem_Following}
#
#SS Mobile Common - Open Wemall and Select Topic Refund
#    Open Browser                                ${WEMALL_URL}               ${BROWSER}
#    SS Mobile Common - Click Live Chat Button
#    SS Mobile Main Form - Display Title
#    SS Main Form - Select Topic                 ${Topic_Refund}
#
#SS Mobile Common - Open Wemall and Select Topic Other
#    Open Browser                                ${WEMALL_URL}               ${BROWSER}
#    SS Common - Click Live Chat Button
#    SS Mobile Main Form - Display Title
#    SS Main Form - Select Topic                 ${Topic_Other}
