*** Settings ***
Library           Selenium2Library
Library           Collections
Library           String
Library           ${CURDIR}/../../../../Python_Library/DatabaseData.py

*** Keywords ***
Clear Cart Current User
    Get User ID
    Clear Cart    ${TV_user_id}
    Reset Count Number In Cart

Clear Cart Member By Login Then Logout
    [Arguments]   ${email}   ${password}
    User Login From login page   ${email}   ${password}
    Clear Cart Current User
    Logout Page - Go To Logout Page

Reset Count Number In Cart
    ${added_item}=    Convert To Integer    0
    Set Test Variable    ${TV_added_item}    ${added_item}
    ${added_inv}=    Convert To Integer    0
    Set Test Variable    ${TV_added_inv}    ${added_inv}



