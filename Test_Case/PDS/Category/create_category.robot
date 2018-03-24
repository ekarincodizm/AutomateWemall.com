*** Setting ***
Force Tags    WLS_PDS_Category
Library           HttpLibrary.HTTP
Library           BuiltIn
Library           String
Library           OperatingSystem
Library           Collections
Library           DateTime
Library           DatabaseLibrary
Library           ${CURDIR}/../../../Python_Library/FileKeyword.py
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/API/PDS/pds_api_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PDS/Keywords_PDS_Common.robot
Resource          ${CURDIR}/../../../Resource/init.robot
Test Teardown     Run keyword If    "${cat_id}" != "${EMPTY}"    Run Keywords    Log    ${cat_id}    AND    Permanent Delete Category By Category ID    ${cat_id}

*** Variables ***
${parent_id}               1
${50_chars}                12345678901234567890123456789012345678901234567890
${100_chars}               ${50_chars}${50_chars}
${255_chars}               ${100_chars}${100_chars}${50_chars}12345
${img_url}                 //cdn-p2.itruemart.com/pcms/uploads/14-11-13/6fc3fcc11d6f6f176261ad8d7646d765_xl.jpg
${cat_id}                  ${EMPTY}
*** Test Cases ***
TC_ITMWM_00333 Create Category: all valid data - success
    [Documentation]    To verify category will be created successfully when sending request with all data
    [Tags]    TC_ITMWM_00333    regression    ready    phoenix    API_category    success
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name               "${tc_number}"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status                      "inactive"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner                       "${ALIAS_MERCHANT_CODE}"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner_type                  "${ALIAS_MERCHANT_TYPE}"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name_translate     "${tc_number}-EN"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    slug                        "${tc_number}-slug"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_desktop           "image_url_desktop-${img_url}"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_mobile            "image_url_mobile-${img_url}"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display                     "0"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    seo_id                      1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_desktop_link      "image_url_desktop_link"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    alt_text_desktop            "alt_text_desktop"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_mobile_link       "image_url_mobile_link"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    alt_text_mobile             "alt_text_mobile"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${data}=         Get Json Value and Convert to List    ${response}    /data

    ${category_name}=              Get From Dictionary    ${data}    category_name
    ${category_name_translate}=    Get From Dictionary    ${data}    category_name_translate
    ${slug}=                       Get From Dictionary    ${data}    slug
    ${status}=                     Get From Dictionary    ${data}    status
    ${display}=                    Get From Dictionary    ${data}    display
    ${owner}=                      Get From Dictionary    ${data}    owner
    ${owner_type}=                 Get From Dictionary    ${data}    owner_type
    ${image_url_desktop}=          Get From Dictionary    ${data}    image_url_desktop
    ${image_url_mobile}=           Get From Dictionary    ${data}    image_url_mobile
    ${seo_id}=                     Get From Dictionary    ${data}    seo_id
    ${image_url_desktop_link}=     Get From Dictionary    ${data}    image_url_desktop_link
    ${alt_text_desktop}=           Get From Dictionary    ${data}    alt_text_desktop
    ${image_url_mobile_link}=      Get From Dictionary    ${data}    image_url_mobile_link
    ${alt_text_mobile}=            Get From Dictionary    ${data}    alt_text_mobile
    ${image_new_tab_option_desktop}=    Get From Dictionary    ${data}    image_new_tab_option_desktop
    ${image_new_tab_option_mobile}=     Get From Dictionary    ${data}    image_new_tab_option_mobile
    ${display_option}=                  Get From Dictionary    ${data}    display_option
    ${pkey}=                            Get From Dictionary    ${data}    pkey
    ${display_image_desktop}=           Get From Dictionary    ${data}    display_image_desktop
    ${display_image_mobile}=            Get From Dictionary    ${data}    display_image_mobile

    ${seo_id_int}=    Convert To Integer    1

    Should Be Equal    ${category_name}                ${tc_number}
    Should Be Equal    ${category_name_translate}      ${tc_number}-EN
    Should Be Equal    ${slug}                         ${tc_number}-slug-${pkey}
    Should Be Equal    ${status}                       inactive
    Should Be Equal    ${display}                      0
    Should Be Equal    ${owner}                        ${ALIAS_MERCHANT_CODE}
    Should Be Equal    ${owner_type}                   ${ALIAS_MERCHANT_TYPE}
    Should Be Equal    ${image_url_desktop}            image_url_desktop-${img_url}
    Should Be Equal    ${image_url_mobile}             image_url_mobile-${img_url}
    Should Be Equal    ${seo_id}                       ${seo_id_int}
    Should Be Equal    ${image_url_desktop_link}       image_url_desktop_link
    Should Be Equal    ${alt_text_desktop}             alt_text_desktop
    Should Be Equal    ${image_url_mobile_link}        image_url_mobile_link
    Should Be Equal    ${alt_text_mobile}              alt_text_mobile
    Should Be Equal    ${image_new_tab_option_desktop}    1
    Should Be Equal    ${image_new_tab_option_mobile}     1
    Should Be Equal    ${display_option}                  product
    Should Be Equal    ${display_image_desktop}           image_url_desktop-${img_url}
    Should Be Equal    ${display_image_mobile}            image_url_mobile-${img_url}

    @{expected_name_trail}=                Create List    ${tc_number}
    @{expected_name_translation_trail}=    Create List    ${tc_number}-EN
    @{expected_slug_trail}=                Create List    ${tc_number}-slug-${pkey}
    ${cat_id}=       Get Category ID After Creating
    Verify Category Name Trail From Response Data Should Be Equal    ${response}    ${expected_name_trail}    ${expected_name_translation_trail}    ${cat_id}
    Verify Slug Trail From Response Data Should Be Equal    ${response}    ${expected_slug_trail}    ${cat_id}

