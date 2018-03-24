*** Settings ***
Force Tags          WLS_Supernumber     WLS_High
Library             Selenium2Library
Library             HttpLibrary.HTTP
Library             Collections
Library             OperatingSystem
Library             DateTime
Resource            ${CURDIR}/../../Keyword/Common/Keywords_Common.robot
Resource            ${CURDIR}/../../Resource/init.robot
Library             ${CURDIR}/../../Python_Library/common.py
Resource            ${CURDIR}/../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource            ${CURDIR}/../../Keyword/Portal/PCMS/TruemoveH/keywords_super_number.robot
Resource            ${CURDIR}/../../Keyword/API/api_super_number/keyword_super_number_common.robot

*** Variable ***
${path_excel}       ${CURDIR}/../../Resource/TestData/SuperNumber
&{mobile_list}      Gold=0000000005    Silver=0000000006     Lucky=0000000007    Seer_nitikit=0000000008

*** Test Cases ***

TC_ITMWM_07527 To verify that after user import new mobile number for all number type on same excel file to PCMS, system will map data and insert to DB correctly.
    [Tags]      TC_ITMWM_07527    regression    ready

    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot
    Clear Prepared Proposition and Price Plan    ${unique_id}    ${unique_id}
    SuperNumber - Delete Data With Import Lot And Company Code    ${unique_id}
    Clear Imported Mobile Number    ${mobile_list}

    Prepare Proposition and Price Plan     ${unique_id}    ${unique_id}
    Create Truemoveh Excel import mobile    4    ${mobile_list}    ${unique_id}    mobile_import2.xlsx

    Login Pcms
    Truemoveh - Go To Import Mobile Number By Excel
    Upload Mobile Import Excel     mobile_import2.xlsx    ${unique_id}
    Upload Mobile Import Excel - Click Upload Button
    Upload Mobile Import Excel - Click Confirm Upload Button

    ${imported_proposition_id}=    get_proposition_by_nascode    ${unique_id}

    :for    ${mobile_type}    in    @{mobile_list}
    \    ${mobile_number}=    Get From Dictionary     ${mobile_list}    ${mobile_type}
    \    ${result}=    get_mobile_by_mobile_number    ${mobile_number}

    # get data
    \    ${import_lot}=            Get From Dictionary     ${result}   import_lot
    \    ${zone_id}=               Get From Dictionary     ${result}   zone_id
    \    ${mobile}=                Get From Dictionary     ${result}   mobile
    \    ${type_name}=             Get From Dictionary     ${result}   type_name
    \    ${pattern}=               Get From Dictionary     ${result}   pattern
    \    ${proposition_id}=        Get From Dictionary     ${result}   proposition_id
    \    ${amount}=                Get From Dictionary     ${result}   amount
    \    ${promotion}=             Get From Dictionary     ${result}   promotion
    \    ${expired_date}=          Get From Dictionary     ${result}   expired_date
    \    ${hold_expired_date}=     Get From Dictionary     ${result}   hold_expired_date
    \    ${customer_ref_id}=       Get From Dictionary     ${result}   customer_ref_id
    \    ${company_code}=          Get From Dictionary     ${result}   company_code
    \    ${bundle_type}=           Get From Dictionary     ${result}   bundle_type
    \    ${used}=                  Get From Dictionary     ${result}   used
    \    ${status}=                Get From Dictionary     ${result}   status
    \    ${status_activities}=     Get From Dictionary     ${result}   status_activities
    \    ${user_id}=               Get From Dictionary     ${result}   user_id

    # prepare data
    \    ${mobile_type}=        Convert To Lowercase	${mobile_type}
    \    ${type_name}=          Convert To Lowercase    ${type_name}
    \    ${total_amount}=       Sum mobile number       ${mobile_number}

    # verify data
    \    Should Be Equal As Strings     ${import_lot}           ${unique_id}
    \    Should Be Equal As Strings     ${zone_id}              1
    \    Should Be Equal As Strings     ${mobile}               ${mobile_number}
    \    Should Be Equal As Strings     ${type_name}            ${mobile_type}
    \    Run Keyword If    '${mobile_type}' == 'gold' or '${mobile_type}' == 'silver'    Should Be Equal As Strings     ${pattern}    XXYY
    \    Should Be Equal As Strings     ${proposition_id}       ${imported_proposition_id[0]}
    \    Should Be Equal As Strings     ${amount}               ${total_amount}
    \    Should Be Equal As Strings     ${promotion}            None
    \    Should Be Equal As Strings     ${expired_date}         2020-12-16 23:23:59
    \    Should Be Equal As Strings     ${hold_expired_date}    None
    \    Should Be Equal As Strings     ${customer_ref_id}      None
    \    Should Be Equal As Strings     ${company_code}         ROBOT
    \    Should Be Equal As Strings     ${bundle_type}          None
    \    Should Be Equal As Strings     ${used}                 N
    \    Should Be Equal As Strings     ${status}               Y
    \    Should Be Equal As Strings     ${status_activities}    None
    \    Should Be Equal As Strings     ${user_id}              35

    [Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_id}

TC_ITMWM_07532 To verify that system display value on mobile type dropdown list match with value on DB.
    [Tags]     TC_ITMWM_07532     regression    ready
    ${mobile_type_db}=    Get Mobile Type List From DB
    Login Pcms
    Truemoveh - Go To Mobile Report
    Verify Mobile Type Dropdown List With DB      ${mobile_type_db}


TC_ITMWM_07537 To verify that system display mobile type on PCMS match with mobile type on truemoveh_mobiles DB.
    [Tags]     TC_ITMWM_07537     regression    ready

    ${unique_id}=    SuperNumber - Prepare Data Get Import Lot
    Clear Prepared Proposition and Price Plan    ${unique_id}    ${unique_id}
    SuperNumber - Delete Data With Import Lot And Company Code    ${unique_id}
    Clear Imported Mobile Number    ${mobile_list}

    Prepare Proposition and Price Plan     ${unique_id}    ${unique_id}
    Create Truemoveh Excel import mobile    4    ${mobile_list}    ${unique_id}    mobile_import2.xlsx

    Login Pcms
    Truemoveh - Go To Import Mobile Number By Excel
    Upload Mobile Import Excel     mobile_import2.xlsx    ${unique_id}
    Upload Mobile Import Excel - Click Upload Button
    Upload Mobile Import Excel - Click Confirm Upload Button

    #Verify Mobile type in report
    Truemoveh - Go To Mobile Report
    Verify Mobile Type In Report     0000000005     Gold
    Verify Mobile Type In Report     0000000006     Silver
    Verify Mobile Type In Report     0000000007     Lucky
    Verify Mobile Type In Report     0000000008     Seer_nitikit

    [Teardown]    Clear Proposition and Price Plan and Mobile number    ${unique_id}
