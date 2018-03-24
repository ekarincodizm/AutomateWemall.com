*** Settings ***
Resource          ../../Keyword/Common/Keywords_Common.robot
Resource          ../../Keyword/Portal/iTrueMart/Category_page/Keywords_CategoryPage.robot
Resource          ../../Keyword/Portal/iTrueMart/Search_page/Keywords_SearchPage.robot
Resource          ../../Keyword/Portal/iTrueMart/Brand_page/Keywords_BrandPage.robot
Resource          ../../Keyword/Features/Freebie_Promotion/Create_Freebie.robot
Resource          ../../Resource/WebElement/CAMP/Camp_Freebie.robot
Resource          ../../Keyword/Portal/CAMP/CAMP_common/Keywords_CAMP_Common.robot
Resource          ../../Keyword/Portal/CAMP/CAMP_promotion/Keywords_CAMP_Promotion.robot
Resource          ../../Keyword/Features/PC1_And_PC3/PCMS.robot
Resource          ../../Keyword/Features/PC1_And_PC3/ITM.robot
Resource          ../../Keyword/Portal/iTrueMart/Cart_light_box/Keywords_CartLightBox.robot
Resource          ../../Keyword/Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot
Resource          ../../Keyword/Portal/iTrueMart/Mini Cart/Keywords_MiniCart.robot
Resource          ../../Keyword/Portal/iTrueMart/Cart_pop_up/Keywords_CartPopUp.robot
Resource          ../../Keyword/Features/Create_Order/Create_order.txt
Resource          ../../Keyword/Database/PCMS/keyword_pcms.robot

*** Test Cases ***
TC_ITMWME2E_00162 - Out Of Stock img displayed when product out of stock and disappear when product have stock in Search page
    [Tags]    ready
    ${Search_Name}    Set Variable    yantouch
    ${SKU_ID}    Set Variable    YAAAA1111111
    Update to Full stock    ${SKU_ID}
    Go to Search Page with No Cache    ${Search_Name}
    Search - Verify Out Of Stock is not displayed    ${SKU_ID}
    Update to Out of Stock    ${SKU_ID}
    Reload Page
    Search - Verify Out Of Stock is displayed    ${SKU_ID}
    [Teardown]    close browser

TC_ITMWME2E_00163 - Out Of Stock img displayed when product out of stock and disappear when product have stock in Brand page
    [Tags]    ready
    ${Brand_Name}    Set Variable    yantouch-6765006824801.html?no-cache=1
    ${Product_Name}    Set Variable    Yantouch
    ${SKU_ID}    Set Variable    YAAAA1111111
    ${Brand_Key}    Set Variable    6765006824801
    Update to Full stock    ${SKU_ID}
    Go to Brand Page with No Cache    ${Brand_Name}    ${Brand_Key}
    Brand - Verify Out Of Stock is not displayed    ${Product_Name}
    Update to Out of Stock    ${SKU_ID}
    Reload Page
    Brand - Verify Out Of Stock is displayed    ${Product_Name}
    [Teardown]    close browser

TC_ITMWME2E_00164 - Out Of Stock img displayed when product out of stock and disappear when product have stock in Category page
    [Tags]    ready
    ${category_url}    Set Variable    speakers-3316485013429.html?no-cache=1
    ${Product_Name}    Set Variable    Yantouch
    ${SKU_ID}    Set Variable    YAAAA1111111
    Update to Full stock    ${SKU_ID}
    Go to Category Page with No Cache    ${category_url}
    Category - Verify Out Of Stock is not displayed    ${Product_Name}
    Update to Out of Stock    ${SKU_ID}
    Reload Page
    Category - Verify Out Of Stock is displayed    ${Product_Name}
    [Teardown]    close browser

TC_ITMWME2E_00165 - Out Of Stock img displayed when all variance under product is out of stock and disappeared when a variance is in stock
    [Tags]    ready
    ${category_url}    Set Variable    samsung-3788272176468.html?no-cache=1&page=2
    ${Product_Name}    Set Variable    Samsung Galaxy S5 เครื่องเปล่าศูนย์ทรู แถมฟรี!!!! Powerbank ความจุ 6200 mAh (จ่ายเต็ม หรือ ผ่อนชำระ)    #Product key 2653078495585
    ${SKU_SamsungGalaxyS5_Black}    Set Variable    SAAAB1113711
    ${SKU_SamsungGalaxyS5_White}    Set Variable    SAAAB1113811
    ${SKU_SamsungGalaxyS5_Blue}    Set Variable    SAAAB1114611
    ${SKU_SamsungGalaxyS5_Gold}    Set Variable    SAAAB1114511
    Update to Full stock    ${SKU_SamsungGalaxyS5_Black}
    Update to Full stock    ${SKU_SamsungGalaxyS5_White}
    Update to Full stock    ${SKU_SamsungGalaxyS5_Blue}
    Update to Full stock    ${SKU_SamsungGalaxyS5_Gold}
    Go to Category Page with No Cache    ${category_url}
    Category - Verify Out Of Stock is not displayed    ${Product_Name}
    Update to Out of Stock    ${SKU_SamsungGalaxyS5_Black}
    Update to Out of Stock    ${SKU_SamsungGalaxyS5_White}
    Update to Out of Stock    ${SKU_SamsungGalaxyS5_Blue}
    Update to Out of Stock    ${SKU_SamsungGalaxyS5_Gold}
    Reload Page
    Category - Verify Out Of Stock is displayed    ${Product_Name}
    [Teardown]    close browser

