*** Settings ***
Library           Selenium2Library
Library           String
Library           ${CURDIR}/../../../../Python_Library/product.py
#Library           ${CURDIR}/../../../../Python_Library/DatabaseData.py
Library           ${CURDIR}/../../../../Python_Library/mnp_util.py
Resource          WebElement_LevelD.robot
Resource          ${CURDIR}/../../../Common/keywords_common.robot

*** Keywords ***

Level D Mobile - Go to Level D Mobile with Product
    [Arguments]    ${Product}
    Go to    ${ITM_MOBILE_URL}/products/${Product}.html

Level D Mobile - Go to Level D Mobile with Product No Cache
    [Arguments]    ${Product}
    Go to    ${ITM_MOBILE_URL}/products/content/${Product}?no-cache=1
    Go to    ${ITM_MOBILE_URL}/en/products/content/${Product}?no-cache=1
    Go to    ${ITM_MOBILE_URL}/products/${Product}.html
    Go To Current Page No Cache Version

Open Browser ITM Mobile -levelD No Cache
    [Arguments]    ${product}
    Open Browser    ${ITM_MOBILE_URL}/products/${product}.html    ${Browser}
    ${url}=    Get Location
    Go to    ${url}?no-cache=1
    Wemall Common - Close Live Chat

Level D Mobile - Open Level D With Any Product
    [Arguments]  ${lang}=th
    ${inv_id}=        product.Get Inventory Normal
    ${product_pkey}=  product.Get Product Pkey  ${inv_id}
    Run Keyword If   '${lang}'=='th'   Open Browser
     ...             ${ITM_MOBILE_URL}/products/items-${product_pkey}.html    ${BROWSER}
     ...      ELSE   Open Browser   ${ITM_MOBILE_URL}/${lang}/products/items-${product_pkey}.html  ${BROWSER}

Open Browser ITM-levelD Mobile
    [Arguments]     ${product}
    Open Browser    ${ITM_MOBILE_URL}/products/content/${Product}    ${Browser}

Open Browser ITM-levelD Th Mobile
    [Arguments]     ${product}
    Open Browser    ${ITM_MOBILE_URL}/products/${Product}    ${Browser}

Open Browser ITM-levelD Mobile No Cache
    [Arguments]     ${product}
    Open Browser    ${ITM_MOBILE_URL}/products/content/${Product}?no-cache=1    ${Browser}
    Go to           ${ITM_MOBILE_URL}/en/products/content/${Product}?no-cache=1
    Go to           ${ITM_MOBILE_URL}/products/${Product}.html
    Go To Current Page No Cache Version

Level D Mobile - Delivery Time Should Be
    [Arguments]    ${expected_text}
    Wait Until Element Is Visible    ${level_d_mobile_delivery_time}    20
    Selenium2Library.Element Text Should Be           ${level_d_mobile_delivery_time}    ${expected_text}

Level D Mobile - Page Should Not Contain Delivery Time
    Page Should Not Contain          ${level_d_mobile_delivery_time}

Level D Mobile - Delivery Policy Title Should Be
    [Arguments]    ${expected_text}
    Wait Until Element Is Visible    ${level_d_mobile_delivery_policy_title}    20
    Selenium2Library.Element Text Should Be           ${level_d_mobile_delivery_policy_title}    ${expected_text}

Level D Mobile - Refund Policy Title Should Be
    [Arguments]    ${expected_text}
    Wait Until Element Is Visible    ${level_d_mobile_refund_policy_title}    20
    Selenium2Library.Element Text Should Be           ${level_d_mobile_refund_policy_title}    ${expected_text}

Level D Mobile - Return Policy Title Should Be
    [Arguments]    ${expected_text}
    Wait Until Element Is Visible    ${level_d_mobile_return_policy_title}    20
    Selenium2Library.Element Text Should Be           ${level_d_mobile_return_policy_title}    ${expected_text}

