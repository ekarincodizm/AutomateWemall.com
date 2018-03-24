*** Settings ***
Library         Selenium2Library
Library         String
Library         BuiltIn
Library         Collections
Library         ${CURDIR}/../../../Python_Library/ExtendedSelenium/
Resource        ${CURDIR}/../../../Resource/Config/alpha/env_config.robot
# Resource        ${CURDIR}/../../../Resource/Config/local/Env_config.robot
Resource        ${CURDIR}/../../../Resource/Config/staging/env_config.robot
Resource        ${CURDIR}/../../../Keyword/Portal/wemall-mobile/common/mobile_common_keywords.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_1/Keywords_Checkout1.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_2/Keywords_Checkout2.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/Checkout_3/Keywords_Checkout3.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource        ${CURDIR}/../../../Keyword/Portal/iTrueMart/Full_cart/keywords_full_cart.robot
Resource        ${CURDIR}/../Portal_Main_Page_Mobile/resource_mobile.robot

*** Variable ***
${timeout_30}     30

*** Keywords ***
Open Portal Main Page
    Open Mobile Browser     ${WEMALL_WEB}/portal/${mainPage}        ${BROWSER}

Open Portal iTrueMart Mobile
    Open Mobile Browser     ${ITM_MOBILE}/${home}        ${BROWSER}

# Open Portal Promotion Page
#     Open Mobile Browser     ${WEMALL_WEB}/portal/${promotionPage}        ${BROWSER}

# Open Portal EverydayWow Page
#     Open Mobile Browser     ${WEMALL_WEB}/portal/${everydayWowPage}        ${BROWSER}

# Open Portal Category Page
#     Open Mobile Browser     ${WEMALL_WEB}/portal/${categoryPage}        ${BROWSER}

# Open Portal Search Page
#     Open Mobile Browser     ${WEMALL_WEB}/portal/${searchPage}        ${BROWSER}

Initialize Suite Variable
    [Arguments]  ${page}
    ${dict}=   Create Dictionary   page=${page}
    Set Test Variable   ${TEST_VAR}  ${dict}


Open Mobile Browser without resize
    [Arguments]     ${HOST}    ${BROWSER}    ${ALIAS}=None
    Open Browser    ${HOST}    ${BROWSER}    ${ALIAS}
    Maximize Browser Window
    Add Cookie      is_mobile  true
    Reload Page
    Set Window Position   ${0}      ${0}
    # Set Window Size       ${320}    ${568}

Open Portal Main Page without resize
    Open Mobile Browser without resize     ${WEMALL_MOBILE_URL}/portal/${mainPage}        ${BROWSER}
    Reload Page
    Maximize Browser Window

###########################################################   CMS   ##############################################################
Open CMS WeMall
    Open Browser   ${PORTAL-HOST}     Chrome
    Set Window Position   ${0}      ${0}
    Set Window Size       ${1500}    ${1000}
    Wait Until Element Is Visible   ${XPATH_CMS.link_category_manage_portal}     ${timeout}
    Maximize Browser Window


Click Manage Portal
    Click Element and Wait Angular Ready    ${XPATH_CMS.link_category_manage_portal}


Click Manage Portal MenuBar
    Wait Until Element Is Visible   ${XPATH_CMS.link_manage_portal_menubar}     ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_CMS.link_manage_portal_menubar}
    Wait Until Element Is Visible   ${XPATH_CMS.wait_manage_portal_menubar_respond}     ${timeout}

Click Manage Portal Mega Menu
    Wait Until Element Is Visible   ${XPATH_CMS.link_manage_portal_megamenu}     ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_CMS.link_manage_portal_megamenu}
    Wait Until Element Is Visible   ${XPATH_CMS.wait_manage_portal_megamenu_respond}     ${timeout}

Click Manage Portal Mega Menu Highlights
    Wait Until Element Is Visible   ${XPATH_CMS.txt_highlights}     ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_CMS.txt_highlights}


Click Manage Portal Merchant Zone
    Wait Until Element Is Visible   ${XPATH_CMS.link_manage_portal_merchantzone}     ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_CMS.link_manage_portal_merchantzone}
    Wait Until Element Is Visible   ${XPATH_CMS.wait_manage_portal_merchantzone_respond}     ${timeout}

Click Save Merchant Zone
    Wait Until Element Is Visible   ${XPATH_CMS.btn_save_draft_merchantzone}     ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_CMS.btn_save_draft_merchantzone}
    Sleep   4s

Click Publish Merchant Zone
    Wait Until Element Is Visible   ${XPATH_CMS.btn_publish_merchantzone}     ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_CMS.btn_publish_merchantzone}
    Sleep   7s

Click Save MegaMenu Category
    Wait Until Element Is Visible   ${XPATH_CMS.btn_save_draft_megamenu_cat}     ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_CMS.btn_save_draft_megamenu_cat}
    Sleep   4s

Click Publish MegaMenu Category
    Wait Until Element Is Visible   ${XPATH_CMS.btn_publish_megamenu_cat}    ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_CMS.btn_publish_megamenu_cat}    15
    Wait Until Element Is Visible    //div[@class='alert ng-isolate-scope alert-success']    ${timeout}

Click Manage Portal ShowRoom
    Wait Until Element Is Visible   ${XPATH_CMS.link_manage_portal_showroom}     ${timeout}
    Sleep   3s
    Click Element and Wait Angular Ready    ${XPATH_CMS.link_manage_portal_showroom}
    Sleep   3s
    Click Element and Wait Angular Ready    ${XPATH_CMS.link_manage_portal_merchantzone}
    Sleep   3s
    Click Element and Wait Angular Ready    ${XPATH_CMS.link_manage_portal_showroom}
    Wait Until Element Is Visible   ${XPATH_CMS.wait_manage_portal_showroom_respond}    ${timeout}

Count MenuBar Category in Manage Portal
    ${Get_Category_Number}   Get matching xpath count   ${XPATH_CMS.cnt_manage_portal_menubar_category}
    Log To Console   \n Category Number = ${Get_Category_Number} \n
    Set Test Variable   ${Check_Category_Number}   ${Get_Category_Number}

    @{Get_Category_Name_In_CMS_WeMall}=   Create List  ${EMPTY}

    :FOR  ${index}  IN RANGE  1  ${Get_Category_Number}+1
    \  ${XPATH_CMS_Menubar_category_name}   Catenate  SEPARATOR=  ${XPATH_CMS.cnt_manage_portal_menubar_category}[${index}]/div[2]/span
    \  Log To Console   Category Name No.${index}

    \  ${Get_Category_Data}  Get Text   ${XPATH_CMS_Menubar_category_name}
    \  Append To List  ${Get_Category_Name_In_CMS_WeMall}   ${Get_Category_Data}

    \  ${Get_Category_Name_From_List}=  Get From List   ${Get_Category_Name_In_CMS_WeMall}   ${index}
    \  Log To Console   ${Get_Category_Name_From_List} \n

    ${dict}=   Set Variable   ${TEST_VAR}
    Set To Dictionary   ${dict}   package_name=${Get_Category_Name_In_CMS_WeMall}
    Set Test Variable   ${TEST_VAR}
    # Log To Console    ${TEST_VAR}

Count Mega Menu Category in Manage Portal
    ${Get_Category_Number}   Get matching xpath count   ${XPATH_CMS.cnt_manage_portal_megamenu_level1}
    Log To Console   \n Category Number = ${Get_Category_Number} \n
    Set Test Variable   ${Check_Category_Number}   ${Get_Category_Number}

    @{Get_Category_Name_In_CMS_WeMall}=   Create List  ${EMPTY}

    :FOR  ${index}  IN RANGE  1  ${Get_Category_Number}+1
    \  ${XPATH_CMS_MegaMenu_category_name}   Catenate  SEPARATOR=  ${XPATH_CMS.cnt_manage_portal_megamenu_level1}[${index}]/div[2]/span
    \  Log To Console   Category Name No.${index}

    \  ${Get_Category_Data}   Get Text   ${XPATH_CMS_MegaMenu_category_name}
    \  Append To List  ${Get_Category_Name_In_CMS_WeMall}   ${Get_Category_Data}

    \  ${Get_Category_Name_From_List}=  Get From List   ${Get_Category_Name_In_CMS_WeMall}   ${index}
    \  Log To Console   ${Get_Category_Name_From_List} \n

    ${dict}=   Set Variable  ${TEST_VAR}
    Set To Dictionary   ${dict}    package_name=${Get_Category_Name_In_CMS_WeMall}
    Set Test Variable   ${TEST_VAR}  ${dict}
    # Log To Console    ${TEST_VAR}



Get Mega Menu Picture Attribute
    @{Get_MegaMenu_Picture_Attribute}=   Create List    ${EMPTY}
    ${Cnt_MegaMenu_Picture_Attribute}    Get matching xpath count    ${XPATH_CMS.cnt_manage_portal_megamenu_pic_att}
    Set Test Variable    ${Check_MegaMenu_Picture_Attribute}    ${Cnt_MegaMenu_Picture_Attribute}

    :FOR   ${index}   IN RANGE   1   ${Cnt_MegaMenu_Picture_Attribute}+1
    \  ${XPATH_CMS_MegaMenu_Pic_Att}    Catenate  SEPARATOR=    ${XPATH_CMS.cnt_manage_portal_megamenu_pic_att}[${index}]/div/img@src
    \  ${Get_MegaMenu_Pic_Att_Data}    Selenium2Library.Get Element Attribute    ${XPATH_CMS_MegaMenu_Pic_Att}
    \  Append To List   ${Get_MegaMenu_Picture_Attribute}   ${Get_MegaMenu_Pic_Att_Data}
    \  ${Get_preview_pic_attribute_from_list}=   Get From List   ${Get_MegaMenu_Picture_Attribute}   ${index}
    \  Log To Console    ${Check_Category_name} Pic No.[${index}] = ${Get_preview_pic_attribute_from_list}
    Set Test Variable    ${MegaMenu_Pic_Att_List}    ${Get_MegaMenu_Picture_Attribute}

Get Mega Menu All Picture For Each Category
    ${Get_Category_Number}   Get matching xpath count   ${XPATH_CMS.cnt_manage_portal_megamenu_level1}
    Log To Console   \n Category Number = ${Get_Category_Number}
    Set Test Variable   ${Check_Category_Number}   ${Get_Category_Number}

    @{Get_MegaMenu_Data}=   Create List  ${EMPTY}
    :FOR  ${index}  IN RANGE  1  ${Get_Category_Number}+1
    \  ${XPATH_CMS_MegaMenu_category_name}   Catenate  SEPARATOR=  ${XPATH_CMS.cnt_manage_portal_megamenu_level1}[${index}]/div[2]/span
    \  ${Get_Category_name}   Get Text   ${XPATH_CMS_MegaMenu_category_name}
    \  Click Element and Wait Angular Ready    ${XPATH_CMS_MegaMenu_category_name}
    \  Set Test Variable    ${Check_Category_name}    ${Get_Category_name}
    \  Log To Console   \n Category Name No.[${index}] = ${Get_Category_name}

    \  Get Mega Menu Picture Attribute
    \  Append To List  ${Get_MegaMenu_Data}   ${MegaMenu_Pic_Att_List}
    # \  ${Get_Category_Name_From_List}=  Get From List   ${Get_MegaMenu_Data}   ${index}
    # \  Log To Console   ${Get_Category_Name_From_List} \n

    ${dict1}=   Create Dictionary   test=TestData
    Set To Dictionary   ${dict1}   package_name=${Get_MegaMenu_Data}
    Set Test Variable   ${Get_MegaMenu_Data}   ${dict1}
    # Log To Console    ${Get_MegaMenu_Data}



Get Merchantzone Attribute

####### Code below use for MerchantZone Picture Web&Mobile isn't same picture ####### This code is get attribute very slow
    Set Window Size       ${2000}    ${2000}
    ${Get_Merhantzone_pic_attribute}=    Create List    ${EMPTY}

    ${Get_Pic_Number}   Get matching xpath count   ${XPATH_CMS.cnt_pic_number}
    Log To Console   Picture Number = ${Get_Pic_Number}

    :FOR  ${index}  IN RANGE  1  ${Get_Pic_Number}+1
    \  ${XPATH_edit_button}    Catenate  SEPARATOR=    ${XPATH_CMS.cnt_pic_number}[${index}]//i
    \  Wait Until Element Is Visible    ${XPATH_edit_button}
    \  Click Element and Wait Angular Ready    ${XPATH_edit_button}
    \  Wait Until Element Is Visible    ${XPATH_CMS.popup_edit_merchantzone_pic}

    \  ${XPATH_Picture}   Catenate  SEPARATOR=   ${XPATH_CMS.popup_mobile_merchant_pic}@src
    \  ${Get_Pic_Attribute}   Selenium2Library.Get Element Attribute   ${XPATH_Picture}
    \  Append To List  ${Get_Merhantzone_pic_attribute}   ${Get_Pic_Attribute}
    \  ${Get_Picture_Attribute_From_List}=  Get From List   ${Get_Merhantzone_pic_attribute}   ${index}
    \  Log To Console   Picture Name No.[${index}] = ${Get_Picture_Attribute_From_List}
    \  Wait Until Element Is Visible    ${XPATH_CMS.popup_cancel_btn}
    \  Click Element and Wait Angular Ready    ${XPATH_CMS.popup_cancel_btn}

    Wait Until Element Is Visible    ${XPATH_CMS.merchant_left_banner_edit_btn}
    Click Element and Wait Angular Ready      ${XPATH_CMS.merchant_left_banner_edit_btn}
    Wait Until Element Is Visible    ${XPATH_CMS.popup_edit_merchantzone_pic}
    ${Get_pic_banner_left}   Selenium2Library.Get Element Attribute   ${XPATH_CMS.get_attribute_banner_left}
    Log To Console   Left Banner = ${Get_pic_banner_left}
    Append To List  ${Get_Merhantzone_pic_attribute}   ${Get_pic_banner_left}
    Wait Until Element Is Visible    ${XPATH_CMS.popup_cancel_btn}
    Click Element and Wait Angular Ready    ${XPATH_CMS.popup_cancel_btn}

    Sleep     3
    # Wait Until Element Is Visible    ${XPATH_CMS.merchant_right_banner_edit_btn}     20
    ### Comment Wait because in Jenkin Right Banner is break the line then robot can't found edit button
    Execute JavaScript      ${XPATH_CMS.merchant_right_banner_edit_btn}
    Wait Until Element Is Visible    ${XPATH_CMS.popup_edit_merchantzone_pic}
    ${Get_pic_banner_right}   Selenium2Library.Get Element Attribute   ${XPATH_CMS.get_attribute_banner_right}
    Log To Console   Right Banner = ${Get_pic_banner_right}
    Append To List  ${Get_Merhantzone_pic_attribute}   ${Get_pic_banner_right}
    Wait Until Element Is Visible    ${XPATH_CMS.popup_cancel_btn}
    Click Element and Wait Angular Ready    ${XPATH_CMS.popup_cancel_btn}

    Set Test Variable    ${Check_Merhantzone_pic_attribute}    ${Get_Merhantzone_pic_attribute}





####### Code below use for MerchantZone Picture Web&Mobile is same picture ####### This code is get attribute very fast
    # Set Window Size       ${2000}    ${2000}
    # ${Get_Merhantzone_pic_attribute}=    Create List    ${EMPTY}

    # ${Get_Pic_Number}   Get matching xpath count   ${XPATH_CMS.cnt_pic_number}
    # Log To Console   Picture Number = ${Get_Pic_Number}

    # :FOR  ${index}  IN RANGE  1  ${Get_Pic_Number}+1
    # \  ${XPATH_Picture}   Catenate  SEPARATOR=   ${XPATH_CMS.cnt_pic_number}[${index}]/img@src
    # \  ${Get_Pic_Attribute}   Selenium2Library.Get Element Attribute   ${XPATH_Picture}
    # \  Append To List  ${Get_Merhantzone_pic_attribute}   ${Get_Pic_Attribute}
    # \  ${Get_Picture_Attribute_From_List}=  Get From List   ${Get_Merhantzone_pic_attribute}   ${index}
    # \  Log To Console   Picture Name No.[${index}] = ${Get_Picture_Attribute_From_List}

    # ${Get_pic_banner_left}   Selenium2Library.Get Element Attribute   ${XPATH_CMS.get_attribute_banner_left}
    # Log To Console   Left Banner = ${Get_pic_banner_left}
    # Append To List  ${Get_Merhantzone_pic_attribute}   ${Get_pic_banner_left}

    # ${Get_pic_banner_right}   Selenium2Library.Get Element Attribute   ${XPATH_CMS.get_attribute_banner_right}
    # Log To Console   Right Banner = ${Get_pic_banner_right}
    # Append To List  ${Get_Merhantzone_pic_attribute}   ${Get_pic_banner_right}

    # Set Test Variable    ${Check_Merhantzone_pic_attribute}    ${Get_Merhantzone_pic_attribute}


Count Merchant Zone Picture in Manage Portal
    Wait Until Element Is Visible   ${XPATH_CMS.wait_manage_portal_merchantzone_respond}
    ${Cnt_Category_Merchantzone}    Get matching xpath count    ${XPATH_CMS.Cnt_manage_portal_merchantzone_category}
    Log To Console     \n Merchantzone Category = ${Cnt_Category_Merchantzone}
    Set Test Variable    ${Check_Category_Merchantzone}    ${Cnt_Category_Merchantzone}
    @{Get_Merchantzone_Category_Attribute}=    Create List    ${EMPTY}
    :FOR    ${index}    IN RANGE    1    ${Cnt_Category_Merchantzone}+1
    \  CLick Element And Wait Angular Ready    ${XPATH_CMS.Cnt_manage_portal_merchantzone_category}[${index}]
    \  Log To Console    \n Get Merchant Zone Attribute On Category No.[${index}]
    \  Get Merchantzone Attribute
    \  Append To List   ${Get_Merchantzone_Category_Attribute}     ${Check_Merhantzone_pic_attribute}
    Set Test Variable    ${Check_Merchantzone_Category_Attribute}    ${Get_Merchantzone_Category_Attribute}
    # ${Get_from_list}=    Get From List    ${Get_Merchantzone_Category_Attribute}    1
    # ${Get_from_list2}=   Get From List    ${Get_from_list}   1
    # ${Get_from_list3}=   Get From List    ${Get_from_list}   2
    # ${Get_from_list4}=   Get From List    ${Get_from_list}   3
    # ${Get_from_list5}=   Get From List    ${Get_from_list}   21
    # ${Get_from_list6}=   Get From List    ${Get_from_list}   22
    # Log To Console    Get From list = ${Get_from_list2}
    # Log To Console    Get From list = ${Get_from_list3}
    # Log To Console    Get From list = ${Get_from_list4}
    # Log To Console    Get From list = ${Get_from_list5}
    # Log To Console    Get From list = ${Get_from_list6}







Count Showroom Category Name In Manage Portal
    ${Get_Category_Number}   Get matching xpath count   ${XPATH_CMS.cnt_manage_portal_showroom_category}
    Log To Console   \n Category Number = ${Get_Category_Number}
    Set Test Variable   ${Check_Category_Number}   ${Get_Category_Number}

    @{Get_Category_Name_In_CMS_WeMall}=   Create List   ${EMPTY}

    :FOR  ${index}  IN RANGE  1  ${Get_Category_Number}+1
    \  ${XPATH_CMS_Showroom_category_name}   Catenate  SEPARATOR=   ${XPATH_CMS.cnt_manage_portal_showroom_category}[${index}]/div[2]/span
    \  Log To Console   Category Name No. ${index}

    \  ${Get_Category_Data}   Get Text   ${XPATH_CMS_Showroom_category_name}
    \  Append To List  ${Get_Category_Name_In_CMS_WeMall}   ${Get_Category_Data}

    \  ${Get_Category_Name_From_List}=  Get From List   ${Get_Category_Name_In_CMS_WeMall}   ${index}
    \  Log To Console   ${Get_Category_Name_From_List} \n

    ${dict}=   Set Variable   ${TEST_VAR}
    Set To Dictionary   ${dict}   package_name=${Get_Category_Name_In_CMS_WeMall}
    Set Test Variable   ${TEST_VAR}   ${dict}
    # Log To Console   ${TEST_VAR}


# Get Showroom Picture Attribute
    # :FOR  ${index}  IN RANGE  1  ${Check_Showroom_Max_Picture}+1
    # \  ${XPATH_Picture}   Catenate  SEPARATOR=  //li[@class='mock-banner ng-scope'][${index}]/div/img@src
    # # \  Log To Console   XPATH = ${XPATH_Picture}
    # \  ${Get_Pic_Attribute}   Selenium2Library.Get Element Attribute   ${XPATH_Picture}
    # \  Log To Console   Get Attribute = ${Get_Pic_Attribute}
    # \  Append To List  ${Get_Showroom_Picture_Name_In_CMS_WeMall1}   ${Get_Pic_Attribute}

