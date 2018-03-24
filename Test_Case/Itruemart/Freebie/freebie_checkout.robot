*** Settings ***
Suite Teardown    Selenium2Library.Close All Browsers
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           OperatingSystem
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Freebie/keywords_prepare_data_checkout.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Cart/keywords_cart.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Stock/keywords_stock.robot
Resource          ${CURDIR}/../../../Keyword/Features/Freebie/keywords_checkout.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Full_cart/keywords_full_cart.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_1/Keywords_Checkout1.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_2/Keywords_Checkout2.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Logout/keywords_logout.robot
Resource          ${CURDIR}/../../../Keyword/Portal/KBANK_Payment_Gateway/Keyword_KBank_PaymentGateway.txt
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Orders/keywords_track_orders.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Orders/keywords_order_detail.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Campaign/Keywords_Campaign.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Promotion/Keywords_Promotion.robot
Resource          ${CURDIR}/../../../Keyword/Mobile/Mobile_iTrueMart/Mobile_Level_d_page/WebElement_LevelD.robot
Resource          ${CURDIR}/../../../Keyword/API/common/api_keywords.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Product/update_stock.robot
Resource          ${CURDIR}/../../../Keyword/Portal/AAD/AAD_common/keywords_aad.robot
Resource          ${CURDIR}/../../../Keyword/Portal/CAMP/CAMP_Freebie/keywords_freebie.robot
Resource          ${CURDIR}/../../../Keyword/Portal/CAMP/CAMP_common/Keywords_CAMP_Common.robot

*** Variables ***
${start_normal}    5
${start_free}     7

*** Test Cases ***
TC_iTM_00600 : Free item can be checkout when the free item is new SKU from FMS and created product in PCMS by making pay via CCW
    [Tags]    TC_iTM_00600    ready    set1
    Freebie Checkout - Get Product Same Collection
    Freebie Checkout - Get Free Product Status Inactive Content Draft No Collection
    Freebie Checkout - Get Main Product Same Collection A
    Freebie Checkout - Get Normal Product Same Collection B
    Freebie Checkout - Get Normal2 Product Same Collection c
    Freebie Checkout - Check Current Stock Main Product
    Freebie Checkout - Check Current Stock Free Product
    Freebie Checkout - Check Current Stock Normal Product
    Freebie Checkout - Check Current Stock Normal2 Product
    Freebie Checkout - Set Remaining Main Product    20
    Freebie Checkout - Set Remaining Free Product    20
    Freebie Checkout - Set Remaining Normal Product    20
    Freebie Checkout - Set Remaining Normal2 Product    20
    User Open Home page
    Freebie Checkout - Rebuild Stock More Than 1Variant
    Freebie Checkout - Rebuild Stock More Than 1Variant Normal
    Freebie Checkout - Rebuild Stock More Than 1Variant Normal2
    Freebie Checkout - Set Freebie On Camp    2    1
    Promotion - Remove Promotion By Campaign Name And Promotion Name    ${robot_campaign_ITMMZ_1211}    TC_iTM_00600
    Freebie Checkout - Create Promotion Code Main Exclude Normal Discount Percent    TC_iTM_00600    10
    Freebie Checkout - Set Promotion Code For Freebie    TC_iTM_00600
    Freebie Checkout - Add Main Product has Style 2 Qty To Cart And Logout
    Freebie Checkout - User Login Check Item In Cart has Promotion Buy 2 Get 1
    Freebie Checkout - Go To Level D Normal Product
    Freebie Checkout - Choose Style Option Normal Product
    Level D - User Click Add To Cart Button
    Display Full Cart
    Full Cart - Display Total Quantity Items Of Full Cart As Expect Qty    4
    Freebie Checkout - Go To Level D Normal2 Product
    Freebie Checkout - Choose Style Option Normal2 Product
    Level D - User Click Add To Cart Button
    Display Full Cart
    Full Cart - Display Normal Product First Item 2 Qty
    Full Cart - Display Normal Product Second Item 1 Qty
    Full Cart - Display Normal Product Third Item 1 Qty
    Full Cart - Display Free Product First Item 1 Qty
    Full Cart - Display Camp Short Description
    User Click Next Process On Full Cart
    User Click First Member Address
    Freebie Checkout - Step 3 User Apply Coupon And Enter Valid Data Master Card
    # Display Cybersource Page
    # Confirm Action
    Freebie Checkout - Display Freebie Order On Thankyou Page Success
    Thankyou - Count Normal Items as Expect Qty    4
    Thankyou - Count Freebie Items as Expect Qty    1
    Thankyou - Count All Items as Expect Qty    5
    Thankyou - Price of Freebie Item Is Zero    1
    Thankyou - Total Price of Freebie Item Is Zero    1
    Thankyou - Display Short description From Camp On Remark
    Freebie Checkout - Count Stock Hold Permanent    5
    Freebie Checkout - Check Remaining Main Product    18
    Freebie Checkout - Check Remaining Free Product    19
    Freebie Checkout - Check Remaining Normal Product    19
    Freebie Checkout - Check Remaining Normal2 Product    19
    Freebie Checkout - Check Order Freebie On PCMS    4    1
    [Teardown]    Run Keywords    Freebie Checkout - Restore Remaining 1Main 1Free 2Normal And Promotion And Campaign

