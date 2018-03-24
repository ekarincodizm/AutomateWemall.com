*** Settings ***
Resource          web_element_main_form.robot

*** Variables ***
${Topic_Order_Tracking}             order_tracking
${Topic_Order_Problem}              order_problem
${Topic_Order_Problem_Following}    order_problem_following
${Topic_Order_Refund}               order_refund
${Topic_Order_Other}                other

*** Keywords ***
SS Mobile Main Form - Display Title
    Wait Until Element Is Visible               ${SS_MainForm_Title}            15s
    Element Should Be Visible                   ${SS_MainForm_Title}

SS Mobile Main Form - Display Title Text
    Wait Until Element Is Visible               ${SS_MainForm_TitleText}            15s
    Element Should Be Visible                   ${SS_MainForm_TitleText}

SS Mobile Main Form - Display Dropdown
    Wait Until Element Is Visible               ${SS_MainForm_Dropdown}            15s
    Element Should Be Visible                   ${SS_MainForm_Dropdown}

SS Mobile Main Form - Select Topic
    [Arguments]         ${topic}
    Wait Until Element Is Visible               ${SS_TopicList}                     15s
    Click Element                               ${SS_TopicList}
    Wait Until Element Is Visible               //li[@data-id="${topic}"]           15s
    Click Element                               //li[@data-id="${topic}"]

SS Mobile Main Form - Input Email
    [Arguments]         ${email}
    Log To Console      email=${email}
    Wait Until Element Is Visible               ${SS_txt_email}                     15s
    Input Text          ${SS_txt_email}         ${email}

SS Mobile Main Form - Input Order Id
    [Arguments]         ${order_id}
    Wait Until Element Is Visible               ${SS_txt_order_id}                     15s
    Input Text          ${SS_txt_order_id}      ${order_id}

SS Mobile Main Form - Click Next Step
    Wait Until Element Is Visible               ${SS_btn_submit_enabled}           15s
    Click Element                               ${SS_btn_submit_enabled}

SS Mobile Main Form - Do not Input Email
    Element Should Not Be Visible                   ${SS_txt_email}

SS Mobile Main Form - Do not Input Order Id
    Element Should Not Be Visible                   ${SS_txt_order_id}

SS Mobile Main Form - Do not Buttom Continue
    Element Should Not Be Visible                   ${SS_btn_submit_disabled}
    Element Should Not Be Visible                   ${SS_btn_submit_enabled}
