class FakeSTDIN
  def read
    "Your SSHKEY here..."
  end
end

Given /^I start the gritano console$/ do
  stdin = double()
  stdin.stub(:read).and_return("Your SSHKEY here...")
  @console = Gritano::Console.new(stdin)
  @console.ssh_path = 'tmp'
end

When /^I execute "(.*?)"$/ do |command|
  @output = @console.execute(command.split(' '))
end

Then /^I should see a (success|error) message$/ do |ret|
  expected_output = true if ret == 'success'
  expected_output = false if ret == 'error'
  @output[0].should be == expected_output
end