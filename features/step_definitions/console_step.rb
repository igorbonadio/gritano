Given /^I start the gritano console$/ do
  stdin = double()
  stdin.stub(:read).and_return("Your SSHKEY here...")
  @console = Gritano::Console::Gritano.new(stdin, '.', 'tmp')
end

When /^I execute "(.*?)"$/ do |command|
  @output = @console.execute(command.split(' '))
end

Then /^I should see a (success|error) message$/ do |result|
  expected_output = true if result == 'success'
  expected_output = false if result == 'error'
  @output[0].should be == expected_output
end

Then /^I should see the help$/ do
  help = File.open("features/data/help.txt").readlines.join[0..-2]
  @output[1].should be == help
end

Given /^I start the gritano console but gritano is not installed$/ do
  stdin = double()
  stdin.stub(:read).and_return("Your SSHKEY here...")
  FileUtils.rm_rf('tmp\.gritano')
  @console = Gritano::Console::Gritano.new(stdin, 'tmp', 'tmp')
end

When /^I execute a command$/ do
  @command = ['user:list']
end

Then /^I should see an error$/ do
  lambda {@console.execute(@command)}.should raise_error SystemExit
end
