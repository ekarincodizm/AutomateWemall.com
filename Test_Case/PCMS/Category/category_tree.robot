*** Setting ***
Force Tags    WLS_PCMS_Category
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           BuiltIn
Library           String
Library           OperatingSystem
Library           Collections
Library           DateTime
Library           DatabaseLibrary
Library           ${CURDIR}/../../../Python_Library/common.py
Library           ${CURDIR}/../../../Python_Library/FileKeyword.py
Library           ${CURDIR}/../../../Python_Library/common/uploadsoperation.py
Library           ${CURDIR}/../../../Python_Library/common/csvlibrary.py
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Database/PDS/keyword_merchant.robot
Resource          ${CURDIR}/../../../Keyword/API/PDS/pds_api_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PDS/Keywords_PDS_Common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PDS/webelement_PCMS_Category_Management.robot
Resource          ${CURDIR}/../../../Resource/init.robot
Test Setup        Run Keywords    Login Pcms    AND    Maximize Browser Window
Test Teardown     Close All Browsers

*** Test Cases ***
TC_ITMWM_04868 Show alias name/code and merchant name/code
    [Tags]    TC_ITMWM_04868    regression    ready    phoenix    WLS_High
    #..Create new merchant and alias
    ${merchant_code}=    Set Variable    APHOENIXCODE1
    ${merchant_name}=    Set Variable    A_PHOENIX_1
    ${alias_name}=       Set Variable    Alias PDS
    ${merchant_shop_id}=     Create Merchant in DB          "${merchant_name}"    "${merchant_code}"
    ${merchant_alias_id}=    Create Merchant Alias in DB    "${alias_name}"       "${merchant_code}"

    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    ${name_list}=    Get List of Merchant / Alias Name From Selector
    ${sorted_name_list}=    Copy List    ${name_list}
    Sort List    ${sorted_name_list}
    Lists Should Be Equal    ${name_list}    ${sorted_name_list}
    List Should Contain Value    ${name_list}    ${merchant_name} ( ${merchant_code} )
    List Should Contain Value    ${name_list}    ${alias_name} ( ${merchant_code} )
    [Teardown]    Run Keywords    Delete Merchant From DB    ${merchant_shop_id}    AND    Delete Merchant Alias From DB    ${merchant_alias_id}    AND    Close All Browsers

TC_ITMWM_04869 Verify header at category management tree
    [Tags]    TC_ITMWM_04869    regression    ready    phoenix     WLS_Medium
    Go To Category Management Page
    Go To Category Management Tab
    Verify Category Management Table Header at Category Management Page