TC_iTM_00603 : Free item can be checkout when the free item is new SKU and assign collection with publish on iTM with apply coupon type on "Cart with Condition-collection with exclude product"
    [Tags]    TC_iTM_00603    ready    set2
    Freebie Checkout - Get Product Same Collection
    Freebie Checkout - Get Free Product Status Inactive Content Draft Collection Is Itruemart
    Freebie Checkout - Get Main Product Same Collection A
    Freebie Checkout - Get Normal Product Same Collection B
    Freebie Checkout - Get Normal2 Product Same Collection C
    Freebie Checkout - Check Current Stock Main Product
    Freebie Checkout - Check Current Stock Free Product
    Freebie Checkout - Check Current Stock Normal Product
    Freebie Checkout - Check Current Stock Normal2 Product
    Freebie Checkout - Set Remaining Main Product    20
    Freebie Checkout - Set Remaining Free Product    20
    Freebie Checkout - Set Remaining Normal Product    20
    Freebie Checkout - Set Remaining Normal2 Product    20
    User Open Home page
    Freebie Checkout - Rebuild Stock More Than 1Variant
    Freebie Checkout - Rebuild Stock More Than 1Variant Normal
    Freebie Checkout - Rebuild Stock More Than 1Variant Normal2
    Freebie Checkout - Set Freebie On Camp    2    1
    Promotion - Remove Promotion By Campaign Name And Promotion Name    ${robot_campaign_ITMMZ_1211}    TC_iTM_00603
    Freebie Checkout - Create Promotion Code For Freebie Discount On Cart    TC_iTM_00603    10
    Freebie Checkout - Set Promotion Code For Freebie    TC_iTM_00603
    Freebie Checkout - Add Main Product has Style 2 Qty To Cart And Logout
    Freebie Checkout - User Login Check Item In Cart has Promotion Buy 2 Get 1
    Freebie Checkout - Go To Level D Normal Product
    Freebie Checkout - Choose Style Option Normal Product
    Level D - User Click Add To Cart Button
    Display Full Cart
    Full Cart - Display Total Quantity Items Of Full Cart As Expect Qty    4
    Freebie Checkout - Go To Level D Normal2 Product
    Freebie Checkout - Choose Style Option Normal2 Product
    Level D - User Click Add To Cart Button
    Display Full Cart
    Full Cart - Display Normal Product First Item 2 Qty
    Full Cart - Display Normal Product Second Item 1 Qty
    Full Cart - Display Normal Product Third Item 1 Qty
    Full Cart - Display Free Product First Item 1 Qty
    Full Cart - Display Camp Short Description
    User Click Next Process On Full Cart
    User Click First Member Address
    Freebie Checkout - Step 3 User Apply Coupon And Enter Valid Data Master Card
    # Display Cybersource Page
    # Confirm Action
    Freebie Checkout - Display Freebie Order On Thankyou Page Success
    Thankyou - Count Normal Items as Expect Qty    4
    Thankyou - Count Freebie Items as Expect Qty    1
    Thankyou - Count All Items as Expect Qty    5
    Thankyou - Price of Freebie Item Is Zero    1
    Thankyou - Total Price of Freebie Item Is Zero    1
    Thankyou - Display Short description From Camp On Remark
    Freebie Checkout - Count Stock Hold Permanent    5
    Freebie Checkout - Check Remaining Main Product    18
    Freebie Checkout - Check Remaining Free Product    19
    Freebie Checkout - Check Remaining Normal Product    19
    Freebie Checkout - Check Remaining Normal2 Product    19
    Freebie Checkout - Check Order Freebie On PCMS    4    1
    [Teardown]    Run Keywords    Freebie Checkout - Restore Remaining 1Main 1Free 2Normal And Promotion And Campaign

