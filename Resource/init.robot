*** Settings ***
Resource          ${CURDIR}/Config/app_config.robot
Resource          ${CURDIR}/Config/${ENV}/database.robot
Resource          ${CURDIR}/Config/${ENV}/env_config.robot
Resource          ${CURDIR}/../Keyword/Common/keywords_wemall_common.robot
Resource          ${CURDIR}/TestData/${ENV}/test_data.robot
# Resource    ${CURDIR}/Config/pcms_api_endpoint.robot
# Resource    ${CURDIR}/Config/camp_api_endpoint.robot
# Resource    ${CURDIR}/Config/storefront_api_endpoint.robot
#    Helper Keyword File    #**********************


*** Variables ***
${EMAIL}          authen001@test.com
${PASSWORD}       password
${GRANT_TYPE}     merchant
# ${GRANT_TYPE}    trueid
${EXPIRED_TOKENS}    eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJkbm0iOiJhdXRoZW4wMDEiLCJ1c3IiOiIxIiwidHlwIjoic2hvcCIsImV4cCI6MTQ0NzA3MjM3NH0.QrfIu7MuZfzvTpZh3VITs2RKvCMac8mpEaoKQAdV9wavmnJRxzOgh3jqFOYz6Yi-17-kcPjFZ2yKJwsCrnPKVSihCbjx_s8D4xZuFeBamq8_UOb71lcbr49kqYu9tFt9ZzpVgP3WGJ5htttrl_L6zQtNtvKmQvwZJ9zmrMFIICY
${TOKENS_ALLOWED}    eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJkbm0iOiJhdXRoZW4wMDEiLCJ1c3IiOiIxIiwidHlwIjoic2hvcCIsImV4cCI6MTQ0NzE1MDc1Nn0.dMa_pmzoHEHolRh9BAo74-oNzdY01KSJc5YC9eEgfU3jJOZMWCbTpZGxTuqbmYjeyztNTGHbaU5paFFpGu9M6tZzw67Iauf6NwJeggY02rMlARX6F4HSnuKhJ6Rh1HVhT6iSF3_G5TDH133tIlPwUHAs3RjsL3eaTfHLc8eQ6LY
