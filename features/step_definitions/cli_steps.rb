Given /^I start the CLI$/ do
  @cli = Gritano::CLI
  @home_dir = '.'
  @repo_dir = 'tmp'
  @stdin = double()
  @stdin.stub(:read).and_return("Your SSHKEY here...")
end

When /^I send "(.*?)" to the CLI\.execute$/ do |cmd|
  @output = @cli.execute(cmd.split(' '), @stdin, @home_dir, @repo_dir)
end

When /^I send "(.*?)" to the CLI\.check$/ do |cmd|
  @output = @cli.check(cmd.split(' '), @login, @stdin, @home_dir, @repo_dir)
end


Then /^CLI should return the help$/ do
  help = File.open("features/data/help.txt").readlines.join[0..-2]
  @output.should be == help
end

Then /^CLI should return the help\-check$/ do
  help = File.open("features/data/help-check.txt").readlines.join[0..-2]
  @output.should be == help
end

Given /^I start the CLI but gritano is not installed$/ do
  @cli = Gritano::CLI
  @home_dir = 'tmp'
  @repo_dir = 'tmp'
  @stdin = double()
  @stdin.stub(:read).and_return("Your SSHKEY here...")
end

Given /^I start the CLI with "(.*?)"$/ do |login|
  @cli = Gritano::CLI
  @home_dir = '.'
  @repo_dir = 'tmp'
  @stdin = double()
  @stdin.stub(:read).and_return("Your SSHKEY here...")
  @login = login
end

Then /^CLI should exit$/ do
  lambda {@cli.execute(@cmd, @stdin, @home_dir, @repo_dir)}.should raise_error SystemExit
end

When /^I send a command to the CLI\.execute$/ do
  @cmd = ["user:list"]
end

Then /^CLI should return "(.*?)"$/ do |msg|
  @output.should be == msg
end

When /^I try to get tmp\/gritano\.git from CLI\.check$/ do
  Kernel.should_receive(:exec)
  @cli.check(['git-receive-pack', 'tmp/gritano.git'], @login, @stdin, @home_dir, @repo_dir)
end

When /^I try to send data to tmp\/gritano\.git from CLI\.check$/ do
  Kernel.should_receive(:exec)
  @cli.check(['git-upload-pack', 'tmp/gritano.git'], @login, @stdin, @home_dir, @repo_dir)
end

When /^I try to send an invalid command to CLI\.check$/ do
  @output = @cli.check(['error:error'], @login, @stdin, @home_dir, @repo_dir)
end