TC_ITMWM_00334 - Create Category: Lv1 to Lv.6 - success
    [Tags]    success    API_category    TC_ITMWM_00334    phoenix
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    #..create level1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name               "${tc_number}-1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name_translate     "${tc_number}-1-EN"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_desktop           "image_url_desktop${tc_number}-1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_mobile            "image_url_mobile${tc_number}-1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    1    ${file_data}
    ${cat_id_1}=     Get Category ID After Creating
    ${data}=         Get Json Value and Convert to List    ${response}    /data
    ${image_url_desktop}=    Get From Dictionary    ${data}    image_url_desktop
    ${image_url_mobile}=     Get From Dictionary    ${data}    image_url_mobile
    ${display_image_desktop}=    Get From Dictionary    ${data}    display_image_desktop
    ${display_image_mobile}=     Get From Dictionary    ${data}    display_image_mobile
    ${pkey}=                     Get From Dictionary    ${data}    pkey

    #..create level2
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name               "${tc_number}-1-2"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name_translate     "${tc_number}-1-2-EN"
    Remove From Dictionary    ${CATEGORY_CREATE_JSON}    image_url_desktop
    Remove From Dictionary    ${CATEGORY_CREATE_JSON}    image_url_mobile
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response1}=     Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1_2}=    Get Category ID After Creating
    ${data1}=         Get Json Value and Convert to List    ${response1}    /data
    ${display_image_desktop1}=    Get From Dictionary    ${data1}    display_image_desktop
    ${display_image_mobile1}=     Get From Dictionary    ${data1}    display_image_mobile
    ${pkey1}=                     Get From Dictionary    ${data1}    pkey

    #..create level3
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name               "${tc_number}-1-2-3"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name_translate     "${tc_number}-1-2-3-EN"
    Remove From Dictionary    ${CATEGORY_CREATE_JSON}    image_url_desktop
    Remove From Dictionary    ${CATEGORY_CREATE_JSON}    image_url_mobile
    ${file_data}=       Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response1-2}=     Create Category    ${cat_id_1_2}    ${file_data}
    ${cat_id_1_2_3}=    Get Category ID After Creating
    ${data1-2}=         Get Json Value and Convert to List    ${response1-2}    /data
    ${display_image_desktop1-2}=    Get From Dictionary    ${data1-2}    display_image_desktop
    ${display_image_mobile1-2}=     Get From Dictionary    ${data1-2}    display_image_mobile
    ${pkey1-2}=                     Get From Dictionary    ${data1-2}    pkey

    #..create level4
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name               "${tc_number}-1-2-3-4"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name_translate     "${tc_number}-1-2-3-4-EN"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_desktop           "image_url_desktop${tc_number}-1-2-3-4"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_mobile            "image_url_mobile${tc_number}-1-2-3-4"
    ${file_data}=          Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response1-3}=        Create Category    ${cat_id_1_2_3}    ${file_data}
    ${cat_id_1_2_3_4}=          Get Category ID After Creating
    ${data1-3}=                 Get Json Value and Convert to List    ${response1-3}    /data
    ${image_url_desktop1-3}=    Get From Dictionary    ${data1-3}    image_url_desktop
    ${image_url_mobile1-3}=     Get From Dictionary    ${data1-3}    image_url_mobile
    ${display_image_desktop1-3}=    Get From Dictionary    ${data1-3}    display_image_desktop
    ${display_image_mobile1-3}=     Get From Dictionary    ${data1-3}    display_image_mobile
    ${pkey1-3}=                     Get From Dictionary    ${data1-3}    pkey

    #..create level5
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name               "${tc_number}-1-2-3-4-5"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name_translate     "${tc_number}-1-2-3-4-5-EN"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_mobile            "image_url_mobile${tc_number}-1-2-3-4-5"
    Remove From Dictionary    ${CATEGORY_CREATE_JSON}    image_url_desktop
    ${file_data}=       Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response1-4}=     Create Category    ${cat_id_1_2_3_4}    ${file_data}
    ${cat_id_1_2_3_4_5}=        Get Category ID After Creating
    ${data1-4}=                 Get Json Value and Convert to List    ${response1-4}    /data
    ${image_url_mobile1-4}=     Get From Dictionary    ${data1-4}    image_url_mobile
    ${display_image_desktop1-4}=    Get From Dictionary    ${data1-4}    display_image_desktop
    ${display_image_mobile1-4}=     Get From Dictionary    ${data1-4}    display_image_mobile
    ${pkey1-4}=                     Get From Dictionary    ${data1-4}       pkey

    #..create level6
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name               "${tc_number}-1-2-3-4-5-6"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name_translate     "${tc_number}-1-2-3-4-5-6-EN"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_desktop           "image_url_desktop${tc_number}-1-2-3-4-5-6"
    Remove From Dictionary    ${CATEGORY_CREATE_JSON}    image_url_mobile
    ${file_data}=       Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response1-5}=     Create Category    ${cat_id_1_2_3_4_5}    ${file_data}
    ${cat_id_1_2_3_4_5_6}=      Get Category ID After Creating
    ${data1-5}=                 Get Json Value and Convert to List    ${response1-5}    /data
    ${image_url_desktop1-5}=    Get From Dictionary    ${data1-5}     image_url_desktop
    ${display_image_desktop1-5}=    Get From Dictionary    ${data1-5}    display_image_desktop
    ${display_image_mobile1-5}=     Get From Dictionary    ${data1-5}    display_image_mobile
    ${pkey1-5}=                     Get From Dictionary    ${data1-5}    pkey

    @{expected_name_trail}=    Create List    ${tc_number}-1    ${tc_number}-1-2    ${tc_number}-1-2-3    ${tc_number}-1-2-3-4    ${tc_number}-1-2-3-4-5    ${tc_number}-1-2-3-4-5-6
    @{expected_name_translation_trail}=    Create List    ${tc_number}-1-EN    ${tc_number}-1-2-EN    ${tc_number}-1-2-3-EN    ${tc_number}-1-2-3-4-EN    ${tc_number}-1-2-3-4-5-EN    ${tc_number}-1-2-3-4-5-6-EN
    @{expected_slug_trail}=    Create List    ${tc_number}-slug-${pkey}    ${tc_number}-slug-${pkey1}    ${tc_number}-slug-${pkey1-2}     ${tc_number}-slug-${pkey1-3}    ${tc_number}-slug-${pkey1-4}    ${tc_number}-slug-${pkey1-5}

    #..test step
    #...level1
    Should Be Equal    ${image_url_desktop}            image_url_desktop${tc_number}-1
    Should Be Equal    ${image_url_mobile}             image_url_mobile${tc_number}-1
    Should Be Equal    ${display_image_desktop}        image_url_desktop${tc_number}-1
    Should Be Equal    ${display_image_mobile}         image_url_mobile${tc_number}-1
    #...level2
    Dictionary Should Not Contain Key    ${data1}      image_url_desktop
    Dictionary Should Not Contain Key    ${data1}      image_url_mobile
    Should Be Equal    ${display_image_desktop1}       image_url_desktop${tc_number}-1
    Should Be Equal    ${display_image_mobile1}        image_url_mobile${tc_number}-1
    #...level3
    Dictionary Should Not Contain Key    ${data1-2}    image_url_desktop
    Dictionary Should Not Contain Key    ${data1-2}    image_url_mobile
    Should Be Equal    ${display_image_desktop1-2}     image_url_desktop${tc_number}-1
    Should Be Equal    ${display_image_mobile1-2}      image_url_mobile${tc_number}-1
    #...level4
    Should Be Equal    ${image_url_desktop1-3}         image_url_desktop${tc_number}-1-2-3-4
    Should Be Equal    ${image_url_mobile1-3}          image_url_mobile${tc_number}-1-2-3-4
    Should Be Equal    ${display_image_desktop1-3}     image_url_desktop${tc_number}-1-2-3-4
    Should Be Equal    ${display_image_mobile1-3}      image_url_mobile${tc_number}-1-2-3-4
    #...level5
    Dictionary Should Not Contain Key    ${data1-4}    image_url_desktop
    Should Be Equal    ${image_url_mobile1-4}          image_url_mobile${tc_number}-1-2-3-4-5
    Should Be Equal    ${display_image_desktop1-4}     image_url_desktop${tc_number}-1-2-3-4
    Should Be Equal    ${display_image_mobile1-4}      image_url_mobile${tc_number}-1-2-3-4-5
    #...level6
    Dictionary Should Not Contain Key    ${data1-5}    image_url_mobile
    Should Be Equal    ${image_url_desktop1-5}         image_url_desktop${tc_number}-1-2-3-4-5-6
    Should Be Equal    ${display_image_desktop1-5}     image_url_desktop${tc_number}-1-2-3-4-5-6
    Should Be Equal    ${display_image_mobile1-5}      image_url_mobile${tc_number}-1-2-3-4-5
    #...cate trail
    Verify Category Name Trail From Response Data Should Be Equal    ${response1-5}    ${expected_name_trail}    ${expected_name_translation_trail}    ${cat_id_1_2_3_4_5_6}
    Verify Slug Trail From Response Data Should Be Equal    ${response1-5}    ${expected_slug_trail}    ${cat_id_1_2_3_4_5_6}

    [Teardown]    Run Keywords    Run keyword If    "${cat_id_1_2_3_4_5_6}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_2_3_4_5_6}    AND    Run keyword If    "${cat_id_1_2_3_4_5}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_2_3_4_5}\
    ...    AND    Run keyword If    "${cat_id_1_2_3_4}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_2_3_4}\
    ...    AND    Run keyword If    "${cat_id_1_2_3}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_2_3}\
    ...    AND    Run keyword If    "${cat_id_1_2}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_2}\
    ...    AND    Run keyword If    "${cat_id_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1}

