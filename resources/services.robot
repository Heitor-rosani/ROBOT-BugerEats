*** Settings ***
Documentation      Camada de serviços
Library            RequestsLibrary

*** Variables ***
${URL}    http://localhost:3333/partners
&{HEADERS}     Content-Type=application/json    auth_user=qa    auth_password=ninja


*** Keywords ***
POST Partner
    [Arguments]    ${payload}

    ${response}    POST    ${URL}
    ...            json=${payload}
    ...            headers=${HEADERS}
    ...            expected_status=any
    Set Suite Variable    ${response}
    [return]       ${response}

GET Partner

    ${response}    GET    ${URL}
    ...            headers=${HEADERS}
    ...            expected_status=any
    Set Suite Variable    ${response}
    [return]       ${response}

GET Partner by name
    [Arguments]    ${name}

    ${query}        Create Dictionary    name=${name}

    ${response}    GET    ${URL}
    ...            params=${query}
    ...            headers=${HEADERS}
    ...            expected_status=any

    Set Suite Variable    ${response}

    [return]       ${response}

PUT Enable partner
    [Arguments]    ${id}

    ${response}    PUT    ${URL}/${id}/enable
    ...            headers=${HEADERS}
    ...            expected_status=any

    Set Suite Variable    ${response}

PUT Disable partner
    [Arguments]    ${id}

    ${response}    PUT    ${URL}/${id}/disable
    ...            headers=${HEADERS}
    ...            expected_status=any

    Set Suite Variable    ${response}

DELETE Partner
    [Arguments]    ${id}

    ${response}    DELETE    ${URL}/${id}
    ...            headers=${HEADERS}
    ...            expected_status=any

    Set Suite Variable    ${response}