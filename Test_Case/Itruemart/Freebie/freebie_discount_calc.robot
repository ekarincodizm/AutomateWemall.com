*** Settings ***
Suite Teardown    Selenium2Library.Close All Browsers
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           OperatingSystem
# Library           ExcelLibrary
Library           ${CURDIR}/../../../Python_Library/aimtest.py
Library           ${CURDIR}/../../../Python_Library/FileKeyword.py
Resource          ${CURDIR}/../../../Resource/Config/${env}/env_config.robot
Resource          ${CURDIR}/../../../Resource/Config/${env}/database.robot
Resource          ${CURDIR}/../../../Resource/TestData/${env}/test_data.robot
Resource          ${CURDIR}/../../../Resource/Config/stark/camps_libs_resources.robot
# Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource          ${CURDIR}/../../../Keyword/Features/Freebie/keywords_add_to_cart.robot
Resource          ${CURDIR}/../../../Keyword/Features/Freebie_Promotion/Create_Freebie.robot
Resource          ${CURDIR}/../../../Keyword/Features/Create_Order/Create_order.txt
Resource          ${CURDIR}/../../../Keyword/Features/PC1_And_PC3/PCMS.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Full_cart/keywords_full_cart.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_2/keywords_Checkout2.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_3/keywords_Checkout3.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Receipt/Keywords_Receipts.robot
# Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Run_PCMS_order/Keywords_RunPCMSOrder.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Order_together/keywords_order_together.robot
Resource          ${CURDIR}/../../../Keyword/API/FMS/FMS_ORDER.robot
Resource          ${CURDIR}/../../../Keyword/API/CAMP_API/keyword_camp.txt
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Order/keywords_order.robot
# Resource          ${CURDIR}/../../../TestData/CAMPS_test_data_variables.robot

*** Variables ***
${ITM_USERNAME}    starkautomate@gmail.com
${ITM_PASSWORD}    true1234!

*** Test Cases ***
TC_iTM02295 Discount should be calculated and distributed to bought products correctly when there is freebie product in cart
    [TAGS]    TC_iTM02295    ready
    ${epoch}=    Get current epoch time
    ${Text_CampaignName}    Set Variable    DISCOUNT_${epoch}
    ${Text_PromotionName}    Set Variable    DISCOUNT_${epoch}
    ${Text_PromotionCode}    Set Variable    KADEBOSSA
    ${Text_Detail}    Set Variable    KADEBOSSA
    ${Text_Note}    Set Variable    KADEBOSSA
    ${Text_SingleCode}    Set Variable    1
    ${Text_DiscountBath}    Set Variable    100
    ${Text_Prefix}    Set Variable    STARK

    # Step 1 - CAMPS : Create Freebie Promotions #
    Create Campaign and Create Promotion Freebie

    # Step 2 - PCMS : Create Discount Code promotion #
    ${discount_code}=    Create Campaign and promotion discount code    ${Text_CampaignName}    ${Text_Detail}    ${Text_Note}    ${Text_PromotionName}    ${Text_PromotionCode}    ${Text_DiscountBath}    ${Text_SingleCode}    ${Text_Prefix}

    # Step 3 - iTruemart : Create Order #
    ${order}=    Member Buy Product(s) on iTruemart with CCW payment    ${ITM_USERNAME}    ${ITM_PASSWORD}    ${discount_code}    @{PRODUCT-MATCH-FREEBIE}
    Log    ${order}

    # Step 4 - PCMS : Verify Order #
    ${order}=    Set Variable    ${order}
    @{order_shipment_item_ids}=    TrackOrder - Export Order as Excel and Get Order Shipment Ids    ${order}    ${Text_DiscountBath}

    # Step 5 - FMS : Update Order Status
    Update orders status from order pending to Pending shipment    ${order}    ${order_shipment_item_ids}

    # Step 6 - FMS : Verify pending outbound
    ${response}=    Order Should Be Valid On FMS Service    ${order}
    Log Json    ${response}

    # Step 7 - PCMS : Sync Order
    Open PCMS And Sync Order Together

    # Step 8 - PCMS : Verify order at receipt
    Go To Receipt Detail Page as PDF    ${order}
    [Teardown]    Run Keywords    Delete If Created Campaign and Close All Browsers    ${g_camp_id}
    ...    AND    Delete Campaign by campaign name    ${Text_CampaignName}

TC_xxxxx Discount should be calculated and distributed to bought products correctly when there is freebie product in cart
    [TAGS]    mini
    ${order}=    Member Buy Product(s) on iTruemart with CCW payment    ${ITM_USERNAME}    ${ITM_PASSWORD}    ${DISCOUNT_CODE}    @{PRODUCT-MATCH-FREEBIE}
    ${response}=    Order Should Be Valid On FMS Service    ${order}
    Log Json    ${response}
