*** Settings ***
Library           Selenium2Library
Resource          ../../../Common/Keywords_Common.robot
Resource          WebElement_registration.robot
Resource          ../../../../Resource/Config/${env}/env_config.robot
Resource          WebElement_registration.robot

*** Keywords ***
Registration Assert Bundle Promotion Name
    [Arguments]    ${Text_BundleName}
    ${element_bundle}=    Replace String    ${Assert_BundleName}    REPLACE_ME    ${Text_BundleName}
    Wait Until Element Is Visible    ${element_bundle}    60s

Registration Choose Lucky Number
    [Arguments]    ${Text_SimProvince}
    Wait Until Element is ready and click    ${List_SimProvince}    ${Text_SimProvince}
    Click Element    ${Radio_GoldNumber}
    Click Element    ${Selected_SIMFixed}
    Wait Until Element Is Visible    ${Assert_SimSelected}

Registration Apply Information
    [Arguments]    ${Text_RegisFirstName}    ${Text_RegisLastName}    ${Text_RegisBirthdateYear}    ${Text_RegisbirthdateMonth}    ${Text_RegisbirthdateDay}    ${Text_RegisEmail}
    ...    ${Text_RegisPhoneNumber}    ${Text_RegisIDCard}    ${Text_RegisexpiredYear}    ${Text_RegisexpiredMonth}    ${Text_RegisexpiredDay}    ${Text_RegisProvince}
    ...    ${Text_RegisDistrict}    ${Text_RegisCity}    ${Text_RegisZipcode}    ${Text_RegisAddress}    ${Text_RegisRoad}
    Click Element    ${Radio_Mr}    #MR
    Click Element    ${Radio_Male}    #Male
    Input Text    ${Input_FirstName}    ${Text_RegisFirstName}
    Input Text    ${Input_LastName}    ${Text_RegisLastName}
    Click Element    ${List_BirthDaysYear}
    Select From List    ${List_BirthDaysYear}    ${Text_RegisBirthdateYear}    #BirthdateYear
    Click Element    ${List_BirthDaysMonth}
    Select From List    ${List_BirthDaysMonth}    ${Text_RegisbirthdateMonth}    #birthdateMonth
    Click Element    ${List_BirthDaysDate}
    Select From List    ${List_BirthDaysDate}    ${Text_RegisbirthdateDay}    #birthdateDay
    Input Text    ${Input_Email}    ${Text_RegisEmail}    #Email
    Input Text    ${Input_Phone}    ${Text_RegisPhoneNumber}
    Input Text    ${Input_IDCard}    ${Text_RegisIDCard}    #IDCard
    Click Element    ${List_ExpiredYear}
    Select From List    ${List_ExpiredYear}    ${Text_RegisexpiredYear}    #expiredYear
    Click Element    ${List_ExpiredMonth}
    Select From List    ${List_ExpiredMonth}    ${Text_RegisexpiredMonth}    #expiredMonth
    Click Element    ${List_ExpiredDate}
    Select From List    ${List_ExpiredDate}    ${Text_RegisexpiredDay}    expiredDay
    Choose File    ${Upload_PDS}    ${Path-ImgFile}\\pds.pds
    Click Element    ${List_Province}
    Select From List    ${List_Province}    ${Text_RegisProvince}
    Wait Until Element Is Enabled    ${List_District}    60s
    Click Element    ${List_District}
    Select From List    ${List_District}    ${Text_RegisDistrict}
    Wait Until Element Is Enabled    ${List_City}    60s
    Click Element    ${List_City}
    Select From List    ${List_City}    ${Text_RegisCity}
    Wait Until Element Is Enabled    ${List_Zipcode}    60s
    Click Element    ${List_Zipcode}
    Select From List    ${List_Zipcode}    ${Text_RegisZipcode}
    Input Text    ${Input_Address}    ${Text_RegisAddress}
    Input Text    ${Input_Road}    ${Text_RegisRoad}
    Click Element    ${Checkbox_Address}
    Click Element    ${Checkbox_Confirm}