TC_ITMWM_00335 Create Category: mandatory valid data - success
    [Tags]    TC_ITMWM_00335    regression    ready    phoenix    API_category    success
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${data}=         Get Json Value and Convert to List    ${response}    /data

    ${category_name}=             Get From Dictionary    ${data}     category_name
    ${category_name_translate}=   Get From Dictionary    ${data}     category_name_translate
    ${status}=                    Get From Dictionary    ${data}     status
    ${owner}=                     Get From Dictionary    ${data}     owner
    ${owner_type}=                Get From Dictionary    ${data}     owner_type
    ${slug}=                      Get From Dictionary    ${data}     slug
    ${image_url_desktop}=         Get From Dictionary    ${data}     image_url_desktop
    ${image_url_mobile}=          Get From Dictionary    ${data}     image_url_mobile
    ${image_new_tab_option_desktop}=    Get From Dictionary    ${data}    image_new_tab_option_desktop
    ${image_new_tab_option_mobile}=     Get From Dictionary    ${data}    image_new_tab_option_mobile
    ${display_option}=                  Get From Dictionary    ${data}    display_option
    ${pkey}=                            Get From Dictionary    ${data}    pkey
    ${display_image_desktop}=           Get From Dictionary    ${data}    display_image_desktop
    ${display_image_mobile}=            Get From Dictionary    ${data}    display_image_mobile

    Should Be Equal    ${category_name}               ${tc_number}
    Should Be Equal    ${category_name_translate}     ${tc_number}-EN
    Should Be Equal    ${status}                      active
    Should Be Equal    ${owner}                       ${MERCHANT_CODE}
    Should Be Equal    ${owner_type}                  ${MERCHANT_TYPE}
    Should Be Equal    ${slug}                        ${tc_number}-slug-${pkey}
    Should Be Equal    ${image_url_desktop}           image_url_desktop-${tc_number}
    Should Be Equal    ${image_url_mobile}            image_url_mobile-${tc_number}
    Should Be Equal    ${image_new_tab_option_desktop}    1
    Should Be Equal    ${image_new_tab_option_mobile}     1
    Should Be Equal    ${display_option}                  product
    Should Be Equal    ${display_image_desktop}           image_url_desktop-${tc_number}
    Should Be Equal    ${display_image_mobile}            image_url_mobile-${tc_number}

    @{expected_name_trail}=                Create List    ${tc_number}
    @{expected_name_translation_trail}=    Create List    ${tc_number}-EN
    @{expected_slug_trail}=                Create List    ${tc_number}-slug-${pkey}
    Verify Category Name Trail From Response Data Should Be Equal    ${response}    ${expected_name_trail}    ${expected_name_translation_trail}    ${cat_id}
    Verify Slug Trail From Response Data Should Be Equal    ${response}    ${expected_slug_trail}    ${cat_id}

