*** Settings ***
Force Tags    WLS_PCMS_Product
Library    Selenium2Library
Resource   ${CURDIR}/../../../Resource/init.robot
Resource   ${CURDIR}/../../../Resource/Config/api_gateway_endpoint.robot
Resource   ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource   ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Merchant_alias/keywords_alias.robot

Library    ${CURDIR}/../../../Python_Library/storefronts_library.py

Resource   ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot

Resource   ${CURDIR}/../../../Keyword/Database/PCMS/Alias/keywords_db_alias.robot
Resource   ${CURDIR}/../../../Keyword/Database/PCMS/Product/keywords_product.robot

Resource   ${CURDIR}/../../../Keyword/API/api_storefronts/storefront_keywords.robot

Resource   ${CURDIR}/../../../Keyword/Portal/PCMS/Product/Merchant_alias/keywords_mass_upload_product_merchant_alias.robot


*** Variables ***
${alias_name_a1}     Alias Name A1
${alias_name_a2}	 Alias Name A2
${alias_name_a3}	 Alias Name A3
${alias_name_a4}	 Alias Name A4

${alias_a1_nivea}    A1
${alias_aa12_canon}   A12
${alias_ba_360degree}   BA
${alias_bc_zb}    BC
${alias_1c_za}     1C
${alias_loreal_athome}   ลอรีอัล

${storefront_slug_alias}   slug-alias
${result_verify_success}       Mass upload completed. 4 row(s) processed.

*** Test Cases ***
TC_iTM_03110 Display data not found message at list alias page when no data alias
	[Tags]    TC_iTM_03110    Ready     regression
	Given Login Pcms
	And Merchant Alias - Go To Set Merchant Alias Page
	When Merchant Alias - Serach For Automated Test Alias    DUMMY-KEY-FOR-NOT-FOUND
	Then Merchant Alias - Should Be No matching records found
	[Teardown]    Run Keywords    Close All Browsers


TC_iTM_03111 Display alias list following search criteria
	[Tags]    TC_iTM_03111    Ready     regression
	Given Merchant Alias - Create Alias
	And Login Pcms
    And Merchant Alias - Go To Set Merchant Alias Page
    When Merchant Alias - Serach For Automated Test Alias
    Then Merchant Alias - Should Be Found Merchant Automated Test Alias

    [Teardown]    Run Keywords    Merchant Alias - Delete Alias
    ...           AND             Close All Browsers

TC_iTM_03112 Display default pagination 30 records per page
    [Tags]    TC_iTM_03112    Ready     regression

    Given Merchant Alias - Create 31 Automated Alias
    And Login Pcms
    And Merchant Alias - Go To Set Merchant Alias Page

    When Merchant Alias - Serach For Automated Test Alias

    Then Merchant Alias - Display 100 Elements In One Page
    And Merchant Alias - Page Should 31 Automated Test Elements

    [Teardown]    Run Keywords    Merchant Alias - Delete Alias
    ...           AND             Close All Browsers

TC_iTM_03113 Can delete alias merchant when click delete button
    [Tags]    TC_iTM_03113    Ready     regression
    Given Merchant Alias - Create Alias

    Given Login Pcms
    And Merchant Alias - Go To Set Merchant Alias Page
    And Merchant Alias - Serach For Automated Test Alias

    When Merchant Alias - Click Delete Alias
    Then Merchant Alias - Should Delete Alias Success

    [Teardown]    Run Keywords    Merchant Alias - Delete Alias
    ...           AND             Close All Browsers

TC_iTM_03114 Display error message when click save button without no input all fields
    [Tags]    TC_iTM_03114    Ready     regression

    Given Login Pcms
    And Merchant Alias - Go To Create Merchant Alias Page

    When Merchant Alias - User Click Save Button

    Then Merchant Alias - Page Should Contain Alias Merchant Name Is Required

    [Teardown]    Close All Browsers

TC_iTM_03115 Display success message and redirect to edit alias page
    [Tags]    TC_iTM_03115    Ready     regression

    Given Login Pcms
    And Merchant Alias - Go To Create Merchant Alias Page

    When Merchant Alias - User Enter Alias Name
    And Merchant Alias - User Click Save Button

    Then Merchant Alias - Edit Alias Page Is Opened
    And Merchant Alias - Should Create Merchant Success

    [Teardown]    Run Keywords    Merchant Alias - Delete Alias From Alias Name
    ...           AND             Close All Browsers

