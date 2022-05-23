Feature: Accessing Course Attendants
  Course Attendants section of the App

  Scenario: Access the Results of a Course on the App without grades available
    Given I open the side drawer
    And I tap the "Cadeiras" button
    And I tap the "Turmas" button
    And I am enrolled in at least 1 course
    And I am enrolled in "Engenharia de Software"
    And I tap the "Engenharia de Software - Turmas" text
    And the class "2LEIC01" exists
    When I tap the "2LEIC01" text
    Then I expect the text "2LEIC01 - Student 1 Name" to be present within 3 seconds