TC_ITMWM_04870 Verify merchant's categories when select merchant
    [Tags]    TC_ITMWM_04870    regression    ready    phoenix    WLS_High
    ${tc_number}=    Get Test Case Number
    #..Create new merchant
    ${merchant_code}=    Set Variable    APHOENIXCODE1
    ${merchant_name}=    Set Variable    A_PHOENIX_1
    ${merchant_shop_id}=     Create Merchant in DB    "${merchant_name}"    "${merchant_code}"
    #..Create merchant's categories
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner         "${merchant_code}"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner_type    "merchant"
    #.. CATEGORY 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "inactive"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "0"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    1    ${file_data}
    ${cat_id_1}=     Get Category ID After Creating
    ${cat_pkey_1}=     Get Category Pkey After Creating
    #.. CATEGORY 2
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-2"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "inactive"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    1    ${file_data}
    ${cat_id_2}=     Get Category ID After Creating
    ${cat_pkey_2}=     Get Category Pkey After Creating
    #.. CATEGORY 3
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-3"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "0"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    1    ${file_data}
    ${cat_id_3}=     Get Category ID After Creating
    ${cat_pkey_3}=     Get Category Pkey After Creating
    #.. CATEGORY 1-1.1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1-1_no1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1_1_1}=     Get Category ID After Creating
    ${cat_pkey_1_1_1}=     Get Category Pkey After Creating
    #.. CATEGORY 1-1.2
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1-1_no2"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "inactive"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "0"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1_1_2}=     Get Category ID After Creating
    ${cat_pkey_1_1_2}=     Get Category Pkey After Creating
    #.. CATEGORY 2-1.1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-2-1_no1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "inactive"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${cat_id_2}    ${file_data}
    ${cat_id_2_1_1}=     Get Category ID After Creating
    ${cat_pkey_2_1_1}=     Get Category Pkey After Creating
    #.. CATEGORY 3-1.1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-3-1_no1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "0"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_3}    ${file_data}
    ${cat_id_3_1_1}=     Get Category ID After Creating
    ${cat_pkey_3_1_1}=     Get Category Pkey After Creating
    #.. CATEGORY 3-2.1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-3-2_no1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_3_1_1}    ${file_data}
    ${cat_id_3_2_1}=     Get Category ID After Creating
    ${cat_pkey_3_2_1}=     Get Category Pkey After Creating
    #.. CATEGORY 3-3.1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-3-3_no1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "inactive"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "0"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_3_2_1}    ${file_data}
    ${cat_id_3_3_1}=     Get Category ID After Creating
    ${cat_pkey_3_3_1}=     Get Category Pkey After Creating
    #.. CATEGORY 3-4.1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-3-4_no1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "inactive"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_3_3_1}    ${file_data}
    ${cat_id_3_4_1}=     Get Category ID After Creating
    ${cat_pkey_3_4_1}=     Get Category Pkey After Creating
    #.. CATEGORY 3-5.1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-3-5_no1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "0"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_3_4_1}    ${file_data}
    ${cat_id_3_5_1}=     Get Category ID After Creating
    ${cat_pkey_3_5_1}=     Get Category Pkey After Creating
    #.. CATEGORY 3-6.1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-3-5_no2"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_3_4_1}    ${file_data}
    ${cat_id_3_5_2}=     Get Category ID After Creating
    ${cat_pkey_3_5_2}=     Get Category Pkey After Creating
    ##########################################################################
    # - CATEGORY 1                         (status: inactive, display: 0)
    #   - CATEGORY 1-1.1                   (status: active  , display: 1)
    #   - CATEGORY 1-1.2                   (status: inactive, display: 0)
    # - CATEGORY 2                         (status: inactive, display: 1)
    #   - CATEGORY 2-1.1                   (status: inactive, display: 1)
    # - CATEGORY 3                         (status: active  , display: 0)
    #   - CATEGORY 3-1.1                   (status: active  , display: 0)
    #     - CATEGORY 3-2.1                 (status: active  , display: 1)
    #        - CATEGORY 3-3.1              (status: inactive, display: 0)
    #           - CATEGORY 3-4.1           (status: inactive, display: 1)
    #              - CATEGORY 3-5.1        (status: active  , display: 0)
    #              - CATEGORY 3-5.2        (status: active  , display: 1)
    ##########################################################################
    #.. Generate CSV file to be uploaded
    ${cat_pkey}=        Set Variable    ${cat_pkey_1}
    @{data_name}=       Create List     Category Key     Product Key
    @{data_value1}=     Create List     ${cat_pkey}      &{product-disc-1}[pkey]
    @{data_value2}=     Create List     ${cat_pkey}      &{product-disc-2}[pkey]
    @{data}=            Create List     ${data_name}     ${data_value1}     ${data_value2}

    ${path_file}=       Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}
    #.. Upload Product to categories
    # ${response}=    Add Products To Categories    ${file_upload}
    #...............................
    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    Select Merchant / Alias By Name    ${merchant_name}

    #### (1)level, (2)number_of_sub_cat_order, (3)pkey, (4)name, (5)merchant, (6)number of products, (7)status, (8)display
    @{exp_cat_1}=        Create List    1    ${EMPTY}    ${cat_pkey_1}        ${tc_number}-1          ${merchant_name}    2    inactive    ${false}
    @{exp_cat_1_1_1}=    Create List    1    1.1         ${cat_pkey_1_1_1}    ${tc_number}-1-1_no1    ${merchant_name}    0    active      ${true}
    @{exp_cat_1_1_2}=    Create List    1    1.2         ${cat_pkey_1_1_2}    ${tc_number}-1-1_no2    ${merchant_name}    0    inactive    ${false}
    @{exp_cat_2}=        Create List    2    ${EMPTY}    ${cat_pkey_2}        ${tc_number}-2          ${merchant_name}    0    inactive    ${true}
    @{exp_cat_2_1_1}=    Create List    2    1.1         ${cat_pkey_2_1_1}    ${tc_number}-2-1_no1    ${merchant_name}    0    inactive    ${true}
    @{exp_cat_3}=        Create List    3    ${EMPTY}    ${cat_pkey_3}        ${tc_number}-3          ${merchant_name}    0    active      ${false}
    @{exp_cat_3_1_1}=    Create List    3    1.1         ${cat_pkey_3_1_1}    ${tc_number}-3-1_no1    ${merchant_name}    0    active      ${false}
    @{exp_cat_3_2_1}=    Create List    3    2.1         ${cat_pkey_3_2_1}    ${tc_number}-3-2_no1    ${merchant_name}    0    active      ${true}
    @{exp_cat_3_3_1}=    Create List    3    3.1         ${cat_pkey_3_3_1}    ${tc_number}-3-3_no1    ${merchant_name}    0    inactive    ${false}
    @{exp_cat_3_4_1}=    Create List    3    4.1         ${cat_pkey_3_4_1}    ${tc_number}-3-4_no1    ${merchant_name}    0    inactive    ${true}
    @{exp_cat_3_5_1}=    Create List    3    5.1         ${cat_pkey_3_5_1}    ${tc_number}-3-5_no1    ${merchant_name}    0    active      ${false}
    @{exp_cat_3_5_2}=    Create List    3    5.2         ${cat_pkey_3_5_2}    ${tc_number}-3-5_no2    ${merchant_name}    0    active      ${true}
    @{exp_list}=    Create List    @{exp_cat_1}    @{exp_cat_1_1_1}    @{exp_cat_1_1_2}    @{exp_cat_2}    @{exp_cat_2_1_1}    @{exp_cat_3}    @{exp_cat_3_1_1}    @{exp_cat_3_2_1}    @{exp_cat_3_3_1}    @{exp_cat_3_4_1}    @{exp_cat_3_5_1}    @{exp_cat_3_5_2}

    #.. Click to expand sub categories
    Expand or Collapse Sub-Categories under Category    1
    Expand or Collapse Sub-Categories under Category    2
    Expand or Collapse Sub-Categories under Category    3
    Expand or Collapse Sub-Categories under Category    3    1.1
    Expand or Collapse Sub-Categories under Category    3    2.1
    Expand or Collapse Sub-Categories under Category    3    3.1
    Expand or Collapse Sub-Categories under Category    3    4.1
    Capture Page Screenshot
    :FOR    ${level}    ${number_of_sub_cat_order}    ${expected_pkey}    ${expected_name}    ${expected_merchant}    ${expected_number_of_products}    ${expected_status}    ${expected_display}    IN    @{exp_list}
    \    Verify Category Data in Table at Category Management Page    ${level}    ${number_of_sub_cat_order}    ${expected_pkey}    ${expected_name}    ${expected_merchant}    ${expected_number_of_products}    ${expected_status}    ${expected_display}

   [Teardown]    Run Keywords    Delete Merchant From DB    ${merchant_shop_id}    AND    Run keyword If    "${cat_id_3_5_2}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_3_5_2}\
   ...    AND    Run keyword If    "${cat_id_3_5_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_3_5_1}\
   ...    AND    Run keyword If    "${cat_id_3_4_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_3_4_1}\
   ...    AND    Run keyword If    "${cat_id_3_3_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_3_3_1}\
   ...    AND    Run keyword If    "${cat_id_3_2_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_3_2_1}\
   ...    AND    Run keyword If    "${cat_id_3_1_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_3_1_1}\
   ...    AND    Run keyword If    "${cat_id_3}" != "${EMPTY}"        Permanent Delete Category By Category ID    ${cat_id_3}\
   ...    AND    Run keyword If    "${cat_id_2_1_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_2_1_1}\
   ...    AND    Run keyword If    "${cat_id_2}" != "${EMPTY}"        Permanent Delete Category By Category ID    ${cat_id_2}\
   ...    AND    Run keyword If    "${cat_id_1_1_2}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_1_2}\
   ...    AND    Run keyword If    "${cat_id_1_1_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_1_1}\
   ...    AND    Run keyword If    "${cat_id_1}" != "${EMPTY}"        Permanent Delete Category By Category ID    ${cat_id_1}\
   ...    AND    Close All Browsers