TC_iTM_03116 Display error message when no input alias name in edit form
    [Tags]    TC_iTM_03116    Ready     regression

    Given Merchant Alias - Create Alias

    Given Login Pcms
    And Merchant Alias - Go To Set Merchant Alias Page
    And Merchant Alias - Serach For Automated Test Alias
    And Merchant Alias - Click Edit Merchant Alias

    When Merchant Alias - Input Blank Text In Alias Merchant Name Input
    And Merchant Alias - User Click Save Button

    Then Merchant Alias - Page Should Contain Alias Merchant Name Is Required

    [Teardown]    Run Keywords    Merchant Alias - Delete Alias
    ...           AND             Close All Browsers

TC_iTM_03117 Display success message and stay to edit alias page if alias name is not blank
    [Tags]    TC_iTM_03117    Ready     regression

    Given Merchant Alias - Create Alias

    Given Login Pcms
    And Merchant Alias - Go To Set Merchant Alias Page
    And Merchant Alias - Serach For Automated Test Alias
    And Merchant Alias - Click Edit Merchant Alias
    And Merchant Alias - User Click Save Button

    Then Merchant Alias - Page Should Contain Upddate Success Message

    [Teardown]    Run Keywords    Merchant Alias - Delete Alias
    ...           AND             Close All Browsers

TC_iTM_03118 Can delete product is in alias
    [Tags]    TC_iTM_03118    Ready     regression

    Given Merchant Alias - Create Alias
    And Merchant Alias - Assign Product To Alias

    Given Login PCMS
    And Merchant Alias - Go To Set Merchant Alias Page
    And Merchant Alias - Serach For Automated Test Alias
    And Merchant Alias - Click Edit Merchant Alias

    When Merchant Alias - Delete Product From Alias

    Then Merchant Alias - Delete Action Should Succeed

    [Teardown]    Run Keywords    Merchant Alias - Delete Alias
    ...           AND             Close All Browsers


