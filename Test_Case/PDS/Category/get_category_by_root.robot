*** Setting ***
Force Tags    WLS_PDS_Category
Library           HttpLibrary.HTTP
Library           Collections
Library           DatabaseLibrary
Library           String
Library           ${CURDIR}/../../../Python_Library/FileKeyword.py
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/Database/PDS/keyword_categories.robot
Resource          ${CURDIR}/../../../Keyword/API/PDS/pds_api_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PDS/Keywords_PDS_Common.robot

*** Test Cases ***
TC_ITMWM_00659 GET: /categories/root - get root category that has sub category by category root - success 200
    [Documentation]    To verify data for category that has sub category will be returned successfully when sending request to get category by category root
    [Tags]    regression    API_category    ready    TC_ITMWM_00659    phoenix
    ${response}=    Get Category By Category Root
    Verify Success Response Status Code and Message
    Verify Response Data From Get Root Category
    Verify Children Order of Category Root From Response is as Children Order in DB    ${response}

TC_ITMWM_00660 GET: /categories/root - get root category that has no sub category by category root - success 200
    [Documentation]    To verify data for category that has no sub category will be returned successfully when sending request to get category by category root
    [Tags]    TC_ITMWM_00660    API_category    ready
    # Prerequisite: There is no any category on system
    ${response}=    Get Category By Category Root
    Verify Success Response Status Code and Message
    Verify Response is Empty Data From Get All Categories