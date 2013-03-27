Feature: Remote access
  In order to use gritano remotely
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
    Given I start the remote console with "igorbonadio"
    When I try to get "tmp/gritano.git"
    Then I should get it
  
  Scenario: Git write access
    Given I start the remote console with "igorbonadio"
    When I try to send data to "tmp/gritano.git"
    Then I should send it
    
  Scenario: Git read access denied
    Given I start the remote console with "jessicaeto"
    When I try to get "tmp/gritano.git"
    Then I should not get it
  
  Scenario: Git write access denied
    Given I start the remote console with "jessicaeto"
    When I try to send data to "tmp/gritano.git"
    Then I should not send it
    
  Scenario Outline: Normal user execute command
      Given I start the remote console with "jessicaeto"
      When I execute "<command>" via ssh
      Then I should see a message via ssh
      Examples:
        | command                                              |
        | invalid:command                                      |
        | version                                              |
        | help                                                 |
        | repo:list                                            |
        | key:list                                             |
        | key:add keyname                                      |
        | key:rm hal                                           |
        | email:get                                            |
        | admin:help                                           |
        | admin:version                                        |
        | admin:user:add jose                                  |
        | admin:user:key:add igorbonadio marvin                |
        | admin:user:key:rm igorbonadio eva                    |
        | admin:user:email:update igorbonadio igor@bonadio.com |
        | admin:user:email:update wrong igor@bonadio.com       |
        | admin:user:email:get igorbonadio                     |
        | admin:user:email:get wrong                           |
        | admin:user:email:get jessicaeto                      |
        | admin:user:rm igorbonadio                            |
        | admin:user:list                                      |
        | admin:user:key:list igorbonadio                      |
        | admin:user:repo:list igorbonadio                     |
        | admin:user:admin:add igorbonadio                     |
        | admin:user:admin:rm igorbonadio                      |
        | admin:repo:add tmp/p-lang.git                        |
        | admin:repo:add tmp/p-lang.git igorbonadio            |
        | admin:repo:add tmp/p-lang.git igorbonadio jessicaeto |
        | admin:repo:rm tmp/jeka.git                           |
        | admin:repo:read:add tmp/gritano.git jessicaeto       |
        | admin:repo:write:add tmp/gritano.git jessicaeto      |
        | admin:repo:read:rm tmp/jeka.git igorbonadio          |
        | admin:repo:write:rm tmp/gritano.git igorbonadio      |
        | admin:repo:list                                      |
        | admin:repo:user:list tmp/jeka.git                    |
        | admin:user:add igorbonadio                           |
        | admin:user:rm jose                                   |
        | admin:user:key:add userrr marvino                    |
        | admin:user:key:rm igorbonadio marvino                |
        | admin:user:key:list arybonadio                       |
        | admin:user:repo:list arybonadio                      |
        | admin:user:admin:add arybonadio                      |
        | admin:user:admin:rm arybonadio                       |
        | admin:repo:add tmp/jeka.git                          |
        | admin:repo:rm tmp/p-lang.git                         |
        | admin:repo:read:add tmp/gritano.git arybonadio       |
        | admin:repo:read:add tmp/p-lang.git jessicaeto        |
        | admin:repo:write:add tmp/gritano.git arybonadio      |
        | admin:repo:write:add tmp/p-lang.git jessicaeto       |
        | admin:repo:read:rm tmp/jeka.git aribonadio           |
        | admin:repo:read:rm tmp/p-lang.git igorbonadio        |
        | admin:repo:write:rm tmp/gritano.git arybonadio       |
        | admin:repo:write:rm tmp/p-lang.git igorbonadio       |
        | admin:repo:user:list tmp/ruby.git                    |
        | admin:plugin:list                                    |
        | admin:plugin:info ssh                                |
        | admin:plugin:info sshs                               |
        | admin:plugin:exec ssh help                           |
        | admin:plugin:exec ssh helps                          |
        | admin:plugin:exec sshs help                          |

  Scenario Outline: Admin user execute command
      Given I start the remote console with "igorbonadio"
      When I execute "<command>" via ssh
      Then I should see a message via ssh
      Examples:
        | command                                              |
        | invalid:command                                      |
        | version                                              |
        | help                                                 |
        | repo:list                                            |
        | key:list                                             |
        | key:add keyname                                      |
        | key:rm hal                                           |
        | email:get                                            |
        | admin:help                                           |
        | admin:version                                        |
        | admin:user:add jose                                  |
        | admin:user:email:update igorbonadio igor@bonadio.com |
        | admin:user:email:update wrong igor@bonadio.com       |
        | admin:user:email:get igorbonadio                     |
        | admin:user:email:get wrong                           |
        | admin:user:email:get jessicaeto                      |
        | admin:user:key:add igorbonadio marvin                |
        | admin:user:key:rm igorbonadio eva                    |
        | admin:user:rm igorbonadio                            |
        | admin:user:list                                      |
        | admin:user:key:list igorbonadio                      |
        | admin:user:repo:list igorbonadio                     |
        | admin:user:admin:add igorbonadio                     |
        | admin:user:admin:rm igorbonadio                      |
        | admin:repo:add tmp/p-lang.git                        |
        | admin:repo:add tmp/p-lang.git igorbonadio            |
        | admin:repo:add tmp/p-lang.git igorbonadio jessicaeto |
        | admin:repo:rm tmp/jeka.git                           |
        | admin:repo:read:add tmp/gritano.git jessicaeto       |
        | admin:repo:write:add tmp/gritano.git jessicaeto      |
        | admin:repo:read:rm tmp/jeka.git igorbonadio          |
        | admin:repo:write:rm tmp/gritano.git igorbonadio      |
        | admin:repo:list                                      |
        | admin:repo:user:list tmp/jeka.git                    |
        | admin:user:add igorbonadio                           |
        | admin:user:rm jose                                   |
        | admin:user:key:add userrr marvino                    |
        | admin:user:key:rm igorbonadio marvino                |
        | admin:user:key:list arybonadio                       |
        | admin:user:repo:list arybonadio                      |
        | admin:user:admin:add arybonadio                      |
        | admin:user:admin:rm arybonadio                       |
        | admin:repo:add tmp/jeka.git                          |
        | admin:repo:rm tmp/p-lang.git                         |
        | admin:repo:read:add tmp/gritano.git arybonadio       |
        | admin:repo:read:add tmp/p-lang.git jessicaeto        |
        | admin:repo:write:add tmp/gritano.git arybonadio      |
        | admin:repo:write:add tmp/p-lang.git jessicaeto       |
        | admin:repo:read:rm tmp/jeka.git aribonadio           |
        | admin:repo:read:rm tmp/p-lang.git igorbonadio        |
        | admin:repo:write:rm tmp/gritano.git arybonadio       |
        | admin:repo:write:rm tmp/p-lang.git igorbonadio       |
        | admin:repo:user:list tmp/ruby.git                    |
        | admin:plugin:list                                    |
        | admin:plugin:info ssh                                |
        | admin:plugin:info sshs                               |
        | admin:plugin:exec ssh help                           |
        | admin:plugin:exec ssh helps                          |
        | admin:plugin:exec sshs help                          |
