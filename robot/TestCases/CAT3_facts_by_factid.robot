*** Settings ***
#Suite Setup       Default Suite Setup
#Suite Teardown    Default Suite Teardown
Force Tags        CAT-3    P1    DONE
Resource          ./Settings.robot

#Author           Abhirup Bhattacharya

*** Variables ***
${factid}    591f98d1d1f17a153828aade
${animal_type}    dog,cat

*** Test Cases ***
Validate Querying Facts With Parameters
    Get Facts By factId    ${factid}
    Validate Response Codes
    Validate Response Header
    Validate Response ID Is '${factid}' And Type Of Animal Is '${animal_type}'