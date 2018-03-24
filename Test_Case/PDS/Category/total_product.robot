*** Setting ***
Library           HttpLibrary.HTTP
Library           DatabaseLibrary
Library           Collections
Library           ${CURDIR}/../../../Python_Library/common.py
Library           ${CURDIR}/../../../Python_Library/common/csvlibrary.py
Library           ${CURDIR}/../../../Python_Library/common/uploadsoperation.py
Library           ${CURDIR}/../../../Python_Library/FileKeyword.py
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/API/PDS/pds_api_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PDS/Keywords_PDS_Common.robot
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Resource/TestData/pds/test_data.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Shop/keywords_shop.robot
Test Teardown     Delete Data



*** Variables ***
${parent_id}               1
${sum}             ${EMPTY}
${cat_id_1}        ${EMPTY}
${cat_id_1_1}      ${EMPTY}
${cat_id_1_2}      ${EMPTY}
${cat_id_1_2_1}    ${EMPTY}
${merchant_code}    AM00003
*** Keywords ***
Delete Data
    Run keyword If    "${cat_id_1_2_1}" != "${EMPTY}"    Run Keywords    Log    ${cat_id_1_2_1}    AND    Permanent Delete Category By Category ID    ${cat_id_1_2_1}    AND    Log To Console    Delete Data Category ID 1-2-1 Success
    Run keyword If    "${cat_id_1_2}" != "${EMPTY}"    Run Keywords    Log    ${cat_id_1_2}    AND    Permanent Delete Category By Category ID    ${cat_id_1_2}    AND    Log To Console    Delete Data Category ID 1-2 Success
    Run keyword If    "${cat_id_1_1}" != "${EMPTY}"    Run Keywords    Log    ${cat_id_1_1}    AND    Permanent Delete Category By Category ID    ${cat_id_1_1}    AND    Log To Console    Delete Data Category ID 1-1 Success
    Run keyword If    "${cat_id_1}" != "${EMPTY}"    Run Keywords    Log    ${cat_id_1}    AND    Permanent Delete Category By Category ID    ${cat_id_1}    AND    Log To Console    Delete Data Category ID 1 Success


*** Test Cases ***
TC_ITMWM_05100 View All: Category has some products
    [Tags]    TC_ITMWM_05100    phoenix    PDS_API    All_Cat
    ${cat_id_1}    ${cat_pkey_1}=    Create Category level 1
    Add Product To Category 1 Product A    ${cat_pkey_1}
    Verify Total Product By Get All Category    ${cat_id_1}     1

TC_ITMWM_05101 View All: Category and sub-category have some products
    [Tags]    TC_ITMWM_05101    phoenix    PDS_API    All_Cat
    ${cat_id_1}    ${cat_pkey_1}=    Create Category level 1
    Add Product To Category 1 Product A   ${cat_pkey_1}
    ${cat_id_1_1}    ${cat_pkey_1_1}=    Create Category sub level 1-1    ${cat_id_1}
    Add Product To Category 1 Product B   ${cat_pkey_1_1}
    Verify Total Product By Get All Category    ${cat_id_1}     2
    Verify Total Product By Get All Category    ${cat_id_1_1}     1

TC_ITMWM_05102 View All: Category has no product but all sub-categories have some products
    [Tags]    TC_ITMWM_05102    phoenix    PDS_API    All_Cat
    ${cat_id_1}    ${cat_pkey_1}=    Create Category level 1
    ${cat_id_1_1}    ${cat_pkey_1_1}=    Create Category sub level 1-1    ${cat_id_1}
    Add Product To Category 1 Product A   ${cat_pkey_1_1}
    ${cat_id_1_2}    ${cat_pkey_1_2}=    Create Category sub level 1-2    ${cat_id_1}
    Add Product To Category 1 Product B   ${cat_pkey_1_2}
    Verify Total Product By Get All Category    ${cat_id_1}     2
    Verify Total Product By Get All Category    ${cat_id_1_1}     1
    Verify Total Product By Get All Category    ${cat_id_1_2}     1

