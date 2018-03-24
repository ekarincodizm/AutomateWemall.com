*** Settings ***
Test Teardown     Close All Browsers
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           OperatingSystem
Library           DateTime
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/TruemoveH/keywords_activate_sim_report.robot
Resource          ${CURDIR}/../../../Keyword/Database/PCMS/Truemove_h/keywords_truemove_h.robot

*** Variable ***
${name_itruemart}           iTruemart
${dealer_all}               all
${dealer_itruemart_id}      0
${dealer_seer_nitikit_id}   1

*** Test Cases ***
TC_ITMWM_07790 To verify search activate sim report when using multi criterias. (Case seer)
    [Tags]    TC_ITMWM_07790    regression    ready
    TruemoveH - Get Pcms Order By Dealer                ${dealer_seer_nitikit_id}
    ${set_merchant_cretaed_at}=              Convert To String   ${var_tmh_pcms_merchant_created_at}
    ${set_merchant_transaction_time}=        Convert To String   ${var_tmh_pcms_merchant_transaction_time}
    ${set_merchant_order_id}=                Convert To String   ${var_tmh_pcms_merchant_order_id}
    ${set_merchant_payment_status}=          Convert To String   ${var_tmh_pcms_merchant_payment_status}
    ${set_merchant_status}=                  Convert To String   ${var_tmh_pcms_merchant_status}
    ${set_merchant_item_status}=             Convert To String   ${var_tmh_pcms_merchant_item_status}
    ${set_merchant_activate_status}=         Convert To String   ${var_tmh_pcms_merchant_activate_status}
    ${set_merchant_item_id}=                 Convert To String   ${var_tmh_pcms_merchant_item_id}
    ${set_merchant_mobile_no}=               Convert To String   ${var_tmh_pcms_merchant_mobile_no}
    ${set_merchant_merchant_name}=           Convert To String   ${var_tmh_pcms_merchant_merchant_name}
    Activate Sim Report - Login PCMS                    ${PCMS_USERNAME}       ${PCMS_PASSWORD}
    Activate Sim Report - Go To TruemoveH Activate Sim Report
    Activate Sim Report - Default Value
    Activate Sim Report - Input Search By Order Date    ${set_merchant_cretaed_at}
    Activate Sim Report - Dropdown Search By Dealer     ${dealer_seer_nitikit_id}
    Activate Sim Report - Click Search Button
    Activate Sim Report - Check Data        ${set_merchant_order_id}   ${set_merchant_item_id}   ${set_merchant_mobile_no}   ${set_merchant_merchant_name}
    Activate Sim Report - Default Value
    Activate Sim Report - Input Search By Payment Date  ${set_merchant_transaction_time}
    Activate Sim Report - Dropdown Search By Dealer     ${dealer_seer_nitikit_id}
    Activate Sim Report - Click Search Button
    Activate Sim Report - Check Data        ${set_merchant_order_id}   ${set_merchant_item_id}   ${set_merchant_mobile_no}   ${set_merchant_merchant_name}
    Activate Sim Report - Default Value
    Activate Sim Report - Input Search By Order ID      ${set_merchant_order_id}
    Activate Sim Report - Dropdown Search By Dealer     ${dealer_seer_nitikit_id}
    Activate Sim Report - Click Search Button
    Activate Sim Report - Check Data        ${set_merchant_order_id}   ${set_merchant_item_id}   ${set_merchant_mobile_no}   ${set_merchant_merchant_name}
    Activate Sim Report - Default Value
    Activate Sim Report - Input Search By Order Date    ${set_merchant_cretaed_at}
    Activate Sim Report - Input Search By Payment Date  ${set_merchant_transaction_time}
    Activate Sim Report - Dropdown Search By Dealer     ${dealer_seer_nitikit_id}
    Activate Sim Report - Click Search Button
    Activate Sim Report - Check Data        ${set_merchant_order_id}   ${set_merchant_item_id}   ${set_merchant_mobile_no}   ${set_merchant_merchant_name}
    Activate Sim Report - Default Value
    Activate Sim Report - Input Search By Order Date    ${set_merchant_cretaed_at}
    Activate Sim Report - Select Value Dropdown         ${set_merchant_payment_status}   ${set_merchant_status}   ${set_merchant_item_status}   ${set_merchant_activate_status}   ${dealer_seer_nitikit_id}
    Activate Sim Report - Click Search Button
    Activate Sim Report - Check Data        ${set_merchant_order_id}   ${set_merchant_item_id}   ${set_merchant_mobile_no}   ${set_merchant_merchant_name}

