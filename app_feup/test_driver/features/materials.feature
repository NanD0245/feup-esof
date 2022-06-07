Feature: Accessing Course Materials
  Course Materials section of the App

  Scenario: Access the Materials of a Course on the App without anything available
    Given I open the side drawer
    And I tap the "Cadeiras" button
    And I tap the "Materiais" button
    And I am enrolled in at least 1 course
    And I am enrolled in "Engenharia de Software"
    And "Engenharia de Software" does not have contents in SIGARRA
    When I tap the "Engenharia de Software - Materiais" text
    Then I expect the text "Engenharia de Software - Sem Material" to be present within 3 seconds

  Scenario: Access the Materials of a Course on the App with contents available
    Given I open the side drawer
    And I tap the "Cadeiras" button
    And I tap the "Materiais" button
    And I am enrolled in at least 1 course
    And I am enrolled in "Linguagens e Tecnologias Web"
    And "Linguagens e Tecnologias Web" has contents in SIGARRA
    When I tap the "Linguagens e Tecnologias Web - Materiais" text
    Then I expect the text "Linguagens e Tecnologias Web - Transferir Material" to be present within 3 seconds
