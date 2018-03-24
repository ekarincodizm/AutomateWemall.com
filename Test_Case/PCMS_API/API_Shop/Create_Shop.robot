*** Settings ***
Force Tags        WLS_API_PCMS
Resource    ${CURDIR}/../../../Resource/init.robot
Resource    ${CURDIR}/../../../Keyword/API/PCMS/Shop/keywords_shop.robot
Resource    ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource    ${CURDIR}/../../../Keyword/Portal/PCMS/Shop/keywords_shop.robot
Resource    ${CURDIR}/../../../Keyword/Portal/PCMS/Policy/keywords_policy.robot

Library     Selenium2Library
Library     HttpLibrary.HTTP
Library     Collections
Library     OperatingSystem
Library     ${CURDIR}/../../../Python_Library/DatabaseData.py

*** Variables ***
${shop_code}    M10001
${shop_name}    iStudio!@#$%^&*()_+~ไอสตูดิโอ

${50_chars}                         12345678901234567890123456789012345678901234567890
${100_chars}                        ${50_chars}${50_chars}
${255_chars}                        ${100_chars}${100_chars}${50_chars}12345

${merchant_type_marketplace}        M
${history_camp_price_prod_db}       camp_prc_pro

*** Test Cases ***
TC_iTM_01331 API return success when send both valid data (shop_code, shop_name)
    [Tags]    TC_iTM_01331   API    Shop    create_shop    pcms    PCMS-API    ready    QCT    flash    regression    WLS_High
    ${expect_code}=          Set Variable    200
    ${expect_message}=       Set Variable    "200 OK"
    ${result}=     API Shop - Create Shop    ${shop_code}    ${shop_name}

    ${actual_code}=            Get Json Value    ${result}    /code
    ${actual_message}=         Get Json Value    ${result}    /message


    Should Be Equal    ${expect_code}    ${actual_code}
    Should Be Equal    ${expect_message}    ${actual_message}
    Login Pcms
    Click Open Menu Shop Management
    Search Shop Name in Shop Management    ${shop_name}
    ${search_result}=    Get Shop Name From Search Result
    Found Shop From Search Shop Management    ${shop_name}    ${search_result}
    Go To Menu Policy Management
    Search Shop Policy In Policy Management    ${shop_name}
    Page Should Contain    ${shop_name}
    ${merchant_type}=    verify shop merchant type    ${shop_code}
    Should Be Equal    ${merchant_type}    ${merchant_type_marketplace}
    #[Teardown]     Delete Shop By Shop Code    ${shop_code}
    [Teardown]    Run Keywords    Delete Shop By Shop Code    ${shop_code}
    ...    AND    Close Browser

TC_iTM_01332 API return error when not send data for create shop API
    [Tags]    TC_iTM_01332   API   Shop  create_shop  pcms  PCMS_API  PCMS-API    ready    flash    regression    WLS_Medium
    ${shop_before}=    Count All Shop
    ${shop_code}=    Set Variable
    ${shop_name}=    Set Variable
    ${expect}=    Set Variable    {"status":"error","code":400002,"message":"shop_code is required"}

    ${expect_code}=          Set Variable    400002
    ${expect_message}=       Set Variable    "shop_code is required"
    ${result}=     API Shop - Create Shop    ${shop_code}    ${shop_name}
    ${actual_code}=            Get Json Value    ${result}    /code
    ${actual_message}=         Get Json Value    ${result}    /message

    Should Be Equal    ${expect_code}    ${actual_code}
    Should Be Equal    ${expect_message}    ${actual_message}

    ${shop_after}=    Count All Shop
    Should Be Equal As Integers    ${shop_before}    ${shop_after}

TC_iTM_01333 API return error when send shop_code is exist in system
    [Tags]  TC_iTM_01333   API   Shop  create_shop  pcms  PCMS-API    ready    QCT    flash     regression    WLS_Medium
    ${dummy_create_shop}=     API Shop - Create Shop    ${shop_code}    ${shop_name}
    ${expect_code}=          Set Variable    400003
    #${expect_code}=          Set Variable    400
    ${expect_message}=       Set Variable    "Shop Code already exists."
    ${result}=     API Shop - Create Shop    ${shop_code}    ${shop_name}
    ${actual_code}=            Get Json Value    ${result}    /code
    ${actual_message}=         Get Json Value    ${result}    /message
    Should Be Equal    ${expect_code}    ${actual_code}
    Should Be Equal    ${expect_message}    ${actual_message}
    Login Pcms
    Click Open Menu Shop Management
    Search Shop Name in Shop Management    ${shop_name}
    ${search_result}=    Get Shop Name From Search Result
    Found Shop From Search Shop Management    ${shop_name}    ${search_result}
    Go To Menu Policy Management
    Search Shop Policy In Policy Management    ${shop_name}
    ${policy_shop_code}=    Get Shop Name From Search Policy Result
    Page Should Contain    ${shop_name}
    [Teardown]    Run Keywords    Delete Shop By Shop Code    ${shop_code}
    ...    AND    Close Browser