TC_iTM_03130 Sorting on alias list.
	[Tags]   TC_iTM_03130   alias_list   ready      regression

	Given Merchant Alias - Create Alias Data  ${alias_a1_nivea}   SORT00090
	and Sleep  1s
	and Merchant Alias - Create Alias Data    ${alias_aa12_canon}  SORT00091
	and Sleep  1s
	and Merchant Alias - Create Alias Data    ${alias_ba_360degree}   SORT00092
	and Sleep  1s
	and Merchant Alias - Create Alias Data    ${alias_bc_zb}         SORT00093
	and Sleep  1s
	and Merchant Alias - Create Alias Data    ${alias_1c_za}         SORT00094
	and Sleep  1s
	and Merchant Alias - Create Alias Data    ${alias_loreal_athome}   SORT00095

	When Login Pcms
	and Merchant Alias - Go To Set Merchant Alias Page
	and Merchant Alias - Serach For Automated Test Alias    SORT
	and Merchant Alias - User Click Sort By Id
	Then Merchant Alias - Id Is Displayed Arrow Ascending
	and Merchant Alias - Alias Name Is At First Row   ${alias_a1_nivea}
	and Merchant Alias - Alias Name Is At Second Row   ${alias_aa12_canon}
	and Merchant Alias - Alias Name Is At Third Row   ${alias_ba_360degree}
	and Merchant Alias - Alias Name Is At Fourth Row   ${alias_bc_zb}
	and Merchant Alias - Alias Name Is At Fifth Row   ${alias_1c_za}
	and Merchant Alias - Alias Name Is At Sixth Row   ${alias_loreal_athome}

	When Merchant Alias - User Click Sort By Id
	Then Merchant Alias - Id Is Displayed Arrow Descending
	and Merchant Alias - Alias Name Is At First Row   ${alias_loreal_athome}
	and Merchant Alias - Alias Name Is At Second Row  ${alias_1c_za}
	and Merchant Alias - Alias Name Is At Third Row   ${alias_bc_zb}
	and Merchant Alias - Alias Name Is At Fourth Row  ${alias_ba_360degree}
	and Merchant Alias - Alias Name Is At Fifth Row   ${alias_aa12_canon}
	and Merchant Alias - Alias Name Is At Sixth Row   ${alias_a1_nivea}

	When Merchant Alias - User Click Sort By Alias Name
	Then Merchant Alias - Alias Name Is Displayed Arrow Ascending
	and Merchant Alias - Alias Name Is At First Row   ${alias_1c_za}
	and Merchant Alias - Alias Name Is At Second Row   ${alias_a1_nivea}
	and Merchant Alias - Alias Name Is At Third Row   ${alias_aa12_canon}
	and Merchant Alias - Alias Name Is At Fourth Row   ${alias_ba_360degree}
	and Merchant Alias - Alias Name Is At Fifth Row   ${alias_bc_zb}
	and Merchant Alias - Alias Name Is At Sixth Row   ${alias_loreal_athome}

	When Merchant Alias - User Click Sort By Alias Name
	Then Merchant Alias - Alias Name Is Displayed Arrow Descending
	and Merchant Alias - Alias Name Is At First Row   ${alias_loreal_athome}
	and Merchant Alias - Alias Name Is At Second Row  ${alias_bc_zb}
	and Merchant Alias - Alias Name Is At Third Row   ${alias_ba_360degree}
	and Merchant Alias - Alias Name Is At Fourth Row  ${alias_aa12_canon}
	and Merchant Alias - Alias Name Is At Fifth Row   ${alias_a1_nivea}
	and Merchant Alias - Alias Name Is At Sixth Row   ${alias_1c_za}

	When Merchant Alias - User Click Sort By Merchant Code
	Then Merchant Alias - Merchant Code Is Displayed Arrow Ascending
	and Merchant Alias - Alias Name Is At First Row   ${alias_a1_nivea}
	and Merchant Alias - Alias Name Is At Second Row   ${alias_aa12_canon}
	and Merchant Alias - Alias Name Is At Third Row   ${alias_ba_360degree}
	and Merchant Alias - Alias Name Is At Fourth Row   ${alias_bc_zb}
	and Merchant Alias - Alias Name Is At Fifth Row   ${alias_1c_za}
	and Merchant Alias - Alias Name Is At Sixth Row   ${alias_loreal_athome}

	When Merchant Alias - User Click Sort By Merchant Code
	Then Merchant Alias - Merchant Code Is Displayed Arrow Descending
	and Merchant Alias - Alias Name Is At First Row   ${alias_loreal_athome}
	and Merchant Alias - Alias Name Is At Second Row  ${alias_1c_za}
	and Merchant Alias - Alias Name Is At Third Row   ${alias_bc_zb}
	and Merchant Alias - Alias Name Is At Fourth Row  ${alias_ba_360degree}
	and Merchant Alias - Alias Name Is At Fifth Row   ${alias_aa12_canon}
	and Merchant Alias - Alias Name Is At Sixth Row   ${alias_a1_nivea}

	When Merchant Alias - User Click Sort By Updated At
	Then Merchant Alias - Updated At Is Displayed Arrow Ascending
	and Merchant Alias - Alias Name Is At First Row   ${alias_a1_nivea}
	and Merchant Alias - Alias Name Is At Second Row   ${alias_aa12_canon}
	and Merchant Alias - Alias Name Is At Third Row   ${alias_ba_360degree}
	and Merchant Alias - Alias Name Is At Fourth Row   ${alias_bc_zb}
	and Merchant Alias - Alias Name Is At Fifth Row   ${alias_1c_za}
	and Merchant Alias - Alias Name Is At Sixth Row   ${alias_loreal_athome}

	When Merchant Alias - User Click Sort By Updated At
	Then Merchant Alias - Updated At Is Displayed Arrow Descending
	and Merchant Alias - Alias Name Is At First Row   ${alias_loreal_athome}
	and Merchant Alias - Alias Name Is At Second Row  ${alias_1c_za}
	and Merchant Alias - Alias Name Is At Third Row   ${alias_bc_zb}
	and Merchant Alias - Alias Name Is At Fourth Row  ${alias_ba_360degree}
	and Merchant Alias - Alias Name Is At Fifth Row   ${alias_aa12_canon}
	and Merchant Alias - Alias Name Is At Sixth Row   ${alias_a1_nivea}




	[Teardown]   Run Keywords   Merchant Alias - Delete Alias By Alias And Code   ${alias_a1_nivea}  SORT00090
	 ...   AND  Merchant Alias - Delete Alias By Alias And Code  ${alias_aa12_canon}  SORT00091
	 ...   AND  Merchant Alias - Delete Alias By Alias And Code   ${alias_ba_360degree}  SORT00092
	 ...   AND  Merchant Alias - Delete Alias By Alias And Code  ${alias_bc_zb}  SORT00093
	 ...   AND  Merchant Alias - Delete Alias By Alias And Code  ${alias_1c_za}  SORT00094
	 ...   AND  Merchant Alias - Delete Alias By Alias And Code  ${alias_loreal_athome}  SORT00095
	 ...   AND  Close All Browsers


