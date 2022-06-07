Feature: Accessing Course Results
  Course Results section of the App

  Scenario: Access the Results of a Course on the App without grades available
    Given I open the side drawer
    And I tap the "Cadeiras" button
    And I tap the "Resultados" button
    And I am enrolled in at least 1 course
    And I am enrolled in "Engenharia de Software"
    And I pause for 2 seconds
    When I tap the "Engenharia de Software - Resultados" text
    Then I expect the text "Engenharia de Software - Tabela" to be present within 3 seconds

  Scenario: Access the Results of a Course on the App with grades available
    Given I open the side drawer
    And I tap the "Cadeiras" button
    And I tap the "Resultados" button
    And I am enrolled in at least 1 course
    And I am enrolled in "Fundamentos de Segurança Informática"
    And I pause for 2 seconds
    When I tap the "Fundamentos de Segurança Informática - Resultados" text
    Then I expect the text "Fundamentos de Segurança Informática - Tabela" to be present within 3 seconds