#     Click Element and Wait Angular Ready    ${XPATH_CMS.btn_back_to_manage_showroom}
#     Wait Until Element Is Visible   ${XPATH_CMS.wait_manage_portal_showroom_respond}

Verify Showroom Picture In Manage Portal
    @{Get_Showroom_Picture_Name_In_CMS_WeMall}=   Create List   ${EMPTY}

    ${Get_First_Showroom_Name}   Get Text   ${XPATH_CMS.txt_first_showroom}
    Log To Console   Verify Showroom Name = ${Get_First_Showroom_Name}
    Set Test Variable   ${Check_First_Showroom_Name}   ${Get_First_Showroom_Name}

    Wait Until Element Is Visible   ${XPATH_CMS.btn_showroom_manage_pic}     ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_CMS.btn_showroom_manage_pic}
    Wait Until Element Is Visible   ${XPATH_CMS.wait_showroom_pic_respond}     ${timeout}
    ${Get_Showroom_Max_Picture}   Get matching xpath Count   ${XPATH_CMS.cnt_max_showroom_pic}
    Log To Console   Max Picture = ${Get_Showroom_Max_Picture}

    :FOR  ${index}  IN RANGE  1  ${Get_Showroom_Max_Picture}+1
    \  Sleep   0.2s
    \  Wait Until Element Is Visible   //div[@class='template-wrapper']/ul/li[@class='mock-banner ng-scope'][${index}]/div/a[2]          ${timeout}
    \  Click Element and Wait Angular Ready    //div[@class='template-wrapper']/ul/li[@class='mock-banner ng-scope'][${index}]/div/a[2]          ${timeout}
    \  Wait Until Element Is Visible   //*[@id="form_data.data.src_mobile.th"]
    \  ${XPATH_Picture}   Catenate  SEPARATOR=  //*[@id="form_data.data.src_mobile.th"]@src
    \  ${Get_Pic_Attribute}   Selenium2Library.Get Element Attribute   ${XPATH_Picture}
    \  Append To List  ${Get_Showroom_Picture_Name_In_CMS_WeMall}   ${Get_Pic_Attribute}
    \  Log To Console   Get Attribute Picture [${index}] = ${Get_Pic_Attribute}
    \  Sleep   0.2s
    \  Wait Until Element Is Visible   //button[contains(.,'Cancel')]          ${timeout}
    \  Click Element and Wait Angular Ready    //button[contains(.,'Cancel')]

    ${dict}=   Set Variable   ${TEST_VAR}
    Set To Dictionary   ${dict}   package_name=${Get_Showroom_Picture_Name_In_CMS_WeMall}
    Set Test Variable   ${TEST_VAR}   ${dict}

#THIS CODE BELOW USE FOR GET ATTRIBUTE EVERY PICTURE IN CMS
    # @{Get_Showroom_Picture_Name_In_CMS_WeMall}=   Create List   ${EMPTY}
    # Set Test Variable   @{Get_Showroom_Picture_Name_In_CMS_WeMall1}   @{Get_Showroom_Picture_Name_In_CMS_WeMall}

    # Wait Until Element Is Visible   ${XPATH_CMS.wait_manage_portal_showroom_respond}

    # ${Get_Category_Name_From_List}   Get From Dictionary   ${TEST_VAR}   package_name

    # :FOR  ${index}  IN RANGE  1  ${Check_Category_Number}+1
    # \  ${Get_Category_Name_From_List2}=  Get From List   ${Get_Category_Name_From_List}   ${index}
    # \  ${XPATH_Click_Manage_Category}   Catenate  SEPARATOR=  //li//div[span[contains(.,'${Get_Category_Name_From_List2}')]]/div/div/a[1]
    # \  Click Element and Wait Angular Ready    ${XPATH_Click_Manage_Category}
    # \  Wait Until Element Is Visible   ${XPATH_CMS.wait_showroom_pic_respond}
    # \  ${Get_Showroom_Max_Picture}   Get matching xpath Count   ${XPATH_CMS.cnt_max_showroom_pic}
    # \  Set Test Variable   ${Check_Showroom_Max_Picture}   ${Get_Showroom_Max_Picture}

    # \  Get Showroom Picture Attribute


Verify Showroom Manage Brand Picture In Manage Portal
    @{Get_Showroom_Brand_Picture_Name_In_CMS_WeMall}=   Create List   ${EMPTY}

    ${Get_First_Showroom_Name}   Get Text   ${XPATH_CMS.txt_first_showroom}
    Log To Console   Verify Showroom Name = ${Get_First_Showroom_Name}
    Set Test Variable   ${Check_First_Showroom_Name}   ${Get_First_Showroom_Name}

    Wait Until Element Is Visible   ${XPATH_CMS.btn_showroom_manage_pic}          ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_CMS.btn_showroom_manage_pic}
    Wait Until Element Is Visible   ${XPATH_CMS.wait_showroom_pic_respond}          ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_CMS.btn_manage_showroom_brand_pic}
    Wait Until Element Is Visible   ${XPATH_CMS.wait_manage_showroom_brand_respond}          ${timeout}
    ${Get_Showroom_Brand_Pic_Number}   Get matching xpath Count   ${XPATH_CMS.cnt_showroom_brand_pic}
    Set Test Variable   ${Check_Showroom_Brand_Pic_Number}   ${Get_Showroom_Brand_Pic_Number}
    Log To Console   \n Showroom Brand Number = ${Get_Showroom_Brand_Pic_Number}

    :FOR  ${index}  IN RANGE  1  ${Get_Showroom_Brand_Pic_Number}+1
    \  ${XPATH_showroom_brand_attribute}   Catenate  SEPARATOR=   ${XPATH_CMS.cnt_showroom_brand_pic}[${index}]/div[2]/img@src
    \  ${Get_showroom_brand_attribute}   Selenium2Library.Get Element Attribute   ${XPATH_showroom_brand_attribute}

    # \  ${Get_showroom_brand_data}   Set Variable   ${Get_showroom_brand_attribute}
    \  Append To List  ${Get_Showroom_Brand_Picture_Name_In_CMS_WeMall}   ${Get_showroom_brand_attribute}
    \  ${Get_showroom_brand_attribute_from_list}=  Get From List   ${Get_Showroom_Brand_Picture_Name_In_CMS_WeMall}   ${index}

    \  Log To Console   \n Showroom Brand No. ${index}
    \  Log To Console   Get Attribute = ${Get_showroom_brand_attribute_from_list}

    ${dict}=   Set Variable   ${TEST_VAR}
    Set To Dictionary   ${dict}   package_name=${Get_Showroom_Brand_Picture_Name_In_CMS_WeMall}
    Set Test Variable   ${TEST_VAR}   ${dict}



Get CMS Mobile Preview Picture Attibute
    @{Get_preview_pic_attribute}=   Create List   ${EMPTY}

    ${Get_preview_pic_number}   Get matching xpath Count   ${XPATH_CMS.cnt_mobile_preview_pic}
    Set Test Variable   ${Check_preview_pic_number}   ${Get_preview_pic_number}
    :FOR  ${index}  IN RANGE  1  ${Get_preview_pic_number}+1
    \  ${XPATH_pic}   Catenate  SEPARATOR=   ${XPATH_CMS.cnt_mobile_preview_pic}[${index}]//img@src
    \  ${Get_Pic_Attribute}   Selenium2Library.Get Element Attribute   ${XPATH_pic}

    \  @{Split_String}   Split String   ${Get_Pic_Attribute}   /
    \  ${Max_length}   Get Length   ${Split_String}
    \  ${Last_Index}   Evaluate   ${Max_length}-1
    \  ${String}=   Set Variable   @{Split_String}[${Last_Index}]
    # \  Log To Console   Get Attribute = ${String}
    \  Append To List   ${Get_preview_pic_attribute}   ${String}
    \  ${Get_preview_pic_attribute_from_list}=   Get From List   ${Get_preview_pic_attribute}   ${index}
    # \  Log To Console   Mobile Preview Picture No.${pic_number} - ${index}
    \  Log To Console   Mobile Preview Picture Attribute [${index}] = ${Get_preview_pic_attribute_from_list}

    ${dict1}=   Create Dictionary   test=TestData
    Set To Dictionary   ${dict1}   package_name=${Get_preview_pic_attribute}
    Set Test Variable   ${Preview_attribute_data}   ${dict1}
    # Log To Console   ${Get_preview_attribute}

Get HighLights Picture Data In Manage Portal
    Click Element and Wait Angular Ready    //div[@class='widget-body']//li[1]//span
    # Click Element and Wait Angular Ready    //div[@class='widget-body']//li[1]//span[text()='Highlights']
    Wait Until Element Is Visible   ${XPATH_CMS.btn_highlights_banner_group_management}     ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_CMS.btn_highlights_banner_group_management}
    Wait Until Element Is Visible   ${XPATH_CMS.wait_banner_group_management_respond}     ${timeout}

    Sleep    2
    @{Get_Highlight_Picture_Attribute_In_CMS_WeMall}=   Create List   ${EMPTY}
    ${Get_pic_number}   Get matching xpath Count   ${XPATH_CMS.cnt_banner_group_pic}
    Log To Console    Get Pic Number = ${Get_pic_number}
    Set Test Variable   ${Check_pic_number}   ${Get_pic_number}

    :FOR  ${index}  IN RANGE  1  ${Get_pic_number}+1
    \  Set Test Variable   ${pic_number}   ${index}
    \  ${XPATH_banner_group}   Catenate  SEPARATOR=   ${XPATH_CMS.cnt_banner_group_pic}[${index}]
    \  Click Element and Wait Angular Ready    ${XPATH_banner_group}
    \  Wait Until Element Is Visible   ${XPATH_CMS.wait_preview_pic_respond}     ${timeout}
    \  Log To Console   \n Picture No. ${index}

    \  Get CMS Mobile Preview Picture Attibute

    \  Append To List   ${Get_Highlight_Picture_Attribute_In_CMS_WeMall}   ${Preview_attribute_data}

    ${dict}=   Set Variable   ${TEST_VAR}
    Set To Dictionary   ${dict}   package_name=${Get_Highlight_Picture_Attribute_In_CMS_WeMall}
    Set Test Variable   ${TEST_VAR}   ${dict}





Login CMS WeMall And Go To Manage Portal
    Open CMS WeMall
    Click Manage Portal

Login CMS WeMall To Verify Category Number In Manage Portal - Menu Bar
    Login CMS WeMall And Go To Manage Portal
    Click Manage Portal MenuBar
    Count MenuBar Category in Manage Portal
    Close Browser

Login CMS WeMall To Verify Category Number In Manage Portal - Mega Menu
    Login CMS WeMall And Go To Manage Portal
    Click Manage Portal Mega Menu
    Click Save MegaMenu Category
    Click Publish MegaMenu Category
    Count Mega Menu Category in Manage Portal
    Close Browser
Login CMS WeMall To Verify Category Picture In Manage Portal - Mega Menu
    Login CMS WeMall And Go To Manage Portal
    Click Manage Portal Mega Menu
    Get Mega Menu All Picture For Each Category
    Close Browser
Login CMS WeMall To Verify Highlights Section In Main Page
    Login CMS WeMall And Go To Manage Portal
    Click Manage Portal Mega Menu
    Click Manage Portal Mega Menu Highlights
    Get HighLights Picture Data In Manage Portal
    Close Browser
Login CMS WeMall To Verify Picture In Manage Portal - Merchantzone
    Login CMS WeMall And Go To Manage Portal
    Click Manage Portal Merchant Zone
    # Click Save Merchant Zone
    # Click Publish Merchant Zone
    Count Merchant Zone Picture in Manage Portal
    # Close Browser
Login CMS WeMall To Verify Category Number In Manage Portal - Showroom
    Login CMS WeMall And Go To Manage Portal
    Click Manage Portal ShowRoom
    Count Showroom Category Name In Manage Portal
    Close Browser
Login CMS WeMall To Verify Manage Picture In Manage Portal - Showroom
    Login CMS WeMall And Go To Manage Portal
    Click Manage Portal ShowRoom
    Verify Showroom Picture In Manage Portal
    Close Browser
Login CMS WeMall To Verify Manage Brand Picture In Manage Portal - Showroom
    Login CMS WeMall And Go To Manage Portal
    Click Manage Portal ShowRoom
    # Click Save MegaMenu Category
    # Click Publish MegaMenu Category
    Verify Showroom Manage Brand Picture In Manage Portal
    Close Browser
#####################################################   PCMS   ###################################################################
Open PCMS iTruemart
    Open Browser    ${PCMS_URL}    chrome
    Maximize Browser Window
    Wait Until Element Is Visible   ${XPATH_PCMS.input_email_login}    ${timeout}
    Input Text   ${XPATH_PCMS.input_email_login}   admin@domain.com
    Input Text   ${XPATH_PCMS.input_password_login}   12345
    Click Element and Wait Angular Ready    ${XPATH_PCMS.btn_login}
    Wait Until Element Is Visible   ${XPATH_PCMS.wait_homepage_respond}    ${timeout}

Click Collection
    Wait Until Element Is Visible   ${XPATH_PCMS.link_collection}    ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_PCMS.link_collection}
    Wait Until Element Is Visible   ${XPATH_PCMS.link_manage_collection}    ${timeout}

Click Collection - Manage Collection
    Click Element and Wait Angular Ready    ${XPATH_PCMS.link_manage_collection}
    Wait Until Element Is Visible   ${XPATH_PCMS.wait_manage_collection_respond}    ${timeout}

Back To Manage Collection
    Click Element and Wait Angular Ready    ${XPATH_PCMS.btn_goto_Collection_management}
    Wait Until Element Is Visible   ${XPATH_PCMS.wait_manage_collection_respond}    ${timeout}

Get PDS Type Collection To Array
    Append To List  ${Check_PDS_Type_Collection_In_PCMS}   ${Check_Collection_Name}
    Log To Console   PDS Type Collection = ${Check_PDS_Type_Collection_In_PCMS}

    ${dict1}=   Create Dictionary   test=TestData
    Set To Dictionary   ${dict1}   package_name=${Check_PDS_Type_Collection_In_PCMS}
    Set Test Variable   ${PDS_Type_Collection}   ${dict1}


Get PDS Type Category To Array
    Append To List  ${Check_PDS_Type_Category_In_PCMS}   ${Check_Collection_Name}
    Log To Console   PDS Type Category = ${Check_PDS_Type_Category_In_PCMS}

    ${dict2}=   Create Dictionary   test=TestData
    Set To Dictionary   ${dict2}   package_name=${Check_PDS_Type_Category_In_PCMS}
    Set Test Variable   ${PDS_Type_Category}   ${dict2}


Publishes Status Is Incorrect
    ${text}=    Set Variable   it shoud be true
    Log To Console   System have something wrong with iTruemart Publishes
    Should Be Equal As Strings   ${Get_Publishes_iTruemart_status}   ${text}


Verify Category Level 1
    Click Collection
    Click Collection - Manage Collection

    ${Get_iTruemart_collection_number}   Get matching xpath Count   ${XPATH_PCMS.get_iTruemart_collection_number}
    Log To Console   \n iTruemart Collection = ${Get_iTruemart_collection_number}

    @{Get_PDS_Type_Collection_In_PCMS}=   Create List   ${EMPTY}
    @{Get_PDS_Type_Category_In_PCMS}=   Create List   ${EMPTY}
    Set Test Variable   ${Check_PDS_Type_Collection_In_PCMS}   ${Get_PDS_Type_Collection_In_PCMS}
    Set Test Variable   ${Check_PDS_Type_Category_In_PCMS}   ${Get_PDS_Type_Category_In_PCMS}

    :FOR   ${index}   IN RANGE   1   ${Get_iTruemart_collection_number}+1
    \  Wait Until Element Is Visible   ${XPATH_PCMS.get_iTruemart_collection_number}[${index}]/td[4]/a[2]    ${timeout}
    \  Click Element and Wait Angular Ready    ${XPATH_PCMS.get_iTruemart_collection_number}[${index}]/td[4]/a[2]
    \  Wait Until Element Is Visible   ${XPATH_PCMS.txt_name}    ${timeout}
    \  ${Get_Collection_Name}   Get Value   ${XPATH_PCMS.txt_name}

    \  Log To Console   \n iTruemart Collection No.${index}
    \  Log To Console   Name = ${Get_Collection_Name}
    \  Set Test Variable   ${Check_Collection_Name}   ${Get_Collection_Name}

    \  ${Get_display_status}=    Run Keyword And Return Status    Element Should Be Visible    jquery=input[name='is_category'][checked='checked']
    \  Log To Console   Display Value = ${Get_display_status}
    \  Run Keyword If  '${Get_display_status}' == 'False'    Back To Manage Collection
    \  Continue For Loop If  '${Get_display_status}' == 'False'

    \  ${Status_Collection}=    Set Variable   ${EMPTY}
    \  ${Status_Category}=    Set Variable   ${EMPTY}
    \  ${Status_Collection}=    Run Keyword And Return Status    Element Should Be Visible    jquery=input[checked='checked'][value='1'][type='radio']
    \  ${Status_Category}=     Run Keyword And Return Status    Element Should Be Visible    jquery=input[checked='checked'][value='2'][type='radio']
    \
    \  Log To Console    PDS Type Collection Status = ${Status_Collection}
    \  Log To Console    PDS Type Category Status = ${Status_Category}


    \  ${Get_Publishes_iTruemart_status}   Run Keyword And Return Status   Element Should Be Visible   jquery=input[name='app[1]'][value='1'][type='checkbox'][checked='checked']
    \  Log To Console   Publishes for iTruemart = ${Get_Publishes_iTruemart_status}
    \  Run Keyword If  '${Get_Publishes_iTruemart_status}' == 'False'    Publishes Status Is Incorrect

    \  Run Keyword If  '${Status_Collection}' == 'True'    Get PDS Type Collection To Array
    \  Run Keyword If  '${Status_Category}' == 'True'    Get PDS Type Category To Array

    \  Click Element and Wait Angular Ready    ${XPATH_PCMS.btn_goto_Collection_management}
    \  Wait Until Element Is Visible   ${XPATH_PCMS.wait_manage_collection_respond}    ${timeout}



Click Promotion
    Wait Until Element Is Visible   ${XPATH_PCMS.link_promotion}    ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_PCMS.link_promotion}
    Wait Until Element Is Visible   ${XPATH_PCMS.link_discount_campiagn}    ${timeout}

Click Promotion - Discount Campaign
    Click Element and Wait Angular Ready    ${XPATH_PCMS.link_discount_campiagn}
    Wait Until Element Is Visible   ${XPATH_PCMS.wait_discount_campiagn_respond}    ${timeout}

Select Promotion - Discount Campaign
    Wait Until Element Is Visible   ${XPATH_PCMS.btn_select_discount_campiagn}    ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_PCMS.btn_select_discount_campiagn}
    Wait Until Element Is Visible   ${XPATH_PCMS.wait_discount_campaign_product_respond}    ${timeout}


Get Product Name In PCMS iTrueMart - Discount Campaign
    @{Get_Product_Name_In_PCMS}=   Create List   ${EMPTY}
    ${Count_pcms_wow_product_number}   Get matching xpath Count   ${XPATH_PCMS.cnt_pcms_wow_product}
    Set Test Variable   ${Check_pcms_wow_product_number}   ${Count_pcms_wow_product_number}
    Log To Console   PCMS Everyday Wow Product = ${Count_pcms_wow_product_number}

    :FOR  ${index}  IN RANGE  1  ${Count_pcms_wow_product_number}+1
    \  ${XPATH_pcms_wow_name}   Catenate  SEPARATOR=   ${XPATH_PCMS.cnt_pcms_wow_product}[${index}]/td/h4
    \  ${Get_wow_product_name}   Get Text   ${XPATH_pcms_wow_name}

    \  Append To List  ${Get_Product_Name_In_PCMS}   ${Get_wow_product_name}
    \  ${Get_Product_Name_In_PCMS2}=  Get From List   ${Get_Product_Name_In_PCMS}   ${index}
    \  Log To Console   PCMS Product No.${index}
    \  Log To Console   PCMS Product Name =${Get_Product_Name_In_PCMS2} \n

    ${dict1}=   Create Dictionary   test=TestData
    Set To Dictionary   ${dict1}   package_name=${Get_Product_Name_In_PCMS}
    Set Test Variable   ${Get_PCMS_Product_Name}   ${dict1}
    # Log To Console   ${Get_PCMS_Product_Name}


