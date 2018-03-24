*** Settings ***
Library           Selenium2Library
Library           Collections
Library           String
Library           ${CURDIR}/../../../../Python_Library/promotion_code.py

*** Keywords ***
Remove Promotion By Name And Campaign
    [Arguments]    ${campaign_name}    ${promotion_name}
    ${promotion_id}=    py_get_promotion_id    ${campaign_name}    ${promotion_name}
    py_remove_promotion_code_logs    ${promotion_id}
    py_remove_promotion_codes    ${promotion_id}
    py_remove_promotions    ${promotion_id}
    Log To Console    remove=${promotion_id}
