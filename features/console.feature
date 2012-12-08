Feature: Console operations
  In order to use gritano via console
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
      
  Scenario Outline: Add user
    Given I start the gritano console
    When I execute "<command>"
    Then I should see a <result> message
    Examples:
      | command                                   | result  |
      | user:add jose                             | success |
      | user:key:add igorbonadio marvin           | success |
      | user:key:rm igorbonadio eva               | success |
      | user:rm igorbonadio                       | success |
      | user:list                                 | success |
      | user:key:list igorbonadio                 | success |
      | user:repo:list igorbonadio                | success |
      | user:admin:add igorbonadio                | success |
      | user:admin:rm igorbonadio                 | success |
      | repo:add tmp/p-lang.git                   | success |
      | repo:rm tmp/jeka.git                      | success |
      | repo:read:add tmp/gritano.git jessicaeto  | success |
      | repo:write:add tmp/gritano.git jessicaeto | success |
      | repo:read:rm tmp/jeka.git igorbonadio     | success |
      | repo:write:rm tmp/gritano.git igorbonadio | success |
      | repo:list                                 | success |
      | repo:user:list tmp/jeka.git               | success |
      | user:add igorbonadio                      | error   |
      | user:rm jose                              | error   |
      | user:key:add userrr marvino               | error   |
      | user:key:rm igorbonadio marvino           | error   |
      | user:key:list arybonadio                  | error   |
      | user:repo:list arybonadio                 | error   |
      | user:admin:add arybonadio                 | error   |
      | user:admin:rm arybonadio                  | error   |
      | repo:add tmp/jeka.git                     | error   |
      | repo:rm tmp/p-lang.git                    | error   |
      | repo:read:add tmp/gritano.git arybonadio  | error   |
      | repo:read:add tmp/p-lang.git jessicaeto   | error   |
      | repo:write:add tmp/gritano.git arybonadio | error   |
      | repo:write:add tmp/p-lang.git jessicaeto  | error   |
      | repo:read:rm tmp/jeka.git aribonadio      | error   |
      | repo:read:rm tmp/p-lang.git igorbonadio   | error   |
      | repo:write:rm tmp/gritano.git arybonadio  | error   |
      | repo:write:rm tmp/p-lang.git igorbonadio  | error   |
      | repo:user:list tmp/ruby.git               | error   |