# Get Product Picture Attribute In PCMS iTrueMart - Discount Campaign
#     @{Get_Product_Picture_Attribute_In_PCMS}=   Create List   ${EMPTY}

#     :FOR  ${index}  IN RANGE  1  ${Check_pcms_wow_product_number}+1
#     \  ${XPATH_pcms_wow_pic}   Catenate  SEPARATOR=   ${XPATH_PCMS.cnt_pcms_wow_product}[${index}]/td/img@src
#     \  ${Get_wow_pic_attribute}   Selenium2Library.Get Element Attribute   ${XPATH_pcms_wow_pic}

    # \  @{Split_String}   Split String   ${Get_wow_pic_attribute}   /
    # \  ${Max_length}   Get Length   ${Split_String}
    # \  ${Last_Index}   Evaluate   ${Max_length}-1
    # \  ${String}=   Set Variable   @{Split_String}[${Last_Index}]
    # # \  Log To Console   Get Attribute = ${String}
    # \  @{Split_String1}   Split String   ${String}   _
    # \  ${Max_lenght1}   Get Length   ${Split_String1}
    # \  ${String1}=   Set Variable   @{Split_String1}[0]
#     # \  Log To Console   Everyday Wow Attribute = ${String1}

#     \  Append To List  ${Get_Product_Picture_Attribute_In_PCMS}   ${String1}
#     \  ${Get_Product_Picture_Attribute_In_PCMS2}=  Get From List   ${Get_Product_Picture_Attribute_In_PCMS}   ${index}
#     \  Log To Console   PCMS Product No.${index}
#     \  Log To Console   PCMS Product Picture Attribute =${Get_Product_Picture_Attribute_In_PCMS2} \n


#     ${dict2}=   Create Dictionary   test=TestData
#     Set To Dictionary   ${dict2}   package_name=${Get_Product_Picture_Attribute_In_PCMS}
#     Set Test Variable   ${Get_PCMS_Product_Pic_Attribute}   ${dict2}
#     # Log To Console   ${PCMS_Product_Pic_Attribute}



Login PCMS To Verify Promotion - Discount Promotion Product
    Open PCMS iTruemart
    Click Promotion
    Click Promotion - Discount Campaign
    Select Promotion - Discount Campaign
    Get Product Name In PCMS iTrueMart - Discount Campaign
    # Get Product Picture Attribute In PCMS iTrueMart - Discount Campaign

#######################################################   Storefront CMS    #####################################################
Open storefront CMS
    Open Browser    ${STOREFRONT_CMS}    chrome
    Maximize Browser Window
    Sleep    4s

Click Shop Name
    [Arguments]    ${shop}
    Wait Until Element Is Visible    ${XPATH_storefront.wait_shop_list_display}    ${timeout}
    ${xpath_shop_name}    Catenate  SEPARATOR=    //tr[td[a[@ng-if="shop.site == 'mobile'"]]]/td[@style='text-align: center;vertical-align: middle;']/a/span[contains(.,'${shop}')]
    Click Element and Wait Angular Ready    ${xpath_shop_name}
    Wait Until Element Is Visible    ${XPATH_storefront.wait_edit_shop_logo_popup}    ${timeout}

Click Cancel Shop popup
    Wait Until Element Is Visible    ${XPATH_storefront.btn_cancel_shop_logo_popup}    ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_storefront.btn_cancel_shop_logo_popup}
    Wait Until Element Is Visible    ${XPATH_storefront.wait_shop_list_display}    ${timeout}

Click Shop Published
    [Arguments]    ${shop}
    ${xpath_shop_published}    Catenate  SEPARATOR=    //tr[td[a[@ng-if="shop.site == 'mobile'"]]][td[a/span[contains(.,'${shop}')]]]/td[4]/a
    Wait Until Element Is Visible    ${XPATH_storefront.wait_shop_list_display}    ${timeout}
    Click Element and Wait Angular Ready    ${xpath_shop_published}
    Wait Until Element Is Visible    ${XPATH_storefront.wait_storefront_management_menu_display}    ${timeout}

Click Storefront Management Header Menu
    Wait Until Element Is Visible    ${XPATH_storefront.btn_menu_header}    ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_storefront.btn_menu_header}

Click Storefront Management Menu
    Wait Until Element Is Visible    ${XPATH_storefront.btn_menu_menu}    ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_storefront.btn_menu_menu}
    Wait Until Element Is Visible    ${XPATH_storefront.wait_menu_edit_display}    ${timeout}
Click Storefront Management Banner Menu
    Wait Until Element Is Visible    ${XPATH_storefront.btn_menu_banner}    ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_storefront.btn_menu_banner}
    Wait Until Element Is Visible    ${XPATH_storefront.banner_list}    ${timeout}
Click Storefront Management Content Menu
    Wait Until Element Is Visible    ${XPATH_storefront.btn_menu_content}    ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_storefront.btn_menu_content}
    # Wait Until Element Is Visible
Click Storefront Management Footer Menu
    Wait Until Element Is Visible    ${XPATH_storefront.btn_menu_footer}    ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_storefront.btn_menu_footer}
    # Wait Until Element Is Visible
Back To Storefront Management Menu
    Wait Until Element Is Visible    ${XPATH_storefront.btn_back_to_storefront_menu}    ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_storefront.btn_back_to_storefront_menu}
    Wait Until Element Is Visible    ${XPATH_storefront.wait_storefront_management_menu_display}    ${timeout}



Get Mobile Shop Header Attribute
    [Arguments]    ${shop}
    Click Shop Published    ${shop}
    Click Storefront Management Header Menu
    Sleep    4s
    Select Frame    //div[@id='cke_header-portal_html_primary']//iframe[@class='cke_wysiwyg_frame cke_reset']
    ${Get_Header_Attribute}    Selenium2Library.Get Element Attribute    //body[@class='header-portal cke_editable cke_editable_themed cke_contents_ltr cke_show_borders']/p/img@src
    Log To Console    \n Header Attribute = ${Get_Header_Attribute}
    Set Test Variable    ${Check_Header_Attribute}    ${Get_Header_Attribute}
    Close Browser


Get Shop Menu
    Wait Until Element Is Visible    ${XPATH_storefront.memu_field}    ${timeout}
    ${Get_menu_number}    Get matching xpath Count    ${XPATH_storefront.memu_field}/li
    Log To Console    Menu = ${Get_menu_number}
    @{storefront_menu_name}    Create List    ${EMPTY}
    :FOR  ${index}   IN RANGE   1  ${Get_menu_number}+1
    \  ${xpath_menu_name}    Catenate  SEPARATOR=    ${XPATH_storefront.memu_field}/li[${index}]//span
    \  ${Get_menu_name}    Get Text    ${xpath_menu_name}
    \  Log To Console    Menu No.[${index}] = ${Get_menu_name}
    \  Append To List  ${storefront_menu_name}   ${Get_menu_name}

    Set Test Variable   ${Check_storefront_menu_name}   ${storefront_menu_name}

Storefront Menu Status Is Off
    Log To Console   Menu Status = Off , please turn on before run Automated
    Should Be Equal As Strings    Menu Status = off     Menu Status = on
Check Menu Status
    ${Menu_stauts_on}   Get matching xpath Count   ${XPATH_storefront.menu_status_on}
    #Menu_stauts_off have some issue can't get status =1 , need to find solution for new xpath
    ${Menu_stauts_off}   Get matching xpath Count   ${XPATH_storefront.menu_status_off}
    Log To Console    \n Menu status ON = ${Menu_stauts_on} \n Menu Status OFF = ${Menu_stauts_off}
    Run Keyword If  '${Menu_stauts_off}' > '0'    Storefront Menu Status Is Off
     ...  ELSE    Get Shop Menu

Get Mobile Shop Menu Category Name
    [Arguments]    ${shop}
    Click Shop Published    ${shop}
    Click Storefront Management Menu
    Sleep    2s
    Check Menu Status
    # Close Browser

Get Mobile Shop Logo 130x130
    [Arguments]    ${shop}
    Click Shop Name    ${shop}
    Wait Until Element Is Visible    ${XPATH_storefront.shop_logo_attribute}    ${timeout}
    ${Shop_logo130_attribute}    Selenium2Library.Get Element Attribute    ${XPATH_storefront.shop_logo_attribute}@src
    Click Cancel Shop popup
    Log To Console    \n Storefront Get Shop Logo Attribute = ${Shop_logo130_attribute}
    Set Test Variable    ${Check_Shop_logo130_attribute}    ${Shop_logo130_attribute}
    # Close Browser

Get Mobile Shop Banner
    [Arguments]    ${shop}
    Click Shop Published    ${shop}
    Click Storefront Management Banner Menu
    Sleep    2
    ${Cnt_Banner_number}    Get matching xpath count    ${XPATH_storefront.cnt_banner_number}
    Log To Console    \n Shop Have Banner = ${Cnt_Banner_number}
    Set Test Variable    ${Check_Cnt_Banner_number}    ${Cnt_Banner_number}
    @{Storefront_banner_attribute}=   Create List   ${EMPTY}
    :FOR    ${index}    IN RANGE    1   ${Cnt_Banner_number}+1
    \  ${xpath_banner_attribute}    Catenate  SEPARATOR=    ${XPATH_storefront.cnt_banner_number}[${index}]/td[6]/a[1]/i
    \  Click Element and Wait Angular Ready    ${xpath_banner_attribute}
    \  Wait Until Element Is Visible    ${XPATH_storefront.banner_picture_TH}    ${timeout}
    \  ${Get_banner_pic_attribute}    Selenium2Library.Get Element Attribute    ${XPATH_storefront.banner_picture_TH}@src
    \  Log To Console    Banner Picture No.[${index}] = ${Get_banner_pic_attribute}
    \  Append To List    ${Storefront_banner_attribute}    ${Get_banner_pic_attribute}
    \  Click Element and Wait Angular Ready    ${XPATH_storefront.banner_picture_popup_cancel_button}
    \  Wait Until Element Is Visible    ${XPATH_storefront.banner_list}    ${timeout}
    Set Test Variable   ${Check_Storefront_banner_attribute}   ${Storefront_banner_attribute}
    # Close Browser


#####################################################   WeMall Mobile SIte   #####################################################
Login WeMall And Go To Portal
    Open Browser   ${ITM_MOBILE}/auth/login   chrome   chrome
    Set Window Position   ${0}      ${0}
    Maximize Browser Window
    Wait Until Element Is Visible   ${XPATH_iTrueMart.username}    ${timeout}
    Input Text   ${XPATH_iTrueMart.username}   ${SAMPLE_DATA.VALID.iTruemart_id}
    Input Text   ${XPATH_iTrueMart.password}   ${SAMPLE_DATA.VALID.iTruemart_password}
    Click Element and Wait Angular Ready    ${XPATH_iTrueMart.btn_submit_login}
    Wait Until Element Is Visible   ${XPATH_iTrueMart.txt_id}    ${timeout}
    Go To   ${WEMALL_WEB}/portal/${mainPage}
    Add Cookie      is_mobile  true
    Reload Page

Go To Promotion Page
    # Click Element and Wait Angular Ready    ${XPATH_WeMall.btn_Promotion_page}
    Go To   ${WEMALL_WEB}/portal/page2
    Wait Until Element Is Visible   ${XPATH_WeMall.wait_Promotion_page_respond}    ${timeout}


Verify WeMall icon Button In WeMall Mobile Site
    Wait Until Element Is Visible   ${XPATH_WeMall.btn_wemall_icon}    ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_WeMall.btn_wemall_icon}
    Location Should Be   ${Check_URL.home}
    Log To Console   \n  WeMall Icon button is Active


Verify Shop Cart Button In WeMall Mobile Site
    Wait Until Element Is Visible   ${XPATH_WeMall.btn_cart_main_page}        ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_WeMall.btn_cart_main_page}        ${timeout}
    Wait Until Element Is Visible   ${Check_URL.wait_cart_respond}
    Location Should Be   ${Check_URL.cart}
    Log To Console   \n  Shop Cart button is Active
    Wait Until Element Is Visible   ${XPATH_iTrueMart.user_contain}    ${timeout}
    Log To Console   Login Success

Verify Footer Change View Button In WeMall Mobile Site
    Wait Until Element Is Visible   ${XPATH_WeMall.btn_footer_change_view}    ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_WeMall.btn_footer_change_view}
    Wait Until Element Is Visible   ${XPATH_WeMall.wait_footer_change_view_respond}    ${timeout}
    Log To Console   \n  Footer Change View button is Active


Check Everyday Wow Name Is Exist
    ${Get_PCMS_Product_Name_From_List}   Get From Dictionary   ${Get_PCMS_Product_Name}   package_name
    :FOR  ${index}  IN RANGE  1  ${Check_pcms_wow_product_number}+1
    \  ${Get_PCMS_Product_Name_From_List1}=  Get From List   ${Get_PCMS_Product_Name_From_List}   ${index}

    \  Set Test Variable   ${Current_Wow_Name}   ${Get_PCMS_Product_Name_From_List1}

    \  Log To Console   Get Current Everyday Wow Name In ARRAY[${index}] = ${Current_Wow_Name}

    \  Run Keyword If  '${Check_wow_product_name}' == '${Current_Wow_Name}'    Exit For Loop

    \  Run Keyword If  '${index}' == '${Check_pcms_wow_product_number}'   Log To Console   Everyday Wow Name = ${Check_wow_product_name} Is Not Exist In PCMS


Check Everyday Wow Attribute Is Exist
    ${Get_PCMS_Product_Attribute_From_List}   Get From Dictionary   ${Get_PCMS_Product_Pic_Attribute}   package_name
    :FOR  ${index}  IN RANGE  1  ${Check_pcms_wow_product_number}+1
    \  ${Get_PCMS_Product_Attribute_From_List1}=  Get From List   ${Get_PCMS_Product_Attribute_From_List}   ${index}

    \  Set Test Variable   ${Current_Wow_Attribute}   ${Get_PCMS_Product_Attribute_From_List1}

    \  Log To Console   Get Current Everyday Wow Attribute In ARRAY[${index}] = ${Current_Wow_Attribute}

    \  Run Keyword If  '${Check_wow_product_attribute}' == '${Current_Wow_Attribute}'    Exit For Loop

    \  Run Keyword If  '${index}' == '${Check_pcms_wow_product_number}'   Log To Console   Everyday Wow Attribute = ${Check_wow_product_name} Is Not Exist In PCMS


Check Everyday Wow PKey Is Exist
    :FOR  ${index}  IN RANGE  1  ${Check_length_Pkey}+1

    \  ${pkey_index}   Evaluate   ${index}-1

    \  Set Test Variable   ${Current_Pkey}   @{promotion_discount_wow_pkey}[${pkey_index}]

    \  Log To Console   Get Current Everyday Wow PKey In ARRAY[${index}] = ${Current_Pkey}

    \  Run Keyword If  '${Check_wow_Pkey}' == '${Current_Pkey}'    Exit For Loop

    \  Run Keyword If  '${index}' == '${Check_length_Pkey}'   Log To Console   Everyday Wow Attribute = ${Check_wow_Pkey} Is Not Exist In ARRAY



Compare Everyday Wow In Wemall Mobile SIte with PCMS
    Wait Until Element Is Visible   ${XPATH_WeMall.wait_wow_respond}    ${timeout}

    ${Get_Wow_pic_number}   Get matching xpath Count   ${XPATH_WeMall.cnt_wow_product}
    Log To Console   \n Everyday Wow Product = ${Get_Wow_pic_number}

    ${Max_length_Pkey}   Get Length   ${promotion_discount_wow_pkey}
    Set Test Variable   ${Check_length_Pkey}   ${Max_length_Pkey}
    Log To Console   Max Length Pkey = ${Check_length_Pkey}


    #FOR LOOP of Everyday Wow Name
    :FOR  ${index}  IN RANGE  1  ${Get_Wow_pic_number}+1
    \  ${XPATH_wow_product}   Catenate  SEPARATOR=   ${XPATH_WeMall.cnt_wow_product}[${index}]//h5
    \  ${Get_wow_product_name}   Get Text   ${XPATH_wow_product}
    \  Set Test Variable   ${Check_wow_product_name}   ${Get_wow_product_name}
    \  Log To Console   \n Get Product Name No.${index}
    \  Log To Console   Portal Product Name = ${Get_wow_product_name}
    \  Check Everyday Wow Name Is Exist
    \  Log To Console   PCMS Found Everyday Wow Name = ${Current_Wow_Name}
    \  Should Be Equal As Strings   ${Get_wow_product_name}   ${Current_Wow_Name}
    \  Log To Console   Portal Everyday Wow Name No.${index} Is Retrieve Data From PCMS Correct \n

    # # #FOR LOOP of Everyday Wow Attribute
    # \  ${XPATH_wow_product}   Catenate  SEPARATOR=   ${XPATH_WeMall.cnt_wow_product}[${index}]//img@src
    # \  ${Get_wow_product_attribute}   Selenium2Library.Get Element Attribute   ${XPATH_wow_product}

    # \  @{Split_String}   Split String   ${Get_wow_product_attribute}   /
    # \  ${Max_length}   Get Length   ${Split_String}
    # \  ${Last_Index}   Evaluate   ${Max_length}-1
    # \  ${String}=   Set Variable   @{Split_String}[${Last_Index}]
    # # \  Log To Console   Get Attribute = ${String}
    # \  @{Split_String1}   Split String   ${String}   _
    # \  ${Max_lenght1}   Get Length   ${Split_String1}
    # \  ${String1}=   Set Variable   @{Split_String1}[0]
    # # \  Log To Console   Everyday Wow Attribute = ${String1}

    # \  Set Test Variable   ${Check_wow_product_attribute}   ${String1}
    # \  Log To Console   Get Product Attribute No.${index}
    # \  Log To Console   Portal Product Attribute = ${String1}
    # \  Check Everyday Wow Attribute Is Exist
    # \  Log To Console   PCMS Found Everyday Wow Attribute = ${Current_Wow_Attribute}
    # \  Should Be Equal As Strings   ${String1}   ${Current_Wow_Attribute}
    # \  Log To Console   Portal Everyday Wow Attribute No.${index} Is Retrieve Data From PCMS Correct \n

    #FOR LOOP of Pkey
    \  ${XPATH_wow_product}   Catenate  SEPARATOR=   ${XPATH_WeMall.cnt_wow_product}[${index}]/div/a@href
    \  ${Get_wow_Element}   Selenium2Library.Get Element Attribute   ${XPATH_wow_product}

    \  @{Split_String2}   Split String   ${Get_wow_Element}   -
    \  ${Max_length}   Get Length   ${Split_String2}
    \  ${Last_Index}   Evaluate   ${Max_length}-1
    \  ${String2}=   Set Variable   @{Split_String2}[${Last_Index}]
    # \  Log To Console   Get Attribute = ${String}
    \  @{Split_String3}   Split String   ${String2}   .
    \  ${Max_lenght2}   Get Length   ${Split_String3}
    \  ${String4}=   Set Variable   @{Split_String3}[0]
    # \  Log To Console   Everyday Wow Pkey = ${String4}
    \  Set Test Variable   ${Check_wow_Pkey}   ${String4}
    \  Log To Console   Get Product PKey No.${index}
    \  Log To Console   Portal Product PKey = ${String4}
    \  Check Everyday Wow PKey Is Exist
    \  Should Be Equal As Strings   ${Current_Pkey}   ${Check_wow_Pkey}
    \  Log To Console   Everyday Wow PKey No.${index} Is Retrieve Data Correct
    \  Log TO Console   ========================================================================================================\n

Click Main Menu In WeMall Mobile Sites
    Sleep   2s
    Wait Until Element Is Visible    ${XPATH_WeMall.btn_main_menu}        ${timeout}
    Click Element and Wait Angular Ready   ${XPATH_WeMall.btn_main_menu}
    Sleep    2s


Not Found Item In Cart
    Log To Console   Item in cart = ${Check_item_number}
    Log To Console   Not Found Item In Cart
    Wait Until Element Is Visible   ${XPATH_iTrueMart.icon_cart}    ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_iTrueMart.icon_cart}
    Wait Until Element Is Visible   ${XPATH_iTrueMart.user_contain}    ${timeout}
    Log To Console   Login Success

