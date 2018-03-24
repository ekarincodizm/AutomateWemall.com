*** Settings ***
Library           Selenium2Library
Resource          WebElement_UserInformationPage.robot

*** Variables ***

*** Keywords ***
Go to user information page
    Wait Until Element Is Visible    ${User_menu_locator}    20s
    Mouse Over    ${User_menu_locator}
    Wait Until Element Is Visible    ${User_information_locator}    20s
    Click Element    ${User_information_locator}

Choose existing address

Enter add new address formation
    [Arguments]    ${Text_Displayname}    ${Text_Address}    ${Text_Postcode}    ${Text_Mobile}    ${Text_Email}
    Wait Until Element Is Visible    ${Enter_displayname_usrFormationPage_locator}    20s
    Input Text    ${Enter_displayname_usrFormationPage_locator}    ${Text_Displayname}
    Click Element    ${Select_province_usrFormationPage_locator}
    Wait Until Element Is Visible    ${Select_city_usrFormationPage_locator}    20s
    Click Element    ${Select_city_usrFormationPage_locator}
    Wait Until Element Is Visible    ${Select_distric_usrFormationPage_locator}    20s
    Click Element    ${Select_distric_usrFormationPage_locator}
    Input Text    ${Enter_address_usrFormationPage_locator}    ${Text_Address}
    Input Text    ${Enter_postcode_usrFormationPage_locator}    ${Text_Postcode}
    Input Text    ${Enter_mobile_usrFormationPage_locator}    ${Text_Mobile}
    Input Text    ${Enter_email_usrFormationPage_locator}    ${Text_Email}

Click add new address(If user have at least 1 existing address)
    Wait Until Element Is Visible    ${Addnewaddress_dropdown_locator}    20s
    Click Element    ${Addnewaddress_dropdown_locator}

Click submit add new address
    Wait Until Element Is Visible    ${Submit_newaddress_locator}    20s
    Click Element    ${Submit_newaddress_locator}

Logout user from itruemart
    Wait Until Element Is Visible    ${User_menu_locator}    20s
    Mouse Over    ${User_menu_locator}
    Wait Until Element Is Visible    ${Logout_locator}    20s
    Click Element    ${Logout_locator}

Verify Avaiable address by Displayname
    [Arguments]    ${Text_Displayname}
    Wait Until Element Is Visible    ${Chooseaddress_dropdown_locator}    20s
    Element should contain    ${Chooseaddress_dropdown_locator}    ${Text_Displayname}

Verify if Address Should be Empty
    Wait Until Element Is Visible    ${Addnewaddress_dropdown_locator}    20s
    Element Should Not Be Visible    ${FirstAvaliableAddress_dropdown_locator}
