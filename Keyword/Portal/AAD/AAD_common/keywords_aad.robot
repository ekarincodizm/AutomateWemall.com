*** Settings ***
Library    HttpLibrary.HTTP
Resource   ${CURDIR}/../../../../Resource/Config/${ENV}/env_config.robot
Library   String

*** Keywords ***
AAD Login And Get Token
	Create Http Context   ${AAD-HOST-API}   http
	Set Request Header    Content-Type   ${AAD-HEADER}
	Set Request Header    Authorization   Basic dGVzdDpwYXNzd29yZA==
	Next Request Should Succeed
	HttpLibrary.HTTP.POST   ${AAD-LOGIN-URI}
	${body}=   Get Response Body


	#Create Http Context   ${AAD-HOST-API}   http
	Set Request Header   Content-Type   ${AAD-HEADER}
	Set Request Header    Authorization   Basic dGVzdDpwYXNzd29yZA==
	HttpLibrary.HTTP.POST   /authen/v1/tokens?grant_type=merchant
	${body}=   Get Response Body
	${refresh-token}=  Get Json Value   ${body}   /refresh_token
	${access-token}=   Get Json Value   ${body}   /access_token
	${refresh-token}=  Replace String   ${refresh-token}  "  ${EMPTY}
	${access-token}=   Replace String   ${access-token}  "  ${EMPTY}

	${dict}=  Create Dictionary   refresh_token=${refresh-token}  access_token=${access-token}

	[Return]  ${dict}