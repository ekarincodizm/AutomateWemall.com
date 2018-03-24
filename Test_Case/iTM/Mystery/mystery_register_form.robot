*** Settings ***
Suite Teardown    Close All Browsers
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           OperatingSystem
Library           String
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Mystery/keywords_register_form.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Mystery/keywords_begins.robot
Resource          ${CURDIR}/../../../Keyword/Portal/iTrueMart/Mystery/keywords_error.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Mystery/keywords_prepare_data.robot
Resource          ${CURDIR}/../../../Keyword/Features/Mystery/keywords_register_form.robot

*** Test Cases ***
TC_iTM_03162 : Display register form page by pass from mystery landing page
    [Tags]  TC_iTM_03162   regression    ready    ITMMZ-1438    Support-2016S12  blackpanther
    Mystery Begins - [Web] Open Begins Page
    Mystery Begins - Click Next
    Mystery Data - Get Prediction List
    Mystery Register - Display All Prediction Item
    Mystery Register - Total Prediciton Item Active
    Mystery Register - Display Title Prediction
    Mystery Register - Display All Input
    Mystery Register - Display Term And Condition Link

TC_iTM_03163 : Display register form page by enter direct URL
    [Tags]  TC_iTM_03163   regression    ready    ITMMZ-1438    Support-2016S12  blackpanther
    Mystery Register - [Web] Open Register Form
    Mystery Data - Get Prediction List
    Mystery Register - Display All Prediction Item
    Mystery Register - Total Prediciton Item Active
    Mystery Register - Display Title Prediction
    Mystery Register - Display All Input
    Mystery Register - Display Term And Condition Link

TC_iTM_03165 : Error message for required field
    [Tags]  TC_iTM_03165    regression    ready    ITMMZ-1438    Support-2016S12  blackpanther
    Mystery Register - [Web] Open Register Form
    Mystery Register - Input All Except Prediction
    Mystery Register - Click Submit
    Mystery Register - Display Error Prediciton
    Reload Page
    Mystery Register - Input All Except First Name
    Mystery Register - Click Submit
    Mystery Register - Display Error First Name
    Reload Page
    Mystery Register - Input All Except Last Name
    Mystery Register - Click Submit
    Mystery Register - Display Error Last Name
    Reload Page
    Mystery Register - Input All Except Tel
    Mystery Register - Click Submit
    Mystery Register - Display Error Tel
    Reload Page
    Mystery Register - Input All Except Birth Date
    Mystery Register - Click Submit
    Mystery Register - Display Error Birth Date
    Reload Page
    Mystery Register - Input All Except Gender
    Mystery Register - Click Submit
    Mystery Register - Display Error Gender
    Reload Page
    Mystery Register - Input All Except Email
    Mystery Register - Click Submit
    Mystery Register - Display Error Email
    Reload Page
    Mystery Register - Input All Except Recaptcha
    Mystery Register - Click Submit
    Mystery Register - Display Error Recaptcha

TC_iTM_03166 : Validate the last name field
    [Tags]  TC_iTM_03166   regression    ready    ITMMZ-1438    Support-2016S12  blackpanther
    Mystery Register - [Web] Open Register Form
    Mystery Register - Validate First Name Fail          FirstName9
    Mystery Register - Validate First Name Fail          FirstName+

TC_iTM_03167 : Validate the last name field
    [Tags]  TC_iTM_03167        regression    ready    ITMMZ-1438    Support-2016S12  blackpanther
    Mystery Register - [Web] Open Register Form
    Mystery Register - Validate Last Name Fail          LastName9
    Mystery Register - Validate Last Name Fail          LastName+

TC_iTM_03168 : Validate the mobile number field
    [Tags]   TC_iTM_03168       regression    ready    ITMMZ-1438    Support-2016S12  blackpanther
    Mystery Register - [Web] Open Register Form
    Mystery Register - Validate Tel Fail            089691949a
    Mystery Register - Validate Tel Fail            +66896919492
    Mystery Register - Validate Tel Fail            08-9691-9492
    Mystery Register - Validate Tel Fail            '08 9691 9492'
    Mystery Register - Validate Tel Fail            01234567
    Mystery Register - Validate Tel Fail            666919492
    Mystery Register - Validate Tel Length          1234567890123456

TC_iTM_03169 : Validate the email field
    [Tags]   TC_iTM_03169       regression    ready    ITMMZ-1438    Support-2016S12  blackpanther
    Mystery Register - [Web] Open Register Form
    Mystery Register - Validate Email Fail          abcdefgh
    Mystery Register - Validate Email Fail          abcdefgh.abc
    Mystery Register - Validate Email Fail          abcdefgh@.
    Mystery Register - Validate Email Fail          abcdefgh@@.
    Mystery Register - Validate Email Fail          abcdefgh.aefaef@

TC_iTM_03170 : Display register form page by pass from mystery landing page
    [Tags]  TC_iTM_03170        regression    ready    ITMMZ-1438    Support-2016S12  blackpanther
    Mystery Register - [Web] Open Register Form
    Mystery Data - Get Prediction List
    Mystery Register - Display Tootip on Mouse Over Prediction Item

TC_iTM_03429 : Display error message if not have color lists in database
    [Tags]  TC_iTM_03429        regression    ready    ITMMZ-1438    Support-2016S12  blackpanther
    Mystery Data - Update Status Prediction to Inactive
    Mystery Register - [Web] Open Register Form
    Mystery Error - Display Error Page
    [Teardown]          Run Keywords            Mystery Data - Update Status Prediction to Active

TC_iTM_03466 : Display Term&Condition page in the new tab after click link (register form page)
    [Tags]  TC_iTM_03466        regression    ready    ITMMZ-1438    Support-2016S12  blackpanther
    Mystery Begins - [Web] Open Begins Page
    Mystery Begins - Click Next
    Mystery Register - Click Term And Condition
    Sleep                          10s
    Select Window                  url=http://support.wemall.com/?id=895505&title=%25e0%25b9%2580%25e0%25b8%2587%25e0%25b8%25ad%25e0%25b8%2599%25e0%25b9%2584%25e0%25b8%2582%25e0%25b8%2581%25e0%25b8%25b2%25e0%25b8%25a3%25e0%25b8%25a3%25e0%25b8%25a7%25e0%25b8%25a1%25e0%25b8%2581%25e0%25b8%2588%25e0%25b8%2581%25e0%25b8%25a3%25e0%25b8%25a3%25e0%25b8%25a1%252dThe%252dMystery%252dBegins%252d%25e0%25b8%2596%25e0%25b8%25ad%25e0%25b8%2594%25e0%25b8%25a3%25e0%25b8%25ab%25e0%25b8%25aa%252dSecret%252dCode%252d%25e0%25b8%25a3%25e0%25b8%259a%25e0%25b8%25a3%25e0%25b8%25b2%25e0%25b8%2587%25e0%25b8%25a7%25e0%25b8%25a5%25e0%25b8%25a1%25e0%25b8%25a5%25e0%25b8%2584%25e0%25b8%25b2%25e0%25b8%25a3%25e0%25b8%25a7%25e0%25b8%25a1%25e0%25b8%2581%25e0%25b8%25a7%25e0%25b8%25b2%252d300000%252d%25e0%25b8%259a%25e0%25b8%25b2%25e0%25b8%2597
