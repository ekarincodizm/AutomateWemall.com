*** Settings ***
Force Tags    WLS_Wemall_storefront_homepage
Suite Setup         Run Keywords    Prepare Shop For Suite And If Shop Exist will Delete and Create New    ${merchant_id}    ${shop_name}    ${shop_slug}    ${status}
    ...             AND    Open Storefront - Shop List Page
    ...             AND    Set up Content Anchor link
    ...             AND    Set up Menu Anchor link

Suite Teardown      Run Keywords    Close All Browsers
    ...             AND    Delete Shop and All Storefront Data    ${suite_shop_id}

Resource            ${CURDIR}/../../../Resource/init.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/storefront_page/webelement_anchor_link.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/storefront_page/webelement_storefront_page.robot
# Resource            ${CURDIR}/../../../Keywords/api_merchant/css_api_merchant_keyword.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_list_page/css_shop_list_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/shop_management_page/css_shop_management_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/manage_shop_content/css_manage_shop_content_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/common_page/css_common_page_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/common/web_common_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/ckeditor/web_ckeditor_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/storefront_cms/manage_shop_menu/css_manage_shop_menu_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/storefront_page/anchor_link_keywords.robot
Resource            ${CURDIR}/../../../Keyword/Portal/wemall/storefront_page/storefront_landing_web_page_keywords.robot
Library             OperatingSystem
Library             Selenium2Library
Library             ${CURDIR}/../../../Python_Library/ExtendedSelenium/

*** Variables ***
${merchant_id}         TOSHIBA00813
${shop_name}           Toshiba
${status}              active
${shop_slug}           toshiba

${module}              Content
${web}                 Web
${mobile}              Mobile

*** Test Cases ***
TC_WMALL_01480 [Web][Th] On Shop in Shop Page,Anchor link scroll to element when Click
    [Tags]    Regression    manage_storefront    anchor_link
    [Template]          Scroll to Element When Click Element
    [Setup]             Go To Shop TH     ${shop_slug}
#   ${clickedElem}                ${destElem}
    jquery=img#content_header     jquery=#content_footer    ${empty}
    jquery=img#content_footer     jquery=#content_header    ${empty}
    jquery=ul.menu > li > a[data-menu="1"]:eq(0)        jquery=#content_footer    ${empty}
    jquery=ul.menu > li > a[data-menu="1"]:eq(1)        jquery=#content_footer    ${empty}
    jquery=ul.menu > li > a[data-menu="1"]:eq(2)        jquery=#content_footer    ${empty}


TC_WMALL_01481 [Web][En] On Shop in Shop Page,Anchor link scroll to element when Click
    [Tags]    Regression    manage_storefront    anchor_link
    [Template]          Scroll to Element When Click Element
    [Setup]              Go To Shop EN    ${shop_slug}
#   ${clickedElem}                                ${destElem}
    jquery=img#content_header                     jquery=#content_footer    ${empty}
    jquery=img#content_footer                     jquery=#content_header    ${empty}
    jquery=ul.menu > li > a[data-menu="1"]:eq(0)  jquery=#content_footer    ${empty}
    jquery=ul.menu > li > a[data-menu="1"]:eq(1)  jquery=#content_footer    ${empty}
    jquery=ul.menu > li > a[data-menu="1"]:eq(2)  jquery=#content_footer    ${empty}

TC_WMALL_01482 [Web][Th] On Shop in Shop Page,Anchor link scroll to element when Click with QueryString
    [Tags]    Regression    manage_storefront    anchor_link
    [Template]          Scroll to Element When Click Element
    [Setup]             Go To Shop TH    ${shop_slug}?q=iphone4
#   ${clickedElem}                                ${destElem}
    jquery=img#content_header                     jquery=#content_footer    ?q=iphone4
    jquery=img#content_footer                     jquery=#content_header    ?q=iphone4
    jquery=ul.menu > li > a[data-menu="1"]:eq(0)  jquery=#content_footer    ?q=iphone4
    jquery=ul.menu > li > a[data-menu="1"]:eq(1)  jquery=#content_footer    ?q=iphone4
    jquery=ul.menu > li > a[data-menu="1"]:eq(2)  jquery=#content_footer    ?q=iphone4

TC_WMALL_01483 [Web][En] On Shop in Shop Page,Anchor link scroll to element when Click with QueryString
    [Tags]    Regression    manage_storefront    anchor_link
    [Template]          Scroll to Element When Click Element
    [Setup]             Go To Shop EN    ${shop_slug}?q=iphone5
