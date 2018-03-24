*** Setting ***
Force Tags    WLS_PDS_Category
Library           HttpLibrary.HTTP
Library           BuiltIn
Library           String
Library           OperatingSystem
Library           Collections
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
${cat_id}                  ${EMPTY}

*** Test Cases ***
TC_ITMWM_00390 Update Category: all valid data - success
    [Tags]    regression    TC_ITMWM_00390    phoenix    ready
    #### prepare create category ####
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ## optional fields with values
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display                     "0"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_desktop_link      "image_url_desktop_link-${tc_number}"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    alt_text_desktop            "alt_text_desktop-${tc_number}"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_mobile_link       "image_url_mobile_link-${tc_number}"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    alt_text_mobile             "alt_text_mobile-${tc_number}"

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message

    ### update ###
    # mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ## optional fields with values
    ${CATEGORY_CREATE_JSON}=    Update Dictionary for Common Update JSON Category    ${CATEGORY_CREATE_JSON}

    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display                     "1"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_desktop_link      "image_url_desktop_link-${tc_number}-update"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    alt_text_desktop            "alt_text_desktop-${tc_number}-update"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_mobile_link       "image_url_mobile_link-${tc_number}-update"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    alt_text_mobile             "alt_text_mobile-${tc_number}-update"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    sort_by                     "update"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display_option              "variant"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_new_tab_option_desktop    "0"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_new_tab_option_mobile     "0"


    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=      Update Category    ${cat_id}    ${file_data}
    Verify Success Response Status Code and Message
    ${data}=             Get Json Value and Convert to List    ${response}    /data
    ${category_name}=              Get From Dictionary    ${data}    category_name
    ${category_name_translate}=    Get From Dictionary    ${data}    category_name_translate
    ${status}=                     Get From Dictionary    ${data}    status
    ${slug}=                       Get From Dictionary    ${data}    slug
    ${image_url_desktop}=          Get From Dictionary    ${data}    image_url_desktop
    ${image_url_mobile}=           Get From Dictionary    ${data}    image_url_mobile
    ${display}=                    Get From Dictionary    ${data}    display
    ${owner}=                      Get From Dictionary    ${data}    owner
    ${owner_type}=                 Get From Dictionary    ${data}    owner_type
    ${image_url_desktop_link}=     Get From Dictionary    ${data}    image_url_desktop_link
    ${alt_text_desktop}=           Get From Dictionary    ${data}    alt_text_desktop
    ${image_url_mobile_link}=      Get From Dictionary    ${data}    image_url_mobile_link
    ${alt_text_mobile}=            Get From Dictionary    ${data}    alt_text_mobile
    ${sort_by}=                    Get From Dictionary    ${data}    sort_by
    ${display_option}=             Get From Dictionary    ${data}    display_option
    ${image_new_tab_option_desktop}=    Get From Dictionary    ${data}    image_new_tab_option_desktop
    ${image_new_tab_option_mobile}=     Get From Dictionary    ${data}    image_new_tab_option_mobile
    ${display_image_desktop}=           Get From Dictionary    ${data}    display_image_desktop
    ${display_image_mobile}=            Get From Dictionary    ${data}    display_image_mobile

    ## verify data
    Should Be Equal    ${category_name}                ${tc_number}-update
    Should Be Equal    ${category_name_translate}      ${tc_number}-EN-update
    Should Be Equal    ${slug}                         ${tc_number}-slug-update
    Should Be Equal    ${status}                       inactive
    Should Be Equal    ${display}                      1
    Should Be Equal    ${owner}                        ${MERCHANT_CODE}
    Should Be Equal    ${owner_type}                   ${MERCHANT_TYPE}
    Should Be Equal    ${image_url_desktop}            image_url_desktop-${tc_number}-update
    Should Be Equal    ${image_url_mobile}             image_url_mobile-${tc_number}-update
    Should Be Equal    ${image_url_desktop_link}       image_url_desktop_link-${tc_number}-update
    Should Be Equal    ${alt_text_desktop}             alt_text_desktop-${tc_number}-update
    Should Be Equal    ${image_url_mobile_link}        image_url_mobile_link-${tc_number}-update
    Should Be Equal    ${alt_text_mobile}              alt_text_mobile-${tc_number}-update
    Should Be Equal    ${sort_by}                      update
    Should Be Equal    ${display_option}               variant
    Should Be Equal    ${image_new_tab_option_mobile}    0
    Should Be Equal    ${image_new_tab_option_mobile}    0
    Should Be Equal    ${display_image_desktop}           image_url_desktop-${tc_number}-update
    Should Be Equal    ${display_image_mobile}            image_url_mobile-${tc_number}-update

    ## verify data
    @{expected_name_trail}=                Create List    ${tc_number}-update
    @{expected_name_translation_trail}=    Create List    ${tc_number}-EN-update
    Verify Category Name Trail From Response Data Should Be Equal    ${response}    ${expected_name_trail}    ${expected_name_translation_trail}    ${cat_id}

TC_ITMWM_00391 Update Category: mandatory valid data - success
    [Tags]    TC_ITMWM_00391    phoenix    regression    ready
    #### prepare create category ####
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ## optional fields with values
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message

    ### update ###
    # mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ## optional fields with values
    ${CATEGORY_CREATE_JSON}=    Update Dictionary for Common Update JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Verify Success Response Status Code and Message
    ${category_name}=              Get Json Value and Convert to List    ${response}    /data/category_name
    ${category_name_translate}=    Get Json Value and Convert to List    ${response}    /data/category_name_translate
    ${status}=                     Get Json Value and Convert to List    ${response}    /data/status
    ${slug}=                       Get Json Value and Convert to List    ${response}    /data/slug
    ${image_url_desktop}=          Get Json Value and Convert to List    ${response}    /data/image_url_desktop
    ${image_url_mobile}=           Get Json Value and Convert to List    ${response}    /data/image_url_mobile
    ${display_image_desktop}=      Get Json Value and Convert to List    ${response}    /data/display_image_desktop
    ${display_image_mobile}=       Get Json Value and Convert to List    ${response}    /data/display_image_mobile

    ## verify data
    Should Be Equal    ${category_name}              ${tc_number}-update
    Should Be Equal    ${category_name_translate}    ${tc_number}-EN-update
    Should Be Equal    ${slug}                       ${tc_number}-slug-update
    Should Be Equal    ${status}                     inactive
    Should Be Equal    ${image_url_desktop}          image_url_desktop-${tc_number}-update
    Should Be Equal    ${image_url_mobile}           image_url_mobile-${tc_number}-update
    Should Be Equal    ${display_image_desktop}      image_url_desktop-${tc_number}-update
    Should Be Equal    ${display_image_mobile}       image_url_mobile-${tc_number}-update

    @{expected_name_trail}=                Create List    ${tc_number}-update
    @{expected_name_translation_trail}=    Create List    ${tc_number}-EN-update
    Verify Category Name Trail From Response Data Should Be Equal    ${response}    ${expected_name_trail}    ${expected_name_translation_trail}    ${cat_id}

TC_ITMWM_00392 Update Category: category_name equal 255 characters - success
    [Tags]    TC_ITMWM_00392    phoenix    ready
    #### prepare create category ####
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ## optional fields with values
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${data}=         Get Json Value and Convert to List    ${response}    /data/display
    ${category_name}=      Get Json Value    ${response}    /data/category_name
    Should Be Equal    ${category_name}    "${tc_number}"

    ### update ###
    ## mandatory fields with values
    Set To Dictionary     ${CATEGORY_CREATE_JSON}    category_name         "${255_chars}"
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log To Console    update=${file_data}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Log To Console    response=${response}
    Verify Success Response Status Code and Message
    ${category_name}=              Get Json Value and Convert to List    ${response}    /data/category_name

    ## verify data
    Should Be Equal    ${category_name}      ${255_chars}

TC_ITMWM_00393 Update Category: category_name_translate equal 255 characters - success
    [Tags]    TC_ITMWM_00393     phoenix    ready
    #### prepare create category ####
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ## optional fields with values
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${data}=         Get Json Value and Convert to List    ${response}    /data/display
    ${category_name}=      Get Json Value    ${response}    /data/category_name
    Should Be Equal    ${category_name}    "${tc_number}"

    ### update ###
    ## optional fields with values
    Set To Dictionary     ${CATEGORY_CREATE_JSON}    category_name_translate         "${255_chars}"
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log To Console    update=${file_data}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Log To Console    response=${response}
    Verify Success Response Status Code and Message
    ${category_name_translate}=              Get Json Value and Convert to List    ${response}    /data/category_name_translate

    ## verify data
    Should Be Equal    ${category_name_translate}      ${255_chars}

TC_ITMWM_00394 Update Category: slug equal 255 characters - success
    [Tags]    TC_ITMWM_00394    phoenix    ready
    #### prepare create category ####
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ## optional fields with values
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${data}=         Get Json Value and Convert to List    ${response}    /data/display
    ${category_name}=      Get Json Value    ${response}    /data/category_name
    Should Be Equal    ${category_name}    "${tc_number}"

    ### update ###
    ## mandatory fields with values
    Set To Dictionary     ${CATEGORY_CREATE_JSON}    slug         "${255_chars}"
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log To Console    update=${file_data}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Log To Console    response=${response}
    Verify Success Response Status Code and Message
    ${slug}=              Get Json Value and Convert to List    ${response}    /data/slug

    ## verify data
    Should Be Equal    ${slug}    ${255_chars}

