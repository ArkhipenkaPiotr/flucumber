Feature: Counter sample 2e2 test
  Background: Counter app is open

    Scenario: Clicking 12 times to add button
      When App is opened
      Then Click 12 times to plus button
      Then Assert that number on screen is 12