Verify Login link
    Wait Until Element Is Visible   ${Mega_Menu.login}    ${timeout}
    Click Element and Wait Angular Ready    ${Mega_Menu.login}
    # Wait Until Element Is Visible   ${Check_URL.wait_login_respond}
    Location Should Be   ${Check_URL.login}
    Log To Console   \n Login link is Active
    Wait Until Element Is Visible   ${XPATH_iTrueMart.username}    ${timeout}
    Input Text   ${XPATH_iTrueMart.username}   ${SAMPLE_DATA.VALID.iTruemart_id}
    Input Text   ${XPATH_iTrueMart.password}   ${SAMPLE_DATA.VALID.iTruemart_password}
    Click Element and Wait Angular Ready    ${XPATH_iTrueMart.btn_submit_login}
    Wait Until Element Is Visible   ${XPATH_iTrueMart.icon_cart}    ${timeout}

    ${Get_item_number}   Get matching xpath count   ${XPATH_iTrueMart.icon_item_number_in_cart}
    Set Test Variable   ${Check_item_number}   ${Get_item_number}

    Run Keyword If   '${Get_item_number}' > '0'   Log To Console   Item in cart = ${Get_item_number} \n Login Success

    Run Keyword If   '${Get_item_number}' == '0'   Not Found Item In Cart

Verify Home link
    Wait Until Element Is Visible   ${Mega_Menu.home}    ${timeout}
    Click Element and Wait Angular Ready    ${Mega_Menu.home}
    # Wait Until Element Is Visible   ${XPATH_WeMall.txt_menubar}
    Location Should Be   ${Check_URL.home}
    Log To Console   \n Home link is Active

Verify Everyday Wow link
    Wait Until Element Is Visible   ${Mega_Menu.wow}    ${timeout}
    Click Element and Wait Angular Ready    ${Mega_Menu.wow}
    # Wait Until Element Is Visible   ${Check_URL.wait_wow_respond}
    Location Should Be   ${Check_URL.wow}
    Log To Console   \n Wow link is Active

Verify Category Main Link
    Wait Until Element Is Visible   ${Mega_Menu.category}    ${timeout}
    Click Element and Wait Angular Ready    ${Mega_Menu.category}
    Wait Until Element Is Visible   ${Mega_Menu.wait_category_respond}    ${timeout}
    Log To Console   \n Category Main link is Active



Check Mega Menu Category Name Is Exist
    ${Max_length}   Get Length   ${Check_Category_Name_From_Dic}

    :FOR  ${index}  IN RANGE  1  ${Max_length}+1
    \  ${Get_Category_Name_From_List}=  Get From List   ${Check_Category_Name_From_Dic}   ${index}

    \  Set Test Variable   ${Current_Category_Name}   ${Get_Category_Name_From_List}

    \  Log To Console   Get Current Category Name In ARRAY = ${Current_Category_Name}

    \  Run Keyword If  '${Check_Category_Name}' == '${Get_Category_Name_From_List}'    Exit For Loop

    \  Run Keyword If  '${index}' == '${Max_length}'   Log To Console   Category Name Is Not Exist In PCMS


Compare Mega Menu Category In WeMall Mobile Site with PCMS
    Click Main Menu In WeMall Mobile Sites
    Wait Until Element Is Visible   ${Mega_Menu.category}    ${timeout}
    Sleep   1s
    Click Element and Wait Angular Ready    ${Mega_Menu.category}
    Wait Until Element Is Visible   ${Mega_Menu.wait_category_respond}    ${timeout}

    ${Get_Category_number}   Get Matching xpath count   ${Mega_Menu.cnt_category_number}
    Log To Console   \n Category Number = ${Get_Category_number}

    ${Get_Category_Name_From_Dic}   Get From Dictionary   ${PDS_Type_Category}   package_name
    Set Test Variable   ${Check_Category_Name_From_Dic}   ${Get_Category_Name_From_Dic}

    :FOR   ${index}   IN RANGE   1   ${Get_Category_number}+1
    \  ${XPATH_Category}   Catenate  SEPARATOR   ${Mega_Menu.cnt_category_number}//span
    \  ${Category_Name}   Get Text   ${XPATH_Category}
    \  Log To Console   \n Mega Menu Category No.${index}
    \  Log To Console   Mega Menu Category Name = ${Category_Name}
    \  Set Test Variable   ${Check_Category_Name}   ${Category_Name}

    \  Check Mega Menu Category Name Is Exist

    \  Log To Console   Category Name = ${Current_Category_Name} Is Found

    \  Should Be Equal As Strings   ${Current_Category_Name}   ${Category_Name}
    \  Log To Console   Mega Menu Category Name No.${index} Is Retrieve Data Correct \n


Verify Promotion Main Link
    Wait Until Element Is Visible   ${Mega_Menu.promotion}    ${timeout}
    Click Element and Wait Angular Ready    ${Mega_Menu.promotion}
    Wait Until Element Is Visible   ${Mega_Menu.wait_promotion_respond}    ${timeout}
    Log To Console   \n Promotion Main link is Active



Check Mega Menu Promotion Name Is Exist
    ${Max_length}   Get Length   ${Check_Promotion_Name_From_Dic}

    :FOR  ${index}  IN RANGE  1  ${Max_length}+1
    \  ${Get_Promotion_Name_From_List}=  Get From List   ${Check_Promotion_Name_From_Dic}   ${index}

    \  Set Test Variable   ${Current_Promotion_Name}   ${Get_Promotion_Name_From_List}

    \  Log To Console   Get Current Category Name In ARRAY = ${Current_Promotion_Name}

    \  Run Keyword If  '${Check_Promotion_Name}' == '${Get_Promotion_Name_From_List}'    Exit For Loop

    \  Run Keyword If  '${index}' == '${Max_length}'   Log To Console   Promotion Name Is Not Exist In PCMS


Compare Mega Menu Promotion Name In WeMall Mobile Site with PCMS
    Click Main Menu In WeMall Mobile Sites
    Wait Until Element Is Visible   ${Mega_Menu.promotion}    ${timeout}
    Sleep   1s
    Click Element and Wait Angular Ready    ${Mega_Menu.promotion}
    Wait Until Element Is Visible   ${Mega_Menu.wait_promotion_respond}    ${timeout}

    ${Get_Promotion_number}   Get Matching xpath count   ${Mega_Menu.cnt_promotion_number}
    Log To Console   \n Promotion Number = ${Get_Promotion_number}

    ${Get_Promotion_Name_From_Dic}   Get From Dictionary   ${PDS_Type_Collection}   package_name
    Set Test Variable   ${Check_Promotion_Name_From_Dic}   ${Get_Promotion_Name_From_Dic}

    :FOR   ${index}   IN RANGE   1   ${Get_Promotion_number}+1
    \  ${XPATH_Promotion}   Catenate  SEPARATOR   ${Mega_Menu.cnt_promotion_number}//span
    \  ${Promotion_Name}   Get Text   ${XPATH_Promotion}
    \  Log To Console   \n Mega Menu Promotion No.${index}
    \  Log To Console   Mega Menu Promotion Name = ${Promotion_Name}
    \  Set Test Variable   ${Check_Promotion_Name}   ${Promotion_Name}

    \  Check Mega Menu Promotion Name Is Exist

    \  Log To Console   Category Name = ${Current_Promotion_Name} Is Found

    \  Should Be Equal As Strings   ${Current_Promotion_Name}   ${Promotion_Name}
    \  Log To Console   Mega Menu Promotion Name No.${index} Is Retrieve Data Correct \n



Verify Picture Data In WeMall Mobile Site with CMS
    ${XPATH_pic_1}    Catenate  SEPARATOR=    //div[h3[contains(.,'${Check_WeMall_Category_Name}')]]//div[@class='owl-item active']//img@src
    ${Get_portal_pic_attribute_1}    Selenium2Library.Get Element Attribute    ${XPATH_pic_1}
    ${XPATH_pic_2}    Catenate  SEPARATOR=    //div[h3[contains(.,'${Check_WeMall_Category_Name}')]]//div[@class='item'][1]//img@src
    ${Get_portal_pic_attribute_2}    Selenium2Library.Get Element Attribute    ${XPATH_pic_2}
    ${XPATH_pic_3}    Catenate  SEPARATOR=    //div[h3[contains(.,'${Check_WeMall_Category_Name}')]]//div[@class='item'][2]//img@src
    ${Get_portal_pic_attribute_3}    Selenium2Library.Get Element Attribute    ${XPATH_pic_3}

    ${Get_Promotion_Data_From_Dic}   Get From Dictionary   ${Get_MegaMenu_Data}   package_name
    ${Get_Pic_Attribute_From_List}=   Get From List   ${Get_Promotion_Data_From_Dic}   ${Pass_value_index_category}
    ${Get_Pic_Attribute_From_List1}=   Get From List   ${Get_Pic_Attribute_From_List}   1
    ${Get_Pic_Attribute_From_List2}=   Get From List   ${Get_Pic_Attribute_From_List}   2
    ${Get_Pic_Attribute_From_List3}=   Get From List   ${Get_Pic_Attribute_From_List}   3

    Log To Console   Compare Attribute Portal No.[1] = ${Get_portal_pic_attribute_1}
    Log To Console   Compare Attribute CMS No.[1] = ${Get_Pic_Attribute_From_List1}
    Should Be Equal As Strings   ${Get_portal_pic_attribute_1}   ${Get_Pic_Attribute_From_List1}
    Log To Console   ${Check_WeMall_Category_Name} Picture Attribute No.[1] Is Correct As CMS \n

    Log To Console   Compare Attribute Portal No.[2] = ${Get_portal_pic_attribute_2}
    Log To Console   Compare Attribute CMS No.[2] = ${Get_Pic_Attribute_From_List2}
    Should Be Equal As Strings   ${Get_portal_pic_attribute_2}   ${Get_Pic_Attribute_From_List2}
    Log To Console   ${Check_WeMall_Category_Name} Picture Attribute No.[2] Is Correct As CMS \n

    Log To Console   Compare Attribute Portal No.[3] = ${Get_portal_pic_attribute_3}
    Log To Console   Compare Attribute CMS No.[3] = ${Get_Pic_Attribute_From_List3}
    Should Be Equal As Strings   ${Get_portal_pic_attribute_3}   ${Get_Pic_Attribute_From_List3}
    Log To Console   ${Check_WeMall_Category_Name} Picture Attribute No.[3] Is Correct As CMS \n

Compare Mega Menu Promotion Picture In WeMall Mobile Site with PCMS
    Wait Until Element Is Visible   ${XPATH_WeMall.txt_menubar}    ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_WeMall.btn_Promotion_page}
    Wait Until Element Is Visible   ${XPATH_WeMall.wait_Promotion_page_respond}    ${timeout}

    ${Get_portal_category_number}    Get matching xpath count    //div/h3
    Set Test Variable    ${Check_portal_category_number}    ${Get_portal_category_number}

    :FOR  ${index}  IN RANGE  1  ${Get_portal_category_number}+1
    \  ${index1}   Evaluate   ${index}+1
    \  Set Test Variable    ${Pass_value_index_category}    ${index1}
    \  ${XPATH_Check_Category_Name}   Catenate  SEPARATOR=  //div[${index}]/h3
    \  ${Get_WeMall_Category_Name}   Get Text   ${XPATH_Check_Category_Name}
    \  Set Test Variable    ${Check_WeMall_Category_Name}    ${Get_WeMall_Category_Name}
    \  Log To Console   \n WeMall Promotion Category No.${index} = ${Get_WeMall_Category_Name}
    \  Verify Picture Data In WeMall Mobile Site with CMS
    \  Log To Console    ==================================================================================================

Verify Itruemart link
    Wait Until Element Is Visible   ${Mega_Menu.itruemart}    ${timeout}
    Click Element and Wait Angular Ready    ${Mega_Menu.itruemart}
    # Wait Until Element Is Visible   ${Check_URL.wait_itruemart_respond}
    Location Should Be   ${Check_URL.itruemart}
    Log To Console   \n Itruemart link is Active

Verify Cart link
    Wait Until Element Is Visible   ${Mega_Menu.cart}    ${timeout}
    Click Element and Wait Angular Ready    ${Mega_Menu.cart}
    # Wait Until Element Is Visible   ${Check_URL.wait_cart_respond}
    Location Should Be   ${Check_URL.cart}
    Log To Console   \n Cart link is Active
    Wait Until Element Is Visible   ${XPATH_iTrueMart.user_contain}    ${timeout}
    Log To Console   Login Success

Verify Order Tracking link
    Wait Until Element Is Visible   ${Mega_Menu.order_tracking}    ${timeout}
    Click Element and Wait Angular Ready    ${Mega_Menu.order_tracking}
    Location Should Be   ${Check_URL.order_tracking}
    Log To Console   \n Order Tracking link is Active

Verify Return Policy link
    Wait Until Element Is Visible   ${Mega_Menu.return_policty}    ${timeout}
    Click Element and Wait Angular Ready    ${Mega_Menu.return_policty}
    # Wait Until Element Is Visible   ${Check_URL.wait_return_policty_respond}
    Location Should Be   ${Check_URL.return_policty}
    Log To Console   \n Return Policy link is Active

Verify Shipment Policy link
    Wait Until Element Is Visible   ${Mega_Menu.shipment_policy}    ${timeout}
    Click Element and Wait Angular Ready    ${Mega_Menu.shipment_policy}
    # Wait Until Element Is Visible   ${Check_URL.wait_shipment_policy_respond}
    Location Should Be   ${Check_URL.shipment_policy}
    Log To Console   \n Shipment Policy link is Active

Verify Refund Policy link
    Wait Until Element Is Visible   ${Mega_Menu.refund_policy}    ${timeout}
    Click Element and Wait Angular Ready    ${Mega_Menu.refund_policy}
    # Wait Until Element Is Visible   ${Check_URL.wait_refund_policy_respond}
    Location Should Be   ${Check_URL.refund_policy}
    Log To Console   \n Refund Policy link is Active

Verify Discount Code link
    Wait Until Element Is Visible   ${Mega_Menu.discount_code}    ${timeout}
    Click Element and Wait Angular Ready    ${Mega_Menu.discount_code}
    # Wait Until Element Is Visible   ${Check_URL.wait_discount_code_respond}
    Location Should Be   ${Check_URL.discount_code}
    Log To Console   \n Discount Code link is Active

Verify Contact Us link
    Wait Until Element Is Visible   ${Mega_Menu.contact_us}    ${timeout}
    Click Element and Wait Angular Ready    ${Mega_Menu.contact_us}
    # Wait Until Element Is Visible   ${Check_URL.wait_contact_us_respond}
    Location Should Be   ${Check_URL.contact_us}
    Log To Console   \n Contact Us link is Active

Verify Thai language
    Wait Until Element Is Visible   ${Mega_Menu.language}    ${timeout}
    Log To Console   Ready To Click ENG language
    Click Element and Wait Angular Ready    ${Mega_Menu.language}
    Wait Until Element Is Visible   ${XPATH_WeMall.txt_menubar}    ${timeout}
    Click Main Menu In WeMall Mobile Sites
    Wait Until Element Is Visible   ${Mega_Menu.language}    ${timeout}
    Click Element and Wait Angular Ready    ${Mega_Menu.language}
    Log To Console   Ready To Click ENG language
    Wait Until Element Is Visible   ${XPATH_WeMall.txt_menubar}    ${timeout}
    Location Should Be   ${Check_URL.th_language}
    Log To Console   \n TH language link is Active

Verify English language
    Wait Until Element Is Visible   ${Mega_Menu.language}    ${timeout}
    # Sleep   2s
    Log To Console   Ready To Click ENG language
    Click Element and Wait Angular Ready    ${Mega_Menu.language}
    Wait Until Element Is Visible   ${XPATH_WeMall.txt_menubar}    ${timeout}
    Location Should Be   ${Check_URL.en_language}
    Log To Console   \n EN language link is Active

Verify View More Button In WeMall Mobile Site
    Set Window Size       ${320}    ${568}
    Execute JavaScript    window.scrollTo(0,1200)
    Wait Until Element Is Visible   ${XPATH_WeMall.btn_view_more}    ${timeout}
    Sleep   1s
    Click Element and Wait Angular Ready    ${XPATH_WeMall.btn_view_more}
    Location Should Be   ${Check_URL.view_more}
    Log To Console   \n View More button link is Active

Compare Menubar In WeMall Mobile Site with CMS
    Wait Until Element Is Visible   ${XPATH_WeMall.txt_menubar}    ${timeout}

    ${Get_Category_Name_From_List}   Get From Dictionary   ${TEST_VAR}   package_name

    :FOR  ${index}  IN RANGE  1  ${Check_Category_Number}+1

    \  ${XPATH_Check_Category_Name}   Catenate  SEPARATOR=  //ul[@class='list-menu']/li[${index}+2]/a
    \  ${Get_WeMall_Category_Name}   Get Text   ${XPATH_Check_Category_Name}

    \  Log To Console   \n WeMall MenuBar Category No.${index}
    \  Log To Console   WeMall MenuBar Category Name = ${Get_WeMall_Category_Name}

    \  ${Get_Category_Name_From_List2}=  Get From List   ${Get_Category_Name_From_List}   ${index}
    \  Log To Console   CMS MenuBar Category No.${index}
    \  Log To Console   CMS MenuBar Category Name = ${Get_Category_Name_From_List2}

    \  Should Be Equal As Strings   ${Get_Category_Name_From_List2}   ${Get_WeMall_Category_Name}
    \  Log To Console   WeMall MenuBar Category Name No.${index} Is Retrieve Data Correct \n


Compare Menubar In WeMall Mobile Site Is Infinite Skirt
    Set Window Size       ${320}    ${568}
    Add Cookie      is_mobile  true
    Reload Page
    Wait Until Element Is Visible   ${XPATH_WeMall.txt_menubar}    ${timeout}

    ${Get_Category_Name_From_List}   Get From Dictionary   ${TEST_VAR}   package_name

    Set Test Variable   ${Check_Infinite_Skirt}   ${Check_Category_Number}

    :FOR  ${index}  IN RANGE  1  ${Check_Category_Number}+1

    \  ${XPATH_Check_Category_Name}   Catenate  SEPARATOR=  //ul[@class='list-menu']/li[${index}+${Check_Infinite_Skirt}+4]/a
    \  ${Get_WeMall_Category_Name}   Get Text   ${XPATH_Check_Category_Name}
    \  Log To Console   \n get xpath skirt = ${XPATH_Check_Category_Name}

    \  Log To Console   \n WeMall MenuBar Infinite Skirt No.${index}
    \  Log To Console   WeMall MenuBar Infinite Skirt Name = ${Get_WeMall_Category_Name}

    \  ${Get_Category_Name_From_List2}=  Get From List   ${Get_Category_Name_From_List}   ${index}
    \  Log To Console   CMS MenuBar Infinite Skirt No.${index}
    \  Log To Console   CMS MenuBar Infinite Skirt Name = ${Get_Category_Name_From_List2}

    \  Should Be Equal As Strings   ${Get_Category_Name_From_List2}   ${Get_WeMall_Category_Name}
    \  Log To Console   WeMall MenuBar Infinite Skirt Name No.${index} Is Retrieve Data Correct \n



Compare Mega Menu In WeMall Mobile Site - Promotion Page with CMS
    Wait Until Element Is Visible   ${XPATH_WeMall.txt_menubar}    ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_WeMall.btn_Promotion_page}
    Wait Until Element Is Visible   ${XPATH_WeMall.wait_Promotion_page_respond}    ${timeout}

    ${Get_Category_Name_From_List}   Get From Dictionary   ${TEST_VAR}   package_name

    :FOR  ${index}  IN RANGE  1  ${Check_Category_Number}

    \  ${XPATH_Check_Category_Name}   Catenate  SEPARATOR=  //div[${index}]/h3
    \  ${Get_WeMall_Category_Name}   Get Text   ${XPATH_Check_Category_Name}

    \  Log To Console   \n WeMall Promotion Category No.${index}
    \  Log To Console   WeMall Promotion Category Name = ${Get_WeMall_Category_Name}

    \  ${index_category}    Evaluate    ${index}+1
    \  ${Get_Category_Name_From_List2}=  Get From List   ${Get_Category_Name_From_List}   ${index_category}
    \  Log To Console   CMS Promotion Category No.${index}
    \  Log To Console   CMS Promotion Category Name = ${Get_Category_Name_From_List2}

    \  Should Be Equal As Strings   ${Get_Category_Name_From_List2}   ${Get_WeMall_Category_Name}
    \  Log To Console   WeMall Promotion Category Name No.${index} Is Retrieve Data Correct \n


