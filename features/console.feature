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
	    | user +key igorbonadio marvin features/data/keys/igorbonadio.pub | success |
	    | user -key igorbonadio eva                                       | success |
	    | user rm igorbonadio                                             | success |
	    | repo add tmp/p-lang.git                                         | success |
	    | repo rm tmp/jeka.git                                            | success |
	    | repo +read jessicaeto tmp/gritano.git                           | success |
	    | repo +write jessicaeto tmp/gritano.git                          | success |
	    | repo -read igorbonadio tmp/jeka.git                             | success |
	    | repo -write igorbonadio tmp/gritano.git                         | success |
	    | user add igorbonadio                                            | error   |
	    | user rm jose                                                    | error   |
	    | user +key igorbonadio marvin features/data/keys/arybonadio.pub  | error   |
	    | user -key igorbonadio marvino                                   | error   |
	    | repo add tmp/jeka.git                                           | error   |
	    | repo rm tmp/p-lang.git                                          | error   |
	    | repo +read arybonadio tmp/gritano.git                           | error   |
	    | repo +read jessicaeto tmp/p-lang.git                            | error   |
	    | repo +write arybonadio tmp/gritano.git                          | error   |
	    | repo +write jessicaeto tmp/p-lang.git                           | error   |
	    | repo -read aribonadio tmp/jeka.git                              | error   |
	    | repo -read igorbonadio tmp/p-lang.git                           | error   |
	    | repo -write arybonadio tmp/gritano.git                          | error   |
	    | repo -write igorbonadio tmp/p-lang.git                          | error   |
