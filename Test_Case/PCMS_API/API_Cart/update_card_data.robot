*** Setting ***
Force Tags        WLS_API_PCMS
Library     Selenium2Library
Library     HttpLibrary.HTTP
Resource    ${CURDIR}/../../../Resource/init.robot
Resource    ${CURDIR}/../../../Keyword/Common/Keywords_Common.robot
Resource    ${CURDIR}/../../../Keyword/Common/keywords_itruemart_common.robot
Resource    ${CURDIR}/../../../Keyword/API/PCMS/Cart/keywords_cart.robot
Library     ${CURDIR}/../../../Python_Library/DatabaseData.py
Resource    ${CURDIR}/../../../Keyword/Features/User_login/User_login.robot


*** Variable ***
${TrueID}        robotautomate01@gmail.com
${TruePWD}       true1234
${guestEmail}    robotautomate@gmail.com
${inv_id}        CIAAA1111711

*** Test Case ***

TC_iTM_03653 Update card data only active row Guest
    [tags]    TC_iTM_03653    ITMA-3108    itm-a-sprint 2016s13    pcms_api    api    guest    ready    regression    WLS_High
    ${ord}    ${ref}    ${rs1}=    Guest Buy Product with CCW     ${guestEmail}    ${inv_id}
    ${rs2}=    Guest Buy Product Until Checkout3     ${guestEmail}    1    ${ref}    ${inv_id}
    ${rs3}=    Get carts by id    ${rs1[0][0]}
    # Log To Console    ${rs1[0][0]}/${rs2[0][0]}/${rs3[0][0]}
    # Log To Console    ${rs1[0][42]}/${rs2[0][42]}/${rs3[0][42]}
    Should Be Equal As Strings    ${rs1[0][42]}     ${rs3[0][42]}    Carts updated

    [teardown]    Run Keywords    Close Browser

TC_iTM_03654 Update card data only actiave row Member
    [tags]    TC_iTM_03654    ITMA-3108    itm-a-sprint 2016s13    pcms_api    api    mamber    ready    regression   QCT    WLS_High
    Open Browser    ${ITM_URL}/auth/login           ${BROWSER}
    Login_with_TrueID    ${TrueID}    ${TruePWD}
    ${ref}=  Get ACL    3
    clear_cart    ${ref}
    Close Browser
    ${ord}    ${rs1}=    Member Buy Product with CCW     ${TrueID}    ${TruePWD}    ${ref}    ${inv_id}
    Close Browser
    ${rs2}=    Member Buy Product Until Checkout3     ${TrueID}    ${TruePWD}    ${ref}    ${inv_id}
    ${rs3}=    Get carts by id    ${rs1[0][0]}
    # Log To Console    ${rs1[0][0]}/${rs2[0][0]}/${rs3[0][0]}
    # Log To Console    ${rs1[0][42]}/${rs2[0][42]}/${rs3[0][42]}
    Should Be Equal As Strings    ${rs1[0][42]}     ${rs3[0][42]}    Carts updated

    [teardown]    Run Keywords    Close Browser


TC_iTM_03655 Update card data only active row and API return code 200 (Guest)
    [tags]    TC_iTM_03655    ITMA-3108    itm-a-sprint 2016s13    pcms_api    api    guest    ready    regression    WLS_Medium
    ${ord}    ${ref}    ${rs1}=    Guest Buy Product with CCW     ${guestEmail}    ${inv_id}
    ${ref}=   Remove String   ${ref}   "
    API Add Cart    ${PCMS_URL_API}    ${add-cart}    ${ref}    non-user    ${inv_id}    1
    API Set Card Data     ${PCMS_URL_API}    /api/v2/45311375168544/cart/set-card   ${ref}    non-user    123456    set
    ${rs3}=    Get carts by id    ${rs1[0][0]}
    # Log To Console    ${rs1[0][0]}//${rs3[0][0]}
    # Log To Console    ${rs1[0][42]}//${rs3[0][42]}
    Should Be Equal As Strings    ${rs1[0][42]}     ${rs3[0][42]}    Carts updated
    [teardown]    Run Keywords    Close Browser


TC_iTM_03656 Update card data only active row and API return code 200 (Member)
    [tags]    TC_iTM_03656    ITMA-3108    itm-a-sprint 2016s13    pcms_api    api    member    ready    regression    WLS_Medium
    Open Browser    ${ITM_URL}/auth/login           ${BROWSER}
    Login_with_TrueID    ${TrueID}    ${TruePWD}
    ${ref}=  Get ACL    3
    clear_cart    ${ref}
    Close Browser
    ${ord}   ${rs1}=    Member Buy Product with CCW     ${TrueID}    ${TruePWD}    ${ref}    ${inv_id}
    Close Browser
    ${ref}=   Remove String   ${ref}   "
    API Add Cart    ${PCMS_URL_API}    ${add-cart}    ${ref}    user    ${inv_id}    1
    API Set Card Data     ${PCMS_URL_API}    /api/v2/45311375168544/cart/set-card   ${ref}    user    123456    set
    ${rs3}=    Get carts by id    ${rs1[0][0]}
    # Log To Console    ${rs1[0][0]}//${rs3[0][0]}
    # Log To Console    ${rs1[0][42]}//${rs3[0][42]}
    Should Be Equal As Strings    ${rs1[0][42]}     ${rs3[0][42]}    Carts updated
    [teardown]    Run Keywords    Close Browser
