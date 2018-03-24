*** Settings ***
Resource        ${CURDIR}/webelement_css_create_shop.robot

*** Keywords ***
Set Logo(157x85) Image
    [Arguments]    ${imagePath}
    ${canonicalPath}=    Get Canonical Path    ${imagePath}
    Choose File    ${modalLogo_Desktop}    ${canonicalPath}
    Wait Until Element Is Visible    ${modalLoga_DesktopPre}

Set Logo(130x130) Image
    [Arguments]    ${imagePath}
    ${canonicalPath}=    Get Canonical Path    ${imagePath}
    Choose File    ${modalLogo_Mobile}    ${canonicalPath}
    Wait Until Element Is Visible    ${modalLogo_MobilePre}

Verify info on Create New Shop
    Selenium2Library.Element Text Should Be    ${newShop_title}    Add new shop    message=Add new shop Text Not Found.
    Write Name to console    \nCreate new shop show field data are correctly.
    Selenium2Library.Element Text Should Be    ${nameShop_text}    Shop name    message=Shop name Text Not Found.
    Selenium2Library.Element Text Should Be    ${merchantId_text}    Merchant Code (optional)    message=Merchant Code (optional) Text Not Found.
    Selenium2Library.Element Text Should Be    ${shopUrl_text}    Shop url    message=Shop url Text Not Found.
    Selenium2Library.Element Text Should Be    ${logo157x85_text}    Logo(157x85)    message=Logo(157x85) Text Not Found.
    Selenium2Library.Element Text Should Be    ${logo130x130_text}    Logo(130x130)    message=Logo(130x130) Text Not Found.

Input Shop name
    [Arguments]    ${shop_name}
    Input Text     ${shopName_field}    ${shop_name}

Input Shop Url
    [Arguments]    ${shop_url}
    Input Text     ${shopUrl_field}     ${shop_url}

Input Mechant Code
    [Arguments]    ${merchant_code}
    Input Text    ${merchantId_field}    ${merchant_code}

Click Edit Shop Web By Shop ID
    [Arguments]    ${shopId}
    Click Element and Wait Angular Ready    jquery=table.table-striped.table-hover tr[id='${shopId}-web'] td:eq(1)

Click Edit Shop Mobile By Shop ID
    [Arguments]     ${shopId}
    Click Element and Wait Angular Ready    jquery=table.table-striped.table-hover tr[id='${shopId}-mobile'] td:eq(1)

Error Message Shop Name Already Exists Appears
    Wait Until Element Is Visible    jquery=div.col-sm-9 span.select:contains("Shop name already exists")    5s    Error message 'Shop name already exists' not appears
    ${errormessage}=    Get Text    jquery=div.col-sm-9 #sfmShopName ~ span
    Should Be Equal As Strings    Shop name already exists    ${errormessage}    Error message 'Shop name already exists' not matched







