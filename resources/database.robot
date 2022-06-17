*** Settings ***
Documentation      database helper collection
Library            RobotMongoDBLibrary.Delete
Library            RobotMongoDBLibrary.Find

*** Variables ***

&{MONGODB_CONNECT_STRING}   connection=mongodb+srv://bugereats:bugereats123@cluster0.ywm5l.mongodb.net/PartnerDB?retryWrites=true&w=majority    database=PartnerDB   collection=partner

*** Keywords ***

REMOVE partner by name
    [Arguments]    ${name}

    ${FILTER}    Create Dictionary
    ...          name=${name}

    DeleteOne    ${MONGODB_CONNECT_STRING}    ${FILTER}

ENCONTRAR partner
    [Arguments]    ${name}

    ${FILTER}    Create Dictionary
    ...          name=${name}

    ${response}     Find    ${MONGODB_CONNECT_STRING}    ${FILTER}
    [Return]    ${response}
    