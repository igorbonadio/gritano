Given /^I start the gritano console$/ do
  @console = Gritano::Console.new
end

When /^I execute "(.*?)"$/ do |command|
  @output = @console.execute(command.split(' '))
end

Then /^I should see a (success|error) message$/ do |ret|
  expected_output = true if ret == 'success'
  expected_output = false if ret == 'error'
  @output.should be == expected_output
end