TC_ITMWM_05103 View All: Category and some sub-categories have no product but some sub-categories have some products
    [Tags]    TC_ITMWM_05103    phoenix    PDS_API    All_Cat
    ${cat_id_1}    ${cat_pkey_1}=    Create Category level 1
    Add Product To Category 1 Product A   ${cat_pkey_1}
    ${cat_id_1_1}    ${cat_pkey_1_1}=    Create Category sub level 1-1    ${cat_id_1}
    ${cat_id_1_2}    ${cat_pkey_1_2}=    Create Category sub level 1-2    ${cat_id_1}
    Add Product To Category 1 Product A   ${cat_pkey_1_2}
    ${cat_id_1_2_1}    ${cat_pkey_1_2_1}=    Create Category sub level 1-2-1    ${cat_id_1_2}
    Add Product To Category 1 Product B   ${cat_pkey_1_2_1}
    Verify Total Product By Get All Category    ${cat_id_1}     2
    Verify Total Product By Get All Category    ${cat_id_1_1}     0
    Verify Total Product By Get All Category    ${cat_id_1_2}     2
    Verify Total Product By Get All Category    ${cat_id_1_2_1}     1
TC_ITMWM_05104 View All: Category and sub-category have some of same products
    [Tags]    TC_ITMWM_05104    phoenix    PDS_API    All_Cat
    ${cat_id_1}    ${cat_pkey_1}=    Create Category level 1
    Add Product To Category 1 Product A   ${cat_pkey_1}
    ${cat_id_1_1}    ${cat_pkey_1_1}=    Create Category sub level 1-1    ${cat_id_1}
    Add Product To Category 1 Product A   ${cat_pkey_1_1}
    Add Product To Category 1 Product B   ${cat_pkey_1_1}
    ${cat_id_1_2}    ${cat_pkey_1_2}=    Create Category sub level 1-2    ${cat_id_1}
    Add Product To Category 1 Product B   ${cat_pkey_1_2}
    ${cat_id_1_2_1}    ${cat_pkey_1_2_1}=    Create Category sub level 1-2-1    ${cat_id_1_2}
    Add Product To Category 1 Product C   ${cat_pkey_1_2_1}
    Verify Total Product By Get All Category    ${cat_id_1}     3
    Verify Total Product By Get All Category    ${cat_id_1_1}     2
    Verify Total Product By Get All Category    ${cat_id_1_2}     2
    Verify Total Product By Get All Category    ${cat_id_1_2_1}     1

TC_ITMWM_05105 View By Category ID: Category has some products
    [Tags]    TC_ITMWM_05105    phoenix    PDS_API    Cat_ID
    ${cat_id_1}    ${cat_pkey_1}=    Create Category level 1
    Add Product To Category 1 Product A    ${cat_pkey_1}
    Verify Total Product By Category ID    ${cat_id_1}    ${cat_pkey_1}    1

TC_ITMWM_05106 View By Category ID: Category and sub-category have some products
    [Tags]    TC_ITMWM_05106    phoenix    PDS_API    Cat_ID
    ${cat_id_1}    ${cat_pkey_1}=    Create Category level 1
    Add Product To Category 1 Product A   ${cat_pkey_1}
    ${cat_id_1_1}    ${cat_pkey_1_1}=    Create Category sub level 1-1    ${cat_id_1}
    Add Product To Category 1 Product B   ${cat_pkey_1_1}
    Verify Total Product By Category ID    ${cat_id_1}    ${cat_pkey_1}    2
    Verify Total Product By Category ID    ${cat_id_1_1}    ${cat_pkey_1_1}    1

TC_ITMWM_05107 View By Category ID: Category has no product but all sub-categories have some products
    [Tags]    TC_ITMWM_05107    phoenix    PDS_API    Cat_ID
    ${cat_id_1}    ${cat_pkey_1}=    Create Category level 1
    ${cat_id_1_1}    ${cat_pkey_1_1}=    Create Category sub level 1-1    ${cat_id_1}
    Add Product To Category 1 Product A   ${cat_pkey_1_1}
    ${cat_id_1_2}    ${cat_pkey_1_2}=    Create Category sub level 1-2    ${cat_id_1}
    Add Product To Category 1 Product B   ${cat_pkey_1_2}
    Verify Total Product By Category ID    ${cat_id_1}    ${cat_pkey_1}    2
    Verify Total Product By Category ID    ${cat_id_1_1}    ${cat_pkey_1_1}    1
    Verify Total Product By Category ID    ${cat_id_1_2}    ${cat_pkey_1_2}    1