TC_ITMWME2E_00166 - Out Of Stock img NOT displayed when at less one variance under product is in stock and appeared when all variance is out of stock
    [Tags]    ready
    ${category_url}    Set Variable    samsung-3788272176468.html?no-cache=1&page=2
    ${Product_Name}    Set Variable    Samsung Galaxy S5 เครื่องเปล่าศูนย์ทรู แถมฟรี!!!! Powerbank ความจุ 6200 mAh (จ่ายเต็ม หรือ ผ่อนชำระ)    #Product key 2653078495585
    ${SKU_SamsungGalaxyS5_Black}    Set Variable    SAAAB1113711
    ${SKU_SamsungGalaxyS5_White}    Set Variable    SAAAB1113811
    ${SKU_SamsungGalaxyS5_Blue}    Set Variable    SAAAB1114611
    ${SKU_SamsungGalaxyS5_Gold}    Set Variable    SAAAB1114511
    Update to Out of Stock    ${SKU_SamsungGalaxyS5_Black}
    Update to Out of Stock    ${SKU_SamsungGalaxyS5_White}
    Update to Out of Stock    ${SKU_SamsungGalaxyS5_Blue}
    Update to Out of Stock    ${SKU_SamsungGalaxyS5_Gold}
    Go to Category Page with No Cache    ${category_url}
    Category - Verify Out Of Stock is displayed    ${Product_Name}
    Update to Full stock    ${SKU_SamsungGalaxyS5_White}
    Reload Page
    Category - Verify Out Of Stock is not displayed    ${Product_Name}
    [Teardown]    close browser

TC_ITMWME2E_00167 - Out Of Stock img NOT displayed when some variance is over sold but other still in stock
    [Tags]    ready
    [Setup]    Run Keywords    Delete Hold stock from DB by SKU    SAAAB1113811
    ...    AND    Delete Hold stock from DB by SKU    SAAAB1114511
    ${category_url}    Set Variable    samsung-3788272176468.html?no-cache=1&page=2
    ${Product_Name}    Set Variable    Samsung Galaxy S5 เครื่องเปล่าศูนย์ทรู แถมฟรี!!!! Powerbank ความจุ 6200 mAh (จ่ายเต็ม หรือ ผ่อนชำระ)    #Product key 2653078495585
    ${SKU_SamsungGalaxyS5_Black}    Set Variable    SAAAB1113711
    ${SKU_SamsungGalaxyS5_White}    Set Variable    SAAAB1113811
    ${SKU_SamsungGalaxyS5_Blue}    Set Variable    SAAAB1114611
    ${SKU_SamsungGalaxyS5_Gold}    Set Variable    SAAAB1114511
    Update to specific stock number by SKUID    ${SKU_SamsungGalaxyS5_Black}    0
    Update to specific stock number by SKUID    ${SKU_SamsungGalaxyS5_White}    0
    Update to specific stock number by SKUID    ${SKU_SamsungGalaxyS5_Blue}    0
    Update to specific stock number by SKUID    ${SKU_SamsungGalaxyS5_Gold}    1
    Go to Category Page with No Cache    ${category_url}
    Category - Verify Out Of Stock is not displayed    ${Product_Name}
    Update to Out of Stock    ${SKU_SamsungGalaxyS5_Gold}
    Reload Page
    Category - Verify Out Of Stock is displayed    ${Product_Name}
    [Teardown]    close browser

TC_ITMWME2E_00168 - Product with freebie buy A get A and A stock is not enough for freebie will display as Out of sotck in Search page
    [Tags]    ready
    #CAMP Set Buy 1 A get 1 A
    ${epoch}=    Get current epoch time
    ${Text_CampaignName}    Set Variable    TC_ITMWME2E_00168 campaign name \ ${epoch}
    ${Text_CampaignDetail}    Set Variable    TC_ITMWME2E_00168 campaign detail ${epoch}
    ${Text_CampaignStart}    Get current date by format    %m/%d/%Y    0
    ${Text_CampaignEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_FreebieName}    Set Variable    TC_ITMWME2E_00168 freebie name ${epoch}
    ${Text_FreebieShortDesc}    Set Variable    TC_ITMWME2E_00168 Freebie shot description ${epoch}
    ${Text_FreebieDesc}    Set Variable    TC_ITMWME2E_00168 Freebie description ${epoch}
    ${Text_FreebieStart}    Get current date by format    %m/%d/%Y    0
    ${Text_FreebieEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_Freebie_CategoryType}    Set Variable    ${Variant}
    ${Text_Freebie_Identifyer}    Set Variable    YAAAA1111111
    ${Text_PeriTem}    Set Variable    1
    ${Text_FreeVariantID}    Set Variable    YAAAA1111111
    ${Text_FreeVariantQuantity}    Set Variable    2
    ${Text_RepeatTime}    Set Variable    1
    ${Text_Note}    Set Variable    Note ${epoch}
    ${img_160x80}    Set Variable    \\160x80.jpg
    ${img_220x110}    Set Variable    \\220x110.jpg
    ${img_320x160}    Set Variable    \\320x160.jpg
    Go To Camp CMS
    ${campaign_id}    Create Campaign    ${Text_CampaignName}    ${Text_CampaignDetail}    ${Text_CampaignStart}    ${Text_CampaignEnd}
    Keywords_CAMP_Promotion.Create Freebie Promotion    ${Text_FreebieName}    ${Text_FreebieShortDesc}    ${Text_FreebieDesc}    ${Text_FreebieStart}    ${Text_FreebieEnd}    ${Text_Freebie_CategoryType}
    ...    ${Text_Freebie_Identifyer}    ${Text_PeriTem}    ${Text_FreeVariantID}    ${Text_FreeVariantQuantity}    ${Text_RepeatTime}    ${Text_Note}
    ...    ${img_160x80}    ${img_220x110}    ${img_320x160}
    Click build button
    #ITM Update stock to 1 and Search product and verify product is out of stock
    ${Search_Name}    Set Variable    yantouch
    ${SKU_ID}    Set Variable    ${Text_Freebie_Identifyer}
    Update to specific stock number by SKUID    ${SKU_ID}    2
    Close Browser
    Go to Search Page with No Cache    ${Search_Name}
    Comment    Go To    http://www.itruemart-dev.com/search2?q=${Search_Name}&per_page=60&page=1%3Fno-cache%3D1%3Fno-cache%3D1
    Comment    Go to Search Page with No Cache    ${Search_Name}
    Search - Verify Out Of Stock is displayed    ${SKU_ID}
    #ITM Search product and verify product is out of stock
    Update to Full stock    ${SKU_ID}
    Reload Page
    Search - Wait until product image is visible    //cdn-search.itruemart-dev.com/pcms/uploads/14-09-29/315b716cfeb157571e6dd17dc96ae589_l.jpg
    Search - Verify Out Of Stock is not displayed    ${SKU_ID}
    [Teardown]    Run Keywords    close browser
    ...    AND    Delete Campaign    ${campaign_id}

