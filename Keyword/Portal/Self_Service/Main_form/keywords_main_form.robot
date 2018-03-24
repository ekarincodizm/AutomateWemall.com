*** Settings ***
Resource          web_element_main_form.robot

*** Variables ***
${Topic_Order_Tracking}             1
${Topic_Order_Problem}              2
${Topic_Order_Problem_Following}    3
${Topic_Order_Refund}               4
${Topic_Order_Other}                5

*** Keywords ***
SS Main Form - Display Main Form
    Wait Until Element Is Visible               ${SS_MainForm}            15s
    Element Should Be Visible                   ${SS_MainForm}

SS Main Form - Display Container Form
    Wait Until Element Is Visible               ${SS_ContainerFooter}            15s
    Element Should Be Visible                   ${SS_ContainerFooter}

SS Main Form - Select Topic
    [Arguments]         ${topic}
    Wait Until Element Is Visible               ${SS_TopicList}                     15s
    Click Element                               ${SS_TopicList}
    Wait Until Element Is Visible               //li[@data-id="${topic}"]           15s
    Click Element                               //li[@data-id="${topic}"]

SS Main Form - Input Email
    [Arguments]         ${email}
    Wait Until Element Is Visible               ${SS_txt_email}                     15s
    Input Text          ${SS_txt_email}         ${email}

SS Main Form - Input Order Id
    [Arguments]         ${order_id}
    Wait Until Element Is Visible               ${SS_txt_order_id}                     15s
    Input Text          ${SS_txt_order_id}      ${order_id}

SS Main Form - Click Next Step
    Wait Until Element Is Visible               ${SS_btn_submit_enabled}           15s
    Click Element                               ${SS_btn_submit_enabled}

SS Main Form - Do not Input Email
    Element Should Not Be Visible                   ${SS_txt_email}

SS Main Form - Do not Input Order Id
    Element Should Not Be Visible                   ${SS_txt_order_id}

SS Main Form - Do not Buttom Continue
    Element Should Not Be Visible                   ${SS_btn_submit_disabled}
    Element Should Not Be Visible                   ${SS_btn_submit_enabled}