#   ${clickedElem}                                  ${destElem}
    jquery=img#content_header                      jquery=#content_footer    ?q=iphone5
    jquery=img#content_footer                      jquery=#content_header    ?q=iphone5
    jquery=ul.menu > li > a[data-menu="1"]:eq(0)   jquery=#content_footer    ?q=iphone5
    jquery=ul.menu > li > a[data-menu="1"]:eq(1)   jquery=#content_footer    ?q=iphone5
    jquery=ul.menu > li > a[data-menu="1"]:eq(2)   jquery=#content_footer    ?q=iphone5

TC_WMALL_01484 [Web][Th] On Shop in Shop Page,Anchor link scroll to element when Enter Url
    [Tags]    Regression    manage_storefront    anchor_link
    [Template]          Scroll to Element When Enter Url With Hash
#   ${url}                                                       ${hash}               ${expectedQueryString}
    ${WEMALL_WEB}/shop/${shop_slug}#content_header                jquery=#content_header   ${empty}
    ${WEMALL_WEB}/shop/${shop_slug}#content_footer                jquery=#content_footer    ${empty}
    ${WEMALL_WEB}/shop/${shop_slug}?q=iphone5#content_footer      jquery=#content_footer   ?q=iphone5

TC_WMALL_01485 [Web][En] On Shop in Shop Page,Anchor link scroll to element when Enter Url
    [Tags]    Regression    manage_storefront    anchor_link
    [Template]          Scroll to Element When Enter Url With Hash
#   ${url}                                                          ${hash}             ${expectedQueryString}
    ${WEMALL_WEB}${secondary_language}/shop/${shop_slug}#content_header                jquery=#content_header    ${empty}
    ${WEMALL_WEB}${secondary_language}/shop/${shop_slug}#content_footer                jquery=#content_footer     ${empty}
    ${WEMALL_WEB}${secondary_language}/shop/${shop_slug}?q=iphone6#content_footer      jquery=#content_footer    ?q=iphone6

TC_WMALL_01486 [Web][Th] On Portal Page,Anchor link scroll to element when Enter Url
    [Tags]    Regression    manage_storefront    anchor_link    12345
    [Template]          Scroll to Element When Enter Url With Hash
#   ${url}                                     ${hash}               ${expectedQueryString}
    ${WEMALL_WEB}#footer                       jquery=#footer        ${empty}
    ${WEMALL_WEB}?xxx=a#footer                 jquery=#footer        ?xxx=a

TC_WMALL_01487 [Web][En] On Portal Page,Anchor link scroll to element when Enter Url
    [Tags]    Regression    manage_storefront    anchor_link    12345
    [Template]          Scroll to Element When Enter Url With Hash
#   ${url}                                                          ${hash}             ${expectedQueryString}
    ${WEMALL_WEB}${secondary_language}/#footer                       jquery=#footer        ${empty}
    ${WEMALL_WEB}${secondary_language}/?xxx=a#footer                 jquery=#footer        ?xxx=a

*** Keywords ***
Set up Content Anchor link
    Go to URL Shop List Page
    Go To Manage Storefront Page    ${suite_shop_id}    web
    Click Link on Management Page    ${suite_shop_id}    ${module}    ${web}
    Wait Until Angular Ready    60s
    CKEditor Wait Util Ready    ${ckidprimary}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    ${content}=    Get File    ${test_content_th}
    CKEditor Input Text    ${ckidprimary}    ${content}
    Click Element and Wait Angular Ready    ${SOURCE_ICONTH}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    ${content}=    Get File    ${test_content_en}
    CKEditor Input Text    ${ckidsecondary}    ${content}
    Click Element and Wait Angular Ready    ${SOURCE_ICONEN}
    Click Save for Content Storefront page
    Wait For Success Content Storefront page
    Click Publish for Content Storefront page

Set up Menu Anchor link
    Update Storefront and Published Storefront Data    ${suite_shop_id}    ${prepare_header}    header
    Go To Menu Editor Page For Web    ${suite_shop_id}
    Click Add Menu Button    1
    Fill In Menu Data    @{menuLevel11}
    Click Ok Button on Modal Dialog
    Click Add Menu Button    1
    Fill In Menu Data    @{menuLevel21}
    Click Ok Button on Modal Dialog
    Click Add Menu Button    1
    Fill In Menu Data    @{menuLevel31}
    Click Ok Button on Modal Dialog
    Set Status To Active
    Click Save Menu Button
    Verify Status Message Appears    ${SAVE_DRAFT_SUCCESS_MSG}
    Click Publish Button