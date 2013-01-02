Given /^I start the gritano console$/ do
  @stdin = double()
  @stdin.stub(:read).and_return("Your SSHKEY here...")
  @home_dir = '.'
  @repo_dir = 'tmp'
  @console = Gritano::CLI
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
