*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Library           HttpLibrary.HTTP
Library           DateTime
Library           Collections
Resource          ${CURDIR}/../../Resource/init.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Mnp_verify/keywords_verify.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Mnp_handset/keywords_handset.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Mnp_handset/web_element_mnp_handset.robot
Resource          ${CURDIR}/../../Keyword/Common/keywords_itruemart_common.robot
Library           ${CURDIR}/../../Python_Library/truemoveh_order_verify.py
Resource          ${CURDIR}/../../Keyword/Database/PCMS/Truemove_h/keywords_truemove_h.robot
Resource          ${CURDIR}/../../Keyword/Portal/CAMP/CAMP_Bundle/keywords_bundle.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Library           ${CURDIR}/../../Python_Library/mnp_util.py
Library           ${CURDIR}/../../Python_Library/order.py
Library           ${CURDIR}/../../Python_Library/product.py
Resource          ../../Resource/init.robot

*** Test Cases ***
Display active price plan on register step2 of MNP Sim (1 active)
    [Tags]    QCT
    Delete TruemoveH Order Verify By Mobile    0961415653
    Delete Order By Customer Email    robotautomate@gmail.com
    ${order_return}=    Create Order
    ${order_id}=    Get From Dictionary    ${order_return}    lastid
    Create MNP Truemoveh Order verify    ${order_id}
    Prepare TruemoveH Product MNP Device On PCMS One Priceplan
    ${device_discount_type}=    Set Variable    percent
    ${device_discount}=    Set Variable    40
    ${camp_data}=    Create Mnp Camp Promotion by Promotion data    ${var_tmh_product_device_inventory_id}    ${device_discount_type}    ${device_discount}    ${var_tmh_price_plan_code}
    ${campaign_id}=    Get From Dictionary    ${camp_data}    campaign_id
    ${token_data}=    Get From Dictionary    ${camp_data}    token-data
    LvD - Open Level D Page By Product Pkey    ${var_tmh_product_device_pkey}
    ${variants}=    get_option_pkey_by_variant    ${var_tmh_product_device_inventory_id}
    ${color_pkey}=    Get From List    ${variants}    0
    LvD - Click Style Option By Variant Pkey    ${variants}
    Log To Console    CloseBar
    LvD - Remove Chatbar
    LvD - Click Mnp Tab
    Click Element    id=mnp-device-btn-order
    ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${msisdn_input_box}
    Run Keyword If    '${status}' == '${True}'    Wait Until Element Is Visible    ${msisdn_input_box}
    Sleep    2s
    Input MNP2 Verify Form
    Wait Until Ajax Loading Is Not Visible
    User Click Link Next Operate
    Wait Until Ajax Loading Is Not Visible
    Display Handset Step1 Page
    ${total_price_plan_from_ui}=    Count Price Plans From Register MNP Page
    ${expect}=    Set Variable    1
    Should Be Equal    '${expect}'    '${total_price_plan_from_ui}'
    [Teardown]    Run Keywords    Delete TruemoveH Order Verify By Mobile    0961415653
    ...    AND    Delete Order By Order Id    ${order_id}
    ...    AND    Delete Campaign On Camp    ${token_data}    ${campaign_id}
    ...    AND    Delete TruemoveH Product On PCMS
    ...    AND    Close Browser

Show error message if no active price plan
    [Tags]    QCT
    Delete TruemoveH Order Verify By Mobile    0961415653
    Delete Order By Customer Email    robotautomate@gmail.com
    ${order_return}=    Create Order
    ${order_id}=    Get From Dictionary    ${order_return}    lastid
    Create MNP Truemoveh Order verify    ${order_id}
    Prepare TruemoveH Product MNP Device On PCMS One Priceplan
    ${device_discount_type}=    Set Variable    percent
    ${device_discount}=    Set Variable    40
    ${camp_data}=    Create Mnp Camp Promotion by Promotion data    ${var_tmh_product_device_inventory_id}    ${device_discount_type}    ${device_discount}    ${var_tmh_price_plan_code}
    ${campaign_id}=    Get From Dictionary    ${camp_data}    campaign_id
    ${token_data}=    Get From Dictionary    ${camp_data}    token-data
    LvD - Open Level D Page By Product Pkey    ${var_tmh_product_device_pkey}
    ${variants}=    get_option_pkey_by_variant    ${var_tmh_product_device_inventory_id}
    ${color_pkey}=    Get From List    ${variants}    0
    LvD - Click Style Option By Variant Pkey    ${variants}
    Log To Console    CloseBar
    LvD - Remove Chatbar
    LvD - Click Mnp Tab
    Click Element    id=mnp-device-btn-order
    ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    //input[@name="msisdn"]
    Run Keyword If    '${status}' == '${True}'    Wait Until Element Is Visible    //input[@name="msisdn"]
    Sleep    2s
    Input MNP2 Verify Form
    Wait Until Ajax Loading Is Not Visible
    User Click Link Next Operate
    Wait Until Ajax Loading Is Not Visible
    Display Handset Step1 Page
    LvD - Remove Chatbar
    Countinue To Next Page1
    LvD - Remove Chatbar
    Input MNP2 Register Form
    Countinue To Next Page2
    Accept Checkbox
    Update Priceplan Status    ${var_tmh_price_plan_id}
    Page Show Dialog Without Priceplan    # ...    # AND    Close Browser
    [Teardown]    Run Keywords    Delete TruemoveH Order Verify By Mobile    0961415653
    ...    AND    Delete Order By Order Id    ${order_id}
    ...    AND    Delete Campaign On Camp    ${token_data}    ${campaign_id}
    ...    AND    Delete TruemoveH Product On PCMS
    ...    AND    Close Browser