TC_ITMWME2E_00169 - Product with freebie buy A get A and A stock is out of stock for freebie will display as Out of sotck in Brand page
    [Tags]    ready
    [Setup]    Delete Hold stock from DB by SKU    HTAAA1113111
    #CAMP Set Buy 1 A get 1 A
    ${epoch}=    Get current epoch time
    ${Text_CampaignName}    Set Variable    TC_ITMWME2E_00169 ${epoch}
    ${Text_CampaignDetail}    Set Variable    TC_ITMWME2E_00169 Campaign detail ${epoch}
    ${Text_CampaignStart}    Get current date by format    %m/%d/%Y    0
    ${Text_CampaignEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_FreebieName}    Set Variable    TC_ITMWME2E_00169 ${epoch}
    ${Text_FreebieShortDesc}    Set Variable    TC_ITMWME2E_00169 Freebie shot description ${epoch}
    ${Text_FreebieDesc}    Set Variable    TC_ITMWME2E_00169 Freebie description ${epoch}
    ${Text_FreebieStart}    Get current date by format    %m/%d/%Y    0
    ${Text_FreebieEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_Freebie_CategoryType}    Set Variable    ${Variant}
    ${Text_Freebie_Identifyer}    Set Variable    HTAAA1113111
    ${Text_PeriTem}    Set Variable    1
    ${Text_FreeVariantID}    Set Variable    HTAAA1113111
    ${Text_FreeVariantQuantity}    Set Variable    1
    ${Text_RepeatTime}    Set Variable    1
    ${Text_Note}    Set Variable    Note ${epoch}
    ${img_160x80}    Set Variable    \\160x80.jpg
    ${img_220x110}    Set Variable    \\220x110.jpg
    ${img_320x160}    Set Variable    \\320x160.jpg
    ${Brand_Key}    Set Variable    6765006824801
    Go To Camp CMS
    ${campaign_id}    Create Campaign    ${Text_CampaignName}    ${Text_CampaignDetail}    ${Text_CampaignStart}    ${Text_CampaignEnd}
    Keywords_CAMP_Promotion.Create Freebie Promotion    ${Text_FreebieName}    ${Text_FreebieShortDesc}    ${Text_FreebieDesc}    ${Text_FreebieStart}    ${Text_FreebieEnd}    ${Text_Freebie_CategoryType}
    ...    ${Text_Freebie_Identifyer}    ${Text_PeriTem}    ${Text_FreeVariantID}    ${Text_FreeVariantQuantity}    ${Text_RepeatTime}    ${Text_Note}
    ...    ${img_160x80}    ${img_220x110}    ${img_320x160}
    Click build button
    #ITM Update stock to 1 and Search product and verify product is out of stock
    ${Brand_Name}    Set Variable    htc-6751102460926.html?no-cache=1
    ${Product_key}    Set Variable    2735724871530
    ${SKU_ID1}    Set Variable    ${Text_Freebie_Identifyer}
    ${SKU_ID2}    Set Variable    HTAAA1113211
    Update to specific stock number by SKUID    ${SKU_ID1}    0
    Update to specific stock number by SKUID    ${SKU_ID2}    0
    Close Browser
    Go to Brand Page with No Cache    ${Brand_Name}    ${Brand_Key}
    Brand - Verify Out of stock is displayed by Product key    ${Product_key}
    #ITM Search product and verify product is out of stock
    Update to specific stock number by SKUID    ${SKU_ID1}    2
    Reload Page
    Brand - Verify Out of stock is NOT displayed by Product key    ${Product_key}
    [Teardown]    Run Keywords    close browser
    ...    AND    Delete Campaign    ${campaign_id}

TC_ITMWME2E_00170 - Product with freebie buy A get B and B stock is not enough for freebie will display as Out of sotck in Category page
    [Tags]    ready
    [Setup]    Run Keywords    Delete Hold stock from DB by SKU    SOAAA1113111
    ...    AND    Delete Hold stock from DB by SKU    SOAAA1113311
    #CAMP Set Buy 1 A get 1 A
    ${epoch}=    Get current epoch time
    ${Text_CampaignName}    Set Variable    oos_${epoch}
    ${Text_CampaignDetail}    Set Variable    TC_ITMWME2E_00170 Campaign detail ${epoch}
    ${Text_CampaignStart}    Get current date by format    %m/%d/%Y    0
    ${Text_CampaignEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_FreebieName}    Set Variable    e2e_${epoch}
    ${Text_FreebieShortDesc}    Set Variable    Freebie shot description ${epoch}
    ${Text_FreebieDesc}    Set Variable    Freebie description ${epoch}
    ${Text_FreebieStart}    Get current date by format    %m/%d/%Y    0
    ${Text_FreebieEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_Freebie_CategoryType}    Set Variable    ${Variant}
    ${Text_Freebie_Identifyer}    Set Variable    SOAAA1113111    #Sony Xperia Z3 LTE เครื่องเปล่าศูนย์โซนี่ประเทศไทย (ผ่อนชำระ) (ดำ)
    ${Text_PeriTem}    Set Variable    1
    ${Text_FreeVariantID}    Set Variable    SOAAA1113311    #Sony Xperia Z3 LTE เครื่องเปล่าศูนย์โซนี่ประเทศไทย (ผ่อนชำระ) (ขาว)
    ${Text_FreeVariantQuantity}    Set Variable    2
    ${Text_RepeatTime}    Set Variable    1
    ${Text_Note}    Set Variable    Note ${epoch}
    ${img_160x80}    Set Variable    \\160x80.jpg
    ${img_220x110}    Set Variable    \\220x110.jpg
    ${img_320x160}    Set Variable    \\320x160.jpg
    Go To Camp CMS
    ${campaign_id}    Create Campaign    ${Text_CampaignName}    ${Text_CampaignDetail}    ${Text_CampaignStart}    ${Text_CampaignEnd}
    Keywords_CAMP_Promotion.Create Freebie Promotion    ${Text_FreebieName}    ${Text_FreebieShortDesc}    ${Text_FreebieDesc}    ${Text_FreebieStart}    ${Text_FreebieEnd}    ${Text_Freebie_CategoryType}
    ...    ${Text_Freebie_Identifyer}    ${Text_PeriTem}    ${Text_FreeVariantID}    ${Text_FreeVariantQuantity}    ${Text_RepeatTime}    ${Text_Note}
    ...    ${img_160x80}    ${img_220x110}    ${img_320x160}
    Click build button
    #ITM Update stock to 1 and Search product and verify product is out of stock
    ${product_key}    Set Variable    2306181563718    #Sony Xperia Z3 LTE เครื่องเปล่าศูนย์โซนี่ประเทศไทย (ผ่อนชำระ) /products/sony-xperia-z3-lte--2306181563718.html
    ${category_url}    Set Variable    smartphones-3153226347149.html?page=2&no-cache=1
    ${SKU_ID}    Set Variable    ${Text_Freebie_Identifyer}
    Update to specific stock number by SKUID    ${SKU_ID}    0
    Update to specific stock number by SKUID    ${Text_FreeVariantID}    1
    Close Browser
    Go to Category Page with No Cache    ${category_url}
    Category - Verify Outof Stock is NOT displayed by Product key    ${product_key}
    #ITM Search product and verify product is out of stock
    Update to specific stock number by SKUID    ${SKU_ID}    99999
    Update to specific stock number by SKUID    ${Text_FreeVariantID}    0
    Reload Page
    Category - Verify Out of Stock is displayed by Product key    ${product_key}
    [Teardown]    Run Keywords    close browser
    ...    AND    Delete Campaign    ${campaign_id}