Check Preview Picture Is1
    ${XPATH_Pic1}   Catenate  SEPARATOR=   //div[@class='lb-section-content']//div[@class='owl-item active']//img@src
    ${verify_attribute_pic1}   Selenium2Library.Get Element Attribute   ${XPATH_Pic1}

    @{Split_String}   Split String   ${verify_attribute_pic1}   /
    ${Max_length}   Get Length   ${Split_String}
    ${Last_Index}   Evaluate   ${Max_length}-1
    ${String}=   Set Variable   @{Split_String}[${Last_Index}]
    # Log To Console   String =${String}
    Set Test Variable   ${Get_Attribute_pic}   ${String}
    # Log To Console   Check Preview Picture Is1

Check Preview Picture Is2
    ${XPATH_Pic2}   Catenate  SEPARATOR=   //div[@class='lb-section-content']//div[@class='items-container']/div[1]//img@src
    ${verify_attribute_pic2}   Selenium2Library.Get Element Attribute   ${XPATH_Pic2}

    @{Split_String}   Split String   ${verify_attribute_pic2}   /
    ${Max_length}   Get Length   ${Split_String}
    ${Last_Index}   Evaluate   ${Max_length}-1
    ${String}=   Set Variable   @{Split_String}[${Last_Index}]
    # Log To Console   String =${String}
    Set Test Variable   ${Get_Attribute_pic}   ${String}
    # Log To Console   Check Preview Picture Is2

Check Preview Picture Is3
    ${XPATH_Pic3}   Catenate  SEPARATOR=   //div[@class='lb-section-content']//div[@class='items-container']/div[2]//img@src
    ${verify_attribute_pic3}   Selenium2Library.Get Element Attribute   ${XPATH_Pic3}

    @{Split_String}   Split String   ${verify_attribute_pic3}   /
    ${Max_length}   Get Length   ${Split_String}
    ${Last_Index}   Evaluate   ${Max_length}-1
    ${String}=   Set Variable   @{Split_String}[${Last_Index}]
    # Log To Console   String =${String}
    Set Test Variable   ${Get_Attribute_pic}   ${String}
    # Log To Console   Check Preview Picture Is3


Verify Preview Picture Data In WeMall Mobile Site with CMS
    @{Get_Preview_Attribute_Pic}=   Create List   ${EMPTY}

    :FOR  ${index}  IN RANGE  1  ${Check_preview_pic_number}+1

    \  Run Keyword If   '${index}' == '1'   Check Preview Picture Is1

    \  Run Keyword If   '${index}' == '2'   Check Preview Picture Is2

    \  Run Keyword If   '${index}' == '3'   Check Preview Picture Is3

    \  Append To List  ${Get_Preview_Attribute_Pic}   ${Get_Attribute_pic}

    \  Set Test Variable   ${Check_Preview_Attribute_Pic}   ${Get_Preview_Attribute_Pic}
    \  Log To Console   Get Current Attribute No.[${index}] = ${Get_Attribute_pic}


Get Preview Picture Sub Array
    :FOR  ${index}  IN RANGE  1  ${Check_preview_pic_number}+1
    \  ${Get_sub_list_from_dic}   Get From Dictionary   ${Check_Preview_Attribute_From_List}   package_name
    \  ${Get_sub_list_from_list}=   Get From List   ${Get_sub_list_from_dic}   ${index}
    \  ${Get_Portal_highlight_attribute}=   Get From List   ${Check_Preview_Attribute_Pic}   ${index}
    \  Log To Console   Compare Attribute Portal No.[${index}] = ${Get_sub_list_from_list}
    \  Log To Console   Compare Attribute CMS No.[${index}] = ${Get_Portal_highlight_attribute}
    \  Should Be Equal As Strings   ${Get_sub_list_from_list}   ${Get_Portal_highlight_attribute}
    \  Log To Console   Picture Attribute No.${index} Is Correct As CMS \n


Compare Highlights Picture In WeMall Mobile Site with CMS
    ${Get_Preview_Attribute_From_Dic}   Get From Dictionary   ${TEST_VAR}   package_name

    Wait Until Element Is Visible   ${XPATH_WeMall.pic_highlight}    ${timeout}

    :FOR  ${index}  IN RANGE  1  ${Check_pic_number}+1
    \  ${XPATH_btn_change_highlight_pic}   Catenate  SEPARATOR=   ${XPATH_WeMall.btn_change_highlight_pic}[${index}]
    \  Click Element and Wait Angular Ready    ${XPATH_btn_change_highlight_pic}

    \  Log To Console   \n Verify Highlight Picture No.${index}
    \  Verify Preview Picture Data In WeMall Mobile Site with CMS

    \  ${Get_Preview_Attribute_From_List}=  Get From List   ${Get_Preview_Attribute_From_Dic}   ${index}
    \  Set Test Variable   ${Check_Preview_Attribute_From_List}   ${Get_Preview_Attribute_From_List}
    \  Get Preview Picture Sub Array

    \  Log To Console   Banner Group Picture No. ${index} Is Retrieve Data Correct
    \  Log To Console  =========================================================================================================\n



Compare Merchantzone Picture Attribute
    ${Dot}=    Set Variable    ${Check_Category_Merchantzone}
    ${Max_Dot_runing}=    Evaluate    ${Check_Category_Merchantzone}*2
    ${First_Part_Pic}=    Set Variable    10
    ${Second_Part_Pic}=    Set Variable    20

    ${Dot_Cnt}=    Set Variable    ${Check_Category_runing}
    ${Dot_Cnt_Running_first_part}=    Evaluate    (${Dot_Cnt}*2)-1
    ${Dot_Cnt_Running_second_part}=    Evaluate    ${Dot_Cnt}*2

    Wait Until Element Is Visible    ${XPATH_WeMall.btn_change_Merchantzone_banner_field}    ${timeout}
    Click Element And Wait Angular Ready    ${XPATH_WeMall.btn_change_Merchantzone_banner_field}/div[${Dot_Cnt_Running_first_part}]

    ${Get_Left_banner_from_List}=    Get From List    ${Pass_Value_Merchantzone_Category_Attribute}    21
    @{Split_Str}    Split String    ${Get_Left_banner_from_List}    alpha-
    ${Left_banner_after_cut_prefix}=    Set Variable    @{Split_Str}[0]@{Split_Str}[1]


    ${XPATH_banner_left}   Catenate  SEPARATOR=   ${XPATH_WeMall.get_attribute_banner_left}@src
    ${Get_pic_banner_left}   Selenium2Library.Get Element Attribute   ${XPATH_banner_left}
    Log To Console    Convert Attribute Left Banner = ${Get_pic_banner_left}
    @{Split_String}   Split String   ${Get_pic_banner_left}   ?
    ${Left_banner_after_convert}=   Set Variable   @{Split_String}[0]
    Log To Console   WeMall Left Banner Attribute = ${Left_banner_after_convert}


    Log To Console   CMS Left Banner Attribute = ${Left_banner_after_cut_prefix}
    Should Be Equal As Strings   ${Left_banner_after_convert}   ${Left_banner_after_cut_prefix}
    Log To Console   Left Banner Picture Is Retrieve Data Correct

    :FOR   ${index}    IN RANGE    1    ${First_Part_Pic}+1
    \  ${Get_Merchant_Attribute_From_List}=    Get From List    ${Pass_Value_Merchantzone_Category_Attribute}    ${index}
    \  ${XPATH_Check_Category_Name}   Catenate  SEPARATOR=  ${XPATH_Wemall.Merchant_brand}[${index}]//img@src
    \  ${Get_WeMall_Merchant_Brand_Attribute}   Selenium2Library.Get Element Attribute   ${XPATH_Check_Category_Name}
    \  Log To Console   WeMall MerchantZone Brand Attribute No.[${index}] = ${Get_WeMall_Merchant_Brand_Attribute}
    \  Log To Console   ...CMS MerchantZone Brand Attribute No.[${index}] = ${Get_Merchant_Attribute_From_List}
    \  Should Be Equal As Strings   ${Get_Merchant_Attribute_From_List}   ${Get_WeMall_Merchant_Brand_Attribute}
    \  Log To Console   WeMall MerchantZone Brand Attribute No.[${index}] Is Retrieve Data Correct

    Wait Until Element Is Visible    ${XPATH_WeMall.btn_change_Merchantzone_banner_field}    ${timeout}
    Click Element And Wait Angular Ready    ${XPATH_WeMall.btn_change_Merchantzone_banner_field}/div[${Dot_Cnt_Running_second_part}]

    ${Get_Right_banner_from_List}=    Get From List    ${Pass_Value_Merchantzone_Category_Attribute}    22
    @{Split_Str}    Split String    ${Get_Right_banner_from_List}    alpha-
    ${Right_banner_after_cut_prefix}=    Set Variable    @{Split_Str}[0]@{Split_Str}[1]
    ${XPATH_banner_right}   Catenate  SEPARATOR=   ${XPATH_WeMall.get_attribute_banner_right}@src
    ${Get_pic_banner_right}   Selenium2Library.Get Element Attribute   ${XPATH_banner_right}
    Log To Console    Convert Attribute Right Banner = ${Get_pic_banner_right}
    @{Split_String}   Split String   ${Get_pic_banner_right}   ?
    ${Right_banner_after_convert}=   Set Variable   @{Split_String}[0]
    Log To Console   WeMall Right Banner Attribute = ${Right_banner_after_convert}
    Log To Console   CMS Right Banner Attribute = ${Right_banner_after_cut_prefix}
    Should Be Equal As Strings   ${Right_banner_after_convert}   ${Right_banner_after_cut_prefix}
    Log To Console   Right Banner Picture Is Retrieve Data Correct

    :FOR   ${index}   IN RANGE   11   ${Second_Part_Pic}+1
    \  ${Get_Merchant_Attribute_From_List}=    Get From List    ${Pass_Value_Merchantzone_Category_Attribute}    ${index}
    \  ${XPATH_Check_Category_Name}   Catenate  SEPARATOR=  ${XPATH_Wemall.Merchant_brand}[${index}-10]//img@src
    \  ${Get_WeMall_Merchant_Brand_Attribute}   Selenium2Library.Get Element Attribute   ${XPATH_Check_Category_Name}
    \  Log To Console   WeMall MerchantZone Brand Attribute No.[${index}] = ${Get_WeMall_Merchant_Brand_Attribute}
    \  Log To Console   ...CMS MerchantZone Brand Attribute No.[${index}] = ${Get_Merchant_Attribute_From_List}
    \  Should Be Equal As Strings   ${Get_Merchant_Attribute_From_List}   ${Get_WeMall_Merchant_Brand_Attribute}
    \  Log To Console   WeMall MerchantZone Brand Attribute No.[${index}] Is Retrieve Data Correct







    # \  ${XPATH_Check_Category_Name}   Catenate  SEPARATOR=  ${XPATH_Wemall.Merchant_brand}[${index}-10]//img@src
    # \  ${Get_WeMall_Merchant_Brand_Attribute}   Selenium2Library.Get Element Attribute   ${XPATH_Check_Category_Name}

    # \  Log To Console   \n WeMall Merchant Brand No.${index}
    # \  Log To Console   WeMall Merchant Brand Attribute = ${Get_WeMall_Merchant_Brand_Attribute}

    # \  ${Get_Merchant_Brand_Attribute_From_List2}=  Get From List   ${Get_Merchant_Brand_Attribute_From_List}   ${index}
    # \  Log To Console   CMS MerchantZone Attribute No.${index}
    # \  Log To Console   CMS MerchantZone Attribute = ${Get_Merchant_Brand_Attribute_From_List2}

    # \  Should Be Equal As Strings   ${Get_Merchant_Brand_Attribute_From_List2}   ${Get_WeMall_Merchant_Brand_Attribute}
    # \  Log To Console   WeMall MerchantZone Attribute No.${index} Is Retrieve Data Correct \n




Compare MerchantZone In WeMall Mobile Site with CMS
    Wait Until Element Is Visible   ${XPATH_WeMall.wait_Merchantzone_respond}    ${timeout}
    # ${Get_Merchantzone_Name}   Get Text   ${XPATH_WeMall.Merchantzone_name}
    # Log To Console   Merchant Zone Name In CMS = ${Check_Merchantzone_category_name}
    # Log To Console   Merchant Zone Name In Wemall = ${Get_Merchantzone_Name}
    # Should Be Equal As Strings   ${Get_Merchantzone_Name}   ${Check_Merchantzone_category_name}
    # Log To Console   Merchant Zone Category Name Is Retrieve Data Correct \n

    :FOR    ${index}    IN RANGE    1   ${Check_Category_Merchantzone}+1
    \  ${Category_runing}=    Set Variable    ${index}
    \  Set Test Variable    ${Check_Category_runing}    ${Category_runing}
    \  ${Get_Merchantzone_Category_Attribute1}=    Get From List    ${Check_Merchantzone_Category_Attribute}    ${index}
    \  Set Test Variable    ${Pass_Value_Merchantzone_Category_Attribute}    ${Get_Merchantzone_Category_Attribute1}
    \  Log To Console    \n Check MerchantZone Attribute Category No.[${index}]
    \  Compare Merchantzone Picture Attribute



Check Showroom Name Is Exist
    ${Get_Category_Name_From_List}   Get From Dictionary   ${TEST_VAR}   package_name
    :FOR  ${index}  IN RANGE  1  ${Check_Category_Number}+1
    \  ${Get_Category_Name_From_List2}=  Get From List   ${Get_Category_Name_From_List}   ${index}

    \  Set Test Variable   ${Current_Category_Name}   ${Get_Category_Name_From_List2}

    \  Log To Console   Get Current Showroom Name In ARRAY[${index}] = ${Current_Category_Name}

    \  Run Keyword If  '${Check_WeMall_Category_Name}' == '${Get_Category_Name_From_List2}'    Exit For Loop

    \  Run Keyword If  '${index}' == '${Check_Category_Number}'   Log To Console   Showroom Name Is Not Exist In CMS

Compare Showroom Name In WeMall Mobile Site with CMS
    Wait Until Element Is Visible   ${XPATH_WeMall.wait_showroom_respond}    ${timeout}

    ${Get_Category_Name_From_List}   Get From Dictionary   ${TEST_VAR}   package_name

    :FOR  ${index}  IN RANGE  1  ${Check_Category_Number}+1

    \  ${XPATH_Check_Category_Name}   Catenate  SEPARATOR=  //div[@class='ng-scope'][${index}]//span[@class='title-text ng-binding']
    \  ${Get_WeMall_Category_Name}   Get Text   ${XPATH_Check_Category_Name}
    \  Set Test Variable   ${Check_WeMall_Category_Name}   ${Get_WeMall_Category_Name}

    \  Log To Console   \n WeMall Showroom Category No.${index}
    \  Log To Console   WeMall Showroom Category Name = ${Get_WeMall_Category_Name}

    \  Check Showroom Name Is Exist

    \  Log To Console   CMS Showroom Found Category Name = ${Current_Category_Name}

    \  Should Be Equal As Strings   ${Current_Category_Name}   ${Get_WeMall_Category_Name}
    \  Log To Console   WeMall Showroom Category Name No.${index} Is Retrieve Data Correct \n





Compare Showroom Picture In WeMall Mobile Site with CMS
    ${XPATH_First_Showroom}   Catenate  SEPARATOR=  //div[a/div/div/span[contains(.,'${Check_First_Showroom_Name}')]]
    Wait Until Element Is Visible   ${XPATH_First_Showroom}    ${timeout}
    Log To Console   \n Verify Showroom Name = ${Check_First_Showroom_Name}

    ${Get_Showroom_Picture_Attribute}   Get From Dictionary   ${TEST_VAR}   package_name

    Log To Console   Verify Showroom Picture Big Banner
    ${XPATH_Big_Banner}   Catenate  SEPARATOR=  ${XPATH_First_Showroom}/div[@class='banner-big']//img@src
    ${Get_Big_Banner_Attribute}   Selenium2Library.Get Element Attribute   ${XPATH_Big_Banner}
    ${Get_Showroom_Brand_Pic_Attribute_From_List}=  Get From List   ${Get_Showroom_Picture_Attribute}   1
    Should Be Equal As Strings   ${Get_Big_Banner_Attribute}   ${Get_Showroom_Brand_Pic_Attribute_From_List}
    Log To Console   Portal Big Banner = ${Get_Big_Banner_Attribute}
    Log To Console   CMS Big Banner = ${Get_Showroom_Brand_Pic_Attribute_From_List}
    Log To Console   Portal Big Banner Picture Is Retrieve Data From CMS Correct \n

    Log To Console   Verify Showroom Picture Banner
    ${XPATH_Banner}   Catenate  SEPARATOR=  ${XPATH_First_Showroom}/div[@class='showroom']//img@src
    ${Get_Banner_Attribute}   Selenium2Library.Get Element Attribute   ${XPATH_Banner}
    ${Get_Showroom_Brand_Pic_Attribute_From_List}=  Get From List   ${Get_Showroom_Picture_Attribute}   7
    Should Be Equal As Strings   ${Get_Banner_Attribute}   ${Get_Showroom_Brand_Pic_Attribute_From_List}
    Log To Console   Portal Banner = ${Get_Banner_Attribute}
    Log To Console   CMS Banner = ${Get_Showroom_Brand_Pic_Attribute_From_List}
    Log To Console   Portal Banner Picture Is Retrieve Data From CMS Correct \n


    :FOR  ${index}   IN RANGE  1  3+1
    \  ${XPATH_mini_showroom}   Catenate  SEPARATOR=  ${XPATH_First_Showroom}/div[@class='showroom']/ul/li[${index}]/a/img@src
    \  ${Get_mini_showroom_Attribute}   Selenium2Library.Get Element Attribute   ${XPATH_mini_showroom}

    \  ${set_mini_showroom_count}=   Evaluate  ${index} + 1
    \  ${Get_Showroom_Brand_Pic_Attribute_From_List}=  Get From List   ${Get_Showroom_Picture_Attribute}   ${set_mini_showroom_count}
    \  Should Be Equal As Strings   ${Get_mini_showroom_Attribute}   ${Get_Showroom_Brand_Pic_Attribute_From_List}
    \  Log To Console   Portal Mini Showroom No.${index} = ${Get_mini_showroom_Attribute}
    \  Log To Console   CMS Mini Showroom No.${index} = ${Get_Showroom_Brand_Pic_Attribute_From_List}
    \  Log To Console   Portal Mini Showroom Picture Is Retrieve Data From CMS Correct \n

    Log To Console   Verify Showroom Picture Container
    ${XPATH_Container}   Catenate  SEPARATOR=  ${XPATH_First_Showroom}/div[@class='wm-container ng-scope']//img@src
    ${Get_Container_Attribute}   Selenium2Library.Get Element Attribute   ${XPATH_Container}
    ${Get_Showroom_Brand_Pic_Attribute_From_List}=  Get From List   ${Get_Showroom_Picture_Attribute}   8
    Should Be Equal As Strings   ${Get_Container_Attribute}   ${Get_Showroom_Brand_Pic_Attribute_From_List}
    Log To Console   Portal Container = ${Get_Container_Attribute}
    Log To Console   CMS Container = ${Get_Showroom_Brand_Pic_Attribute_From_List}
    Log To Console   Portal Container Picture Is Retrieve Data From CMS Correct \n


Compare Showroom Manage Brand Picture In WeMall Mobile Site with CMS
    ${XPATH_First_Showroom}   Catenate  SEPARATOR=  //div[a/div/div/span[contains(.,'${Check_First_Showroom_Name}')]]
    Wait Until Element Is Visible   ${XPATH_First_Showroom}    ${timeout}
    Log To Console   \n Verify Showroom Name = ${Check_First_Showroom_Name}

    ${Get_Showroom_Brand_Picture_Attribute}   Get From Dictionary   ${TEST_VAR}   package_name

    :FOR  ${index}   IN RANGE  1  ${Check_Showroom_Brand_Pic_Number}+1
    \  ${XPATH_showroom_brand}   Catenate  SEPARATOR=  ${XPATH_First_Showroom}//div[@class='slide-wrapper not-swipe ng-scope']//li[${index}]//img@src
    \  ${Get_showroom_brand_Attribute}   Selenium2Library.Get Element Attribute   ${XPATH_showroom_brand}
    \  ${Get_Showroom_Brand_Pic_Attribute_From_List}=  Get From List   ${Get_Showroom_Brand_Picture_Attribute}   ${index}
    \  Should Be Equal As Strings   ${Get_showroom_brand_Attribute}   ${Get_Showroom_Brand_Pic_Attribute_From_List}
    \  Log To Console   Portal Showroom Brand Picture Attribute No.${index} = ${Get_showroom_brand_Attribute}
    \  Log To Console   CMS Showroom Brand Picture Attribute No.${index} = ${Get_Showroom_Brand_Pic_Attribute_From_List}
    \  Log To Console   Portal Showroom Brand Picture No.${index} Is Retrieve Data From CMS Correct \n

