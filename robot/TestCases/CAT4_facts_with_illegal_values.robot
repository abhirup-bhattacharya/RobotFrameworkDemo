*** Settings ***
#Suite Setup       Default Suite Setup
#Suite Teardown    Default Suite Teardown
Force Tags        CAT-4    P1    DONE
Resource          ./Settings.robot

#Author           Abhirup Bhattacharya

*** Variables ***
${animal_type}    man
${amount}    600

*** Test Cases ***
Validate Querying Facts With Parameters
    Query Facts    ${animal_type}    ${amount}
    ${status}    Run Keyword And Ignore Error    Validate Response Codes
    Run Keyword If    '''${status[0]}''' == '''PASS'''    FAIL    API returning OK even with wrong input
    Validate Response Header
    ${status}    Run Keyword And Ignore Error    Validate Response Data
    Run Keyword If    '''${status[0]}''' == '''PASS'''    FAIL    API returning OK even with wrong input