TC_ITMWM_00395 Update Category: display is 0 - success
    [Tags]     TC_ITMWM_00395    phoenix    ready
    #### prepare create category ####
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ## optional fields with values
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    display    "1"

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id}=     Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${display}=      Get Json Value    ${response}    /data/display
    Should Be Equal    ${display}    "1"

    ### update ###
    ## optional fields with values
    Set To Dictionary     ${CATEGORY_CREATE_JSON}    display         "0"
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log To Console    update=${file_data}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Log To Console    response=${response}
    Verify Success Response Status Code and Message
    ${display}=              Get Json Value and Convert to List    ${response}    /data/display

    ## verify data
    Should Be Equal    ${display}    0

TC_ITMWM_00396 Update Category: display is 1 - success
    [Tags]    TC_ITMWM_00396    ready    phoenix    regression
    #### prepare create category ####
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

    ### update ###
    ## mandatory fields with values
    Set To Dictionary     ${CATEGORY_CREATE_JSON}    display         "1"
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log To Console    update=${file_data}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Log To Console    response=${response}
    Verify Success Response Status Code and Message
    ${display}=              Get Json Value and Convert to List    ${response}    /data/display

    ## verify data
    Should Be Equal    ${display}    1

TC_ITMWM_00397 Update Category: status is active - success
    [Tags]    TC_ITMWM_00397    ready    phoenix    regression
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status    "inactive"

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${data}=         Get Json Value and Convert to List    ${response}    /data

    ${status}=      Get Json Value    ${response}    /data/status
    Should Be Equal    ${status}    "inactive"

    ### update ###
    ## mandatory fields with values
    Set To Dictionary     ${CATEGORY_CREATE_JSON}    status         "active"
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log To Console    update=${file_data}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Log To Console    response=${response}
    Verify Success Response Status Code and Message
    ${status}=              Get Json Value and Convert to List    ${response}    /data/status

    ## verify data
    Should Be Equal    ${status}    active

TC_ITMWM_00398 Update Category: status is inactive - success
    [Tags]    TC_ITMWM_00398    phoenix    regression
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    status    "active"

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${data}=         Get Json Value and Convert to List    ${response}    /data

    ${status}=      Get Json Value    ${response}    /data/status
    Should Be Equal    ${status}    "active"

    ### update ###
    ## mandatory fields with values
    Set To Dictionary     ${CATEGORY_CREATE_JSON}    status         "inactive"
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log To Console    update=${file_data}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Log To Console    response=${response}
    Verify Success Response Status Code and Message
    ${status}=              Get Json Value and Convert to List    ${response}    /data/status

    ## verify data
    Should Be Equal    ${status}    inactive

TC_ITMWM_00399 Update Category: updated image_url_mobile - success
    [Tags]    TC_ITMWM_00399    ready    regression    phoenix
    ## mandatory fields with values
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${data}=         Get Json Value and Convert to List    ${response}    /data

    ${image_url_mobile}=      Get Json Value    ${response}    /data/image_url_mobile
    Should Be Equal    ${image_url_mobile}    "image_url_mobile-${tc_number}"

    ### update ###
    ## mandatory fields with values
    Set To Dictionary     ${CATEGORY_CREATE_JSON}    image_url_mobile         "image_url_desktop-${tc_number}-update"
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log To Console    update=${file_data}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Log To Console    response=${response}
    Verify Success Response Status Code and Message
    ${image_url_mobile}=              Get Json Value and Convert to List    ${response}    /data/image_url_mobile

    ## verify data
    Should Be Equal    ${image_url_mobile}    image_url_desktop-${tc_number}-update

TC_ITMWM_00400 Update Category: image_url_desktop_link is empty - Success
    [Tags]    TC_ITMWM_00400     ready    regression     phoenix
    ## mandatory fields with values
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary     ${CATEGORY_CREATE_JSON}    image_url_desktop_link         "image_url_desktop_link-${tc_number}"

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${data}=         Get Json Value and Convert to List    ${response}    /data

    ${image_url_desktop_link}=      Get Json Value    ${response}    /data/image_url_desktop_link
    Should Be Equal    ${image_url_desktop_link}    "image_url_desktop_link-${tc_number}"

    ### update ###
    ## optional fields with values
    Set To Dictionary     ${CATEGORY_CREATE_JSON}    image_url_desktop_link         ""
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log To Console    update=${file_data}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Log To Console    response=${response}
    Verify Success Response Status Code and Message
    ${image_url_desktop_link}=              Get Json Value and Convert to List    ${response}    /data/image_url_desktop_link

    ## verify data
    Should Be Equal    ${image_url_desktop_link}    ${EMPTY}

TC_ITMWM_00401 Update Category: image_url_desktop_link is whitespace - Success
    [Tags]     TC_ITMWM_00401    ready   regression    phoenix
    ## mandatory fields with values
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary     ${CATEGORY_CREATE_JSON}    image_url_desktop_link         "image_url_desktop_link-${tc_number}"

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${data}=         Get Json Value and Convert to List    ${response}    /data

    ${image_url_desktop_link}=      Get Json Value    ${response}    /data/image_url_desktop_link
    Should Be Equal    ${image_url_desktop_link}    "image_url_desktop_link-${tc_number}"

    ### update ###
    ## optional fields with values
    Set To Dictionary     ${CATEGORY_CREATE_JSON}    image_url_desktop_link         " "
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log To Console    update=${file_data}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Log To Console    response=${response}
    Verify Success Response Status Code and Message
    ${image_url_desktop_link}=              Get Json Value and Convert to List    ${response}    /data/image_url_desktop_link

    ## verify data
    Should Be Equal    ${image_url_desktop_link}    ${SPACE}

TC_ITMWM_00402 Update Category: image_url_desktop_link is null - success
    [Tags]    TC_ITMWM_00402    ready    phoenix
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary     ${CATEGORY_CREATE_JSON}    image_url_desktop_link         "image_url_desktop_link-${tc_number}"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message

    ### update ###
    ## optional fields with values
    ${update_json}=    Create Dictionary    image_url_desktop_link=null
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    ${response}=      Update Category    ${cat_id}    ${file_data}
    Verify Success Response Status Code and Message
    ${data}=         Get Json Value and Convert to List    ${response}    /data
    ${image_url_desktop_link}=    Get From Dictionary    ${data}    image_url_desktop_link

    ## verify data
    Should Be Equal    ${image_url_desktop_link}    image_url_desktop_link-${tc_number}

TC_ITMWM_00403 Update Category: image_url_mobile_link is empty - Success
    [Tags]     TC_ITMWM_00403    ready    phoenix
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}

    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary     ${CATEGORY_CREATE_JSON}    image_url_mobile_link         "image_url_mobile_link-${tc_number}"

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${data}=         Get Json Value and Convert to List    ${response}    /data

    ${image_url_mobile_link}=      Get Json Value    ${response}    /data/image_url_mobile_link
    Should Be Equal    ${image_url_mobile_link}    "image_url_mobile_link-${tc_number}"

    ### update ###
    ## optional fields with values
    Set To Dictionary     ${CATEGORY_CREATE_JSON}    image_url_mobile_link         ""
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log To Console    update=${file_data}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Log To Console    response=${response}
    Verify Success Response Status Code and Message
    ${image_url_mobile_link}=     Get Json Value and Convert to List    ${response}    /data/image_url_mobile_link

    ## verify data
    Should Be Equal    ${image_url_mobile_link}    ${EMPTY}

TC_ITMWM_00404 Update Category: image_url_mobile_link is whitespace - Success
    [Tags]    TC_ITMWM_00404    ready    phoenix
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}

    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary     ${CATEGORY_CREATE_JSON}    image_url_mobile_link         "image_url_mobile_link-${tc_number}"

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${data}=         Get Json Value and Convert to List    ${response}    /data

    ${image_url_mobile_link}=      Get Json Value    ${response}    /data/image_url_mobile_link
    Should Be Equal    ${image_url_mobile_link}    "image_url_mobile_link-${tc_number}"

    ### update ###
    ## optional fields with values
    Set To Dictionary     ${CATEGORY_CREATE_JSON}    image_url_mobile_link         " "
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log To Console    update=${file_data}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Log To Console    response=${response}
    Verify Success Response Status Code and Message
    ${image_url_mobile_link}=              Get Json Value and Convert to List    ${response}    /data/image_url_mobile_link

    ## verify data
    Should Be Equal    ${image_url_mobile_link}    ${SPACE}

