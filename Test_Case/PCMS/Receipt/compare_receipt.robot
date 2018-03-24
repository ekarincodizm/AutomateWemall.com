*** Settings ***
Suite Setup         Login Pcms    admin@domain.com    12345
Suite Teardown      Close All Browsers
Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource            ${CURDIR}/../../../Keyword/Portal/PCMS/Order_together/keywords_order_together.robot
Test Template       Compare Receipt with Expected File

*** Variables ***
${destination}      ${CURDIR}/../../../Resource/TestData/pcms/receipts
${download_path}    ${CURDIR}/../../../Resource/TestData/pcms/downloads

*** Test Cases ***
TC_PCMS_XXXXX - 100011377    100011377    ${destination}/100011377-160524000069.pdf
    [Tags]  order_receipt    regression

*** Keywords ***
Compare Receipt with Expected File
    [Arguments]    ${order_id}    ${expected_file}
    ${download_file}=    Set Variable    ${download_path}/${order_id}-back.pdf
    Go To Order Together Page
    Search Order    ${order_id}
    Download Pdf Order Together File specific name    ${download_file}
    Compare PDF Files Should Equal    ${download_file}    ${expected_file}