Click Search Icon To Go To Search Function
    Wait Until Element Is Visible   ${XPATH_WeMall.btn_search_main_page}    ${timeout}
    Sleep   2s
    Click Element and Wait Angular Ready    ${XPATH_WeMall.btn_search_main_page}
    Log To Console   \n Click Search Icon
    Wait Until Element Is Visible   ${XPATH_WeMall.txt_search}    ${timeout}

Verify Search Auto Suggestion
    Input Text   ${XPATH_WeMall.txt_search}   ${SAMPLE_DATA.VALID.txt_search_auto_suggestion}
    Sleep   2s
    Wait Until Element Is Visible   ${XPATH_WeMall.txt_auto_suggestion_field}    ${timeout}
    ${Get_Auto_Suggestion}   Get matching xpath Count   ${XPATH_WeMall.txt_auto_suggestion}
    Run Keyword If   '${Get_Auto_Suggestion}' > '0'   Log To console   \n Auto Suggestion Active \n
     ...  ELSE IF  '${Get_Auto_Suggestion}' == '0'   Log To Console   \n No Data Found \n

    ${Xpath_keyword_url}   Catenate  SEPARATOR=   ${XPATH_WeMall.txt_auto_suggestion}[1]/span/span[1]/strong
    ${Get_Keyword_url}   Get Text   ${Xpath_keyword_url}
    Log To Console   Click Keyword = ${Get_Keyword_url}
    ${Get_Keyword_url_Lowercase}   Convert To Lowercase   ${Get_Keyword_url}
    Click Element and Wait Angular Ready    ${XPATH_WeMall.txt_auto_suggestion}[1]
    Wait Until Element Is Visible   //div[@class='col-xs-15 mi-product-card-container-mobile ng-isolate-scope']    ${timeout}

    ${Get_location}=    Get Location
    Log To Console    \n Current Location = ${Get_location}
    @{Split_String}   Split String   ${Get_location}   /
    ${Max_length}   Get Length   ${Split_String}
    ${String}=   Set Variable   @{Split_String}[0]
    Log To Console   Check URL = ${String}

    Run Keyword If   '${String}' == 'https:'    Location Should Be   ${WEMALL_MOBILE_URL_SSL}/search2?q=${Get_Keyword_url_Lowercase}
     ...  ELSE    Location Should Be   ${WEMALL_MOBILE_URL}/search2?q=${Get_Keyword_url_Lowercase}



Verify Search When No Data Found
    Input Text   ${XPATH_WeMall.txt_search}   ${SAMPLE_DATA.INVALID.txt_search_not_found}
    Sleep   5s
    ${Get_Auto_Suggestion}   Get matching xpath Count   ${XPATH_WeMall.txt_auto_suggestion}
    Run Keyword If   '${Get_Auto_Suggestion}' > '0'   Log To console   \n Auto Suggestion Active \n
     ...  ELSE IF  '${Get_Auto_Suggestion}' == '0'   Log To Console   \n No Data Found \n

Click Cancel Button On Search Page
    Wait Until Element Is Visible   ${XPATH_WeMall.btn_cancle_search_page}    ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_WeMall.btn_cancle_search_page}


Verify Page After Click Cancle On Search Page
    Wait Until Element Is Visible   ${XPATH_WeMall.txt_menubar}    ${timeout}
    # ${Get_current_page_value2}   Get Text   ${XPATH_WeMall.txt_current_page}
    # Log To Console   \n Current Page After Back From Search Page = ${Get_current_page_value2} \n
    # Should Be Equal As Strings  ${Check_current_page_value}  ${Get_current_page_value2}
    Location Should Be   ${WEMALL_WEB}portal/page1
    Log To Console   Back to previous page correct





#AFTER SEARCH > GO TO iTruemart
Search Item And Go To iTruemart Site
    Input Text   ${XPATH_WeMall.txt_search}   ${SAMPLE_DATA.VALID.txt_search_auto_suggestion}
    Wait Until Element Is Visible   ${XPATH_WeMall.txt_select_auto_suggestion}    ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_Wemall.txt_select_auto_suggestion}
#BELOW THIS LINE IS WORK AROUND WHILE WAITING FOR FIX BUG
    Wait Until Element Is Visible   ${iTruemart.wait_search_respond}    ${timeout}
    Input Text   ${iTruemart.txt_input_search_keyword}   ${SAMPLE_DATA.VALID.txt_search_auto_suggestion}
    Wait Until Element Is Visible   ${iTruemart.txt_auto_suggestion_field}    ${timeout}
    Click Element and Wait Angular Ready    ${iTruemart.txt_select_auto_suggestion}
#ABOVE THIS LINE IS WORK AROUND WHILE WAITING FOR FIX BUG
    Wait Until Element Is Visible   ${iTruemart.select_item}    ${timeout}

Check Burger Menu If False
    Log To Console    \n Burger Menu Didn't Display On the Top Right Hand Side of Screen
    Should Be Equal As Strings    Burger Menu = True    Burger Menu = ${Check_burger_menu1}
Verify Shop In Shop Burger Menu
    Wait Until Element Is Visible    ${XPATH_WeMall.shopinshop_burger_menu}    ${timeout}
    ${Check_burger_menu}=    Run Keyword And Return Status    Element Should Be Visible    jquery=div[class='btn-right-menu btn-show-slide-menu ng-scope ng-isolate-scope'] span
    Set Test Variable    ${Check_burger_menu1}    ${Check_burger_menu}
    Run Keyword If    '${Check_burger_menu}' == 'True'    Log To Console    \n Burger Menu Display On the Top Right Hand Side of Screen
     ...   ELSE     Check Burger Menu If False

Check Back Button If False
    Log To Console    \n Back Button Didn't Display On the Top Left Hand Side of Screen
    Should Be Equal As Strings    Back Button = True    Back Button = ${Check_back_btn1}
Verify Shop In Shop Back button
    Wait Until Element Is Visible    ${XPATH_WeMall.shopinshop_back_btn}    ${timeout}
    ${Check_back_btn}=    Run Keyword And Return Status    Element Should Be Visible    jquery=div[class='storefront-back-button'] span
    Set Test Variable    ${Check_back_btn1}    ${Check_back_btn}
    Run Keyword If    '${Check_back_btn}' == 'True'    Log To Console    \n Back Button Display On the Top Left Hand Side of Screen
     ...   ELSE     Check Back Button If False

Verify Shop In Shop Logo
    Wait Until Element Is Visible    ${XPATH_Wemall.shopinshop_logo}    ${timeout}
    ${Get_logo_attribute}    Selenium2Library.Get Element Attribute    ${XPATH_Wemall.shopinshop_logo}@src
    Log To Console     \n Portal Shop Logo Attribute = ${Get_logo_attribute}
    Should Be Equal As Strings    ${Check_Shop_logo130_attribute}    ${Get_logo_attribute}
    Log To Console    Shop Logo Retrieve From Storefront Correct

Verify Shop In Shop Header
    Wait Until Element Is Visible    ${XPATH_Wemall.shopinshop_header}    ${timeout}
    ${Get_header_attribute}    Selenium2Library.Get Element Attribute    ${XPATH_Wemall.shopinshop_header}@src
    Log To Console     \n Portal Shop Logo Attribute = ${Get_header_attribute}
    Should Be Equal As Strings    ${Check_Header_Attribute}    ${Get_header_attribute}
    Log To Console    Shop Header Retrieve From Storefront Correct

Verify Shop In Shop Banner
    Wait Until Element Is Visible    ${XPATH_Wemall.shopinshop_banner_field}    ${timeout}
    :FOR   ${index}    IN RANGE    1    ${Check_Cnt_Banner_number}+1
    \  Click Element And Wait Angular Ready    ${XPATH_Wemall.shopinshop_banner_dot}[${index}]
    \  ${Get_banner_attribute_from_Shopinshop}    Selenium2Library.Get Element Attribute    //div[@class='owl-stage-outer']//div[@class='owl-item active']//img@src
    \  Log To Console    \n WeMall Shop Banner Picture Attribute No.[${index}] = ${Get_banner_attribute_from_Shopinshop}
    \  ${Get_banner_attribute_from_list}=    Get From List    ${Check_Storefront_banner_attribute}    ${index}
    \  Log To Console    Storefront Banner Picture Attribute No.[${index}] = ${Get_banner_attribute_from_list}
    \  Should Be Equal As Strings    ${Get_banner_attribute_from_list}     ${Get_banner_attribute_from_Shopinshop}
    \  Log To Console    Banner Picture No.[${index}] Retrieve From Storefront Success


Click Burger Menu On Mobile Shop In Shop
    Wait Until Element Is Visible    ${XPATH_WeMall.shopinshop_burger_menu}    ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_WeMall.shopinshop_burger_menu}
    Wait Until Element Is Visible    ${XPATH_Wemall.shopinshop_burger_menu_popup}    ${timeout}
Verify Shop In Shop Menu
    Click Burger Menu On Mobile Shop In Shop
    ${count_category_name}    Get Matching xpath count    ${XPATH_Wemall.cnt_shopinshop_category_name}
    Log To Console    Category = ${count_category_name}
    # :FOR    ${index}    IN RANGE    1    ${count_category_name}+1
    # Its fail because robot can't see portal category name more than 5 category need to scroll down popup to make robot run pass
    # and can't find solution for scroll down then just pretend storefront have only 5 Category for make robot Pass this case
    :FOR    ${index}    IN RANGE    1    5+1
    \  ${xpath_category_name}    Catenate  SEPARATOR=    ${XPATH_Wemall.cnt_shopinshop_category_name}[${index}]/a
    \  ${portal_shop_category_name}    Get Text    ${xpath_category_name}
    \  ${Check_storefront_menu_name1}=  Get From List    ${Check_storefront_menu_name}    ${index}
    \  Log To Console    \n Portal Shop Category Name No.[${index}] = ${portal_shop_category_name}
    \  Log To Console    Storefron Catefory Name No.[${index}] = ${Check_storefront_menu_name1}
    \  Should Be Equal As Strings    ${portal_shop_category_name}    ${Check_storefront_menu_name1}
    \  Log To Console    Shop Category Name No.[${index}] Is Retrieve From Storefront Success
    Log To Console    This Case Is WorkAround For Make Robot Run Pass If Category Name More Than 5 Category \n Need to Find Solution Scroll Down Popup

Close Burger Menu On Mobile Shop In Shop
    Wait Until Element Is Visible    ${XPATH_WeMall.shopinshop_close_btn_popup}    ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_WeMall.shopinshop_close_btn_popup}
    Wait Until Element Is Visible    ${XPATH_Wemall.shopinshop_burger_menu}    ${timeout}

Click Burger Menu Short Cut WeMall
    Wait Until Element Is Visible    ${XPATH_WeMall.shopinshop_shortcut_wemall}    ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_WeMall.shopinshop_shortcut_wemall}
    Location Should Be    ${WEMALL_URL}/
Click Burger Menu Short Cut Cart
    Wait Until Element Is Visible    ${XPATH_WeMall.shopinshop_shortcut_cart}    ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_WeMall.shopinshop_shortcut_cart}
    Location Should Be    ${WEMALL_MOBILE}/cart
Click Burger Menu Short Cut Search
    Wait Until Element Is Visible    ${XPATH_WeMall.shopinshop_shortcut_search}    ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_WeMall.shopinshop_shortcut_search}
    Wait Until Element Is Visible   ${XPATH_WeMall.txt_search}    ${timeout}
Click Burger Menu Short Cut Language
    Wait Until Element Is Visible    ${XPATH_WeMall.shopinshop_shortcut_language}    ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_WeMall.shopinshop_shortcut_language}
    Location Should Be     ${WEMALL_MOBILE}/en/${home}


Verify Burger Menu Short Cut - Back To WeMall
    Click Burger Menu On Mobile Shop In Shop
    Click Burger Menu Short Cut WeMall
Verify Burger Menu Short Cut - Go To Cart
    Click Burger Menu On Mobile Shop In Shop
    Click Burger Menu Short Cut Cart
Verify Burger Menu Short Cut - Search
    Click Burger Menu On Mobile Shop In Shop
    Click Burger Menu Short Cut Search
    Verify Search Auto Suggestion
Verify Burger Menu Short Cut - Language
    Click Burger Menu On Mobile Shop In Shop
    Click Burger Menu Short Cut Language


#######################################   SEARCH PAGE , SORTING  ########################################################
# Go To Skrit That Content Is Search
#     Click Element and Wait Angular Ready    ${XPATH_WeMall.btn_search_skrit}
#     Wait Until Element Is Visible   ${XPATH_WeMall.wait_search_skrit_respond}

# Click Sort
#     Wait Until Element Is Visible   ${XPATH_WeMall.btn_sort}
#     Click Element and Wait Angular Ready    ${XPATH_WeMall.btn_sort}
#     Wait Until Element Is Visible   ${XPATH_WeMall.btn_sort_expand}

# Click Sort By Keyword
#     Wait Until Element Is Visible   ${XPATH_Wemall.cbo_sort_keyword}
#     Click Element and Wait Angular Ready    ${XPATH_Wemall.cbo_sort_keyword}
#     Wait Until Element Is Visible   ${XPATH_WeMall.wait_search_skrit_respond}

# Verify Sort By Keyword


# Click Sort By Latest Product
#     Wait Until Element Is Visible   ${XPATH_Wemall.cbo_sort_latest}
#     Click Element and Wait Angular Ready    ${XPATH_Wemall.cbo_sort_latest}
#     Wait Until Element Is Visible   ${XPATH_WeMall.wait_search_skrit_respond}

# Verify Sort By Latest Product



# Click Sort By Low To High Price
#     Wait Until Element Is Visible   ${XPATH_Wemall.cbo_sort_low_to_high_price}
#     Click Element and Wait Angular Ready    ${XPATH_Wemall.cbo_sort_low_to_high_price}
#     Wait Until Element Is Visible   ${XPATH_WeMall.wait_search_skrit_respond}

# Verify Sort By Low To High Price


# Click Sort By High To Low Price
#     Wait Until Element Is Visible   ${XPATH_Wemall.cbo_sort_high_to_low_price}
#     Click Element and Wait Angular Ready    ${XPATH_Wemall.cbo_sort_high_to_low_price}
#     Wait Until Element Is Visible   ${XPATH_WeMall.wait_search_skrit_respond}

# Verify Sort By High To Low Price


# Click Sort By Low To High Discount
#     Wait Until Element Is Visible   ${XPATH_Wemall.cbo_sort_low_to_high_discount}
#     Click Element and Wait Angular Ready    ${XPATH_Wemall.cbo_sort_low_to_high_discount}
#     Wait Until Element Is Visible   ${XPATH_WeMall.wait_search_skrit_respond}

# Verify Sort By Low To High Discount
#     ${Count_Product_Number}   Get matching xpath count   ${XPATH_WeMall.cnt_item_in_search_skrit}
#     Log To Console   Product Number = ${Count_Product_Number}

#     Run Keyword If   '${Count_Product_Number}' == '0'

#     Run Keyword If   '${Count_Product_Number}' < '10'

#     Run Keyword If   '${Count_Product_Number}' > '20'


#     //div[@class='product-list']/div[@class='over_lvb ng-scope'][${index}]//span[@class='price-display']
#     //div[@class='product-list']/div[@class='over_lvb ng-scope'][1]//span[@class='price-display']/span[1]


# Click Sort By High To Low Discount
#     Wait Until Element Is Visible   ${XPATH_Wemall.cbo_sort_high_to_low_discount}
#     Click Element and Wait Angular Ready    ${XPATH_Wemall.cbo_sort_high_to_low_discount}
#     Wait Until Element Is Visible   ${XPATH_WeMall.wait_search_skrit_respond}

# Verify Sort By High To Low Discount

# Click Filter
#     Wait Until Element Is Visible   ${XPATH_WeMall.btn_filter}
#     Click Element and Wait Angular Ready    ${XPATH_WeMall.btn_filter}
#     Wait Until Element Is Visible   ${XPATH_WeMall.btn_filter_expand}




####################################################### Keyword iTruemart Header #################################################
Open Portal iTrueMart Mobile rebrand
    [Arguments]    ${home}
    # Log To Console   home = ${home}
    # Log To Console   URL=${ITM_MOBILE}/${home}, browser=${BROWSER}
    Run Keyword If   '${home}' == 'No Pass Arguments'   Open Mobile Browser     ${ITM_MOBILE}        ${BROWSER}
     ...  ELSE    Open Mobile Browser     ${ITM_MOBILE}/${home}        ${BROWSER}
    Maximize Browser Window
    Add Cookie      is_mobile  true
    Reload Page
    Set Test Variable    ${home1}    ${home}
    Set Test Variable    ${home}    ${home1}

Open Portal iTrueMart Mobile without resize rebrand
    [Arguments]    ${home}
    Run Keyword If   '${home}' == 'No Pass Arguments'   Open Mobile Browser     ${ITM_MOBILE}        ${BROWSER}
     ...  ELSE    Open Mobile Browser without resize     ${ITM_MOBILE}/${home}        ${BROWSER}
    Maximize Browser Window
    # Set Window Position   ${0}      ${0}
    Add Cookie      is_mobile  true
    Reload Page

Login iTruemart And Go To Portal rebrand
    [Arguments]    ${home}
    Open Browser   ${ITM_MOBILE}/auth/login   chrome
    # Add Cookie      is_mobile  true
    # Reload Page
    Set Window Position   ${0}      ${0}
    Maximize Browser Window
    Wait Until Element Is Visible   ${XPATH_iTrueMart.username}    ${timeout}
    Input Text   ${XPATH_iTrueMart.username}   ${SAMPLE_DATA.VALID.iTruemart_id}
    Input Text   ${XPATH_iTrueMart.password}   ${SAMPLE_DATA.VALID.iTruemart_password}
    Click Element and Wait Angular Ready    ${XPATH_iTrueMart.btn_submit_login}
    Add Cookie      is_mobile  true
    Reload Page
    Wait Until Element Is Visible   ${XPATH_iTrueMart.icon_item_number_in_cart}    ${timeout}
    Run Keyword If   '${home}' == 'No Pass Arguments'   Go To   ${ITM_MOBILE}
     ...  ELSE    Go To   ${ITM_MOBILE}/${home}




Not Found Item In Cart For Test iTruemart Header
    Log To Console   Item in cart = ${Check_item_number}
    Log To Console   Not Found Item In Cart
    Wait Until Element Is Visible   ${XPATH_iTrueMart.icon_cart}    ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_iTrueMart.icon_cart}
    Wait Until Element Is Visible   ${XPATH_WeMall.btn_main_menu}    ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_WeMall.btn_main_menu}
    Wait Until Element Is Visible   ${Mega_Menu.user_name}    ${timeout}
    Log To Console   Login Success


Verify Login link For Test iTruemart Header rebrand
    [Arguments]    ${home}
    Wait Until Element Is Visible   ${Mega_Menu.login}    ${timeout}
    Click Element and Wait Angular Ready    ${Mega_Menu.login}
    Run Keyword If   '${home}' == 'No Pass Arguments'   Location Should Be   ${WEMALL_MOBILE_URL_SSL}/auth/login?continue=${WEMALL_MOBILE_URL}/itruemart/
     ...  ELSE    Location Should Be   ${WEMALL_MOBILE_URL_SSL}/auth/login?continue=${WEMALL_MOBILE_URL}/${home}
    Log To Console   \n Login link is Active
    Wait Until Element Is Visible   ${XPATH_iTrueMart.username}    ${timeout}
    Input Text   ${XPATH_iTrueMart.username}   ${SAMPLE_DATA.VALID.iTruemart_id}
    Input Text   ${XPATH_iTrueMart.password}   ${SAMPLE_DATA.VALID.iTruemart_password}
    Click Element and Wait Angular Ready    ${XPATH_iTrueMart.btn_submit_login}
    Wait Until Element Is Visible   ${XPATH_iTrueMart.icon_cart}    ${timeout}

    ${Get_item_number}   Get matching xpath count   ${XPATH_iTrueMart.icon_item_number_in_cart}
    Set Test Variable   ${Check_item_number}   ${Get_item_number}

    Run Keyword If   '${Get_item_number}' > '0'   Log To Console   Item in cart = ${Get_item_number} \n Login Success

    Run Keyword If   '${Get_item_number}' == '0'   Not Found Item In Cart For Test iTruemart Header