TC_ITMWM_00336 Create Category: display is 0 - success
    [Tags]    TC_ITMWM_00336    regression    ready    phoenix    API_category    success
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ## optional fields with values
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display    "0"

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id}=     Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${display}=      Get Json Value    ${response}    /data/display
    Should Be Equal    ${display}    "0"

TC_ITMWM_00337 Create Category: display is 1 - success
    [Tags]    TC_ITMWM_00337    regression    ready    phoenix    API_category    success
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ## optional fields with values
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display    "1"

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=      Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${display}=      Get Json Value    ${response}    /data/display
    Should Be Equal    ${display}    "1"

TC_ITMWM_00338 Create Category: status is active - success
    [Tags]    TC_ITMWM_00338    regression    ready    phoenix    API_category    success
    [Documentation]    To verify category will be created successfully when sending request with status field is active
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status    "active"

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=      Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${data}=         Get Json Value and Convert to List    ${response}    /data

    ${status}=      Get Json Value    ${response}    /data/status
    Should Be Equal    ${status}    "active"

TC_ITMWM_00339 Create Category: status is inactive - success
    [Documentation]    To verify category will be created successfully when sending request with status field is inactive
    [Tags]    TC_ITMWM_00339    regression    ready    phoenix    API_category    success
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status                      "inactive"

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=      Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${data}=         Get Json Value and Convert to List    ${response}    /data
    Log To Console    data=${data}

    ${status}=      Get Json Value    ${response}    /data/status
    Should Be Equal    ${status}    "inactive"

TC_ITMWM_00340 Create Category: owner_type is merchant - success
    [Documentation]    To verify category will be created successfully when sending request with owner_type field is merchant
    [Tags]    TC_ITMWM_00340    regression    ready    phoenix    API_category    success
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner                       "${MERCHANT_CODE}"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner_type                  "${MERCHANT_TYPE}"

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=      Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${data}=         Get Json Value and Convert to List    ${response}    /data
    Log To Console    data=${data}

    ${level}=      Get Json Value    ${response}    /data/level
    ${category_code}=      Get Json Value    ${response}    /data/category_code
    Verify format code    ${MERCHANT_TYPE}    category    ${category_code}    ${level}

TC_ITMWM_00341 Create Category: owner_type is alias - success
    [Documentation]    To verify category will be created successfully when sending request with owner_type field is alias
    [Tags]    TC_ITMWM_00341    regression    ready    phoenix    API_category    success
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner                       "${ALIAS_MERCHANT_CODE}"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner_type                  "${ALIAS_MERCHANT_TYPE}"

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes
    ${response}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id}=     Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${data}=        Get Json Value and Convert to List    ${response}    /data

    ${level}=      Get Json Value    ${response}    /data/level
    ${category_code}=      Get Json Value    ${response}    /data/category_code
    Verify format code    ${ALIAS_MERCHANT_TYPE}    category    ${category_code}    ${level}