TC_ITMWME2E_00171 - Product with freebie buy A get A and A stock is equal freebie will NOT display as Out of sotck in Category page
    [Tags]    ready
    [Setup]    Run Keywords    Delete Hold stock from DB by SKU    SAAAB1114511
    ...    AND    Delete Hold stock from DB by SKU    SAAAB1113811
    #CAMP Set Buy 1 A get 1 A
    ${epoch}=    Get current epoch time
    ${Text_CampaignName}    Set Variable    TC_ITMWME2E_00171 Campaign name01 ${epoch}
    ${Text_CampaignDetail}    Set Variable    Campaign detail Product with freebie buy A get A and A stock is equal freebie will NOT display as Out of sotck in Category page ${epoch}
    ${Text_CampaignStart}    Get current date by format    %m/%d/%Y    0
    ${Text_CampaignEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_FreebieName}    Set Variable    TC_ITMWME2E_00171 Freebie name ${epoch}
    ${Text_FreebieShortDesc}    Set Variable    Freebie shot description ${epoch}
    ${Text_FreebieDesc}    Set Variable    Freebie description Product with freebie buy A get A and A stock is equal freebie will NOT display as Out of sotck in Category page ${epoch}
    ${Text_FreebieStart}    Get current date by format    %m/%d/%Y    0
    ${Text_FreebieEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_Freebie_CategoryType}    Set Variable    ${Variant}
    ${Text_Freebie_Identifyer}    Set Variable    SAAAB1114511
    ${Text_PeriTem}    Set Variable    1
    ${Text_FreeVariantID}    Set Variable    SAAAB1114511
    ${Text_FreeVariantQuantity}    Set Variable    2
    ${Text_RepeatTime}    Set Variable    1
    ${Text_Note}    Set Variable    Note ${epoch}
    ${img_160x80}    Set Variable    \\160x80.jpg
    ${img_220x110}    Set Variable    \\220x110.jpg
    ${img_320x160}    Set Variable    \\320x160.jpg
    Go To Camp CMS
    ${campaign_id}    Create Campaign    ${Text_CampaignName}    ${Text_CampaignDetail}    ${Text_CampaignStart}    ${Text_CampaignEnd}
    Keywords_CAMP_Promotion.Create Freebie Promotion    ${Text_FreebieName}    ${Text_FreebieShortDesc}    ${Text_FreebieDesc}    ${Text_FreebieStart}    ${Text_FreebieEnd}    ${Text_Freebie_CategoryType}
    ...    ${Text_Freebie_Identifyer}    ${Text_PeriTem}    ${Text_FreeVariantID}    ${Text_FreeVariantQuantity}    ${Text_RepeatTime}    ${Text_Note}
    ...    ${img_160x80}    ${img_220x110}    ${img_320x160}
    Click build button
    #ITM Update stock to 1 and Search product and verify product is out of stock
    ${product_key}    Set Variable    2653078495585
    ${category_url}    Set Variable    samsung-3788272176468.html?no-cache=1&page=2
    ${SKU_ID1}    Set Variable    ${Text_Freebie_Identifyer}
    ${SKU_ID2}    Set Variable    SAAAB1113811
    Update to specific stock number by SKUID    ${SKU_ID1}    3
    Update to specific stock number by SKUID    ${SKU_ID2}    0
    Close Browser
    Go to Category Page with No Cache    ${category_url}
    Category - Verify Outof Stock is NOT displayed by Product key    ${product_key}
    #Update Freebie stock to not enough and verify OOS is display
    Update to specific stock number by SKUID    ${SKU_ID1}    2
    Reload Page
    Category - Verify Outof Stock is displayed by Product key    ${product_key}
    #Update other variance in same product \ to have stock and \ verify OOS is not display
    Update to specific stock number by SKUID    ${SKU_ID2}    2
    Reload Page
    Category - Verify Outof Stock is NOT displayed by Product key    ${product_key}
    [Teardown]    Run Keywords    close browser
    ...    AND    Delete Campaign    ${campaign_id}

