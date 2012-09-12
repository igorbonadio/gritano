Feature: Keys
  In Order to restrict access to repositories
  As Gritano
  I want to manage user's keys

  Background:
    Given the following users exist:
      | login       |
      | igorbonadio |
      | jessicaeto  |

  Scenario Outline: Add user key
    Given I add "<key>" key to "<user>"
    When I generate the authorized_keys
    Then I should see "<authorized_keys>" authorized_keys
    Examples:
      | user | key | authorized_keys |
      | igorbonadio | igorbonadio.pub | igorbonadio_authorized_keys |
      | jessicaeto  | jessicaeto.pub  | jessicaeto_authorized_keys  |

  Scenario: Generate autorized_keys
    Given I add "igorbonadio.pub" key to "igorbonadio"
    And I add "jessicaeto.pub" key to "jessicaeto"
    When I generate the authorized_keys
    Then I should see "full_authorized_keys" authorized_keys