Level D Mobile - Delivery Policy Detail Should Be
    [Arguments]    ${expected_text}
    Wait Until Element Is Visible    ${level_d_mobile_delivery_policy_description}    20
    Selenium2Library.Element Text Should Be           ${level_d_mobile_delivery_policy_description}    ${expected_text}

Level D Mobile - Refund Policy Detail Should Be
    [Arguments]    ${expected_text}
    Wait Until Element Is Visible    ${level_d_mobile_refund_policy_description}      20
    Selenium2Library.Element Text Should Be           ${level_d_mobile_refund_policy_description}      ${expected_text}

Level D Mobile - Return Policy Detail Should Be
    [Arguments]    ${expected_text}
    Wait Until Element Is Visible    ${level_d_mobile_return_policy_description}      20
    Selenium2Library.Element Text Should Be           ${level_d_mobile_return_policy_description}      ${expected_text}

Level D Mobile - Click Delivery Policy Tab
    Wait Until Element Is Visible    ${level_d_mobile_delivery_policy_tab}    20
    ${elem}=                         Get Webelement    ${level_d_mobile_delivery_policy_tab}
    Scroll To Element                ${elem}    0    100
    Click Element                    ${level_d_mobile_delivery_policy_tab}

Level D Mobile - Click Refund Policy Tab
    Wait Until Element Is Visible    ${level_d_mobile_refund_policy_tab}    20
    ${elem}=                         Get Webelement    ${level_d_mobile_refund_policy_tab}
    Scroll To Element                ${elem}    0    100
    Click Element                    ${level_d_mobile_refund_policy_tab}

Level D Mobile - Click Return Policy Tab
    Wait Until Element Is Visible    ${level_d_mobile_return_policy_tab}    20
    ${elem}=                         Get Webelement    ${level_d_mobile_return_policy_tab}
    Scroll To Element                ${elem}    0    100
    Click Element                    ${level_d_mobile_return_policy_tab}


Level D Mobile - Open Browser And Go To Level D Mobile
    ${inv_id}=   Get From Dictionary   ${TEST_VAR}  inv_id
    ${product_pkey}=   Get From Dictionary    ${TEST_VAR}  product_pkey
    ${product_slug}=   Get From Dictionary    ${TEST_VAR}  product_slug

    Level D Mobile - Open Browser Level D Mobile With Pkey And Slug And No Cache    ${product_pkey}  ${product_slug}

Level D Mobile - Open Browser Level D Mobile With Pkey And Slug And No Cache
    [Arguments]   ${product_pkey}   ${product_slug}

    Log to console   =======
    Log to console   PRODUCT_MOBILE=${ITM_MOBILE_URL}/products/${product_slug}-${product_pkey}.html?no-cache=1
    Log to console   =======
    Open Browser   ${ITM_MOBILE_URL}/products/content/${product_pkey}?no-cache=1  ${BROWSER}
    Level D Mobile - Content Is Displayed
    Go To   ${ITM_MOBILE_URL}/products/${product_slug}-${product_pkey}.html


Level D Mobile - Get Level D Sale Price


    ${special_price_is_visible}=   Run Keyword And Return Status   Element Should Be Visible   ${XPATH_LEVEL_D_MOBILE.lbl_special_price}


    Log to console  special_price_is_visible=${special_price_is_visible}

    ${sale_price}=   Run Keyword If  '${special_price_is_visible}' == '${True}'   Get Text  ${XPATH_LEVEL_D_MOBILE.lbl_special_price}   ELSE   Get Text   ${XPATH_LEVEL_D_MOBILE.lbl_normal_price}

    Log to console  sale_price0=${sale_price}
    ${sale_price}=   Replace String   ${sale_price}  ,  ${EMPTY}
    Log to console  sale_price1=${sale_price}
    ${sale_price}=   helper.Py Convert To Float   ${sale_price}

    Log to console   sale_price2=${sale_price}

    ${dict}=   Set Variable  ${TEST_VAR}
    Set To Dictionary  ${dict}  level_d_price=${sale_price}
    Set Test Variable  ${TEST_VAR}  ${dict}

