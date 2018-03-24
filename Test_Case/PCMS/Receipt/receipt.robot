*** Settings ***
Library     Selenium2Library
Library     HttpLibrary.HTTP
Library     Collections
Library     OperatingSystem

Resource    ${CURDIR}/../../../Resource/init.robot
Resource    ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource    ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource    ${CURDIR}/../../../Keyword/Portal/PCMS/Receipt/Keywords_Receipts.robot
Resource    ${CURDIR}/../../../Keyword/Portal/PCMS/Receipt/WebElement_Receipt.robot
# Test Setup      Prepare Test Case
Test Teardown   Run Keywords
# ...					End Test Case
# ...					Close Browser

*** Keywords ***
# Prepare Test Case


# End Test Case





*** Variables ***
#${shop_code}   ROBOTCODE

*** Test Cases ***