TC_ITMWM_05108 View By Category ID: Category and some sub-categories have no product but some sub-categories have some products
    [Tags]    TC_ITMWM_05108    phoenix    PDS_API    Cat_ID
    ${cat_id_1}    ${cat_pkey_1}=    Create Category level 1
    Add Product To Category 1 Product A   ${cat_pkey_1}
    ${cat_id_1_1}    ${cat_pkey_1_1}=    Create Category sub level 1-1    ${cat_id_1}
    ${cat_id_1_2}    ${cat_pkey_1_2}=    Create Category sub level 1-2    ${cat_id_1}
    Add Product To Category 1 Product A   ${cat_pkey_1_2}
    ${cat_id_1_2_1}    ${cat_pkey_1_2_1}=    Create Category sub level 1-2-1    ${cat_id_1_2}
    Add Product To Category 1 Product B   ${cat_pkey_1_2_1}
    Verify Total Product By Category ID    ${cat_id_1}    ${cat_pkey_1}    2
    Verify Total Product By Category ID    ${cat_id_1_1}    ${cat_pkey_1_1}    0
    Verify Total Product By Category ID    ${cat_id_1_2}    ${cat_pkey_1_2}    2
    Verify Total Product By Category ID    ${cat_id_1_2_1}    ${cat_pkey_1_2_1}    1

TC_ITMWM_05109 View By Category ID: Category and sub-category have some of same products
    [Tags]    TC_ITMWM_05109    phoenix    PDS_API    Cat_ID
    ${cat_id_1}    ${cat_pkey_1}=    Create Category level 1
    Add Product To Category 1 Product A   ${cat_pkey_1}
    ${cat_id_1_1}    ${cat_pkey_1_1}=    Create Category sub level 1-1    ${cat_id_1}
    Add Product To Category 1 Product A   ${cat_pkey_1_1}
    Add Product To Category 1 Product B   ${cat_pkey_1_1}
    ${cat_id_1_2}    ${cat_pkey_1_2}=    Create Category sub level 1-2    ${cat_id_1}
    Add Product To Category 1 Product B   ${cat_pkey_1_2}
    ${cat_id_1_2_1}    ${cat_pkey_1_2_1}=    Create Category sub level 1-2-1    ${cat_id_1_2}
    Add Product To Category 1 Product C   ${cat_pkey_1_2_1}
    Verify Total Product By Category ID    ${cat_id_1}    ${cat_pkey_1}    3
    Verify Total Product By Category ID    ${cat_id_1_1}    ${cat_pkey_1_1}    2
    Verify Total Product By Category ID    ${cat_id_1_2}    ${cat_pkey_1_2}    2
    Verify Total Product By Category ID    ${cat_id_1_2_1}    ${cat_pkey_1_2_1}    1
TC_ITMWM_05110 View By Merchant ID: Category has some products
    [Tags]    TC_ITMWM_05110    phoenix    PDS_API    Merchant_ID
    ${cat_id_1}    ${cat_pkey_1}=    Create Category level 1
    Add Product To Category 1 Product A    ${cat_pkey_1}
    Verify Total Product By Merchant Code    ${cat_id_1}    ${merchant_code}    1
TC_ITMWM_05111 View By Merchant ID: Category and sub-category have some products
    [Tags]    TC_ITMWM_05111    phoenix    PDS_API    Merchant_ID
    ${cat_id_1}    ${cat_pkey_1}=    Create Category level 1
    Add Product To Category 1 Product A   ${cat_pkey_1}
    ${cat_id_1_1}    ${cat_pkey_1_1}=    Create Category sub level 1-1    ${cat_id_1}
    Add Product To Category 1 Product B   ${cat_pkey_1_1}
    Verify Total Product By Merchant Code    ${cat_id_1}    ${merchant_code}    2
    Verify Total Product By Merchant Code    ${cat_id_1_1}    ${merchant_code}    1
