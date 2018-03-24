*** Settings ***
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/API/api_general/uploads_keyword.robot

*** Variables ***
${service}    hot-brands/
${store_directory}    temp_test/
${sub_folder_in_s3}    ${service}dir/${store_directory}
${invalid_service}    invalid_service/dir/${store_directory}
${invalid_store_directory}    ${service}dir/invalid_store_directory

*** Test Cases ***
TC_WMALL_00252 Get General Upload Success and Data Not Empty
    [Tags]    get_uploads    api_uploads    api_general
    Send Get Uploads Success    ${sub_folder_in_s3}
    Verify Get Uploads Success and Data Not Empty

TC_WMALL_00253 Get General Upload Success but Data Empty
    [Tags]    get_uploads    api_uploads    api_general
    Send Get Uploads Success    ${invalid_service}
    Verify Get Uploads Success but Data Empty
    Send Get Uploads Success    ${invalid_store_directory}
    Verify Get Uploads Success but Data Empty