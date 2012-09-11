When /^I receive a "(.*?)" command$/ do |cmd|
  @access, @repo = Gritano::Command.eval(cmd)
end

Then /^I should see that it is a "(.*?)" access to "(.*?)"$/ do |access, repo|
  @access.to_s.should be == access
  @repo.to_s.should be == repo
end