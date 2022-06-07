Feature: Accessing Course Attendants
  Course Attendants section of the App

  Scenario: Access the Results of a Course on the App without grades available
    Given I open the side drawer
    And I tap the "Cadeiras" button
    And I tap the "Turmas" button
    And I am enrolled in at least 1 course
    And I am enrolled in "Engenharia de Software"
    And I wait until the "Engenharia de Software - Turmas" is present
    And I pause for 2 seconds
    And I tap the "Engenharia de Software - Turmas" text
    And the class "2LEIC01 - Engenharia de Software" exists
    When I tap the "2LEIC01 - Engenharia de Software" text
    Then I expect the text "2LEIC01 - Engenharia de Software - Student 1" to be present within 3 seconds
