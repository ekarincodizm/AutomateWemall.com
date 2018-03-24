*** Settings ***
Library         Selenium2Library
Library         HttpLibrary.HTTP
Library         Collections
Library         OperatingSystem
Resource        ${CURDIR}/../../../Resource/init.robot
Resource        ${CURDIR}/../../../Keyword/Database/PCMS/Cms_Template/keywords_prepare_data_mail_and_sms.robot
Resource        ${CURDIR}/../../../Keyword/Database/PCMS/Cart/keywords_cart.robot
Resource        ${CURDIR}/../../../Keyword/Database/PCMS/Truemove_h/keywords_truemove_h.robot
Resource        ${CURDIR}/../../../Keyword/Database/PCMS/Orders/keywords_orders.robot

Resource        ${CURDIR}/../../../Keyword/Features/Cms_Template/keywords_mail_and_sms.robot
Resource        ${CURDIR}/../../../Keyword/API/common/api_keywords.robot
Resource        ${CURDIR}/../../../Keyword/API/PCMS/Product/update_stock.robot
Resource        ${CURDIR}/../../../Keyword/API/PCMS/Cart/keywords_cart.robot
Resource        ${CURDIR}/../../../Keyword/API/PCMS/Bundle/keywords_prepare_bundle.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/Full_cart/keywords_full_cart.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/Login/keywords_login.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTruemart/Home/Keywords_home.robot

Resource        ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource        ${CURDIR}/../../../Keyword/Portal/PCMS/Email/keywords_email_sms.robot
Resource        ${CURDIR}/../../../Keyword/Portal/PCMS/TruemoveH/keywords_order_report.robot
Resource        ${CURDIR}/../../../Keyword/Portal/PCMS/TruemoveH/keywords_activate_sim_report.robot
Resource        ${CURDIR}/../../../Keyword/Portal/PCMS/Orders/keywords_track_orders.robot
Resource        ${CURDIR}/../../../Keyword/Portal/PCMS/Orders/keywords_order_detail.robot
Resource        ${CURDIR}/../../../Keyword/Portal/PCMS/Email/Keywords_test_mail_form_order.robot

Resource        ${CURDIR}/../../../Keyword/Portal/KBANK_Payment_Gateway/Keyword_KBank_PaymentGateway.txt
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_1/Keywords_Checkout1.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_2/Keywords_Checkout2.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTruemart/ThankYou_Page/Keywords_ThankYouPage.robot
Resource        ${CURDIR}/../../../Keyword/Portal/CAMP/CAMP_Bundle/Keywords_CAMP_Bundle.robot
Resource        ${CURDIR}/../../../Keyword/Portal/CAMP/CAMP_common/Keywords_CAMP_Common.robot

*** Variables ***
${product_start}                9
${product_stock}                100

*** Test Cases ***
TC_iTM_02783: Can received email/sms thank you with logo wemall and sender from wemall if create order success CCW (TH)
    [Tags]   TC_iTM_02783   ready   regression   ready   ITMMZ-1400   BP-2016S10   email   sms   template
    Cms Template Mail Sms - Login and Clear Cart
    Cms Template Prepare Data - Set Product
    Cms Template Mail Sms - Set Old Stock For Restore
    Cms Template Mail Sms - Set Stock
    Cms Template Mail Sms - Go To Level D To Buy Product
    User Click First Member Address
    Checkout 3 - User Enter Valid Data Master Card As Member
    Sleep   30s
    Confirm Action
    Thankyou - Header Display Payment Status As Success
    Cms Template Mail Sms - Get Order Id From Thankyou Page
    Cms Template Mail Sms - Expect Email Thankyou iTrueMart Changed to Wemall
    [Teardown]   Run Keywords   Cms Template Mail Sms - Restore
    ...  AND    Close Browser

TC_iTM_02784 : Can received email/sms thank you with logo wemall and sender from wemall if create order success Installment (TH)
    [Tags]    TC_iTM_02784   ready   regression   ready   ITMMZ-1400   BP-2016S10   email   sms   template
    Cms Template Mail Sms - Login and Clear Cart
    Cms Template Mail Sms - Prepare Product Installment
    Cms Template Mail Sms - Buy Product
    Cms Template Mail Sms - Checkout with Installment
    Sleep           30s
    Confirm Action
    Cms Template Mail Sms - Get Order Id From Thankyou Page
    Cms Template Mail Sms - Expect Email Thankyou iTrueMart Changed to Wemall
    Email SMS - Email Thankyou Content Display Thank for Order
    Email SMS - Email Thankyou Content Not Display Thank for Order with iTrueMart
    [Teardown]      Run Keywords   Cms Template Mail Sms - Restore
    ...  AND    Close Browser

