*** Settings ***
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/API/api_general/uploads_keyword.robot

*** Variables ***
${service}    hot-brands/
${store_directory}    temp_test2/
${sub_folder_in_s3}    ${service}dir/${store_directory}
${directory_file}    ${CURDIR}/tmp/
${filename}    iphone6_01.jpg
${filename_1}    file_type_1.txt
${filename_2}    file_type_2.txt
${filename_3}    file_type_3.txt
${expected_cdn_url}    ${CDN_SERVER}th/${service}${store_directory}${filename}
${expected_cdn_url_limit_size}    ${CDN_SERVER}th/${service}${store_directory}${filename_1}
${file_size_10}    10485777
${file_size_11}    11639193
${file_size_15}    15833497
${code200}          200
${code413}          413
${code500}          500
${messageSuccess}    OK
${messageInternalServerError}     Exceeded file size limit.
${messageInternalServerError2}      413 Request Entity Too Large
${default_max_age}    604800

*** Test Cases ***
TC_WMALL_00254 Upload One File with default max_age
    [Tags]    post_uploads    api_uploads    api_general
    ${files}=    Prepare File    ${directory_file}    ${filename}
    ${response}=    Post Uploads Files    ${GENERAL_API}    ${sub_folder_in_s3}    ${files}
    ${expected_cdn_url_with_md5}=    Get Cdn Url Expected    ${expected_cdn_url}    ${files}
    Response Should Contain Data And CDN URL Must Matched    ${response}    ${expected_cdn_url_with_md5}    ${files}
    check_message    ${response}    ${messageSuccess}
    ${CDN_response}=    Get Uploaded File from CDN S3    http:${expected_cdn_url_with_md5}
    Verify Cache_Control in Response Header    ${CDN_response}    ${default_max_age}

TC_WMALL_01763 Upload One File with max_age = 0
    [Tags]    post_uploads    api_uploads    api_general
    ${files}=    Prepare File    ${directory_file}    ${filename}
    ${response}=    Post Uploads Files    ${GENERAL_API}    ${sub_folder_in_s3}    ${files}    0
    ${expected_cdn_url_with_md5}=    Get Cdn Url Expected    ${expected_cdn_url}    ${files}
    Response Should Contain Data And CDN URL Must Matched    ${response}    ${expected_cdn_url_with_md5}    ${files}
    check_message    ${response}    ${messageSuccess}
    ${CDN_response}=    Get Uploaded File from CDN S3    http:${expected_cdn_url_with_md5}
    Verify Cache_Control in Response Header    ${CDN_response}    0

TC_WMALL_01764 Upload One File with max_age = None
    [Tags]    post_uploads    api_uploads    api_general
    ${files}=    Prepare File    ${directory_file}    ${filename}
    ${response}=    Post Uploads Files    ${GENERAL_API}    ${sub_folder_in_s3}    ${files}        ${None}
    ${expected_cdn_url_with_md5}=    Get Cdn Url Expected    ${expected_cdn_url}    ${files}
    Response Should Contain Data And CDN URL Must Matched    ${response}    ${expected_cdn_url_with_md5}    ${files}
    check_message    ${response}    ${messageSuccess}
    ${CDN_response}=    Get Uploaded File from CDN S3    http:${expected_cdn_url_with_md5}
    Verify Cache_Control in Response Header    ${CDN_response}    ${default_max_age}

TC_WMALL_01765 Upload One File with max_age = 'xxx'
    [Tags]    post_uploads    api_uploads    api_general
    ${files}=    Prepare File    ${directory_file}    ${filename}
    ${response}=    Post Uploads Files    ${GENERAL_API}    ${sub_folder_in_s3}    ${files}        xxx
    ${expected_cdn_url_with_md5}=    Get Cdn Url Expected    ${expected_cdn_url}    ${files}
    Response Should Contain Data And CDN URL Must Matched    ${response}    ${expected_cdn_url_with_md5}    ${files}
    check_message    ${response}    ${messageSuccess}
    ${CDN_response}=    Get Uploaded File from CDN S3    http:${expected_cdn_url_with_md5}
    Verify Cache_Control in Response Header    ${CDN_response}    ${default_max_age}

TC_WMALL_01766 Upload One File with max_age = Empty
    [Tags]    post_uploads    api_uploads    api_general
    ${files}=    Prepare File    ${directory_file}    ${filename}
    ${response}=    Post Uploads Files    ${GENERAL_API}    ${sub_folder_in_s3}    ${files}        ${EMPTY}
    ${expected_cdn_url_with_md5}=    Get Cdn Url Expected    ${expected_cdn_url}    ${files}
    Response Should Contain Data And CDN URL Must Matched    ${response}    ${expected_cdn_url_with_md5}    ${files}
    check_message    ${response}    ${messageSuccess}
    ${CDN_response}=    Get Uploaded File from CDN S3    http:${expected_cdn_url_with_md5}
    Verify Cache_Control in Response Header    ${CDN_response}    ${default_max_age}

