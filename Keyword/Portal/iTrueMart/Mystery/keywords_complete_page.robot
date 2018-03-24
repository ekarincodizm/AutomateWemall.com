*** Settings ***
Resource    ${CURDIR}/web_element_complete_page.robot

*** Variables ***
${img_src_title_caption}   https://cdn-static.itruemart.com/pcms/uploads/images/result_title.png
${img_src_btn_facebook}   https://cdn-static.itruemart.com/pcms/uploads/images/facebook.png

*** Keywords ***
Mystery Complete - Display Title Caption
    ${element}=         Replace String       ${MysteryComplete_Title_Caption}        REPLACE_SRC     ${img_src_title_caption}
    Wait Until Element Is Visible           ${element}              20s

Mystery Complete - Display Customer Name as Test Data
    Wait Until Element Is Visible           ${MysteryComplete_Customer_Name}        20s
    ${customer_name}=               Get Text        ${MysteryComplete_Customer_Name}
    ${expect_customer_name}=        Convert To String            คุณ ${var_data_firstname} เลือกสี
    Should Be Equal                ${customer_name}            ${expect_customer_name}

Mystery Complete - Display Customer Color as Test Data
    Wait Until Element Is Visible           ${MysteryComplete_Customer_Color}        20s
    ${color}=               Get Text        ${MysteryComplete_Customer_Color}
    ${expect_color}=        Convert To String            “${var_mystery_prediction_item_name_th}”
    Should Be Equal                ${color}            ${expect_color}

Mystery Complete - Display Long Description
    Wait Until Element Is Visible           ${MysteryComplete_Prediction_Detail}        20s
    Element Should Be Visible               ${MysteryComplete_Prediction_Detail}
    Wait Until Element Is Visible           ${MysteryComplete_Prediction_Sub_Detail}        20s
    Element Should Be Visible               ${MysteryComplete_Prediction_Sub_Detail}

Mystery Complete - Display Button Share with Facebook
    ${element}=         Replace String       ${MysteryComplete_Btn_Share_Facebook}        REPLACE_SRC     ${img_src_btn_facebook}
    Wait Until Element Is Visible           ${element}              20s

Mystery Complete - Display Prediciton All Image Main
    : FOR    ${prediction}    IN    @{var_mystery_prediction_sub}
    \           ${img_main}=              Get From Dictionary         ${prediction}       img_main
    \           Wait Until Element Is Visible           //*[@src="${img_main}"]              20s
    \           Element Should Be Visible               //*[@src="${img_main}"]