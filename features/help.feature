Feature: Console operations
  In order to kwon how to use gritano
  As a user
  I want to see the help
      
  Scenario: Get help
    When I set bin_name to test
    Then gritano should show help-test

