*** Settings ***
Resource          web_element_report_problem.robot

*** Keywords ***
SS Report Problem - Display Report Problem
    Wait Until Element Is Visible               ${SS_ReportProblem.report_problem_expand}            15s
    Element Should Be Visible                   ${SS_ReportProblem.report_problem_up_img}
    Click Element                               ${SS_ReportProblem.report_problem_expand}
    Wait Until Element Is Visible               ${SS_ReportProblem.report_problem_expand}            15s
    Element Should Be Visible                   ${SS_ReportProblem.report_problem_down_img}
    Click Element                               ${SS_ReportProblem.report_problem_expand}
    Wait Until Element Is Visible               ${SS_ReportProblem.report_problem_expand}            15s
    Element Should Be Visible                   ${SS_ReportProblem.report_problem_up_img}

SS Report Problem - Display Not Found Problem
    Wait Until Element Is Visible               ${SS_ReportProblem.not_found_order_image}            15s
    Element Should Be Visible                   ${SS_ReportProblem.not_found_order_image}
    Wait Until Element Is Visible               ${SS_ReportProblem.not_found_order_txt}              15s
    Element Should Be Visible                   ${SS_ReportProblem.not_found_order_txt}
#    ${txt_not_found_order}=                     Get Text                            ${SS_OrderTracking.not_found_order_txt}
#    Should Be Equal                             ${txt_not_found_order}              ไม่พบประวัติการแจ้งปัญหาของเลขที่สั่งซื้อ

SS Report Problem - Close Modal
    Wait Until Element Is Visible               ${SS_ReportProblem.close_btn}            15s
    Element Should Be Visible                   ${SS_ReportProblem.close_btn}
    Click Element                               ${SS_ReportProblem.close_btn}
    Wait Until Element Is Visible               ${SS_SelfService_Button}            15s
    Element Should Not Be Visible               ${SS_ReportProblem.self_service_container}
    Element Should Be Visible                   ${SS_SelfService_Button}

SS Report Problem - Back To Main Menu
    Wait Until Element Is Visible               ${SS_ReportProblem.back_btn}            15s
    Element Should Be Visible                   ${SS_ReportProblem.back_btn}
    Click Element                               ${SS_ReportProblem.back_btn}
    Wait Until Element Is Visible               ${SS_SelfService_Dropdown}            15s
    Element Should Not Be Visible               ${SS_OrderTracking_Container}
    Element Should Be Visible                   ${SS_SelfService_Dropdown}