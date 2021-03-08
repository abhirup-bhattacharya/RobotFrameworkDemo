*** Settings ***
#Suite Setup       Default Suite Setup
#Suite Teardown    Default Suite Teardown
Force Tags        CAT-2    P1    DONE
Resource          ./Settings.robot

#Author           Abhirup Bhattacharya

*** Variables ***
${animal_type}    cat
${amount}    100

*** Test Cases ***
Validate Querying Facts With Parameters
    Query Facts    ${animal_type}    ${amount}
    Validate Response Codes
    Validate Response Header
    Validate Response Data