*** Settings ***
# Force Tags        Wemall_Portal_Page
Library         Selenium2Library
Library         ${CURDIR}/../../../Python_Library/ExtendedSelenium/

Suite Teardown    Close All Browsers

*** Test Cases ***
TC_WMALL_xxxxx - Check Cross Origin Issue of Mobile Site
    [tags]    Portal    staging
    Open Browser    http://www.wemall-dev.com    gc
    Delete Cookie    is_mobile
    Add Cookie       is_mobile    true
    Delete Cookie    is_clear
    Add Cookie       is_clear    false
    Go To     http://www.wemall-dev.com
    Wait Until Angular Ready    30s
    Go to     http://m.wemall-dev.com/products/aiko-ak-125gs-5549-stone-skunk-v.2-2557653043206.html
    Add Cookie       is_clear    false
    Add Cookie       is_mobile    true
    Wait Until Angular Ready    30s
    Click Element and Wait Angular Ready    jquery=.box-center .box-center
    Wait Until Angular Ready    30s
    Page Should Contain Element    jquery=.wm-skirt-header    Mobile portal page not contain menu bars section
    Page Should Contain Element    jquery=.lb-section-content .owl-stage-outer    Mobile portal page not contain mega-menus section
    Page Should Contain Element    jquery=.super-deals-box.ng-isolate-scope .icon-everyday-wow    Mobile portal page not contain everyday-wow section
    Page Should Contain Element    jquery=.wm-brand-box.ng-isolate-scope    Mobile portal page not contain merchant-zones section
    Page Should Contain Element    jquery=.wm-floor-box.ng-isolate-scope    Mobile portal page not contain showrooms section

TC_WMALL_xxxxx - Check Cross Origin Issue of Mobile Site
    [tags]    Portal    production
    Open Browser    http://www.wemall.com    gc
    Delete Cookie    is_mobile
    Add Cookie       is_mobile    true
    Delete Cookie    is_clear
    Add Cookie       is_clear    false
    Go To     http://www.wemall.com
    Wait Until Angular Ready    30s
    Go to     http://m.wemall.com/products/aiko-ak-125gs-5549-stone-skunk-v.2-2557653043206.html
    Add Cookie       is_clear    false
    Add Cookie       is_mobile    true
    Wait Until Angular Ready    30s
    Click Element and Wait Angular Ready    jquery=.box-center .box-center
    Wait Until Angular Ready    30s
    Page Should Contain Element    jquery=.wm-skirt-header    Mobile portal page not contain menu bars section
    Page Should Contain Element    jquery=.lb-section-content .owl-stage-outer    Mobile portal page not contain mega-menus section
    Page Should Contain Element    jquery=.super-deals-box.ng-isolate-scope .icon-everyday-wow    Mobile portal page not contain everyday-wow section
    Page Should Contain Element    jquery=.wm-brand-box.ng-isolate-scope    Mobile portal page not contain merchant-zones section
    Page Should Contain Element    jquery=.wm-floor-box.ng-isolate-scope    Mobile portal page not contain showrooms section














