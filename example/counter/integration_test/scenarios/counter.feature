Feature: Counter sample 2e2 test
  Background: Counter app is open

    Scenario:
      When App is opened
      Then Click 3 times to plus button
      Then Assert that number on screen is 12