TC_ITMWM_05148 Create Category: image_url_desktop of category more than level 1 is empty - success 200
    [Tags]     phoenix        regression    TC_ITMWM_05148
    # Prerequisite: There is category that has 1 sub category level on system
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    #..CATEGORY level 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-CAT1"
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id_1}=      Get Category ID After Creating
    ${level}=         Set Variable    2
    ${response_1}=    Get Category By Category ID    ${cat_id_1}
    Verify Success Response Status Code and Message

    #..CATEGORY level2 - sub level 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name        "${tc_number}-CAT1-1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_desktop    ""
    ${file_data}=       Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1-1}=    Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1-1}=      Get Category ID After Creating
    Verify Success Response Status Code and Message

    ${data}=                     Get Json Value and Convert to List    ${response_1-1}    /data
    ${image_url_desktop}=        Get From Dictionary    ${data}    image_url_desktop
    ${display_image_desktop}=    Get From Dictionary    ${data}    display_image_desktop
    Log To Console    image_url_desktop=${image_url_desktop}

    Should Be Equal    ${image_url_desktop}        ${EMPTY}
    Should Be Equal    ${display_image_desktop}    image_url_desktop-${tc_number}

    [Teardown]    Run Keywords    Run keyword If    "${cat_id_1-1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1-1}\
    ...    AND     Run keyword If    "${cat_id_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1}

TC_ITMWM_05149 Create Category: image_url_desktop of category more than level 1 is whitespace - success 200
    [Tags]    phoenix        regression    TC_ITMWM_05149
    # Prerequisite: There is category that has 1 sub category level on system
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    #..CATEGORY 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-CAT1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_desktop    "image_url_desktop${tc_number}-1"
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1}=    Create Category    ${parent_id}    ${file_data}
    Verify Success Response Status Code and Message
    ${cat_id_1}=      Get Category ID After Creating

    # Test Step:
    #..CATEGORY 1-1 sub level 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name        "${tc_number}-CAT1-1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_desktop    " "
    ${file_data}=       Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1-1}=    Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1-1}=      Get Category ID After Creating

    Verify Success Response Status Code and Message
    ${data}=                     Get Json Value and Convert to List    ${response_1-1}    /data
    ${image_url_desktop}=        Get From Dictionary    ${data}    image_url_desktop
    ${display_image_desktop}=    Get From Dictionary    ${data}    display_image_desktop

    Should Be Equal    ${image_url_desktop}        ${SPACE}
    Should Be Equal    ${display_image_desktop}    image_url_desktop${tc_number}-1

    [Teardown]    Run Keywords    Run keyword If    "${cat_id_1-1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1-1}\
    ...    AND     Run keyword If    "${cat_id_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1}

TC_ITMWM_05150 Create Category: image_url_desktop of category more than level 1 is null - success 200
    [Tags]    phoenix       regression    TC_ITMWM_05150
    # Prerequisite: There is category that has 1 sub category level on system
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    #..CATEGORY 1 - level1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name        "${tc_number}-CAT1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_desktop    "image_url_desktop${tc_number}-1"
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Create Category    ${parent_id}    ${file_data}
    ${cat_id_1}=      Get Category ID After Creating
    Verify Success Response Status Code and Message

    # Test Step:
    #..CATEGORY 1-1 sub level 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name        "${tc_number}-CAT1-1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_desktop    null
    ${file_data}=       Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1-1}=    Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1-1}=      Get Category ID After Creating

    Verify Success Response Status Code and Message
    ${data}=        Get Json Value and Convert to List    ${response_1-1}    /data
    ${display_image_desktop}=    Get From Dictionary    ${data}    display_image_desktop
    Dictionary Should Not Contain Key    ${data}    image_url_desktop
    Should Be Equal    ${display_image_desktop}     image_url_desktop${tc_number}-1

    [Teardown]    Run Keywords    Run keyword If    "${cat_id_1-1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1-1}\
    ...    AND     Run keyword If    "${cat_id_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1}

TC_ITMWM_05154 Create Category: image_url_mobile of category more than level 1 is empty - success 200
    [Tags]       regression    phoenix    TC_ITMWM_05154
    # Prerequisite: There is category that has 1 sub category level on system
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    #..CATEGORY 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name        "${tc_number}-CAT1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_mobile     "image_url_mobile${tc_number}-1"
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id_1}=      Get Category ID After Creating
    Verify Success Response Status Code and Message

    # Test Step:
    #..CATEGORY 1-1 sub level 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name        "${tc_number}-CAT1-1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_mobile    ""
    ${file_data}=       Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1-1}=    Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1-1}=      Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${data}=        Get Json Value and Convert to List    ${response_1-1}    /data
    ${image_url_mobile}=        Get From Dictionary    ${data}    image_url_mobile
    ${display_image_mobile}=    Get From Dictionary    ${data}    display_image_mobile
    Should Be Equal    ${image_url_mobile}        ${EMPTY}
    Should Be Equal    ${display_image_mobile}    image_url_mobile${tc_number}-1

    [Teardown]    Run Keywords    Run keyword If    "${cat_id_1-1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1-1}\
    ...    AND     Run keyword If    "${cat_id_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1}

