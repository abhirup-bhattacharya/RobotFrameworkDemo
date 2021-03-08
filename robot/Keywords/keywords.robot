*** Settings ***
Library    ../Libraries/CatFacts.py

*** Variables ***
${types_of_animal}    dog,cat

*** Keywords ***
Query Facts
    [Documentation]    Retrieves the animal facts by calling python method "get_facts" of CatFacts class
    [Arguments]    ${animal_type}=dog,cat    ${amount}=100
    ${response}    Run Keyword    Get Facts    ${animal_type}    ${amount}
    Set Suite Variable    ${response}    ${response}

Get Facts By factId
    [Documentation]    Retrieves the animal facts using 'factid' by calling python method
    ...    "get_facts_by_id" of CatFacts class
    [Arguments]    ${factid}
    ${response}    Run Keyword    Get Facts By Id   ${factid}
    Set Suite Variable    ${response}    ${response}

Call Base API
    [Documentation]    Calls base API and sets response as a suite variable.
    ${response}    Run Keyword    Custom Call
    Set Suite Variable    ${response}    ${response}

Retrieve And Query Facts
    [Documentation]    Queries Fact URL
    ${response}    Run Keyword    Custom Call    facts
    Set Suite Variable    ${response}    ${response}

Query Facts With Wrong Headers
    [Documentation]    Queries Facts API with wrong API
    [Arguments]    ${animal_type}    ${amount}    ${headerDict}
    ${response}    Run Keyword    Call With Custom Headers    ${animal_type}    ${amount}    ${headerDict}
    Set Suite Variable    ${response}    ${response}

Validate Response Codes
    [Documentation]    this step validate the response code from suite variable response
    Variable Should Exist    ${response}    Please set response first.
    ${response_code}    Set Variable    ${response.status_code}
    ${failedReason}    Set Variable If    ${response_code} != 200
    ...    Getting status with ${response.status_code} while fetching cat facts with parameter    ${EMPTY}
    Should Be Empty    ${failedReason}

Validate Response Data
    [Documentation]     this step validate the attribute like 'type' & '_id' from the response
    Variable Should Exist    ${response}    Please set response first.
    ${response_data}    Set Variable    ${response.json()}
    Log    ${response_data}
    ${count}    Evaluate    len(${response_data})
    FOR    ${index}    IN RANGE    0    ${count}
        # the attribute 'type' retured in response should match with the animal_type sent in the request
        ${type}    Set Variable    ${response_data[${index}]['type']}
        ${contains}=  Evaluate   "${type}" in "${types_of_animal}"
        Should Be True    ${contains}    attribute 'type' returned in reponse is not same as animal_type sent in the request
        #Evaluate the data type of the attribute '_id' retured in response
        Should Match Regexp    ${response_data[${index}]['_id']}    ^([a-zA-Z0-9])*$    invalid data type of attribute '_id'
    END

Validate Response Header
    [Documentation]     this step validate the headers from response header
    Variable Should Exist    ${response}    Please set response first.
    ${header_response}    Set Variable    ${response.headers}
    ${content_type}     Set Variable     ${header_response['Content-Type']}
    Should Be True    '''${content_type}''' == '''application/json; charset=utf-8''' or '''${content_type}''' == '''text/html; charset=UTF-8'''    invalid content type returned

Validate Response ID Is '${factid}' And Type Of Animal Is '${animal_type}'
    [Documentation]    Validates the response ID from the API with the factid and the type of animal
    Variable Should Exist    ${response}    Please set response first.
    ${response_data}    Set Variable    ${response.json()}
    Log    ${response_data}
    ${response_id}    Set Variable    ${response_data['_id']}
    Should Be Equal    ${response_id}    ${factid}       recieved id doesn't match with id provided by user
    #Evaluate the data type of the attribute '_id' retured in response
    Should Match Regexp    ${response_id}    ^([a-zA-Z0-9])*$    invalid data type of id
    #Validate Animal type
    ${animal_type}    Set Variable    ${response_data['type']}
    ${is_string}=   Evaluate     isinstance('${animal_type}', str)