TC_ITMWM_00405 Update Category: image_url_mobile_link is null - success
    [Tags]    TC_ITMWM_00405   ready    phoenix
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}

    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary     ${CATEGORY_CREATE_JSON}    image_url_mobile_link         "image_url_mobile_link-${tc_number}"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${data}=         Get Json Value and Convert to List    ${response}    /data

    ${image_url_mobile_link}=      Get Json Value    ${response}    /data/image_url_mobile_link
    Should Be Equal    ${image_url_mobile_link}    "image_url_mobile_link-${tc_number}"

    ### update ###
    ## optional fields with values
    ${update_json}=    Create Dictionary    image_url_mobile_link=null
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    ${response}=      Update Category    ${cat_id}    ${file_data}
    Verify Success Response Status Code and Message
    ${data}=         Get Json Value and Convert to List    ${response}    /data
    ${image_url_mobile_link}=    Get From Dictionary    ${data}    image_url_mobile_link

    ## verify data
    Should Be Equal    ${image_url_mobile_link}    image_url_mobile_link-${tc_number}

TC_ITMWM_00406 Update Category: alt_text_desktop is empty - Success
    [Tags]    TC_ITMWM_00406    ready    phoenix    regression
    #### prepare create category ####
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id}=     Get Category ID After Creating
    Verify Success Response Status Code and Message
    Dictionary Should Not Contain Key    ${response}    alt_text_desktop

    ### update ###
    ## mandatory fields with values
    Set To Dictionary     ${CATEGORY_CREATE_JSON}    alt_text_desktop    ""
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=      Update Category    ${cat_id}    ${file_data}
    Verify Success Response Status Code and Message
    ${alt_text_desktop}=    Get Json Value and Convert to List    ${response}    /data/alt_text_desktop

    ## verify data
    Should Be Equal    ${alt_text_desktop}    ${EMPTY}

TC_ITMWM_00407 Update Category: alt_text_desktop is whitespace - Success
    [Tags]    TC_ITMWM_00407    ready    phoenix    regression
    #### prepare create category ####
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id}=     Get Category ID After Creating
    Verify Success Response Status Code and Message
    Dictionary Should Not Contain Key    ${response}    alt_text_desktop

    ### update ###
    ## mandatory fields with values
    Set To Dictionary     ${CATEGORY_CREATE_JSON}    alt_text_desktop    " "
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=      Update Category    ${cat_id}    ${file_data}
    Verify Success Response Status Code and Message
    ${alt_text_desktop}=              Get Json Value and Convert to List    ${response}    /data/alt_text_desktop

    ## verify data
    Should Be Equal    ${alt_text_desktop}    ${SPACE}

TC_ITMWM_00408 Update Category: alt_text_desktop is null - success
    [Tags]    TC_ITMWM_00408    ready    phoenix    regression
    #### prepare create category ####
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id}=     Get Category ID After Creating
    Verify Success Response Status Code and Message
    Dictionary Should Not Contain Key    ${response}    alt_text_desktop

    ### update ###
    ## mandatory fields with values
    Set To Dictionary     ${CATEGORY_CREATE_JSON}    alt_text_desktop    null
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Log To Console    response=${response}
    Verify Success Response Status Code and Message
    Dictionary Should Not Contain Key    ${response}    alt_text_desktop

TC_ITMWM_00409 Update Category: updated image_url_desktop - success
    [Tags]    TC_ITMWM_00409    ready    phoenix    regression

    ## mandatory fields with values
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${data}=         Get Json Value and Convert to List    ${response}    /data

    ${image_url_desktop}=      Get Json Value    ${response}    /data/image_url_desktop
    Should Be Equal    ${image_url_desktop}    "image_url_desktop-${tc_number}"

    ### update ###
    ## mandatory fields with values
    Set To Dictionary     ${CATEGORY_CREATE_JSON}    image_url_desktop    "image_url_desktop-${tc_number}-update"
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log To Console    update=${file_data}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Log To Console    response=${response}
    Verify Success Response Status Code and Message
    ${image_url_desktop}=              Get Json Value and Convert to List    ${response}    /data/image_url_desktop

    ## verify data
    Should Be Equal    ${image_url_desktop}    image_url_desktop-${tc_number}-update

TC_ITMWM_00410 Update Category: alt_text_mobile is empty - Success
    [Tags]    TC_ITMWM_00410    ready    phoenix    regression
    #### prepare create category ####
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id}=     Get Category ID After Creating
    Verify Success Response Status Code and Message
    Dictionary Should Not Contain Key    ${response}    alt_text_mobile

    ### update ###
    ## mandatory fields with values
    Set To Dictionary     ${CATEGORY_CREATE_JSON}    alt_text_mobile    ""
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log To Console    update=${file_data}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Log To Console    response=${response}
    Verify Success Response Status Code and Message
    ${alt_text_mobile}=    Get Json Value and Convert to List    ${response}    /data/alt_text_mobile

    ## verify data
    Should Be Equal    ${alt_text_mobile}    ${EMPTY}

TC_ITMWM_00411 Update Category: alt_text_mobile is whitespace - Success
    [Tags]    TC_ITMWM_00411    ready    phoenix    regression
    #### prepare create category ####
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id}=     Get Category ID After Creating
    Verify Success Response Status Code and Message
    Dictionary Should Not Contain Key    ${response}    alt_text_mobile

    ### update ###
    ## mandatory fields with values
    Set To Dictionary     ${CATEGORY_CREATE_JSON}    alt_text_mobile    " "
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log To Console    update=${file_data}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Log To Console    response=${response}
    Verify Success Response Status Code and Message
    ${alt_text_mobile}=              Get Json Value and Convert to List    ${response}    /data/alt_text_mobile

    ## verify data
    Should Be Equal    ${alt_text_mobile}    ${SPACE}

TC_ITMWM_00412 Update Category: alt_text_mobile is null - success
    [Tags]    TC_ITMWM_00412    ready    phoenix    regression
    #### prepare create category ####
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id}=     Get Category ID After Creating
    Verify Success Response Status Code and Message
    Dictionary Should Not Contain Key    ${response}    alt_text_mobile

    ### update ###
    ## mandatory fields with values
    Set To Dictionary     ${CATEGORY_CREATE_JSON}    alt_text_desktop    null
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log To Console    update=${file_data}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Log To Console    response=${response}
    Verify Success Response Status Code and Message
    Dictionary Should Not Contain Key    ${response}    alt_text_mobile

TC_ITMWM_00413 Update Category: children_order is empty - Success
    [Tags]    TC_ITMWM_00413    phoenix    ready    regression
    #### prepare create category ####
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ## optional fields with values
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message

    ### update ###
    ${update_json}=    Create Dictionary    children_order=""
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    ${response}=       Update Category    ${cat_id}    ${file_data}

    Verify Success Response Status Code and Message
    Dictionary Should Not Contain Key    ${response}    /data/children_order

TC_ITMWM_00414 Update Category: children_order is whitespace - Success
    [Tags]    TC_ITMWM_00414    phoenix    ready    regression
    #### prepare create category ####
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ## optional fields with values
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message

    ### update ###
    ${update_json}=    Create Dictionary    children_order="${SPACE}"
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    ${response}=       Update Category    ${cat_id}    ${file_data}

    Verify Success Response Status Code and Message
    Dictionary Should Not Contain Key    ${response}    /data/children_order

TC_ITMWM_00415 Update Category: children_order is null - success
    [Tags]    TC_ITMWM_00415    phoenix    ready    regression
    #### prepare create category ####
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ## optional fields with values
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message

    ### update ###
    ${update_json}=    Create Dictionary    children_order=null
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    ${response}=       Update Category    ${cat_id}    ${file_data}

    Verify Success Response Status Code and Message
    Dictionary Should Not Contain Key    ${response}    /data/children_order

TC_ITMWM_00416 Update Category: children_order with same children and same number of previous children_order but different order - success
    [Tags]    TC_ITMWM_00416    phoenix    ready    regression
    #### prepare create category ####
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id_1}=     Get Category ID After Creating

    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1-1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1_1}=     Get Category ID After Creating

    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1-2"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1_2}=     Get Category ID After Creating

    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1-3"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1_3}=     Get Category ID After Creating

    #.. Get Category that has children
    ${response}=    Get Category By Category ID    ${cat_id_1}
    Verify Success Response Status Code and Message
    ${children_order}=      Get Json Value    ${response}    /data/children_order

    ### update ###
    ${children_order_list}=    Strip String    ${children_order}    characters=[]
    @{children_order_list}=    Split String    ${children_order_list}    ,${SPACE}
    ${update_children_order}=    Set Variable    @{children_order_list}[1], @{children_order_list}[0], @{children_order_list}[2]
    ${update_json}=    Create Dictionary    children_order=[${update_children_order}]
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    ${response}=       Update Category    ${cat_id_1}    ${file_data}

    Verify Success Response Status Code and Message
    ${children_order}=      Get Json Value    ${response}    /data/children_order
    Should Be Equal    ${children_order}    [${update_children_order}]

    [Teardown]    Run Keywords    Run keyword If    "${cat_id_1_3}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_3}    AND    Run keyword If    "${cat_id_1_2}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_2}\
    ...    AND    Run keyword If    "${cat_id_1_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_1}\
    ...    AND    Run keyword If    "${cat_id_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1}

