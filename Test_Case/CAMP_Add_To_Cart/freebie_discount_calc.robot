*** Settings ***
Suite Teardown    Selenium2Library.Close All Browsers
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           OperatingSystem
Resource          ${CURDIR}/../../Resource/Config/${env}/env_config.robot
Resource          ${CURDIR}/../../Resource/init.robot
Resource          ${CURDIR}/../../Keyword/Features/Freebie/keywords_add_to_cart.robot
Resource          ${CURDIR}/../../Keyword/Features/Create_Order/Create_order.txt
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Login/keywords_login.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Level_d_page/keywords_leveld.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Full_cart/keywords_full_cart.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Checkout_2/keywords_Checkout2.robot
Resource          ${CURDIR}/../../Keyword/Portal/iTrueMart/Checkout_3/keywords_Checkout3.robot
Resource          ${CURDIR}/../../Keyword/API/FMS/FMS_ORDER.robot

*** Test Cases ***
