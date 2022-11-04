Feature: Clicker game start

  Scenario: Game start
    When Welcome screen is on display
    Then Click to start button
    Then Assert that game is started
    Then Assert that game title is "Faster!"