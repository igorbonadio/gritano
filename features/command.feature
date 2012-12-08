Feature: Command
	In order to restrict access to repositories
	As Gritano
	I want to know if a command is a read/write command
	
	Scenario Outline: Write command
	  When I receive a "<original_command>" command
	  Then I should see that it is a "<access>": "<command>" "<repo>"
	  Examples:
	    | original_command                           | access    | command                              | repo     |
	    | git-receive-pack proj.git                  | write     | git-receive-pack                     | proj.git |
	    | git-upload-pack proj.git                   | read      | git-upload-pack                      | proj.git |
	    | repo:list                                  | user_cmd  | user:repo:list [USER]                |          |
	    | key:list                                   | user_cmd  | user:key:list [USER]                 |          |
	    | key:add keyname                            | user_cmd  | user:key:add [USER] keyname          |          |
	    | key:rm keyname                             | user_cmd  | user:key:rm [USER] keyname           |          |
	    | admin:user:add username                    | admin_cmd | user:add username                    |          |
	    | admin:user:rm username                     | admin_cmd | user:rm username                     |          |
	    | admin:user:key:add username keyname        | admin_cmd | user:key:add username keyname        |          |
	    | admin:user:key:rm username keyname         | admin_cmd | user:key:rm username keyname         |          |
	    | admin:user:list                            | admin_cmd | user:list                            |          |
	    | admin:user:key:list username               | admin_cmd | user:key:list username               |          |
	    | admin:user:repo:list username              | admin_cmd | user:repo:list username              |          |
	    | admin:repo:add reponame.git                | admin_cmd | repo:add reponame.git                |          |
	    | admin:repo:rm reponame.git                 | admin_cmd | repo:rm reponame.git                 |          |
	    | admin:repo:read:add reponame.git username  | admin_cmd | repo:read:add reponame.git username  |          |
	    | admin:repo:write:add reponame.git username | admin_cmd | repo:write:add reponame.git username |          |
	    | admin:repo:read:rm reponame.git username   | admin_cmd | repo:read:rm reponame.git username   |          |
	    | admin:repo:write:rm reponame.git username  | admin_cmd | repo:write:rm reponame.git username  |          |
	    | admin:repo:list                            | admin_cmd | repo:list                            |          |
	    | admin:repo:user:list reponame.git          | admin_cmd | repo:user:list reponame.git          |          |
	    | admin:help                                 | admin_cmd | help                                 |          |
