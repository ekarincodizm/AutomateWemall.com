*** Settings ***
Library         Selenium2Library
Resource        ${CURDIR}/web_element_member_profile.robot

*** Variables ***

*** Keywords ***
Verify Member User Account
    [Arguments]    ${expected_username}
    Wait Until Element Is Visible    ${username_detail_label}    30s
    ${actual_username}=    Get Text    ${username_detail_label}
    Should Be Equal As Strings    ${expected_username}    ${actual_username}
    Location Should Contain    /member/profile

Verify New Member Coupon Page
    Wait Until Element Is Visible    ${new_member_coupon_label}    30s
    Location Should Contain    /member/profile?coupon=new-user