TC_ITMWME2E_00172 - Product with freebie buy A get B and B stock is out of stock for freebie will display as Out of sotck in Search page
    [Tags]    ready
    #CAMP Set Buy 1 A get 1 A
    ${epoch}=    Get current epoch time
    ${Text_CampaignName}    Set Variable    oos_${epoch}
    ${Text_CampaignDetail}    Set Variable    TC_ITMWME2E_00172 Campaign detail ${epoch}
    ${Text_CampaignStart}    Get current date by format    %m/%d/%Y    0
    ${Text_CampaignEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_FreebieName}    Set Variable    e2e_${epoch}
    ${Text_FreebieShortDesc}    Set Variable    Freebie shot description ${epoch}
    ${Text_FreebieDesc}    Set Variable    Freebie description ${epoch}
    ${Text_FreebieStart}    Get current date by format    %m/%d/%Y    0
    ${Text_FreebieEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_Freebie_CategoryType}    Set Variable    ${Variant}
    ${Text_Freebie_Identifyer}    Set Variable    YAAAA1111111
    ${Text_PeriTem}    Set Variable    1
    ${Text_FreeVariantID}    Set Variable    YAAAA1111111
    ${Text_FreeVariantQuantity}    Set Variable    2
    ${Text_RepeatTime}    Set Variable    1
    ${Text_Note}    Set Variable    Note ${epoch}
    ${img_160x80}    Set Variable    \\160x80.jpg
    ${img_220x110}    Set Variable    \\220x110.jpg
    ${img_320x160}    Set Variable    \\320x160.jpg
    Go To Camp CMS
    ${campaign_id}    Create Campaign    ${Text_CampaignName}    ${Text_CampaignDetail}    ${Text_CampaignStart}    ${Text_CampaignEnd}
    Keywords_CAMP_Promotion.Create Freebie Promotion    ${Text_FreebieName}    ${Text_FreebieShortDesc}    ${Text_FreebieDesc}    ${Text_FreebieStart}    ${Text_FreebieEnd}    ${Text_Freebie_CategoryType}
    ...    ${Text_Freebie_Identifyer}    ${Text_PeriTem}    ${Text_FreeVariantID}    ${Text_FreeVariantQuantity}    ${Text_RepeatTime}    ${Text_Note}
    ...    ${img_160x80}    ${img_220x110}    ${img_320x160}
    Click build button
    #ITM Update stock to 1 and Search product and verify product is out of stock
    ${Search_Name}    Set Variable    yantouch
    ${SKU_ID}    Set Variable    ${Text_Freebie_Identifyer}
    Update to specific stock number by SKUID    ${SKU_ID}    2
    Close Browser
    Go to Search Page with No Cache    ${Search_Name}
    Comment    Go To    http://www.itruemart-dev.com/search2?q=${Search_Name}&per_page=60&page=1%3Fno-cache%3D1%3Fno-cache%3D1
    Comment    Go to Search Page with No Cache    ${Search_Name}
    Search - Verify Out Of Stock is displayed    ${SKU_ID}
    #ITM Search product and verify product is out of stock
    Update to Full stock    ${SKU_ID}
    Reload Page
    Search - Wait until product image is visible    //cdn-search.itruemart-dev.com/pcms/uploads/14-09-29/315b716cfeb157571e6dd17dc96ae589_l.jpg
    Search - Verify Out Of Stock is not displayed    ${SKU_ID}
    [Teardown]    Run Keywords    close browser
    ...    AND    Delete Campaign    ${campaign_id}

TC_ITMWME2E_00173 - Product with freebie buy A get B and B stock is equal freebie will NOT display as Out of sotck in Brand page
    [Tags]    ready
    [Setup]    Run Keywords    Delete Hold stock from DB by SKU    HTAAA1111611
    ...    AND    Delete Hold stock from DB by SKU    HTAAA1111711
    ...    AND    Delete Hold stock from DB by SKU    XIAAA1111111
    #CAMP Set Buy 1 A get 1 A
    ${epoch}=    Get current epoch time
    ${Text_CampaignName}    Set Variable    TC_ITMWME2E_00173 Campaign name02 ${epoch}
    ${Text_CampaignDetail}    Set Variable    Campaign detail Product with freebie buy A get B and B stock is equal freebie will NOT display as Out of sotck in Brand page \ ${epoch}
    ${Text_CampaignStart}    Get current date by format    %m/%d/%Y    0
    ${Text_CampaignEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_FreebieName}    Set Variable    OOS Freebie name 02${epoch}
    ${Text_FreebieShortDesc}    Set Variable    Freebie Promotion name \ ${epoch}
    ${Text_FreebieDesc}    Set Variable    Freebie description Product with freebie buy A get B and B stock is equal freebie will NOT display as Out of sotck in Brand page \ ${epoch}
    ${Text_FreebieStart}    Get current date by format    %m/%d/%Y    0
    ${Text_FreebieEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_Freebie_CategoryType}    Set Variable    ${Variant}
    ${Text_Freebie_Identifyer}    Set Variable    HTAAA1111611
    ${Text_PeriTem}    Set Variable    1
    ${Text_FreeVariantID}    Set Variable    XIAAA1111111
    ${Text_FreeVariantQuantity}    Set Variable    2
    ${Text_RepeatTime}    Set Variable    1
    ${Text_Note}    Set Variable    Note Product with freebie buy A get B and B stock is equal freebie will NOT display as Out of sotck in Brand page \ ${epoch}
    ${img_160x80}    Set Variable    \\160x80.jpg
    ${img_220x110}    Set Variable    \\220x110.jpg
    ${img_320x160}    Set Variable    \\320x160.jpg
    ${Brand_Key}    Set Variable    6765006824801
    Go To Camp CMS
    ${campaign_id}    Create Campaign    ${Text_CampaignName}    ${Text_CampaignDetail}    ${Text_CampaignStart}    ${Text_CampaignEnd}
    Keywords_CAMP_Promotion.Create Freebie Promotion    ${Text_FreebieName}    ${Text_FreebieShortDesc}    ${Text_FreebieDesc}    ${Text_FreebieStart}    ${Text_FreebieEnd}    ${Text_Freebie_CategoryType}
    ...    ${Text_Freebie_Identifyer}    ${Text_PeriTem}    ${Text_FreeVariantID}    ${Text_FreeVariantQuantity}    ${Text_RepeatTime}    ${Text_Note}
    ...    ${img_160x80}    ${img_220x110}    ${img_320x160}
    Click build button
    #ITM Update stock to 1 and Search product and verify product is out of stock
    ${Brand_Name}    Set Variable    htc-6751102460926.html?no-cache=1
    ${Product_key}    Set Variable    2404915516669
    ${SKU_ID1}    Set Variable    ${Text_Freebie_Identifyer}
    ${SKU_ID2}    Set Variable    HTAAA1111711
    ${SKU_Freebie}    Set Variable    ${Text_FreeVariantID}
    Update to specific stock number by SKUID    ${SKU_ID1}    1
    Update to specific stock number by SKUID    ${SKU_ID2}    0
    Update to specific stock number by SKUID    ${SKU_Freebie}    1
    Close Browser
    Go to Brand Page with No Cache    ${Brand_Name}    ${Brand_Key}
    Brand - Verify Out of stock is displayed by Product key    ${Product_key}
    #--------
    Update to specific stock number by SKUID    ${SKU_Freebie}    2
    Reload Page
    Brand - Verify Out of stock is NOT displayed by Product key    ${Product_key}
    #--------
    Update to specific stock number by SKUID    ${SKU_ID2}    1
    Reload Page
    Brand - Verify Out of stock is NOT displayed by Product key    ${Product_key}
    [Teardown]    Run Keywords    close browser
    ...    AND    Delete Campaign    ${campaign_id}
    ...    AND    Update to Full stock    ${SKU_ID2}

