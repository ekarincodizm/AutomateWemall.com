*** Settings ***
Resource   ${CURDIR}/web_element_upload_s3.robot


*** Keywords ***

Upload S3 - Go To Menu Upload S3
    Go To    ${PCMS_URL}/upload-s3

Upload S3 - Search File Url
    [Arguments]    ${policy_cdn_path}
    Input Text    ${xpath-txt-search-cdn-path}    ${policy_cdn_path}

    Run Keyword If   '${BROWSER}' == 'chrome'   Click Element    ${xpath-btn-search-upload-s3}
    Sleep    3s
    Click Element    ${xpath-btn-search-upload-s3}
    ${count_element}=    Get Matching Xpath Count    ${xpath-search-record}
    [Return]    ${count_element}

Upload S3 - New File Upload
    [Arguments]    ${subject}    ${description}     ${file_upload}
    Click Element    ${xpath-btn-upload-new-file}
    Input Text    ${xpath-txt-subject}    ${subject}
    Input Text    ${xpath-txt-description}    ${description}
    Click Element    ${xpath-cbo-type-other}
    Choose File    ${xpath-input-file-upload}    ${file_upload}
    Click Element    ${xpath-btn-submit-upload}

Upload S3 - Edit File Upload
    [Arguments]    ${subject}    ${description}     ${file_upload}
    Click Element    ${xpath-btn-edit-file-upload}
    Input Text    ${xpath-txt-subject}    ${subject}
    Input Text    ${xpath-txt-description}    ${description}
    Click Element    ${xpath-cbo-type-other}
    Choose File    ${xpath-input-file-upload}    ${file_upload}
    Click Element    ${xpath-btn-submit-upload}

Prepare Upload S3 Record
    [Arguments]    ${policy_cdn_path}    ${subject}    ${description}     ${file_upload}
    Login Pcms
    Upload S3 - Go To Menu Upload S3
    ${serach_record}=    Upload S3 - Search File Url    ${policy_cdn_path}
    Log To Console    Count Search Repord= ${serach_record}

    Run Keyword If    '${serach_record}'=='0'    Upload S3 - New File Upload    ${subject}    ${description}     ${file_upload}
    ...     ELSE    Upload S3 - Edit File Upload    ${subject}    ${description}     ${file_upload}

    Upload S3 - Search File Url    ${policy_cdn_path}
    ${cdn_path}=    Get Text    ${xpath-cdn-file-upload}
    ${time}=    Get Time
    Close All Browsers
    Open Browser    ${cdn_path}?q=${time}    ${BROWSER}
    Close All Browsers