TC_iTM_03219 End2End for alias creating using mass upload to display alias header on levelD
    [Tags]   TC_iTM_03219   end2end-1  end2end   QCT   ready       regression

    Given DB Product - Prepare Product To Excel

    # and Login Pcms
    # and Maximize Browser Window
    # and Merchant Alias - Go To Create Merchant Alias Page


    # When Merchant Alias - User Enter Alias Name
    # and Merchant Alias - User Click Save Button

    # When Merchant Alias - Edit Alias Page Is Opened
    # and Merchant Alias - Get ID From Edit Alias Page URL
    # and Merchant Alias - User Click Mass Upload
    # Then Merchant Alias - Mass Upload Page Is Opened

    # When Merchant Alias - User Choose File Upload
    # and Merchant Alias - Mass upload product result is displayed    ${result_verify_success}
    # and Merchant Alias - User click back to history page
    # and Merchant Alias - Go To Edit Alias Page
    # and Merchant Alias - Get Product Pkey From Product List In Alias
    # and Merchant Alias - Get Merchant Alias Code
    # and Storefront - Create Merchant Alias
    # Then Level D - Alias Merchant Header On Level D Is Displayed

    # [Teardown]    Run Keywords    Merchant Alias - Delete Alias From Alias Name
    # ...           AND             Close All Browsers

TC_iTM_03220 End2End for alias creating using deleteing mass upload not to display alias header on levelD
    [Tags]    TC_iTM_03220   end2end-2  end2end  QCT   ready    regression

    Given DB Product - Prepare Product To Excel

    and Login Pcms
    and Maximize Browser Window
    and Merchant Alias - Go To Create Merchant Alias Page


    When Merchant Alias - User Enter Alias Name
    and Merchant Alias - User Click Save Button

    When Merchant Alias - Edit Alias Page Is Opened
    and Merchant Alias - Get ID From Edit Alias Page URL
    and Merchant Alias - User Click Mass Upload
    Then Merchant Alias - Mass Upload Page Is Opened

    When Merchant Alias - User Choose File Upload
    and Merchant Alias - Go To Edit Alias Page
    and Merchant Alias - Get Product Pkey From Product List In Alias
    and Merchant Alias - Get Merchant Alias Code

    and Merchant Alias - User Click Mass Delete
    Then Merchant Alias - Mass Delete Page Is Opened

    When Merchant Alias - User Choose File Upload

    Given DB Product - Get Merchant Code From Product API

    Then Level D - Alias Merchant Header On Level D Is Not Displayed

    # [Teardown]    Run Keywords    Merchant Alias - Delete Alias From Alias Name
    # ...           AND             Close All Browsers

TC_iTM_03185 Go to List view when clicking 'Back to Alias Merchant List' button.
	[Tags]   TC_iTM_03185  list_view   merchant_alias   ready   regression
	Given Login Pcms
	and Merchant Alias - Go To Create Merchant Alias Page
	When Merchant Alias - User Enter Alias Name
    and Merchant Alias - User Click Save Button

    When Merchant Alias - Edit Alias Page Is Opened
    and Merchant Alias - User Click Back Button

    Then Merchant Alias - Alias List Page Is Opened

	[Teardown]   Run Keywords   Merchant Alias - Delete Merchant Alias And Product By Alias ID
	 ...    AND    Close All Browsers

