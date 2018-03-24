*** Settings ***
Library           HttpLibrary.HTTP
Library           DateTime
Library           Collections
Library           String
Library           ${CURDIR}/../../../Python_Library/common.py
Library           ${CURDIR}/../../../Python_Library/FileKeyword.py
Resource          ${CURDIR}/../../../Resource/Config/${env}/env_config.robot
Resource          ${CURDIR}/../../../Keyword/API/CAMP_API/Keywords_CAMPS_API.robot
Resource          ${CURDIR}/../../../Keyword/Portal/CAMPS/CAMPS_Common/Keywords_CAMPS_Common.robot
Resource          ${CURDIR}/../../../Keyword/Portal/CAMPS/CAMPS_Flash_Sale/Keywords_CAMPS_Flash_Sale.robot
Resource          ${CURDIR}/../../../Keyword/Portal/CAMPS/CAMPS_Flash_Sale/Keywords_CAMPS_Variant_Selector_Flash_Sale.robot
Resource          ${CURDIR}/../../../Keyword/Portal/CAMPS/CAMPS_Campaign/Keywords_CAMPS_Campaign.robot
Resource          ${CURDIR}/../../../Keyword/Portal/CAMPS/CAMPS_Promotion/Keywords_CAMPS_Promotion.robot
Resource          ${CURDIR}/../../../Resource/TestData/CAMPS_test_data_variables.robot
Resource          ${CURDIR}/../../../Resource/TestData/CAMPS_message_library.robot
