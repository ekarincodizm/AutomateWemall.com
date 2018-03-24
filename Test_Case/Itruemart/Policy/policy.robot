*** Settings ***
Resource    ${CURDIR}/../../../Resource/init.robot
Library    ${CURDIR}/../../../Python_Library/helper.py
Resource    ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource    ${CURDIR}/../../../Keyword/Portal/PCMS/Upload_s3/keywords_upload_s3.robot
Resource    ${CURDIR}/../../../Keyword/Portal/iTrueMart/Policy/keywords_policy.robot

Library     Selenium2Library
Library     HttpLibrary.HTTP
Library     Collections
Library     OperatingSystem
Library     String

Test Tear down     Close All Browsers

*** Variables ***
${delivery_th_cdn_path}    /other/delivery_th.html
${fastdelivery_en_cdn_path}    /other/fastdelivery_en.html
${refund_th_cdn_path}    /other/refund_th.html
${return_en_cdn_path}    /other/return_en.html



*** Test Cases ***
TC_iTM_02536 Display a correct delivery policy (TH) at www.itruemart.com/policy/deliverypolicy
    [Tags]  TC_iTM_02536   ready   delivery_policy  policy  th  web     regression
    ${expect_policy_content}=    Set Variable    Delivery Policy TH - Robot
    ${policy_url}=    Set Variable    /policy/freedelivery?no-cache=1
    ${subject}=    Set Variable    Delivery Policy TH
    ${description}=    Set Variable    Delivery Policy TH
    #${file_upload}=   Set Variable   ${CURDIR}/../../../Resource/TestData/html/policy/delivery_th.html
    ${file_upload}=    get_canonical_path    ${CURDIR}/../../../Resource/TestData/html/policy/delivery_th.html

    Given Prepare Upload S3 Record    ${delivery_th_cdn_path}    ${subject}    ${description}     ${file_upload}
    When Open Browser    ${ITM_URL}${policy_url}    ${BROWSER}
    Then Expect Policy Content    ${expect_policy_content}

TC_iTM_02537 Display a correct fast delivery (EN) policy at www.itruemart.com/en/policy/fastdelivery
    [Tags]  TC_iTM_02537  ready  fast_delivery  policy  en  web     regression
    ${expect_policy_content}=    Set Variable    Fast Delivery Policy EN - Robot
    ${policy_url}=    Set Variable    /en/policy/fastdelivery?no-cache=1
    ${subject}=    Set Variable    Fast Delivery Policy EN
    ${description}=    Set Variable    Fast Delivery Policy EN
    ${file_upload}=    get_canonical_path    ${CURDIR}/../../../Resource/TestData/html/policy/fastdelivery_en.html

    Given Prepare Upload S3 Record    ${fastdelivery_en_cdn_path}    ${subject}    ${description}     ${file_upload}
    When Open Browser    ${ITM_URL}${policy_url}    ${BROWSER}
    Then Expect Policy Content    ${expect_policy_content}

TC_iTM_02538 Display a correct refund policy (TH) policy at www.itruemart.com/policy/refundpolicy
    [Tags]  TC_iTM_02538  ready  refund_policy  policy   th  web    regression
    ${expect_policy_content}=    Set Variable    Refund Policy TH - Robot
    ${policy_url}=    Set Variable    /policy/moneyback?no-cache=1
    ${subject}=    Set Variable    Refund Policy TH
    ${description}=    Set Variable    Refund Policy TH
    ${file_upload}=    get_canonical_path    ${CURDIR}/../../../Resource/TestData/html/policy/refund_th.html

    Given Prepare Upload S3 Record    ${refund_th_cdn_path}    ${subject}    ${description}     ${file_upload}
    When Open Browser    ${ITM_URL}${policy_url}    ${BROWSER}
    Then Expect Policy Content    ${expect_policy_content}

TC_iTM_02539 Display a correct return policy (EN) policy at www.itruemart.com/en/policy/returnpolicy
    [Tags]   TC_iTM_02539   ready   return_policy  policy  en  web      regression
    ${expect_policy_content}=    Set Variable    Return Policy EN - Robot
    ${policy_url}=    Set Variable    /en/policy/returnpolicy?no-cache=1
    ${subject}=    Set Variable    Return Policy EN
    ${description}=    Set Variable    Return Policy EN
    ${file_upload}=    get_canonical_path    ${CURDIR}/../../../Resource/TestData/html/policy/return_en.html

    Given Prepare Upload S3 Record    ${return_en_cdn_path}    ${subject}    ${description}     ${file_upload}
    When Open Browser    ${ITM_URL}${policy_url}    ${BROWSER}
    Then Expect Policy Content    ${expect_policy_content}