TC_iTM_00606 : Free item can be checkout when the free item is new SKU and assign collection but not publish on iTM
    [Tags]    TC_iTM_00606    ready    set3
    Freebie Checkout - Set Product 1Variant
    Freebie Checkout - Get Main Product 1Variant A
    Freebie Checkout - Get Free Product Status Inactive Content Draft Has Collection Not Publish On Itruemart
    Freebie Checkout - Check Current Stock Main Product
    Freebie Checkout - Check Current Stock Free Product
    Freebie Checkout - Set Remaining Main Product    20
    Freebie Checkout - Set Remaining Free Product    20
    User Open Home page
    Freebie Checkout - Rebuild Stock No Variant
    Freebie Checkout - Set Freebie On Camp    2    1
    Freebie Checkout - Add Main Product No Style 2 Qty To Cart And Logout
    Freebie Checkout - User Login Check Item In Cart has Promotion Buy 2 Get 1
    User Click Next Process On Full Cart
    User Click First Member Address
    Freebie Checkout - Step 3 User Enter Valid Data Master Card
    # Sleep    5s
    # Display Cybersource Page
    # Confirm Action
    Freebie Checkout - Display Freebie Order On Thankyou Page Success
    Thankyou - Count Normal Items as Expect Qty    2
    Thankyou - Count Freebie Items as Expect Qty    1
    Thankyou - Count All Items as Expect Qty    3
    Thankyou - Price of Freebie Item Is Zero    1
    Thankyou - Total Price of Freebie Item Is Zero    1
    Thankyou - Display Short description From Camp On Remark
    Freebie Checkout - Count Stock Hold Permanent    3
    Freebie Checkout - Check Remaining Main Product    18
    Freebie Checkout - Check Remaining Free Product    19
    Freebie Checkout - Check Order Freebie On PCMS    2    1
    [Teardown]    Run Keywords    Freebie Checkout - Restore Remaining And Promotion

TC_iTM_00607 : Free item can be checkout when the freebie is in stock with status inactive and has product content status as "Draft"
    [Tags]    TC_iTM_00607    ready    set3
    Freebie Checkout - Set Product 1Variant
    Freebie Checkout - Get Main Product 1Variant A
    Freebie Checkout - Get Free Product Status Inactive Content Draft Variant Status Active
    Freebie Checkout - Check Current Stock Main Product
    Freebie Checkout - Check Current Stock Free Product
    Freebie Checkout - Set Remaining Main Product    20
    Freebie Checkout - Set Remaining Free Product    20
    User Open Home page
    Freebie Checkout - Rebuild Stock No Variant
    Freebie Checkout - Set Freebie On Camp    2    1
    Freebie Checkout - Add Main Product No Style 2 Qty To Cart And Logout
    Freebie Checkout - User Login Check Item In Cart has Promotion Buy 2 Get 1
    User Click Next Process On Full Cart
    User Click First Member Address
    Freebie Checkout - Step 3 User Enter Valid Data Master Card
    #    # Sleep    5s
    #    # Display Cybersource Page
    #    # Confirm Action
    Freebie Checkout - Display Freebie Order On Thankyou Page Success
    Thankyou - Count Normal Items as Expect Qty    2
    Thankyou - Count Freebie Items as Expect Qty    1
    Thankyou - Count All Items as Expect Qty    3
    Thankyou - Price of Freebie Item Is Zero    1
    Thankyou - Total Price of Freebie Item Is Zero    1
    Thankyou - Display Short description From Camp On Remark
    Freebie Checkout - Check Order Freebie On PCMS    2    1
    Freebie Checkout - Count Stock Hold Permanent    3
    Freebie Checkout - Check Remaining Main Product    18
    Freebie Checkout - Check Remaining Free Product    19
    [Teardown]    Run Keywords    Freebie Checkout - Restore Remaining And Promotion

