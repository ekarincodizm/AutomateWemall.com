*** Settings ***
Library           Selenium2Library
Resource          WebElement_Mapping_ProductAndGroupProposition.robot
Library           String
Resource          ../../../../Resource/Config/${env}/env_config.robot

*** Keywords ***
MappingProductAndGroup - Go To Mapping Product And Group
    Go To    ${PCMS_URL}/truemoveh/device

MappingProductAndGroup - Click to Create New Mapping
    Wait Until Element Is Visible    ${Btn_AddNewMapping}    60s
    Click Element    ${Btn_AddNewMapping}
    Wait Until Element Is Visible    ${Input_ProductName}    60s

MappingProductAndGroup - Search And Mapping Product
    [Arguments]    ${Text_DeviceName}    ${Text_GroupPropositionName}
    Wait Until Element Is Visible    ${Input_ProductName}    60s
    Input Text    ${Input_ProductName}    ${Text_DeviceName}
    Click Element    ${Btn_Search}
    ${element_Product_Device_Click}=    Replace String    ${CheckBox_Device}    REPLACE_ME    ${Text_DeviceName}
    Wait Until Element Is Visible    ${element_Product_Device_Click}    60s
    Click Element    ${element_Product_Device_Click}
    ${element_Product_Device_List}=    Replace String    ${List_GroupProposition}    REPLACE_ME    ${Text_DeviceName}
    Wait Until Element Is Visible    ${element_Product_Device_List}    60s
    Click Element    ${element_Product_Device_List}
    Select From List    ${element_Product_Device_List}    ${Text_GroupPropositionName}
    Click Element    ${Btn_Map}
    Confirm Action
    Wait Until Element Is Visible    ${Input_ProductName}    60s
    Input Text    ${Input_ProductName}    ${Text_DeviceName}
    Click Element    ${Btn_Search}
    ${element_Product_Device_Click}=    Replace String    ${Assert_DeviceMap}    REPLACE_ME    ${Text_DeviceName}
    Wait Until Element Is Visible    ${element_Product_Device_Click}    60s
