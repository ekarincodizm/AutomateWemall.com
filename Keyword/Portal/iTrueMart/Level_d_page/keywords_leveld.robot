*** Settings ***
Library           DatabaseLibrary
Library           XML
Resource          ${CURDIR}/../../../Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Common/keywords_itruemart_common.robot
Resource          ${CURDIR}/../../../../Keyword/Portal/wemall/lv_d/lv_d.robot
Resource          WebElement_LevelD.robot
Resource          web_element_level_d.robot
Resource          ${CURDIR}/../../../../Resource/TestData/Mnp/Images/resource.robot
Resource          ${CURDIR}/../../../../Resource/Config/${ENV}/env_config.robot
Resource          ${CURDIR}/../Cart_light_box/WebElement_CartLightBox.robot
Resource          ${CURDIR}/../Cart_light_box/Keywords_CartLightBox.robot
Resource          ${CURDIR}/../../../../Keyword/Common/keywords_wemall_common.robot
Library           ${CURDIR}/../../../../Python_Library/common.py
Library           ${CURDIR}/../../../../Python_Library/common/web_element_library.py
Library           ${CURDIR}/../../../../Python_Library/mnp_util.py
Library           ${CURDIR}/../../../../Python_Library/product.py
Library           ${CURDIR}/../../../../Python_Library/DatabaseData.py