TC_ITMWM_05155 Create Category: image_url_mobile of category more than level 1 is whitespace - success 200
    [Tags]    ready   phoenix    regression    TC_ITMWM_05155
    # Prerequisite: There is category that has 1 sub category level on system
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    #..CATEGORY 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name       "${tc_number}-CAT1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_mobile    "image_url_mobile${tc_number}-1"
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id_1}=      Get Category ID After Creating
    Verify Success Response Status Code and Message

    # Test Step:
    #..CATEGORY 1-1 sub level 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name        "${tc_number}-CAT1-1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_mobile    " "
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1-1}=    Create Category    ${cat_id_1}    ${file_data}
    log to console    ${response_1-1}
    ${cat_id_1-1}=      Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${data}=        Get Json Value and Convert to List    ${response_1-1}    /data
    ${image_url_mobile}=          Get From Dictionary    ${data}    image_url_mobile
    ${display_image_mobile}=      Get From Dictionary    ${data}    display_image_mobile

    Should Be Equal    ${image_url_mobile}        ${SPACE}
    Should Be Equal    ${display_image_mobile}    image_url_mobile${tc_number}-1

    [Teardown]    Run Keywords    Run keyword If    "${cat_id_1-1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1-1}\
    ...    AND     Run keyword If    "${cat_id_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1}

TC_ITMWM_05156 Create Category: category more than level 1 is null - success 200
    [Tags]    ready    phoenix    regression    TC_ITMWM_05156
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    #..CATEGORY 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name       "${tc_number}-CAT1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_mobile    "image_url_mobile${tc_number}-1"
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id_1}=      Get Category ID After Creating
    Verify Success Response Status Code and Message

    # Test Step:
    #..CATEGORY 1-1 sub level 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name        "${tc_number}-CAT1-1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_mobile     null
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1-1}=    Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1-1}=      Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${data}=            Get Json Value and Convert to List    ${response_1-1}    /data
    ${display_image_mobile}=    Get From Dictionary    ${data}    display_image_mobile

    Dictionary Should Not Contain Key     ${data}     image_url_mobile
    Should Be Equal    ${display_image_mobile}    image_url_mobile${tc_number}-1

    [Teardown]    Run Keywords    Run keyword If    "${cat_id_1-1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1-1}\
    ...    AND     Run keyword If    "${cat_id_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1}

TC_ITMWM_00342 Create Category: category_name_translate is empty - fail
    [Tags]    TC_ITMWM_00342    ready    phoenix    API_category    fail
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name_translate     ""

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Category name translation should not be empty

TC_ITMWM_00343 Create Category: category_name_translate is whitespace - fail
    [Tags]    TC_ITMWM_00343    ready    phoenix    API_category    fail
    [Documentation]    To verify category will be created successfully when sending request with category_name_translate field is whitespace
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name_translate     " "

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Category name translation should not be empty

TC_ITMWM_00344 Create Category: category_name_translate is null - fail
    [Tags]    TC_ITMWM_00344    ready    phoenix    API_category    fail
    [Documentation]    To verify category will be created successfully when sending request with category_name_translate field is null
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name_translate     null

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Category name translation field should not be null

TC_ITMWM_00345 Create Category: slug is empty - fail
    [Tags]    TC_ITMWM_00345    ready    phoenix    API_category    fail
    [Documentation]    To verify category will be created successfully when sending request with slug field is empty
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    slug    "${EMPTY}"

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes
    ${response}=     Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Slug name should not be empty

TC_ITMWM_00346 Create Category: slug is whitespace - fail
    [Tags]     TC_ITMWM_00346     ready    phoenix    API_category    fail
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    slug    " "

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes
    ${response}=     Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Slug name should not be empty

TC_ITMWM_00347 Create Category: slug is null - fail
    [Tags]    TC_ITMWM_00347    ready    phoenix    API_category    success
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    slug    null

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes
    ${response}=     Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Slug field should not be null

TC_ITMWM_00356 Create Category: image_url_desktop of category level 1 is empty - fail 4xx
    [Tags]    TC_ITMWM_00356    fail    phoenix    ready    regression
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_desktop    ""

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes
    ${response}=     Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Image url desktop should not be empty

TC_ITMWM_00357 Create Category: image_url_desktop of category level 1 is whitespace - fail 4xx
    [Tags]    TC_ITMWM_00357    API_category    fail
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_desktop    " "

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes
    ${response}=     Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Image url desktop should not be empty

TC_ITMWM_00358 Create Category: image_url_desktop of category level 1 is null - fail 4xx
    [Tags]    TC_ITMWM_00358    API_category    fail   ready
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_desktop    null

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes
    ${response}=     Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Image url desktop field should not be null

TC_ITMWM_05151 Create Category: image_url_mobile of category level 1 is empty - fail 4xx
    [Tags]    regression    ready    fail    ready    TC_ITMWM_05151
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_mobile    ""

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes
    ${response}=     Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Image url mobile should not be empty

TC_ITMWM_05152 Create Category: image_url_mobile of category level 1 is whitespace - fail 4xx
    [Tags]    regression    ready    fail     TC_ITMWM_05152
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_mobile    " "

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes
    ${response}=     Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Image url mobile should not be empty