Level D Mobile - User Select Style Options
    ${inv_id}=   Get From Dictionary   ${TEST_VAR}  inv_id
    ${option_pkey}=   get_option_pkey_by_variant   ${inv_id}
    Log to console  ==== Option Pkey=${option_pkey} ====

    ${count_option_pkey}=   Get Length   ${option_pkey}
    Log to console  count_option_pkey=${count_option_pkey}
    ${color_pkey}=   Run Keyword If  '${count_option_pkey}' == '1'    Get From List  ${option_pkey}   0   ELSE   Set Variable   None
    ${size_pkey}=   Run keyword If   '${count_option_pkey}' > '1'   Get From List  ${option_pkey}   1   ELSE   Set Variable   None

    #Wait Until Page Contains Element  //div[contains(@class, "style-options")][1]/a/div[@data-style-option-pkey="${color_pkey}"]   60s


    Run Keyword If  '${count_option_pkey}' == '1'  Run Keywords   Wait Until Page Contains Element   //div[contains(@class, "style-options")][1]/a/div[@data-style-option-pkey="${color_pkey}"]
    ...  AND   Click Element   //div[contains(@class, "style-options")][1]/a/div[@data-style-option-pkey="${color_pkey}"]
    ...  AND   Log to console    ==== select color ====


    Run Keyword If  '${count_option_pkey}' > '1'  Run Keywords   Wait Until Page Contains Element    //div[contains(@class, "style-options")][1]/a/div[@data-style-option-pkey="${color_pkey}"]
    ...  AND   Click Element   //div[contains(@class, "style-options")][1]/a/div[@data-style-option-pkey="${color_pkey}"]
    ...  AND   Mobile - Wait Until Ajax Loading Is Not Visible
    ...  AND   Click Element   //div[contains(@class, "style-options")][2]/a/div[@data-style-option-pkey="${size_pkey}"]

    Mobile - Wait Until Ajax Loading Is Not Visible

Level D Mobile - Normal Price Is Displayed
    Log to console   xpath-normal-price=${XPATH_LEVEL_D_MOBILE.lbl_normal_price}
    Wait Until Page Contains Element  ${XPATH_LEVEL_D_MOBILE.lbl_normal_price}  ${TIMEOUT}

Level D Mobile - Content Is Displayed
    Wait Until Page Contains Element  ${XPATH_LEVEL_D_MOBILE.div_container}   ${TIMEOUT}
    Element Should Be Visible  ${XPATH_LEVEL_D_MOBILE.div_container}

Level D Mobile - Installment Section Is Displayed
    Wait Until Page Contains Element  ${XPATH_LEVEL_D_MOBILE.div_installment}  ${TIMEOUT}
    Element Should Be Visible  ${XPATH_LEVEL_D_MOBILE.div_installment}

Level D Mobile - Price Per Month Is Correctly Displayed

    Level D Mobile - Normal Price Is Displayed

    ${period}=   Get Matching Xpath Count   ${XPATH_LEVEL_D_MOBILE.div_installment}/div[@class="loop-promotion"]


    ${level_d_price}=   Get From Dictionary  ${TEST_VAR}  level_d_price
    :FOR  ${index}  IN RANGE  1  ${period} + 1
    \  ${period}=   Get Text  ${XPATH_LEVEL_D_MOBILE.div_installment}/div[@class="loop-promotion"][${index}]/div[@class="col-xs-12"][1]/div[contains(@class, "row pro-header")]/span[@class="discount_period"]
    \  Log to console  period=${period}
    \  ${period}=  product.py Convert To Float  ${period}
    \  ${level_d_price_per_month}=  Evaluate  ${level_d_price} / ${period}

    \  ${price_per_month}=   Get Text   ${XPATH_LEVEL_D_MOBILE.div_installment}/div[@class="loop-promotion"][${index}]/div[@class="col-xs-12"][2]/div[contains(@class, "inst_bank")]/p[2]/span[1]
    \  ${price_per_month}=   Replace String  ${price_per_month}  ฿  ${EMPTY}
    \  ${price_per_month}=   Replace String  ${price_per_month}  ,  ${EMPTY}
    \  ${price_per_month}=   product.Py Convert To Float  ${price_per_month}
    \  Should Be Equal As Integers  ${price_per_month}  ${level_d_price_per_month}