TC_iTM_00608 : Free item can not be checkout when the free item is out of stock with status inactive and has product content status as "Draft"
    [Tags]    TC_iTM_00608    ready    set3
    Freebie Checkout - Set Product 1Variant
    Freebie Checkout - Get Main Product 1Variant A
    Freebie Checkout - Get Free Product Status Inactive Content Draft Variant Status Active
    Freebie Checkout - Check Current Stock Main Product
    Freebie Checkout - Check Current Stock Free Product
    Freebie Checkout - Set Remaining Main Product    20
    Freebie Checkout - Set Remaining Free Product    20
    User Open Home page
    Freebie Checkout - Rebuild Stock No Variant
    Freebie Checkout - Set Freebie On Camp    2    1
    Freebie Checkout - Add Main Product No Style 2 Qty To Cart And Logout
    Freebie Checkout - User Login Check Item In Cart has Promotion Buy 2 Get 1
    User Click Next Process On Full Cart
    User Click First Member Address
    Freebie Checkout - Set Remaining Free Product    0
    Freebie Checkout - Step 3 User Enter Valid Data Master Card
    Checkout3 - Display Out Of Stock Page
    [Teardown]    Run Keywords    Freebie Checkout - Restore Remaining And Promotion

TC_iTM_00609 : Free item can be checkout when the freebie is in stock with status inactive and have product content status as "Approve"
    [Tags]    TC_iTM_00609    ready    set3
    Freebie Checkout - Set Product More Than 1Variant Has Installment Kbank
    Freebie Checkout - Get Main Product 4Variant A
    Freebie Checkout - Get Free Product Status Active Content Approved Variant Status Inactive
    Freebie Checkout - Check Current Stock Main Product
    Freebie Checkout - Check Current Stock Free Product
    Freebie Checkout - Set Remaining Main Product    20
    Freebie Checkout - Set Remaining Free Product    20
    User Open Home page
    Freebie Checkout - Rebuild Stock More Than 1Variant
    Freebie Checkout - Set Freebie On Camp    2    1
    Freebie Checkout - Add Main Product has Style 2 Qty To Cart And Logout
    Freebie Checkout - User Login Check Item In Cart has Promotion Buy 2 Get 1
    User Click Next Process On Full Cart
    User Click First Member Address
    Checkout3 - Display Checkout Step3 Page
    User Click Payment Channel Installment Tab
    Checkout3 - Wait Loading
    Checkout3 - Installment payment and Submit    กสิกรไทย    @value='10'
    Freebie Checkout - Input Kbank Data On Kbank Payment Gateway
    Freebie Checkout - Display Freebie Order On Thankyou Page Success
    Thankyou - Count Normal Items as Expect Qty    2
    Thankyou - Count Freebie Items as Expect Qty    1
    Thankyou - Count All Items as Expect Qty    3
    Thankyou - Price of Freebie Item Is Zero    1
    Thankyou - Total Price of Freebie Item Is Zero    1
    Thankyou - Display Short description From Camp On Remark
    Freebie Checkout - Count Stock Hold Permanent    3
    Freebie Checkout - Check Remaining Main Product    18
    Freebie Checkout - Check Remaining Free Product    19
    [Teardown]    Run Keywords    Freebie Checkout - Restore Remaining And Promotion

TC_iTM_00610 : Free item can not be checkout when the free item is inactive but stock is not enough for freebie campaign and has product content status as "Approve"
    [Tags]    TC_iTM_00610    ready    set4
    Freebie Checkout - Set Product 1Variant
    Freebie Checkout - Get Main Product 1Variant A
    Freebie Checkout - Get Free Product Status Inactive Content Approve Variant Status Active
    Freebie Checkout - Check Current Stock Main Product
    Freebie Checkout - Check Current Stock Free Product
    Freebie Checkout - Set Remaining Main Product    20
    Freebie Checkout - Set Remaining Free Product    20
    User Open Home page
    Freebie Checkout - Rebuild Stock No Variant
    Freebie Checkout - Set Freebie On Camp    3    2
    Freebie Checkout - Add Main Product No Style 3 Qty To Cart And Logout
    User Open Home page
    Wait Until Ajax Loading Is Not Visible
    Login User to iTrueMart With User Freebie Checkout
    Click Cart Box Button
    Full Cart - Display Normal Product First Item 3 Qty
    Full Cart - Display Free Product First Item 2 Qty
    Full Cart - Display Camp Short Description
    User Click Next Process On Full Cart
    User Click First Member Address
    Freebie Checkout - Set Remaining Free Product    1
    Freebie Checkout - Step 3 User Enter Valid Data Master Card
    Checkout3 - Display Out Of Stock Page
    [Teardown]    Run Keywords    Freebie Checkout - Restore Remaining And Promotion