TC_ITMWM_05112 View By Merchant ID: Category has no product but all sub-categories have some products
    [Tags]    TC_ITMWM_05112    phoenix    PDS_API    Merchant_ID
    ${cat_id_1}    ${cat_pkey_1}=    Create Category level 1
    ${cat_id_1_1}    ${cat_pkey_1_1}=    Create Category sub level 1-1    ${cat_id_1}
    Add Product To Category 1 Product A   ${cat_pkey_1_1}
    ${cat_id_1_2}    ${cat_pkey_1_2}=    Create Category sub level 1-2    ${cat_id_1}
    Add Product To Category 1 Product B   ${cat_pkey_1_2}
    Verify Total Product By Merchant Code    ${cat_id_1}    ${merchant_code}    2
    Verify Total Product By Merchant Code    ${cat_id_1_1}    ${merchant_code}    1
    Verify Total Product By Merchant Code    ${cat_id_1_2}    ${merchant_code}    1
TC_ITMWM_05113 View By Merchant ID: Category and some sub-categories have no product but some sub-categories have some products
    [Tags]    TC_ITMWM_05113    phoenix    PDS_API    Merchant_ID
    ${cat_id_1}    ${cat_pkey_1}=    Create Category level 1
    Add Product To Category 1 Product A   ${cat_pkey_1}
    ${cat_id_1_1}    ${cat_pkey_1_1}=    Create Category sub level 1-1    ${cat_id_1}
    ${cat_id_1_2}    ${cat_pkey_1_2}=    Create Category sub level 1-2    ${cat_id_1}
    Add Product To Category 1 Product A   ${cat_pkey_1_2}
    ${cat_id_1_2_1}    ${cat_pkey_1_2_1}=    Create Category sub level 1-2-1    ${cat_id_1_2}
    Add Product To Category 1 Product B   ${cat_pkey_1_2_1}
    Verify Total Product By Merchant Code    ${cat_id_1}    ${merchant_code}    2
    Verify Total Product By Merchant Code    ${cat_id_1_1}    ${merchant_code}    0
    Verify Total Product By Merchant Code    ${cat_id_1_2}    ${merchant_code}    2
    Verify Total Product By Merchant Code    ${cat_id_1_2_1}    ${merchant_code}    1
TC_ITMWM_05114 View By Merchant ID: Category and sub-category have some of same products
    [Tags]    TC_ITMWM_05114    phoenix    PDS_API    Merchant_ID
    ${cat_id_1}    ${cat_pkey_1}=    Create Category level 1
    Add Product To Category 1 Product A   ${cat_pkey_1}
    ${cat_id_1_1}    ${cat_pkey_1_1}=    Create Category sub level 1-1    ${cat_id_1}
    Add Product To Category 1 Product A   ${cat_pkey_1_1}
    Add Product To Category 1 Product B   ${cat_pkey_1_1}
    ${cat_id_1_2}    ${cat_pkey_1_2}=    Create Category sub level 1-2    ${cat_id_1}
    Add Product To Category 1 Product B   ${cat_pkey_1_2}
    ${cat_id_1_2_1}    ${cat_pkey_1_2_1}=    Create Category sub level 1-2-1    ${cat_id_1_2}
    Add Product To Category 1 Product C   ${cat_pkey_1_2_1}
    Verify Total Product By Merchant Code    ${cat_id_1}    ${merchant_code}    3
    Verify Total Product By Merchant Code    ${cat_id_1_1}    ${merchant_code}    2
    Verify Total Product By Merchant Code    ${cat_id_1_2}    ${merchant_code}    2
    Verify Total Product By Merchant Code    ${cat_id_1_2_1}    ${merchant_code}    1


TC_ITMWM_05632 View By Pkey: Category has some products
    [Tags]    TC_ITMWM_05632    phoenix    PDS_API    PKey
    ${cat_id_1}    ${cat_pkey_1}=    Create Category level 1
    Add Product To Category 1 Product A    ${cat_pkey_1}
    Verify Total Product By Category Pkey    ${cat_id_1}    ${cat_pkey_1}    1