#=================================================================
Level D Mobile - Open Browser Level D
    ${product_pkey}=   Get From Dictionary   ${TEST_VAR}   product_pkey
    ${product_slug}=   Get From Dictionary   ${TEST_VAR}   product_slug
    Open Browser   ${ITM_MOBILE_URL}/products/${product_slug}-${product_pkey}.html   ${BROWSER}

Level D Mobile - Click Sku By Pkey
    [Arguments]   ${type_option}   ${pkey}  ${price}

    Log to console   type_option=${type_option}, pkey=${pkey}  ${\n}${\n}${\n}
    Run Keyword If  '${type_option}' == 'type'  Run Keywords   Click Color From Pkey List  ${pkey}
    ...   AND   Price Should Be Equal As    ${price}

    Run Keyword If  '${type_option}' == 'type_option'  Run Keywords   Click Color From Pkey List  ${pkey}
    ...   AND   Click Size From Pkey List  ${pkey}
    ...   AND   Price Should Be Equal As    ${price}

Price Should Be Equal As
    [Arguments]   ${price}
    #Level D - Get Level D Sale Price
    Level D Mobile - Get Level D Sku Price
    ${level_d_price}=   Get From Dictionary   ${TEST_VAR}   sku_price
    Should Be Equal As Integers   ${level_d_price}  ${price}

Click Color From Pkey List
    [Arguments]   ${pkey_list}
    ${color_pkey}=   Get From List   ${pkey_list}   0
    Click Element   //div[@class="product-style_types"]/div[contains(@class, "style-options") and @data-style-type-name="สี"]/a/div[@data-style-option-pkey="${color_pkey}"]
    #Log to console   ==== click color ====
    Wait Until Ajax Loading Is Not Visible

Level D Mobile - Select Product Quantity
   [Arguments]    ${quantity}
   Wait Until Element Is Enabled    //select[@name="qty"]    20
   Select From List By Value        //select[@name="qty"]    ${quantity}

Click Size From Pkey List
    [Arguments]   ${pkey_list}
    ${size_pkey}=   Get From List   ${pkey_list}   1
    Log to console   ==== size pkey=${size_pkey} ====   ${\n}${\n}
    #Log to console   ==== click size ====
    Click Element   //div[@class="product-style_types"]/div[contains(@class, "style-options") and @data-style-type-name="ขนาด"]/a/div[@data-style-option-pkey="${size_pkey}"]

    Wait Until Ajax Loading Is Not Visible

Level D Mobile - Open Browser Level D From Test Variable With No Cache
    ${product_pkey}=   Wemall Common - Get Value From Test Variable   product_pkey
    ${product_slug}=   Wemall Common - Get Value From Test Variable   product_slug

    Open Browser   ${ITM_MOBILE_URL}/products/content/${product_pkey}?no-cache=1   ${BROWSER}
    Go To   ${ITM_MOBILE_URL}/products/${product_slug}-${product_pkey}.html?no-cache=1

Level D Mobile - Get Level D Sku Price
    ${special_price_is_visible}=   Run Keyword And Return Status   Element Should Be Visible  ${XPATH_LEVEL_D_MOBILE.lbl_special_price}

    ${sale_price}=   Run Keyword If  '${special_price_is_visible}' == '${True}'   Get Text  ${XPATH_LEVEL_D_MOBILE.lbl_special_price}  ELSE   Get Text   ${XPATH_LEVEL_D_MOBILE.lbl_normal_price}
    Log to console  sale_price0=${sale_price}
    ${sale_price}=   Replace String   ${sale_price}  ,  ${EMPTY}
    Log to console  sale_price1=${sale_price}
    ${sale_price}=   helper.Py Convert To Float   ${sale_price}

    Log to console   sale_price2=${sale_price}

    ${dict}=   Set Variable  ${TEST_VAR}
    Set To Dictionary  ${dict}  sku_price=${sale_price}
    Set Test Variable  ${TEST_VAR}  ${dict}