TC_iTM_02787 : Can received email/sms thank you with logo wemall and sender from wemall if create order success COD (TH)
    [Tags]    TC_iTM_02787   ready   regression   ready   ITMMZ-1400   BP-2016S10   email   sms   template
    Cms Template Mail Sms - Login and Clear Cart
    Cms Template Mail Sms - Prepare Product COD
    Cms Template Mail Sms - Buy Product
    Cms Template Mail Sms - Checkout with COD
#    Sleep           30s
#    Confirm Action
    Cms Template Mail Sms - Get Order Id From Thankyou Page
    Cms Template Mail Sms - Expect Email Thankyou iTrueMart Changed to Wemall
    [Teardown]      Run Keywords   Cms Template Mail Sms - Restore
    ...  AND    Close Browser

TC_iTM_02789: Can received email/sms thank you with logo wemall and sender from wemall if create order success CS (TH)
    [Tags]   TC_iTM_02789   ready   regression   ready   ITMMZ-1400   BP-2016S10   email   sms   template
    Cms Template Mail Sms - Login and Clear Cart
    Cms Template Prepare Data - Set Product Counter Service
    Cms Template Mail Sms - Set Old Stock For Restore
    Cms Template Mail Sms - Set Stock
    Cms Template Mail Sms - Go To Level D To Buy Product
    User Click First Member Address
    Cms Template Mail Sms - Checkout with Counter Service
    Cms Template Mail Sms - Get Order Id From Thankyou Page
    Cms Template Mail Sms - Expect Email Thankyou iTrueMart Changed to Wemall
    [Teardown]   Run Keywords   Cms Template Mail Sms - Restore
    ...  AND    Close Browser

TC_iTM_02792: Can received email/sms thank you with logo wemall and sender from wemall if create order success CCW (EN)
    [Tags]   TC_iTM_02792   ready   regression   ready   ITMMZ-1400   BP-2016S10   email   sms   template
    Cms Template Mail Sms - Login and Clear Cart
    Cms Template Prepare Data - Set Product
    Cms Template Mail Sms - Set Old Stock For Restore
    Cms Template Mail Sms - Set Stock
    Cms Template Mail Sms - Go To Level D To Buy Product (EN)
    User Click First Member Address
    Checkout 3 - User Enter Valid Data Master Card As Member
    Sleep   30s
    Confirm Action
    Cms Template Mail Sms - Get Order Id From Thankyou Page
    Cms Template Mail Sms - Expect Email Thankyou iTrueMart Changed to Wemall EN
    [Teardown]   Run Keywords   Cms Template Mail Sms - Restore
    ...  AND    Close Browser

TC_iTM_02793 : Can received email/sms thank you with logo wemall and sender from wemall if create order success Installment (EN)
    [Tags]    TC_iTM_02793   ready   regression   ready   ITMMZ-1400   BP-2016S10   email   sms   template
    Cms Template Mail Sms - Login and Clear Cart
    Cms Template Mail Sms - Prepare Product Installment
    Cms Template Mail Sms - Buy Product EN
    Cms Template Mail Sms - Checkout with Installment EN
    Sleep           30s
    Confirm Action
    Cms Template Mail Sms - Get Order Id From Thankyou Page
    Cms Template Mail Sms - Expect Email Thankyou iTrueMart Changed to Wemall EN
    Email SMS - Email Thankyou Content Display Thank for Order EN
    Email SMS - Email Thankyou Content Not Display Thank for Order with iTrueMart EN
    [Teardown]      Run Keywords   Cms Template Mail Sms - Restore
    ...  AND    Close Browser

TC_iTM_02796 : Can received email/sms thank you with logo wemall and sender from wemall if create order success COD (TH)
    [Tags]    TC_iTM_02796   ready   regression   ready   ITMMZ-1400   BP-2016S10   email   sms   template
    Cms Template Mail Sms - Login and Clear Cart
    Cms Template Mail Sms - Prepare Product COD
    Cms Template Mail Sms - Buy Product EN
    Cms Template Mail Sms - Checkout with COD
#    Sleep           30s
#    Confirm Action
    Cms Template Mail Sms - Get Order Id From Thankyou Page
    Cms Template Mail Sms - Expect Email Thankyou iTrueMart Changed to Wemall EN
    [Teardown]      Run Keywords   Cms Template Mail Sms - Restore
    ...  AND    Close Browser