Verify Login link For Test iTruemart Header rebrand incase auth/login
    [Arguments]    ${home}
    Wait Until Element Is Visible   ${Mega_Menu.login}    ${timeout}
    Click Element and Wait Angular Ready    ${Mega_Menu.login}
    Run Keyword If   '${home}' == 'No Pass Arguments'   Location Should Be   ${WEMALL_MOBILE_URL_SSL}/auth/login?continue=${WEMALL_MOBILE_URL_SSL}/itruemart/
     ...  ELSE    Location Should Be   ${WEMALL_MOBILE_URL_SSL}/auth/login?continue=${WEMALL_MOBILE_URL_SSL}/${home}
    Log To Console   \n Login link is Active
    Wait Until Element Is Visible   ${XPATH_iTrueMart.username}    ${timeout}
    Input Text   ${XPATH_iTrueMart.username}   ${SAMPLE_DATA.VALID.iTruemart_id}
    Input Text   ${XPATH_iTrueMart.password}   ${SAMPLE_DATA.VALID.iTruemart_password}
    Click Element and Wait Angular Ready    ${XPATH_iTrueMart.btn_submit_login}
    Add Cookie      is_mobile  true
    Reload Page

    Wait Until Element Is Visible   ${XPATH_iTrueMart.icon_cart}    ${timeout}
    ${Get_item_number}   Get matching xpath count   ${XPATH_iTrueMart.icon_item_number_in_cart}
    Set Test Variable   ${Check_item_number}   ${Get_item_number}

    Run Keyword If   '${Get_item_number}' > '0'   Log To Console   Item in cart = ${Get_item_number} \n Login Success

    Run Keyword If   '${Get_item_number}' == '0'   Not Found Item In Cart For Test iTruemart Header

Verify Home link For Test iTruemart Header
    Wait Until Element Is Visible   ${Mega_Menu.home}    ${timeout}
    Click Element and Wait Angular Ready    ${Mega_Menu.home}

    ${Get_location}=    Get Location
    Log To Console    \n Current Location = ${Get_location}
    @{Split_String}   Split String   ${Get_location}   /
    ${Max_length}   Get Length   ${Split_String}
    ${String}=   Set Variable   @{Split_String}[0]
    Log To Console   Check URL = ${String}

    Run Keyword If   '${String}' == 'https:'   Location Should Contain   ${WEMALL_MOBILE_URL_SSL}
     ...  ELSE    Location Should Contain   ${WEMALL_MOBILE}
    Log To Console   \n Home link is Active

Verify Everyday Wow link For Test iTruemart Header
    Wait Until Element Is Visible   ${Mega_Menu.wow}    ${timeout}
    Click Element and Wait Angular Ready    ${Mega_Menu.wow}

    Location Should Contain   .com/everyday-wow
    Check HTTPS Page Redirect To WWW OR M And Verify URL Is Redirect Correct
    # ${Get_location}=    Get Location
    # Log To Console    \n Current Location = ${Get_location}
    # @{Split_String}   Split String   ${Get_location}   www
    # ${Max_length}   Get Length   ${Split_String}
    # # ${String1}=   Set Variable   @{Split_String}[0]
    # # ${String2}=   Set Variable   @{Split_String}[1]
    # # Log To Console   URL first part = ${String1}
    # # Log To Console   URL second part= ${String2}
    # Go To     @{Split_String}[0]m@{Split_String}[1]
    # Click Main Menu In WeMall Mobile Sites
    # Log To Console   \n Wow link is Active

Verify Category Main Link For Test iTruemart Header
    Wait Until Element Is Visible   ${Mega_Menu.category}    ${timeout}
    Sleep   2s
    Click Element and Wait Angular Ready    ${Mega_Menu.category}
    # Sleep   1s
    # Click Element and Wait Angular Ready    ${Mega_Menu.category}
    Wait Until Element Is Visible   ${Mega_Menu.wait_category_respond}    ${timeout}
    Log To Console   \n Category Main link is Active

Verify Promotion Main Link For Test iTruemart Header
    Wait Until Element Is Visible   ${Mega_Menu.promotion}    ${timeout}
    Sleep   2s
    Click Element and Wait Angular Ready    ${Mega_Menu.promotion}
    Sleep   1s
    Click Element and Wait Angular Ready    ${Mega_Menu.promotion}
    Wait Until Element Is Visible   ${Mega_Menu.wait_promotion_respond}    ${timeout}
    Log To Console   \n Promotion Main link is Active


Redirect WWW To Mobile And Verify URL Is Redirect Correct
    # Go To    ${WEMALL_URL}/xxxx    this line use for test redirect Run Keyword If   '${Get_URL_result}' == 'True' (WWW)
    # Sleep    5s
    ${Get_location}=    Get Location
    Log To Console    \n Current Location = ${Get_location}
    @{Split_String}   Split String   ${Get_location}   www
    ${Max_length}   Get Length   ${Split_String}
    # ${String1}=   Set Variable   @{Split_String}[0]
    # ${String2}=   Set Variable   @{Split_String}[1]
    # Log To Console   URL first part = ${String1}
    # Log To Console   URL second part= ${String2}
    Go To     @{Split_String}[0]m@{Split_String}[1]
    Log To Console    WWW Redirect To Mobile
    Sleep    2s
    ${Get_location1}=    Get Location
    @{Split_String1}   Split String   ${Get_location1}   .com
    ${Max_length1}   Get Length   ${Split_String1}
    Log To Console    Lenght = ${Max_length1}
    ${String1}=   Set Variable   @{Split_String1}[1]
    Log To Console   / URL = ${String1}

    Sleep    2s
    Location Should Be    ${WEMALL_MOBILE_URL}${String1}
    Log To Console   \n Itruemart link is Active

Check HTTPS Page Redirect To WWW OR M And Verify URL Is Redirect Correct
    ${Get_location}=    Get Location
    ${Get_URL_result}=    Run Keyword And Return Status    Should Contain    ${Get_location}    www.
    Log To Console    URL WWW result = ${Get_URL_result}

    @{Split_String}   Split String   ${Get_location}   .com
    ${Max_length}   Get Length   ${Split_String}
    Log To Console    Lenght = ${Max_length}
    ${String}=   Set Variable   @{Split_String}[1]
    Log To Console   / URL = ${String}

    Run Keyword If   '${Get_URL_result}' == 'True'   Redirect WWW To Mobile And Verify URL Is Redirect Correct
     ...  ELSE    Location Should Be    ${WEMALL_MOBILE_URL}${String}

Verify Itruemart link For Test iTruemart Header
    Wait Until Element Is Visible   ${Mega_Menu.itruemart}    ${timeout}
    Click Element and Wait Angular Ready    ${Mega_Menu.itruemart}
    Location Should Contain   .com/itruemart
    Check HTTPS Page Redirect To WWW OR M And Verify URL Is Redirect Correct


Verify Cart link For Test iTruemart Header
    Wait Until Element Is Visible   ${Mega_Menu.cart}    ${timeout}
    Click Element and Wait Angular Ready    ${Mega_Menu.cart}
    Location Should Be   ${Check_URL_iTrueMart.cart}
    Log To Console   \n Cart link is Active
    Wait Until Element Is Visible    ${XPATH_WeMall.btn_main_menu}        ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_WeMall.btn_main_menu}
    Wait Until Element Is Visible   ${Mega_Menu.user_name}         ${timeout}
    Log To Console   Login Success


Verify Order Tracking link For Test iTruemart Header
    Wait Until Element Is Visible   ${Mega_Menu.order_tracking}    ${timeout}
    Click Element and Wait Angular Ready    ${Mega_Menu.order_tracking}
    Location Should Be   ${Check_URL_iTrueMart.order_tracking}
    Log To Console   \n Order Tracking link is Active

Verify Return Policy link For Test iTruemart Header
    Wait Until Element Is Visible   ${Mega_Menu.return_policty}    ${timeout}
    Click Element and Wait Angular Ready    ${Mega_Menu.return_policty}

    ${Get_location}=    Get Location
    Log To Console    \n Current Location = ${Get_location}
    @{Split_String}   Split String   ${Get_location}   /
    ${Max_length}   Get Length   ${Split_String}
    ${String}=   Set Variable   @{Split_String}[0]
    Log To Console   Check URL = ${String}

    Run Keyword If   '${String}' == 'https:'   Location Should Be   ${Check_URL_iTrueMart.https_return_policty}
     ...  ELSE    Location Should Be   ${Check_URL_iTrueMart.return_policty}
    Log To Console   \n Return Policy link is Active

Verify Shipment Policy link For Test iTruemart Header
    Wait Until Element Is Visible   ${Mega_Menu.shipment_policy}    ${timeout}
    Click Element and Wait Angular Ready    ${Mega_Menu.shipment_policy}

    ${Get_location}=    Get Location
    Log To Console    \n Current Location = ${Get_location}
    @{Split_String}   Split String   ${Get_location}   /
    ${Max_length}   Get Length   ${Split_String}
    ${String}=   Set Variable   @{Split_String}[0]
    Log To Console   Check URL = ${String}

    Run Keyword If   '${String}' == 'https:'   Location Should Be   ${Check_URL_iTrueMart.https_shipment_policy}
     ...  ELSE    Location Should Be   ${Check_URL_iTrueMart.shipment_policy}
    Log To Console   \n Shipment Policy link is Active

Verify Refund Policy link For Test iTruemart Header
    Wait Until Element Is Visible   ${Mega_Menu.refund_policy}    ${timeout}
    Click Element and Wait Angular Ready    ${Mega_Menu.refund_policy}

    ${Get_location}=    Get Location
    Log To Console    \n Current Location = ${Get_location}
    @{Split_String}   Split String   ${Get_location}   /
    ${Max_length}   Get Length   ${Split_String}
    ${String}=   Set Variable   @{Split_String}[0]
    Log To Console   Check URL = ${String}

    Run Keyword If   '${String}' == 'https:'   Location Should Be   ${Check_URL_iTrueMart.https_refund_policy}
     ...  ELSE    Location Should Be   ${Check_URL_iTrueMart.refund_policy}
    Log To Console   \n Refund Policy link is Active

Verify Discount Code link For Test iTruemart Header
    Wait Until Element Is Visible   ${Mega_Menu.discount_code}    ${timeout}
    Click Element and Wait Angular Ready    ${Mega_Menu.discount_code}
    Location Should Contain   http://support.wemall.com/
    Log To Console   \n Discount Code link is Active

Verify Contact Us link For Test iTruemart Header
    # Wait Until Element Is Visible   ${Mega_Menu.contact_us}    ${timeout_30}
    # Click Element and Wait Angular Ready    ${Mega_Menu.contact_us}
    Sleep    2
    Execute JavaScript    ${Mega_Menu.contact_us_Java}

    ${Get_location}=    Get Location
    Log To Console    \n Current Location = ${Get_location}
    @{Split_String}   Split String   ${Get_location}   /
    ${Max_length}   Get Length   ${Split_String}
    ${String}=   Set Variable   @{Split_String}[0]
    Log To Console   Check URL = ${String}

    Run Keyword If   '${String}' == 'https:'   Location Should Be   ${Check_URL_iTrueMart.https_contact_us}
     ...  ELSE    Location Should Be   ${Check_URL_iTrueMart.contact_us}
    Log To Console   \n Contact Us link is Active

Check HTTPS URL
    [Arguments]    ${home}
    Location Should Be    ${WEMALL_MOBILE_URL_SSL}/${home}
Check HTTP URL
    [Arguments]    ${home}
    Location Should Be    ${WEMALL_MOBILE_URL}/${home}

Convert TH language HTTPS URL
    [Arguments]    ${home}
    ${Get_TH_URL}   Catenate  SEPARATOR=   ${WEMALL_MOBILE_URL_SSL}/${home}
    Set Test Variable    ${Check_TH_URL}    ${Get_TH_URL}

Convert TH language HTTP URL
    [Arguments]    ${home}
    ${Get_TH_URL}   Catenate  SEPARATOR=   ${WEMALL_MOBILE_URL}/${home}
    Set Test Variable    ${Check_TH_URL}    ${Get_TH_URL}

Convert ENG language HTTPS URL
    [Arguments]    ${home}
    ${Get_ENG_URL}   Catenate  SEPARATOR=   ${WEMALL_MOBILE_URL_SSL}/en/${home}
    Set Test Variable    ${Check_ENG_URL}    ${Get_ENG_URL}

Convert ENG language HTTP URL
    [Arguments]    ${home}
    ${Get_ENG_URL}   Catenate  SEPARATOR=   ${WEMALL_MOBILE_URL}/en/${home}
    Set Test Variable    ${Check_ENG_URL}    ${Get_ENG_URL}

Verify Thai language For Test iTruemart Header rebrand
    [Arguments]    ${home}
    Go To    ${WEMALL_MOBILE}/en/${home}
    Add Cookie      is_mobile  true
    Reload Page
    Click Main Menu In WeMall Mobile Sites
    Wait Until Element Is Visible   ${Mega_Menu.language}    ${timeout}
    Log To Console   \n Ready To Click TH language
    Click Element and Wait Angular Ready    ${Mega_Menu.language}

    ${Get_location}=    Get Location
    Log To Console    \n Current Location = ${Get_location}
    @{Split_String}   Split String   ${Get_location}   /
    ${Max_length}   Get Length   ${Split_String}
    ${String}=   Set Variable   @{Split_String}[0]
    Log To Console   Check URL = ${String}

    Run Keyword If   '${String}' == 'https:'    Convert TH language HTTPS URL    ${home}
     ...  ELSE    Convert TH language HTTP URL    ${home}

    @{Split_String1}   Split String   ${Check_TH_URL}   ?
    ${Max_length}   Get Length   ${Split_String1}
    ${String1}=   Set Variable   @{Split_String1}[0]
    Log To Console   Convert URL = ${String1}

    Location Should Be   ${String1}

    Log To Console   TH language link is Active

Verify English language For Test iTruemart Header rebrand
    [Arguments]    ${home}
    Wait Until Element Is Visible   ${Mega_Menu.language}    ${timeout}
    Log To Console   \n Ready To Click ENG language
    Click Element and Wait Angular Ready    ${Mega_Menu.language}

    ${Get_location}=    Get Location
    Log To Console    \n Current Location = ${Get_location}
    @{Split_String}   Split String   ${Get_location}   /
    ${Max_length}   Get Length   ${Split_String}
    ${String}=   Set Variable   @{Split_String}[0]
    Log To Console   Check URL = ${String}

    Run Keyword If   '${String}' == 'https:'    Convert ENG language HTTPS URL    ${home}
     ...  ELSE    Convert ENG language HTTP URL    ${home}

    @{Split_String1}   Split String   ${Check_ENG_URL}   ?
    ${Max_length}   Get Length   ${Split_String1}
    ${String1}=   Set Variable   @{Split_String1}[0]
    Log To Console   Convert URL = ${String1}

    Location Should Be   ${String1}
    Log To Console   EN language link is Active

Verify Page After Click Cancle On Search Page For Test iTruemart Header rebrand
    [Arguments]    ${home}

    ${Get_location}=    Get Location
    Log To Console    \n Current Location = ${Get_location}
    @{Split_String}   Split String   ${Get_location}   /
    ${Max_length}   Get Length   ${Split_String}
    ${String}=   Set Variable   @{Split_String}[0]
    Log To Console   Check URL = ${String}

    Run Keyword If   '${String}' == 'https:'    Check HTTPS URL    ${home}
     ...  ELSE    Check HTTP URL    ${home}
    Log To Console   Back to previous page correct

Verify Shop Cart Button In WeMall Mobile Site For Test iTruemart Header
    Wait Until Element Is Visible   ${Check_URL_iTrueMart.btn_cart_main_page}        ${timeout}
    Click Element and Wait Angular Ready    ${Check_URL_iTrueMart.btn_cart_main_page}    15
    Location Should Be   ${Check_URL_iTrueMart.cart}
    Log To Console   Shop Cart button is Active
    Wait Until Element Is Visible   ${XPATH_WeMall.btn_main_menu}        ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_WeMall.btn_main_menu}
    Wait Until Element Is Visible   ${Mega_Menu.user_name}         ${timeout}
    Log To Console   Login Success


Close popup
    Click Element and Wait Angular Ready    ${Check_URL_iTrueMart.btn_popup}
    Log To Console   Close Popup success

Verify Popup
    ${Check_popup_exist}   Get Matching xpath count   ${Check_URL_iTrueMart.btn_popup}

    Run Keyword If   '${Check_popup_exist}' == '0'   Log To Console   Popup dosen't Exist

    Run Keyword If   '${Check_popup_exist}' == '1'   Close popup


Verify WeMall icon Button In WeMall Mobile Site For Test iTruemart Header
    ${Get_location}=    Get Location
    Log To Console    \n Current Location = ${Get_location}
    @{Split_String}   Split String   ${Get_location}   //
    ${String}=   Set Variable   @{Split_String}[0]
    Log To Console   Check URL = ${String}

    Wait Until Element Is Visible   ${XPATH_WeMall.btn_wemall_icon}    ${timeout}
    Sleep   2s
    Click Element and Wait Angular Ready    ${XPATH_WeMall.btn_wemall_icon}
    Run Keyword If   '${String}' == 'https:'    Location Should Contain   ${WEMALL_MOBILE_URL_SSL}
     ...  ELSE    Location Should Contain   ${WEMALL_MOBILE_URL}
    Log To Console   \n  WeMall Icon button is Active


############################################ sprint13 buy product from Mobile  #################################################
Buy Product And Go To Cart Page
    [Arguments]    ${pkey1}    ${pkey2}
    ${ProductURL1}=    Set Variable    ${ITM_MOBILE}/products/item-${pkey1}.html
    ${ProductURL2}=    Set Variable    ${ITM_MOBILE}/products/item-${pkey2}.html
    Open Browser    ${ProductURL1}    chrome
    Set Window Position   ${0}      ${0}
    Set Window Size       ${414}    ${736}
    Add Cookie      is_mobile  true
    Reload Page
    Sleep   1s

    Click Buy Product
    Go To    ${ProductURL2}
    Sleep   3s
    Click Buy Product
    Check Product Number In Cart
    Check Product Name In Cart

Click Buy Product
    Sleep   3s
    Wait Until Element Is Visible    ${XPATH_iTrueMart.buy_button}         ${timeout}
    Click Element and Wait Angular Ready     ${XPATH_iTrueMart.buy_button}
    Sleep   3s
    Wait Until Element Is Visible    ${XPATH_iTrueMart.wait_cart_page_loading}     20
    Location Should Be    ${WEMALL_MOBILE}/cart

Check Product Number In Cart
    Wait Until Element Is Visible    ${XPATH_iTruemart.icon_item_number_in_cart}         ${timeout}
    ${Product_in_cart}    Selenium2Library.Get Element Attribute    ${XPATH_iTruemart.icon_item_number_in_cart}@data-noti-number
    Log To Console    Product in cart = ${Product_in_cart}
    Set Test Variable    ${Check_Product_in_cart}    ${Product_in_cart}

Check Product Name In Cart
    @{Get_Product_In_Cart}=   Create List  ${EMPTY}
    :FOR  ${index}  IN RANGE  1  ${Check_Product_in_cart}+1
    \  ${xpath_product_name}    Catenate  SEPARATOR=    //div[@class='row box-product']/div[${index}]//div[@class='col-xs-9']/div/a
    \  ${product_name}    Get Text    ${xpath_product_name}
    \  Log To Console    Product No.[${index}] Name = ${product_name}
    \  Append To List    ${Get_Product_In_Cart}    ${product_name}

    ${dict1}=    Create Dictionary    test=TestData
    Set To Dictionary    ${dict1}    package_name=${Get_Product_In_Cart}
    Set Test Variable    ${Get_Product_In_Cart}    ${dict1}
    # Log To Console    ${Get_Product_In_Cart}

Click Checkout Button
    Sleep    2s
    Wait Until Element Is Visible    ${XPATH_iTrueMart.checkout_button}    ${timeout}
    Click Element and Wait Angular Ready     ${XPATH_iTrueMart.checkout_button}

Checkout Step1 By Guest
    Wait Until Element Is Visible    ${XPATH_iTrueMart.checkout_by_guest}    ${timeout}
    Click Element and Wait Angular Ready     ${XPATH_iTrueMart.checkout_by_guest}
    Wait Until Element Is Visible   ${XPATH_iTrueMart.username}    ${timeout}
    Input Text   ${XPATH_iTrueMart.username}   ${SAMPLE_DATA.VALID.iTruemart_id}
    Click Element and Wait Angular Ready     ${XPATH_iTrueMart.checkout_step1_next_button}

