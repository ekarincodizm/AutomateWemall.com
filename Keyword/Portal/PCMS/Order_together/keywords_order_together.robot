*** Settings ***
Library           Selenium2Library
Resource          ${CURDIR}/../Login/keywords_login.robot
Resource          ${CURDIR}/../Run_PCMS_order/Keywords_RunPCMSOrder.robot
Resource          ${CURDIR}/web_element_order_together.robot
Library           ${CURDIR}/../../../../Python_Library/FileLibrary.py

*** Keywords ***
Go To Order Together Page
    Go To    ${PCMS_URL}
    Click Element    ${order_together_bar}
    Wait Until Element Is Visible    ${order_together_bar_receipt}    30s
    CLick Element    ${order_together_bar_receipt}
    Wait Until Element Is Visible    ${order_together_search_button}    30s

Search Order
    [Arguments]    ${order_id_together}
    Wait Until Element Is Enabled    ${order_together_input_pcms_order_id}    30s
    Input Text    ${order_together_input_pcms_order_id}    ${order_id_together}
    Click Element    ${order_together_search_button}

Open PCMS And Sync Order Together
    [Arguments]    ${time}=2
    Login Pcms    ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    Repeat Keyword    ${time}    Run PCMS Order

Download Pdf Order Together File specific name
    [Arguments]    ${download_filename}
    Wait Until Element Is Visible    ${order_together_export_billing_button}    30s
    ${urlReport}=    Selenium2Library.Get Element Attribute    ${download_button}@href
    Click Element    ${download_button}
    ${title}=    Get Title
    Select Window    url=${urlReport}
    ${textAreaVisible}=    Run Keyword And Return Status    Element Should Be Visible    ${order_together_textarea}
    Run Keyword If    ${textAreaVisible}    Input Text    ${order_together_textarea}    test
    Click Element    ${order_together_confirm}
    ${cookies}    Get Cookies
    write_download_file    ${cookies}    ${urlReport}    ${download_filename}
    Close Window
    Select Window    title=${title}

Compare PDF Files Should Equal
    [Arguments]    ${file_original}    ${file_robot_download}
    ${text1}=    convert_pdf_to_txt    ${file_original}
    ${text2}=    convert_pdf_to_txt    ${file_robot_download}
    Should Be Equal    ${text1}    ${text2}

Order - Together Check Item Status In DB
    [Arguments]    ${order_id}    ${item_id}    ${status}
    #    Check cancel item ${status} = 4
    Order - Together Check PCMS Item In DB    ${order_id}    ${item_id}
    ${item_status}=    Get Together Item Status    ${order_id}    ${item_id}
    Should Be Equal As Strings    ${item_status}    ${status}
    # Log To Console    ${item_status}

Order - Together Check Order Status In DB
    [Arguments]    ${order_id}    ${status}
    #    Check cancel order ${status} = 1, Check refund order ${status} = 2
    Order - Together Check PCMS Order In DB    ${order_id}
    ${order_status}=    Get Together Order Status    ${order_id}
    Should Be Equal As Strings    ${order_status}    ${status}
    # Log To Console    ${order_status}

Order - Together Check PCMS Order In DB
    [Arguments]    ${order_id}
    ${count_order}=    Get Together Order    ${order_id}
    Should Be Equal As Strings    ${count_order}    1
    Log To Console    ${count_order}

Order - Together Check PCMS Item In DB
    [Arguments]    ${order_id}    ${item_id}
    ${count_item}=    Get Together Order Item    ${order_id}    ${item_id}
    Should Be Equal As Strings    ${count_item}    1
    Log To Console    ${count_item}
