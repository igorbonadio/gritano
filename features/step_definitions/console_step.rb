Given /^I start the gritano console$/ do
  stdin = double()
  stdin.stub(:read).and_return("Your SSHKEY here...")
  @console = Gritano::Console.new(stdin)
  @console.ssh_path = 'tmp'
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
  help = File.open("features/data/help.txt").readlines.join
  @output[1].should be == help
end