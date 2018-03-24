*** Settings ***
Resource          ../../Keyword/Features/PC1_And_PC3/PCMS.robot
Resource          ../../Keyword/Common/Keywords_Common.robot
Resource          ../../Keyword/Features/PC1_And_PC3/ITM.robot
Resource          ../../Keyword/Portal/PCMS/Run_PCMS_order/Keywords_RunPCMSOrder.robot
Resource          ../../Keyword/Portal/PCMS/Receipt/Keywords_Receipts.robot
Resource          ../../Keyword/Portal/CAMP/CAMP_common/Keywords_CAMP_Common.robot
Resource          ../../Keyword/API/CAMP_API/keyword_camp.txt
Resource          ../../Keyword/Features/Freebie_Promotion/Create_Freebie.robot
Resource          ../../Resource/WebElement/CAMP/Camp_Freebie.robot
Resource          ../../Keyword/Portal/CAMP/CAMP_common/Keywords_CAMP_Common.robot
Resource          ../../Keyword/Portal/CAMP/CAMP_promotion/Keywords_CAMP_Promotion.robot
Resource          ../../Resource/init.robot
Resource          ../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ../../Keyword/Portal/iTrueMart/registration_page/Keywords_registration.robot
#Resource          Test_Data.robot
Resource          ../../Keyword/Portal/iTrueMart/Search_Page/Keywords_SearchPage.robot
Resource          ../../Keyword/Features/Create_Order/Create_order.txt
Resource          ../../Keyword/Portal/iTrueMart/Brand_page/Keywords_BrandPage.robot
Resource          ../../Keyword/Features/Sanity_test/Keywords_Sanity_Production.robot
Resource          ../../Keyword/Portal/iTrueMart/Category_Page/Keywords_CategoryPage.robot
Resource          ../../Keyword/Features/User_login/User_login.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/User_Information_Page/Keywords_UserInformationPage.robot

*** Test Cases ***
ITM_Login
    [Tags]    QCT
    ${Email}    Set Variable    sanity_test@mail.com
    ${Password}    Set Variable    test@1234
    User Login From login page    ${Email}    ${Password}
    [Teardown]    close browser

ITM_Register
    [Tags]    QCT    ITM_REGISTER
    ${epoch}=    Get current epoch time short
    Register New Account    QCT_${epoch}@gmail.com    Test_QCT    QCT@1234    ${ITM_URL}
    [Teardown]    close browser
