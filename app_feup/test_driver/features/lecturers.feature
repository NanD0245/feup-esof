Feature: Accessing Course Information
  Course Information Component of the App

  Scenario: Access the Lecturers of a Course on the App
    Given I open the side drawer
    And I tap the "Cadeiras" button
    And I tap the "Fichas" button
    And I am enrolled in at least 1 course
    And I am enrolled in "Projeto Integrador"
    And I tap the "Projeto Integrador" text
    When I tap the "Projeto Integrador - Docencia" text
    Then I expect the text "Projeto Integrador - Docencia Tables" to be present within 2 seconds