TC_iTM_00611 : Free item can be checkout when the freebie is in stock with status inactive and have product content status as "Publish"
    [Tags]    TC_iTM_00611    ready    set4
    Freebie Checkout - Set Product More Than 1Variant Allow COD
    Freebie Checkout - Get Main Product 4Variant A
    Freebie Checkout - Get Free Product Status Active Content Publish Variant Status Inactive
    Freebie Checkout - Check Current Stock Main Product
    Freebie Checkout - Check Current Stock Free Product
    Freebie Checkout - Set Remaining Main Product    20
    Freebie Checkout - Set Remaining Free Product    20
    User Open Home page
    Freebie Checkout - Rebuild Stock More Than 1Variant
    Freebie Checkout - Set Freebie On Camp    2    1
    Freebie Checkout - Add Main Product has Style 2 Qty To Cart And Logout
    Freebie Checkout - User Login Check Item In Cart has Promotion Buy 2 Get 1
    User Click Next Process On Full Cart
    User Click First Member Address
    Checkout3 - Display Checkout Step3 Page
    #    checkout_step3_keyword.User Click Payment Channel COD Tab
    Checkout3 - COD payment same address and Submit
    Freebie Checkout - Display Freebie Order On Thankyou Page Waiting
    Thankyou - Count Normal Items as Expect Qty    2
    Thankyou - Count Freebie Items as Expect Qty    1
    Thankyou - Count All Items as Expect Qty    3
    Thankyou - Price of Freebie Item Is Zero    1
    Thankyou - Total Price of Freebie Item Is Zero    1
    Thankyou - Display Short description From Camp On Remark
    Freebie Checkout - Count Stock Hold Permanent    3
    Freebie Checkout - Check Remaining Main Product    18
    Freebie Checkout - Check Remaining Free Product    19
    [Teardown]    Run Keywords    Freebie Checkout - Restore Remaining And Promotion

TC_iTM_00612 : Free item can not be checkout when the free item which out of stock is inactive, has product content status as "Publish" and primary item is not enough for freebie campaign
    [Tags]    TC_iTM_00612    ready    set4
    Freebie Checkout - Set Product More Than 1Variant Allow COD
    Freebie Checkout - Get Main Product 4Variant A
    Freebie Checkout - Get Free Product Status Inactive Content Publish Variant Status Active
    Freebie Checkout - Check Current Stock Main Product
    Freebie Checkout - Check Current Stock Free Product
    Freebie Checkout - Set Remaining Main Product    20
    Freebie Checkout - Set Remaining Free Product    20
    User Open Home page
    Freebie Checkout - Rebuild Stock More Than 1Variant
    Freebie Checkout - Set Freebie On Camp    3    2
    Freebie Checkout - Add Main Product has Style 3 Qty To Cart And Logout
    User Open Home page
    Wait Until Ajax Loading Is Not Visible
    Login User to iTrueMart With User Freebie Checkout
    Click Cart Box Button
    Full Cart - Display Normal Product First Item 3 Qty
    Full Cart - Display Free Product First Item 2 Qty
    Full Cart - Display Camp Short Description
    User Click Next Process On Full Cart
    User Click First Member Address
    Freebie Checkout - Set Remaining Free Product    0
    Checkout3 - Display Checkout Step3 Page
    Checkout3 - COD payment same address and Submit
    Checkout3 - Display Out Of Stock Page
    [Teardown]    Run Keywords    Freebie Checkout - Restore Remaining And Promotion

TC_iTM_00613 : Free item can be checkout when the freebie is in stock with status active and have product content status as "Draft"
    [Tags]    TC_iTM_00613    set4
    Freebie Checkout - Set Product More Than 1Variant Has Counter Service
    Freebie Checkout - Get Main Product 4Variant A
    Freebie Checkout - Get Free Product Status Active Content Draft Variant Status Active
    Freebie Checkout - Check Current Stock Main Product
    Freebie Checkout - Check Current Stock Free Product
    Freebie Checkout - Set Remaining Main Product    20
    Freebie Checkout - Set Remaining Free Product    20
    User Open Home page
    Freebie Checkout - Rebuild Stock More Than 1Variant
    Freebie Checkout - Set Freebie On Camp    2    1
    Freebie Checkout - Add Main Product has Style 2 Qty To Cart And Logout
    Freebie Checkout - User Login Check Item In Cart has Promotion Buy 2 Get 1
    User Click Next Process On Full Cart
    User Click First Member Address
    Checkout3 - Display Checkout Step3 Page
    Checkout3 - Counter Service payment and Submit
    Freebie Checkout - Display Freebie Order On Thankyou Page Waiting
    Thankyou - Count Normal Items as Expect Qty    2
    Thankyou - Count Freebie Items as Expect Qty    1
    Thankyou - Count All Items as Expect Qty    3
    Thankyou - Price of Freebie Item Is Zero    1
    Thankyou - Total Price of Freebie Item Is Zero    1
    Thankyou - Display Short description From Camp On Remark
    Freebie Checkout - Count Stock Hold Temporary    3
    Freebie Checkout - Check Remaining Main Product    18
    Freebie Checkout - Check Remaining Free Product    19
    Freebie Checkout - Check Order Freebie On PCMS    2    1
    [Teardown]    Run Keywords    Freebie Checkout - Restore Remaining And Promotion

