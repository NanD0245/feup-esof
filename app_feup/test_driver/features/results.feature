Feature: Accessing Course Results
  Course Results of the App

  Scenario: Access the Results of a Course on the App without grades available
    Given I open the side drawer
    And I tap the "Cadeiras" button
    And I tap the "Resultados" button
    And I am enrolled in at least 1 course
    And I am enrolled in "Engenharia de Software"
    When I tap the "Engenharia de Software - Resultados" text
    Then I expect the text "Engenharia de Software - Tabela" to be present within 2 seconds

  Scenario: Access the Results of a Course on the App without grades available
      Given I open the side drawer
      And I tap the "Cadeiras" button
      And I tap the "Resultados" button
      And I am enrolled in at least 1 course
      And I am enrolled in "Redes de Computadores"
      When I tap the "Redes de Computadores - Resultados" text
      Then I expect the text "Redes de Computadores - Tabela" to be present within 2 seconds
