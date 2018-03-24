*** Settings ***
Resource          web_element_common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/Self_Service/Main_form/keywords_main_form.robot

*** Keywords ***
SS Common - Display Live Chat Button
    Wait Until Element Is Visible           ${Live_Chat_Btn}            15s
    Element Should Be Visible               ${Live_Chat_Btn}

SS Common - Click Live Chat Button
    Wait Until Element Is Visible           ${Live_Chat_Btn}            15s
    Sleep                                   5s
    Click Element                           ${Live_Chat_Btn}

SS Common - [Modal] Display Success Button
    Wait Until Element Is Visible           ${SS_Btn_SSsuccess}            15s
    Element Should Be Visible               ${SS_Btn_SSsuccess}

SS Common - [Modal] Display Submit Button
    Wait Until Element Is Visible           ${SS_Btn_SSsubmit}            15s
    Element Should Be Visible               ${SS_Btn_SSsubmit}

SS Common - [Modal] Display Live Chat Button
    Wait Until Element Is Visible           ${SS_Btn_SSliveChat}            15s
    Element Should Be Visible               ${SS_Btn_SSliveChat}

SS Common - [Modal] Display Back Button
    Wait Until Element Is Visible           ${SS_Btn_SSback}            15s
    Element Should Be Visible               ${SS_Btn_SSback}

SS Common - [Modal] Do not display Success Button
    Element Should Not Be Visible           ${SS_Btn_SSsuccess}

SS Common - [Modal] Do not display Submit Button
    Element Should Not Be Visible           ${SS_Btn_SSsubmit}

SS Common - [Modal] Do not display Live Chat Button
    Element Should Not Be Visible           ${SS_Btn_SSliveChat}

SS Common - [Modal] Do not display Back Button
    Element Should Not Be Visible           ${SS_Btn_SSback}

SS Common - Open Wemall
    Open Browser                                ${WEMALL_URL}               ${BROWSER}
    Set Window Size	                            ${1500}      ${1200}
SS Common - Open Wemall and Select Topic Order Tracking
    SS Common - Open Wemall
    SS Common - Click Live Chat Button
    SS Main Form - Display Main Form
    SS Main Form - Select Topic                 ${Topic_Order_Tracking}

SS Common - Open Wemall and Select Topic Order Problem
    SS Common - Open Wemall
    SS Common - Click Live Chat Button
    SS Main Form - Display Main Form
    SS Main Form - Select Topic                 ${Topic_Order_Problem}

SS Common - Open Wemall and Select Topic Order Problem Following
    SS Common - Open Wemall
    SS Common - Click Live Chat Button
    SS Main Form - Display Main Form
    SS Main Form - Select Topic                 ${Topic_Order_Problem_Following}

SS Common - Open Wemall and Select Topic Refund
    SS Common - Open Wemall
    SS Common - Click Live Chat Button
    SS Main Form - Display Main Form
    SS Main Form - Select Topic                 ${Topic_Refund}

SS Common - Open Wemall and Select Topic Other
    SS Common - Open Wemall
    SS Common - Click Live Chat Button
    SS Main Form - Display Main Form
    SS Main Form - Select Topic                 ${Topic_Other}
