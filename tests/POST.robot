*** Settings ***
Documentation    API Test POST.partner
Resource        ../resources/base.robot

*** Keywords ***
Dado ter uma massa criada
    ${PAYLOAD}     New Partner
    Set Suite Variable    ${PAYLOAD}
    REMOVE partner by name    ${PAYLOAD}[name]   
Quando enviar uma requisicao POST
    POST Partner    ${PAYLOAD}
Então devo receber a confirmação de sucesso
    Status Should Be      201
    ${RESULTS}            ENCONTRAR partner                ${PAYLOAD}[name] 
    Log To Console        ${RESULTS}[0]
    Should Be Equal       ${RESULTS}[0][_id]                ${response.json()}[partner_id]
Dado ter um parceiro ja criado
    Dado ter uma massa criada
    Quando enviar uma requisicao POST
Quando tento cadastra-lo novamente
    Quando enviar uma requisicao POST
Então recebo uma mesnagem de erro
    Log To Console    Status

*** Test Cases ***
Test 01 - Criar parceiro
    [Tags]    POST_correct
    Dado ter uma massa criada
    Quando enviar uma requisicao POST
    Então devo receber a confirmação de sucesso

Test 02 - Não criar parceiro repetido
    [Tags]    POST_duplicate
    Dado ter um parceiro ja criado
    Quando tento cadastra-lo novamente
    Então recebo uma mesnagem de erro



