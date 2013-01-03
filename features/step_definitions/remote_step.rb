Given /^I start the remote console with "(.*?)"$/ do |login|
  @stdin = double()
  @stdin.stub(:read).and_return("Your SSHKEY here...")
  @home_dir = '.'
  @repo_dir = 'tmp'
  @login = login
  @console = Gritano::CLI
end

When /^I execute "(.*?)" via ssh$/ do |command|
  @command = command + "_" + @login
  @command = @command.gsub(' ', '_').gsub(':', '_').gsub('/', '_').
                      gsub('-', '_').gsub('.', '_')
  @output = @console.check(command.split(' '), @login, @stdin, @home_dir, @repo_dir)
end

Then /^I should see a message via ssh$/ do
  msg = File.open("features/data/remote_commands/#{@command}.txt").readlines.join.
          gsub('{{VERSION}}', File.open("VERSION").readlines.join)
  @output.should be == msg
end

When /^I try to get "(.*?)"$/ do |repo|
  Kernel.should_receive(:exec)
  @console.check(['git-receive-pack', repo], @login, @stdin, @home_dir, @repo_dir)
end

Then /^I should get it$/ do
end

When /^I try to send data to "(.*?)"$/ do |repo|
  Kernel.should_receive(:exec)
  @console.check(['git-upload-pack', repo], @login, @stdin, @home_dir, @repo_dir)
end

Then /^I should send it$/ do
end