*** Variables ***
#for test alpha,staging
${collection1-1_flash}    แม่และเด็ก
${collection1-2_flash}    เด็ก
${collection1-3_flash}    ของเล่นเด็ก
${collection1-4_flash}    ตัวต่อ
${product_flash}    flash team(don't touch)

*** Keywords ***
Level D Go to level D with Product
    [Arguments]    ${Product}
    Go to    ${ITM_URL}/products/${Product}.html
    Wemall Common - Close Live Chat

Level D Go to en level D with Product
    [Arguments]    ${Product}
    Go to    ${ITM_URL}/en/products/${Product}.html
    Wemall Common - Close Live Chat

Level D Go to level D with Product No Cache
    [Arguments]    ${Product}
    Go to    ${ITM_URL}/products/${Product}.html
    Sleep    3s
    ${url}=    Get Location
    Go to    ${url}?no-cache=1
    Wemall Common - Close Live Chat

Open Browser ITM-levelD
    [Arguments]    ${product}
    Open Browser    ${ITM_URL}/products/${product}.html    ${Browser}
    Maximize Browser Window
    Wemall Common - Close Live Chat

Open Browser ITM-en-levelD
    [Arguments]    ${product}
    Open Browser    ${ITM_URL}/en/products/${product}.html    ${Browser}
    Wemall Common - Close Live Chat

Open Browser ITM-levelD No Cache
    [Arguments]    ${product}
    Open Browser    ${ITM_URL}/products/${product}.html    ${Browser}
    ${url}=    Get Location
    Go to    ${url}?no-cache=1
    Wemall Common - Close Live Chat

Level D Open Browser ITM-levelD Web Of Normal Product
    ${inven_ID}=    product.get_inventory_normal
    ${product_pkey}=    product.get_product_pkey    ${inven_ID}
    Open Browser ITM-levelD    items-${product_pkey}
    Wemall Common - Close Live Chat

Level D Display Level D Page
    Wait Until Element Is Visible    ${XPATH_LEVEL_D.wrapper}
    Element Should Be Visible    ${XPATH_LEVEL_D.wrapper}

Level D Select All Option Of Product Variant in Level D If Exist
    ${option_count}=    Get Matching Xpath Count    //*[@class="style-types"]
    : FOR    ${x}    IN RANGE    ${option_count}
    \    Wait Until Element Is Visible              //*[@class="style-types"][${x+1}]      20
    \    Click Element                              //*[@class="style-types"][${x+1}]//a
    \    Sleep      3s

Level D Select Product Variance in Level D
    [Arguments]    ${Color_position}=1    ${Size_position}=1
    ${LvD_Color_Element}    Replace string in WebElelment    ${LvD_Color_position}    ${Color_position}
    ${color_displayed}    Run Keyword And Return Status    Element Should Be Visible    ${LvD_Color_Element}
    Run Keyword If    '${color_displayed}' == '${True}'    Click Element    ${LvD_Color_Element}
    ${LvD_Size_Element}    Replace string in WebElelment    ${LvD_Size_position}    ${Size_position}
    ${Size_displayed}    Run Keyword And Return Status    Element Should Be Visible    ${LvD_Size_Element}
    Run Keyword If    '${Size_displayed}' == '${True}'    Click Element    ${LvD_Size_Element}
    Wait Until Element Is Not Visible    ${LvD_LoadingImg}    20s

Level D Select Variance item
    [Arguments]    ${Color_position}=1    ${Size_position}=1
    ${LvD_Color_Element}    Replace string in WebElelment    ${LvD_Color_position}    ${Color_position}
    ${color_displayed}    Run Keyword And Return Status    Element Should Be Visible    ${LvD_Color_Element}
    Run Keyword If    '${color_displayed}' == '${True}'    Click Element    ${LvD_Color_Element}
    ${LvD_Size_Element}    Replace string in WebElelment    ${LvD_Size_position}    ${Size_position}
    ${Size_displayed}    Run Keyword And Return Status    Element Should Be Visible    ${LvD_Size_Element}
    Run Keyword If    '${Size_displayed}' == '${True}'    Click Element    ${LvD_Size_Element}
    Wait Until Element Is Not Visible    ${LvD_LoadingImg}    20s

Level D Select Product size in Level D
    [Arguments]    ${position}=1
    ${LvD_Variance_Element}    Replace string in WebElelment    xpath=//*[@class="prd_control options"]/ul[contains(@data-style-name, "Size")]/li[REPLACE_ME]/a    ${position}
    Wait Until Element is ready and click    ${LvD_Variance_Element}    10
    Comment    Wait Until Element Is Visible    ${LvD_Active_status}    20s
    Wait Until Element Is Not Visible    ${LvD_LoadingImg}    20s

Level D Choose Product Color
    ${color}=    Set Variable    //ul[@data-style-name="สี"]
    ${have_color}=    Run Keyword And Return Status    Element Should Be Visible    ${color}
    Run Keyword If    ${have_color}    Level D Choose Product Color Item
    Sleep    5s

Level D Choose Product Color Item
    [Arguments]    ${color_no}=1
    ${div_stock_active}=    Set Variable    //div[@class="box_status active box-status-has-stock"]
    ${div_stock_inactive}=    Set Variable    //div[@class="box_status inc_active box-status-no-stock"]
    ${color}=    Set Variable    //ul[@data-style-name="สี"]/li
    ${have_color}=    Run Keyword And Return Status    Element Should Be Visible    ${color}
    Run Keyword If    ${have_color}    Click Element    ${color}
    Sleep    3s
    ${have_stock}=    Run Keyword And Return Status    Element Should Be Visible    ${div_stock_inactive}
    ${color_no}=    Evaluate    ${color_no} + 1
    Run Keyword If    ${have_stock}    Level D Choose Product Color Item    ${color_no}

Level D Add Quantity
    Wait Until Element Is Visible    ${LvD_Add_item}    30s
    Click Element    ${LvD_Add_item}

Level D Assert Bundle box
    Wait Until Element Is Visible    ${LvD_BundleBox}    60s
    Wait Until Element Is Visible    ${LvD_BundleDevice}    60s
    Wait Until Element Is Visible    ${LvD_BundleSim}    60s

Level D Purchase Bundle
    Wait Until Element is ready and click    ${Btn_BundlePurchase}    60s
    Wait Until Element is ready and click    //*[@class="btn btn-order-all"][contains(text(),'สั่งซื้อทั้งหมด')]    60s

Level D Assert variance is out of stock
    Element Should Be Visible    ${LvD_Product_Out_Of_Stock}
    Element Should Be Visible    ${Buy_Product_Button_disabled}

Level D Select Product Variance and expect variance to be out of stock
    [Arguments]    ${position}
    ${element}    Replace string in WebElelment    ${LvD_Variance_position}    ${position}
    Wait Until Element is ready and click    ${element}    10
    Wait Until Element Is Not Visible    ${LvD_LoadingImg}    20s
    Level D Assert variance is out of stock
    Click Element    ${LvD_Add_item}

Level D Go To Product Level D
    [Arguments]    ${product_pkey}
    Go To    ${ITM_URL}/products/item-${product_pkey}.html
    Maximize Browser Window

Level D Click Add To Cart fail case
    Wait Until Element is ready and click    ${LvD_Add_to_Cart}    60
    Wait Until Element Is Not Visible    ${LvD_LoadingImg}    20s
    Comment    ${is_cart_appreae}    Run Keyword And Return Status    Element Should Be Visible    ${CartLightBox_Qualtity}
    Comment    Run Keyword If    '${is_cart_appreae}'!='True'    Wait Until Element is ready and click    ${LvD_Add_to_Cart}    60

Level D Click Add To Cart success case
    Wemall Common - Close Live Chat
    Wait Until Element is ready and click    ${LvD_Add_to_Cart}    60s
    Wait Until Element Is Not Visible    ${LvD_LoadingImg}    20s
    ${is_cart_appreae}    Run Keyword And Return Status    Element Should Be Visible    ${CartLightBox_Qualtity}
    Run Keyword If    '${is_cart_appreae}'!='True'    Wait Until Element is ready and click    ${LvD_Add_to_Cart}    60

Level D Click Add To Cart success case for mobile
    Wemall Common - Close Live Chat
    Wait Until Element is ready and click    ${LvD_Add_to_Cart_mobile}    60s
    Wait Until Element Is Not Visible    ${LvD_LoadingImg}    20s
    ${is_cart_appreae}    Run Keyword And Return Status    Element Should Be Visible    ${CartLightBox_Qualtity}
    Run Keyword If    '${is_cart_appreae}'!='True'    Wait Until Element is ready and click    ${LvD_Add_to_Cart_mobile}    60

LvD - Click Mnp Tab
    Wait Until Ajax Loading Is Not Visible
    Wait Until Element Is Not Visible    ${LvD_wow_pack_loading}    60s
    Wait Until Element Is Visible    ${XPATH_LEVEL_D.tab_mnp}    60s
    Click Element    ${XPATH_LEVEL_D.tab_mnp}

LvD - Click Bundle Tab
    Wait Until Ajax Loading Is Not Visible
    Wait Until Element Is Not Visible    ${LvD_wow_pack_loading}    60s
    Wait Until Element Is Visible    ${XPATH_LEVEL_D.tab_bundle}    60s
    Click Element    ${XPATH_LEVEL_D.tab_bundle}

LvD - Bundle Tab Is Visible
    Wait Until Element Is Visible    ${XPATH_LEVEL_D.tab_bundle}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${XPATH_LEVEL_D.tab_bundle}

LvD - Mnp Tab Is Visible
    #Wait Until Ajax Loading Is Not Visible
    Wait Until Element Is Visible    ${XPATH_LEVEL_D.tab_mnp}    ${CHECKOUT_TIMEOUT}
    Element Should Be Visible    ${XPATH_LEVEL_D.tab_mnp}

LvD - Mnp Tab Not Be Visible
    Wait Until Ajax Loading Is Not Visible
    Wait Until Element Is Not Visible    ${LvD_wow_pack_loading}    20
    Element Should Not Be Visible    ${XPATH_LEVEL_D.tab_mnp}

LvD - Bundle Tab Not Be Visible
    Wait Until Ajax Loading Is Not Visible
    Wait Until Element Is Not Visible    ${LvD_wow_pack_loading}    20
    Element Should Not Be Visible    ${XPATH_LEVEL_D.tab_bundle}

Check category trail of level D under menu bar is correctly
    Wait Until Element Is Visible    ${cate_trail_levelD}    15s
    ${list_collection}=    Create List    ${collection1-1_flash}    ${collection1-2_flash}    ${collection1-3_flash}    ${collection1-4_flash}    ${product_flash}
    ${count}=    Get Matching Xpath Count    //*[@class="breadcrumb__link"]/li
    Log To Console    ${count}
    ${count}=    Evaluate    ${count}
    : FOR    ${index}    IN RANGE    2    ${count}
    \    Log To Console    index=${index}
    \    ${get_trail}=    Get Text    //*[@class="breadcrumb__link"]/li[${index}]
    \    Log To Console    get=${get_trail}
    \    ${test}=    List Should Contain Value    ${list_collection}    ${get_trail}
    # Wait Until Element Is Visible    ${XPATH_LEVEL_D.tab_bundle}    10
    # Click Element    ${XPATH_LEVEL_D.tab_bundle}

LvD - Click Style Option By Variant Pkey
    [Arguments]    ${variant_pkey}
    ${style_pkey}=    Get From List    ${variant_pkey}    0
    ${style_pkey}=    Convert To String    ${style_pkey}
    ${replaced_xpath}=    Replace String    ${XPATH_LEVEL_D.style_option}    ^^style_pkey^^    ${style_pkey}
    Wait Until Element Is Visible    ${replaced_xpath}
    Click Element    ${replaced_xpath}

LvD - Remove Chatbar
    ${chatbar}=    Get Matching Xpath Count    ${XPATH_LEVEL_D.chatbar}
    ${floating_ads}=    Get Matching Xpath Count    ${XPATH_LEVEL_D.floating_ads}
    Run Keyword If    '${chatbar}' > '0'    Execute Javascript    document.getElementById('chatbar').style.display = 'none';
    Run Keyword If    '${floating_ads}' > '0'    Execute Javascript    document.getElementById('floating-ads').style.display='none';

LvD - Click Bundle Package Information
    Wait Until Element is Visible    ${XPATH_LEVEL_D.href_bundle_package_information}    60
    Click Element    ${XPATH_LEVEL_D.href_bundle_package_information}

LvD - Open Level D Page By Product Pkey
    [Arguments]    ${product_pkey}
    Open Browser    ${ITM_URL}/products/item-${product_pkey}.html    ${BROWSER}
    Maximize Browser Window

LvD - Count Price Plan Bundle
    ${priceplan_count}=    Get Matching Xpath Count    ${XPATH_LEVEL_D.package_box}
    [Return]    ${priceplan_count}

LvD - Count Price Plan MNP Device
    ${priceplan_count}=    Get Matching Xpath Count    ${XPATH_LEVEL_D.mnp_package}
    [Return]    ${priceplan_count}

LvD - Click MNP Device Package Information
    Wait Until Element is Visible    ${XPATH_LEVEL_D.href_mnp_device_package_information}    60
    Click Element    ${XPATH_LEVEL_D.href_mnp_device_package_information}

Go to Level D by Pkey
    [Arguments]    ${product_pkey}
    Go to    ${ITM_URL}/products/${product_pkey}.html

Click Add to Cart
    Wait Until Element is Visible    jquery=.box_status.active.box-status-has-stock    30s
    Wait Until Element is Visible    ${LvD_Add_to_Cart}    30s
    Click Element    ${LvD_Add_to_Cart}

Add Product to Cart
    [Arguments]    ${product_pkey}
    Go to Level D by Pkey    ${product_pkey}
    Wait Until Element is Visible    ${LvD_Add_to_Cart}    30s
    Click Add to Cart
    keywords_full_cart.Verify Cart Light Box is Not Empty

Add Product to Cart Not Check Full Cart
    [Arguments]    ${product_pkey}
    Go to Level D by Pkey    ${product_pkey}
    Wait Until Element is Visible    ${LvD_Add_to_Cart}    30s
    Click Add to Cart
    keywords_full_cart.Display Full Cart

LvD - Click Buy All
    Wemall Common - Close Live Chat
    Wait Until Element is Visible    id=bundle-btn-order    60
    Click Element    id=bundle-btn-order

Should Be Without PricePlan
    Wait Until Element Is Visible    xpath=//div[@class="modal ng-isolate-scope in"]/div/div/div[1]/div/h3    60
    ${expect_without_priceplan}    Get Text    xpath=//div[@class="modal ng-isolate-scope in"]/div/div/div[1]/div/h3
    Should Be Equal    ${expect_without_priceplan}    ขออภัยค่ะ

Countinue To Next Page1
    Wait Until Element Is Visible    xpath=//div[@class="section-footer"]/button
    Click Element    xpath=//div[@class="section-footer"]/button

Input MNP2 Register Form
    Maximize Browser Window
    Select From List    id=marital_status    โสด
    ${resource}=    Get Path Picture Profile
    Log To Console    ${resource}
    Choose File    name=file    ${resource}/NoFace.jpg
    Sleep    3s

Countinue To Next Page2
    Click Element    xpath=//button[@data-goto="3"]

Accept Checkbox
    Wait Until Element Is Visible    name=accept-conditions    60
    Click Element    name=accept-conditions
    Wait Until Element Is Visible    xpath=//div[@class="modal-footer"]/button    60
    Click Element    xpath=//div[@class="modal-footer"]/button
    Wait Until Element Is Visible    id=confirm-form    60
    Click Element    id=confirm-form

Page Show Dialog Without Priceplan
    Page Should Contain Element    //div[@id="modalWindow"]/div/div

Level D - User Click Add To Cart Button
    Wait Until Ajax Loading Is Not Visible
    Wait Until Element Is Visible    ${XPATH_LEVEL_D.btn_add_to_cart}    ${CHECKOUT_TIMEOUT}
    Wemall Common - Close Live Chat
    Sleep    2s
    Click Element    ${XPATH_LEVEL_D.btn_add_to_cart}

LvD - User Click Buy Button Bundle
    Wait Until Element Is Visible    ${XPATH_LEVEL_D.btn_buy_bundle}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_LEVEL_D.btn_buy_bundle}