TC_ITMWM_05633 View By Pkey: Category and sub-category have some products
    [Tags]    TC_ITMWM_05633    phoenix    PDS_API    PKey
    ${cat_id_1}    ${cat_pkey_1}=    Create Category level 1
    Add Product To Category 1 Product A   ${cat_pkey_1}
    ${cat_id_1_1}    ${cat_pkey_1_1}=    Create Category sub level 1-1    ${cat_id_1}
    Add Product To Category 1 Product B   ${cat_pkey_1_1}
    Verify Total Product By Category Pkey    ${cat_id_1}    ${cat_pkey_1}    2
    Verify Total Product By Category Pkey    ${cat_id_1_1}    ${cat_pkey_1_1}    1

TC_ITMWM_05634 View By Pkey: Category has no product but all sub-categories have some products
    [Tags]    TC_ITMWM_05634    phoenix    PDS_API    PKey
    ${cat_id_1}    ${cat_pkey_1}=    Create Category level 1
    ${cat_id_1_1}    ${cat_pkey_1_1}=    Create Category sub level 1-1    ${cat_id_1}
    Add Product To Category 1 Product A   ${cat_pkey_1_1}
    ${cat_id_1_2}    ${cat_pkey_1_2}=    Create Category sub level 1-2    ${cat_id_1}
    Add Product To Category 1 Product B   ${cat_pkey_1_2}
    Verify Total Product By Category Pkey    ${cat_id_1}    ${cat_pkey_1}    2
    Verify Total Product By Category Pkey    ${cat_id_1_1}    ${cat_pkey_1_1}    1
    Verify Total Product By Category Pkey    ${cat_id_1_2}    ${cat_pkey_1_2}    1

TC_ITMWM_05635 View By Pkey: Category and some sub-categories have no product but some sub-categories have some products
    [Tags]    TC_ITMWM_05635    phoenix    PDS_API    PKey
    ${cat_id_1}    ${cat_pkey_1}=    Create Category level 1
    Add Product To Category 1 Product A   ${cat_pkey_1}
    ${cat_id_1_1}    ${cat_pkey_1_1}=    Create Category sub level 1-1    ${cat_id_1}
    ${cat_id_1_2}    ${cat_pkey_1_2}=    Create Category sub level 1-2    ${cat_id_1}
    Add Product To Category 1 Product A   ${cat_pkey_1_2}
    ${cat_id_1_2_1}    ${cat_pkey_1_2_1}=    Create Category sub level 1-2-1    ${cat_id_1_2}
    Add Product To Category 1 Product B   ${cat_pkey_1_2_1}
    Verify Total Product By Category Pkey    ${cat_id_1}    ${cat_pkey_1}    2
    Verify Total Product By Category Pkey    ${cat_id_1_1}    ${cat_pkey_1_1}    0
    Verify Total Product By Category Pkey    ${cat_id_1_2}    ${cat_pkey_1_2}    2
    Verify Total Product By Category Pkey    ${cat_id_1_2_1}    ${cat_pkey_1_2_1}    1

TC_ITMWM_05636 View By Pkey: Category and sub-category have some of same products
    [Tags]    TC_ITMWM_05636    phoenix    PDS_API    PKey
    ${cat_id_1}    ${cat_pkey_1}=    Create Category level 1
    Add Product To Category 1 Product A   ${cat_pkey_1}
    ${cat_id_1_1}    ${cat_pkey_1_1}=    Create Category sub level 1-1    ${cat_id_1}
    Add Product To Category 1 Product A   ${cat_pkey_1_1}
    Add Product To Category 1 Product B   ${cat_pkey_1_1}
    ${cat_id_1_2}    ${cat_pkey_1_2}=    Create Category sub level 1-2    ${cat_id_1}
    Add Product To Category 1 Product B   ${cat_pkey_1_2}
    ${cat_id_1_2_1}    ${cat_pkey_1_2_1}=    Create Category sub level 1-2-1    ${cat_id_1_2}
    Add Product To Category 1 Product C   ${cat_pkey_1_2_1}
    Verify Total Product By Category Pkey    ${cat_id_1}    ${cat_pkey_1}    3
    Verify Total Product By Category Pkey    ${cat_id_1_1}    ${cat_pkey_1_1}    2
    Verify Total Product By Category Pkey    ${cat_id_1_2}    ${cat_pkey_1_2}    2
    Verify Total Product By Category Pkey    ${cat_id_1_2_1}    ${cat_pkey_1_2_1}    1

