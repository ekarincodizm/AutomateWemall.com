*** Settings ***
Force Tags        WLS_Cart
Library     Selenium2Library
Resource    ${CURDIR}/../../../Keyword/Portal/wemall/Header/keywords_wemall_header.robot
Resource    ${CURDIR}/../../../Resource/Config/app_config.robot
Resource    ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource    ${CURDIR}/../../../Keyword/Portal/iTrueMart/Cart_light_box/Keywords_CartLightBox.robot
Resource    ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_1/Keywords_Checkout1.robot
Resource    ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_2/Keywords_Checkout2.robot
Resource    ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot

Test Setup       Prepare Browser
Test Teardown    Close Browser

#Test Template       Cart light box

*** Variables ***
${product_pkey}    2787537870208
${username}        robot02@mail.com
${password}        123456
${product_page_url}     ${WEMALL_URL}/products/electrolux-eje3000-2787537870208.html
${product_page_url_en}     ${WEMALL_URL}/en/products/electrolux-eje3000-2787537870208.html

*** Keywords ***
Prepare Browser
    Open Browser    ${ITM_URL}    chrome
    Set Window Position    ${0}    ${0}
    Set Window Size    ${1440}    ${900}

Cart - input data checkout 2
    Checkout2 - Input Name              robot01ja
    Checkout2 - Input Phone             0888888888
    Checkout2 - Input Email             ${username}
    sleep       1s
    Checkout2 - Select Province
    sleep       1s
    Checkout2 - Select District
    sleep       1s
    Checkout2 - Select SubDistrict
    Checkout2 - Select ZipCode
    Checkout2 - Input Address           robotmalawwwwww

Cart - Add Shipping Address
    User Click Add New Address Button
    Cart - input data checkout 2
    Checkout2 - Click Next
    sleep       3s
    Checkout2 - Click Next Member

*** Test Cases ***
TC_iTM_04069 - Cart light box - [TH] Guest back to level d page.
    [Tags]      Cart     desktop     regression    TC_iTM_04069    WLS_High
    Level D Go to level D with Product No Cache     ${product_pkey}
    Level D Click Add To Cart success case
    Sleep       3s
    Cart light box - Click product link     ${product_pkey}
    Cart light box - Verify prduct link     ${product_page_url}

TC_iTM_04070 - Cart light box - [EN] Guest back to level d page.
    [Tags]      Cart     desktop     regression    TC_iTM_04070    WLS_Medium
    Level D Go To En Level D With Product     ${product_pkey}
    Level D Click Add To Cart success case
    Sleep       3s
    Cart light box - Click product link     ${product_pkey}
    Cart light box - Verify prduct link     ${product_page_url_en}

TC_iTM_04071 - Cart light box - [TH] Member back to level d page.
    [Tags]      Cart     desktop     regression    TC_iTM_04071    WLS_Medium
    Login User to WeMall    ${username}     ${password}
    Level D Go to level D with Product No Cache     ${product_pkey}
    Level D Click Add To Cart success case
    Sleep       3s
    Cart light box - Click product link     ${product_pkey}
    Cart light box - Verify prduct link     ${product_page_url}

TC_iTM_04072 - Cart light box - [EN] Member back to level d page.
    [Tags]      Cart     desktop     regression    TC_iTM_04072    WLS_High
    Login User to WeMall    ${username}     ${password}
    Level D Go To En Level D With Product     ${product_pkey}
    Level D Click Add To Cart success case
    Sleep       3s
    Cart light box - Click product link     ${product_pkey}
    Cart light box - Verify prduct link     ${product_page_url_en}

TC_iTM_04073 - Cart light box - [TH] Guest back to level d Check out step 1 page.
    [Tags]      Cart     desktop     regression    TC_iTM_04073    WLS_High
    Level D Go to level D with Product No Cache     ${product_pkey}
    Level D Click Add To Cart success case
    Sleep       3s
    Next to Checkout 1
    Sleep       3s
    Cart light box - Click edit cart
    Cart light box - Click product link     ${product_pkey}
    Cart light box - Verify prduct link     ${product_page_url}

TC_iTM_04074 - Cart light box - [EN] Guest back to level d Check out step 1 page.
    [Tags]      Cart     desktop     regression    TC_iTM_04074    WLS_Medium
    Level D Go To En Level D With Product       ${product_pkey}
    Level D Click Add To Cart success case
    Sleep       3s
    Next to Checkout 1
    Cart light box - Click edit cart
    Cart light box - Click product link     ${product_pkey}
    Cart light box - Verify prduct link     ${product_page_url_en}