TC_WMALL_01767 Upload One File without max_age
    [Tags]    post_uploads    api_uploads    api_general
    ${files}=    Prepare File    ${directory_file}    ${filename}
    ${response}=    Post Uploads Files wo Cache Max Age    ${GENERAL_API}    ${sub_folder_in_s3}    ${files}
    ${expected_cdn_url_with_md5}=    Get Cdn Url Expected    ${expected_cdn_url}    ${files}
    Response Should Contain Data And CDN URL Must Matched    ${response}    ${expected_cdn_url_with_md5}    ${files}
    check_message    ${response}    ${messageSuccess}
    ${CDN_response}=    Get Uploaded File from CDN S3    http:${expected_cdn_url_with_md5}
    Verify Cache_Control in Response Header    ${CDN_response}    ${default_max_age}

TC_WMALL_01768 Upload One File with max_age = 31535999 and 1209600
    [Tags]    post_uploads    api_uploads    api_general
    ${files}=    Prepare File    ${directory_file}    ${filename}
    ${expected_cdn_url_with_md5}=    Get Cdn Url Expected    ${expected_cdn_url}    ${files}

    ${response}=    Post Uploads Files    ${GENERAL_API}    ${sub_folder_in_s3}    ${files}    31535999
    Response Should Contain Data And CDN URL Must Matched    ${response}    ${expected_cdn_url_with_md5}    ${files}
    check_message    ${response}    ${messageSuccess}
    ${CDN_response}=    Get Uploaded File from CDN S3    http:${expected_cdn_url_with_md5}
    Verify Cache_Control in Response Header    ${CDN_response}    31535999

    ${files}=    Prepare File    ${directory_file}    ${filename}
    ${expected_cdn_url_with_md5}=    Get Cdn Url Expected    ${expected_cdn_url}    ${files}

    ${response}=    Post Uploads Files    ${GENERAL_API}    ${sub_folder_in_s3}    ${files}    1209600
    Response Should Contain Data And CDN URL Must Matched    ${response}    ${expected_cdn_url_with_md5}    ${files}
    check_message    ${response}    ${messageSuccess}
    ${CDN_response}=    Get Uploaded File from CDN S3    http:${expected_cdn_url_with_md5}
    Verify Cache_Control in Response Header    ${CDN_response}    1209600

TC_WMALL_01769 Upload One File with max_age = -1209600
    [Tags]    post_uploads    api_uploads    api_general
    ${files}=    Prepare File    ${directory_file}    ${filename}
    ${response}=    Post Uploads Files    ${GENERAL_API}    ${sub_folder_in_s3}    ${files}    -1209600
    ${expected_cdn_url_with_md5}=    Get Cdn Url Expected    ${expected_cdn_url}    ${files}
    Response Should Contain Data And CDN URL Must Matched    ${response}    ${expected_cdn_url_with_md5}    ${files}
    check_message    ${response}    ${messageSuccess}
    ${CDN_response}=    Get Uploaded File from CDN S3    http:${expected_cdn_url_with_md5}
    Verify Cache_Control in Response Header    ${CDN_response}    ${default_max_age}

TC_WMALL_01311 Upload file size less than limit (set limit = 11MB)
    [Tags]    post_uploads    api_uploads    api_general
    ${files}=    Prepare File With File Size    ${directory_file}    ${filename_1}    ${file_size_10}
    ${response}=    Post Uploads Files    ${GENERAL_API}    ${sub_folder_in_s3}    ${files}
    ${expected_cdn_url_with_md5}=    Get Cdn Url Expected    ${expected_cdn_url_limit_size}    ${files}
    Response Should Contain Data And CDN URL Must Matched    ${response}    ${expected_cdn_url_with_md5}    ${files}
    check_message    ${response}    ${messageSuccess}

TC_WMALL_01312 Upload file size more than PHP config limit size (set limit = 11MB)
    [Tags]    post_uploads    api_uploads    api_general
    ${files}=    Prepare File With File Size    ${directory_file}    ${filename_2}    ${file_size_11}
    ${response}=    Post Uploads Files    ${GENERAL_API}    ${sub_folder_in_s3}    ${files}
    check_status    ${response}    ${code500}
    check_message    ${response}    ${messageInternalServerError}

TC_WMALL_01313 Upload file size more than Nginx config limit size (set limit = 15MB)
    [Tags]    post_uploads    api_uploads    api_general
    ${files}=    Prepare File With File Size    ${directory_file}    ${filename_3}    ${file_size_15}
    ${response}=    Post Uploads Files    ${GENERAL_API}    ${sub_folder_in_s3}    ${files}
    check_status    ${response}    ${code413}
    check_message_nginx    ${response}    ${messageInternalServerError2}

# Upload File not Exist
#     [Tags]    1234
#     ${files}=    Prepare File    ${directory_file}    ${filename}
#     Delete File Before Send Post Request    ${directory_file}    ${filename}
#     ${response}=    Post Uploads files    ${GENERAL-API}    ${sub_folder_in_s3}    ${files}
#     Check Error and No Data    ${response}
