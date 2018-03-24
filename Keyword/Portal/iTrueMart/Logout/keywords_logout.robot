*** Settings ***
Library           Selenium2Library

*** Keywords ***
Logout Page - Go To Logout Page
    Go To    ${ITM_URL}/auth/logout

Logout Page - Go To Logout Page EN
    Go To    ${ITM_URL}/en/auth/logout
