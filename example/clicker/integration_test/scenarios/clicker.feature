Feature: Clicker sample 2e2 test
  Background: Clicker app is open

    Scenario: Game start
      When Welcome screen is on display
      Then Click to start button
      Then Assert that game is started

    Scenario: Low result game
      When Welcome screen is on display
      Then Click to start button
      Then Click to counter 10 times

    Scenario: Medium result game
      When Welcome screen is on display
      Then Click to start button
      Then Wait for the end of the game

    Scenario: Good result game
      When Welcome screen is on display
      Then Click to start button
      Then Wait for the end of the game

    Scenario: Excellent result game
      When Welcome screen is on display
      Then Click to start button
      Then Wait for the end of the game