When /^I receive a "(.*?)" command$/ do |cmd|
  @command = Gritano::Command.eval(cmd)
end

Then /^I should see that it is a "(.*?)": "(.*?)" "(.*?)"$/ do |access, command, repo|
  @command[:access].to_s.should be == access
  @command[:command].to_s.should be == command
  @command[:repo].to_s.should be == repo if repo
end