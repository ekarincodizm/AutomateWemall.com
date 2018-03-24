*** Settings ***
Force Tags        WLS_API_PCMS
Library           HttpLibrary.HTTP
Library           Selenium2Library
Library           Collections
Library           String
Library           BuiltIn
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Brand/keywords_api_brand.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Collection/keywords_api_collection.robot

*** Variables ***

${TC_iTM_03462_limit}            10000
${TC_iTM_03463_Brand_Name}   API Test Create Brand
${TC_iTM_03463_Brand_Description}   API Test Create Brand
${TC_iTM_03464_Brand_search}   Test API Brand
${TC_iTM_03464_Brand_Name}   Test API Brand Edit
${TC_iTM_03464_Brand_Description}   Des Test API Brand Edit

*** Test cases ***

TC_iTM_03462 GET All Brands
    [Tags]     TC_iTM_03457    API Brand    ITMA-3106    Get_All_Brands   ready   regression    WLS_High
    ${body}=  Call API Get Body   ${PCMS_URL_API}    /api/v2/45311375168544/brands?limit=${TC_iTM_03462_limit}
    Verify Coed in Response     ${body}     200
    ${Expected_data}=    Count Brands
    Count Data Json     ${body}     /data       ${Expected_data}


TC_iTM_03463 Get new brand
    [Tags]     TC_iTM_03463    API Brand    ITMA-3106    Get_new_brand    ready    regression    WLS_Medium
    Open Browser   ${PCMS_URL}/#logged_in   chrome
    Maximize Browser Window
    Login PCMS      ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    Create Brand    ${TC_iTM_03463_Brand_Name}      ${TC_iTM_03463_Brand_Description}
    ${rs}=    Get Brand    ${TC_iTM_03463_Brand_Name}
    ${body}=  Call API Get Body   ${PCMS_URL_API}    /api/v2/45311375168544/brands/${rs[0][1]}
    Verify Coed in Response     ${body}     200
    Verify pkey in Response     ${body}     ${rs[0][1]}
    Verify Name in Response     ${body}     ${TC_iTM_03463_Brand_Name}
    Verify Description in Response      ${body}     ${TC_iTM_03463_Brand_Description}
    [Teardown]
    delete_brand_by_brand_id    ${rs[0][0]}
    Close Browser

TC_iTM_03464 Update Brand
    [Tags]     TC_iTM_03464    API Brand    ITMA-3106    Update_Brand    ready    regression    WLS_Medium
    Open Browser   ${PCMS_URL}/#logged_in   chrome
    Maximize Browser Window
    Login PCMS      ${PCMS_USERNAME}    ${PCMS_PASSWORD}
    Create Brand    ${TC_iTM_03464_Brand_search}      ${TC_iTM_03464_Brand_search}_Des
    ${rs}=  update_brand    ${TC_iTM_03464_Brand_search}    ${TC_iTM_03464_Brand_Name}    ${TC_iTM_03464_Brand_Description}
    ${body}=  Call API Get Body   ${PCMS_URL_API}    /api/v2/45311375168544/brands/${rs[0][1]}
    Verify Coed in Response     ${body}     200
    Verify pkey in Response     ${body}     ${rs[0][1]}
    Verify Name in Response     ${body}     ${TC_iTM_03464_Brand_Name}
    Verify Description in Response      ${body}     ${TC_iTM_03464_Brand_Description}
    [Teardown]
    # update_brand    ${TC_iTM_03464_Brand_Name}    ${TC_iTM_03464_Brand_search}    ${TC_iTM_03464_Brand_search}
    delete_brand_by_brand_id    ${rs[0][0]}
    Close Browser
