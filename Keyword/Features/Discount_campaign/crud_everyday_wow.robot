*** Settings ***
Library           Selenium2Library
# Library           ${CURDIR}/../../../../Python_Library/common.py
# Library           ${CURDIR}/../../../../Python_Library/DatabaseData.py
# Library           ${CURDIR}/../../../../Python_Library/common/csvlibrary.py
Resource          ${CURDIR}/../../Portal/PCMS/Promotion/keywords_discount_campaign.robot


*** Variables ***
@{discount_type_variable}         discount        wow
@{discount_icon_type_variable}    Line TMVH       Line True You    No Icon
@{wow_icon_type_variable}         Everyday Wow    Wow 1 Baht

*** Keywords ***

Create campaign - everyday wow 1 bath
    [Arguments]    ${app}    ${code}    ${name}    ${description}
    ...    ${discount}    ${discount_value_type}    ${start}    ${end}
    Discount campaign - Go to Create campaign page
    Discount campaign - Input Campaign Detail    ${app}    @{discount_type_variable}[1]    @{wow_icon_type_variable}[1]
    ...    ${code}    ${name}    ${description}    ${discount}    ${discount_value_type}    ${start}    ${end}
    Discount campaign - Wait Until Page Contains Discount Product Campaigns Table

Create campaign - everyday wow
    [Arguments]    ${app}    ${code}    ${name}    ${description}
    ...    ${discount}    ${discount_value_type}    ${start}    ${end}
    Discount campaign - Go to Create campaign page
    Discount campaign - Input Campaign Detail    ${app}    @{discount_type_variable}[1]    @{wow_icon_type_variable}[0]
    ...    ${code}    ${name}    ${description}    ${discount}    ${discount_value_type}    ${start}    ${end}
    Discount campaign - Wait Until Page Contains Discount Product Campaigns Table


Create campaign - discount(no icon)
    [Arguments]    ${app}    ${code}    ${name}    ${description}
    ...    ${discount}    ${discount_value_type}    ${start}    ${end}
    Discount campaign - Go to Create campaign page
    Discount campaign - Input Campaign Detail    ${app}    @{discount_type_variable}[0]    @{discount_icon_type_variable}[2]
    ...    ${code}    ${name}    ${description}    ${discount}    ${discount_value_type}    ${start}    ${end}
    Discount campaign - Wait Until Page Contains Discount Product Campaigns Table

Create campaign - discount(line true you)
    [Arguments]    ${app}    ${code}    ${name}    ${description}
    ...    ${discount}    ${discount_value_type}    ${start}    ${end}
    Discount campaign - Go to Create campaign page
    Discount campaign - Input Campaign Detail    ${app}    @{discount_type_variable}[0]    @{discount_icon_type_variable}[0]
    ...    ${code}    ${name}    ${description}    ${discount}    ${discount_value_type}    ${start}    ${end}
    Discount campaign - Wait Until Page Contains Discount Product Campaigns Table

Create campaign - discount(line truemoveH)
    [Arguments]    ${app}    ${code}    ${name}    ${description}
    ...    ${discount}    ${discount_value_type}    ${start}    ${end}
    Discount campaign - Go to Create campaign page
    Discount campaign - Input Campaign Detail    ${app}    @{discount_type_variable}[0]    @{discount_icon_type_variable}[1]
    ...    ${code}    ${name}    ${description}    ${discount}    ${discount_value_type}    ${start}    ${end}
    Discount campaign - Wait Until Page Contains Discount Product Campaigns Table

Edit campaign - period
    [Arguments]    ${campaign_name}    ${start}    ${end}
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click Edit Campaign button    ${campaign_name}
    Discount campaign - User select period campaign    ${start}    ${end}
    Discount campaign - User Click Submit to create campaign

Edit campaign - code and name and description
    [Arguments]    ${campaign_name}    ${edit_name}
    Discount campaign - Go to Discount campaigns menu
    Discount campaign - User click Edit Campaign button    ${campaign_name}
    Discount campaign - User input text code    ${edit_name}
    Discount campaign - User input campaign name    ${edit_name}
    Discount campaign - User input discription    ${edit_name}
    Discount campaign - User Click Submit to create campaign

Delete campaign - delete by campaign name
    [Arguments]    ${campaign_name}
    Discount campaign - Go to Discount campaigns menu
    Sleep    1s
    Discount campaign - User search campaign name    ${campaign_name}
    Run Keyword And Ignore Error    Discount campaign - User click Delete Campaign button    ${campaign_name}
    Sleep    1s
    Run Keyword And Ignore Error    Confirm Action
    Sleep    1s
    Discount campaign - Should Delete Campaign Success