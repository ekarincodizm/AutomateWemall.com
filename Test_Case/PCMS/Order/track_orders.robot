*** Settings ***
Force Tags    WLS_Order
Test Teardown     Close All Browsers
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           OperatingSystem
Library           DateTime
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Features/Create_Product/Create_Product.robot
Resource          ${CURDIR}/../../../Keyword/Features/Create_Order/Create_order.txt
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Track_order/Keywords_TrackOrder.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Run_PCMS_order/Keywords_RunPCMSOrder.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Order_together/keywords_order_together.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Receipt/Keywords_Receipts.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Track Order/keywords_ApiTrackOrder.robot
Resource          ${CURDIR}/../../../Keyword/Features/Order/Keywords_Order_Tracking.robot
Library           ${CURDIR}/../../../Python_Library/order_tracking.py

*** Variables ***
${CHECKOUT_TIMEOUT}    20s
${Text_Email}      flash@test.com
${Text_Name}       Flash test
${Text_Phone}      0918888888
${Text_Address}    test merchant type
${product_name_retail}    Product For flash Test Automate retail5
${product_name_market}    Product For flash Test Automate merket place5

*** Test Cases ***
TC_iTM_02244 - Create Order Item merchant_type = reatil - Success
    [Tags]    order    ready    TC_iTM_02244    flash
    ${pkey}=    Insert products by name with retail type    ${product_name_retail}
    Log To Console    product pkey retail=${pkey}
    ${get_order_id}=    Guest buy product(pkey) success with CCW    ${pkey}
    Log To Console    order id=${get_order_id}

    ${order_shipment_items}=    Get order shipment items from DB    ${get_order_id}
    Check merchant type of order items    ${order_shipment_items[0][1]}    R

TC_iTM_02245 - Create Order Item merchant_type = market place - Success
    [Tags]    order    ready    TC_iTM_02245    flash
    ${pkey}=    Insert products by name with marketplace type    ${product_name_market}
    ${ProductURL}=    Set Variable    ${ITM_URL}/products/item-${pkey}.html
    Open Browser    ${ProductURL}    chrome
    Maximize Browser Window
    Level D - Increase Product Quantity
    Sleep    3s
    Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    Display Checkout Step1 Page
    Checkout1 - Input Email    ${Text_Email}
    Checkout1 - Click Next
    Checkout1 - Wait Loading
    Display Checkout Step2 Page
    Checkout2 - Input Name    ${Text_Name}
    Checkout2 - Input Phone    ${Text_Phone}
    Checkout2 - Select Province
    Checkout2 - Select District
    Checkout2 - Select SubDistrict
    Checkout2 - Select ZipCode
    Checkout2 - Input Address    ${Text_Address}
    Checkout2 - Click Next
    Checkout3 - Display Checkout Step3 Page
    User Click Payment Channel COD Tab
    Checkout3 - Wait Loading
    Checkout3 - Click Submit
    ThankYou - Close Popup
    Thankyou - Get Delivery Text
    ${get_order_id}=    Thankyou - Get order id
    Log To Console    order id=${get_order_id}
    Login Pcms
    TrackOrder - Go To Order Detail Page    ${get_order_id}
    ${order_shipment_items}=    Get order shipment items from DB    ${get_order_id}
    Check merchant type of order items    ${order_shipment_items[0][1]}    M
    Check merchant type of order items    ${order_shipment_items[1][1]}    M

TC_iTM_02246 - Create Order Item merchant_type = reatil and market place - Success
    [Tags]    regression    order    ready    TC_iTM_02246    flash
    ${pkey_R}=    Insert products by name with retail type    ${product_name_retail}
    Log To Console    product pkey retail=${pkey_R}
    ${pkey_M}=    Insert products by name with marketplace type    ${product_name_market}
    Log To Console    pkey market place=${pkey_M}
    ${get_order_id}=    Guest buy multiple-product(pkey) success with CCW    ${pkey_R}    ${pkey_M}

    ${order_shipment_items}=    Get order shipment items from DB    ${get_order_id}
    Check merchant type of order items    ${order_shipment_items[0][1]}    R
    Check merchant type of order items    ${order_shipment_items[1][1]}    M

TC_iTM_01941 Before COD update received date
    [Tags]    TC_iTM_01941    blackpanther
    Get COD Payment Default To Start
    Expect Receive Date Is Null

