Feature: Clicker game process

  Background: Clicker game has started
    Given Welcome screen is on display
    Then Click to start button

  # Low result game is game with 20 or less clicks
  Scenario: Low result game
    And Click to counter 10 times
    And Assert that game title is "Faster!"

    # Medium game is game with clicks more then 20 but less then 50
  Scenario: Medium result game
    Then Click to counter 21 times
    And Assert that game title is "More faster!"
    And Assert that number on screen is 21
    Then Wait for the end of the game
    But Assert that result of game is 21 clicks

  # Good game is game with clicks more then 50 but less then 70
  Scenario: Good result game
    Then Click to counter 51 times
    And Assert that game title is "Good work!"
    And Assert that number on screen is 51
    Then Wait for the end of the game
    But Assert that result of game is 51 clicks

    # Excellent game is game with more then 70 clicks
  Scenario: Excellent result game
    Then Click to counter 71 times
    * Assert that game title is "MONSTER! ARE YOU A BOT??"
    * Assert that number on screen is 71
    Then Wait for the end of the game
    But Assert that result of game is 71 clicks