TC_ITMWM_05153 Create Category: image_url_mobile of category level 1 is null - fail 4xx
    [Tags]    fail    ready    regression    TC_ITMWM_05153
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_mobile    null

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes
    ${response}=     Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Image url mobile field should not be null

TC_ITMWM_00360 - Create Category: category_name is empty - Fail
    [Tags]    fail    API_category    TC_ITMWM_00360    regression
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    ""

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Category name should not be empty

TC_ITMWM_00361 - Create Category: category_name is whitespace - Fail
    [Tags]    fail    API_category    TC_ITMWM_00361    ready     phoenix    regression
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${SPACE}"

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Category name should not be empty

TC_ITMWM_00362 - Create Category: category_name is null - Fail
    [Tags]    Success    API_category    TC_ITMWM_00362    ready     phoenix    regression
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    null

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Category name field should not be null

TC_ITMWM_00363 - Create Category: category_name more 255 characters - Fail
    [Tags]    Fail    API_category     TC_ITMWM_00363    ready     phoenix    regression
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${255_chars}1"

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Category name length should be less than or equal 255

TC_ITMWM_00364 - Create Category: not found category_name - Fail
    [Tags]    Fail    API_category    TC_ITMWM_00364    ready     phoenix    regression
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Remove From Dictionary    ${CATEGORY_CREATE_JSON}    category_name

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Category name field is missing

TC_ITMWM_00365 - Create Category: category_name_translate more 255 characters - Fail
    [Tags]    Fail    API_category    TC_ITMWM_00365    ready     phoenix    regression
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name_translate     "${255_chars}1"

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Category name translation length should be less than or equal 255

TC_ITMWM_00366 - Create Category: slug more 255 characters - Fail
    [Tags]    Fail    API_category    TC_ITMWM_00366    ready     phoenix    regression
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    slug                        "${255_chars}1"

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Slug length should be less than or equal 255

TC_ITMWM_00368 Create Category: parent_id non-exist on system - Fail
    [Tags]    Fail    API_category    TC_ITMWM_00368    ready     phoenix    regression
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=    Create Category    100000000001    ${file_data}
    Verify Fail Response Status Code and Message    404    error    Not found parent category !

TC_ITMWM_00369 - Create Category: parent_id is whitespace - Fail
    [Tags]    Fail    API_category    TC_ITMWM_00369    ready     phoenix    regression
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=    Create Category    ${SPACE}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Id should be number

TC_ITMWM_00367 - Create Category: parent_id is empty - Fail
    [Tags]    Fail    API_category    TC_ITMWM_00367    ready     phoenix    regression
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=    Create Category    ${EMPTY}    ${file_data}
    Response Status Code Should Equal    301 Moved Permanently

TC_ITMWM_00370 - Create Category: parent_id is out of boundary - Fail
    [Tags]    Fail    API_category    TC_ITMWM_00370    ready     phoenix    regression
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=    Create Category    0    ${file_data}
    Verify Fail Response Status Code and Message    404    error    Not found parent category !

    ${response}=    Create Category    -1    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Id should be number

TC_ITMWM_00371 - Create Category: parent_id is string - Fail
    [Tags]    Fail    API_category    TC_ITMWM_00371    ready     phoenix    regression
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=    Create Category    A    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Id should be number

TC_ITMWM_00372 - Create Category: owner is empty - Fail
    [Tags]    Fail    API_category    TC_ITMWM_00372    ready     phoenix    regression
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner    ""

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Owner should not be empty

TC_ITMWM_00373 - Create Category: owner is whitespace - Fail
    [Tags]    Fail    API_category    TC_ITMWM_00373    ready     phoenix    regression
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner    "${SPACE}"

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Owner should not be empty

TC_ITMWM_00374 - Create Category: owner is null - Fail
    [Tags]    Fail    API_category    TC_ITMWM_00374    ready     phoenix    regression
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner                       null

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Owner field should not be null

TC_ITMWM_00375 - Create Category: not found owner - Fail
    [Tags]    Fail    API_category    TC_ITMWM_00375    ready     phoenix    regression
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Remove From Dictionary    ${CATEGORY_CREATE_JSON}    owner

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Owner field is missing

TC_ITMWM_00376 - Create Category: display is not 0 or 1 - Fail
    [Tags]    Fail    API_category    TC_ITMWM_00376    ready     phoenix    regression
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ## optional fields with values
    @{test_data}=    Create List     "-1"    "2"    "true"    "100"
    #...update
    :FOR    ${data}    IN    @{test_data}
    \    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display    ${data}
    \    ${file_data}=      Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    \    ${response}=       Create Category    ${parent_id}    ${file_data}
    \    Verify Fail Response Status Code and Message    400    error    Display should be 0/1

TC_ITMWM_00377 - Create Category: status is not 'active' or 'inactive' - Fail
    [Tags]    Fail    API_category    TC_ITMWM_00377    ready     phoenix    regression
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    @{test_data}=    Create List     "1"     "true"     "actively"
    #...update
    :FOR    ${data}    IN    @{test_data}
    \    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status    ${data}
    \    ${file_data}=      Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    \    ${response}=       Create Category    ${parent_id}    ${file_data}
    \    Verify Fail Response Status Code and Message    400    error    Status must be one of active, inactive