TC_ITMWME2E_00181 - Out of stock img is displayed when product out of stock from Credit card hold
    [Tags]    ready
    [Setup]    Run Keywords    Delete Hold stock from DB by SKU    SAAAB1113811
    ...    AND    Delete Hold stock from DB by SKU    SAAAB1114511
    ${epoch}=    Get current epoch time
    ${Text_CampaignName}    Set Variable    oos_${epoch}
    ${Text_CampaignDetail}    Set Variable    TC_ITMWME2E_00181 Campaign detail ${epoch}
    ${Text_CampaignStart}    Get current date by format    %m/%d/%Y    0
    ${Text_CampaignEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_FreebieName}    Set Variable    e2e_${epoch}
    ${Text_FreebieShortDesc}    Set Variable    Freebie shot description ${epoch}
    ${Text_FreebieDesc}    Set Variable    Freebie description ${epoch}
    ${Text_FreebieStart}    Get current date by format    %m/%d/%Y    0
    ${Text_FreebieEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_Freebie_CategoryType}    Set Variable    ${Variant}
    ${Text_Freebie_Identifyer}    Set Variable    SAAAB1113811
    ${Text_PeriTem}    Set Variable    1
    ${Text_FreeVariantID}    Set Variable    SAAAB1114511
    ${Text_FreeVariantQuantity}    Set Variable    2
    ${Text_RepeatTime}    Set Variable    5
    ${Text_Note}    Set Variable    Note ${epoch}
    ${img_160x80}    Set Variable    \\160x80.jpg
    ${img_220x110}    Set Variable    \\220x110.jpg
    ${img_320x160}    Set Variable    \\320x160.jpg
    ${Text_Email}    Set Variable    e2e@gmail.com
    ${Text_Name}    Set Variable    e2e_test
    ${Text_Phone}    Set Variable    0911111111
    ${Text_Address}    Set Variable    test e2e
    ${Text_Code}    Set Variable    Dummy
    ${Text_CWName}    Set Variable    test
    ${Text_CWCardNo}    Set Variable    4111111111111111
    ${Text_CWCCV}    Set Variable    123
    ${Text_Code}    Set Variable    111
    ${product_key}    Set Variable    2653078495585
    ${category_url}    Set Variable    samsung-3788272176468.html?no-cache=1&page=2
    ${SKU_ID}    Set Variable    ${Text_Freebie_Identifyer}
    #Update stock to equal amount need to create order
    Update to specific stock number by SKUID    ${Text_FreeVariantID}    2
    Update to specific stock number by SKUID    ${Text_Freebie_Identifyer}    2
    # Create Freebie
    Go To Camp CMS
    ${campaign_id}    Create Campaign    ${Text_CampaignName}    ${Text_CampaignDetail}    ${Text_CampaignStart}    ${Text_CampaignEnd}
    Keywords_CAMP_Promotion.Create Freebie Promotion    ${Text_FreebieName}    ${Text_FreebieShortDesc}    ${Text_FreebieDesc}    ${Text_FreebieStart}    ${Text_FreebieEnd}    ${Text_Freebie_CategoryType}
    ...    ${Text_Freebie_Identifyer}    ${Text_PeriTem}    ${Text_FreeVariantID}    ${Text_FreeVariantQuantity}    ${Text_RepeatTime}    ${Text_Note}
    ...    ${img_160x80}    ${img_220x110}    ${img_320x160}
    Click build button
    #Buy main variance and have freebie out of stock
    ${order_id}=    Buy Product with Freebie and assert Freebie information is correcylt displayed in Checkout process with COD payment    http://www.itruemart-dev.com/products/samsung-galaxy-s5-16gb-2653078495585.html    1    Samsung Galaxy S5 เครื่องเปล่าศูนย์ทรู แถมฟรี!!!! Powerbank ความจุ 6200 mAh (จ่ายเต็ม หรือ ผ่อนชำระ) (ทองแชมเปญจน์)    18,900.00    2
    ...    3    ${Text_FreebieShortDesc}    ${Text_Email}    ${Text_Name}    ${Text_Phone}    ${Text_Address}
    Close Browser
    #Verify Category page display out of stock image
    Go to Category Page with No Cache    ${category_url}
    Category - Verify Out of Stock is displayed by Product key    ${product_key}
    [Teardown]    Run Keywords    close browser
    ...    AND    Delete Campaign    ${campaign_id}
    ...    AND    Delete Hold stock from DB by Order ID    ${order_id}

