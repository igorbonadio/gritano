Feature: Command
	In order to restrict access to repositories
	As Gritano
	I want to know if a command is a read/write command
	
	Scenario Outline: Write command
	  When I receive a "<original_command>" command
	  Then I should see that it is a "<access>": "<command>" "<repo>"
	  Examples:
	    | original_command          | access   | command          | repo     |
	    | git-receive-pack proj.git | write    | git-receive-pack | proj.git |
	    | git-upload-pack proj.git  | read     | git-upload-pack  | proj.git |
	    | repos                     | user_cmd | repos            |          |
	    | keys                      | user_cmd | keys             |          |
	    | addkey keyname            | user_cmd | addkey keyname   |          |
	    | rmkey keyname             | user_cmd | rmkey keyname    |          |
