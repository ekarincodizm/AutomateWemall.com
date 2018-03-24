*** Settings ***
Force Tags        WLS_API_PCMS
Library           HttpLibrary.HTTP
Library           Selenium2Library
Library           Collections
Library           String
Library           BuiltIn
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Collection/keywords_api_collection.robot
# Library           ${CURDIR}/../../../Python_Library/common.py
# Library           ${CURDIR}/../../../Python_Library/DatabaseData.py
# Library           ${CURDIR}/../../../Python_Library/collection.py
# Library           ${CURDIR}/../../../Python_Library/common/csvlibrary.py
# Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Collection/keywords_collection.robot
# Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot


*** Variables ***
${TC_iTM_03457_limit}            10000
# ${TC_iTM_03457_Expected_data}    166
${TC_iTM_03458_level1_collection_pkey}   3701719194416
${TC_iTM_03458_collection_name}      Test API Collections Lv1
${TC_iTM_03458_collection_slug}      test-api-collections-lv1
${TC_iTM_03459_collection_pkey_delete}   3701719194417
${TC_iTM_03460_collection_pkey_edit}   3701719194420
${TC_iTM_03460_collection_name}   Antman Test API
${TC_iTM_03460_collection_slug}   antman-test-api
${TC_iTM_03460_collection_name_edit}      Antman Test API Edit01
${TC_iTM_03460_collection_slug_edit}      antman-test-api-edit01
${TC_iTM_03461_collection_pkey}   3778827517882

*** Test cases ***

TC_iTM_03457 Get All Collection
    [Tags]     TC_iTM_03457    API Collections    ITMA-3106    Get_All_Collection      regression   ready    WLS_High
    ${body}=  Call API Get Body   ${PCMS_API_URL}    /api/45311375168544/collections?limit=${TC_iTM_03457_limit}
    Verify Coed in Response     ${body}     200
    ${Expected_data}=    Count collection
    Count Data Json     ${body}     /data       ${Expected_data}

TC_iTM_03458 Get New collection
    [Tags]     TC_iTM_03458    API Collections    ITMA-3106    Get_New_collection      regression   ready    WLS_Medium

    ${level1_collection_id}=    Create collection level1   0    ${TC_iTM_03458_level1_collection_pkey}    ${TC_iTM_03458_collection_name}    ${TC_iTM_03458_collection_slug}
    ${body}=  Call API Get Body   ${PCMS_URL_API}   /api/45311375168544/collections/${TC_iTM_03458_level1_collection_pkey}
    Verify Coed in Response     ${body}     200
    Verify pkey in Response     ${body}     ${TC_iTM_03458_level1_collection_pkey}
    Verify Name in Response     ${body}     ${TC_iTM_03458_collection_name}
    Verify Slug in Response     ${body}     ${TC_iTM_03458_collection_slug}
    [teardown]
    delete_collection_by_collection_id   ${level1_collection_id}


TC_iTM_03459 Delete collection
    [Tags]     TC_iTM_03459    API Collections    ITMA-3106    Delete_Collection     regression     ready    WLS_Medium
    ${collection_id}=    Create collection level1   0    ${TC_iTM_03459_collection_pkey_delete}    Test delete collection    test-delete-collection
    ${body}=  Call API Get Body   ${PCMS_URL_API}   /api/45311375168544/collections/${TC_iTM_03459_collection_pkey_delete}
    Verify Coed in Response     ${body}     200
    Verify pkey in Response     ${body}     ${TC_iTM_03459_collection_pkey_delete}

    delete_collection_by_collection_id   ${collection_id}
    ${body}=  Call API Get Body   ${PCMS_URL_API}   /api/45311375168544/collections/${TC_iTM_03459_collection_pkey_delete}
    Verify status in Response     ${body}     "error"
    Verify Coed in Response     ${body}     404
    Verify message in Response  ${body}     "404 Not Found"


TC_iTM_03460 Update Collection
    [Tags]     TC_iTM_03460    API Collections    ITMA-3106    Update_Collection     regression     ready    WLS_Medium
    ${collection_id}=    Create collection level1   0    ${TC_iTM_03460_collection_pkey_edit}    ${TC_iTM_03460_collection_name}    ${TC_iTM_03460_collection_slug}

    Open Browser   ${PCMS_URL}/#logged_in   chrome
    Maximize Browser Window
    Login PCMS      ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    Collections - Go To Collections Management Page
    ${colection_data}=    Collections - Get Collection Data By Name    ${TC_iTM_03460_collection_name}
    Wait Until Element Is Visible     xpath=${text_header}   20s      Page "Collections Management" not found
    Collections - Click Edit Collection     ${colection_data}
    Wait Until Element Is Visible     xpath=//*[@class='mws-form-item']     10s      Page "Edit Collection" not found
    Update Collection       ${TC_iTM_03460_collection_name_edit}    ${TC_iTM_03460_collection_slug_edit}
    Click Element       ${save_button}
    Wait Until Element Is Visible     xpath=${text_header}   20s      Save Fail


    ${body}=  Call API Get Body   ${PCMS_URL_API}   /api/45311375168544/collections/${TC_iTM_03460_collection_pkey_edit}
    Verify Coed in Response     ${body}     200
    Verify pkey in Response     ${body}     ${TC_iTM_03460_collection_pkey_edit}
    Verify Name in Response     ${body}     ${TC_iTM_03460_collection_name_edit}
    Verify Slug in Response     ${body}     ${TC_iTM_03460_collection_slug_edit}
    [teardown]      Run keywords    delete_collection_by_collection_id   ${collection_id}
    ...    AND     Close Browser


TC_iTM_03461 Get Collections by ListBrands
    [Tags]     TC_iTM_03461    API Collections    ITMA-3106    Get_Collections_by_ListBrands     regression     ready    WLS_Medium
    ${body}=  Call API Get Body   ${PCMS_API_URL}    /api/45311375168544/collections/${TC_iTM_03461_collection_pkey}/brands
    Verify Coed in Response     ${body}     200
    ${Expected_data}=    Count collection List brand    ${TC_iTM_03461_collection_pkey}
    Count Data Json     ${body}     /data       ${Expected_data}
