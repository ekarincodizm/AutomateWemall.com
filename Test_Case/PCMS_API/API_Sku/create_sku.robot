*** Settings ***
Force Tags        WLS_API_PCMS
Resource          ${CURDIR}/../../../Resource/init.robot
Resource          ${CURDIR}/../../../Keyword/Portal/PCMS/Login/keywords_login.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Sku/keywords_sku.robot
Resource          ${CURDIR}/../../../Keyword/API/PCMS/Shop/keywords_shop.robot
Library           ${CURDIR}/../../../Python_Library/sku_library.py
Library           Selenium2Library
Library           HttpLibrary.HTTP
Library           Collections
Library           OperatingSystem

*** Test Cases ***
TC_iTM_01386 Display a new SKU with valid shop code and valid shop name
    [Tags]    TC_iTM_01386    Ready    QCT      regression    WLS_High
    ${sku_id}=    Set Variable    SKUCODE00001
    ${shop_code}=    Set Variable    SHOPCODE001
    ${shop_name}=    Set Variable    SHOPNAME_!@#$%^&*()_+ื่ชื่อร้านค้า
    ${request_data}=    Set Variable    [{"shop_code": "${shop_code}","shop_name": "${shop_name}","sku": "${sku_id}","name": "sku_test","color": null,"brand": "APAAA","special_price": "10.00","unit_type": "piece","material_code": "","selling_price": "20.00","category_id": "-","size": null}]
    ${expect_code}=    Set Variable    200
    ${expect_message}=    Set Variable    "200 OK"
    API Shop - Create Shop    ${shop_code}    ${shop_name}    # Prepare Shop
    ${result}=    Create New Sku    ${request_data}
    ${actual_code}=    Get Json Value    ${result}    /code
    ${actual_message}=    Get Json Value    ${result}    /message
    ${actual_on_dashboard}=    Is SKU Show On Dashboard    ${sku_id}
    Should Be Equal    ${expect_code}    ${actual_code}
    Should Be Equal    ${expect_message}    ${actual_message}
    Should Be True    ${actual_on_dashboard}
    [Teardown]    Run Keywords    Delete Shop By Shop Code    ${shop_code}
    ...    AND    Delete Imported Sku By sku_id    ${sku_id}

TC_iTM_01387 Display a new invalid SKU with valid existing shop code and special character shop name
    [Tags]    TC_iTM_01387    Ready     regression    WLS_Medium
    ${sku_id}=    Set Variable    ~!@#$%^&*()ก
    ${shop_code_prepare}=    Set Variable    SHOPCODE002
    ${shop_name_prepare}=    Set Variable    SHOPNAME_!@#$%^&*()_+ื่ชื่อร้านค้า
    ${shop_code}=    Set Variable    SHOPCODE002
    ${request_data}=    Set Variable    [{"shop_code": "${shop_code}", "sku": "${sku_id}","name": "sku_test","color": null,"brand": "APAAA","special_price": "10.00","unit_type": "piece","material_code": "","selling_price": "20.00","category_id": "-","size": null}]
    ${expect_code}=    Set Variable    200
    ${expect_message}=    Set Variable    "200 OK"
    API Shop - Create Shop    ${shop_code_prepare}    ${shop_name_prepare}    # Prepare Shop
    ${result}=    Create New Sku    ${request_data}
    ${actual_code}=    Get Json Value    ${result}    /code
    ${actual_message}=    Get Json Value    ${result}    /message
    ${actual_on_dashboard}=    Is SKU Show On Dashboard    ${sku_id}
    Should Be Equal    ${expect_code}    ${actual_code}
    Should Be Equal    ${expect_message}    ${actual_message}
    Should Be True    ${actual_on_dashboard}
    [Teardown]    Run Keywords    Delete Shop By Shop Code    ${shop_code}
    ...    AND    Delete Imported Sku By sku_id    ${sku_id}

TC_iTM_01388 Get error from api when send data with a existing valid SKU with valid existing shop code and special character shop name
    [Tags]    TC_iTM_01388    Ready     regression    WLS_Medium
    ${sku_id}=    Set Variable    SKUCODE00002
    ${shop_code}=    Set Variable    SHOPID003
    ${shop_name}=    Set Variable    null
    ${request_data_prepare}=    Set Variable    [{"shop_code": "${shop_code}", "shop_name": "${shop_name}", "sku": "${sku_id}","name": "sku_test","color": null,"brand": "APAAA","special_price": "10.00","unit_type": "piece","material_code": "","selling_price": "20.00","category_id": "-","size": null}]
    ${request_data}=    Set Variable    [{"shop_code": "${shop_code}", "shop_name": "${shop_name}", "sku": "${sku_id}","name": "sku_test","color": null,"brand": "APAAA","special_price": "10.00","unit_type": "piece","material_code": "","selling_price": "20.00","category_id": "-","size": null}]
    ${expect_code}=    Set Variable    400
    ${expect_message}=    Set Variable    "Error, Duplicate SKU."
    API Shop - Create Shop    ${shop_code}    ${shop_name}    # Prepare Shop
    Create New Sku    ${request_data_prepare}    # Prepare SKU
    ${result}=    Create New Sku    ${request_data}
    ${actual_code}=    Get Json Value    ${result}    /code
    ${actual_message}=    Get Json Value    ${result}    /message
    ${actual_on_dashboard}=    Is SKU Show On Dashboard    ${sku_id}
    Should Be Equal    ${expect_code}    ${actual_code}
    Should Be Equal    ${expect_message}    ${actual_message}
    Should Be True    ${actual_on_dashboard}
    [Teardown]    Run Keywords    Delete Shop By Shop Code    ${shop_code}
    ...    AND    Delete Imported Sku By sku_id    ${sku_id}