TC_ITMWM_04871 Verify merchant's categories when select alias
    [Tags]    TC_ITMWM_04871    regression    ready    phoenix    WLS_High
    ${tc_number}=    Get Test Case Number
    #..Create new merchant
    ${merchant_code}=    Set Variable    APHOENIXCODE1
    ${merchant_name}=    Set Variable    A_PHOENIX_1
    ${alias_name}=       Set Variable    Alias PDS
    ${merchant_shop_id}=     Create Merchant in DB    "${merchant_name}"    "${merchant_code}"
    ${merchant_alias_id}=     Create Merchant Alias in DB    "${alias_name}"    "${merchant_code}"
    #..Create merchant's categories
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner         "${merchant_code}"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner_type    "alias"
    #.. CATEGORY 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "inactive"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "0"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    1    ${file_data}
    ${cat_id_1}=     Get Category ID After Creating
    ${cat_pkey_1}=     Get Category Pkey After Creating
    #.. CATEGORY 2
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-2"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "inactive"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    1    ${file_data}
    ${cat_id_2}=     Get Category ID After Creating
    ${cat_pkey_2}=     Get Category Pkey After Creating
    #.. CATEGORY 3
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-3"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "0"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    1    ${file_data}
    ${cat_id_3}=     Get Category ID After Creating
    ${cat_pkey_3}=     Get Category Pkey After Creating
    #.. CATEGORY 1-1.1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1-1_no1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1_1_1}=     Get Category ID After Creating
    ${cat_pkey_1_1_1}=     Get Category Pkey After Creating
    #.. CATEGORY 1-1.2
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1-1_no2"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "inactive"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "0"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1_1_2}=     Get Category ID After Creating
    ${cat_pkey_1_1_2}=     Get Category Pkey After Creating
    #.. CATEGORY 2-1.1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-2-1_no1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "inactive"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${cat_id_2}    ${file_data}
    ${cat_id_2_1_1}=     Get Category ID After Creating
    ${cat_pkey_2_1_1}=     Get Category Pkey After Creating
    #.. CATEGORY 3-1.1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-3-1_no1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "0"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_3}    ${file_data}
    ${cat_id_3_1_1}=     Get Category ID After Creating
    ${cat_pkey_3_1_1}=     Get Category Pkey After Creating
    #.. CATEGORY 3-2.1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-3-2_no1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_3_1_1}    ${file_data}
    ${cat_id_3_2_1}=     Get Category ID After Creating
    ${cat_pkey_3_2_1}=     Get Category Pkey After Creating
    #.. CATEGORY 3-3.1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-3-3_no1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "inactive"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "0"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_3_2_1}    ${file_data}
    ${cat_id_3_3_1}=     Get Category ID After Creating
    ${cat_pkey_3_3_1}=     Get Category Pkey After Creating
    #.. CATEGORY 3-4.1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-3-4_no1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "inactive"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_3_3_1}    ${file_data}
    ${cat_id_3_4_1}=     Get Category ID After Creating
    ${cat_pkey_3_4_1}=     Get Category Pkey After Creating
    #.. CATEGORY 3-5.1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-3-5_no1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "0"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_3_4_1}    ${file_data}
    ${cat_id_3_5_1}=     Get Category ID After Creating
    ${cat_pkey_3_5_1}=     Get Category Pkey After Creating
    #.. CATEGORY 3-6.1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-3-5_no2"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_3_4_1}    ${file_data}
    ${cat_id_3_5_2}=     Get Category ID After Creating
    ${cat_pkey_3_5_2}=     Get Category Pkey After Creating
    ##########################################################################
    # - CATEGORY 1                         (status: inactive, display: 0)
    #   - CATEGORY 1-1.1                   (status: active  , display: 1)
    #   - CATEGORY 1-1.2                   (status: inactive, display: 0)
    # - CATEGORY 2                         (status: inactive, display: 1)
    #   - CATEGORY 2-1.1                   (status: inactive, display: 1)
    # - CATEGORY 3                         (status: active  , display: 0)
    #   - CATEGORY 3-1.1                   (status: active  , display: 0)
    #     - CATEGORY 3-2.1                 (status: active  , display: 1)
    #        - CATEGORY 3-3.1              (status: inactive, display: 0)
    #           - CATEGORY 3-4.1           (status: inactive, display: 1)
    #              - CATEGORY 3-5.1        (status: active  , display: 0)
    #              - CATEGORY 3-5.2        (status: active  , display: 1)
    ##########################################################################
    #.. Generate CSV file to be uploaded
    ${cat_pkey}=        Set Variable    ${cat_pkey_1}
    @{data_name}=       Create List     Category Key     Product Key
    @{data_value1}=     Create List     ${cat_pkey}      &{product-disc-1}[pkey]
    @{data_value2}=     Create List     ${cat_pkey}      &{product-disc-2}[pkey]
    @{data}=            Create List     ${data_name}     ${data_value1}     ${data_value2}

    ${path_file}=       Set Category Key and Product Key in file csv     ${data}
    ${file_upload}=     common.Get Canonical Path    ${path_file}
    ${filename}=        Get file name from canonical path    ${file_upload}
    #.. Upload Product to categories
    # ${response}=    Add Products To Categories    ${file_upload}
    #...............................
    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    Select Merchant / Alias By Name    ${alias_name}

    #### (1)level, (2)number_of_sub_cat_order, (3)pkey, (4)name, (5)merchant, (6)number of products, (7)status, (8)display
    @{exp_cat_1}=        Create List    1    ${EMPTY}    ${cat_pkey_1}        ${tc_number}-1          ${merchant_name}    2    inactive    ${false}
    @{exp_cat_1_1_1}=    Create List    1    1.1         ${cat_pkey_1_1_1}    ${tc_number}-1-1_no1    ${merchant_name}    0    active      ${true}
    @{exp_cat_1_1_2}=    Create List    1    1.2         ${cat_pkey_1_1_2}    ${tc_number}-1-1_no2    ${merchant_name}    0    inactive    ${false}
    @{exp_cat_2}=        Create List    2    ${EMPTY}    ${cat_pkey_2}        ${tc_number}-2          ${merchant_name}    0    inactive    ${true}
    @{exp_cat_2_1_1}=    Create List    2    1.1         ${cat_pkey_2_1_1}    ${tc_number}-2-1_no1    ${merchant_name}    0    inactive    ${true}
    @{exp_cat_3}=        Create List    3    ${EMPTY}    ${cat_pkey_3}        ${tc_number}-3          ${merchant_name}    0    active      ${false}
    @{exp_cat_3_1_1}=    Create List    3    1.1         ${cat_pkey_3_1_1}    ${tc_number}-3-1_no1    ${merchant_name}    0    active      ${false}
    @{exp_cat_3_2_1}=    Create List    3    2.1         ${cat_pkey_3_2_1}    ${tc_number}-3-2_no1    ${merchant_name}    0    active      ${true}
    @{exp_cat_3_3_1}=    Create List    3    3.1         ${cat_pkey_3_3_1}    ${tc_number}-3-3_no1    ${merchant_name}    0    inactive    ${false}
    @{exp_cat_3_4_1}=    Create List    3    4.1         ${cat_pkey_3_4_1}    ${tc_number}-3-4_no1    ${merchant_name}    0    inactive    ${true}
    @{exp_cat_3_5_1}=    Create List    3    5.1         ${cat_pkey_3_5_1}    ${tc_number}-3-5_no1    ${merchant_name}    0    active      ${false}
    @{exp_cat_3_5_2}=    Create List    3    5.2         ${cat_pkey_3_5_2}    ${tc_number}-3-5_no2    ${merchant_name}    0    active      ${true}
    @{exp_list}=    Create List    @{exp_cat_1}    @{exp_cat_1_1_1}    @{exp_cat_1_1_2}    @{exp_cat_2}    @{exp_cat_2_1_1}    @{exp_cat_3}    @{exp_cat_3_1_1}    @{exp_cat_3_2_1}    @{exp_cat_3_3_1}    @{exp_cat_3_4_1}    @{exp_cat_3_5_1}    @{exp_cat_3_5_2}

    #.. Click to expand sub categories
    Expand or Collapse Sub-Categories under Category    1
    Expand or Collapse Sub-Categories under Category    2
    Expand or Collapse Sub-Categories under Category    3
    Expand or Collapse Sub-Categories under Category    3    1.1
    Expand or Collapse Sub-Categories under Category    3    2.1
    Expand or Collapse Sub-Categories under Category    3    3.1
    Expand or Collapse Sub-Categories under Category    3    4.1
    Capture Page Screenshot
    :FOR    ${level}    ${number_of_sub_cat_order}    ${expected_pkey}    ${expected_name}    ${expected_merchant}    ${expected_number_of_products}    ${expected_status}    ${expected_display}    IN    @{exp_list}
    \    Verify Category Data in Table at Category Management Page    ${level}    ${number_of_sub_cat_order}    ${expected_pkey}    ${expected_name}    ${expected_merchant}    ${expected_number_of_products}    ${expected_status}    ${expected_display}

   [Teardown]    Run Keywords    Delete Merchant From DB    ${merchant_shop_id}    AND    Delete Merchant Alias From DB    ${merchant_alias_id}\
   ...    AND    Run keyword If    "${cat_id_3_5_2}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_3_5_2}\
   ...    AND    Run keyword If    "${cat_id_3_5_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_3_5_1}\
   ...    AND    Run keyword If    "${cat_id_3_4_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_3_4_1}\
   ...    AND    Run keyword If    "${cat_id_3_3_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_3_3_1}\
   ...    AND    Run keyword If    "${cat_id_3_2_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_3_2_1}\
   ...    AND    Run keyword If    "${cat_id_3_1_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_3_1_1}\
   ...    AND    Run keyword If    "${cat_id_3}" != "${EMPTY}"        Permanent Delete Category By Category ID    ${cat_id_3}\
   ...    AND    Run keyword If    "${cat_id_2_1_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_2_1_1}\
   ...    AND    Run keyword If    "${cat_id_2}" != "${EMPTY}"        Permanent Delete Category By Category ID    ${cat_id_2}\
   ...    AND    Run keyword If    "${cat_id_1_1_2}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_1_2}\
   ...    AND    Run keyword If    "${cat_id_1_1_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_1_1}\
   ...    AND    Run keyword If    "${cat_id_1}" != "${EMPTY}"        Permanent Delete Category By Category ID    ${cat_id_1}\
   ...    AND    Close All Browsers