TC_iTM_02798: Can received email/sms thank you with logo wemall and sender from wemall if create order success CS (EN)
    [Tags]   TC_iTM_02798   ready   regression   ready   ITMMZ-1400   BP-2016S10   email   sms   template
    Cms Template Mail Sms - Login and Clear Cart
    Cms Template Prepare Data - Set Product Counter Service
    Cms Template Mail Sms - Set Old Stock For Restore
    Cms Template Mail Sms - Set Stock
    Cms Template Mail Sms - Go To Level D To Buy Product (EN)
    User Click First Member Address
    Cms Template Mail Sms - Checkout with Counter Service
    Cms Template Mail Sms - Get Order Id From Thankyou Page
    Cms Template Mail Sms - Expect Email Thankyou iTrueMart Changed to Wemall EN
    [Teardown]   Run Keywords   Cms Template Mail Sms - Restore
    ...  AND    Close Browser

TC_iTM_02801: Can received email/sms thank you with logo wemall and sender from wemall if create order failed CCW (TH)
    [Tags]   TC_iTM_02801   ready   regression   ready   ITMMZ-1400   BP-2016S10   email   sms   template
    Cms Template Mail Sms - Login and Clear Cart
    Cms Template Prepare Data - Set Product
    Cms Template Mail Sms - Set Old Stock For Restore
    Cms Template Mail Sms - Set Stock
    Cms Template Mail Sms - Go To Level D To Buy Product
    User Click First Member Address
    Cms Template Mail Sms - Checkout with CCW Faied
    Sleep   30s
    Confirm Action
    Cms Template Mail Sms - Get Order Id From Thankyou Page
    Cms Template Mail Sms - Expect Email Thankyou iTrueMart Changed to Wemall
    [Teardown]   Run Keywords   Cms Template Mail Sms - Restore
    ...  AND    Close Browser

TC_iTM_02804: Can received email/sms thank you with logo wemall and sender from wemall if create order failed CCW (EN)
    [Tags]   TC_iTM_02804   ready   regression   ready   ITMMZ-1400   BP-2016S10   email   sms   template
    Cms Template Mail Sms - Login and Clear Cart
    Cms Template Prepare Data - Set Product
    Cms Template Mail Sms - Set Old Stock For Restore
    Cms Template Mail Sms - Set Stock
    Cms Template Mail Sms - Go To Level D To Buy Product (EN)
    User Click First Member Address
    Cms Template Mail Sms - Checkout with CCW Faied
    Sleep   30s
    Confirm Action
    Cms Template Mail Sms - Get Order Id From Thankyou Page
    Cms Template Mail Sms - Expect Email Thankyou iTrueMart Changed to Wemall EN
    [Teardown]   Run Keywords   Cms Template Mail Sms - Restore
    ...  AND    Close Browser

TC_iTM_02807: Can received email/sms with logo wemall and sender from wemall if payment success COD (TH)
    [Tags]   TC_iTM_02807   ready   Notregression   ready   ITMMZ-1400   BP-2016S10   email   sms   template
    Cms Template Mail Sms - Login and Clear Cart
    Cms Template Mail Sms - Prepare Product COD
    Cms Template Mail Sms - Go To Level D To Buy Product
    User Click First Member Address
    Cms Template Mail Sms - Checkout with COD
    Cms Template Mail Sms - Get Order Id From Thankyou Page
    Sleep       10s
    Check Mail Form Order - Open Web Site For Check     ${var_mail_sms_order_id}
    Cms Template Mail Sms - Expect Email Repeat After Success iTrueMart Changed to Wemall
    [Teardown]      Run Keywords   Cms Template Mail Sms - Restore
    ...  AND    Close Browser

TC_iTM_02809: Can received email/sms with logo wemall and sender from wemall if payment success CS (TH)
    [Tags]   TC_iTM_02809   ready   Notregression   ready   ITMMZ-1400   BP-2016S10   email   sms   template
    Cms Template Mail Sms - Login and Clear Cart
    Cms Template Prepare Data - Set Product Counter Service
    Cms Template Mail Sms - Set Old Stock For Restore
    Cms Template Mail Sms - Set Stock
    Cms Template Mail Sms - Go To Level D To Buy Product
    User Click First Member Address
    Cms Template Mail Sms - Checkout with Counter Service
    Cms Template Mail Sms - Get Order Id From Thankyou Page
    Sleep       10s
    Check Mail Form Order - Open Web Site For Check     ${var_mail_sms_order_id}
    Cms Template Mail Sms - Expect Email Repeat After Success iTrueMart Changed to Wemall
    [Teardown]      Run Keywords   Cms Template Mail Sms - Restore
    ...  AND    Close Browser