Level D Mobile - Select All Sku And Check Price Equal As Database
    @{style_options}=   Get From Dictionary   ${TEST_VAR}   style_options
    ${length}=   Get Length   ${style_options}

    :FOR  ${index}  IN RANGE  0  ${length}
    \   ${inv_id}=   Get From List   @{style_options}[${index}]   0
    \   ${price}=   Get From List   @{style_options}[${index}]    1
    #\   Log to console   inv_id=${inv_id}, price=${price} ${\n}


    \   ${style_option_pkeys}=   get_option_pkey_by_variant   ${inv_id}
    \   ${length_pkey}=   Get Length   ${style_option_pkeys}
    \   Log to console  style_option_pkeys=${style_option_pkeys}
    \   Run Keyword If   '${length_pkey}' == '1'  Level D Mobile - Click Sku By Pkey   type   ${style_option_pkesys}
    \   Run Keyword If   '${length_pkey}' == '2'  Level D Mobile - Click Sku By Pkey   type_option   ${style_option_pkeys}  ${price}

Level D Mobile - User Click Add To Cart Button
    Wait Until Ajax Loading Is Not Visible
    Wait Until Element Is Visible       ${XPATH_LEVEL_D_MOBILE.buy_button_id}   10s
    Click Element       ${XPATH_LEVEL_D_MOBILE.buy_button_id}

Level D Mobile - Go To Level Of First Shop and Select Item
    Level D Mobile - Open Level D Using Invtory Id    ${var.inventory_id_1}

Level D Mobile - Go To Level Of Second Shop and Select Item
    Level D Mobile - Go To Level D Using Invtory Id    ${var.inventory_id_2}

Level D Mobile - Open Level D Using Invtory Id
    [Arguments]    ${inv_id}
    @{product}=   Get Product Detail   ${inv_id}

    Wemall Common - Assign Value To Test Variable   inv_id   ${inv_id}
    Wemall Common - Assign Value To Test Variable   product_pkey   @{product}[1]
    Wemall Common - Assign Value To Test Variable   product_slug   @{product}[3]

    ${product_pkey}=   Set Variable    @{product}[1]
    ${product_slug}=   Set Variable    @{product}[3]

    Level D Mobile - Open Browser Level D With Pkey And Slug And No Cache    ${product_pkey}    ${product_slug}

Level D Mobile - Go To Level D Using Invtory Id
    [Arguments]    ${inv_id}
    @{product}=   Get Product Detail   ${inv_id}

    Wemall Common - Assign Value To Test Variable   inv_id   ${inv_id}
    Wemall Common - Assign Value To Test Variable   product_pkey   @{product}[1]
    Wemall Common - Assign Value To Test Variable   product_slug   @{product}[3]

    ${product_pkey}=   Set Variable    @{product}[1]
    ${product_slug}=   Set Variable    @{product}[3]

    Level D Mobile - Go To Level D With Pkey And Slug And No Cache    ${product_pkey}    ${product_slug}

Level D Mobile - Open Browser Level D With Pkey And Slug And No Cache
    [Arguments]   ${product_pkey}   ${product_slug}

    Wemall Common - Debug    ${ITM_MOBILE_URL}/products/${product_slug}-${product_pkey}.html?no-cache=1   OPEN URL


    Open Browser   ${ITM_MOBILE_URL}/products/${product_slug}-${product_pkey}.html?no-cache=1   ${BROWSER}
    #Open Browser   ${ITM_URL}/products/${product_slug}-${product_pkey}.html  ${BROWSER}

Level D Mobile - Go To Level D With Pkey And Slug And No Cache
    [Arguments]   ${product_pkey}   ${product_slug}


    Wemall Common - Debug    ${ITM_MOBILE_URL}/products/${product_slug}-${product_pkey}.html?no-cache=1  GOTO URL

    Go To    ${ITM_MOBILE_URL}/products/${product_slug}-${product_pkey}.html