TC_ITMWM_04872 Verify Expand and collapse categories
    [Tags]    TC_ITMWM_04872    regression    ready    phoenix    WLS_Medium
    ${tc_number}=    Get Test Case Number
    #..Create new merchant
    ${merchant_code}=    Set Variable    APHOENIXCODE1
    ${merchant_name}=    Set Variable    A_PHOENIX_1
    ${merchant_shop_id}=     Create Merchant in DB    "${merchant_name}"    "${merchant_code}"
    #..Create merchant's categories
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner         "${merchant_code}"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner_type    "merchant"
    #.. CATEGORY 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "inactive"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "0"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    1    ${file_data}
    ${cat_id_1}=     Get Category ID After Creating
    ${cat_pkey_1}=     Get Category Pkey After Creating
    #.. CATEGORY 2
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-2"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "inactive"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    1    ${file_data}
    ${cat_id_2}=     Get Category ID After Creating
    ${cat_pkey_2}=     Get Category Pkey After Creating
    #.. CATEGORY 3
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-3"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "0"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    1    ${file_data}
    ${cat_id_3}=     Get Category ID After Creating
    ${cat_pkey_3}=     Get Category Pkey After Creating
    #.. CATEGORY 1-1.1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1-1_no1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1_1_1}=     Get Category ID After Creating
    ${cat_pkey_1_1_1}=     Get Category Pkey After Creating
    #.. CATEGORY 1-1.2
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1-1_no2"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "inactive"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "0"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1_1_2}=     Get Category ID After Creating
    ${cat_pkey_1_1_2}=     Get Category Pkey After Creating
    #.. CATEGORY 2-1.1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-2-1_no1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "inactive"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${cat_id_2}    ${file_data}
    ${cat_id_2_1_1}=     Get Category ID After Creating
    ${cat_pkey_2_1_1}=     Get Category Pkey After Creating
    #.. CATEGORY 3-1.1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-3-1_no1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "0"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_3}    ${file_data}
    ${cat_id_3_1_1}=     Get Category ID After Creating
    ${cat_pkey_3_1_1}=     Get Category Pkey After Creating
    #.. CATEGORY 3-2.1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-3-2_no1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_3_1_1}    ${file_data}
    ${cat_id_3_2_1}=     Get Category ID After Creating
    ${cat_pkey_3_2_1}=     Get Category Pkey After Creating
    #.. CATEGORY 3-3.1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-3-3_no1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "inactive"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "0"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_3_2_1}    ${file_data}
    ${cat_id_3_3_1}=     Get Category ID After Creating
    ${cat_pkey_3_3_1}=     Get Category Pkey After Creating
    #.. CATEGORY 3-4.1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-3-4_no1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "inactive"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_3_3_1}    ${file_data}
    ${cat_id_3_4_1}=     Get Category ID After Creating
    ${cat_pkey_3_4_1}=     Get Category Pkey After Creating
    #.. CATEGORY 3-5.1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-3-5_no1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "0"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_3_4_1}    ${file_data}
    ${cat_id_3_5_1}=     Get Category ID After Creating
    ${cat_pkey_3_5_1}=     Get Category Pkey After Creating
    #.. CATEGORY 3-6.1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-3-5_no2"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status           "active"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display          "1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${cat_id_3_4_1}    ${file_data}
    ${cat_id_3_5_2}=     Get Category ID After Creating
    ${cat_pkey_3_5_2}=     Get Category Pkey After Creating
    ##########################################################################
    # - CATEGORY 1                         (status: inactive, display: 0)
    #   - CATEGORY 1-1.1                   (status: active  , display: 1)
    #   - CATEGORY 1-1.2                   (status: inactive, display: 0)
    # - CATEGORY 2                         (status: inactive, display: 1)
    #   - CATEGORY 2-1.1                   (status: inactive, display: 1)
    # - CATEGORY 3                         (status: active  , display: 0)
    #   - CATEGORY 3-1.1                   (status: active  , display: 0)
    #     - CATEGORY 3-2.1                 (status: active  , display: 1)
    #        - CATEGORY 3-3.1              (status: inactive, display: 0)
    #           - CATEGORY 3-4.1           (status: inactive, display: 1)
    #              - CATEGORY 3-5.1        (status: active  , display: 0)
    #              - CATEGORY 3-5.2        (status: active  , display: 1)
    ##########################################################################
    #..Test Steps
    Go To Category Management Page
    Go To Category Management Tab
    Select Merchant / Alias By Name    ${merchant_name}

    #### (1)level, (2)number_of_sub_cat_order, (3)pkey, (4)name, (5)merchant, (6)number of products, (7)status, (8)display
    @{exp_cat_1}=        Create List    1    ${EMPTY}    ${cat_pkey_1}        ${tc_number}-1          ${merchant_name}    2    inactive    ${false}
    @{exp_cat_1_1_1}=    Create List    1    1.1         ${cat_pkey_1_1_1}    ${tc_number}-1-1_no1    ${merchant_name}    0    active      ${true}
    @{exp_cat_1_1_2}=    Create List    1    1.2         ${cat_pkey_1_1_2}    ${tc_number}-1-1_no2    ${merchant_name}    0    inactive    ${false}
    @{exp_cat_2}=        Create List    2    ${EMPTY}    ${cat_pkey_2}        ${tc_number}-2          ${merchant_name}    0    inactive    ${true}
    @{exp_cat_2_1_1}=    Create List    2    1.1         ${cat_pkey_2_1_1}    ${tc_number}-2-1_no1    ${merchant_name}    0    inactive    ${true}
    @{exp_cat_3}=        Create List    3    ${EMPTY}    ${cat_pkey_3}        ${tc_number}-3          ${merchant_name}    0    active      ${false}
    @{exp_cat_3_1_1}=    Create List    3    1.1         ${cat_pkey_3_1_1}    ${tc_number}-3-1_no1    ${merchant_name}    0    active      ${false}
    @{exp_cat_3_2_1}=    Create List    3    2.1         ${cat_pkey_3_2_1}    ${tc_number}-3-2_no1    ${merchant_name}    0    active      ${true}
    @{exp_cat_3_3_1}=    Create List    3    3.1         ${cat_pkey_3_3_1}    ${tc_number}-3-3_no1    ${merchant_name}    0    inactive    ${false}
    @{exp_cat_3_4_1}=    Create List    3    4.1         ${cat_pkey_3_4_1}    ${tc_number}-3-4_no1    ${merchant_name}    0    inactive    ${true}
    @{exp_cat_3_5_1}=    Create List    3    5.1         ${cat_pkey_3_5_1}    ${tc_number}-3-5_no1    ${merchant_name}    0    active      ${false}
    @{exp_cat_3_5_2}=    Create List    3    5.2         ${cat_pkey_3_5_2}    ${tc_number}-3-5_no2    ${merchant_name}    0    active      ${true}
    @{exp_list}=    Create List    @{exp_cat_1}    @{exp_cat_1_1_1}    @{exp_cat_1_1_2}    @{exp_cat_2}    @{exp_cat_2_1_1}    @{exp_cat_3}    @{exp_cat_3_1_1}    @{exp_cat_3_2_1}    @{exp_cat_3_3_1}    @{exp_cat_3_4_1}    @{exp_cat_3_5_1}    @{exp_cat_3_5_2}

    #### Click to expand sub categories
    Expand or Collapse Sub-Categories under Category    1
    #.. Found sub-cat 1-1.1
    #.. Found sub-cat 1-1.2
    Category Should Be Found at Category Tree    1    1.1
    Category Should Be Found at Category Tree    1    1.2

    Expand or Collapse Sub-Categories under Category    2
    #.. Found sub-cat 2-1.1
    Category Should Be Found at Category Tree    2    1.1

    Expand or Collapse Sub-Categories under Category    3
    #.. Found sub-cat 3-1.1
    Category Should Be Found at Category Tree    3    1.1

    Expand or Collapse Sub-Categories under Category    3    1.1
    #.. Found sub-cat 3-2.1
    Category Should Be Found at Category Tree    3    2.1

    Expand or Collapse Sub-Categories under Category    3    2.1
    #.. Found sub-cat 3-3.1
    Category Should Be Found at Category Tree    3    3.1

    Expand or Collapse Sub-Categories under Category    3    3.1
    #.. Found sub-cat 3-4.1
    Category Should Be Found at Category Tree    3    4.1

    Expand or Collapse Sub-Categories under Category    3    4.1
    #.. Found sub-cat 3-5.1
    #.. Found sub-cat 3-5.2
    Category Should Be Found at Category Tree    3    5.1
    Category Should Be Found at Category Tree    3    5.1

    Capture Page Screenshot

    #### Click to collapse sub categories
    Expand or Collapse Sub-Categories under Category    3    4.1
    #.. Not found sub-cat 3-5.1
    #.. Not found sub-cat 3-5.2
    Category Should Not Be Found at Category Tree    3    5.1
    Category Should Not Be Found at Category Tree    3    5.1

    Expand or Collapse Sub-Categories under Category    3
    #.. Not found sub-cat 3-1.1
    #.. Not found sub-cat 3-2.1
    #.. Not found sub-cat 3-3.1
    #.. Not found sub-cat 3-4.1
    Category Should Not Be Found at Category Tree    3    4.1
    Category Should Not Be Found at Category Tree    3    3.1
    Category Should Not Be Found at Category Tree    3    2.1
    Category Should Not Be Found at Category Tree    3    1.1

    Expand or Collapse Sub-Categories under Category    2
    #.. Not found sub-cat 2-1.1
    Category Should Not Be Found at Category Tree    2    1.1

    Expand or Collapse Sub-Categories under Category    1
    #.. Not found sub-cat 1-1.1
    #.. Not found sub-cat 1-1.2
    Category Should Not Be Found at Category Tree    1    1.1
    Category Should Not Be Found at Category Tree    1    2.1

    Capture Page Screenshot

   [Teardown]    Run Keywords    Delete Merchant From DB    ${merchant_shop_id}    AND    Run keyword If    "${cat_id_3_5_2}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_3_5_2}\
   ...    AND    Run keyword If    "${cat_id_3_5_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_3_5_1}\
   ...    AND    Run keyword If    "${cat_id_3_4_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_3_4_1}\
   ...    AND    Run keyword If    "${cat_id_3_3_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_3_3_1}\
   ...    AND    Run keyword If    "${cat_id_3_2_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_3_2_1}\
   ...    AND    Run keyword If    "${cat_id_3_1_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_3_1_1}\
   ...    AND    Run keyword If    "${cat_id_3}" != "${EMPTY}"        Permanent Delete Category By Category ID    ${cat_id_3}\
   ...    AND    Run keyword If    "${cat_id_2_1_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_2_1_1}\
   ...    AND    Run keyword If    "${cat_id_2}" != "${EMPTY}"        Permanent Delete Category By Category ID    ${cat_id_2}\
   ...    AND    Run keyword If    "${cat_id_1_1_2}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_1_2}\
   ...    AND    Run keyword If    "${cat_id_1_1_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_1_1}\
   ...    AND    Run keyword If    "${cat_id_1}" != "${EMPTY}"        Permanent Delete Category By Category ID    ${cat_id_1}\
   ...    AND    Close All Browsers
