*** Settings ***
Resource        ${CURDIR}/../common/api_keywords.robot
Library         ${CURDIR}/../../../Python_Library/common/uploadsoperation.py
Library         Collections

*** Keywords ***
############ Prepare Data ############
Prepare File
    [Arguments]    ${Directory_File}    ${Filename}
    Create Folder    ${Directory_File}
    Create File for General Service    ${Directory_File}    ${Filename}
    [Return]    ${Directory_File}${Filename}

Prepare File With File Size
    [Arguments]    ${Directory_File}    ${Filename}    ${fileSize}
    # Log To Console    ${fileSize}
    create_folder    ${Directory_File}
    create_file_with_fileSize    ${Directory_File}    ${Filename}    ${fileSize}
    [Return]    ${Directory_File}${Filename}

Delete File Before Send Post Request
    [Arguments]    ${Directory_File}    ${Filename}
    Delete File    ${Directory_File}    ${Filename}

############ Get ############
Send Get Uploads Success
    [Arguments]    ${Sub_Folder_S3}
    HTTP Get Request    ${GENERAL_API_HOST}    ${HTTP_PROTOCAL}    ${UPLOADS}${Sub_Folder_S3}

############ Verify ############
Response Should Contain Data And CDN URL Must Matched
    [Arguments]    ${Response}    ${expected_cdn_url}    ${File_Full_Path}
    Check Response Success and Data Not Empty    ${Response}
    ${response_cdn_url}=    Get Cdn Url From Response    ${Response}
    Should Be Equal As Strings    ${response_cdn_url}    ${expected_cdn_url}    CDN URL not matched

Check Error and No Data
    [Arguments]    ${Response}
    Check Reponse Error and Data Empty    ${Response}

Verify Get Uploads Success and Data Not Empty
    ${body}=    Get Response Body
    ${message}=    Get Json Value    ${body}    /message
    Should Be Equal As Strings    ${message}    "OK"
    ${total-items}=    Get Json Value    ${body}    /data/total_items
    Should Not Be Equal As Integers    ${total-items}    0

Verify Get Uploads Success but Data Empty
    ${body}=    Get Response Body
    ${message}=    Get Json Value    ${body}    /message
    Should Be Equal As Strings    ${message}    "OK"
    ${total-items}=    Get Json Value    ${body}    /data/total_items
    Should Be Equal As Integers    ${total-items}    0

