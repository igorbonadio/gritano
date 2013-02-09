Given /^I start the remote console with "(.*?)"$/ do |login|
  @stdin = double()
  @stdin.stub(:read).and_return("ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9UnnlDwmvid+WRAyIhVzFhIjUUxA3Wul7LN8mk18dHZDv5HSVADmM4EoqbVSbpeVIyTIchqS3y3XF1rh8dfM41f/W3lcTcFihHM6RDx45Q3Lz9hfyrT8tttlWRA7prvlXu6bUOqMmNtvFFow+bJEo/HgCZHshvoDHcnlHfziU7bDCo+p50SdafFwZRe3AWp/f4TsxiP7jpBnluQM0Dl9Om8jfW8IYAJ+WxlKBsKLMkRH/HWSuigs4AQBD4ADiQfOm2RO4yeSiVFNwGFmgG7NmEq1sNALLAQw+ijN9vyiD99ybr0pqoJX3vhyRBWvCrgQdHjh8ucaoMXI89LxyYts/ igorbonadio@marvin.local")
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
  @command = ['git-receive-pack', repo]
end

Then /^I should get it$/ do
  Kernel.should_receive(:exec)
  @console.check(@command, @login, @stdin, @home_dir, @repo_dir)
end

Then /^I should not get it$/ do
  Kernel.should_not_receive(:exec)
  @console.check(@command, @login, @stdin, @home_dir, @repo_dir)
end

When /^I try to send data to "(.*?)"$/ do |repo|
  @command = ['git-upload-pack', repo]
end

Then /^I should send it$/ do
  Kernel.should_receive(:exec)
  @console.check(@command, @login, @stdin, @home_dir, @repo_dir)
end

Then /^I should not send it$/ do
  Kernel.should_not_receive(:exec)
  @console.check(@command, @login, @stdin, @home_dir, @repo_dir)
end