Feature: Best result check scenarios

  Background: Clicker game has started
    Given Welcome screen is on display
    Then Click to start button

  Scenario Outline: Setting a new record
    Then Click to counter <first_game_result> times
    And Wait for the end of the game
    Then Make sure the best result is <first_game_result>
    Then Start the game again
    And Click to counter <second_game_result> times
    And Wait for the end of the game
    Then Make sure the best result is <second_game_result>
    Examples:
      | first_game_result | second_game_result |
      | 50                | 100                |
      | 99                | 100                |
      | 0                 | 1                  |
      | 0                 | 100                |

  Scenario Outline: Setting a new record
    Then Click to counter <first_game_result> times
    And Wait for the end of the game
    Then Make sure the best result is <first_game_result>
    Then Start the game again
    And Click to counter <second_game_result> times
    And Wait for the end of the game
    Then Make sure the best result is <first_game_result>
    Examples:
      | first_game_result | second_game_result |
      | 100               | 50                 |
      | 100               | 99                 |
      | 1                 | 0                  |
      | 100               | 0                  |
