*** Variables ***
${LiveAgent_apiKey}      ef2ca207e461b8d507bf781e06a4ee57

*** Keyword ***
LA Tickets - Api Get Tickes By Order ID
    [Arguments]    ${order_id}
    Create Http Context             ${LIVE_AGENT_URL_API}    https
    Set Request Header              Content-Type    application/json
    HttpLibrary.HTTP.GET            ${LIVE_AGENT_API_CONVERSATIONS}?apikey=${LiveAgent_apiKey}&subject=${order_id}
    ${response}=                    Get Response Body
    ${conversations}=               Get Json Value              ${response}       /response/conversations
    Set Test Variable               ${var_la_tickets}           ${conversations}
#    Log to console                  Api Get Tickes By Order ID=${var_la_tickets}
