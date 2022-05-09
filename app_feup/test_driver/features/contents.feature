Feature: Accessing Course Information
  Course Information Component of the App

  Scenario: Access the Objectives of a Course card on the App
    Given I open the side drawer
    And I tap the "Cadeiras" button
    And I tap the "Fichas" button
    And I am enrolled in at least 1 course
    And I tap the "Engenharia de Software" text
    When I tap the "Engenharia de Software - Objetivos" text
    Then I expect the text "Engenharia de Software - Objetivos Text" to be present within 2 seconds

  Scenario: Access the Program of a Course card on the App
    Given I open the side drawer
    And I tap the "Cadeiras" button
    And I tap the "Fichas" button
    And I am enrolled in at least 1 course
    And I tap the "Compiladores" text
    When I tap the "Compiladores - Programa" text
    Then I expect the text "Compiladores - Programa Text" to be present within 2 seconds

  Scenario: Access the Evaluation of a Course card on the App
    Given I open the side drawer
    And I tap the "Cadeiras" button
    And I tap the "Fichas" button
    And I am enrolled in at least 1 course
    And I tap the "Linguagens e Tecnologias Web" text
    When I tap the "Linguagens e Tecnologias Web - Avaliacao" text
    Then I expect the text "Linguagens e Tecnologias Web - Avaliacao Table" to be present within 2 seconds