LvD - User Click Buy Button MNP
    Wait Until Element Is Visible    ${XPATH_LEVEL_D.btn_buy_mnp}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_LEVEL_D.btn_buy_mnp}

Level D - Increase Product Quantity
    Wait Until ELement Is Visible    ${XPATH_LEVEL_D.step_arrow_up}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_LEVEL_D.step_arrow_up}
    Wait Until Element Is Not Visible    ${LvD_LoadingImg}    15

Level D - Decrease Product Quantity
    Wait Until ELement Is Visible    ${XPATH_LEVEL_D.step_arrow_down}    ${CHECKOUT_TIMEOUT}
    Click Element    ${XPATH_LEVEL_D.step_arrow_down}
    Wait Until Element Is Not Visible    ${LvD_LoadingImg}    15

Level D - Get Delivery Time
    Wait Until Element Is Visible    ${level_d_delivery_time}    10
    ${delivery_time}=    Get Text    ${level_d_delivery_time}
    [Return]    ${delivery_time}

Level D - Delivery Time Should Be
    [Arguments]    ${expected_text}
    Wait Until Element Is Visible    ${level_d_delivery_time}    10
    Selenium2Library.Element Text Should Be    ${level_d_delivery_time}    ${expected_text}

Level D - Page Should Not Contain Delivery Time
    Page Should Not Contain    ${level_d_delivery_time}

Level D - Get Delivery Policy Title
    Wait Until Element Is Visible    ${level_d_delivery_policy_title}    10
    ${delivery_policy_title}    Get Text    ${level_d_delivery_policy_title}
    ${delivery_policy_subtitle}    Get Text    ${level_d_delivery_policy_subtitle}
    ${policy_only}=    Replace String Using Regexp    ${delivery_policy_title}    \\s*${delivery_policy_subtitle}$    ${EMPTY}
    [Return]    ${policy_only}

