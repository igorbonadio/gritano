Feature: Policies
	In order to restrict access to repositories
	As Gritano
	I want to create policies
	
	Background:
		Given the following users exist:
		  | login       |
		  | igorbonadio |
		  | jessicaeto  |
		  
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
	     
	Scenario Outline: Create a new user
		Given I create a new user called "<user>"
		When I check if "<user>" has <access> access to "<repo>"
		Then I should see that the access is <result>
		Examples:
		  | user       | access | repo            | result |
		  | arybonadio | read   | tmp/gritano.git | denied |
		  | arybonadio | write  | tmp/gritano.git | denied |
		
	Scenario Outline: Create a new repository
		Given I create a new repository called "<repo>" to "<user>"
		Then I should see that only "<user>" has access to "<repo>"
		Examples:
		  | user        | repo           |
		  | igorbonadio | tmp/p-lang.git |
		  | jessicaeto  | tmp/pabel.git  |
		
	Scenario Outline: Edit access permission
		Given I <op> "<user>" <permission> access to "<repo>"
		When I check if "<user>" has <access> access to "<repo>"
		Then I should see that the access is <result>
		Examples:
		  | op     | user        | permission | repo         | access | result  |
		  | add    | igorbonadio | read       | tmp/jeka.git | read   | allowed |
		  | add    | igorbonadio | read       | tmp/jeka.git | write  | denied  |
		  | add    | igorbonadio | write      | tmp/jeka.git | read   | allowed |
		  | add    | igorbonadio | write      | tmp/jeka.git | write  | allowed |
		  | remove | jessicaeto  | read       | tmp/jeka.git | read   | denied  |
		  | remove | jessicaeto  | read       | tmp/jeka.git | write  | allowed |
		  | remove | jessicaeto  | write      | tmp/jeka.git | read   | allowed |
		  | remove | jessicaeto  | write      | tmp/jeka.git | write  | denied  |
