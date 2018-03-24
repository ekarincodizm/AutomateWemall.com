*** Settings ***
Force Tags    WLS_Level_C
Library     Selenium2Library
Library     HttpLibrary.HTTP
Library     Collections
Library     OperatingSystem
Resource    ${CURDIR}/../../../Resource/init.robot
Resource    ${CURDIR}/../../../Keyword/Portal/ui_floating_ads/keywords_ui_floatind_ads.robot
Resource    ${CURDIR}/../../../Keyword/Features/Create_Order/Create_order.txt
Resource    ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot
Resource    ${CURDIR}/../../../Keyword/API/PCMS/Collection/keywords_api_collection.robot
Resource    ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_c_page/keyword_level_c.robot

*** Test Cases ***
TC_iTM_03514 Promotion list on category
    [tags]  TC_iTM_03514    PromotionList   regression  QCT
    Given Get collection from apiCollection-GetIndex
    When Open ITM level C Web With URI      /category/clearance-sale-promotions-3701258529460.html
    Then Data in Promotion tree are the same as collection returned from API
    [Teardown]    close browser

TC_iTM_03515 Promotion list EN on category
    [tags]  TC_iTM_03515    PromotionList   regression
    Given Get collection from apiCollection-GetIndex
    When Open ITM level C Web With URI      /en/category/clearance-sale-promotions-3701258529460.html
    Then Data in Promotion tree are the same as collection returned from API
    [Teardown]    close browser

TC_iTM_03517 Brand filtering
    [tags]  TC_iTM_03517    Brand   regression
     Given Get brand list from apiCollection-brandincollection
     When Open ITM level C Web With URI      /category/clearance-sale-promotions-3701258529460.html
     Then Data in brand list under the collection are the same as brand returned from API
    [Teardown]    close browser

TC_iTM_03518 Brand filtering EN
    [tags]  TC_iTM_03518    Brand   regression
     Given Get brand list from apiCollection-brandincollection
     When Open ITM level C Web With URI      /category/clearance-sale-promotions-3701258529460.html
     Then Data in brand list under the collection are the same as brand returned from API
    [Teardown]    close browser
