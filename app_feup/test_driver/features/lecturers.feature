Feature: Accessing Course Information
  Course Information Component of the App

  Scenario: Access the Lecturers of the Course
    Given I am on the main page of the app
    And I am enrolled in at least one course
    When I press the course card
    Then the system will show me its lecturers