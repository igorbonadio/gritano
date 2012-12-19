Given /^I start the gritano\-check console with "(.*?)"$/ do |login|
  stdin = double()
  stdin.stub(:read).and_return("Your SSHKEY here...")
  @console = Gritano::Console::Check.new(stdin)
  @login = login
end

When /^I execute "(.*?)" via ssh$/ do |command|
  @console.desable_filters
  @output = @console.execute_without_filters(command.split(' ') + [@login])
end