TC_ITMWM_05158 Update Category: image_url_desktop of category more than level 1 is empty - success 200
    [Tags]    ready    regression    TC_ITMWM_05158    phoenix
    # Prerequisite: There is category that has 1 sub category level on system
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    #..CATEGORY 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-CAT1"
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id_1}=      Get Category ID After Creating
    Verify Success Response Status Code and Message

    #..CATEGORY 1-1 sub level 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-CAT1-1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1-1}=    Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1-1}=      Get Category ID After Creating
    Verify Success Response Status Code and Message

    ### update ###
    #..category level1
    ${update_json}=    Create Dictionary    image_url_desktop=""
    ${update_json}=    Generate Create Category JSON Body    ${update_json}
    ${response}=       Update Category      ${cat_id_1-1}    ${update_json}
    Verify Success Response Status Code and Message
    ${data}=                 Get Json Value and Convert to List    ${response}    /data
    ${image_url_desktop}=    Get From Dictionary    ${data}    image_url_desktop
    ${display_image_desktop}=    Get From Dictionary    ${data}    display_image_desktop

    #..step test
    Should Be Equal    ${image_url_desktop}       ${EMPTY}
    Should Be Equal    ${display_image_desktop}    image_url_desktop-${tc_number}

    [Teardown]     Run keyword If    "${cat_id_1-1}" != "${EMPTY}"    Run Keywords    Log    ${cat_id_1-1}    AND    Permanent Delete Category By Category ID    ${cat_id_1-1}

TC_ITMWM_05159 Update Category: image_url_desktop of category more than level 1 is whitespace - success 200
    [Tags]    regression    ready    TC_ITMWM_05159    phoenix
    # Prerequisite: There is category that has 1 sub category level on system
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    #..CATEGORY 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-CAT1"
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id_1}=      Get Category ID After Creating
    Verify Success Response Status Code and Message

    #..CATEGORY 1-1 sub level 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-CAT1-1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1-1}=    Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1-1}=      Get Category ID After Creating
    Verify Success Response Status Code and Message

    ### update ###
    #..category level1
    ${update_json}=    Create Dictionary    image_url_desktop=" "
    ${update_json}=    Generate Create Category JSON Body    ${update_json}
    ${response}=       Update Category      ${cat_id_1-1}    ${update_json}
    Verify Success Response Status Code and Message
    ${data}=                 Get Json Value and Convert to List    ${response}    /data
    ${image_url_desktop}=    Get From Dictionary    ${data}    image_url_desktop
    ${display_image_desktop}=    Get From Dictionary    ${data}    display_image_desktop

    #..step test
    Should Be Equal    ${image_url_desktop}       ${SPACE}
    Should Be Equal    ${display_image_desktop}    image_url_desktop-${tc_number}

    [Teardown]     Run keyword If    "${cat_id_1-1}" != "${EMPTY}"    Run Keywords    Log    ${cat_id_1-1}    AND    Permanent Delete Category By Category ID    ${cat_id_1-1}

TC_ITMWM_05160 Update Category: image_url_desktop of category more than level 1 is null - success 200
    [Tags]    ready    phoenix    regression    TC_ITMWM_05160
    # Prerequisite: There is category that has 1 sub category level on system
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    #..CATEGORY 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-CAT1"
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id_1}=      Get Category ID After Creating
    Verify Success Response Status Code and Message

    #..CATEGORY 1-1 sub level 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-CAT1-1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1-1}=    Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1-1}=      Get Category ID After Creating
    Verify Success Response Status Code and Message

    ### update ###
    #..category level1
    ${update_json}=    Create Dictionary    image_url_desktop=null
    ${update_json}=    Generate Create Category JSON Body    ${update_json}
    ${response}=       Update Category      ${cat_id_1-1}    ${update_json}
    Verify Success Response Status Code and Message
    ${data}=                 Get Json Value and Convert to List    ${response}    /data
    ${image_url_desktop}=    Get From Dictionary    ${data}    image_url_desktop
    ${display_image_desktop}=    Get From Dictionary    ${data}    display_image_desktop

    #..step test
    Should Be Equal    ${image_url_desktop}        image_url_desktop-${tc_number}
    Should Be Equal    ${display_image_desktop}    image_url_desktop-${tc_number}

    [Teardown]     Run keyword If    "${cat_id_1-1}" != "${EMPTY}"    Run Keywords    Log    ${cat_id_1-1}    AND    Permanent Delete Category By Category ID    ${cat_id_1-1}

TC_ITMWM_00417 Update Category: sort_by is publish - success
    [Tags]     TC_ITMWM_00417    phoenix    ready
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary     ${CATEGORY_CREATE_JSON}    sort_by="update"

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${sort_by}=         Get Json Value and Convert to List    ${response}    /data/sort_by
    Should Be Equal    ${sort_by}    update

    ### update ###
    ## optional fields with values
    ${update_json}=    Create Dictionary    sort_by="publish"
    Log To Console    ${update_json}
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    Log To Console     update=${file_data}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Log To Console    response=${response}
    Verify Success Response Status Code and Message
    ${sort_by}=         Get Json Value and Convert to List    ${response}    /data/sort_by

    ## verify data
    Should Be Equal    ${sort_by}    publish

TC_ITMWM_00418 Update Category: sort_by is update - success
    [Tags]    TC_ITMWM_00418    ready    phoenix
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${sort_by}=         Get Json Value and Convert to List    ${response}    /data/sort_by
    Should Be Equal    ${sort_by}    publish

    ### update ###
    ## optional fields with values
    ${update_json}=    Create Dictionary    sort_by="update"
    Log To Console    ${update_json}
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    Log To Console     update=${file_data}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Log To Console    response=${response}
    Verify Success Response Status Code and Message
    ${sort_by}=         Get Json Value and Convert to List    ${response}    /data/sort_by

    ## verify data
    Should Be Equal    ${sort_by}    update

TC_ITMWM_00419 Update Category: sort_by is ranking - success
    [Tags]    TC_ITMWM_00419    ready    phoenix
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}

    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${sort_by}=         Get Json Value and Convert to List    ${response}    /data/sort_by
    Should Be Equal    ${sort_by}    publish

    ### update ###
    ## optional fields with values
    ${update_json}=    Create Dictionary    sort_by="ranking"
    Log To Console    ${update_json}
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    Log To Console     update=${file_data}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Log To Console    response=${response}
    Verify Success Response Status Code and Message
    ${sort_by}=         Get Json Value and Convert to List    ${response}    /data/sort_by

    ## verify data
    Should Be Equal    ${sort_by}    ranking

TC_ITMWM_05161 Update Category: image_url_mobile of category more than level 1 is empty string - success 200
    [Tags]    ready    regression    phoenix    TC_ITMWM_05161
    # Prerequisite: There is category that has 1 sub category level on system
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    #..CATEGORY 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-CAT1"
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id_1}=      Get Category ID After Creating
    Verify Success Response Status Code and Message

    #..CATEGORY 1-1 sub level 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-CAT1-1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1-1}=    Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1-1}=      Get Category ID After Creating
    Verify Success Response Status Code and Message

    ### update ###
    #..category level1
    ${update_json}=    Create Dictionary    image_url_mobile=""
    ${update_json}=    Generate Create Category JSON Body    ${update_json}
    ${response}=       Update Category      ${cat_id_1-1}    ${update_json}
    Verify Success Response Status Code and Message
    ${data}=                 Get Json Value and Convert to List    ${response}    /data
    ${image_url_mobile}=     Get From Dictionary    ${data}    image_url_mobile
    ${display_image_mobile}=    Get From Dictionary    ${data}    display_image_mobile

    #..step test
    Should Be Equal    ${image_url_mobile}        ${EMPTY}
    Should Be Equal    ${display_image_mobile}    image_url_mobile-${tc_number}

    [Teardown]     Run keyword If    "${cat_id_1-1}" != "${EMPTY}"    Run Keywords    Log    ${cat_id_1-1}    AND    Permanent Delete Category By Category ID    ${cat_id_1-1}

TC_ITMWM_05162 Update Category: image_url_mobile of category more than level 1 is whitespace - success 200
    [Tags]    ready    regression    phoenix    TC_ITMWM_05162
    # Prerequisite: There is category that has 1 sub category level on system
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    #..CATEGORY 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-CAT1"
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id_1}=      Get Category ID After Creating
    Verify Success Response Status Code and Message

    #..CATEGORY 1-1 sub level 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-CAT1-1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1-1}=    Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1-1}=      Get Category ID After Creating
    Verify Success Response Status Code and Message

    ### update ###
    #..category level1
    ${update_json}=    Create Dictionary    image_url_mobile=" "
    ${update_json}=    Generate Create Category JSON Body    ${update_json}
    ${response}=       Update Category      ${cat_id_1-1}    ${update_json}
    Verify Success Response Status Code and Message
    ${data}=                 Get Json Value and Convert to List    ${response}    /data
    ${image_url_mobile}=     Get From Dictionary    ${data}    image_url_mobile
    ${display_image_mobile}=    Get From Dictionary    ${data}    display_image_mobile

    #..step test
    Should Be Equal    ${image_url_mobile}        ${SPACE}
    Should Be Equal    ${display_image_mobile}    image_url_mobile-${tc_number}

    [Teardown]     Run keyword If    "${cat_id_1-1}" != "${EMPTY}"    Run Keywords    Log    ${cat_id_1-1}    AND    Permanent Delete Category By Category ID    ${cat_id_1-1}