TC_ITMWM_00378 - Create Category: owner_type is empty - Fail
    [Tags]    Fail    API_category    TC_ITMWM_00378    ready     phoenix    regression
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner_type    "${EMPTY}"

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Owner type must be one of merchant, alias

TC_ITMWM_00379 - Create Category: owner_type is whitespace - Fail
    [Tags]    Fail    API_category    TC_ITMWM_00379    ready     phoenix    regression
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner_type    "${SPACE}"

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Owner type must be one of merchant, alias

TC_ITMWM_00380 - Create Category: owner_type is null - Fail
    [Tags]    Fail    API_category    TC_ITMWM_00380    ready     phoenix    regression
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner_type    null

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Owner type field should not be null

TC_ITMWM_00381 - Create Category: owner_type is not 'merchant' or 'alias' - Fail
    [Tags]    Fail    API_category    TC_ITMWM_00381    ready     phoenix    regression
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner    "${MERCHANT_CODE}"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    owner_type    "AAA"

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Owner type must be one of merchant, alias

TC_ITMWM_00382 - Create Category: seo_id is out of boundary
    [Tags]    Fail    API_category    TC_ITMWM_00382    ready     phoenix    regression
    ## seo_id : 0
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ## optional fields with values
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    seo_id    0

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Seo id should more than 0

    ## seo_id : -1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    seo_id    -1
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Seo id should more than 0

TC_ITMWM_00383 - Create Category: seo_id is string - Fail
    [Tags]    Fail    API_category    TC_ITMWM_00383    ready     phoenix    regression
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ## optional fields with values
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    seo_id    "AAA"

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Seo id should be a number

TC_ITMWM_00352 - Create Category: status is empty - Fail
    [Tags]    Fail    API_category    TC_ITMWM_00352    ready     phoenix    regression
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status    "${EMPTY}"

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Status must be one of active, inactive

TC_ITMWM_00353 - Create Category: status is whitespace - Fail
    [Tags]    Fail    API_category    TC_ITMWM_00353    ready     phoenix    regression
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status                      "${SPACE}"

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Status must be one of active, inactive

TC_ITMWM_00354 - Create Category: status is null - Fail
    [Tags]    Fail    API_category    TC_ITMWM_00354    ready     phoenix    regression
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status                      null

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Status field should not be null

TC_ITMWM_00355 - Create Category: not found status - Fail
    [Tags]    Fail    API_category    TC_ITMWM_00355    ready     phoenix    regression
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Remove From Dictionary    ${CATEGORY_CREATE_JSON}    status

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Status field is missing

TC_ITMWM_00348 - Create Category more than 6 level(lv 7) - Fail
    [Tags]    Fail    API_category    ready     phoenix    regression    TC_ITMWM_00348
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    1    ${file_data}
    ${cat_id_1}=     Get Category ID After Creating

    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1-2"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1_2}=     Get Category ID After Creating

    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1-2-3"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${cat_id_1_2}    ${file_data}
    ${cat_id_1_2_3}=     Get Category ID After Creating

    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1-2-3-4"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${cat_id_1_2_3}    ${file_data}
    ${cat_id_1_2_3_4}=     Get Category ID After Creating

    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1-2-3-4-5"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${cat_id_1_2_3_4}    ${file_data}
    ${cat_id_1_2_3_4_5}=     Get Category ID After Creating

    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1-2-3-4-5-6"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${cat_id_1_2_3_4_5}    ${file_data}
    ${cat_id_1_2_3_4_5_6}=     Get Category ID After Creating

    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1-2-3-4-5-6-7"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${cat_id_1_2_3_4_5_6}    ${file_data}

    Verify Fail Response Status Code and Message    400    error    Cannot create category under category level 6

    [Teardown]    Run Keywords    Run keyword If    "${cat_id_1_2_3_4_5_6}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_2_3_4_5_6}    AND    Run keyword If    "${cat_id_1_2_3_4_5}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_2_3_4_5}\
    ...    AND    Run keyword If    "${cat_id_1_2_3_4}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_2_3_4}\
    ...    AND    Run keyword If    "${cat_id_1_2_3}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_2_3}\
    ...    AND    Run keyword If    "${cat_id_1_2}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_2}\
    ...    AND    Run keyword If    "${cat_id_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1}

TC_ITMWM_00349 - Create Category: display is empty - Fail
    [Tags]    Fail    API_category    TC_ITMWM_00349    phoenix
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ## optional fields with values
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display    ""

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Display should be 0/1

TC_ITMWM_00350 - Create Category: display is whitespace - Fail
    [Tags]    Fail    API_category    TC_ITMWM_00350    phoenix
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ## optional fields with values
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display    "${SPACE}"

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${parent_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Display should be 0/1

TC_ITMWM_00351 - Create Category: display is null - Success
    [Tags]    Success    API_category    TC_ITMWM_00351   ready    phoenix
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ## optional fields with values
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display    null

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=     Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${display}=      Get Json Value    ${response}    /data/display
    Should Be Equal    ${display}    "0"

TC_ITMWM_00359 - Create Category: not found display - success
    [Tags]    success    API_category    TC_ITMWM_00359    ready     phoenix
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Remove From Dictionary    ${CATEGORY_CREATE_JSON}    display

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id}=     Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${display}=      Get Json Value    ${response}    /data/display
    Should Be Equal    ${display}    "0"