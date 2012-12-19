Given /^I start the gritano console$/ do
  stdin = double()
  stdin.stub(:read).and_return("Your SSHKEY here...")
  @console = Gritano::Console::Gritano.new(stdin, 'tmp', 'tmp')
end

When /^I execute "(.*?)"$/ do |command|
  @console.desable_filters
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
