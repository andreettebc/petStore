Feature: Endpoint User

  Background:
    * def user = 'v2/user'


  Scenario: Create new user

    * def body =
    """{
  "id": 10013,
  "username": "karateTest",
  "firstName": "Andrea",
  "lastName": "Burgos",
  "email": "email@gmail.com",
  "password": "pass01",
  "phone": "1234567890",
  "userStatus": 0
}
   """

    Given url petstore
    And path user
    And request body
    When method POST
    Then status 200
    And match response.message == '' + body.id



  Scenario:  Search for the created user

    Given url petstore
    And path user, 'karateTest'
    When method get
    Then status 200
    And match response.username contains 'karateTest'


  Scenario: Update the user's name and email
    * def body =
    """{
  "id": 10013,
  "username": "karateTest",
  "firstName": "Andrea",
  "lastName": "Burgos",
  "email": "email@gmail.com",
  "password": "pass01",
  "phone": "1234567890",
  "userStatus": 0
}
   """

    * def new_name = 'Lissette'
    * def new_email = 'email@hotmail.com'
    * body.firstName = new_name
    * body.email = new_email

    Given url petstore
    And path user,'karateTest'
    And request body
    When method PUT
    Then status 200
    And match response.message == '' + body.id


  Scenario: Search for updated user

    Given url petstore
    And path user, 'karateTest'
    When method get
    Then status 200
    And match response.firstName contains 'Lissette'



  Scenario: Delete user

    Given url petstore
    And path user, 'karateTest'
    When method delete
    Then status 200
