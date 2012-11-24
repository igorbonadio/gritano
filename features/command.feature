Feature: Command
	In order to restrict access to repositories
	As Gritano
	I want to know if a command is a read/write command
	
	Scenario Outline: Write command
	  When I receive a "<original_command>" command
	  Then I should see that it is a "<access>": "<command>" "<repo>"
	  Examples:
	    | original_command                    | access    | command                             | repo     |
	    | git-receive-pack proj.git           | write     | git-receive-pack                    | proj.git |
	    | git-upload-pack proj.git            | read      | git-upload-pack                     | proj.git |
	    | repos                               | user_cmd  | repos                               |          |
	    | keys                                | user_cmd  | keys                                |          |
	    | addkey keyname                      | user_cmd  | addkey keyname                      |          |
	    | rmkey keyname                       | user_cmd  | rmkey keyname                       |          |
	    | user add username                   | admin_cmd | user add username                   |          |
	    | user rm username                    | admin_cmd | user rm username                    |          |
	    | user addkey username keyname        | admin_cmd | user addkey username keyname        |          |
	    | user rmkey username keyname         | admin_cmd | user rmkey username keyname         |          |
	    | user list                           | admin_cmd | user list                           |          |
	    | user keys username                  | admin_cmd | user keys username                  |          |
	    | user repos username                 | admin_cmd | user repos username                 |          |
	    | repo add reponame.git               | admin_cmd | repo add reponame.git               |          |
	    | repo rm reponame.git                | admin_cmd | repo rm reponame.git                |          |
	    | repo addread reponame.git username  | admin_cmd | repo addread reponame.git username  |          |
	    | repo addwrite reponame.git username | admin_cmd | repo addwrite reponame.git username |          |
	    | repo rmread reponame.git username   | admin_cmd | repo rmread reponame.git username   |          |
	    | repo rmwrite reponame.git username  | admin_cmd | repo rmwrite reponame.git username  |          |
	    | repo list                           | admin_cmd | repo list                           |          |
	    | repo users reponame.git             | admin_cmd | repo users reponame.git             |          |
	    | admin help                          | admin_cmd | help                                |          |