TC_iTM_02812: Can received email/sms with logo wemall and sender from wemall if payment success COD (EN)
    [Tags]   TC_iTM_02812   ready   Notregression   ready   ITMMZ-1400   BP-2016S10   email   sms   template
    Cms Template Mail Sms - Login and Clear Cart
    Cms Template Mail Sms - Prepare Product COD
    Cms Template Mail Sms - Go To Level D To Buy Product (EN)
    User Click First Member Address
    Cms Template Mail Sms - Checkout with COD
    Cms Template Mail Sms - Get Order Id From Thankyou Page
    Sleep       10s
    Check Mail Form Order - Open Web Site For Check     ${var_mail_sms_order_id}
    Cms Template Mail Sms - Expect Email Repeat After Success iTrueMart Changed to Wemall EN
    [Teardown]      Run Keywords   Cms Template Mail Sms - Restore
    ...  AND    Close Browser

TC_iTM_02814: Can received email/sms with logo wemall and sender from wemall if payment success CS (EN)
    [Tags]   TC_iTM_02814   ready   Notregression   ready   ITMMZ-1400   BP-2016S10   email   sms   template
    Cms Template Mail Sms - Login and Clear Cart
    Cms Template Prepare Data - Set Product Counter Service
    Cms Template Mail Sms - Set Old Stock For Restore
    Cms Template Mail Sms - Set Stock
    Cms Template Mail Sms - Go To Level D To Buy Product (EN)
    User Click First Member Address
    Cms Template Mail Sms - Checkout with Counter Service
    Cms Template Mail Sms - Get Order Id From Thankyou Page
    Sleep       10s
    Check Mail Form Order - Open Web Site For Check     ${var_mail_sms_order_id}
    Cms Template Mail Sms - Expect Email Repeat After Success iTrueMart Changed to Wemall EN
    [Teardown]      Run Keywords   Cms Template Mail Sms - Restore
    ...  AND    Close Browser

TC_iTM_02843 : Can received email register TruemoveH form with logo wemall when buy SIM only successfully (TH)
    [Tags]    TC_iTM_02843   ready   regression   ready   ITMMZ-1400   BP-2016S10   email   sms   template
    Cms Template Mail Sms - Login and Clear Cart
    Cms Template Mail Sms - Add Product Sim To Cart
    Go To Checkout 2
    User Click First Member Address
    Checkout3 - Display Checkout Step3 Page
    Cms Template Mail Sms - Checkout with CCW
    Sleep           30s
    Confirm Action
    Cms Template Mail Sms - Get Order Id From Thankyou Page
    Cms Template Mail Sms - Expect Email Thankyou iTrueMart Changed to Wemall
    Cms Template Mail Sms - Expect Email Register TruemoveH iTrueMart Changed to Wemall
    [Teardown]      Run Keywords    Close Browser

TC_iTM_02844 : Can received email register TruemoveH form with logo wemall when buy SIM only successfully (EN)
    [Tags]    TC_iTM_02844   ready   regression   ready   ITMMZ-1400   BP-2016S10   email   sms   template
    Cms Template Mail Sms - Login and Clear Cart
    Cms Template Mail Sms - Add Product Sim To Cart
    Go To Checkout 2 EN
    User Click First Member Address
    Checkout3 - Display Checkout Step3 Page
    Cms Template Mail Sms - Checkout with CCW
    Sleep           30s
    Confirm Action
    Cms Template Mail Sms - Get Order Id From Thankyou Page
    Cms Template Mail Sms - Expect Email Thankyou iTrueMart Changed to Wemall EN
    Cms Template Mail Sms - Expect Email Register TruemoveH iTrueMart Changed to Wemall
    [Teardown]      Run Keywords    Close Browser

