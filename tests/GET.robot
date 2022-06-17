*** Settings ***
Documentation     API Test GET.partner
Resource          ../resources/base.robot

Test Setup       Criar Lista de parceiros
Test Teardown    Remover lista de parceiros


*** Keywords ***

Criar Lista de parceiros
    ${partners}    New Partner List
    Set Suite Variable    ${partners}
    FOR    ${partner}    IN    @{partners}
        POST Partner    ${partner}  
    END

Remover lista de parceiros
    FOR    ${partner}    IN    @{partners}
        REMOVE partner by name    ${partner}[name]  
    END

Dado enviar uma requisição para a API
    GET Partner

Quando receber a lista de parceiros cadastrados
    ${size}    Get Length    ${response.json()}

    Should Be True    ${size} > 0

Então valido as informações
    Status Should Be      200

Dado ter parceiros cadastrados
    Dado enviar uma requisição para a API

Quando busco pelo nome especifico
    GET Partner by name    ben

Então recebo informações sobre po parceiro
    Status Should Be      200   
    Should Contain    ${response.json()}[0][name]    Ben                            

*** Test Cases ***
Test 01 - Retornar lista de parceiros
    [Tags]    GET_partners
    Dado enviar uma requisição para a API
    Quando receber a lista de parceiros cadastrados
    Então valido as informações

Test 02 - Busca com parametros
    [Tags]    GET_partner_by_name
    Dado ter parceiros cadastrados
    Quando busco pelo nome especifico
    Então recebo informações sobre po parceiro