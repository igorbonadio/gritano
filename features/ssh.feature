Feature: SSH operations
  In order to use gritano via ssh
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
    Given I start the gritano-check console with "igorbonadio"
    When I try to get tmp/gritano.git
    Then I should get it

  Scenario: Git read access
    Given I start the gritano-check console with "igorbonadio"
    When I try to send data to tmp/gritano.git
    Then I should send it

  Scenario: Error
    Given I start the gritano-check console with "igorbonadio"
    When I try to send an invalid command
    Then I should see an error

  Scenario Outline: Admin via ssh
    Given I start the gritano-check console with "igorbonadio"
    When I execute "<command>" via ssh
    Then I should see a <result> message
    Examples:
      | command                                              | result  |
      | version                                              | success |
      | help                                                 | success |
      | repo:list                                            | success |
      | key:list                                             | success |
      | key:add keyname                                      | success |
      | key:rm eva                                           | success |
      | admin:help                                           | success |
      | key:rm keyname                                       | error   |
      | admin:user:add jose                                  | success |
      | admin:user:key:add igorbonadio marvin                | success |
      | admin:user:key:rm igorbonadio eva                    | success |
      | admin:user:rm igorbonadio                            | success |
      | admin:user:list                                      | success |
      | admin:user:key:list igorbonadio                      | success |
      | admin:user:repo:list igorbonadio                     | success |
      | admin:user:admin:add igorbonadio                     | success |
      | admin:user:admin:rm igorbonadio                      | success |
      | admin:repo:add tmp/p-lang.git                        | success |
      | admin:repo:add tmp/p-lang.git igorbonadio            | success |
      | admin:repo:add tmp/p-lang.git igorbonadio jessicaeto | success |
      | admin:repo:rm tmp/jeka.git                           | success |
      | admin:repo:read:add tmp/gritano.git jessicaeto       | success |
      | admin:repo:write:add tmp/gritano.git jessicaeto      | success |
      | admin:repo:read:rm tmp/jeka.git igorbonadio          | success |
      | admin:repo:write:rm tmp/gritano.git igorbonadio      | success |
      | admin:repo:list                                      | success |
      | admin:repo:user:list tmp/jeka.git                    | success |
      | admin:user:add igorbonadio                           | error   |
      | admin:user:rm jose                                   | error   |
      | admin:user:key:add userrr marvino                    | error   |
      | admin:user:key:rm igorbonadio marvino                | error   |
      | admin:user:key:list arybonadio                       | error   |
      | admin:user:repo:list arybonadio                      | error   |
      | admin:user:admin:add arybonadio                      | error   |
      | admin:user:admin:rm arybonadio                       | error   |
      | admin:repo:add tmp/jeka.git                          | error   |
      | admin:repo:rm tmp/p-lang.git                         | error   |
      | admin:repo:read:add tmp/gritano.git arybonadio       | error   |
      | admin:repo:read:add tmp/p-lang.git jessicaeto        | error   |
      | admin:repo:write:add tmp/gritano.git arybonadio      | error   |
      | admin:repo:write:add tmp/p-lang.git jessicaeto       | error   |
      | admin:repo:read:rm tmp/jeka.git aribonadio           | error   |
      | admin:repo:read:rm tmp/p-lang.git igorbonadio        | error   |
      | admin:repo:write:rm tmp/gritano.git arybonadio       | error   |
      | admin:repo:write:rm tmp/p-lang.git igorbonadio       | error   |
      | admin:repo:user:list tmp/ruby.git                    | error   |

  Scenario Outline: Normal user via ssh
    Given I start the gritano-check console with "jessicaeto"
    When I execute "<command>" via ssh
    Then I should see a <result> message
    Examples:
      | command                                              | result  |
      | version                                              | success |
      | help                                                 | success |
      | repo:list                                            | success |
      | key:list                                             | success |
      | key:add keyname                                      | success |
      | key:rm hal                                           | success |
      | admin:help                                           | success |
      | key:rm keyname                                       | error   |
      | admin:user:add jose                                  | error   |
      | admin:user:key:add igorbonadio marvin                | error   |
      | admin:user:key:rm igorbonadio eva                    | error   |
      | admin:user:rm igorbonadio                            | error   |
      | admin:user:list                                      | error   |
      | admin:user:key:list igorbonadio                      | error   |
      | admin:user:repo:list igorbonadio                     | error   |
      | admin:user:admin:add igorbonadio                     | error   |
      | admin:user:admin:rm igorbonadio                      | error   |
      | admin:repo:add tmp/p-lang.git                        | error   |
      | admin:repo:add tmp/p-lang.git igorbonadio            | error   |
      | admin:repo:add tmp/p-lang.git igorbonadio jessicaeto | error   |
      | admin:repo:rm tmp/jeka.git                           | error   |
      | admin:repo:read:add tmp/gritano.git jessicaeto       | error   |
      | admin:repo:write:add tmp/gritano.git jessicaeto      | error   |
      | admin:repo:read:rm tmp/jeka.git igorbonadio          | error   |
      | admin:repo:write:rm tmp/gritano.git igorbonadio      | error   |
      | admin:repo:list                                      | error   |
      | admin:repo:user:list tmp/jeka.git                    | error   |
      | admin:user:add igorbonadio                           | error   |
      | admin:user:rm jose                                   | error   |
      | admin:user:key:add userrr marvino                    | error   |
      | admin:user:key:rm igorbonadio marvino                | error   |
      | admin:user:key:list arybonadio                       | error   |
      | admin:user:repo:list arybonadio                      | error   |
      | admin:user:admin:add arybonadio                      | error   |
      | admin:user:admin:rm arybonadio                       | error   |
      | admin:repo:add tmp/jeka.git                          | error   |
      | admin:repo:rm tmp/p-lang.git                         | error   |
      | admin:repo:read:add tmp/gritano.git arybonadio       | error   |
      | admin:repo:read:add tmp/p-lang.git jessicaeto        | error   |
      | admin:repo:write:add tmp/gritano.git arybonadio      | error   |
      | admin:repo:write:add tmp/p-lang.git jessicaeto       | error   |
      | admin:repo:read:rm tmp/jeka.git aribonadio           | error   |
      | admin:repo:read:rm tmp/p-lang.git igorbonadio        | error   |
      | admin:repo:write:rm tmp/gritano.git arybonadio       | error   |
      | admin:repo:write:rm tmp/p-lang.git igorbonadio       | error   |
      | admin:repo:user:list tmp/ruby.git                    | error   |

