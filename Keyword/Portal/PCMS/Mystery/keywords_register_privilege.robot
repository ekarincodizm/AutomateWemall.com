*** Settings ***
Resource    ${CURDIR}/web_element_register_privilege.robot

*** Keywords ***
Mystery Register Privilege - [Web] Input Register Form And Use Bypass Recaptcha
    Mystery Register - [Web] Open Register Form Bypass Recaptcha
    Mystery Data - Delete Automate Data
    Mystery Data - Get Prediction Item
    Mystery Register - Input First Name         ${var_data_firstname}
    Mystery Register - Input Last Name          ${var_data_lastname}
    Mystery Register - Input Tel                ${var_data_tel}
    Mystery Register - Select Gender
    Mystery Register - Select Birth Date
    Mystery Register - Input Email              ${var_data_email}
    Mystery Register - Input Prediction
    Mystery Register - Click Submit

Mystery Register Privilege - Check
    Mystery Data - Get register data from database
    Log To Console      ${var_mystery_register_privilege_status}
    sleep       3s
    ${expect_data}=     Convert To String       ${var_mystery_register_privilege_status}
    Should Be Equal          1            ${expect_data}