Level D - Delivery Policy Title Should Be
    [Arguments]    ${expected_text}
    ${policy}=    Level D - Get Delivery Policy Title
    Should Be Equal As Strings    ${expected_text}    ${policy}

Level D - Get Refund Policy Title
    Wait Until Element Is Visible    ${level_d_refund_policy_title}    10
    ${refund_policy_title}    Get Text    ${level_d_refund_policy_title}
    ${refund_policy_subtitle}    Get Text    ${level_d_refund_policy_subtitle}
    ${policy_only}=    Replace String Using Regexp    ${refund_policy_title}    \\s*${refund_policy_subtitle}$    ${EMPTY}
    [Return]    ${policy_only}

Level D - Refund Policy Title Should Be
    [Arguments]    ${expected_text}
    ${policy}=    Level D - Get Refund Policy Title
    Should Be Equal As Strings    ${expected_text}    ${policy}

Level D - Get Return Policy Title
    Wait Until Element Is Visible    ${level_d_return_policy_title}    10
    ${return_policy_title}    Get Text    ${level_d_return_policy_title}
    ${return_policy_subtitle}    Get Text    ${level_d_return_policy_subtitle}
    ${policy_only}=    Replace String Using Regexp    ${return_policy_title}    \\s*${return_policy_subtitle}$    ${EMPTY}
    [Return]    ${policy_only}

Level D - Return Policy Title Should Be
    [Arguments]    ${expected_text}
    ${policy}=    Level D - Get Return Policy Title
    Should Be Equal As Strings    ${expected_text}    ${policy}

Level D - Delivery Policy Detail Should Be
    [Arguments]    ${expected_text}
    Wait Until Element Is Visible    ${level_d_delivery_policy_description}
    Selenium2Library.Element Text Should Be    ${level_d_delivery_policy_description}    ${expected_text}

Level D - Refund Policy Detail Should Be
    [Arguments]    ${expected_text}
    Wait Until Element Is Visible    ${level_d_refund_policy_description}
    Selenium2Library.Element Text Should Be    ${level_d_refund_policy_description}    ${expected_text}

Level D - Return Policy Detail Should Be
    [Arguments]    ${expected_text}
    Wait Until Element Is Visible    ${level_d_return_policy_description}
    Selenium2Library.Element Text Should Be    ${level_d_return_policy_description}    ${expected_text}

Level D - Click Delivery Policy Tab
    Wait Until Element Is Visible    ${level_d_delivery_policy_tab}    10
    ${elem}=    Get Webelement    ${level_d_delivery_policy_tab}
    Scroll To Element    ${elem}    0    100
    Click Element    ${level_d_delivery_policy_tab}

Level D - Click Refund Policy Tab
    Wait Until Element Is Visible    ${level_d_refund_policy_tab}    10
    ${elem}=    Get Webelement    ${level_d_refund_policy_tab}
    Scroll To Element    ${elem}    0    100
    Click Element    ${level_d_refund_policy_tab}

Level D - Click Return Policy Tab
    Wait Until Element Is Visible    ${level_d_return_policy_tab}    10
    ${elem}=    Get Webelement    ${level_d_return_policy_tab}
    Scroll To Element    ${elem}    0    100
    Click Element    ${level_d_return_policy_tab}

Level D - Wait Until Loading Page Is Not Visible
    [Arguments]    ${loading_delay}=20
    Wait Until Element Is Not Visible    ${LvD_LoadingImg}    ${loading_delay}

Level D - Open Level D With Any Product
    [Arguments]    ${lang}=th
    ${inv_id}=    product.Get Inventory Normal
    ${product_pkey}=    product.Get Product Pkey    ${inv_id}
    Run Keyword If    '${lang}'=='th'    Open Browser    ${ITM_URL}/products/items-${product_pkey}.html    ${BROWSER}
    ...    ELSE    Open Browser    ${ITM_URL}/${lang}/products/items-${product_pkey}.html    ${BROWSER}

Level D - Open Level D With Any Product From URL
    [Arguments]    ${url}    ${lang}=th
    ${inv_id}=    product.Get Inventory Normal
    ${product_pkey}=    product.Get Product Pkey    ${inv_id}
    Run Keyword If    '${lang}'=='th'    Open Browser    ${url}/products/items-${product_pkey}.html    ${BROWSER}
    ...    ELSE    Open Browser    ${url}/${lang}/products/items-${product_pkey}.html    ${BROWSER}

Level D - Open Browser With Any Product
    ${inv_id}=    product.Get Inventory Normal
    ${product_pkey}=    product.Get Product Pkey    ${inv_id}
    Open Browser    ${ITM_URL}/products/items-${product_pkey}.html    ${BROWSER}
    Maximize Browser Window
    ${dict}=    Set Variable    ${TEST_VAR}
    Set To Dictionary    ${dict}    inv_id=${inv_id}
    Set Test Variable    ${TEST_VAR}    ${dict}

Level D - Open Browser With Any Product EN
    ${inv_id}=    product.Get Inventory Normal
    ${product_pkey}=    product.Get Product Pkey    ${inv_id}
    Open Browser    ${ITM_URL}/en/products/items-${product_pkey}.html    ${BROWSER}
    ${dict}=    Set Variable    ${TEST_VAR}
    Set To Dictionary    ${dict}    inv_id=${inv_id}
    Set Test Variable    ${TEST_VAR}    ${dict}

Level D - Open Browser Follow Up Lang With Any Product
    [Arguments]    ${lang}=th
    ${inv_id}=    product.Get Inventory Normal
    ${product_pkey}=    product.Get Product Pkey    ${inv_id}
    Open Browser    ${ITM_URL}/${lang}/products/items-${product_pkey}.html    ${BROWSER}
    Maximize Browser Window
    ${dict}=    Set Variable    ${TEST_VAR}
    Set To Dictionary    ${dict}    inv_id=${inv_id}
    Set Test Variable    ${TEST_VAR}    ${dict}

Level D - User Select Sku If Visible And Click Add To Cart Button
    Click Element    ${ld_normal_variant_style1}
    Wait Until Ajax Loading Is Not Visible
    Wait Until ELement Is Visible    ${XPATH_LEVEL_D.btn_add_to_cart}    ${CHECKOUT_TIMEOUT}
    Wemall Common - Close Live Chat
    Click ELement    ${XPATH_LEVEL_D.btn_add_to_cart}
    Wait Until Element Is Not Visible    ${LvD_LoadingImg}    20s

Get Product Name Level D
    ${product_levelD_name}=    Get Text    ${XPATH_LEVEL_D.product_lvD_name}
    #######################################################################################
    [Return]    ${product_levelD_name}

