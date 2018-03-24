*** Settings ***
Library                     Selenium2Library
Library                     ${CURDIR}/../../../Python_Library/ExtendedSelenium/
Resource                    ${CURDIR}/../../../Resource/init.robot
Resource                    ${CURDIR}/../../../Keyword/API/api_portals/megamenus_keywords.robot
Resource                    ${CURDIR}/../../../Keyword/Portal/portal_cms/menu_bar/menubar_keyword.robot

Suite Setup                 Open Brower AND Go To Manage Menu Bar
Suite Teardown              Close All Browsers

*** Variable ***
${name_th_1}                MenuBarTestTh1
${link_th_1}                www.wemall.com
${name_en_1}                MenuBarTestEn1
${link_en_1}                www.wemall.com/en

${name_th_2}                MenuBarTestTh2
${link_th_2}                www.wemall.com
${name_en_2}                MenuBarTestEn2
${link_en_2}                www.wemall.com/en

${name_th_3}                MenuBarTestTh3
${link_th_3}                www.wemall.com
${name_en_3}                MenuBarTestEn3
${link_en_3}                www.wemall.com/en

${name_th_mobile_1}                MenuBarTestTh1_mobile
${link_th_mobile_1}                www.wemall.com
${name_en_mobile_1}                MenuBarTestEn1_mobile
${link_en_mobile_1}                www.wemall.com/en

${name_th_mobile_2}                MenuBarTestTh2_mobile
${link_th_mobile_2}                www.wemall.com
${name_en_mobile_2}                MenuBarTestEn2_mobile
${link_en_mobile_2}                www.wemall.com/en

${name_th_mobile_3}                MenuBarTestTh3_mobile
${link_th_mobile_3}                www.wemall.com
${name_en_mobile_3}                MenuBarTestEn3_mobile
${link_en_mobile_3}                www.wemall.com/en

*** Test Cases ***
TC_WMALL_01711 Manage Portal - Clear cache after published portal data Web EN/TH
        Go To Manage Menu Bar
        Add Menu Bar Web                    ${name_th_1}     ${link_th_1}     ${name_en_1}      ${link_en_1}
        Submit Menu Bar Web
        Click Save Menu Bar Web
        Verify Menu Bar Preview Mode Web    ${name_th_1}       ${name_en_1}
        Go To Manage Menu Bar
        Update Data Menu Bar Web            ${name_th_1}     ${name_th_2}     ${link_th_2}     ${name_en_2}      ${link_en_2}
        Submit Menu Bar Web
        Click Save Menu Bar Web
        Verify Menu Bar Preview Mode Web    ${name_th_2}       ${name_en_2}
        Go To Manage Menu Bar
        sleep    3s
        Publish Menu Bar Web
        Verify Menu Bar Publish Web          ${name_th_2}       ${name_en_2}
        Go To Manage Menu Bar
        Update Data Menu Bar Web             ${name_th_2}     ${name_th_3}     ${link_th_3}     ${name_en_3}      ${link_en_3}
        Submit Menu Bar Web
        Click Save Menu Bar Web
        Verify Menu Bar Preview Mode Web     ${name_th_3}       ${name_en_3}
        Verify Menu Bar Publish Web          ${name_th_2}       ${name_en_2}
        Go To Manage Menu Bar
        sleep    3s
        Click Delete Menu Bar Web            ${name_th_3}
        Confirm Delete Web
        Click Save Menu Bar Web
        Publish Menu Bar Web

TC_WMALL_01712 Manage Portal - Clear cache after published portal data Mobile EN/TH
        Go To Manage Menu Bar
        Add Menu Bar Mobile                    ${name_th_mobile_1}     ${link_th_mobile_1}     ${name_en_mobile_1}      ${link_en_mobile_1}
        Submit Menu Bar Mobile
        Click Save Menu Bar Mobile
        Verify Menu Bar Preview Mode Mobile    ${name_th_mobile_1}       ${name_en_mobile_1}
        Go To Manage Menu Bar
        Update Data Menu Bar Mobile            ${name_th_mobile_1}     ${name_th_mobile_2}     ${link_th_mobile_2}     ${name_en_mobile_2}      ${link_en_mobile_2}
        Submit Menu Bar Mobile
        Click Save Menu Bar Mobile
        Verify Menu Bar Preview Mode Mobile    ${name_th_mobile_2}       ${name_en_mobile_2}
        Go To Manage Menu Bar
        sleep    3s
        Publish Menu Bar Mobile
        Verify Menu Bar Publish Mobile         ${name_th_mobile_2}       ${name_en_mobile_2}
        Go To Manage Menu Bar
        Update Data Menu Bar Mobile            ${name_th_mobile_2}     ${name_th_mobile_3}     ${link_th_mobile_3}     ${name_en_mobile_3}      ${link_en_mobile_3}
        Submit Menu Bar Mobile
        Click Save Menu Bar Mobile
        Verify Menu Bar Preview Mode Mobile    ${name_th_mobile_3}       ${name_en_mobile_3}
        Verify Menu Bar Publish Mobile         ${name_th_mobile_2}       ${name_en_mobile_2}
        Go To Manage Menu Bar
        sleep    3s
        Click Delete Menu Bar Mobile           ${name_th_mobile_3}
        Confirm Delete Mobile
        Click Save Menu Bar Mobile
        Publish Menu Bar Mobile