TC_iTM_01942 COD update received date
    [Tags]    TC_iTM_01942    blackpanther
    Get COD Payment Channel Item Status Is Shipped in Order
    ${date}=    Get Current Date    UTC     + 7 hours    exclude_millis=yes
    Log to console    ${Variable_Tracking_Number}
    Log to console    ${Variable_Token}
    API Receive Status    ${Variable_Tracking_Number}    ${Variable_Token}
    Get Check Tracking Number
    Expected Status    "success"
    Expected Code    "200"
    Expected Message    "Update tracking status is successfully."
    Expect Item Status is Delivered
    Expect Payment Status is Success
    Expect Received Date is Current Time    ${date}
    Expect Transaction Time is Current Time    ${date}
    Restore Transaction Time
    [Teardown]    Restore Receive Date and Item Status

TC_iTM_01943 COD update received date
    [Tags]    TC_iTM_01943    blackpanther
    Get COD Payment Channel Item Status Is Delivered in Order
    ${date}=    Get Current Date    UTC     + 7 hours    exclude_millis=yes

    Log to console    \n${Variable_Tracking_Number}
    Log to console    ${Variable_Token}
    API Receive Status    ${Variable_Tracking_Number}    ${Variable_Token}
    Get Check Tracking Number
    Expected Status    "success"
    Expected Code    "200"
    Expected Message    "Update tracking status is successfully."
    Expect Item Status is Delivered
    Expect Payment Status is Success
    Expect Received Date is Current Time    ${date}
    Restore Transaction Time
    [Teardown]    Restore Receive Date and Item Status

TC_iTM_01944 CCW update received date
    [Tags]    TC_iTM_01944    blackpanther
    Get CCW Payment Channel Item Status Is Shipped in Order
    Log to console    \n${Variable_Tracking_Number}
    Log to console    ${Variable_Token}
    API Receive Status    ${Variable_Tracking_Number}    ${Variable_Token}
    Get Check Tracking Number
    Expected Status    "success"
    Expected Code    "200"
    Expected Message    "Update tracking status is successfully."
    Expect Receive Date Is Null
    Restore Transaction Time
    [Teardown]    Restore Item status

TC_iTM_01945 Installment update received date
    [Tags]    TC_iTM_01945    blackpanther
    Get Installment Payment Channel Item Status Is Shipped in Order
    Log to console    \n${Variable_Tracking_Number}
    Log to console    ${Variable_Token}
    API Receive Status    ${Variable_Tracking_Number}    ${Variable_Token}
    Get Check Tracking Number
    Expected Status    "success"
    Expected Code    "200"
    Expected Message    "Update tracking status is successfully."
    Expect Receive Date Is Null
    Restore Transaction Time
    [Teardown]    Restore Item status

TC_iTM_01946 Counter service update received date
    [Tags]    TC_iTM_01946    blackpanther
    Get Counter Service Payment Channel Item Status Is Shipped in Order
    Log to console    \n${Variable_Tracking_Number}
    Log to console    ${Variable_Token}
    API Receive Status    ${Variable_Tracking_Number}    ${Variable_Token}
    Get Check Tracking Number
    Expected Status    "success"
    Expected Code    "200"
    Expected Message    "Update tracking status is successfully."
    Expect Receive Date Is Null
    Restore Transaction Time
    [Teardown]    Restore Item status

TC_iTM_01947 Installment update received date
    [Tags]    TC_iTM_01947    blackpanther
    Get Wallet Payment Channel Item Status Is Shipped in Order
    Log to console    \n${Variable_Tracking_Number}
    Log to console    ${Variable_Token}
    API Receive Status    ${Variable_Tracking_Number}    ${Variable_Token}
    Get Check Tracking Number
    Expected Status    "success"
    Expected Code    "200"
    Expected Message    "Update tracking status is successfully."
    Expect Receive Date Is Null
    Restore Transaction Time
    [Teardown]    Restore Item status

TC_iTM_01948 COD update received date
    [Tags]    TC_iTM_01948    blackpanther
    Log to console    \nITMROBOTTEST
    Log to console    9jskdenc83jdue7s2ynjdsd32
    API Receive Status    ITMROBOTTEST    9jskdenc83jdue7s2ynjdsd32
    Get Tracking Queue    ITMROBOTTEST
    Expected Status    "success"
    Expected Code    "200"
    Expected Message    "Update tracking status is successfully."
    Expected Tracking Number In Queue    ITMROBOTTEST
    [Teardown]    Restore Tracking Queue    ITMROBOTTEST

