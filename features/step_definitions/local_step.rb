Given /^I start the gritano console$/ do
  @stdin = double()
  @stdin.stub(:read).and_return("ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9UnnlDwmvid+WRAyIhVzFhIjUUxA3Wul7LN8mk18dHZDv5HSVADmM4EoqbVSbpeVIyTIchqS3y3XF1rh8dfM41f/W3lcTcFihHM6RDx45Q3Lz9hfyrT8tttlWRA7prvlXu6bUOqMmNtvFFow+bJEo/HgCZHshvoDHcnlHfziU7bDCo+p50SdafFwZRe3AWp/f4TsxiP7jpBnluQM0Dl9Om8jfW8IYAJ+WxlKBsKLMkRH/HWSuigs4AQBD4ADiQfOm2RO4yeSiVFNwGFmgG7NmEq1sNALLAQw+ijN9vyiD99ybr0pqoJX3vhyRBWvCrgQdHjh8ucaoMXI89LxyYts/ igorbonadio@marvin.local")
  @home_dir = '.'
  @repo_dir = 'tmp'
  @console = Gritano::CLI
  Gritano::Ssh.any_instance.stub(:add)
  Gritano::Ssh.any_instance.stub(:rm)
end

When /^I execute "(.*?)"$/ do |command|
  @command = command.gsub(' ', '_').gsub(':', '_').gsub('/', '_').
                     gsub('-', '_').gsub('.', '_')
  @output = @console.execute(command.split(' '), @stdin, @home_dir, @repo_dir)
end

Then /^I should see the local help$/ do
  help = File.open("features/data/local_help.txt").readlines.join.
    gsub('{{VERSION}}', File.open("VERSION").readlines.join)
  @output.should be == help
end

Then /^I should see a message$/ do
  msg = File.open("features/data/local_commands/#{@command}.txt").readlines.join.
          gsub('{{VERSION}}', File.open("VERSION").readlines.join)
  @output.should be == msg
end
