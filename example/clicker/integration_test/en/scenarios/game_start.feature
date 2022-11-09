Feature: Clicker game start

  Scenario: Game start
    When Welcome screen is on display
    Then Click to start button
    Then Make sure that game is started
    Then Make sure that game title is "Faster!"