TC_ITMWM_05637 View By Root Category: Category has some products
    [Tags]    TC_ITMWM_05637    phoenix    PDS_API    Root_Cat
    ${cat_id_1}    ${cat_pkey_1}=    Create Category level 1
    Add Product To Category 1 Product A    ${cat_pkey_1}
    Verify Total Product By Get Category Root    ${cat_id_1}     1

TC_ITMWM_05638 View By Root Category: Category and sub-category have some products
    [Tags]    TC_ITMWM_05638    phoenix
    ${cat_id_1}    ${cat_pkey_1}=    Create Category level 1
    Add Product To Category 1 Product A  ${cat_pkey_1}
    ${cat_id_1_1}    ${cat_pkey_1_1}=    Create Category sub level 1-1    ${cat_id_1}
    Add Product To Category 1 Product B   ${cat_pkey_1_1}
    Verify Total Product By Get Category Root    ${cat_id_1}     2

TC_ITMWM_05639 View By Root Category: Category has no product but all sub-categories have some products
    [Tags]    TC_ITMWM_05639    phoenix    PDS_API    Root_Cat
    ${cat_id_1}    ${cat_pkey_1}=    Create Category level 1
    ${cat_id_1_1}    ${cat_pkey_1_1}=    Create Category sub level 1-1    ${cat_id_1}
    Add Product To Category 1 Product A   ${cat_pkey_1_1}
    ${cat_id_1_2}    ${cat_pkey_1_2}=    Create Category sub level 1-2    ${cat_id_1}
    Add Product To Category 1 Product B   ${cat_pkey_1_2}
    Verify Total Product By Get Category Root    ${cat_id_1}     2


TC_ITMWM_05640 View By Root Category: Category and some sub-categories have no product but some sub-categories have some products
    [Tags]    TC_ITMWM_05640    phoenix    PDS_API    Root_Cat
    ${cat_id_1}    ${cat_pkey_1}=    Create Category level 1
    Add Product To Category 1 Product A   ${cat_pkey_1}
    ${cat_id_1_1}    ${cat_pkey_1_1}=    Create Category sub level 1-1    ${cat_id_1}
    ${cat_id_1_2}    ${cat_pkey_1_2}=    Create Category sub level 1-2    ${cat_id_1}
    Add Product To Category 1 Product A   ${cat_pkey_1_2}
    ${cat_id_1_2_1}    ${cat_pkey_1_2_1}=    Create Category sub level 1-2-1    ${cat_id_1_2}
    Add Product To Category 1 Product B   ${cat_pkey_1_2_1}
    Verify Total Product By Get Category Root    ${cat_id_1}    2

TC_ITMWM_05641 View By Root Category: Category and sub-category have some of same products
    [Tags]    TC_ITMWM_05641    phoenix    PDS_API    Root_Cat
    ${cat_id_1}    ${cat_pkey_1}=    Create Category level 1
    Add Product To Category 1 Product A   ${cat_pkey_1}
    ${cat_id_1_1}    ${cat_pkey_1_1}=    Create Category sub level 1-1    ${cat_id_1}
    Add Product To Category 1 Product A   ${cat_pkey_1_1}
    Add Product To Category 1 Product B   ${cat_pkey_1_1}
    ${cat_id_1_2}    ${cat_pkey_1_2}=    Create Category sub level 1-2    ${cat_id_1}
    Add Product To Category 1 Product B   ${cat_pkey_1_2}
    ${cat_id_1_2_1}    ${cat_pkey_1_2_1}=    Create Category sub level 1-2-1    ${cat_id_1_2}
    Add Product To Category 1 Product C   ${cat_pkey_1_2_1}
    Verify Total Product By Get Category Root    ${cat_id_1}    3

