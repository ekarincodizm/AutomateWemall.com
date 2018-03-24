*** Settings ***
Library           Selenium2Library
Resource          ../../../Resource/init.robot
Resource          ../../Common/Keywords_Common.robot

*** Keywords ***
Pages access Wemall potal
    Open Browser    ${Wemall_URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="wm-container mega-menu-container"]    20s
    Location Should Be    ${Wemall_URL}/
    Close Browser
    [Teardown]    Close All Browsers

Pages access Wemall potal mobile
    Open Browser    ${WEMALL_MOBILE}/    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="wm-container mega-menu-container"]    20s
    Location Should Be    ${WEMALL_MOBILE}/
    [Teardown]    Close All Browsers

Pages access Wemall potal ENG version
    Open Browser    ${Wemall_URL}/en/itruemart    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="wm-container mega-menu-container"]    20s
    Wait Until Element Is Visible    //span[@ng-if="!login"][contains(text(),"My account")]    20s
    Location Should Be    ${Wemall_URL}/en/itruemart
    [Teardown]    Close All Browsers

Pages access Wemall potal ENG version mobile
    Open Browser    ${WEMALL_MOBILE}/en/    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="wm-container mega-menu-container"]    20s
    Wait Until Element Is Visible    //span[@ng-if="!login"][contains(text(),"My account")]    20s
    Location Should Be    ${WEMALL_MOBILE}/en/
    [Teardown]    Close All Browsers

Pages access Wemall itruemart
    Open Browser    ${Wemall_URL}/itruemart    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    //iwm-merchant-header[@merchant-code="ITM"]    20s
    Location Should Be    ${Wemall_URL}/itruemart
    [Teardown]    Close All Browsers

Pages access Wemall itruemart mobile
    Open Browser    ${WEMALL_MOBILE}/itruemart    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    //div[@ng-bind-html="logo"]    20s
    Location Should Be    ${WEMALL_MOBILE}/itruemart
    [Teardown]    Close All Browsers

Pages access Wemall search
    Open Browser    ${Wemall_URL}/search2?q=iphone&per_page=72&page=1    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="ng-binding"][contains(text(),"iphone")]    20s
    Location Should Be    ${Wemall_URL}/search2?q=iphone&per_page=72&page=1
    [Teardown]    Close All Browsers

Pages access Wemall search ENG version
    Open Browser    ${Wemall_URL}/en/search2?q=iphone&per_page=72&page=1    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="ng-binding"][contains(text(),"iphone")]    20s
    Location Should Be    ${Wemall_URL}/en/search2?q=iphone&per_page=72&page=1
    [Teardown]    Close All Browsers

Pages access Wemall search mobile
    Open Browser    ${WEMALL_MOBILE}/search2?q=iphone    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="ng-binding"][contains(text(),"iphone")]    20s
    Wait Until Element Is Visible    //*[@class="btn-side-menu"]    20s
    Location Should Be    ${WEMALL_MOBILE}/search2?q=iphone
    [Teardown]    Close All Browsers

Pages access Wemall potal HTTPS
    Open Browser    ${Wemall_URL}/    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="wm-container mega-menu-container"]    20s
    Location Should Be    ${Wemall_URL}/
    [Teardown]    Close All Browsers

Pages access Wemall Shop
    Open Browser    ${Wemall_URL}/shop/canon    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="wm-container mega-menu-container"]    20s
    Location Should Be    ${Wemall_URL}/shop/canon
    [Teardown]    Close All Browsers

Pages access Wemall Shop mobile
    Open Browser    ${WEMALL_MOBILE}/shop/canon    ${BROWSER}
    Add Cookie    is_mobile    true
    Reload Page
    Wait Until Element Is Visible    //div[@ng-bind-html="logo"]    20s
    Location Should Be    ${WEMALL_MOBILE}/shop/canon
    [Teardown]    Close All Browsers

Pages access Wemall search redirect from itm url
    Open Browser    ${Wemall_URL}/search2?q=iphone&per_page=60&page=1    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="ng-binding"][contains(text(),"iphone")]    20s
    Location Should Be    ${Wemall_URL}/search2?q=iphone&per_page=72&page=1
    [Teardown]    Close All Browsers

Pages access Wemall search redirect from itm url mobile
    Open Browser    ${WEMALL_MOBILE}/search2?q=iphone    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="ng-binding"][contains(text(),"iphone")]    20s
    Wait Until Element Is Visible    //*[@class="btn-side-menu"]    20s
    Location Should Be    ${WEMALL_MOBILE}/search2?q=iphone
    [Teardown]    Close All Browsers

Pages access Wemall redirect from itm
    Open Browser    ${ITM_URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="wm-container mega-menu-container"]    20s
    Location Should Be    ${Wemall_URL}/
    [Teardown]    Close All Browsers

Pages access Wemall wow
    Open Browser    ${Wemall_URL}/everyday-wow    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="dd-title-name"][contains(text(),"Extra")]    20s
    Location Should Be    ${Wemall_URL}/everyday-wow
    [Teardown]    Close All Browsers

Pages access Wemall level D
    Open Browser    ${Wemall_URL}/products/iphone-6--2634908634297.html    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="order_container"]    20s
    Location Should Be    ${Wemall_URL}/products/iphone-6--2634908634297.html
    [Teardown]    Close All Browsers

Pages access Wemall category
    Open Browser    ${Wemall_URL}/category/samsung-selected-items-3473891659571.html    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="ng-binding"][contains(text(),"CATEGORIES")]    20s
    Location Should Be    ${Wemall_URL}/category/samsung-selected-items-3473891659571.html
    [Teardown]    Close All Browsers

Pages access Wemall brand
    Open Browser    ${Wemall_URL}/brand/samsung-6931849325692.html    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="ng-binding"][contains(text(),"CATEGORIES")]    20s
    Location Should Be    ${Wemall_URL}/brand/samsung-6931849325692.html
    [Teardown]    Close All Browsers

Pages access Wemall truemove h
    Open Browser    ${Wemall_URL}/truemove-h    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@name="action"]//*[contains(text(),"เลือกเบอร์สวย เบอร์มงคล")]    20s
    Location Should Be    ${Wemall_URL}/truemove-h
    [Teardown]    Close All Browsers
