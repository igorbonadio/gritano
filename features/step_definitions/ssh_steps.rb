Given /^I start the gritano\-check console with "(.*?)"$/ do |login|
  stdin = double()
  stdin.stub(:read).and_return("Your SSHKEY here...")
  @console = Gritano::Console::Check.new(stdin, '.', 'tmp')
  @login = login
end

When /^I execute "(.*?)" via ssh$/ do |command|
  @output = @console.execute(command.split(' ') + [@login])
end

When /^I try to get tmp\/gritano\.git$/ do
  Kernel.should_receive(:exec)
  @console.execute(['git-receive-pack', 'tmp/gritano.git'] + [@login])
end

Then /^I should get it$/ do
end

When /^I try to send data to tmp\/gritano\.git$/ do
  Kernel.should_receive(:exec)
  @console.execute(['git-upload-pack', 'tmp/gritano.git'] + [@login])
end

Then /^I should send it$/ do
end

When /^I try to send an invalid command$/ do
  @command = ['invalid:command']
end

Then /^I should see an exception$/ do
  lambda {@console.execute(@command + [@login])}.should raise_error NoMethodError
end