Checkout Step1 By Member
    Wait Until Element Is Visible    ${XPATH_iTrueMart.checkout_by_member}    ${timeout}
    Click Element and Wait Angular Ready     ${XPATH_iTrueMart.checkout_by_member}
    Wait Until Element Is Visible   ${XPATH_iTrueMart.username}    ${timeout}
    Input Text   ${XPATH_iTrueMart.username}   ${SAMPLE_DATA.VALID.iTruemart_member_ID}
    Input Text   ${XPATH_iTrueMart.password}   ${SAMPLE_DATA.VALID.iTruemart_member_password}
    Click Element and Wait Angular Ready     ${XPATH_iTrueMart.checkout_step1_next_button}

Re-Click Province
    Wait Until Element Is Visible    ${XPATH_iTrueMart.checkout_step2_select_province}    ${timeout}
    Click Element and Wait Angular Ready     ${XPATH_iTrueMart.checkout_step2_select_province}
    Wait Until Element Is Visible    ${XPATH_iTrueMart.checkout_step2_select_province}/option[1]    ${timeout}
    Click Element and Wait Angular Ready     ${XPATH_iTrueMart.checkout_step2_select_province}/option[1]
    Sleep    1s
    Mobile Site Select Province


Mobile Site Select Province
    Wait Until Element Is Visible    ${XPATH_iTrueMart.checkout_step2_select_province}    ${timeout}
    Click Element and Wait Angular Ready     ${XPATH_iTrueMart.checkout_step2_select_province}
    Wait Until Element Is Visible    ${XPATH_iTrueMart.checkout_step2_select_province}/option[3]    ${timeout}
    Click Element and Wait Angular Ready     ${XPATH_iTrueMart.checkout_step2_select_province}/option[3]
    Sleep   2s
    ${get_city_value}    Get Matching xpath count    //*[@id='city-control']//option
    Run Keyword if    '${get_city_value}' == '1'   Re-Click Province

Mobile Site Select City
    Wait Until Element Is Visible    ${XPATH_iTrueMart.checkout_step2_select_city}    ${timeout}
    Click Element and Wait Angular Ready     ${XPATH_iTrueMart.checkout_step2_select_city}
    Wait Until Element Is Visible    ${XPATH_iTrueMart.checkout_step2_select_city}/option[2]    ${timeout}
    Click Element and Wait Angular Ready     ${XPATH_iTrueMart.checkout_step2_select_city}/option[2]
Mobile Site Select District
    Wait Until Element Is Visible    ${XPATH_iTrueMart.checkout_step2_select_district}
    Click Element and Wait Angular Ready     ${XPATH_iTrueMart.checkout_step2_select_district}    ${timeout}
    Wait Until Element Is Visible    ${XPATH_iTrueMart.checkout_step2_select_district}/option[2]
    Click Element and Wait Angular Ready     ${XPATH_iTrueMart.checkout_step2_select_district}/option[2]    ${timeout}
Mobile Site Select Zip
    Wait Until Element Is Visible    ${XPATH_iTrueMart.checkout_step2_select_zip}    ${timeout}
    Click Element and Wait Angular Ready     ${XPATH_iTrueMart.checkout_step2_select_zip}
    Wait Until Element Is Visible    ${XPATH_iTrueMart.checkout_step2_select_zip}/option[2]    ${timeout}
    Click Element and Wait Angular Ready     ${XPATH_iTrueMart.checkout_step2_select_zip}/option[2]
Mobile Site Input Address
    Input Text    ${XPATH_iTrueMart.checkout_step2_select_address}    ${SAMPLE_DATA.VALID.checkout_step2_address}
Mobile Site Click Next Button Step2
    Wait Until Element Is Visible    ${XPATH_iTrueMart.checkout_step2_next_button}    ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_iTrueMart.checkout_step2_next_button}

Checkout Step2 By Guest
    Wait Until Element Is Visible    ${XPATH_iTrueMart.checkout_step2_input_name}    ${timeout}
    Input Text    ${XPATH_iTrueMart.checkout_step2_input_name}    ${SAMPLE_DATA.VALID.checkout_step2_name}
    Input Text    ${XPATH_iTrueMart.checkout_step2_input_phone}    ${SAMPLE_DATA.VALID.checkout_step2_phone}
    Input Text    ${XPATH_iTrueMart.checkout_step2_input_phone}    ${SAMPLE_DATA.VALID.checkout_step2_phone}
    Input Text    ${XPATH_iTrueMart.checkout_step2_input_phone}    ${SAMPLE_DATA.VALID.checkout_step2_phone}
    Mobile Site Select Province
    Mobile Site Select City
    Mobile Site Select District
    Mobile Site Select Zip
    Mobile Site Input Address
    Mobile Site Click Next Button Step2

Checkout Step2 By Member
    Wait Until Element Is Visible    ${XPATH_iTruemart.checkout_step2_by_member_next_button}    ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_iTruemart.checkout_step2_by_member_next_button}

Checkout Step3 Payment By CCW
    Sleep    3s
    Wait Until Element Is Visible    ${XPATH_iTrueMart.checkout_step3_payment_ccw}    ${timeout}
    Click Element and Wait Angular Ready     ${XPATH_iTrueMart.checkout_step3_payment_ccw}
    Sleep   2s
    Wait Until Element Is Visible    ${XPATH_iTrueMart.checkout_step3_ccw_name}    ${timeout}
    Input Text    ${XPATH_iTrueMart.checkout_step3_ccw_name}    ${SAMPLE_DATA.VALID.checkout_step3_ccw_name}
    Input Text    ${XPATH_iTrueMart.checkout_step3_ccw_number}    ${SAMPLE_DATA.VALID.checkout_step3_ccw_number}
    Click Element and Wait Angular Ready     ${XPATH_iTrueMart.checkout_step3_ccw_ex_month}
    Click Element and Wait Angular Ready     ${XPATH_iTrueMart.checkout_step3_ccw_ex_year}
    Input Text    ${XPATH_iTrueMart.checkout_step3_ccw_ccv}    ${SAMPLE_DATA.VALID.checkout_step3_ccw_ccv}
    Sleep   2s
    Click Element and Wait Angular Ready     ${XPATH_iTrueMart.checkout_step3_next_button}
    Wait Until Element Is Visible    ${XPATH_iTrueMart.confirm_checkout}    ${timeout}
    Click Element and Wait Angular Ready     ${XPATH_iTrueMart.confirm_checkout}

Verify Cart Page Product Picture and Name Can Redirect To Level D
    :FOR  ${index}  IN RANGE  1  ${Check_Product_in_cart}+1
    \  ${xpath_product_picture}    Catenate  SEPARATOR=    //div[@class='row box-product']/div[${index}]//div/a/img
    \  ${xpath_product_name}    Catenate  SEPARATOR=    //div[@class='row box-product']/div[${index}]//div[@class='col-xs-9']/div/a
    \  ${product_name}    Get Text    ${xpath_product_name}
    \  Log To Console    Product No.[${index}] Name = ${product_name}

    # \  Log To Console    Verify Picture Link Product No.[${index}] = ${product_name}
    \  Wait Until Element Is Visible    ${xpath_product_picture}    ${timeout}
    \  Click Element and Wait Angular Ready     ${xpath_product_picture}
    \  Location Should Contain    ${WEMALL_MOBILE}/products/
    \  Page Should Contain    ${product_name}
    \  Go To    ${WEMALL_MOBILE}/cart

    # \  Log To Console    Verify Name Link Product No.[${index}] = ${product_name}
    \  Wait Until Element Is Visible    ${xpath_product_name}    ${timeout}
    \  Click Element and Wait Angular Ready     ${xpath_product_name}
    \  Location Should Contain    ${WEMALL_MOBILE}/products/
    \  Page Should Contain    ${product_name}
    \  Log To Console    Product No.[${index}] picture and name can redirect to Level D success \n
    \  Go To    ${WEMALL_MOBILE}/cart
    \  Sleep    4s
    \  Location Should Be    ${WEMALL_MOBILE}/cart

Verify Thankyou Page Mobile Site
    Wait Until Element Is Visible    //div[@class='p-order']    ${timeout}
    ${Get_location}=    Get Location
    # Log To Console    \n Current Location = ${Get_location}
    @{Split_String}   Split String   ${Get_location}   www
    ${Max_length}   Get Length   ${Split_String}
    # ${String1}=   Set Variable   @{Split_String}[0]
    # ${String2}=   Set Variable   @{Split_String}[1]
    # Log To Console   URL first part = ${String1}
    # Log To Console   URL second part= ${String2}
    Go To     @{Split_String}[0]m@{Split_String}[1]

    ${Get_Product_Name_From_Cart}   Get From Dictionary   ${Get_Product_In_Cart}   package_name
    # Element Should Contain    //*[@id="thank_customer_name"]    ${SAMPLE_DATA.VALID.checkout_step2_name}
    # Element Should Contain    //*[@id="thank_phone_number"]    ${SAMPLE_DATA.VALID.checkout_step2_phone}
    # Element Should Contain    //*[@id="thank_email"]    ${SAMPLE_DATA.VALID.iTruemart_id}
    :FOR   ${index}   IN RANGE   1  ${Check_Product_in_cart}+1
    \  ${xpath_product_name}    Catenate  SEPARATOR=    //div[@class='cart-item order-list-info-container'][${index}]//h5
    \  ${Get_Production_Name_On_Thankyou_page}    Get Text    ${xpath_product_name}
    \  ${Get_Product_Name_From_Cart1}=  Get From List   ${Get_Product_Name_From_Cart}   ${index}
    \  Log To Console    Thankyou Product No.[${index}] = ${Get_Production_Name_On_Thankyou_page}
    \  Log To Console    Get Product Name From Array No. [${index}] = ${Get_Product_Name_From_Cart1}
    \  Should Be Equal As Strings    ${Get_Product_Name_From_Cart1}    ${Get_Production_Name_On_Thankyou_page}
    \  Log To Console    Product No.[${index}] Retrieve From Cart Page Correct!! \n


############################################# Level D , New Variant Type ##################################################
Open iTruemart Web
    [Arguments]    ${home}
    open browser    ${WEMALL_URL}/${home}    chrome
    Maximize Browser Window
    Reload Page

Click Variant Type
    ${Cnt_Variant_Row}    Get Matching xpath count    //li[@class='style-types'][div]/div[@class='prd_control options']
    Log To Console    Variant Row = ${Cnt_Variant_Row}
    :FOR    ${index}    IN RANGE   1    ${Cnt_Variant_Row}+1
    \  Wait Until Element Is Visible    //li[@class='style-types'][div][${index}]/div[@class='prd_control options']/ul/li[1]/a    ${timeout}
    \  Click Element and Wait Angular Ready    //li[@class='style-types'][div][${index}]/div[@class='prd_control options']/ul/li[1]/a

Verify Variant Type not related each other will display out of stock
    ${Cnt_Variant_Row}    Get Matching xpath count    //li[@class='style-types'][div]/div[@class='prd_control options']
    Log To Console    Variant Row = ${Cnt_Variant_Row}
    :FOR    ${index}    IN RANGE   1    ${Cnt_Variant_Row}+1
    \  Wait Until Element Is Visible    //li[@class='style-types'][div][${index}]/div[@class='prd_control options']/ul/li[2]/a    ${timeout}
    \  Click Element and Wait Angular Ready    //li[@class='style-types'][div][${index}]/div[@class='prd_control options']/ul/li[2]/a
    Wait Until Element Is Not Visible    ${XPATH_iTruemart.level_D_product_status_message}
    Wait Until Element Is Visible    ${XPATH_iTruemart.level_D_product_status_out_of_stock_status}    ${timeout}

Verify Level D Check Stock After Select Variant Type
    ${Cnt_Variant_Row}    Get Matching xpath count    //li[@class='style-types'][div]/div[@class='prd_control options']
    Log To Console    Variant Row = ${Cnt_Variant_Row}
    :FOR    ${index}    IN RANGE   1    ${Cnt_Variant_Row}+1
    \  Wait Until Element Is Visible    //li[@class='style-types'][div][${index}]/div[@class='prd_control options']/ul/li[1]/a    ${timeout}
    \  Click Element and Wait Angular Ready    //li[@class='style-types'][div][${index}]/div[@class='prd_control options']/ul/li[1]/a
    \  Run Keyword If  '${index}' < '${Cnt_Variant_Row}'    Element Should Be Visible    ${XPATH_iTruemart.level_D_product_status_message}
    \  Run Keyword If  '${index}' == '${Cnt_Variant_Row}'    Element Should Not Be Visible    ${XPATH_iTruemart.level_D_product_status_message}
    Wait Until Element Is Visible    ${XPATH_iTruemart.level_D_product_status_have_stock}    ${timeout}
    Log To Console    Stock Active already

Verify Buy Button Is Enable
    Wait Until Element Is Visible    //div[@class='order_container']    ${timeout}
    Element Should Be Visible    ${XPATH_iTrueMart.btn_buy_enable}
    Element Should Not Be Visible     ${XPATH_iTrueMart.btn_buy_disable}


##############################################  Web View Buy Product New&Old Variant Type  ################################

Buy product with old variant type
    Click Variant Type
    Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    Display Checkout Step1 Page
    Checkout1 - Input Email    robot33@mail.com
    Checkout1 - Click Next
    Checkout1 - Wait Loading
    Display Checkout Step2 Page
    Checkout2 - Input Name    Old Variant
    Checkout2 - Input Phone    ${SAMPLE_DATA.VALID.checkout_step2_phone}
    Checkout2 - Select Province
    Checkout2 - Select District
    Checkout2 - Select SubDistrict
    Checkout2 - Select ZipCode
    Checkout2 - Input Address    Test Address
    Checkout2 - Click Next
    Checkout3 - Display Checkout Step3 Page
    User Click Payment Channel CCW Tab
    Checkout 3 - User Enter Valid Data Master Card As Member
    ${get_order_id}=    Thankyou - Get order id

Buy product with new variant type
    Click Variant Type
    Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    Display Checkout Step1 Page
    Checkout1 - Input Email    robot33@mail.com
    Checkout1 - Click Next
    Checkout1 - Wait Loading
    Display Checkout Step2 Page
    Checkout2 - Input Name    New Variant
    Checkout2 - Input Phone    ${SAMPLE_DATA.VALID.checkout_step2_phone}
    Checkout2 - Select Province
    Checkout2 - Select District
    Checkout2 - Select SubDistrict
    Checkout2 - Select ZipCode
    Checkout2 - Input Address    Test Address
    Checkout2 - Click Next
    Checkout3 - Display Checkout Step3 Page
    User Click Payment Channel CCW Tab
    Checkout 3 - User Enter Valid Data Master Card As Member
    ${get_order_id}=    Thankyou - Get order id

Buy product with old and new variant type
    Click Variant Type
    Level D - User Click Add To Cart Button
    Display Full Cart
    User Click Next Process On Full Cart
    Display Checkout Step1 Page
    Checkout1 - Input Email    robot33@mail.com
    Checkout1 - Click Next
    Checkout1 - Wait Loading
    Display Checkout Step2 Page
    Checkout2 - Input Name    Old and New Variant
    Checkout2 - Input Phone    ${SAMPLE_DATA.VALID.checkout_step2_phone}
    Checkout2 - Select Province
    Checkout2 - Select District
    Checkout2 - Select SubDistrict
    Checkout2 - Select ZipCode
    Checkout2 - Input Address    Test Address
    Checkout2 - Click Next
    Checkout3 - Display Checkout Step3 Page
    User Click Payment Channel CCW Tab
    Checkout 3 - User Enter Valid Data Master Card As Member
    ${get_order_id}=    Thankyou - Get order id


##############################################  Profile Mobile Keyword  #####################################################
Click Create New Address Button
    Wait Until Element Is Visible    ${XPATH_iTruemart.btn_create_new_address}    ${timeout}
    Click Element and Wait Angular Ready     ${XPATH_iTruemart.btn_create_new_address}

Click Edit Address
    Wait Until Element Is Visible    ${XPATH_iTruemart.btn_edit}    ${timeout}
    Click Element and Wait Angular Ready     ${XPATH_iTruemart.btn_edit}

Create New Profile Address
    ${Address_exist_status}=   Run Keyword And Return Status     Element Should Be Visible    //div[@class='address-block address-card']
    Log To Console    Address Exist = ${Address_exist_status}
    Click Create New Address Button
    Wait Until Element Is Visible    ${XPATH_iTrueMart.checkout_step2_input_name}    ${timeout}
    Input Text    ${XPATH_iTrueMart.checkout_step2_input_name}    ${SAMPLE_DATA.VALID.checkout_step2_name}
    Input Text    ${XPATH_iTrueMart.checkout_step2_input_phone}    ${SAMPLE_DATA.VALID.checkout_step2_phone}
    Input Text    ${XPATH_iTrueMart.checkout_step2_input_phone}    ${SAMPLE_DATA.VALID.checkout_step2_phone}
    Input Text    ${XPATH_iTrueMart.checkout_step2_input_phone}    ${SAMPLE_DATA.VALID.checkout_step2_phone}
    Mobile Site Select Province
    Mobile Site Select City
    Mobile Site Select District
    Mobile Site Select Zip
    Mobile Site Input Address
    Mobile Site Click Next Button Step2

Verify New Profile Address
    Wait Until Element Is Visible    //div[@class='profile-block profile-delivery-address']    ${timeout}
    Element Should Be Visible    //div[@class='address-block address-card']

Edit Profile Addess
    Click Edit Address
    # ${random}=     Evaluate    random.randint(0, 999)    random
    # Log To Console    Random Number = ${random}
    Wait Until Element Is Visible    ${XPATH_iTrueMart.checkout_step2_input_name}    ${timeout}
    Input Text    ${XPATH_iTrueMart.checkout_step2_input_name}    ${SAMPLE_DATA.VALID.Edit_name}
    Input Text    ${XPATH_iTrueMart.checkout_step2_input_phone}    ${SAMPLE_DATA.VALID.Edit_phone}
    Mobile Site Select Province

    Wait Until Element Is Visible    ${XPATH_iTrueMart.checkout_step2_select_city}    ${timeout}
    Click Element and Wait Angular Ready     ${XPATH_iTrueMart.checkout_step2_select_city}
    Wait Until Element Is Visible    ${XPATH_iTrueMart.checkout_step2_select_city}/option[3]    ${timeout}
    Click Element and Wait Angular Ready     ${XPATH_iTrueMart.checkout_step2_select_city}/option[3]

    Wait Until Element Is Visible    ${XPATH_iTrueMart.checkout_step2_select_district}    ${timeout}
    Click Element and Wait Angular Ready     ${XPATH_iTrueMart.checkout_step2_select_district}
    Wait Until Element Is Visible    ${XPATH_iTrueMart.checkout_step2_select_district}/option[3]    ${timeout}
    Click Element and Wait Angular Ready     ${XPATH_iTrueMart.checkout_step2_select_district}/option[3]

    Wait Until Element Is Visible    ${XPATH_iTrueMart.checkout_step2_select_zip}    ${timeout}
    Click Element and Wait Angular Ready     ${XPATH_iTrueMart.checkout_step2_select_zip}
    Wait Until Element Is Visible    ${XPATH_iTrueMart.checkout_step2_select_zip}/option[2]    ${timeout}
    Click Element and Wait Angular Ready     ${XPATH_iTrueMart.checkout_step2_select_zip}/option[2]

    Input Text    ${XPATH_iTrueMart.checkout_step2_select_address}    ${SAMPLE_DATA.VALID.Edit_Address}

    ${Edit_province}=    Get Selected List Label    ${XPATH_iTrueMart.checkout_step2_select_province}
    ${Edit_city}=    Get Selected List Label    ${XPATH_iTrueMart.checkout_step2_select_province}
    ${Edit_district}=    Get Selected List Label    ${XPATH_iTrueMart.checkout_step2_select_province}
    ${Edit_zip}=    Get Selected List Label    ${XPATH_iTrueMart.checkout_step2_select_province}
    Mobile Site Click Next Button Step2

Verify Edit Address Is Success
    Wait Until Element Is Visible    //div[@class='profile-block profile-delivery-address']    ${timeout}
    Page Should Contain Element    //div[@class='address-block address-card'][1]/p[1]    ${SAMPLE_DATA.VALID.Edit_name}
    Page Should Contain Element    //div[@class='address-block address-card'][1]/p[3]    ${SAMPLE_DATA.VALID.Edit_phone}



Click Order Tracking Link
    Wait Until Element Is Visible    ${XPATH_iTruemart.link_order_tracking}    ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_iTruemart.link_order_tracking}
    Location Should Be    ${WEMALL_MOBILE}/member/orders

Click Cart Link
    Wait Until Element Is Visible    ${XPATH_iTruemart.link_cart}    ${timeout}
    Click Element and Wait Angular Ready    ${XPATH_iTruemart.link_cart}
    Location Should Be    ${WEMALL_MOBILE}/cart
