TC_iTM_02845 : Can received email activate TruemoveH success (TH) with logo wemall when status is changed from waiting to success
    [Tags]    TC_iTM_02845   ready   Notregression   ready   ITMMZ-1400   BP-2016S10   email   sms   template
    Cms Template Mail Sms - Login and Clear Cart
    Cms Template Mail Sms - Add Product Sim To Cart
    Go To Checkout 2
    User Click First Member Address
    Checkout3 - Display Checkout Step3 Page
    Cms Template Mail Sms - Checkout with CCW
    Sleep           30s
    Confirm Action
    Cms Template Mail Sms - Get Order Id From Thankyou Page
    Cms Template Mail Sms - Expect Email Thankyou iTrueMart Changed to Wemall
    Cms Template Mail Sms - Expect Email Register TruemoveH iTrueMart Changed to Wemall
    Cms Template Mail Sms - Approve Thai ID
    Cms Template Mail Sms - Update Status to Shipped
    Cms Template Mail Sms - Activate Sim to Status Success
    Cms Template Mail Sms - Expect Email Activat Sim Success TruemoveH iTrueMart Changed to Wemall
    [Teardown]      Run Keywords    Close Browser

TC_iTM_02846 : Can received email activate TruemoveH success (EN) with logo wemall when status is changed from waiting to success
    [Tags]    TC_iTM_02846   ready   Notregression   ready   ITMMZ-1400   BP-2016S10   email   sms   template
    Cms Template Mail Sms - Login and Clear Cart
    Cms Template Mail Sms - Add Product Sim To Cart
    Go To Checkout 2 EN
    User Click First Member Address
    Checkout3 - Display Checkout Step3 Page
    Cms Template Mail Sms - Checkout with CCW
    Sleep           30s
    Confirm Action
    Cms Template Mail Sms - Get Order Id From Thankyou Page
    Cms Template Mail Sms - Expect Email Thankyou iTrueMart Changed to Wemall EN
    Cms Template Mail Sms - Expect Email Register TruemoveH iTrueMart Changed to Wemall
    Cms Template Mail Sms - Approve Thai ID
    Cms Template Mail Sms - Update Status to Shipped
    Cms Template Mail Sms - Activate Sim to Status Success
    Cms Template Mail Sms - Expect Email Activat Sim Success TruemoveH iTrueMart Changed to Wemall
    [Teardown]      Run Keywords    Close Browser

TC_iTM_02847 : Can received email activate TruemoveH success (TH) with logo wemall when status is changed from waiting to blacklist
    [Tags]    TC_iTM_02847   ready   Notregression   ready   ITMMZ-1400   BP-2016S10   email   sms   template
    Cms Template Mail Sms - Login and Clear Cart
    Cms Template Mail Sms - Add Product Sim To Cart
    Go To Checkout 2
    User Click First Member Address
    Checkout3 - Display Checkout Step3 Page
    Cms Template Mail Sms - Checkout with CCW
    Sleep           30s
    Confirm Action
    Cms Template Mail Sms - Get Order Id From Thankyou Page
    Cms Template Mail Sms - Expect Email Thankyou iTrueMart Changed to Wemall
    Cms Template Mail Sms - Expect Email Register TruemoveH iTrueMart Changed to Wemall
    Cms Template Mail Sms - Approve Thai ID
    Cms Template Mail Sms - Update Status to Shipped
    Cms Template Mail Sms - Activate Sim to Status Blacklist
    Cms Template Mail Sms - Expect Email Activat Sim Fail TruemoveH iTrueMart Changed to Wemall
    [Teardown]      Run Keywords    Close Browser

TC_iTM_02848 : Cms Template Mail Sms - Expect Email Activat Sim Fail TruemoveH iTrueMart Changed to Wemall : Can received email activate TruemoveH success (TH) with logo wemall when status is changed from waiting to blacklist
    [Tags]    TC_iTM_02848   ready   Notregression   ready   ITMMZ-1400   BP-2016S10   email   sms   template
    Cms Template Mail Sms - Login and Clear Cart
    Cms Template Mail Sms - Add Product Sim To Cart
    Go To Checkout 2 EN
    User Click First Member Address
    Checkout3 - Display Checkout Step3 Page
    Cms Template Mail Sms - Checkout with CCW
    Sleep           30s
    Confirm Action
    Cms Template Mail Sms - Get Order Id From Thankyou Page
    Cms Template Mail Sms - Expect Email Thankyou iTrueMart Changed to Wemall EN
    Cms Template Mail Sms - Expect Email Register TruemoveH iTrueMart Changed to Wemall
    Cms Template Mail Sms - Approve Thai ID
    Cms Template Mail Sms - Update Status to Shipped
    Cms Template Mail Sms - Activate Sim to Status Blacklist
    Cms Template Mail Sms - Expect Email Activat Sim Fail TruemoveH iTrueMart Changed to Wemall
    [Teardown]      Run Keywords    Close Browser
