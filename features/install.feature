Feature: Setup
  In order to set up a git server
  As a git user
  I want to install gritano
  
  Scenario: Git is not installed
    Given I start the gritano console but gritano is not installed
    When I execute any command
    Then I should see the error: "Error: git must be installed on the local system"

  Scenario: Gritano is not installed
    Given I start the gritano console but gritano is not installed
    When I execute any command
    Then I should see the error: "Error: First run 'gritano setup:prepare && gritano setup:install'"
    
  Scenario: Git is not installed
    Given I start the gritano console but gritano is not installed
    When I execute "help"
    Then I should see the local help
  
  Scenario: Gritano is not installed
    Given I start the gritano console but gritano is not installed
    When I execute "help"
    Then I should see the local help
  
  Scenario: Git is not installed
    Given I start the gritano console but gritano is not installed
    When I execute "version"
    Then I should see a message
  
  Scenario: Gritano is not installed
    Given I start the gritano console but gritano is not installed
    When I execute "version"
    Then I should see a message
    
  Scenario: Install
    Given I start the gritano console but gritano is not installed
    When I install it
    Then I should see that gritano was successful installed
    
  Scenario: Update
    Given I start the gritano console
    When I update it
    Then I should see that gritano was successful updated
    