TC_iTM_04075 - Cart light box - [TH] Guest back to level d Check out step 2 page.
    [Tags]      Cart     desktop     regression    TC_iTM_04075    WLS_Medium
    Level D Go To Level D With Product       ${product_pkey}
    Level D Click Add To Cart success case
    Sleep       3s
    Next to Checkout 1
    Checkout1 - Input Email                     ${username}
    Checkout1 - Click Next
    Cart light box - Click edit cart
    Cart light box - Click product link     ${product_pkey}
    Cart light box - Verify prduct link     ${product_page_url}

TC_iTM_04076 - Cart light box - [EN] Guest back to level d Check out step 2 page.
    [Tags]      Cart     desktop     regression    TC_iTM_04076    WLS_Medium
    Level D Go To En Level D With Product       ${product_pkey}
    Level D Click Add To Cart success case
    Sleep       3s
    Next to Checkout 1
    Checkout1 - Input Email                     ${username}
    Checkout1 - Click Next
    Cart light box - Click edit cart
    Cart light box - Click product link     ${product_pkey}
    Cart light box - Verify prduct link     ${product_page_url_en}

TC_iTM_04077 - Cart light box - [TH] Member back to level d Check out step 2 page.
    [Tags]      Cart     desktop     regression    TC_iTM_04077    WLS_Medium
    Login User to WeMall    ${username}     ${password}
    Level D Go To Level D With Product       ${product_pkey}
    Level D Click Add To Cart success case
    Sleep       3s
    Next to Checkout 1
    Cart light box - Click edit cart
    Cart light box - Click product link     ${product_pkey}
    Cart light box - Verify prduct link     ${product_page_url}

TC_iTM_04078 - Cart light box - [EN] Member back to level d Check out step 2 page.
    [Tags]      Cart     desktop     regression    TC_iTM_04078    WLS_High
    Login User to WeMall    ${username}     ${password}
    Level D Go To En Level D With Product       ${product_pkey}
    Level D Click Add To Cart success case
    Sleep       3s
    Next to Checkout 1
    Cart light box - Click edit cart
    Cart light box - Click product link     ${product_pkey}
    Cart light box - Verify prduct link     ${product_page_url_en}

TC_iTM_04079 - Cart light box - [TH] Guest back to level d Check out step 3 page.
    [Tags]      Cart     desktop     regression    TC_iTM_04079    WLS_Medium
    Level D Go To Level D With Product       ${product_pkey}
    Level D Click Add To Cart success case
    Sleep       3s
    Next to Checkout 1
    Checkout1 - Input Email                     ${username}
    Checkout1 - Click Next
    cart - input data checkout 2
    Checkout2 - Click Next
    sleep       3s
    Cart light box - Click edit cart
    Cart light box - Click product link     ${product_pkey}
    Cart light box - Verify prduct link     ${product_page_url}

TC_iTM_04080 - Cart light box - [EN] Guest back to level d Check out step 3 page.
    [Tags]      Cart     desktop     regression    TC_iTM_04080    WLS_Medium
    Level D Go To En Level D With Product       ${product_pkey}
    Level D Click Add To Cart success case
    Sleep       3s
    Next to Checkout 1
    Checkout1 - Input Email                     ${username}
    Checkout1 - Click Next
    cart - input data checkout 2
    Checkout2 - Click Next
    sleep       3s
    Cart light box - Click edit cart
    Cart light box - Click product link     ${product_pkey}
    Cart light box - Verify prduct link     ${product_page_url_en}

TC_iTM_04081 - Cart light box - [TH] Member back to level d Check out step 3 page.
    [Tags]      Cart     desktop     regression    TC_iTM_04081    WLS_High
    Login User to WeMall    ${username}     ${password}
    Level D Go To Level D With Product       ${product_pkey}
    Level D Click Add To Cart success case
    Sleep       3s
    Next to Checkout 1
    ${status}=      Run keyword and return status       Checkout2 - Click Next Member
    Run keyword if  '${status}' == 'False'      Cart - Add Shipping Address
    sleep       5s
    Cart light box - Click edit cart
    sleep       1s
    Cart light box - Click product link     ${product_pkey}
    Cart light box - Verify prduct link     ${product_page_url}

TC_iTM_04082 - Cart light box - [EN] Member back to level d Check out step 3 page.
    [Tags]      Cart     desktop     regression    TC_iTM_04082    WLS_Medium
    Login User to WeMall    ${username}     ${password}
    Level D Go To En Level D With Product       ${product_pkey}
    Level D Click Add To Cart success case
    Sleep       3s
    Next to Checkout 1
    ${status}=      Run keyword and return status       Checkout2 - Click Next Member
    Run keyword if  '${status}' == 'False'      Cart - Add Shipping Address
    sleep       5s
    Cart light box - Click edit cart
    sleep       1s
    Cart light box - Click product link     ${product_pkey}
    Cart light box - Verify prduct link     ${product_page_url_en}
