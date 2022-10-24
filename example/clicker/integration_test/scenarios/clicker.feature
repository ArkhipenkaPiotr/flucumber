Feature: Clicker sample 2e2 test
  Background: Clicker app is open

    Scenario: Game start
      When Welcome screen is on display
      Then Click to start button
      Then Assert that game is started
      Then Assert that game title is "Faster!"

    Scenario: Low result game
      When Welcome screen is on display
      Then Click to start button
      Then Click to counter 10 times
      Then Assert that game title is "Faster!"

    Scenario: Medium result game
      When Welcome screen is on display
      Then Click to start button
      Then Click to counter 21 times
      Then Assert that game title is "More faster!"
      Then Assert that number on screen is 21
      Then Wait for the end of the game
      Then Assert that result of game is 21 clicks

    Scenario: Good result game
      When Welcome screen is on display
      Then Click to start button
      Then Click to counter 51 times
      Then Assert that game title is "Good work!"
      Then Assert that number on screen is 51
      Then Wait for the end of the game
      Then Assert that result of game is 51 clicks

    Scenario: Excellent result game
      When Welcome screen is on display
      Then Click to start button
      Then Click to counter 71 times
      Then Assert that game title is "MONSTER! ARE YOU A BOT??"
      Then Assert that number on screen is 71
      Then Wait for the end of the game
      Then Assert that result of game is 71 clicks