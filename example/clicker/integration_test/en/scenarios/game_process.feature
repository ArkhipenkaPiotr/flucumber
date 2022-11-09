Feature: Clicker game process

  Background: Clicker game has started
    Given Welcome screen is on display
    Then Click to start button

  Scenario Outline: Games with different results
    Then Click to counter <clicks_amount> times
    And Make sure that game title is "<message>"
    And Make sure that number on screen is <clicks_amount>
    Then Wait for the end of the game
    But Make sure that result of game is <clicks_amount> clicks
    Examples:
      | result_type | clicks_amount | message                  |
      | Low         | 10            | Faster!                  |
      | Medium      | 21            | More faster!             |
      | Good        | 51            | Good work!               |
      | Excelent    | 71            | MONSTER! ARE YOU A BOT?? |