TC_iTM_01949 COD update received date
    [Tags]    TC_iTM_01949    blackpanther
    Log to console    \nITMROBOTTEST
    Log to console    9jskdenc83jdue7s2ynjdsd32
    API Receive Status    ITMROBOTTEST    9jskdenc83jdue7s2ynjdsd32
    Get Tracking Queue    ITMROBOTTEST
    Expected Status    "success"
    Expected Code    "200"
    Expected Message    "Update tracking status is successfully."
    Expected Tracking Number In Queue    ITMROBOTTEST
    [Teardown]    Restore Tracking Queue    ITMROBOTTEST

TC_iTM_01950 COD update received date
    [Tags]    TC_iTM_01950    blackpanther
    Log to console    \nITMROBOTTEST
    Log to console    9jskdenc83jdue7s2ynjdsd32
    API Receive Status    ITMROBOTTEST    9jskdenc83jdue7s2ynjdsd32
    Get Tracking Queue    ITMROBOTTEST
    Expected Status    "success"
    Expected Code    "200"
    Expected Message    "Update tracking status is successfully."
    Expected Tracking Number In Queue    ITMROBOTTEST
    [Teardown]    Restore Tracking Queue    ITMROBOTTEST

TC_iTM_01951 : "Token" and "tracking"no have in system
    [Tags]    TC_iTM_01951    Ready    Error
    API Receive Status    AAA0000    AAAAAAAAAAAAAAAAAAAAAA
    Expected Status    "error"
    Expected Code    "101"
    Expected Message    "Access Denied."

TC_iTM_01952 : "Tracking" more specifically
    [Tags]    TC_iTM_01952    Ready    Success
    API Receive Status    AAA00000000000000    9jskdenc83jdue7s2ynjdsd32
    Expected Status    "success"
    Expected Code    "200"
    Expected Message    "Update tracking status is successfully."

TC_iTM_01953 : "Tracking" less than specifically
    [Tags]    TC_iTM_01953    Ready    Success
    API Receive Status    AAA    9jskdenc83jdue7s2ynjdsd32
    Expected Status    "success"
    Expected Code    "200"
    Expected Message    "Update tracking status is successfully."

TC_iTM_01954 : "Tracking" input NULL
    [Tags]    TC_iTM_01954    Ready    Error
    API Receive Status    ${EMPTY}    9jskdenc83jdue7s2ynjdsd32
    Expected Status    "error"
    Expected Code    "100"
    Expected Message    "Required fields."
    Expected Data Tracking    "The tracking id field is required."

TC_iTM_01955 : No input token and tracking
    [Tags]    TC_iTM_01955    Ready    Error
    API Receive Status    ${EMPTY}    ${EMPTY}
    Expected Status    "error"
    Expected Code    "100"
    Expected Message    "Required fields."
    Expected Data Tracking    "The tracking id field is required."
    Expected Data Token    "The token field is required."

TC_iTM_01956 : No input token
    [Tags]    TC_iTM_01956    Ready    Error
    API Receive Status    ITM14779806    ${EMPTY}
    Expected Status    "error"
    Expected Code    "100"
    Expected Message    "Required fields."
    Expected Data Token    "The token field is required."

TC_iTM_01957 : "Token" no have in system
    [Tags]    TC_iTM_01957    Ready    Error
    API Receive Status    ITMMZ455    9jskdenc83jdue7s2ynjdsd323
    Expected Status    "error"
    Expected Code    "101"
    Expected Message    "Access Denied."

TC_iTM_01958 : "Token" no have in system
    [Tags]    TC_iTM_01958    Ready    Error
    ${date}=    Get Current Date    exclude_millis=yes
    Get COD Payment Channel Receive Date Is Not Null
    Log to console    \n${Variable_Tracking_Number}
    Log to console    ${Variable_Token}
    Log to console    ${Variable_Received_Date_Old}
    API Receive Status    ${Variable_Tracking_Number}    ${Variable_Token}
    Get Check Tracking Number
    Log to console    ${Variable_Received_Date}
    Expected Status    "success"
    Expected Code    "200"
    Expected Message    "Update tracking status is successfully."
    Expected Receive Date Not Update    ${date}