TC_ITMWM_05163 Update Category: image_url_mobile of category more than level 1 is null - success 200
    [Tags]    ready    regression    phoenix    TC_ITMWM_05163
    # Prerequisite: There is category that has 1 sub category level on system
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    #..CATEGORY 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-CAT1"
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id_1}=      Get Category ID After Creating
    Verify Success Response Status Code and Message

    #..CATEGORY 1-1 sub level 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-CAT1-1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1-1}=    Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1-1}=      Get Category ID After Creating
    Verify Success Response Status Code and Message

    ### update ###
    #..category level1
    ${update_json}=    Create Dictionary    image_url_mobile=null
    ${update_json}=    Generate Create Category JSON Body    ${update_json}
    ${response}=       Update Category      ${cat_id_1-1}    ${update_json}
    Verify Success Response Status Code and Message
    ${data}=                 Get Json Value and Convert to List    ${response}    /data
    ${image_url_mobile}=     Get From Dictionary    ${data}    image_url_mobile
    ${display_image_mobile}=    Get From Dictionary    ${data}    display_image_mobile

    #..step test
    Should Be Equal    ${image_url_mobile}        image_url_mobile-${tc_number}
    Should Be Equal    ${display_image_mobile}    image_url_mobile-${tc_number}

    [Teardown]     Run keyword If    "${cat_id_1-1}" != "${EMPTY}"    Run Keywords    Log    ${cat_id_1-1}    AND    Permanent Delete Category By Category ID    ${cat_id_1-1}

TC_ITMWM_00420 Update Category: category_name is empty - fail
    [Tags]    TC_ITMWM_00420    ready    phoenix    regression
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${category_name}=         Get Json Value and Convert to List    ${response}    /data/category_name
    Should Be Equal    ${category_name}    ${tc_number}

    ### update ###
    ## optional fields with values
    ${update_json}=    Create Dictionary    category_name=""
    ${file_data}=      Generate Create Category JSON Body    ${update_json}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Category name should not be empty

TC_ITMWM_00421 Update Category: category_name is whitespace - fail
    [Tags]    TC_ITMWM_00421    ready    phoenix    regression
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${category_name}=         Get Json Value and Convert to List    ${response}    /data/category_name
    Should Be Equal    ${category_name}    ${tc_number}

    ### update ###
    ## optional fields with values
    ${update_json}=    Create Dictionary    category_name=" "
    Log To Console    create dic=${update_json}
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    Log To Console     update=${file_data}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Log To Console    response=${response}
    Verify Fail Response Status Code and Message    400    error    Category name should not be empty

TC_ITMWM_00422 Update Category: category_name is null - fail
    [Tags]    TC_ITMWM_00422    ready    phoenix    regression
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${category_name}=         Get Json Value and Convert to List    ${response}    /data/category_name
    Should Be Equal    ${category_name}    ${tc_number}

    ### update ###
    ## optional fields with values
    ${update_json}=    Create Dictionary    category_name=null
    Log To Console    create dic=${update_json}
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    Log To Console     update=${file_data}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Log To Console    response=${response}
    Verify Fail Response Status Code and Message    400    error    Category name field should not be null

TC_ITMWM_00423 Update Category: category_name more 255 characters - fail
    [Tags]    TC_ITMWM_00423    ready    phoenix
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${category_name}=         Get Json Value and Convert to List    ${response}    /data/category_name
    Should Be Equal    ${category_name}    ${tc_number}

    ### update ###
    ## optional fields with values
    ${update_json}=    Create Dictionary    category_name=${255_chars}1
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    Log To Console    ${file_data}
    ${response}=      Update Category    ${cat_id}    ${file_data}
    Log To Console    response=${response}
    Verify Fail Response Status Code and Message    400    error    Category name length should be less than or equal 255