TC_iTM_00614 : Free item can not be checkout when the free item is active and has product content status as "Draft" but primary item is not enough for freebie campaign
    [Tags]    TC_iTM_00614    set5
    Freebie Checkout - Set Product More Than 1Variant Has Counter Service
    Freebie Checkout - Get Main Product 4Variant A
    Freebie Checkout - Get Free Product Status Active Content Draft Variant Status Active
    Freebie Checkout - Check Current Stock Main Product
    Freebie Checkout - Check Current Stock Free Product
    Freebie Checkout - Set Remaining Main Product    20
    Freebie Checkout - Set Remaining Free Product    20
    User Open Home page
    Display Logo iTrueMart
    Freebie Checkout - Rebuild Stock More Than 1Variant
    Freebie Checkout - Set Freebie On Camp    3    2
    Freebie Checkout - Add Main Product has Style 3 Qty To Cart And Logout
    User Open Home page
    Display Logo iTrueMart
    Login User to iTrueMart With User Freebie Checkout
    Click Cart Box Button
    Full Cart - Display Normal Product First Item 3 Qty
    Full Cart - Display Free Product First Item 2 Qty
    Full Cart - Display Camp Short Description
    User Click Next Process On Full Cart
    User Click First Member Address
    Freebie Checkout - Set Remaining Main Product    2
    Checkout3 - Display Checkout Step3 Page
    Checkout3 - Counter Service payment and Submit
    Checkout3 - Display Out Of Stock Page
    [Teardown]    Run Keywords    Freebie Checkout - Restore Remaining And Promotion

TC_iTM_00615 : Free item can be checkout when the freebie is in stock with status active and have product content status as "Approve"
    [Tags]    TC_iTM_00615    ready    set5
    Freebie Checkout - Set Product More Than 1Variant
    Freebie Checkout - Get Main Product 4Variant A
    Freebie Checkout - Get Free Product Status Active Content Approved Variant Status Active
    Freebie Checkout - Check Current Stock Main Product
    Freebie Checkout - Check Current Stock Free Product
    Freebie Checkout - Set Remaining Main Product    20
    Freebie Checkout - Set Remaining Free Product    20
    User Open Home page
    Freebie Checkout - Rebuild Stock More Than 1Variant
    Freebie Checkout - Set Freebie On Camp    2    1
    User Open Home page
    Display Logo iTrueMart
    Login User to iTrueMart With User Freebie Checkout
    Clear Cart Current User
    Freebie Checkout - Go To Level D Main Product
    Freebie Checkout - Choose Style Option Main Product
    Level D - User Click Add To Cart Button
    Freebie Checkout - Go To Level D Main Product
    Freebie Checkout - Choose Style Option Main Product
    Level D - User Click Add To Cart Button
    Display Full Cart
    Logout Page - Go To Logout Page
    Freebie Checkout - User Login Check Item In Cart has Promotion Buy 2 Get 1
    User Click Next Process On Full Cart
    User Click First Member Address
    Freebie Checkout - Step 3 User Enter Valid Data Master Card
    # Display Cybersource Page
    # Confirm Action
    Freebie Checkout - Display Freebie Order On Thankyou Page Success
    Thankyou - Count Normal Items as Expect Qty    2
    Thankyou - Count Freebie Items as Expect Qty    1
    Thankyou - Count All Items as Expect Qty    3
    Thankyou - Price of Freebie Item Is Zero    1
    Thankyou - Total Price of Freebie Item Is Zero    1
    Thankyou - Display Short description From Camp On Remark
    Freebie Checkout - Check Order Freebie On PCMS    2    1
    Freebie Checkout - Count Stock Hold Permanent    3
    Freebie Checkout - Check Remaining Main Product    18
    Freebie Checkout - Check Remaining Free Product    19
    [Teardown]    Run Keywords    Freebie Checkout - Restore Remaining And Promotion

