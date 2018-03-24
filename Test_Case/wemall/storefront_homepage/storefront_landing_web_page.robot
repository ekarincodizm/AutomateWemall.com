*** Settings ***
Force Tags    WLS_Wemall_storefront_homepage
Suite Setup       Run Keywords    Open Wemall Browser   AND    Prepare Landing Page Data
Suite Teardown    Run Keywords    Close All Browsers
    ...           AND    Delete Landing Page Prepare Data
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/common/web_common_keywords.robot
Resource          ${CURDIR}/../../../Keyword/Portal/wemall/storefront_page/storefront_landing_web_page_keywords.robot

*** Test Cases ***
TC_WMALL_01218 Check active shop slug web
    [Tags]    shop_landing_page    Regression
    Go To Active Merchant
    Show Correct Merchant

TC_WMALL_01219 Check inactive shop slug web
    [Tags]    shop_landing_page    Regression
    Go To Inactive Merchant
    Show Page Not Found

TC_WMALL_01220 Check shop not found web
    [Tags]    shop_landing_page    Regression
    Go To Not Found MerChant
    Show Page Not Found

TC_WMALL_01283 Check shop slug status waiting
    [Tags]    shop_landing_page    Regression
    Go To Waiting Merchant
    Show Page Not Found

TC_WMALL_01221 Check active shop slug secondary language web
    [Tags]    shop_landing_page    Regression
    Go To Active Merchant With Secondary Language
    Show Correct Merchant With Secondary Language

TC_WMALL_01222 Check inactive shop slug secondary language web
    [Tags]    shop_landing_page    Regression
    Go To Inactive Merchant With Secondary Language
    Show Page Not Found

TC_WMALL_01223 Check shop not found secondary language web
    [Tags]    shop_landing_page    Regression
    Go To Not Found MerChant With Secondary Language
    Show Page Not Found

TC_WMALL_01284 Check shop slug status waiting secondary language
    [Tags]    shop_landing_page    Regression
    Go To Waiting Merchant With Secondary Language
    Show Page Not Found

TC_WMALL_01224 Check active shop slug mobile
    [Tags]    shop_landing_page    Regression
    Go To Active Merchant
    Add Cookie Mobile
    Go To Active Merchant
    Show Mobile Web
    Show Correct Merchant

TC_WMALL_01225 Check inactive shop slug mobile
    [Tags]    shop_landing_page    Regression
    Go To Active Merchant
    Add Cookie Mobile
    Go To Inactive Merchant
    Show Page Not Found

TC_WMALL_01226 Check shop not found mobile
    [Tags]    shop_landing_page    Regression
    Go To Active Merchant
    Add Cookie Mobile
    Go To Not Found MerChant
    Show Page Not Found

TC_WMALL_01285 Check waiting shop slug mobile
    [Tags]    shop_landing_page    Regression
    # Go To Active Merchant
    Go To Wemall
    Add Cookie Mobile
    Go To Waiting Merchant
    Show Mobile Web
    Show Page Not Found

TC_WMALL_01227 Check active shop slug secondary language mobile
    [Tags]    shop_landing_page    Regression
    Go To Active Merchant
    Add Cookie Mobile
    Go To Active Merchant With Secondary Language
    Show Correct Merchant With Secondary Language

TC_WMALL_01228 Check inactive shop slug secondary language mobile
    [Tags]    shop_landing_page    Regression
    Go To Active Merchant
    Add Cookie Mobile
    Go To Inactive Merchant With Secondary Language
    Show Page Not Found

TC_WMALL_01229 Check shop not found secondary language mobile
    [Tags]    shop_landing_page    Regression
    Go To Active Merchant
    Add Cookie Mobile
    Go To Not Found MerChant With Secondary Language
    Show Page Not Found

TC_WMALL_01286 Check waiting shop slug secondary language mobile
    [Tags]    shop_landing_page    Regression
    Go To Active Merchant
    Add Cookie Mobile
    Go To Waiting Merchant With Secondary Language
    Show Page Not Found

# # TC_WMALL_01302 - Check Portal Page Should Not Show - Web View
# #     [Tags]    shop_landing_page    Regression
# #     Go To Potal Page
# #     Show Page Not Found

# TC_WMALL_01303 - Check Portal Page With Dot In URL Should Not Show - Web View
#     [Tags]    shop_landing_page    Regression
#     Go To Potal Page With Dot In URL
#     Show Page Not Found

# TC_WMALL_01304 - Check Portal Page With Controller And Action In URL Should Not Show - Web View
#     [Tags]    shop_landing_page    Regression
#     Go To Waiting Merchant With Secondary Language
#     Go To Potal Page With Controller And Action In URL Should Not Show
#     Show Page Not Found

# # TC_WMALL_01305 - Check Portal Page Should Not Show - Mobile View
# #     [Tags]    shop_landing_page    Regression
# #     Go To Active Merchant
# #     Add Cookie Mobile
# #     Go To Potal Page
# #     Show Page Not Found

# TC_WMALL_01306 - Check Portal Page With Dot In URL Should Not Show - Mobile View
#     [Tags]    shop_landing_page    Regression
#     Go To Active Merchant
#     Add Cookie Mobile
#     Go To Potal Page With Dot In URL
#     Show Page Not Found

# TC_WMALL_01307 - Check Portal Page With Controller And Action In URL Should Not Show - Mobile View
#     [Tags]    shop_landing_page    Regression
#     Go To Active Merchant
#     Add Cookie Mobile
#     Go To Waiting Merchant With Secondary Language
#     Go To Potal Page With Controller And Action In URL Should Not Show
#     Show Page Not Found