TC_ITMWM_05642 View By Root Merchant: Category has some products
    [Tags]    TC_ITMWM_05642    phoenix    PDS_API    Cat_Root_By_Merchant
    ${cat_id_1}    ${cat_pkey_1}=    Create Category level 1
    Add Product To Category 1 Product A    ${cat_pkey_1}
    Verify Total Product By Get Category Root From Merchant Code    ${cat_id_1}    1

TC_ITMWM_05643 View By Root Merchant: Category and sub-category have some products
    [Tags]    TC_ITMWM_05643    phoenix    PDS_API    Cat_Root_By_Merchant
    ${cat_id_1}    ${cat_pkey_1}=    Create Category level 1
    Add Product To Category 1 Product A   ${cat_pkey_1}
    ${cat_id_1_1}    ${cat_pkey_1_1}=    Create Category sub level 1-1    ${cat_id_1}
    Add Product To Category 1 Product B   ${cat_pkey_1_1}
    Verify Total Product By Get Category Root From Merchant Code    ${cat_id_1}    2

TC_ITMWM_05644 View By Root Merchant: Category has no product but all sub-categories have some products
    [Tags]    TC_ITMWM_05644    phoenix    PDS_API    Cat_Root_By_Merchant
    ${cat_id_1}    ${cat_pkey_1}=    Create Category level 1
    ${cat_id_1_1}    ${cat_pkey_1_1}=    Create Category sub level 1-1    ${cat_id_1}
    Add Product To Category 1 Product A   ${cat_pkey_1_1}
    ${cat_id_1_2}    ${cat_pkey_1_2}=    Create Category sub level 1-2    ${cat_id_1}
    Add Product To Category 1 Product B   ${cat_pkey_1_2}
    Verify Total Product By Get Category Root From Merchant Code    ${cat_id_1}    2

TC_ITMWM_05645 View By Root Merchant: Category and some sub-categories have no product but some sub-categories have some products
    [Tags]    TC_ITMWM_05645    phoenix    PDS_API    Cat_Root_By_Merchant
    ${cat_id_1}    ${cat_pkey_1}=    Create Category level 1
    Add Product To Category 1 Product A   ${cat_pkey_1}
    ${cat_id_1_1}    ${cat_pkey_1_1}=    Create Category sub level 1-1    ${cat_id_1}
    ${cat_id_1_2}    ${cat_pkey_1_2}=    Create Category sub level 1-2    ${cat_id_1}
    Add Product To Category 1 Product A   ${cat_pkey_1_2}
    ${cat_id_1_2_1}    ${cat_pkey_1_2_1}=    Create Category sub level 1-2-1    ${cat_id_1_2}
    Add Product To Category 1 Product B   ${cat_pkey_1_2_1}
    Verify Total Product By Get Category Root From Merchant Code    ${cat_id_1}    2

TC_ITMWM_05646 View By Root Merchant: Category and sub-category have some of same products
    [Tags]    TC_ITMWM_05646    phoenix    PDS_API    Cat_Root_By_Merchant
    ${cat_id_1}    ${cat_pkey_1}=    Create Category level 1
    Add Product To Category 1 Product A   ${cat_pkey_1}
    ${cat_id_1_1}    ${cat_pkey_1_1}=    Create Category sub level 1-1    ${cat_id_1}
    Add Product To Category 1 Product A   ${cat_pkey_1_1}
    Add Product To Category 1 Product B   ${cat_pkey_1_1}
    ${cat_id_1_2}    ${cat_pkey_1_2}=    Create Category sub level 1-2    ${cat_id_1}
    Add Product To Category 1 Product B   ${cat_pkey_1_2}
    ${cat_id_1_2_1}    ${cat_pkey_1_2_1}=    Create Category sub level 1-2-1    ${cat_id_1_2}
    Add Product To Category 1 Product C   ${cat_pkey_1_2_1}
    Verify Total Product By Get Category Root From Merchant Code    ${cat_id_1}    3

















