TC_ITMWM_07796 To verify search activate sim report when using multi criterias. (Case iTruemart)
    [Tags]    TC_ITMWM_07796    regression    ready
    TruemoveH - Get Pcms Order By TruemoveH
    ${set_itruemart_cretaed_at}=              Convert To String   ${var_tmh_pcms_itruemart_created_at}
    ${set_itruemart_transaction_time}=        Convert To String   ${var_tmh_pcms_itruemart_transaction_time}
    ${set_itruemart_order_id}=                Convert To String   ${var_tmh_pcms_itruemart_order_id}
    ${set_itruemart_payment_status}=          Convert To String   ${var_tmh_pcms_itruemart_payment_status}
    ${set_itruemart_status}=                  Convert To String   ${var_tmh_pcms_itruemart_status}
    ${set_itruemart_item_status}=             Convert To String   ${var_tmh_pcms_itruemart_item_status}
    ${set_itruemart_activate_status}=         Convert To String   ${var_tmh_pcms_itruemart_activate_status}
    ${set_itruemart_item_id}=                 Convert To String   ${var_tmh_pcms_itruemart_item_id}
    ${set_itruemart_mobile_no}=               Convert To String   ${var_tmh_pcms_itruemart_mobile_no}
    Activate Sim Report - Login PCMS                    ${PCMS_USERNAME}       ${PCMS_PASSWORD}
    Activate Sim Report - Go To TruemoveH Activate Sim Report
    Activate Sim Report - Default Value
    Activate Sim Report - Input Search By Order Date    ${set_itruemart_cretaed_at}
    Activate Sim Report - Dropdown Search By Dealer     ${dealer_itruemart_id}
    Activate Sim Report - Click Search Button
    Activate Sim Report - Check Data        ${set_itruemart_order_id}   ${set_itruemart_item_id}   ${set_itruemart_mobile_no}   ${name_itruemart}
    Activate Sim Report - Default Value
    Activate Sim Report - Input Search By Payment Date  ${set_itruemart_transaction_time}
    Activate Sim Report - Dropdown Search By Dealer     ${dealer_itruemart_id}
    Activate Sim Report - Click Search Button
    Activate Sim Report - Check Data        ${set_itruemart_order_id}   ${set_itruemart_item_id}   ${set_itruemart_mobile_no}   ${name_itruemart}
    Activate Sim Report - Default Value
    Activate Sim Report - Input Search By Order ID      ${set_itruemart_order_id}
    Activate Sim Report - Dropdown Search By Dealer     ${dealer_itruemart_id}
    Activate Sim Report - Click Search Button
    Activate Sim Report - Check Data        ${set_itruemart_order_id}   ${set_itruemart_item_id}   ${set_itruemart_mobile_no}   ${name_itruemart}
    Activate Sim Report - Default Value
    Activate Sim Report - Input Search By Order Date    ${set_itruemart_cretaed_at}
    Activate Sim Report - Input Search By Payment Date  ${set_itruemart_transaction_time}
    Activate Sim Report - Dropdown Search By Dealer     ${dealer_itruemart_id}
    Activate Sim Report - Click Search Button
    Activate Sim Report - Check Data        ${set_itruemart_order_id}   ${set_itruemart_item_id}   ${set_itruemart_mobile_no}   ${name_itruemart}
    Activate Sim Report - Default Value
    Activate Sim Report - Input Search By Order Date    ${set_itruemart_cretaed_at}
    Activate Sim Report - Select Value Dropdown         ${set_itruemart_payment_status}   ${set_itruemart_status}   ${set_itruemart_item_status}   ${set_itruemart_activate_status}   ${dealer_itruemart_id}
    Activate Sim Report - Click Search Button
    Activate Sim Report - Check Data        ${set_itruemart_order_id}   ${set_itruemart_item_id}   ${set_itruemart_mobile_no}   ${name_itruemart}

