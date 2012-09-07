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
	     
	Scenario Outline: Create a new user
		Given I create a new user called "<user>"
		When I check if "<user>" has <access> access to "<repo>"
		Then I should see that the access is <result>
		Examples:
		  | user       | access | repo    | result |
		  | arybonadio | read   | gritano | denied |
		  | arybonadio | write  | gritano | denied |
		
	Scenario Outline: Create a new repository
		Given I create a new repository called "<repo>" to "<user>"
		Then I should see that only "<user>" has access to "<repo>"
		Examples:
		  | user        | repo   |
		  | igorbonadio | p-lang |
		  | jessicaeto  | pabel  |

		
	Scenario Outline: Edit access permission
		Given I <op> "<user>" <permission> access to "<repo>"
		When I check if "<user>" has <access> access to "<repo>"
		Then I should see that the access is <result>
		Examples:
		  | op     | user        | permission | repo | access | result  |
		  | add    | igorbonadio | read       | jeka | read   | allowed |
		  | add    | igorbonadio | read       | jeka | write  | denied  |
		  | add    | igorbonadio | write      | jeka | read   | denied  |
		  | add    | igorbonadio | write      | jeka | write  | allowed |
		  | remove | jessicaeto  | read       | jeka | read   | denied  |
		  | remove | jessicaeto  | read       | jeka | write  | allowed |
		  | remove | jessicaeto  | write      | jeka | read   | allowed |
		  | remove | jessicaeto  | write      | jeka | write  | denied  |
