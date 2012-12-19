Given /^I start the gritano\-check console with "(.*?)"$/ do |login|
  stdin = double()
  stdin.stub(:read).and_return("Your SSHKEY here...")
  @console = Gritano::Console::Check.new(stdin, '.', 'tmp')
  @login = login
end

When /^I execute "(.*?)" via ssh$/ do |command|
  @output = @console.execute(command.split(' ') + [@login])
end
