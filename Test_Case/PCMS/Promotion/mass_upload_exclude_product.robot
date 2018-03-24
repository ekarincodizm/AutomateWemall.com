*** Settings ***
Force Tags    WLS_Promotion
Library           Selenium2Library
Library           String
Resource          ${CURDIR}/../../../Resource/init.robot
Library           ${CURDIR}/../../../Python_Library/promotion_code.py
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Promotion/keywords_prepare_promotion_code.robot


Suite Setup    Init Suite Setup For Testing Mass Upload Exclude Product
Suite Teardown    Teardown For Testing Mass Upload Exclude Product

*** Keywords ***
Init Suite Setup For Testing Mass Upload Exclude Product
    Promotion - Create Campaign    ${campaign_name}    No
    Go To Robot Campaign    ${campaign_name}
    Create Promotion    &{promotion_conditions}
    Click Back And Go To Manage Display Page
    Tick Display on Web Checkbox
    Click Save on Manage Display Page
    Click Mass Upload Exclude Product Button

Teardown For Testing Mass Upload Exclude Product
    promotion_code.Remove Campaign    ${campaign_name}    1
    Close All Browsers

*** Variables ***
${campaign_name}    ANTMAN ROBOT CAMPAIGN For Exclude Product Test

&{promotion_conditions}    name=single-limited-collection-percent
        ...    type=single_code    #  single_code / vip_code / multiple_code
        ...    promo_group=General
        ...    usetime=10
        ...    userlimit=limited    #  limited / unlimited
        ...    time_per_user=1
        ...    minimum=0
        ...    dc_type=percent    #  price / percent
        ...    dc_value=10
        ...    dc_maximum=30
        ...    dc_cart=following    #  cart / following
        ...    dc_on_follow_type=collection     # variant / product / brand / collection / bundle
        #...    dc_on_follow_value=AntmanCategory_ManageDisplay1
        ...    dc_on_follow_value=AntmanCategory_ManageDisplay
        ...    budget=PC1
        ...    card=${EMPTY}

@{exclude_one_product_pkey}=    2815819323555
@{exclude_product_pkey_list}=    2815819323555    2442372811637    2223953855373
@{exclude_active_product_pkey_list}=    2815819323555    2361622559278    2223953855373

*** Test Cases ***
TC_ITMWM_05290 To verify that the file is uploaded successfully when product pkeys match with the ones in PCMS regardless active/inactive/space at first and last/blank row.
    [Tags]    TC_ITMWM_05290    ITMA-3287   ready    regression    WLS_High
    Import Excluded Product - Imported Successfully
    Promotion - Expect Import Excluded Product Success
    Validate Excluded Products Data In Database    ${exclude_product_pkey_list}


TC_ITMWM_05291 To verify that the file is uploaded successfully regardless the name of column header
    [Tags]    TC_ITMWM_05291    ITMA-3287   ready    regression    WLS_Low
    Import Excluded Product - Imported Successfully And Change Column Header
    Promotion - Expect Import Excluded Product Success
    Validate Excluded Products Data In Database    ${exclude_one_product_pkey}

TC_ITMWM_05292 To verify that the file is not uploaded when file type is not CSV (.xlsx, .doc)
    [Tags]    TC_ITMWM_05292    ITMA-3287   ready    regression    WLS_High
    Import Excluded Product - Imported Fail - Excel File
    Promotion - Expect Import Excluded Product Fail File Type


TC_ITMWM_05293 To verify that the file is not uploaded when there is at least 1 invalid pkey.
    [Tags]    TC_ITMWM_05293    ITMA-3287   ready    regression    WLS_High
    Import Excluded Product - Imported Fail - Invalid Data
    Promotion - Expect Import Excluded Product Fail Invalid Data

#[MANUAL] TC_ITMWM_05294 To verify that mass upload exclude pkey template can be downloaded.

TC_ITMWM_05295 To verify that the file cannot be uploaded if no any product pkey in the file.
    [Tags]    TC_ITMWM_05295    ITMA-3287   ready    regression    WLS_Low
    Import Excluded Product - Imported Fail - Empty Data
    Promotion - Expect Import Excluded Product Fail Empty Data

#[MANUAL] TC_ITMWM_05296 To verify that there is loggly for 'mass upload display exclude' action.

TC_ITMWM_05297 To verify that uploading in the next time will overwrite the existing data.
    [Tags]    TC_ITMWM_05297    ITMA-3287   ready    regression    WLS_High
    Import Excluded Product - Imported Successfully With Active All Product
    Promotion - Expect Import Excluded Product Success

#[MANUAL] TC_ITMWM_05298 To verify that mass upload for excluding history can view in PHPMyAdmin