TC_ITMWME2E_00174 - Out of stock img is displayed when product out of stock from COD hold
    [Tags]    ready
    [Setup]    Run Keywords    Delete Hold stock from DB by SKU    SAAAB1113811
    ...    AND    Delete Hold stock from DB by SKU    SAAAB1114511
    ${epoch}=    Get current epoch time
    ${Text_CampaignName}    Set Variable    oos_${epoch}
    ${Text_CampaignDetail}    Set Variable    TC_ITMWME2E_00174 Campaign detail ${epoch}
    ${Text_CampaignStart}    Get current date by format    %m/%d/%Y    0
    ${Text_CampaignEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_FreebieName}    Set Variable    e2e_${epoch}
    ${Text_FreebieShortDesc}    Set Variable    Freebie shot description ${epoch}
    ${Text_FreebieDesc}    Set Variable    Freebie description ${epoch}
    ${Text_FreebieStart}    Get current date by format    %m/%d/%Y    0
    ${Text_FreebieEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_Freebie_CategoryType}    Set Variable    ${Variant}
    ${Text_Freebie_Identifyer}    Set Variable    SAAAB1113811
    ${Text_PeriTem}    Set Variable    1
    ${Text_FreeVariantID}    Set Variable    SAAAB1114511
    ${Text_FreeVariantQuantity}    Set Variable    2
    ${Text_RepeatTime}    Set Variable    5
    ${Text_Note}    Set Variable    Note ${epoch}
    ${img_160x80}    Set Variable    \\160x80.jpg
    ${img_220x110}    Set Variable    \\220x110.jpg
    ${img_320x160}    Set Variable    \\320x160.jpg
    ${Text_Email}    Set Variable    e2e@gmail.com
    ${Text_Name}    Set Variable    e2e_test
    ${Text_Phone}    Set Variable    0911111111
    ${Text_Address}    Set Variable    test e2e
    ${Text_Code}    Set Variable    Dummy
    ${product_key}    Set Variable    2653078495585
    ${category_url}    Set Variable    samsung-3788272176468.html?no-cache=1&page=2
    #Update stock to equal amount need to create order
    Update to specific stock number by SKUID    ${Text_FreeVariantID}    2
    Update to specific stock number by SKUID    ${Text_Freebie_Identifyer}    2
    # Create Freebie
    Go To Camp CMS
    ${campaign_id}    Create Campaign    ${Text_CampaignName}    ${Text_CampaignDetail}    ${Text_CampaignStart}    ${Text_CampaignEnd}
    Keywords_CAMP_Promotion.Create Freebie Promotion    ${Text_FreebieName}    ${Text_FreebieShortDesc}    ${Text_FreebieDesc}    ${Text_FreebieStart}    ${Text_FreebieEnd}    ${Text_Freebie_CategoryType}
    ...    ${Text_Freebie_Identifyer}    ${Text_PeriTem}    ${Text_FreeVariantID}    ${Text_FreeVariantQuantity}    ${Text_RepeatTime}    ${Text_Note}
    ...    ${img_160x80}    ${img_220x110}    ${img_320x160}
    Click build button
    #Buy main variance and have freebie out of stock
    ${order_id}=    Buy Product with Freebie and assert Freebie information is correcylt displayed in Checkout process with COD payment    http://www.itruemart-dev.com/products/samsung-galaxy-s5-16gb-2653078495585.html    1    Samsung Galaxy S5 เครื่องเปล่าศูนย์ทรู แถมฟรี!!!! Powerbank ความจุ 6200 mAh (จ่ายเต็ม หรือ ผ่อนชำระ) (ทองแชมเปญจน์)    18,900.00    2
    ...    3    ${Text_FreebieShortDesc}    ${Text_Email}    ${Text_Name}    ${Text_Phone}    ${Text_Address}
    Close Browser
    #Verify Category page display out of stock image
    Go to Category Page with No Cache    ${category_url}
    Category - Verify Out of Stock is displayed by Product key    ${product_key}
    [Teardown]    Run Keywords    close browser
    ...    AND    Delete Campaign    ${campaign_id}
    ...    AND    Delete Hold stock from DB by Order ID    ${order_id}

TC_ITMWME2E_00175 - Out of stock img is displayed when product out of stock from COD hold same Product multi variance
    [Tags]
    [Setup]    Run Keywords    Delete Hold stock from DB by SKU    SAAAB1113811
    ...    AND    Delete Hold stock from DB by SKU    SAAAB1114511
    ${epoch}=    Get current epoch time
    ${Text_CampaignName}    Set Variable    oos_${epoch}
    ${Text_CampaignDetail}    Set Variable    TC_ITMWME2E_00175 Campaign detail ${epoch}
    ${Text_CampaignStart}    Get current date by format    %m/%d/%Y    0
    ${Text_CampaignEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_FreebieName}    Set Variable    e2e_${epoch}
    ${Text_FreebieShortDesc}    Set Variable    Freebie shot description ${epoch}
    ${Text_FreebieDesc}    Set Variable    Freebie description ${epoch}
    ${Text_FreebieStart}    Get current date by format    %m/%d/%Y    0
    ${Text_FreebieEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_Freebie_CategoryType}    Set Variable    ${Variant}
    ${Text_Freebie_Identifyer}    Set Variable    SAAAB1113811
    ${Text_PeriTem}    Set Variable    1
    ${Text_FreeVariantID}    Set Variable    SAAAB1114511
    ${Text_FreeVariantQuantity}    Set Variable    2
    ${Text_RepeatTime}    Set Variable    5
    ${Text_Note}    Set Variable    Note ${epoch}
    ${img_160x80}    Set Variable    \\160x80.jpg
    ${img_220x110}    Set Variable    \\220x110.jpg
    ${img_320x160}    Set Variable    \\320x160.jpg
    ${Text_Email}    Set Variable    e2e@gmail.com
    ${Text_Name}    Set Variable    e2e_test
    ${Text_Phone}    Set Variable    0911111111
    ${Text_Address}    Set Variable    test e2e
    ${Text_Code}    Set Variable    Dummy
    ${product_key}    Set Variable    2653078495585
    ${category_url}    Set Variable    samsung-3788272176468.html?no-cache=1&page=2
    #Update stock to equal amount need to create order
    Update to specific stock number by SKUID    ${Text_FreeVariantID}    2
    Update to specific stock number by SKUID    ${Text_Freebie_Identifyer}    2
    # Create Freebie
    Go To Camp CMS
    ${campaign_id}    Create Campaign    ${Text_CampaignName}    ${Text_CampaignDetail}    ${Text_CampaignStart}    ${Text_CampaignEnd}
    Keywords_CAMP_Promotion.Create Freebie Promotion    ${Text_FreebieName}    ${Text_FreebieShortDesc}    ${Text_FreebieDesc}    ${Text_FreebieStart}    ${Text_FreebieEnd}    ${Text_Freebie_CategoryType}
    ...    ${Text_Freebie_Identifyer}    ${Text_PeriTem}    ${Text_FreeVariantID}    ${Text_FreeVariantQuantity}    ${Text_RepeatTime}    ${Text_Note}
    ...    ${img_160x80}    ${img_220x110}    ${img_320x160}
    Click build button
    #Buy main variance and have freebie out of stock
    ${order_id}=    Buy Product with Freebie and assert Freebie information is correcylt displayed in Checkout process with COD payment    http://www.itruemart-dev.com/products/samsung-galaxy-s5-16gb-2653078495585.html    1    Samsung Galaxy S5 เครื่องเปล่าศูนย์ทรู แถมฟรี!!!! Powerbank ความจุ 6200 mAh (จ่ายเต็ม หรือ ผ่อนชำระ) (ทองแชมเปญจน์)    18,900.00    2
    ...    3    ${Text_FreebieShortDesc}    ${Text_Email}    ${Text_Name}    ${Text_Phone}    ${Text_Address}
    Close Browser
    #Verify Category page display out of stock image
    Go to Category Page with No Cache    ${category_url}
    Category - Verify Out of Stock is displayed by Product key    ${product_key}
    [Teardown]    Run Keywords    close browser
    ...    AND    Delete Campaign    ${campaign_id}
    ...    AND    Delete Hold stock from DB by Order ID    ${order_id}

