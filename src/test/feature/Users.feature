Feature: This test checks that the users endpoint work as expected and list of users where applicable

  Background: This is the result of the test for the role of BPDTS 34.20 Senior Test Engineer.
  The script uses Karate Framework
    * url 'http://bpdts-test-app-v2.herokuapp.com'
    * header accept = 'application/json'

  Scenario: 200 status code returned for users endpoint and check there number of users
    Given path '/users'
    When method GET
    Then status 200
    And match response.[*].id contains [1]


  Scenario Outline: Validate users for given id
    Given path '/user/<id>'
    When method GET
    Then  status <status_code>
    And match response.first_name == '<firstname>'

    Examples:
      | id  | firstname | status_code |
      | 10  | Brennan   | 200         |
      | 869 | Meagan    | 200         |


  Scenario Outline: 404 returned for non-existing id
    Given path '/user/<id>'
    When method GET
    Then  status <status_code>

    Examples:
      | id   | status_code |
      | -1   | 404         |
      | 1006 | 404         |

  Scenario Outline: List of user returned for specified city when available
    Given path '/city/<city>/users'
    When method GET
    Then  status <status_code>
    And match response.[*].id contains [135]
    And match $.email == "aseabrockeef@indiegogo.com"
    And match $ contains {first_name:"Terry"}

    Examples:
      | city   | status_code |
      | London | 200         |