TC_iTM_01389 Get error from api when send data with a existing invalid SKU with a new valid Shop and shop name is null
    [Tags]    TC_iTM_01389    Ready    QCT      regression    WLS_Medium
    ${sku_id}=    Set Variable    ~!@#$%^&*()ก
    ${shop_code}=    Set Variable    SHOPID003
    ${shop_name}=    Set Variable    null
    ${request_data_prepare}=    Set Variable    [{"shop_code": "${shop_code}", "shop_name": ${shop_name}, "sku": "${sku_id}","name": "sku_test","color": null,"brand": "APAAA","special_price": "10.00","unit_type": "piece","material_code": "","selling_price": "20.00","category_id": "-","size": null}]
    ${request_data}=    Set Variable    [{"shop_code": "${shop_code}", "shop_name": ${shop_name}, "sku": "${sku_id}","name": "sku_test","color": null,"brand": "APAAA","special_price": "10.00","unit_type": "piece","material_code": "","selling_price": "20.00","category_id": "-","size": null}]
    ${expect_code}=    Set Variable    400004
    ${expect_message}=    Set Variable    "shop_code does not exists."
    Create New Sku    ${request_data_prepare}    # Prepare SKU
    ${result}=    Create New Sku    ${request_data}
    ${actual_code}=    Get Json Value    ${result}    /code
    ${actual_message}=    Get Json Value    ${result}    /message
    ${actual_on_dashboard}=    Is SKU Show On Dashboard    ${sku_id}
    Should Be Equal    ${expect_code}    ${actual_code}
    Should Be Equal    ${expect_message}    ${actual_message}
    Should Not Be True    ${actual_on_dashboard}

TC_iTM_01390 Get error from api when send data with a invalid shop code > 16
    [Tags]    TC_iTM_01390    Ready    QCT      regression    WLS_Medium
    ${sku_id}=    Set Variable    ~!@#$%^&*()ก
    ${shop_code}=    Set Variable    SHOPCODE0000000000999999999
    ${request_data}=    Set Variable    [{"shop_code": "${shop_code}", "name": "sku_test","color": null,"brand": "APAAA","special_price": "10.00","unit_type": "piece","material_code": "","selling_price": "20.00","category_id": "-","size": null}]
    ${expect_code}=    Set Variable    400002
    ${expect_message}=    Set Variable    "The shop_code may not be greater than 16 characters."
    ${result}=    Create New Sku    ${request_data}
    ${actual_code}=    Get Json Value    ${result}    /code
    ${actual_message}=    Get Json Value    ${result}    /message
    ${actual_on_dashboard}=    Is SKU Show On Dashboard    ${sku_id}
    Should Be Equal    ${expect_code}    ${actual_code}
    Should Be Equal    ${expect_message}    ${actual_message}
    Should Not Be True    ${actual_on_dashboard}

TC_iTM_01391 Get error from api when send data with SKU = null and a invalid shop id special character and shop name is null
    [Tags]    TC_iTM_01391    Ready     regression    WLS_Medium
    ${shop_code}=    Set Variable    ~!@#$%^&()_+
    ${request_data}=    Set Variable    [{"shop_code": "${shop_code}", "shop_name": null, "sku": null, "name": "sku_test","color": null,"brand": "APAAA","special_price": "10.00","unit_type": "piece","material_code": "","selling_price": "20.00","category_id": "-","size": null}]
    ${expect_code}=    Set Variable    400002
    ${expect_message}=    Set Variable    "The shop_code format is invalid."
    ${result}=    Create New Sku    ${request_data}
    ${actual_code}=    Get Json Value    ${result}    /code
    ${actual_message}=    Get Json Value    ${result}    /message
    Should Be Equal    ${expect_code}    ${actual_code}
    Should Be Equal    ${expect_message}    ${actual_message}