TC_ITMWME2E_00176 - Out of stock img is displayed when product out of stock from Installment hold
    [Tags]    ready
    [Setup]    Run Keywords    Delete Hold stock from DB by SKU    SAAAB1113811
    ...    AND    Delete Hold stock from DB by SKU    SAAAB1114511
    ${epoch}=    Get current epoch time
    ${Text_CampaignName}    Set Variable    oos_${epoch}
    ${Text_CampaignDetail}    Set Variable    TC_ITMWME2E_00176 Campaign detail ${epoch}
    ${Text_CampaignStart}    Get current date by format    %m/%d/%Y    0
    ${Text_CampaignEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_FreebieName}    Set Variable    e2e_${epoch}
    ${Text_FreebieShortDesc}    Set Variable    Freebie shot description ${epoch}
    ${Text_FreebieDesc}    Set Variable    Freebie description ${epoch}
    ${Text_FreebieStart}    Get current date by format    %m/%d/%Y    0
    ${Text_FreebieEnd}    Get current date by format    %m/%d/%Y    1 days
    ${Text_Freebie_CategoryType}    Set Variable    ${Variant}
    ${Text_Freebie_Identifyer}    Set Variable    SAAAB1113811
    ${Text_PeriTem}    Set Variable    1
    ${Text_FreeVariantID}    Set Variable    SAAAB1114511
    ${Text_FreeVariantQuantity}    Set Variable    2
    ${Text_RepeatTime}    Set Variable    5
    ${Text_Note}    Set Variable    Note ${epoch}
    ${img_160x80}    Set Variable    \\160x80.jpg
    ${img_220x110}    Set Variable    \\220x110.jpg
    ${img_320x160}    Set Variable    \\320x160.jpg
    ${Text_Email}    Set Variable    e2e@gmail.com
    ${Text_Name}    Set Variable    e2e_test
    ${Text_Phone}    Set Variable    0911111111
    ${Text_Address}    Set Variable    test e2e
    ${Text_Code}    Set Variable    Dummy
    ${product_key}    Set Variable    2653078495585
    ${category_url}    Set Variable    samsung-3788272176468.html?no-cache=1&page=2
    #Update stock to equal amount need to create order
    Update to specific stock number by SKUID    ${Text_FreeVariantID}    2
    Update to specific stock number by SKUID    ${Text_Freebie_Identifyer}    2
    # Create Freebie
    Go To Camp CMS
    ${campaign_id}    Create Campaign    ${Text_CampaignName}    ${Text_CampaignDetail}    ${Text_CampaignStart}    ${Text_CampaignEnd}
    Keywords_CAMP_Promotion.Create Freebie Promotion    ${Text_FreebieName}    ${Text_FreebieShortDesc}    ${Text_FreebieDesc}    ${Text_FreebieStart}    ${Text_FreebieEnd}    ${Text_Freebie_CategoryType}
    ...    ${Text_Freebie_Identifyer}    ${Text_PeriTem}    ${Text_FreeVariantID}    ${Text_FreeVariantQuantity}    ${Text_RepeatTime}    ${Text_Note}
    ...    ${img_160x80}    ${img_220x110}    ${img_320x160}
    Click build button
    #Buy main variance and have freebie out of stock
    ${order_id}=    Buy Product with Freebie and assert Freebie information is correcylt displayed in Checkout process with Installment payment    http://www.itruemart-dev.com/products/samsung-galaxy-s5-16gb-2653078495585.html    1    Samsung Galaxy S5 เครื่องเปล่าศูนย์ทรู แถมฟรี!!!! Powerbank ความจุ 6200 mAh (จ่ายเต็ม หรือ ผ่อนชำระ) (ทองแชมเปญจน์)    18,900.00    2
    ...    3    ${Text_FreebieShortDesc}    ${Text_Email}    ${Text_Name}    ${Text_Phone}    ${Text_Address}
    ...    กสิกรไทย    2    Visa    4111111111111111    123    01
    ...    2026    ABC
    Close Browser
    #Verify Category page display out of stock image
    Go to Category Page with No Cache    ${category_url}
    Category - Verify Out of Stock is displayed by Product key    ${product_key}
    [Teardown]    Run Keywords    close browser
    ...    AND    Delete Campaign    ${campaign_id}
    ...    AND    Delete Hold stock from DB by Order ID    ${order_id}
