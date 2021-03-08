*** Settings ***
#Suite Setup       Default Suite Setup
#Suite Teardown    Default Suite Teardown
Force Tags        CAT-1    P1    DONE
Resource          ./Settings.robot

#Author           Abhirup Bhattacharya

*** Test Cases ***
Validate Base API call
    [Documentation]    Validates the base API is accessible
    Call Base API
    Validate Response Codes
    Validate Response Header
    Set Suite Variable    ${response}    ${EMPTY}

Validate Facts API
    [Documentation]    Validates retrieving and querying facts API without parameters
    Retrieve And Query Facts
    Validate Response Codes
    Validate Response Header
    Validate Response Data
