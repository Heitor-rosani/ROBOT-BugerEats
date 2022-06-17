*** Settings ***
Documentation     API Test GET.partner
Resource          ../resources/base.robot

Test Setup       Criar Lista de parceiros
Test Teardown    Remover lista de parceiros


*** Keywords ***

Criar Lista de parceiros
    ${partners}    New Partner Put
    Set Suite Variable    ${partners}
    POST Partner    ${partners}  


Remover lista de parceiros
    REMOVE partner by name    ${partners}[name]  

Dado que ativo um parceiro
     ${partner_id}    Set Variable    ${response.json()}[partner_id]
     PUT Enable partner    ${partner_id}
     Set Suite Variable    ${partner_id}

Então recebo uma confirmação da mudança
    Status Should Be    200

Dado que exclua um parceiro valido
    REMOVE partner by name    ${partners}[name]

Quando tento habilitar esse parceiro
    Dado que ativo um parceiro

Então recebo uma mensagem de falha
    Status Should Be    404

Dado ter um parceiro ativo
    Dado que ativo um parceiro

Quando desativar esse parceiro
    PUT Disable partner    ${partner_id}


*** Test Cases ***
Test 01 - Modificando parceiro
    [Tags]    PUT_partner_enable
    Dado que ativo um parceiro
    Então recebo uma confirmação da mudança

Test 02 - Modificar parceiro inexistente
    [Tags]    PUT_partner_invalid
    Dado que exclua um parceiro valido
    Quando tento habilitar esse parceiro
    Então recebo uma mensagem de falha

Test 03 - Desabilitar um parceiro
    [Tags]    PUT_partner_disable
    Dado ter um parceiro ativo
    Quando desativar esse parceiro
    Então recebo uma confirmação da mudança