Level D - Open Browser And Go To Level D
    ${inv_id}=    Get From Dictionary    ${TEST_VAR}    inv_id
    ${product_pkey}=    Get From Dictionary    ${TEST_VAR}    product_pkey
    ${product_slug}=    Get From Dictionary    ${TEST_VAR}    product_slug
    Level D - Open Browser Level D With Pkey And Slug And No Cache    ${product_pkey}    ${product_slug}
    # Level D - Open Browser Level D
    #    ${inv_id}=    Get From Dictionary    ${TEST_VAR}    inv_id
    #    ${product_pkey}=    Get From Dictionary    ${TEST_VAR}    product_pkey
    #    ${product_slug}=    Get From Dictionary    ${TEST_VAR}    product_slug
    #    Open Browser    ${ITM_ITM}/products/${product_slug}-${product_pkey}.html    ${BROWSER}

Level D - Open Browser Level D With Pkey And Slug And No Cache
    [Arguments]    ${product_pkey}    ${product_slug}
    Log to console    =======
    Log to console    PRODUCT_MOBILE=${ITM_URL}/products/${product_slug}-${product_pkey}.html?no-cache=1
    Log to console    =======
    Open Browser    ${ITM_URL}/products/${product_slug}-${product_pkey}.html?no-cache=1    ${BROWSER}
    #Open Browser    ${ITM_URL}/products/${product_slug}-${product_pkey}.html    ${BROWSER}
    Maximize Browser Window

Level D - Go To Level D With Pkey And Slug And No Cache
    [Arguments]    ${product_pkey}    ${product_slug}
    Log to console    =======
    Log to console    PRODUCT_MOBILE=${ITM_URL}/products/${product_slug}-${product_pkey}.html?no-cache=1
    Log to console    =======
    Go To    ${ITM_URL}/products/${product_slug}-${product_pkey}.html?no-cache=1

Level D - Get Level D Sale Price
    Level D - Normal Price Is Displayed
    ${count_special_price}=    Get Matching Xpath Count    ${XPATH_LEVEL_D.lbl_special_price}

    Log To Console   xpath-special-price=${XPATH_LEVEL_D.lbl_special_price}
    Log To Console   xpath-normal-price=${XPATH_LEVEL_D.lbl_normal_price}

    Log to console    count_special_price=${count_special_price}

    ${sale_price}=    Run Keyword If    '${count_special_price}' > '0'    Get Text    ${XPATH_LEVEL_D.lbl_special_price}
    ...    ELSE    Get Text    ${XPATH_LEVEL_D.lbl_normal_price}
    Log to console    sale_price0=${sale_price}
    ${sale_price}=    Replace String    ${sale_price}    ,    ${EMPTY}
    Log to console    sale_price1=${sale_price}
    ${sale_price}=    mnp_util.Py Convert To Float    ${sale_price}
    Log to console    sale_price2=${sale_price}
    Wemall Common - Assign Value TO Test Variable    level_d_price    ${sale_price}
    #${dict}=    Set Variable    ${TEST_VAR}
    #Set To Dictionary    ${dict}    level_d_price=${sale_price}
    #Set Test Variable    ${TEST_VAR}    ${dict}

