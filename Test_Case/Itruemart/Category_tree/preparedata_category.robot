*** Settings ***
Resource          ${CURDIR}/../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Collection/keywords_collection.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Collection/keywords_api_collection.robot

# *** Test Cases ***
# Test title
#    [Tags]    DEBUG
#    Open Browser    ${PCMS_URL}    chrome
#    Set
#    Login Pcms      admin@domain.com        12345
#    Collections - Go To Collections Management Page
#    #Collections - Create Collection     category     Hulk - แคททรี 1    Hulk - category 1     en_US    1
#    ${app_id}=           Set Variable       1

#    ${start}=            Set Variable       1
#    ${end}=            Set Variable       1

#    Collections - PrepareDataForCategoryOrCollectionTree    category       Hulk - แคททะกอรี    Hulk - Category    en_US    ${app_id}    ${start}    ${total}
#    Collections - prepareDataForCategoryOrCollectionTree    collection       Hulk - โปรโมชั่น    Hulk - Promotion    en_US    ${app_id}    ${start}     ${end}
#    #save_current_collection_display     Hulk -
#    #restore_collection_display          Hulk -


*** Keyword ***
Add Cat
  [Arguments]    ${num1}    ${num2}
  Open Browser    ${PCMS_URL}    chrome
  Login Pcms      admin@domain.com        12345
  Maximize Browser Window
  Collections - Go To Collections Management Page
  #Collections - Create Collection     category     Hulk - แคททรี 1    Hulk - category 1     en_US    1
  ${app_id}=           Set Variable       1

  ${start}=            Set Variable       ${num1}
  ${end}=              Set Variable       ${num2}

  Collections - PrepareDataForCategoryOrCollectionTree    category       Hulk - แคททะกอรี    Hulk - Category    en_US    ${app_id}    ${start}    ${end}
  # Collections - prepareDataForCategoryOrCollectionTree    collection       Hulk - โปรโมชั่น    Hulk - Promotion    en_US    ${app_id}    ${start}     ${end}

*** Test Cases ***

Add Cat1
   [Tags]    1
   Add Cat    1    1

# Add Cat2
#    [Tags]    2
#    Add Cat    2    2

# Add Cat3
#    [Tags]    3
#    Add Cat    3    3

# Add Cat4
#    [Tags]    4
#    Add Cat    4    4

# Add Cat5
#    [Tags]    5
#    Add Cat    5    5

# Add Cat6
#    [Tags]    6
#    Add Cat    6    6

# Add Cat7
#    [Tags]    7
#    Add Cat    7    7

# Add Cat8
#    [Tags]    8
#    Add Cat    8    8

# Add Cat9
#    [Tags]    9
#    Add Cat    9    9

# Add Cat10
#    [Tags]    10
#    Add Cat    10    10

# Add Cat11
#    [Tags]    11
#    Add Cat    11    11
# Add Cat11
#    [Tags]    12
#    Add Cat    12    12
# Add Cat11
#    [Tags]    13
#    Add Cat    13    13
# Add Cat11
#    [Tags]    14
#    Add Cat    14    14
# Add Cat11
#    [Tags]    15
#    Add Cat    15    15
# Add Cat11
#    [Tags]    16
#    Add Cat    16    16
# Add Cat11
#    [Tags]    17
#    Add Cat    17    17
# Add Cat11
#    [Tags]    18
#    Add Cat    18    18
# Add Cat19
#    [Tags]    19
#    Add Cat    19    19
# Add Cat20
#    [Tags]    20
#    Add Cat    20    20