TC_ITMWM_00425 Update Category: category_name_translate is empty string - fail
    [Tags]    TC_ITMWM_00425    ready    phoenix
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${category_name_translate}=         Get Json Value and Convert to List    ${response}    /data/category_name_translate
    Should Be Equal    ${category_name_translate}    ${tc_number}-EN

    ### update ###
    ## mandatory fields with values
    ${update_json}=    Create Dictionary    category_name_translate=""
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    Log To Console    file_data=${file_data}
    ${response}=      Update Category    ${cat_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Category name translation should not be empty

TC_ITMWM_00426 Update Category: category_name_translate is whitespace - fail
    [Tags]    TC_ITMWM_00426    phoenix    ready    regression
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${category_name_translate}=         Get Json Value and Convert to List    ${response}    /data/category_name_translate
    Should Be Equal    ${category_name_translate}    ${tc_number}-EN

    ### update ###
    ## mandatory fields with values
    ${update_json}=    Create Dictionary    category_name_translate=" "
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    Log To Console    file_data=${file_data}
    ${response}=      Update Category    ${cat_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Category name translation should not be empty

TC_ITMWM_00427 Update Category: category_name_translate is null - fail
    [Tags]    TC_ITMWM_00427    phoenix    ready     regression
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${category_name_translate}=         Get Json Value and Convert to List    ${response}    /data/category_name_translate
    Should Be Equal    ${category_name_translate}    ${tc_number}-EN

    ### update ###
    ## mandatory fields with values
    ${update_json}=    Create Dictionary    category_name_translate=null
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    Log To Console    file_data=${file_data}
    ${response}=      Update Category    ${cat_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Category name translation field should not be null

TC_ITMWM_00428 Update Category: category_name_translate more 255 characters - fail
    [Tags]    TC_ITMWM_00428    phoenix   ready   regression
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${category_name_translate}=         Get Json Value and Convert to List    ${response}    /data/category_name_translate
    Should Be Equal    ${category_name_translate}    ${tc_number}-EN

    ### update ###
    ## mandatory fields with values
    ${update_json}=    Create Dictionary    category_name_translate=${255_chars}1
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    Log To Console    file_data=${file_data}
    ${response}=      Update Category    ${cat_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Category name translation length should be less than or equal 255

TC_ITMWM_00424 Update Category: category_id with non-existing category_id
    [Tags]    TC_ITMWM_00424    phoenix    ready
    ${non_cat_id}    Set Variable    1234567890
    ### update ###
    ## mandatory fields with values
    ${update_json}=    Create Dictionary    category_name="test"
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    Log To Console    file_data=${file_data}
    ${response}=      Update Category    ${non_cat_id}    ${file_data}
    Verify Fail Response Status Code and Message    404    error    Not Found Category : ${non_cat_id}

TC_ITMWM_00429 Update Category: category_id is character - fail
    [Tags]    TC_ITMWM_00429    phoenix    ready
    ${char_cat_id}    Set Variable    1a
    ### update ###
    ## mandatory fields with values
    ${update_json}=    Create Dictionary    category_name="test"
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    Log To Console    file_data=${file_data}
    ${response}=      Update Category    ${char_cat_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Id should be number

TC_ITMWM_00430 Update Category: display is not 0 or 1 - fail
    [Tags]    TC_ITMWM_00430    phoenix    ready    regression
    #### prepare create category ####
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ## optional fields with values
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message

    ### update ###
    ${update_json}=    Create Dictionary    display="102"
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    ${response}=       Update Category    ${cat_id}    ${file_data}

    Verify Fail Response Status Code and Message    400    error    Display should be 0/1

TC_ITMWM_00431 Update Category: category_id more 18 - fail
    [Tags]    TC_ITMWM_00431    phoenix    ready
    ${long_cat_id}    Set Variable    1234567890123456789
    ### update ###
    ## mandatory fields with values
    ${update_json}=    Create Dictionary    category_name="test"
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    Log To Console    file_data=${file_data}
    ${response}=      Update Category    ${long_cat_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Long number too large

TC_ITMWM_00432 Update Category: status is not 'active' or 'inactive' - fail
    [Tags]    TC_ITMWM_00432    phoenix    ready    regression
    #### prepare create category ####
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ## optional fields with values
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message

    ### update ###
    :FOR    ${item}    IN    1    true    actively
    \    ${update_json}=    Create Dictionary    status="${item}"
    \    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    \    ${response}=       Update Category    ${cat_id}    ${file_data}
    \    Verify Fail Response Status Code and Message    400    error    Status must be one of active, inactive

TC_ITMWM_00433 Update Category: status is empty - fail
    [Tags]    TC_ITMWM_00433    phoenix    ready    regression
    #### prepare create category ####
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ## optional fields with values
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message

    ### update ###
    ${update_json}=    Create Dictionary    status=""
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    ${response}=       Update Category    ${cat_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Status must be one of active, inactive

TC_ITMWM_00434 Update Category: status is whitespace - fail
    [Tags]    TC_ITMWM_00434    phoenix    ready    regression
    #### prepare create category ####
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ## optional fields with values
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message

    ### update ###
    ${update_json}=    Create Dictionary    status="${SPACE}"
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    ${response}=       Update Category    ${cat_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Status must be one of active, inactive

TC_ITMWM_00435 Update Category: status is null - fail
    [Tags]    TC_ITMWM_00435    phoenix    ready    regression
    #### prepare create category ####
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ## optional fields with values
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message

    ### update ###
    ${update_json}=    Create Dictionary    status=null
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    ${response}=       Update Category    ${cat_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Status field should not be null

TC_ITMWM_00437 Update Category: image_url_desktop of category level 1 is empty - fail 4xx
    [Tags]    TC_ITMWM_00437    ready    phoenix    regression
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${category_name}=         Get Json Value and Convert to List    ${response}    /data/category_name
    Should Be Equal    ${category_name}    ${tc_number}

    ### update ###
    ## optional fields with values
    ${update_json}=    Create Dictionary    image_url_desktop=""
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    ${response}=      Update Category    ${cat_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Image url desktop should not be empty

TC_ITMWM_00438 Update Category: image_url_desktop of category level 1 is whitespace - fail 4xx
    [Tags]    TC_ITMWM_00438    ready    phoenix
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${category_name}=         Get Json Value and Convert to List    ${response}    /data/category_name
    Should Be Equal    ${category_name}    ${tc_number}

    ### update ###
    ## optional fields with values
    ${update_json}=    Create Dictionary    image_url_desktop=" "
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    Log To Console    ${file_data}
    ${response}=      Update Category    ${cat_id}    ${file_data}
    Log To Console    response=${response}
    Verify Fail Response Status Code and Message    400    error    Image url desktop should not be empty

TC_ITMWM_00439 Update Category: image_url_desktop of category level 1 is null - fail 4xx
    [Tags]    TC_ITMWM_00439    ready    phoenix
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${category_name}=         Get Json Value and Convert to List    ${response}    /data/category_name
    Should Be Equal    ${category_name}    ${tc_number}

    ### update ###
    ## optional fields with values
    ${update_json}=    Create Dictionary    image_url_desktop=null
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    ${response}=      Update Category    ${cat_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Image url desktop field should not be null

TC_ITMWM_00440 Update Category: image_url_mobile of category level 1 is empty - fail 4xx
    [Tags]    TC_ITMWM_00440    ready    phoenix
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${category_name}=         Get Json Value and Convert to List    ${response}    /data/category_name
    Should Be Equal    ${category_name}    ${tc_number}

    ### update ###
    ## optional fields with values
    ${update_json}=    Create Dictionary    image_url_mobile=""
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    ${response}=      Update Category    ${cat_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Image url mobile should not be empty

TC_ITMWM_00441 Update Category: image_url_mobile of category level 1 is whitespace - fail 4xx
    [Tags]    TC_ITMWM_00441    ready    phoenix
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${category_name}=         Get Json Value and Convert to List    ${response}    /data/category_name
    Should Be Equal    ${category_name}    ${tc_number}

    ### update ###
    ## optional fields with values
    ${update_json}=    Create Dictionary    image_url_mobile=" "
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    ${response}=      Update Category    ${cat_id}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Image url mobile should not be empty

TC_ITMWM_00442 Update Category: image_url_mobile of category level 1 is null - fail 4xx
    [Tags]    TC_ITMWM_00442    ready    phoenix
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${category_name}=         Get Json Value and Convert to List    ${response}    /data/category_name
    Should Be Equal    ${category_name}    ${tc_number}

    ### update ###
    ## optional fields with values
    ${update_json}=    Create Dictionary    image_url_mobile=null
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    ${response}=      Update Category    ${cat_id}    ${file_data}
    # Verify Fail Response Status Code and Message    400    error    Mismatch json input
    Verify Fail Response Status Code and Message    400    error    Image url mobile field should not be null

TC_ITMWM_00443 Update Category: sort_by is not publish, update or ranking - fail
    [Tags]    TC_ITMWM_00443    ready    phoenix
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message
    ${category_name}=         Get Json Value and Convert to List    ${response}    /data/category_name
    Should Be Equal    ${category_name}    ${tc_number}

    ### update ###
    ## optional fields with values
    ${update_json}=    Create Dictionary    sort_by=null
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    Log To Console    ${file_data}
    ${response}=      Update Category    ${cat_id}    ${file_data}
    Log To Console    response=${response}
    Verify Success Response Status Code and Message
    ${sort_by}=         Get Json Value and Convert to List    ${response}    /data/sort_by

    ## verify data
    Should Be Equal    ${sort_by}    publish

    ${update_json}=    Create Dictionary    sort_by="eiei"
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    Log To Console    ${file_data}
    ${response}=      Update Category    ${cat_id}    ${file_data}
    Log To Console    response=${response}
    Verify Fail Response Status Code and Message    400    error    sort by should be publish,update or ranking

TC_ITMWM_00444 Update Category: children_order with some children of previous children_order - fail
    [Tags]    TC_ITMWM_00444    phoenix    ready    regression
    #### prepare create category ####
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id_1}=     Get Category ID After Creating

    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1-1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1_1}=     Get Category ID After Creating

    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1-2"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1_2}=     Get Category ID After Creating

    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1-3"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1_3}=     Get Category ID After Creating

    #.. Get Category that has children
    ${response}=    Get Category By Category ID    ${cat_id_1}
    Verify Success Response Status Code and Message
    ${children_order}=      Get Json Value    ${response}    /data/children_order

    ### update less than previous ###
    ${children_order_list}=    Strip String    ${children_order}    characters=[]
    @{children_order_list}=    Split String    ${children_order_list}    ,${SPACE}
    ${update_children_order}=    Set Variable    @{children_order_list}[2], @{children_order_list}[0]
    ${update_json}=    Create Dictionary    children_order=[${update_children_order}]
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    ${response}=       Update Category    ${cat_id_1}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Children order size not match with old data

    ### update more than previous ###
    ${children_order_list}=    Strip String    ${children_order}    characters=[]
    @{children_order_list}=    Split String    ${children_order_list}    ,${SPACE}
    ${update_children_order}=    Set Variable    @{children_order_list}[2], @{children_order_list}[1], @{children_order_list}[0], "55"
    ${update_json}=    Create Dictionary    children_order=[${update_children_order}]
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    ${response}=       Update Category    ${cat_id_1}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Children order size not match with old data

    [Teardown]    Run Keywords    Run keyword If    "${cat_id_1_3}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_3}    AND    Run keyword If    "${cat_id_1_2}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_2}\
    ...    AND    Run keyword If    "${cat_id_1_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_1}\
    ...    AND    Run keyword If    "${cat_id_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1}

TC_ITMWM_00445 Update Category: children_order with different children but same number of previous children_order - fail
    [Tags]    TC_ITMWM_00445    phoenix    ready    regression
    #### prepare create category ####
    ${tc_number}=    Get Test Case Number
    ## mandatory fields with values
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id_1}=     Get Category ID After Creating

    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1-1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1_1}=     Get Category ID After Creating

    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1-2"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1_2}=     Get Category ID After Creating

    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-1-3"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1_3}=     Get Category ID After Creating

    #.. Get Category that has children
    ${response}=    Get Category By Category ID    ${cat_id_1}
    Verify Success Response Status Code and Message
    ${children_order}=      Get Json Value    ${response}    /data/children_order

    ### update diffrent children from previous ###
    ${children_order_list}=    Strip String    ${children_order}    characters=[]
    @{children_order_list}=    Split String    ${children_order_list}    ,${SPACE}
    ${update_children_order}=    Set Variable    @{children_order_list}[2], @{children_order_list}[1], "55"
    ${update_json}=    Create Dictionary    children_order=[${update_children_order}]
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    ${response}=       Update Category    ${cat_id_1}    ${file_data}
    Verify Fail Response Status Code and Message    400    error    Children order element not match with old data

    [Teardown]    Run Keywords    Run keyword If    "${cat_id_1_3}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_3}    AND    Run keyword If    "${cat_id_1_2}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_2}\
    ...    AND    Run keyword If    "${cat_id_1_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1_1}\
    ...    AND    Run keyword If    "${cat_id_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1}

TC_ITMWM_04137 Update Category: image_new_tab_option_desktop is 0 - success 200
    [Tags]    phoenix    regression    ready    TC_ITMWM_04137
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message

    ### update ###
    ## optional fields with values
    ${update_json}=    Create Dictionary    image_new_tab_option_desktop="0"
    ${file_data}=      Generate Create Category JSON Body    ${update_json}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Log To Console    response=${response}
    Verify Success Response Status Code and Message
    ${image_new_tab_option_desktop}=    Get Json Value and Convert to List    ${response}    /data/image_new_tab_option_desktop

    ## verify data
    Should Be Equal    ${image_new_tab_option_desktop}    0

TC_ITMWM_04138 Update Category: image_new_tab_option_desktop is 1 - success 200
    [Tags]    phoenix     regression    ready    TC_ITMWM_04138
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message

    ### update ###
    ## optional fields with values
    ${update_json}=    Create Dictionary    image_new_tab_option_desktop="0"
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    Log To Console     update=${file_data}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Log To Console    response=${response}
    Verify Success Response Status Code and Message
    ${image_new_tab_option_desktop}=    Get Json Value and Convert to List    ${response}    /data/image_new_tab_option_desktop

    ## verify data
    Should Be Equal    ${image_new_tab_option_desktop}    0

    ### update ###
    ## optional fields with values
    ${update_json}=    Create Dictionary    image_new_tab_option_desktop="1"
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    Log To Console     update=${file_data}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Log To Console    response=${response}
    Verify Success Response Status Code and Message
    ${image_new_tab_option_desktop}=    Get Json Value and Convert to List    ${response}    /data/image_new_tab_option_desktop

    ## verify data
    Should Be Equal    ${image_new_tab_option_desktop}    1

TC_ITMWM_04139 Update Category: image_new_tab_option_desktop is not '0' or '1' - fail 400
    [Tags]    phoenix     regression    ready    TC_ITMWM_04139
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message

    @{test_data}=    Create List     " "     "11"    "test"    "3"    "${EMPTY}"
    ### update ###
    #optional fields with values
    :FOR    ${data}    IN    @{test_data}
    \    ${update_json}=    Create Dictionary    image_new_tab_option_desktop=${data}
    \    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    \    ${response}=       Update Category    ${cat_id}    ${file_data}
    \    Verify Fail Response Status Code and Message    400    error    image new tab option desktop should be 0 or 1

TC_ITMWM_04140 Update Category: image_new_tab_option_mobile is 0 - success 200
    [Tags]    phoenix     regression    ready    TC_ITMWM_04140
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message

    ### update ###
    ## optional fields with values
    ${update_json}=    Create Dictionary    image_new_tab_option_mobile="0"
    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    Log To Console     update=${file_data}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Log To Console    response=${response}
    Verify Success Response Status Code and Message
    ${image_new_tab_option_mobile}=    Get Json Value and Convert to List    ${response}    /data/image_new_tab_option_mobile

    ## verify data
    Should Be Equal    ${image_new_tab_option_mobile}    0

TC_ITMWM_04141 Update Category: image_new_tab_option_mobile is 1 - success 200
    [Tags]    phoenix     regression    ready    TC_ITMWM_04141
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message

    ### update ###
    ## optional fields with values
    ${update_json}=    Create Dictionary    image_new_tab_option_mobile="0"
    ${file_data}=      Generate Create Category JSON Body    ${update_json}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Verify Success Response Status Code and Message
    ${image_new_tab_option_mobile}=    Get Json Value and Convert to List    ${response}    /data/image_new_tab_option_mobile

    ## verify data
    Should Be Equal    ${image_new_tab_option_mobile}    0

    ### update ###
    ## optional fields with values
    ${update_json}=    Create Dictionary    image_new_tab_option_mobile="1"
    ${file_data}=      Generate Create Category JSON Body    ${update_json}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Verify Success Response Status Code and Message
    ${image_new_tab_option_mobile}=    Get Json Value and Convert to List    ${response}    /data/image_new_tab_option_mobile

    ## verify data
    Should Be Equal    ${image_new_tab_option_mobile}    1

TC_ITMWM_04142 Update Category: image_new_tab_option_mobile is not '0' or '1' - fail 400
    [Tags]    phoenix     regression    ready    TC_ITMWM_04142
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message

    @{test_data}=    Create List     " "     "11"    "test"    "3"    "${EMPTY}"
    ### update ###
    #optional fields with values
    :FOR    ${data}    IN    @{test_data}
    \    ${update_json}=    Create Dictionary    image_new_tab_option_mobile=${data}
    \    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    \    ${response}=       Update Category    ${cat_id}    ${file_data}
    \    Verify Fail Response Status Code and Message    400    error    image new tab option mobile should be 0 or 1

TC_ITMWM_04143 Update Category: display_option is variant - success 200
    [Tags]    phoenix     regression    ready    TC_ITMWM_04143
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message

    ### update ###
    ## optional fields with values
    ${update_json}=    Create Dictionary    display_option="variant"
    ${file_data}=      Generate Create Category JSON Body    ${update_json}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Verify Success Response Status Code and Message
    ${display_option}=    Get Json Value and Convert to List    ${response}    /data/display_option

    ## verify data
    Should Be Equal    ${display_option}    variant

TC_ITMWM_04144 Update Category: display_option is product - success 200
    [Tags]    phoenix     regression    ready    TC_ITMWM_04144
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    Log    ${file_data}    console=yes

    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message

    ### update ###
    ## optional fields with values
    ${update_json}=    Create Dictionary    display_option="variant"
    ${file_data}=      Generate Create Category JSON Body    ${update_json}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Verify Success Response Status Code and Message
    ${display_option}=    Get Json Value and Convert to List    ${response}    /data/display_option

    ## verify data
    Should Be Equal    ${display_option}    variant

    ### update ###
    ## optional fields with values
    ${update_json}=    Create Dictionary    display_option="product"
    ${file_data}=      Generate Create Category JSON Body    ${update_json}

    ${response}=      Update Category    ${cat_id}    ${file_data}
    Verify Success Response Status Code and Message
    ${display_option}=    Get Json Value and Convert to List    ${response}    /data/display_option

    ## verify data
    Should Be Equal    ${display_option}    product

TC_ITMWM_04145 Update Category: display_option is not 'product' or 'variant' - fail 400
    [Tags]     phoenix     regression    ready     new    TC_ITMWM_04145
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=     Create Category    ${parent_id}    ${file_data}
    ${cat_id}=       Get Category ID After Creating
    Verify Success Response Status Code and Message

    @{test_data}=    Create List     " "     "11"     "${EMPTY}"     "SA0111111111111"
    ### update ###
    #optional fields with values

    :FOR    ${data}    IN    @{test_data}
    \    ${update_json}=    Create Dictionary    display_option=${data}
    \    ${file_data}=      Generate Create Category JSON Body    ${update_json}
    \    ${response}=       Update Category    ${cat_id}    ${file_data}
    \    Verify Fail Response Status Code and Message    400    error    display option should be product or variant

TC_ITMWM_05157 Update Category: sub-category is updated - success
    [Tags]    phoenix    regression    ready    TC_ITMWM_05157
    # Prerequisite: There is category that has 1-5 sub category level on system
    ${tc_number}=    Get Test Case Number
    ${CATEGORY_CREATE_JSON}=    Copy Dictionary     ${CATEGORY_CREATE_JSON_TEMPLATE}
    ${CATEGORY_CREATE_JSON}=    Create Dictionary for Common Creation JSON Category    ${CATEGORY_CREATE_JSON}

    #..CATEGORY 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-CAT1"
    ${file_data}=     Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1}=    Create Category    ${parent_id}    ${file_data}
    ${cat_id_1}=      Get Category ID After Creating
    Verify Success Response Status Code and Message

    #..CATEGORY 1-1 sub level 1
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-CAT1-1"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1-1}=    Create Category    ${cat_id_1}    ${file_data}
    ${cat_id_1-1}=      Get Category ID After Creating
    Verify Success Response Status Code and Message

    #..CATEGORY 1-2 sub level 2
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-CAT1-1-2"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1-2}=    Create Category    ${cat_id_1-1}    ${file_data}
    ${cat_id_1-2}=      Get Category ID After Creating
    Verify Success Response Status Code and Message

    #..CATEGORY 1-3 sub level 3
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-CAT1-1-3"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1-3}=    Create Category    ${cat_id_1-2}    ${file_data}
    ${cat_id_1-3}=      Get Category ID After Creating
    Verify Success Response Status Code and Message

    #..CATEGORY 1-4 sub level 4
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-CAT1-1-4"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1-4}=    Create Category    ${cat_id_1-3}    ${file_data}
    ${cat_id_1-4}=      Get Category ID After Creating
    Verify Success Response Status Code and Message

    #..CATEGORY 1-5 sub level 5
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name    "${tc_number}-CAT1-1-5"
    ${file_data}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response_1-5}=    Create Category    ${cat_id_1-4}    ${file_data}
    ${cat_id_1-5}=      Get Category ID After Creating
    Verify Success Response Status Code and Message

    ### update ###
    #..category level1
    ${CATEGORY_CREATE_JSON}=    Update Dictionary for Common Update JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name              "${tc_number}-CAT1-update"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name_translate    "${tc_number}-CAT1-EN-update"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_desktop          "image_url_desktop${tc_number}-1update"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_mobile           "image_url_mobile${tc_number}-1update"
    ${update_json}=      Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response}=         Update Category      ${cat_id_1}    ${update_json}
    Verify Success Response Status Code and Message
    ${data}=                 Get Json Value and Convert to List    ${response}    /data
    ${image_url_desktop}=    Get From Dictionary    ${data}    image_url_desktop
    ${image_url_mobile}=     Get From Dictionary    ${data}    image_url_mobile
    ${display_image_desktop}=    Get From Dictionary    ${data}    display_image_desktop
    ${display_image_mobile}=     Get From Dictionary    ${data}    display_image_mobile

    #..category level2
    ${CATEGORY_CREATE_JSON}=    Update Dictionary for Common Update JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name              "${tc_number}-CAT1-1-update"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name_translate    "${tc_number}-CAT1-1-EN-update"
    ${update_json}=      Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response1}=        Update Category      ${cat_id_1-1}    ${update_json}
    Verify Success Response Status Code and Message
    ${data1}=                 Get Json Value and Convert to List    ${response1}    /data
    ${image_url_desktop1}=    Get From Dictionary    ${data1}    image_url_desktop
    ${image_url_mobile1}=     Get From Dictionary    ${data1}    image_url_mobile
    ${display_image_desktop1}=    Get From Dictionary    ${data1}    display_image_desktop
    ${display_image_mobile1}=     Get From Dictionary    ${data1}    display_image_mobile

    #..category level3
    ${CATEGORY_CREATE_JSON}=    Update Dictionary for Common Update JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name                "${tc_number}-CAT1-2-update"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name_translate      "${tc_number}-CAT1-2-EN-update"
    ${update_json}=      Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response1-2}=      Update Category      ${cat_id_1-2}    ${update_json}
    Verify Success Response Status Code and Message
    ${data1-2}=          Get Json Value and Convert to List    ${response1-2}    /data
    ${image_url_desktop1-2}=    Get From Dictionary    ${data1-2}    image_url_desktop
    ${image_url_mobile1-2}=     Get From Dictionary    ${data1-2}    image_url_mobile
    ${display_image_desktop1-2}=    Get From Dictionary    ${data1-2}    display_image_desktop
    ${display_image_mobile1-2}=     Get From Dictionary    ${data1-2}    display_image_mobile

    #..category level4
    ${CATEGORY_CREATE_JSON}=    Update Dictionary for Common Update JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name              "${tc_number}-CAT1-3-update"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name_translate    "${tc_number}-CAT1-3-EN-update"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_desktop          "image_url_desktop${tc_number}-1-2-3-4update"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_mobile           "image_url_mobile${tc_number}-1-2-3-4update"
    ${update_json}=    Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response1-3}     Update Category      ${cat_id_1-3}    ${update_json}
    Verify Success Response Status Code and Message
    ${data1-3}=                 Get Json Value and Convert to List    ${response1-3}    /data
    ${image_url_desktop1-3}=    Get From Dictionary    ${data1-3}    image_url_desktop
    ${image_url_mobile1-3}=     Get From Dictionary    ${data1-3}    image_url_mobile
    ${display_image_desktop1-3}=    Get From Dictionary    ${data1-3}    display_image_desktop
    ${display_image_mobile1-3}=     Get From Dictionary    ${data1-3}    display_image_mobile

    #..category level5
    ${CATEGORY_CREATE_JSON}=    Update Dictionary for Common Update JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name              "${tc_number}-CAT1-4-update"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name_translate    "${tc_number}-CAT1-4-EN-update"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_mobile           "image_url_mobile${tc_number}-1-2-3-4-5update"
    Remove From Dictionary    ${CATEGORY_CREATE_JSON}    image_url_desktop
    ${update_json}=      Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response1-4}=     Update Category      ${cat_id_1-4}    ${update_json}
    Verify Success Response Status Code and Message
    ${data1-4}=                 Get Json Value and Convert to List    ${response1-4}    /data
    ${image_url_desktop1-4}=    Get From Dictionary    ${data1-4}    image_url_desktop
    ${image_url_mobile1-4}=     Get From Dictionary    ${data1-4}    image_url_mobile
    ${display_image_desktop1-4}=    Get From Dictionary    ${data1-4}    display_image_desktop
    ${display_image_mobile1-4}=     Get From Dictionary    ${data1-4}    display_image_mobile

    #..category level6
    ${CATEGORY_CREATE_JSON}=    Update Dictionary for Common Update JSON Category    ${CATEGORY_CREATE_JSON}
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name              "${tc_number}-CAT1-5-update"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    category_name_translate    "${tc_number}-CAT1-5-EN-update"
    Set To Dictionary    ${CATEGORY_CREATE_JSON}    image_url_desktop       "image_url_desktop${tc_number}-1-2-3-4-5-6update"
    Remove From Dictionary    ${CATEGORY_CREATE_JSON}    image_url_mobile
    ${update_json}=      Generate Create Category JSON Body    ${CATEGORY_CREATE_JSON}
    ${response1-5}=     Update Category      ${cat_id_1-5}    ${update_json}
    Verify Success Response Status Code and Message
    ${data1-5}=                 Get Json Value and Convert to List    ${response1-5}    /data
    ${image_url_desktop1-5}=    Get From Dictionary    ${data1-5}     image_url_desktop
    ${image_url_mobile1-5}=     Get From Dictionary    ${data1-5}     image_url_mobile
    ${display_image_desktop1-5}=    Get From Dictionary    ${data1-5}    display_image_desktop
    ${display_image_mobile1-5}=     Get From Dictionary    ${data1-5}    display_image_mobile

    @{expected_name_trail}=    Create List    ${tc_number}-CAT1-update    ${tc_number}-CAT1-1-update    ${tc_number}-CAT1-2-update    ${tc_number}-CAT1-3-update    ${tc_number}-CAT1-4-update    ${tc_number}-CAT1-5-update
    @{expected_name_translation_trail}=    Create List    ${tc_number}-CAT1-EN-update    ${tc_number}-CAT1-1-EN-update    ${tc_number}-CAT1-2-EN-update     ${tc_number}-CAT1-3-EN-update     ${tc_number}-CAT1-4-EN-update    ${tc_number}-CAT1-5-EN-update

    #..test step
    #...level1
    Should Be Equal    ${image_url_desktop}        image_url_desktop${tc_number}-1update
    Should Be Equal    ${image_url_mobile}         image_url_mobile${tc_number}-1update
    Should Be Equal    ${display_image_desktop}    image_url_desktop${tc_number}-1update
    Should Be Equal    ${display_image_mobile}     image_url_mobile${tc_number}-1update
    #...level2
    Should Be Equal    ${image_url_desktop1}        image_url_desktop-${tc_number}-update
    Should Be Equal    ${image_url_mobile1}         image_url_mobile-${tc_number}-update
    Should Be Equal    ${display_image_desktop1}    image_url_desktop-${tc_number}-update
    Should Be Equal    ${display_image_mobile1}     image_url_mobile-${tc_number}-update
    #...level3
    Should Be Equal    ${image_url_desktop1-2}        image_url_desktop-${tc_number}-update
    Should Be Equal    ${image_url_mobile1-2}         image_url_mobile-${tc_number}-update
    Should Be Equal    ${display_image_desktop1-2}    image_url_desktop-${tc_number}-update
    Should Be Equal    ${display_image_mobile1-2}     image_url_mobile-${tc_number}-update
    #...level4
    Should Be Equal    ${image_url_desktop1-3}        image_url_desktop${tc_number}-1-2-3-4update
    Should Be Equal    ${image_url_mobile1-3}         image_url_mobile${tc_number}-1-2-3-4update
    Should Be Equal    ${display_image_desktop1-3}    image_url_desktop${tc_number}-1-2-3-4update
    Should Be Equal    ${display_image_mobile1-3}     image_url_mobile${tc_number}-1-2-3-4update
    #...level5
    Should Be Equal    ${image_url_desktop1-4}        image_url_desktop-${tc_number}
    Should Be Equal    ${image_url_mobile1-4}         image_url_mobile${tc_number}-1-2-3-4-5update
    Should Be Equal    ${display_image_desktop1-4}    image_url_desktop-${tc_number}
    Should Be Equal    ${display_image_mobile1-4}     image_url_mobile${tc_number}-1-2-3-4-5update
    # #...level6
    Should Be Equal    ${image_url_desktop1-5}        image_url_desktop${tc_number}-1-2-3-4-5-6update
    Should Be Equal    ${image_url_mobile1-5}         image_url_mobile-${tc_number}
    Should Be Equal    ${display_image_desktop1-5}    image_url_desktop${tc_number}-1-2-3-4-5-6update
    Should Be Equal    ${display_image_mobile1-5}     image_url_mobile-${tc_number}
    #..cate trail
    Verify Category Name Trail From Response Data Should Be Equal    ${response1-5}    ${expected_name_trail}    ${expected_name_translation_trail}    ${cat_id_1-5}

    [Teardown]    Run Keywords    Run keyword If    "${cat_id_1-5}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1-5}    AND    Run keyword If    "${cat_id_1-4}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1-4}\
    ...    AND     Run keyword If    "${cat_id_1-3}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1-3}\
    ...    AND     Run keyword If    "${cat_id_1-2}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1-2}\
    ...    AND     Run keyword If    "${cat_id_1-1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1-1}\
    ...    AND     Run keyword If    "${cat_id_1}" != "${EMPTY}"    Permanent Delete Category By Category ID    ${cat_id_1}