Feature: Console operations
	In order to use gritano via console
	As a user
	I want to execute some commands
	
	Background:
		Given the following users exist:
		  | login       |
		  | igorbonadio |
		  | jessicaeto  |
		  
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
	  Then I should see a <message> message
	  Examples:
	    | command                                                         | message |
	    | user add jose                                                   | success |
	    | user +key igorbonadio marvin                                    | success |
	    | user -key igorbonadio eva                                       | success |
	    | user rm igorbonadio                                             | success |
	    | user list                                                       | success |
	    | user keys igorbonadio                                           | success |
	    | user repos igorbonadio                                          | success |
	    | repo add tmp/p-lang.git                                         | success |
	    | repo rm tmp/jeka.git                                            | success |
	    | repo +read tmp/gritano.git jessicaeto                           | success |
	    | repo +write tmp/gritano.git jessicaeto                          | success |
	    | repo -read tmp/jeka.git igorbonadio                             | success |
	    | repo -write tmp/gritano.git igorbonadio                         | success |
	    | repo list                                                       | success |
	    | repo users tmp/jeka.git                                         | success |
	    | user add igorbonadio                                            | error   |
	    | user rm jose                                                    | error   |
	    | user +key userrr marvino                                        | error   |
	    | user -key igorbonadio marvino                                   | error   |
	    | user keys arybonadio                                            | error   |
	    | user repos arybonadio                                           | error   |
	    | repo add tmp/jeka.git                                           | error   |
	    | repo rm tmp/p-lang.git                                          | error   |
	    | repo +read tmp/gritano.git arybonadio                           | error   |
	    | repo +read tmp/p-lang.git jessicaeto                            | error   |
	    | repo +write tmp/gritano.git arybonadio                          | error   |
	    | repo +write tmp/p-lang.git jessicaeto                           | error   |
	    | repo -read tmp/jeka.git aribonadio                              | error   |
	    | repo -read tmp/p-lang.git igorbonadio                           | error   |
	    | repo -write tmp/gritano.git arybonadio                          | error   |
	    | repo -write tmp/p-lang.git igorbonadio                          | error   |
	    | repo users tmp/ruby.git                                         | error   |
