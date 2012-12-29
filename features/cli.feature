Feature: Console operations
  In order to use gritano via CLI
  As a user
  I want to execute some commands
  
  Background:
    Given the following users exist:
      | login       | admin |
      | igorbonadio | true  |
      | jessicaeto  | false |
      
    And the following keys exist:
      | login       | key |
      | igorbonadio | eva |
      | jessicaeto  | hal |
      
    And the following repositories exist:
      | name            |
      | tmp/gritano.git |
      | tmp/jeka.git    |
      
    And the following permissions exist:
      | user        | repo            | access |
      | igorbonadio | tmp/gritano.git | read   |
      | igorbonadio | tmp/gritano.git | write  |
      | igorbonadio | tmp/jeka.git    | read   |
      | jessicaeto  | tmp/jeka.git    | read   |
      | jessicaeto  | tmp/jeka.git    | write  |

  Scenario: Git read access
    Given I start the CLI with "igorbonadio"
    When I try to get tmp/gritano.git from CLI.check
    Then I should get it

  Scenario: Git write access
    Given I start the CLI with "igorbonadio"
    When I try to send data to tmp/gritano.git from CLI.check
    Then I should send it

  Scenario: Error
    Given I start the CLI with "igorbonadio"
    When I try to send an invalid command to CLI.check
    Then CLI should return the help-check
      
  Scenario: Get help
    Given I start the CLI
    When I send "help" to the CLI.execute
    Then CLI should return the help

  Scenario: Check git
    Given I start the CLI but gritano is not installed
    When I send a command to the CLI.execute
    Then CLI should exit
      
  Scenario Outline: Add user
    Given I start the CLI
    When I send "<command>" to the CLI.execute
    Then CLI should return "<result>"
    Examples:
      | command                                        | result                                                    |
      | version                                        | v0.5.1                                                    |
      | user:add jose                                  | User jose added.                                          |
      | user:key:add igorbonadio marvin                | Key added successfully.                                   |
      | user:key:rm igorbonadio eva                    | Key removed successfully.                                 |
      | user:rm igorbonadio                            | User igorbonadio removed.                                 |
      | user:admin:add igorbonadio                     | Now, user igorbonadio is an administrator                 |
      | user:admin:rm igorbonadio                      | Now, user igorbonadio is not an administrator             |
      | repo:add tmp/p-lang.git                        | Repository tmp/p-lang.git created successfully.           |
      | repo:add tmp/p-lang.git igorbonadio            | Repository tmp/p-lang.git created successfully.           |
      | repo:add tmp/p-lang.git igorbonadio jessicaeto | Repository tmp/p-lang.git created successfully.           |
      | repo:rm tmp/jeka.git                           | Repository tmp/jeka.git removed successfully.             |
      | repo:read:add tmp/gritano.git jessicaeto       | User jessicaeto has read access to tmp/gritano.git.       |
      | repo:write:add tmp/gritano.git jessicaeto      | User jessicaeto has write access to tmp/gritano.git.      |
      | repo:read:rm tmp/jeka.git igorbonadio          | User igorbonadio has not read access to tmp/jeka.git.     |
      | repo:write:rm tmp/gritano.git igorbonadio      | User igorbonadio has not write access to tmp/gritano.git. |
      | user:add igorbonadio                           | error: Login has already been taken.                      |
      | user:rm jose                                   | error: User jose could not be removed.                    |
      | user:key:add userrr marvino                    | error: Key could not be added.                            |
      | user:key:rm igorbonadio marvino                | error: Key could not be removed.                          |
      | user:key:list arybonadio                       | error: User arybonadio is not registered                  |
      | user:repo:list arybonadio                      | error: User arybonadio is not registered                  |
      | user:admin:add arybonadio                      | error: User arybonadio could not be modified              |
      | user:admin:rm arybonadio                       | error: User arybonadio could not be modified              |
      | repo:add tmp/jeka.git                          | error: Repository tmp/jeka.git could not be created.      |
      | repo:rm tmp/p-lang.git                         | error: Repository tmp/p-lang.git could not be removed.    |
      | repo:read:add tmp/gritano.git arybonadio       | error: An error occurred. Permissions was not modified.   |
      | repo:read:add tmp/p-lang.git jessicaeto        | error: An error occurred. Permissions was not modified.   |
      | repo:write:add tmp/gritano.git arybonadio      | error: An error occurred. Permissions was not modified.   |
      | repo:write:add tmp/p-lang.git jessicaeto       | error: An error occurred. Permissions was not modified.   |
      | repo:read:rm tmp/jeka.git aribonadio           | error: An error occurred. Permissions was not modified.   |
      | repo:read:rm tmp/p-lang.git igorbonadio        | error: An error occurred. Permissions was not modified.   |
      | repo:write:rm tmp/gritano.git arybonadio       | error: An error occurred. Permissions was not modified.   |
      | repo:write:rm tmp/p-lang.git igorbonadio       | error: An error occurred. Permissions was not modified.   |
      | repo:user:list tmp/ruby.git                    | error: Repository tmp/ruby.git doesn't exist.             |

  Scenario Outline: Admin via ssh
    Given I start the CLI with "igorbonadio"
    When I send "<command>" to the CLI.check
    Then CLI should return "<result>"
    Examples:
      | command                                              | result  |
      | version                                              | v0.5.1                                                    |
      | key:add keyname                                      | Key added successfully.                                   |
      | key:rm eva                                           | Key removed successfully.                                 |
      | key:rm keyname                                       | error: Key could not be removed.                          |
      | admin:user:add jose                                  | User jose added.                                          |
      | admin:user:key:add igorbonadio marvin                | Key added successfully.                                   |
      | admin:user:key:rm igorbonadio eva                    | Key removed successfully.                                 |
      | admin:user:rm igorbonadio                            | User igorbonadio removed.                                 |
      | admin:user:admin:add igorbonadio                     | Now, user igorbonadio is an administrator                 |
      | admin:user:admin:rm igorbonadio                      | Now, user igorbonadio is not an administrator             |
      | admin:repo:add tmp/p-lang.git                        | Repository tmp/p-lang.git created successfully.           |
      | admin:repo:add tmp/p-lang.git igorbonadio            | Repository tmp/p-lang.git created successfully.           |
      | admin:repo:add tmp/p-lang.git igorbonadio jessicaeto | Repository tmp/p-lang.git created successfully.           |
      | admin:repo:rm tmp/jeka.git                           | Repository tmp/jeka.git removed successfully.             |
      | admin:repo:read:add tmp/gritano.git jessicaeto       | User jessicaeto has read access to tmp/gritano.git.       |
      | admin:repo:write:add tmp/gritano.git jessicaeto      | User jessicaeto has write access to tmp/gritano.git.      |
      | admin:repo:read:rm tmp/jeka.git igorbonadio          | User igorbonadio has not read access to tmp/jeka.git.     |
      | admin:repo:write:rm tmp/gritano.git igorbonadio      | User igorbonadio has not write access to tmp/gritano.git. |
      | admin:user:add igorbonadio                           | error: Login has already been taken.                      |
      | admin:user:rm jose                                   | error: User jose could not be removed.                    |
      | admin:user:key:add userrr marvino                    | error: Key could not be added.                            |
      | admin:user:key:rm igorbonadio marvino                | error: Key could not be removed.                          |
      | admin:user:key:list arybonadio                       | error: User arybonadio is not registered                  |
      | admin:user:repo:list arybonadio                      | error: User arybonadio is not registered                  |
      | admin:user:admin:add arybonadio                      | error: User arybonadio could not be modified              |
      | admin:user:admin:rm arybonadio                       | error: User arybonadio could not be modified              |
      | admin:repo:add tmp/jeka.git                          | error: Repository tmp/jeka.git could not be created.      |
      | admin:repo:rm tmp/p-lang.git                         | error: Repository tmp/p-lang.git could not be removed.    |
      | admin:repo:read:add tmp/gritano.git arybonadio       | error: An error occurred. Permissions was not modified.   |
      | admin:repo:read:add tmp/p-lang.git jessicaeto        | error: An error occurred. Permissions was not modified.   |
      | admin:repo:write:add tmp/gritano.git arybonadio      | error: An error occurred. Permissions was not modified.   |
      | admin:repo:write:add tmp/p-lang.git jessicaeto       | error: An error occurred. Permissions was not modified.   |
      | admin:repo:read:rm tmp/jeka.git aribonadio           | error: An error occurred. Permissions was not modified.   |
      | admin:repo:read:rm tmp/p-lang.git igorbonadio        | error: An error occurred. Permissions was not modified.   |
      | admin:repo:write:rm tmp/gritano.git arybonadio       | error: An error occurred. Permissions was not modified.   |
      | admin:repo:write:rm tmp/p-lang.git igorbonadio       | error: An error occurred. Permissions was not modified.   |
      | admin:repo:user:list tmp/ruby.git                    | error: Repository tmp/ruby.git doesn't exist.             |

  Scenario Outline: Normal user via ssh
    Given I start the CLI with "jessicaeto"
    When I send "<command>" to the CLI.check
    Then CLI should return "<result>"
    Examples:
      | command                                              | result  |
      | version                                              | v0.5.1                                                    |
      | key:add keyname                                      | Key added successfully.                                   |
      | key:rm hal                                           | Key removed successfully.                                 |
      | key:rm keyname                                       | error: Key could not be removed.                          |
      | admin:user:add jose                                  | error: access denied                                      |
      | admin:user:key:add igorbonadio marvin                | error: access denied                                      |
      | admin:user:key:rm igorbonadio eva                    | error: access denied                                      |
      | admin:user:rm igorbonadio                            | error: access denied                                      |
      | admin:user:admin:add igorbonadio                     | error: access denied                                      |
      | admin:user:admin:rm igorbonadio                      | error: access denied                                      |
      | admin:repo:add tmp/p-lang.git                        | error: access denied                                      |
      | admin:repo:add tmp/p-lang.git igorbonadio            | error: access denied                                      |
      | admin:repo:add tmp/p-lang.git igorbonadio jessicaeto | error: access denied                                      |
      | admin:repo:rm tmp/jeka.git                           | error: access denied                                      |
      | admin:repo:read:add tmp/gritano.git jessicaeto       | error: access denied                                      |
      | admin:repo:write:add tmp/gritano.git jessicaeto      | error: access denied                                      |
      | admin:repo:read:rm tmp/jeka.git igorbonadio          | error: access denied                                      |
      | admin:repo:write:rm tmp/gritano.git igorbonadio      | error: access denied                                      |
      | admin:user:add igorbonadio                           | error: access denied                                      |
      | admin:user:rm jose                                   | error: access denied                                      |
      | admin:user:key:add userrr marvino                    | error: access denied                                      |
      | admin:user:key:rm igorbonadio marvino                | error: access denied                                      |
      | admin:user:key:list arybonadio                       | error: access denied                                      |
      | admin:user:repo:list arybonadio                      | error: access denied                                      |
      | admin:user:admin:add arybonadio                      | error: access denied                                      |
      | admin:user:admin:rm arybonadio                       | error: access denied                                      |
      | admin:repo:add tmp/jeka.git                          | error: access denied                                      |
      | admin:repo:rm tmp/p-lang.git                         | error: access denied                                      |
      | admin:repo:read:add tmp/gritano.git arybonadio       | error: access denied                                      |
      | admin:repo:read:add tmp/p-lang.git jessicaeto        | error: access denied                                      |
      | admin:repo:write:add tmp/gritano.git arybonadio      | error: access denied                                      |
      | admin:repo:write:add tmp/p-lang.git jessicaeto       | error: access denied                                      |
      | admin:repo:read:rm tmp/jeka.git aribonadio           | error: access denied                                      |
      | admin:repo:read:rm tmp/p-lang.git igorbonadio        | error: access denied                                      |
      | admin:repo:write:rm tmp/gritano.git arybonadio       | error: access denied                                      |
      | admin:repo:write:rm tmp/p-lang.git igorbonadio       | error: access denied                                      |
      | admin:repo:user:list tmp/ruby.git                    | error: access denied                                      |

