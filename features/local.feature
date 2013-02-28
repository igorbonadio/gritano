Feature: Local access
  In order to use gritano locally
  As a git user
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
      
  Scenario: Get help
      Given I start the gritano console
      When I execute "help"
      Then I should see the local help
      
  Scenario Outline: Execute command
      Given I start the gritano console
      When I execute "<command>"
      Then I should see a message
      Examples:
        | command                                        |
        | version                                        |
        | user:add jose                                  |
        | user:key:add igorbonadio marvin                |
        | user:key:rm igorbonadio eva                    |
        | user:rm igorbonadio                            |
        | user:list                                      |
        | user:key:list igorbonadio                      |
        | user:repo:list igorbonadio                     |
        | user:admin:add igorbonadio                     |
        | user:admin:rm igorbonadio                      |
        | repo:add tmp/p-lang.git                        |
        | repo:add tmp/p-lang.git igorbonadio            |
        | repo:add tmp/p-lang.git igorbonadio jessicaeto |
        | repo:rm tmp/jeka.git                           |
        | repo:read:add tmp/gritano.git jessicaeto       |
        | repo:write:add tmp/gritano.git jessicaeto      |
        | repo:read:rm tmp/jeka.git igorbonadio          |
        | repo:write:rm tmp/gritano.git igorbonadio      |
        | repo:list                                      |
        | repo:user:list tmp/jeka.git                    |
        | user:add igorbonadio                           |
        | user:rm jose                                   |
        | user:key:add userrr marvino                    |
        | user:key:rm igorbonadio marvino                |
        | user:key:list arybonadio                       |
        | user:repo:list arybonadio                      |
        | user:admin:add arybonadio                      |
        | user:admin:rm arybonadio                       |
        | repo:add tmp/jeka.git                          |
        | repo:rm tmp/p-lang.git                         |
        | repo:read:add tmp/gritano.git arybonadio       |
        | repo:read:add tmp/p-lang.git jessicaeto        |
        | repo:write:add tmp/gritano.git arybonadio      |
        | repo:write:add tmp/p-lang.git jessicaeto       |
        | repo:read:rm tmp/jeka.git aribonadio           |
        | repo:read:rm tmp/p-lang.git igorbonadio        |
        | repo:write:rm tmp/gritano.git arybonadio       |
        | repo:write:rm tmp/p-lang.git igorbonadio       |
        | repo:user:list tmp/ruby.git                    |
        | plugin:list                                    |
        