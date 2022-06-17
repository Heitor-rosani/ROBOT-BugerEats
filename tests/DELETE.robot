*** Settings ***
Documentation     API Test GET.partner
Resource          ../resources/base.robot

Test Setup       Criar Lista de parceiros


*** Keywords ***

Criar Lista de parceiros
    ${partners}    New Partner Delete
    Set Suite Variable    ${partners}
    POST Partner    ${partners}  

Dado envio uma solicatação de exclusão do parceiro
    ${partner_id}    Set Variable    ${response.json()}[partner_id]
    Set Suite Variable    ${partner_id}
    DELETE Partner    ${partner_id}

Quando tento excluir o parceiro novamente
    DELETE Partner    ${partner_id}

Então recebo a confirmação de exclusão
    Status Should Be    204

Então recebo a confirmação de erro na exclusão
    Status Should Be    404

*** Test Cases ***
Test 01 - Deletando parceiro
    [Tags]    DELETE_partner
    Dado envio uma solicatação de exclusão do parceiro
    Então recebo a confirmação de exclusão

Test 02 - Deletando parceiro invalido
    [Tags]    DELETE_invalid_partner
    Dado envio uma solicatação de exclusão do parceiro
    Quando tento excluir o parceiro novamente
    Então recebo a confirmação de erro na exclusão