TC_iTM_00616 : Free item can not be checkout when the primary and free items are not enough for freebie campaign and free item has product content status as "Approve"
    [Tags]    TC_iTM_00616    ready    set5
    Freebie Checkout - Set Product More Than 1Variant
    Freebie Checkout - Get Main Product 4Variant A
    Freebie Checkout - Get Free Product Status Active Content Approved Variant Status Active
    Freebie Checkout - Check Current Stock Main Product
    Freebie Checkout - Check Current Stock Free Product
    Freebie Checkout - Set Remaining Main Product    20
    Freebie Checkout - Set Remaining Free Product    20
    User Open Home page
    Freebie Checkout - Rebuild Stock More Than 1Variant
    Freebie Checkout - Set Freebie On Camp    3    2
    User Open Home page
    Login User to iTrueMart With User Freebie Checkout
    Clear Cart Current User
    Freebie Checkout - Go To Level D Main Product
    Freebie Checkout - Choose Style Option Main Product
    Level D - User Click Add To Cart Button
    Freebie Checkout - Go To Level D Main Product
    Freebie Checkout - Choose Style Option Main Product
    Level D - User Click Add To Cart Button
    Freebie Checkout - Go To Level D Main Product
    Freebie Checkout - Choose Style Option Main Product
    Level D - User Click Add To Cart Button
    Display Full Cart
    Logout Page - Go To Logout Page
    User Open Home page
    Login User to iTrueMart With User Freebie Checkout
    Click Cart Box Button
    Full Cart - Display Normal Product First Item 3 Qty
    Full Cart - Display Free Product First Item 2 Qty
    Full Cart - Display Camp Short Description
    User Click Next Process On Full Cart
    User Click First Member Address
    Freebie Checkout - Set Remaining Main Product    1
    Checkout3 - Display Checkout Step3 Page
    Freebie Checkout - Step 3 User Enter Valid Data Master Card
    Checkout3 - Display Out Of Stock Page
    [Teardown]    Run Keywords    Freebie Checkout - Restore Remaining And Promotion

TC_iTM_00617 : Free item can be checkout when the freebie is in stock with status active and have product content status as "Publish"
    [Tags]    TC_iTM_00617    ready    set5
    Freebie Checkout - Set Product More Than 1Variant Has Installment Kbank
    Freebie Checkout - Get Main Product 4Variant A
    Freebie Checkout - Get Free Product Status Active Content Approved Variant Status Inactive
    Freebie Checkout - Check Current Stock Main Product
    Freebie Checkout - Check Current Stock Free Product
    Freebie Checkout - Set Remaining Main Product    20
    Freebie Checkout - Set Remaining Free Product    1
    User Open Home page
    Freebie Checkout - Rebuild Stock More Than 1Variant
    Freebie Checkout - Set Freebie On Camp    2    1
    Freebie Checkout - Add Main Product has Style 2 Qty To Cart And Logout
    Freebie Checkout - User Login Check Item In Cart has Promotion Buy 2 Get 1
    User Click Next Process On Full Cart
    User Click First Member Address
    Checkout3 - Display Checkout Step3 Page
    User Click Payment Channel Installment Tab
    Checkout3 - Wait Loading
    Checkout3 - Installment payment and Submit    กสิกรไทย    @value='10'
    Freebie Checkout - Input Kbank Data On Kbank Payment Gateway
    # Location Should Contain    kasikornbank
    # Sleep    10s
    # Confirm Action
    Freebie Checkout - Display Freebie Order On Thankyou Page Success
    Thankyou - Count Normal Items as Expect Qty    2
    Thankyou - Count Freebie Items as Expect Qty    1
    Thankyou - Count All Items as Expect Qty    3
    Thankyou - Price of Freebie Item Is Zero    1
    Thankyou - Total Price of Freebie Item Is Zero    1
    Thankyou - Display Short description From Camp On Remark
    Freebie Checkout - Count Stock Hold Permanent    3
    Freebie Checkout - Check Remaining Main Product    18
    Freebie Checkout - Check Remaining Free Product    0
    [Teardown]    Run Keywords    Freebie Checkout - Restore Remaining And Promotion