TC_iTM_01335 API return error when not send data for create shop API
    [Tags]  TC_iTM_01335   API   Shop  create_shop  pcms  PCMS-API    ready    flash       regression    WLS_Medium
    ${shop_before}=    Count All Shop
    ${shop_name}=    Set Variable

    ${expect_code}=          Set Variable    400002
    ${expect_message}=       Set Variable    "shop_name is required"
    ${result}=     API Shop - Create Shop    ${shop_code}    ${shop_name}
    ${actual_code}=            Get Json Value    ${result}    /code
    ${actual_message}=         Get Json Value    ${result}    /message

    Should Be Equal    ${expect_code}    ${actual_code}
    Should Be Equal    ${expect_message}    ${actual_message}
    ${shop_after}=    Count All Shop
    Should Be Equal As Integers    ${shop_before}    ${shop_after}


TC_iTM_01336 API return success when send shop_code and shop name
    [Tags]  TC_iTM_01336   API   Shop  create_shop  pcms  PCMS-API    ready    flash    regression    WLS_Medium

    ${expect_code}=          Set Variable    200
    ${expect_message}=       Set Variable    "200 OK"
    ${result}=     API Shop - Create Shop    ${shop_code}    ${shop_name}
    ${actual_code}=            Get Json Value    ${result}    /code
    ${actual_message}=         Get Json Value    ${result}    /message

    Should Be Equal    ${expect_code}    ${actual_code}
    Should Be Equal    ${expect_message}    ${actual_message}

    Login Pcms
    Click Open Menu Shop Management
    Search Shop Name in Shop Management    ${shop_name}
    ${search_result}=    Get Shop Name From Search Result
    Found Shop From Search Shop Management    ${shop_name}    ${search_result}
    Go To Menu Policy Management
    Search Shop Policy In Policy Management    ${shop_name}
    Page Should Contain    ${shop_name}

    [Teardown]    Run Keywords    Delete Shop By Shop Code    ${shop_code}
    ...    AND    Close Browser

TC_iTM_01373 API return error when length of shop code more than 16 character
    [Tags]  TC_iTM_01373   API   Shop  create_shop  pcms  PCMS-API    ready    flash    regression    WLS_Medium
    ${shop_code}=    Set Variable    M1111111111111111111111

    ${expect_code}=          Set Variable    400002
    ${expect_message}=       Set Variable    "The shop_code may not be greater than 16 characters."
    ${result}=     API Shop - Create Shop    ${shop_code}    ${shop_name}
    ${actual_code}=            Get Json Value    ${result}    /code
    ${actual_message}=         Get Json Value    ${result}    /message

    Should Be Equal    ${expect_code}    ${actual_code}
    Should Be Equal    ${expect_message}    ${actual_message}

    Login Pcms
    Click Open Menu Shop Management
    Search Shop Name in Shop Management    ${shop_name}
    Not Found Shop From Search Shop Management
    Go To Menu Policy Management
    Not Found Shop From Policy Management    ${shop_name}
    [Teardown]    Run Keywords    Close Browser

TC_iTM_01797 API return error when length of shop code more than 255 character
    [Tags]  TC_iTM_01797   API   Shop  create_shop  pcms  PCMS-API   ready    QCT    flash  regression    WLS_Medium
    ${shop_name}=    Set Variable    ${255_chars}x

    ${expect_code}=          Set Variable    400002
    ${expect_message}=       Set Variable    "The shop_name may not be greater than 255 characters."
    ${result}=     API Shop - Create Shop    ${shop_code}    ${shop_name}
    ${actual_code}=            Get Json Value    ${result}    /code
    ${actual_message}=         Get Json Value    ${result}    /message

    Should Be Equal    ${expect_code}    ${actual_code}
    Should Be Equal    ${expect_message}    ${actual_message}

    Login Pcms
    Click Open Menu Shop Management
    Search Shop Name in Shop Management    ${shop_name}
    Not Found Shop From Search Shop Management
    Go To Menu Policy Management
    Not Found Shop From Policy Management    ${shop_name}
    [Teardown]    Run Keywords    Close Browser

TC_iTM_01375 API return error when input special charactors in shop_code
    [Tags]  TC_iTM_01375   API   Shop  create_shop  pcms  PCMS-API    ready    flash    regression    WLS_Medium
    #special ";"
    ${shop_code}=    Set Variable    MID0001
    ${shop_name}=    Set Variable    &#34;a;01&#34;

    ${expect_code}=          Set Variable    400002
    ${expect_message}=       Set Variable    "The shop_name format is invalid."
    ${result}=     API Shop - Create Shop    ${shop_code}    ${shop_name}
    ${actual_code}=            Get Json Value    ${result}    /code
    ${actual_message}=         Get Json Value    ${result}    /message

    Should Be Equal    ${expect_code}    ${actual_code}
    Should Be Equal    ${expect_message}    ${actual_message}

    #special ":"
    ${shop_code}=    Set Variable    MID0001
    ${shop_name}=    Set Variable    &#34:a:01&#34:

    ${expect_code}=          Set Variable    400002
    ${expect_message}=       Set Variable    "The shop_name format is invalid."
    ${result}=     API Shop - Create Shop    ${shop_code}    ${shop_name}
    ${actual_code}=            Get Json Value    ${result}    /code
    ${actual_message}=         Get Json Value    ${result}    /message

    Should Be Equal    ${expect_code}    ${actual_code}
    Should Be Equal    ${expect_message}    ${actual_message}

    Login Pcms
    Click Open Menu Shop Management
    Search Shop Name in Shop Management    ${shop_name}
    Not Found Shop From Search Shop Management
    Go To Menu Policy Management
    Not Found Shop From Policy Management    ${shop_name}
    [Teardown]    Run Keywords    Close Browser