TC_iTM_01392 Display a new SKU when send data with a valid new SKU with not send shop code and not send shop name
    [Tags]    TC_iTM_01392    Ready    QCT      regression    WLS_Medium
    ${sku_id}=    Set Variable    SKUCODE00003
    ${request_data}=    Set Variable    [{"sku": "${sku_id}", "name": "sku_test","color": null,"brand": "APAAA","special_price": "10.00","unit_type": "piece","material_code": "","selling_price": "20.00","category_id": "-","size": null}]
    ${expect_code}=    Set Variable    200
    ${expect_message}=    Set Variable    "200 OK"
    ${result}=    Create New Sku    ${request_data}
    ${actual_code}=    Get Json Value    ${result}    /code
    ${actual_message}=    Get Json Value    ${result}    /message
    ${actual_on_dashboard}=    Is SKU Show On Dashboard    ${sku_id}
    Should Be Equal    ${expect_code}    ${actual_code}
    Should Be Equal    ${expect_message}    ${actual_message}
    Should Be True    ${actual_on_dashboard}
    [Teardown]    Delete Imported Sku By sku_id    ${sku_id}

TC_iTM_01393 Get error from api when send data with a valid existing SKU with not send shop code and special characters shop name
    [Tags]    TC_iTM_01393    Ready     regression    WLS_Medium
    ${sku_id}=    Set Variable    SKUCODE00004
    ${shop_name}=    Set Variable    null
    ${request_data_prepare}=    Set Variable    [{"shop_name": ${shop_name}, "sku": "${sku_id}","name": "sku_test","color": null,"brand": "APAAA","special_price": "10.00","unit_type": "piece","material_code": "","selling_price": "20.00","category_id": "-","size": null}]
    ${request_data}=    Set Variable    [{"shop_name": ${shop_name}, "sku": "${sku_id}","name": "sku_test","color": null,"brand": "APAAA","special_price": "10.00","unit_type": "piece","material_code": "","selling_price": "20.00","category_id": "-","size": null}]
    ${expect_code}=    Set Variable    400
    ${expect_message}=    Set Variable    "Error, Duplicate SKU."
    Create New Sku    ${request_data_prepare}    # Prepare SKU
    ${result}=    Create New Sku    ${request_data}
    ${actual_code}=    Get Json Value    ${result}    /code
    ${actual_message}=    Get Json Value    ${result}    /message
    ${actual_on_dashboard}=    Is SKU Show On Dashboard    ${sku_id}
    Should Be Equal    ${expect_code}    ${actual_code}
    Should Be Equal    ${expect_message}    ${actual_message}
    Should Be True    ${actual_on_dashboard}
    [Teardown]    Delete Imported Sku By sku_id    ${sku_id}

TC_iTM_01394 Display a new SKU in waiting list when send data with a new invalid SKU with not send shop id and special characters
    [Tags]    TC_iTM_01394    Ready     regression    WLS_Medium
    ${sku_id}=    Set Variable    S!@#$%^&ก
    ${shop_name}=    Set Variable    !@#$%^&*()_+Shopชื่อร้านค้า
    ${request_data}=    Set Variable    [{"shop_name": "${shop_name}","sku": "${sku_id}","name": "sku_test","color": null,"brand": "APAAA","special_price": "10.00","unit_type": "piece","material_code": "","selling_price": "20.00","category_id": "-","size": null}]
    ${expect_code}=    Set Variable    200
    ${expect_message}=    Set Variable    "200 OK"
    ${result}=    Create New Sku    ${request_data}
    ${actual_code}=    Get Json Value    ${result}    /code
    ${actual_message}=    Get Json Value    ${result}    /message
    ${actual_on_dashboard}=    Is SKU Show On Dashboard    ${sku_id}
    Should Be Equal    ${expect_code}    ${actual_code}
    Should Be Equal    ${expect_message}    ${actual_message}
    Should Be True    ${actual_on_dashboard}
    [Teardown]    Delete Imported Sku By sku_id    ${sku_id}

TC_iTM_01395 Get error from api when send data with a exiting valid SKU with shop id = null and shop name = null
    [Tags]    TC_iTM_01395    Ready     regression    WLS_Medium
    ${sku_id}=    Set Variable    SKUCODE00005
    ${shop_code}=    Set Variable    null
    ${shop_name}=    Set Variable    null
    ${request_data_prepare}=    Set Variable    [{"sku": "${sku_id}","name": "sku_test","color": null,"brand": "APAAA","special_price": "10.00","unit_type": "piece","material_code": "","selling_price": "20.00","category_id": "-","size": null}]
    ${request_data}=    Set Variable    [{"shop_code": ${shop_code}, "shop_name": ${shop_name}, "sku": "${sku_id}","name": "sku_test","color": null,"brand": "APAAA","special_price": "10.00","unit_type": "piece","material_code": "","selling_price": "20.00","category_id": "-","size": null}]
    ${expect_code}=    Set Variable    400
    ${expect_message}=    Set Variable    "Error, Duplicate SKU."
    Create New Sku    ${request_data_prepare}
    ${result}=    Create New Sku    ${request_data}
    ${actual_code}=    Get Json Value    ${result}    /code
    ${actual_message}=    Get Json Value    ${result}    /message
    ${actual_on_dashboard}=    Is SKU Show On Dashboard Only One    ${sku_id}
    Should Be Equal    ${expect_code}    ${actual_code}
    Should Be Equal    ${expect_message}    ${actual_message}
    Should Be True    ${actual_on_dashboard}
    [Teardown]    Delete Imported Sku By sku_id    ${sku_id}