TC_ITMWM_07797 To verify search activate sim report when using multi criterias. (Case all)
    [Tags]    TC_ITMWM_07797    regression    ready
    TruemoveH - Get Pcms Order By Dealer                ${dealer_seer_nitikit_id}
    ${set_merchant_cretaed_at}=              Convert To String   ${var_tmh_pcms_merchant_created_at}
    ${set_merchant_transaction_time}=        Convert To String   ${var_tmh_pcms_merchant_transaction_time}
    ${set_merchant_order_id}=                Convert To String   ${var_tmh_pcms_merchant_order_id}
    ${set_merchant_payment_status}=          Convert To String   ${var_tmh_pcms_merchant_payment_status}
    ${set_merchant_status}=                  Convert To String   ${var_tmh_pcms_merchant_status}
    ${set_merchant_item_status}=             Convert To String   ${var_tmh_pcms_merchant_item_status}
    ${set_merchant_activate_status}=         Convert To String   ${var_tmh_pcms_merchant_activate_status}
    ${set_merchant_item_id}=                 Convert To String   ${var_tmh_pcms_merchant_item_id}
    ${set_merchant_mobile_no}=               Convert To String   ${var_tmh_pcms_merchant_mobile_no}
    ${set_merchant_merchant_name}=           Convert To String   ${var_tmh_pcms_merchant_merchant_name}
    TruemoveH - Get Pcms Order By TruemoveH
    ${set_itruemart_cretaed_at}=              Convert To String   ${var_tmh_pcms_itruemart_created_at}
    ${set_itruemart_transaction_time}=        Convert To String   ${var_tmh_pcms_itruemart_transaction_time}
    ${set_itruemart_order_id}=                Convert To String   ${var_tmh_pcms_itruemart_order_id}
    ${set_itruemart_payment_status}=          Convert To String   ${var_tmh_pcms_itruemart_payment_status}
    ${set_itruemart_status}=                  Convert To String   ${var_tmh_pcms_itruemart_status}
    ${set_itruemart_item_status}=             Convert To String   ${var_tmh_pcms_itruemart_item_status}
    ${set_itruemart_activate_status}=         Convert To String   ${var_tmh_pcms_itruemart_activate_status}
    ${set_itruemart_item_id}=                 Convert To String   ${var_tmh_pcms_itruemart_item_id}
    ${set_itruemart_mobile_no}=               Convert To String   ${var_tmh_pcms_itruemart_mobile_no}
    Activate Sim Report - Login PCMS                    ${PCMS_USERNAME}       ${PCMS_PASSWORD}
    Activate Sim Report - Go To TruemoveH Activate Sim Report
    Activate Sim Report - Default Value
    Activate Sim Report - Input Search By Order Date    ${set_merchant_cretaed_at}
    Activate Sim Report - Dropdown Search By Dealer     ${dealer_all}
    Activate Sim Report - Click Search Button
    Activate Sim Report - Check Data        ${set_merchant_order_id}   ${set_merchant_item_id}   ${set_merchant_mobile_no}   ${set_merchant_merchant_name}
    Activate Sim Report - Default Value
    Activate Sim Report - Input Search By Order Date    ${set_itruemart_cretaed_at}
    Activate Sim Report - Dropdown Search By Dealer     ${dealer_all}
    Activate Sim Report - Click Search Button
    Activate Sim Report - Check Data        ${set_itruemart_order_id}   ${set_itruemart_item_id}   ${set_itruemart_mobile_no}   ${name_itruemart}
    Activate Sim Report - Default Value
    Activate Sim Report - Input Search By Payment Date  ${set_merchant_transaction_time}
    Activate Sim Report - Dropdown Search By Dealer     ${dealer_all}
    Activate Sim Report - Click Search Button
    Activate Sim Report - Check Data        ${set_merchant_order_id}   ${set_merchant_item_id}   ${set_merchant_mobile_no}   ${set_merchant_merchant_name}
    Activate Sim Report - Default Value
    Activate Sim Report - Input Search By Payment Date  ${set_itruemart_transaction_time}
    Activate Sim Report - Dropdown Search By Dealer     ${dealer_all}
    Activate Sim Report - Click Search Button
    Activate Sim Report - Check Data        ${set_itruemart_order_id}   ${set_itruemart_item_id}   ${set_itruemart_mobile_no}   ${name_itruemart}
    Activate Sim Report - Default Value
    Activate Sim Report - Input Search By Order ID      ${set_merchant_order_id}
    Activate Sim Report - Dropdown Search By Dealer     ${dealer_all}
    Activate Sim Report - Click Search Button
    Activate Sim Report - Check Data        ${set_merchant_order_id}   ${set_merchant_item_id}   ${set_merchant_mobile_no}   ${set_merchant_merchant_name}
    Activate Sim Report - Default Value
    Activate Sim Report - Input Search By Order ID      ${set_itruemart_order_id}
    Activate Sim Report - Dropdown Search By Dealer     ${dealer_all}
    Activate Sim Report - Click Search Button
    Activate Sim Report - Check Data        ${set_itruemart_order_id}   ${set_itruemart_item_id}   ${set_itruemart_mobile_no}   ${name_itruemart}
    Activate Sim Report - Default Value
    Activate Sim Report - Input Search By Order Date    ${set_merchant_cretaed_at}
    Activate Sim Report - Input Search By Payment Date  ${set_merchant_transaction_time}
    Activate Sim Report - Dropdown Search By Dealer     ${dealer_all}
    Activate Sim Report - Click Search Button
    Activate Sim Report - Check Data        ${set_merchant_order_id}   ${set_merchant_item_id}   ${set_merchant_mobile_no}   ${set_merchant_merchant_name}
    Activate Sim Report - Default Value
    Activate Sim Report - Input Search By Order Date    ${set_itruemart_cretaed_at}
    Activate Sim Report - Input Search By Payment Date  ${set_itruemart_transaction_time}
    Activate Sim Report - Dropdown Search By Dealer     ${dealer_all}
    Activate Sim Report - Click Search Button
    Activate Sim Report - Check Data        ${set_itruemart_order_id}   ${set_itruemart_item_id}   ${set_itruemart_mobile_no}   ${name_itruemart}
    Activate Sim Report - Default Value
    Activate Sim Report - Input Search By Order Date    ${set_merchant_cretaed_at}
    Activate Sim Report - Select Value Dropdown         ${set_merchant_payment_status}   ${set_merchant_status}   ${set_merchant_item_status}   ${set_merchant_activate_status}   ${dealer_all}
    Activate Sim Report - Click Search Button
    Activate Sim Report - Check Data        ${set_merchant_order_id}   ${set_merchant_item_id}   ${set_merchant_mobile_no}   ${set_merchant_merchant_name}
    Activate Sim Report - Default Value
    Activate Sim Report - Input Search By Order Date    ${set_itruemart_cretaed_at}
    Activate Sim Report - Select Value Dropdown         ${set_itruemart_payment_status}   ${set_itruemart_status}   ${set_itruemart_item_status}   ${set_itruemart_activate_status}   ${dealer_all}
    Activate Sim Report - Click Search Button
    Activate Sim Report - Check Data        ${set_itruemart_order_id}   ${set_itruemart_item_id}   ${set_itruemart_mobile_no}   ${name_itruemart}