TC_iTM_00618 : Free item can not be checkout when the free item is active and has product content status as "Publish" but primary item is out of stock
    [Tags]    TC_iTM_00618    ready    set6
    Freebie Checkout - Set Product More Than 1Variant Has Installment Kbank
    Freebie Checkout - Get Main Product 4Variant A
    Freebie Checkout - Get Free Product Status Active Content Approved Variant Status Inactive
    Freebie Checkout - Check Current Stock Main Product
    Freebie Checkout - Check Current Stock Free Product
    Freebie Checkout - Set Remaining Main Product    20
    Freebie Checkout - Set Remaining Free Product    20
    User Open Home page
    Freebie Checkout - Rebuild Stock More Than 1Variant
    Freebie Checkout - Set Freebie On Camp    2    1
    Freebie Checkout - Add Main Product has Style 2 Qty To Cart And Logout
    Freebie Checkout - User Login Check Item In Cart has Promotion Buy 2 Get 1
    User Click Next Process On Full Cart
    User Click First Member Address
    Checkout3 - Display Checkout Step3 Page
    Freebie Checkout - Set Remaining Main Product    0
    User Click Payment Channel Installment Tab
    Checkout3 - Wait Loading
    Checkout3 - Installment payment and Submit    กสิกรไทย    @value='10'
    Checkout3 - Display Out Of Stock Page
    [Teardown]    Run Keywords    Freebie Checkout - Restore Remaining And Promotion

TC_iTM_00619 : Free item can not be checkout when the primary item is out of stock and the free item is active but stock is not enough for freebie campaign and has product content status as "Publish"
    [Tags]    TC_iTM_00619    ready    set6
    Freebie Checkout - Set Product More Than 1Variant Has Installment Kbank
    Freebie Checkout - Get Main Product 4Variant A
    Freebie Checkout - Get Free Product Status Active Content Publish Variant Status Active
    Freebie Checkout - Check Current Stock Main Product
    Freebie Checkout - Check Current Stock Free Product
    Freebie Checkout - Set Remaining Main Product    20
    Freebie Checkout - Set Remaining Free Product    20
    User Open Home page
    Freebie Checkout - Rebuild Stock More Than 1Variant
    Freebie Checkout - Set Freebie On Camp    3    2
    Freebie Checkout - Add Main Product has Style 3 Qty To Cart And Logout
    User Open Home page
    Login User to iTrueMart With User Freebie Checkout
    Sleep    10s
    Click Cart Box Button
    Sleep    10s
    Full Cart - Display Normal Product First Item 3 Qty
    Full Cart - Display Free Product First Item 2 Qty
    Full Cart - Display Camp Short Description
    User Click Next Process On Full Cart
    User Click First Member Address
    Checkout3 - Display Checkout Step3 Page
    Freebie Checkout - Set Remaining Main Product    0
    Freebie Checkout - Set Remaining Free Product    1
    Checkout3 - Installment payment and Submit    กสิกรไทย    @value='10'
    Checkout3 - Display Out Of Stock Page
    [Teardown]    Run Keywords    Freebie Checkout - Restore Remaining And Promotion

TC_iTM_00620 : Free item can not be checkout when the free item which out of stock is active and has product content status as "Publish"
    [Tags]    TC_iTM_00620    ready    set6
    Freebie Checkout - Set Product More Than 1Variant Has Installment Kbank
    Freebie Checkout - Get Main Product 4Variant A
    Freebie Checkout - Get Free Product Status Active Content Publish Variant Status Active
    Freebie Checkout - Check Current Stock Main Product
    Freebie Checkout - Check Current Stock Free Product
    Freebie Checkout - Set Remaining Main Product    20
    Freebie Checkout - Set Remaining Free Product    20
    User Open Home page
    Freebie Checkout - Rebuild Stock More Than 1Variant
    Freebie Checkout - Set Freebie On Camp    2    1
    Freebie Checkout - Add Main Product has Style 2 Qty To Cart And Logout
    Freebie Checkout - User Login Check Item In Cart has Promotion Buy 2 Get 1
    User Click Next Process On Full Cart
    User Click First Member Address
    Checkout3 - Display Checkout Step3 Page
    Freebie Checkout - Set Remaining Main Product    0
    Freebie Checkout - Set Remaining Free Product    0
    Checkout3 - Installment payment and Submit    กสิกรไทย    @value='10'
    Checkout3 - Display Out Of Stock Page
    [Teardown]    Run Keywords    Freebie Checkout - Restore Remaining And Promotion