Level D - Get Level D Sku Price
    ${special_price_is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${XPATH_LEVEL_D.lbl_special_price}
    ${sale_price}=    Run Keyword If    '${special_price_is_visible}' == '${True}'    Get Text    ${XPATH_LEVEL_D.lbl_special_price}
    ...    ELSE    Get Text    ${XPATH_LEVEL_D.lbl_normal_price}
    Log to console    sale_price0=${sale_price}
    ${sale_price}=    Replace String    ${sale_price}    ,    ${EMPTY}
    Log to console    sale_price1=${sale_price}
    ${sale_price}=    mnp_util.Py Convert To Float    ${sale_price}
    Log to console    sale_price2=${sale_price}
    ${dict}=    Set Variable    ${TEST_VAR}
    Set To Dictionary    ${dict}    sku_price=${sale_price}
    Set Test Variable    ${TEST_VAR}    ${dict}

Level D - User Select Style Options

    [Arguments]   ${inv_id}=${TEST_VAR.inv_id}
    #${inv_id}=    Get From Dictionary    ${TEST_VAR}    inv_id
    #${inv_id}=    Wemall Common - Get Value From Test Variable    inv_id
    Wemall Common - Debug    ${inv_id}    inv_id_user_select_style_options
    Run Keyword If    '${DEBUG}' == 'True'    Log To Console    inv_id from test variable=${inv_id} ${\n}
    @{product}=    Get Product Detail    ${inv_id}
    Log to console    product_id=@{product}
    ${has_variants}=    Set Variable    @{product}[4]
    #Log to console    Wemall Common - Debug    ${has_variants}    has_variants
    Wemall Common - Debug    ${has_variants}    has_variants
    ${option_pkey}=    get_option_pkey_by_variant    ${inv_id}
    Wemall Common - Debug    ${option_pkey}    opion_pkey
    ${count_option_pkey}=    Get Length    ${option_pkey}
    Wemall Common - Debug    ${count_option_pkey}    count_option_pkey
    ${color_pkey}=    Run Keyword If    '${count_option_pkey}' == '1'    Get From List    ${option_pkey}    0
    ...    ELSE    Set Variable    None
    ${size_pkey}=    Run keyword If    '${count_option_pkey}' > '1'    Get From List    ${option_pkey}    1
    ...    ELSE    Set Variable    None
    Run Keyword If    '${count_option_pkey}' == '1' and '${has_variants}' != '0'    Click Element    //li[@class="style-types"][1]/div[@class="prd_control options"]/ul/li/a[@data-pkey="${color_pkey}"]
    Run Keyword If    '${count_option_pkey}' > '1' and '${has_variants}' != '0'    Click Element    //ul[@class="prd_price_list"]/li[@class="style-types"][2]/div[@class="prd_control options"]/ul/li/a[@data-pkey="${size_pkey}"]
    Wait Until Ajax Loading Is Not Visible

Level D - User Select Style Options From First Inventory Id
    #${inv_id}=    Get From Dictionary    ${TEST_VAR}    inv_id
    ${inv_id}=    Wemall Common - Get Value From Test Variable    inv_id_1
    Run Keyword If    '${DEBUG}' == 'True'    Log To Console    inv_id from test variable=${inv_id} ${\n}
    @{product}=    Get Product Detail    ${inv_id}
    Log to console    product_id=@{product}
    ${has_variants}=    Set Variable    @{product}[4]
    #Log to console    Wemall Common - Debug    ${has_variants}    has_variants
    Log To Console    has_variants=${has_variants}
    ${option_pkey}=    get_option_pkey_by_variant    ${inv_id}
    Log to console    ==== Option Pkey=${option_pkey} ====
    ${count_option_pkey}=    Get Length    ${option_pkey}
    Log to console    count_option_pkey=${count_option_pkey}
    ${color_pkey}=    Run Keyword If    '${count_option_pkey}' == '1'    Get From List    ${option_pkey}    0
    ...    ELSE    Set Variable    None
    ${size_pkey}=    Run keyword If    '${count_option_pkey}' > '1'    Get From List    ${option_pkey}    1
    ...    ELSE    Set Variable    None
    Run Keyword If    '${count_option_pkey}' == '1' and '${has_variants}' != '0'    Click Element    //li[@class="style-types"][1]/div[@class="prd_control options"]/ul/li/a[@data-pkey="${color_pkey}"]
    Run Keyword If    '${count_option_pkey}' > '1' and '${has_variants}' != '0'    Click Element    //ul[@class="prd_price_list"]/li[@class="style-types"][2]/div[@class="prd_control options"]/ul/li/a[@data-pkey="${size_pkey}"]
    Wait Until Ajax Loading Is Not Visible

Level D - Normal Price Is Displayed
    Wait Until Page Contains Element    ${XPATH_LEVEL_D.lbl_normal_price}    ${TIMEOUT}

Level D - Installment Section Is Displayed
    Wait Until Page Contains Element    ${XPATH_LEVEL_D.div_installment}    ${TIMEOUT}
    Element Should Be Visible    ${XPATH_LEVEL_D.div_installment}

Level D - Price Per Month Is Correctly Displayed
    ${period}=    Get Matching Xpath Count    ${XPATH_LEVEL_D.div_installment}/div[@class="product__promotion_col-1"]
    ${level_d_price}=    Get From Dictionary    ${TEST_VAR}    level_d_price
    : FOR    ${index}    IN RANGE    1    ${period} + 1
    \    ${period}=    Get Text    ${XPATH_LEVEL_D.div_installment}/div[@class="product__promotion_col-1"][${index}]/div/p/span
    \    Log to console    period=${period}
    \    ${period}=    mnp_util.py Convert To Float    ${period}
    \    ${level_d_price_per_month}=    Evaluate    ${level_d_price} / ${period}
    \    ${price_per_month}=    Get Text    ${XPATH_LEVEL_D.div_installment}/div[@class="product__promotion_col-1"][${index}]/div/div[@class="product__promotion_bank_col-5"]/ul/li[3]/span
    \    ${price_per_month}=    Replace String    ${price_per_month}    ฿    ${EMPTY}
    \    ${price_per_month}=    Replace String    ${price_per_month}    ,    ${EMPTY}
    \    ${price_per_month}=    product.Py Convert To Float    ${price_per_month}
    \    Should Be Equal As Integers    ${price_per_month}    ${level_d_price_per_month}

Level D - Open Browser Level D
    ${product_pkey}=    Get From Dictionary    ${TEST_VAR}    product_pkey
    ${product_slug}=    Get From Dictionary    ${TEST_VAR}    product_slug
    Wemall Common - Debug    ${ITM_URL}/products/${product_slug}-${product_pkey}.html
    Open Browser    ${ITM_URL}/products/${product_slug}-${product_pkey}.html    ${BROWSER}
    Maximize Browser Window

Level D - Click Sku By Pkey
    [Arguments]    ${type_option}    ${pkey}    ${price}
    Log to console    type_option=${type_option}, pkey=${pkey}    ${\n}${\n}${\n}
    Run Keyword If    '${type_option}' == 'type'    Run Keywords    Click Color From Pkey List    ${pkey}
    ...    AND    Price Should Be Equal As    ${price}
    Run Keyword If    '${type_option}' == 'type_option'    Run Keywords    Click Color From Pkey List    ${pkey}
    ...    AND    Click Size From Pkey List    ${pkey}
    ...    AND    Price Should Be Equal As    ${price}

Price Should Be Equal As
    [Arguments]    ${price}
    #Level D - Get Level D Sale Price
    Level D - Get Level D Sku Price
    ${level_d_price}=    Get From Dictionary    ${TEST_VAR}    sku_price
    Should Be Equal As Integers    ${level_d_price}    ${price}

Click Color From Pkey List
    [Arguments]    ${pkey_list}
    ${color_pkey}=    Get From List    ${pkey_list}    0
    Click Element    //ul[@class="prd_price_list"]/li[@class="style-types"][1]/div[@class="prd_control options"]/ul/li/a[@data-pkey="${color_pkey}"]
    #Log to console    ==== click color ====
    Wait Until Ajax Loading Is Not Visible

Click Size From Pkey List
    [Arguments]    ${pkey_list}
    ${size_pkey}=    Get From List    ${pkey_list}    1
    Log to console    ==== size pkey=${size_pkey} ====    ${\n}${\n}
    #Log to console    ==== click size ====
    Click Element    //ul[@class="prd_price_list"]/li[@class="style-types"][2]/div[@class="prd_control options"]/ul/li/a[@data-pkey="${size_pkey}"]
    Wait Until Ajax Loading Is Not Visible

Level D - Select All Sku And Check Price Equal As Database
    @{style_options}=    Get From Dictionary    ${TEST_VAR}    style_options
    ${length}=    Get Length    ${style_options}
    : FOR    ${index}    IN RANGE    0    ${length}
    \    ${inv_id}=    Get From List    @{style_options}[${index}]    0
    \    ${price}=    Get From List    @{style_options}[${index}]    1
    \    #\    Log to console    inv_id=${inv_id}, price=${price} ${\n}
    \    ${style_option_pkeys}=    get_option_pkey_by_variant    ${inv_id}
    \    ${length_pkey}=    Get Length    ${style_option_pkeys}
    \    Log to console    style_option_pkeys=${style_option_pkeys}
    \    Run Keyword If    '${length_pkey}' == '1'    Level D - Click Sku By Pkey    type    ${style_option_pkeys}
    \    Run Keyword If    '${length_pkey}' == '2'    Level D - Click Sku By Pkey    type_option    ${style_option_pkeys}    ${price}
    # Level D - User Click Add To Cart Button
    #    Wait Until Ajax Loading Is Not Visible
    #    Wait Until Element Is Visible    ${XPATH_LEVEL_D.btn_add_to_cart}    ${TIMEOUT}
    #    Click Element    ${XPATH_LEVEL_D.btn_add_to_cart}

Level D - Open Level D Using Invtory Id
    [Arguments]    ${inv_id}
    @{product}=    Get Product Detail    ${inv_id}
    Wemall Common - Assign Value To Test Variable    inv_id    ${inv_id}
    Wemall Common - Assign Value To Test Variable    product_pkey    @{product}[1]
    Wemall Common - Assign Value To Test Variable    product_slug    @{product}[3]
    ${product_pkey}=    Set Variable    @{product}[1]
    ${product_slug}=    Set Variable    @{product}[3]
    Level D - Open Browser Level D With Pkey And Slug And No Cache    ${product_pkey}    ${product_slug}
    Run Keyword If    '${DEBUG}' == 'True'    Log to console    TEST_VAR=${TEST_VAR}${\n}

Level D - Redirect To Level D
    ${inv_id}=    Get 1Inventory Id
    @{product}=    Get Product Detail    ${inv_id}
    Wemall Common - Assign Value To Test Variable    inv_id    ${inv_id}
    Wemall Common - Assign Value To Test Variable    product_pkey    @{product}[1]
    Wemall Common - Assign Value To Test Variable    product_slug    @{product}[3]
    ${product_pkey}=    Set Variable    @{product}[1]
    ${product_slug}=    Set Variable    @{product}[3]
    Wemall Common - Debug    ${inv_id}    inv_id
    Wemall Common - Debug    ${product_pkey}    product_pkey
    Wemall Common - Debug    ${product_slug}    product_slug
    Level D - Go To Level D With Pkey And Slug And No Cache    ${product_pkey}    ${product_slug}

Level D - Go To Level D Using Invtory Id
    [Arguments]    ${inv_id}
    @{product}=    Get Product Detail    ${inv_id}
    Wemall Common - Assign Value To Test Variable    inv_id    ${inv_id}
    Wemall Common - Assign Value To Test Variable    product_pkey    @{product}[1]
    Wemall Common - Assign Value To Test Variable    product_slug    @{product}[3]
    ${product_pkey}=    Set Variable    @{product}[1]
    ${product_slug}=    Set Variable    @{product}[3]
    Level D - Go To Level D With Pkey And Slug And No Cache    ${product_pkey}    ${product_slug}
    Run Keyword If    '${DEBUG}' == 'True'    Log to console    TEST_VAR=${TEST_VAR}${\n}

Level D - Go To Level Of First Shop and Select Item
    Level D - Open Level D Using Invtory Id    ${var.inventory_id_1}

Level D - Go To Level Of Second Shop and Select Item
    Level D - Go To Level D Using Invtory Id    ${var.inventory_id_2}

User Select Style Options Using Inventory Id
    [Arguments]    ${inv_id}
    Run Keyword If    '${DEBUG}' == 'True'    Log To Console    inv_id from test variable=${inv_id} ${\n}
    ${option_pkey}=    get_option_pkey_by_variant    ${inv_id}
    Log to console    ==== Option Pkey=${option_pkey} ====
    ${count_option_pkey}=    Get Length    ${option_pkey}
    Log to console    count_option_pkey=${count_option_pkey}
    ${color_pkey}=    Run Keyword If    '${count_option_pkey}' == '1'    Get From List    ${option_pkey}    0
    ...    ELSE    Set Variable    None
    ${size_pkey}=    Run keyword If    '${count_option_pkey}' > '1'    Get From List    ${option_pkey}    1
    ...    ELSE    Set Variable    None
    Run Keyword If    '${count_option_pkey}' == '1'    Click Element    //ul[@class="prd_price_list"]/li[@class="style-types"][1]/div[@class="prd_control options"]/ul/li/a[@data-pkey="${color_pkey}"]
    Run Keyword If    '${count_option_pkey}' > '1'    Click Element    //ul[@class="prd_price_list"]/li[@class="style-types"][2]/div[@class="prd_control options"]/ul/li/a[@data-pkey="${size_pkey}"]
    ...    AND    Wait Until Ajax Loading Is Not Visible

Level D - Open Browser Level D With Inventory Id From Test Variable
    ${inv_id}=    Wemall Common - Get Value From Test Variable    inv_id
    @{product}=    Get Product Detail    ${inv_id}
    Wemall Common - Assign Value To Test Variable    product_pkey    @{product}[1]
    Wemall Common - Assign Value To Test Variable    product_slug    @{product}[3]
    ${product_pkey}=    Set Variable    @{product}[1]
    ${product_slug}=    Set Variable    @{product}[3]
    Wemall Common - Debug    ${product_pkey}    product_pkey
    Open Browser    ${WEMALL_URL}/products/${product_slug}-${product_pkey}.html    ${BROWSER}
    ${url}=    Get Location
    Go To    ${url}?no-cache=1

Level D - Redirect To Level D With Inventory Id From Test Variable
    ${inv_id}=    Wemall Common - Get Value From Test Variable    inv_id
    log to console    TEST_VAR=${TEST_VAR}
    @{product}=    Get Product Detail    ${inv_id}
    Wemall Common - Assign Value To Test Variable    product_pkey    @{product}[1]
    Wemall Common - Assign Value To Test Variable    product_slug    @{product}[3]
    ${product_pkey}=    Set Variable    @{product}[1]
    ${product_slug}=    Set Variable    @{product}[3]
    Wemall Common - Debug    ${product_pkey}    product_pkey
    Log To Console    REDIRECT_URL=${WEMALL_URL}/products/${product_pkey}-${product_slug}.html
    Go To    ${WEMALL_URL}/products/${product_slug}-${product_pkey}.html

Level D - Level D Is Opened
    Location Should Contain    ${WEMALL_URL}/products

Level D - Merchant Header Is Not Displayed
    Element Should Not Be Visible    ${XPATH_LEVEL_D.merchant_header}
    Page Should Not Contain Element    ${XPATH_LEVEL_D.merchant_header}

Level D - Alias Merchant Header On Level D Is Displayed
    ${list_product_pkey}=    Wemall Common - Get Value From Test Variable    list_product_pkey
    Log to console    list_product_pkey=${list_product_pkey}
    ${length}=    Get Length    ${list_product_pkey}
    Log to console    length=${length}
    : FOR    ${index}    IN RANGE    0    ${length}
    \    Log to console    product_pkey_from_list=${list_product_pkey[${index}]}
    \    Level D - Go To Product Level D With No Cache    ${list_product_pkey[${index}]}
    \    Wait Until Page Contains Element    //div[contains(@class, "store-header")]    30s
    \    Page Should Contain Element    //div[contains(@class, "store-header")]

Level D - Alias Merchant Header On Level D Is Not Displayed
    ${list_product_pkey}=    Wemall Common - Get Value From Test Variable    list_product_pkey
    Log to console    list_product_pkey=${list_product_pkey}
    ${length}=    Get Length    ${list_product_pkey}
    Log to console    length=${length}
    : FOR    ${index}    IN RANGE    0    ${length}
    \    Log to console    product_pkey_from_list=${list_product_pkey[${index}]}
    \    Level D - Go To Product Level D With No Cache    ${list_product_pkey[${index}]}
    \    #\    Page Should Not Contain Element    //div[contains(@class, "store-header")]
    \    #\    Wait Until Element Is Visible    ${XPATH_LEVEL_D.merchant_header_content}    30s
    \    #\    Wait Until Page Contains Element    ${XPATH_LEVEL_D.merchant_header_content}/p    30s
    \    #\    ${header}=    Execute JavaScript    return document.getElementsByClassName("inner-store-header");
    \    # \    Should Be Equal    ${header}    <div class="inner-store-header ng-binding" ng-bind-html="header">${TEST_VAR.merchant_header_list[${index}]}</div>
    \    #\    log to console    testvar_header=${TEST_VAR.merchant_header_list[${index}]}
    \    ${merchant_header}=    Set Variable    ${TEST_VAR.merchant_header_list[${index}]}
    \    Run Keyword If    '${merchant_header}' != 'null'    Page Should Contain Merchant Header And Footer With Merchant Code    ${TEST_VAR.merchant_header_list[${index}]}
    #\    ${merchant_header}=    Replace String    ${merchant_header}    ${EMPTY}
    #\    Log To Console    merchant_header=${merchant_header}
    #\    Sleep    10s
    #\    ${header}=    Get Text    ${XPATH_LEVEL_D.merchant_header_content}
    #\    Log to console    header=${header}
    #\    Wait Until Page Contains    ${merchant_header}    5s
    #\    Wait Until Element Contains    ${XPATH_LEVEL_D.merchant_header_content}    ${merchant_header}    30s
    #\    Wait Until Page Contains Element    ${merchant_header}    10s
    #\    Page Should Contain    http://alpha-cdn.wemall-dev.com/th/Header/MTH10000_images/banner-storefront.png
    #${merchant_header}

Level D - Go To Product Level D With No Cache
    [Arguments]    ${product_pkey}=None
    Wemall Common - Debug    ${WEMALL_URL}/products/items-${product_pkey}.html?no-cache=1    Level D Url
    Go To    ${WEMALL_URL}/products/items-${product_pkey}.html
    ${url}=    Get Location
    Go To    ${url}?no-cache=1

Level D - count variant status
    ${count_style_color}=    Get Matching Xpath Count    ${style_color}
    Log To Console    count color=${count_style_color}
    [Return]    ${count_style_color}

Level D - Get style color
    [Arguments]    ${count_style_color}
    ${count_style_color}=    Set Variable    ${count_style_color}+1
    ${color_list}=    Create List
    : FOR    ${i}    IN RANGE    1    ${count_style_color}
    \    ${color_name}=    Selenium2Library.Get Element Attribute    ${style_color}[${i}]/a@title
    \    Append To List    ${color_list}    ${color_name}
    Log To Console    color list=${color_list}
    [Return]    ${color_list}

Level D - verify style type
    [Arguments]    ${color_list}    ${value_color}
    Should Be Equal    ${color_list}    ${value_color}

Get Product Price Detail From Level D
    [Arguments]    ${product_name_pkey}
    Open Browser    ${WEMALL_URL}/products/${product_name_pkey}.html?no-cache=1    ${Browser}
    ${product_normal_price}=    Get Text    ${product_normal_price_element}
    ${product_special_price}=    Get Text    ${product_special_price_element}
    ${product_discount_percent}=    Get Text    ${product_discount_percent_element}
    Return From Keyword    ${product_normal_price}    ${product_special_price}    ${product_discount_percent}

Level D - Go To Level D By 2 Pkey From Test Variable
    ${product_pkey_1}=    Wemall Common - Get Value From Test Variable    product_pkey_1
    Go To    ${WEMALL_URL}/products/item-${product_pkey_1}.html

Level D - Get Inventory Id From Test Variable
    ${inv_id}=    Wemall Common - Get Value From Test Variable    inv_id
    [Return]    ${inv_id}

Level D - Go To Level D And Choose Style Options And Add To Cart And Adjust Stock

    [Arguments]   ${inv_id}=None


    #Run Keyword If  '${inv_id}' == 'None'  Return From Keyword   Required inv_id

    ${test_var_inv_id_exist}=   Run Keyword And Return Status    Variable Should Exist  ${TEST_VAR.inv_id}
    ${w_inv_id}=    Run Keyword If  '${test_var_inv_id_exist}' == '${False}' and '${inv_id}' != 'None'   Set Variable  ${inv_id}
     ...    ELSE IF  '${test_var_inv_id_exist}' == '${False}' and '${inv_id}' == 'None'  Return From Keyword   Error
     ...    ELSE   Set Variable  ${TEST_VAR.inv_id}
     Log To Console   3====${w_inv_id}
    ${product}=   Get Product Detail   ${w_inv_id}
    Log To Console  $product=${product}
    Stock - Increase Stock By Test Variable   100  ${w_inv_id}

    # Log To Console   @{product}
    Go To    ${WEMALL_URL}/products/${product[2]}-${product[1]}
    Level D - User Select Style Options
    Level D - User Click Add To Cart Button

Level D - Back to buy product
    Wait Until ELement Is Visible    ${Close_cart_lightbox}    20s
    Click Element    ${Close_cart_lightbox}

Level D - Add Normal Product Not Has Variant To Cart
    Log To Console    ========= PRODUCT-MATCH-FREEBIE =========${PRODUCT-MATCH-FREEBIE}
    ${product}=   py_get_product_normal_not_has_variant    1   ${PRODUCT-MATCH-FREEBIE}
    ${product_pkey}=   Get From Dictionary   ${product}   product_pkey
    ${inventory_id}=   Get From Dictionary   ${product}   inventory_id
    ${product_id}=   Get From Dictionary   ${product}   product_id
    ${variant_id}=   Get From Dictionary   ${product}   variant_id

    Log To Console    ======= py_get_product_normal_not_has_variant ========
    Log To Console    ${product}
    Log To Console    ${product_pkey}
    Log To Console    ${inventory_id}

    Increase Stock    ${inventory_id}     10    Robot Increase Stock    10

    # Open Browser    ${ITM_URL}    ${BROWSER}
    Add Product to Cart Not Check Full Cart  ${product_pkey}
    [return]   ${product}

