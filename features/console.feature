Feature: Console operations
	In order to use gritano via console
	As a user
	I want to execute some commands
	
	Background:
		Given the following users exist:
		  | login       |
		  | igorbonadio |
		  | jessicaeto  |
		  
	  And the following repositories exist:
	    | name    |
	    | gritano |
	    | jeka    |
	    
	  And the following permissions exist:
	     | user        | repo    | access |
	     | igorbonadio | gritano | read   |
	     | igorbonadio | gritano | write  |
	     | igorbonadio | jeka    | read   |
	     | jessicaeto  | jeka    | read   |
	     | jessicaeto  | jeka    | write  |
	
	Scenario Outline: Add user
	  Given I start the gritano console
	  When I execute "<command>"
	  Then I should see a <message> message
	  Examples:
	    | command                         | message |
	    | user add jose                   | success |
	    | user rm igorbonadio             | success |
	    | repo add p-lang                 | success |
	    | repo rm jeka                    | success |
	    | repo +read jessicaeto gritano   | success |
	    | repo +write jessicaeto gritano  | success |
	    | repo -read igorbonadio jeka     | success |
	    | repo -write igorbonadio gritano | success |
	    | repo rename gritano newname     | success |
	    | user add igorbonadio            | error   |
	    | user rm jose                    | error   |
	    | repo add jeka                   | error   |
	    | repo rm p-lang                  | error   |
	    | repo +read arybonadio gritano   | error   |
	    | repo +read jessicaeto p-lang    | error   |
	    | repo +write arybonadio gritano  | error   |
	    | repo +write jessicaeto p-lang   | error   |
	    | repo -read aribonadio jeka      | error   |
	    | repo -read igorbonadio p-lang   | error   |
	    | repo -write arybonadio gritano  | error   |
	    | repo -write igorbonadio p-lang  | error   |
	    | repo rename p-lang newname      | error   |
	    | repo rename gritano jeka        | error   |
