Feature: Command
	In order to restrict access to repositories
	As Gritano
	I want to know if a command is a read/write command
	
	Scenario Outline: Write command
	  When I receive a "<command>" command
	  Then I should see that it is a "<access>" access to "<repo>"
	  Examples:
	    | command                   | access | repo     |
	    | git-receive-pack proj.git | write  | proj.git |
	    | git-upload-pack proj.git  | read   | proj.git |
