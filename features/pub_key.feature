Feature: Public Key
  In order to allow users to user gritano
  As a ssh
  I want to check public keys
  
  Background:
    Given the following users exist:
      | login       | admin |
      | igorbonadio | true  |
      | jessicaeto  | false |
      
    And the following keys exist:
      | login       | key |
      | igorbonadio | eva |
      | jessicaeto  | hal |
      
  Scenario: Valid key
    Given I start the public key checker
    When I receive "eva" public key
    Then I should see "igorbonadio"'s "eva" pubkey entry
    
  Scenario: Invalid key
    Given I start the public key checker
    When I receive "invalid" public key
    Then I should see an invalid pubkey