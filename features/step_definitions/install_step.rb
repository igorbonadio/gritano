Given /^I start the gritano console but gritano is not installed$/ do
  stdin = double()
  stdin.stub(:read).and_return("Your SSHKEY here...")
  FileUtils.rm_rf(File.join("tmp", ".gritano"))
  @home_dir = 'tmp'
  @repo_dir = 'tmp'
  @console = Gritano::CLI
end

When /^I execute any command$/ do
  @command = "user:list"
end

Then /^I should see the error: "(.*?)"$/ do |error|
  lambda {@console.execute(@command.split(' '), @stdin, @home_dir, @repo_dir)}.should raise_error SystemExit
end

When /^I install it$/ do
  @prepare_output = @console.execute(['setup:prepare'], @stdin, @home_dir, @repo_dir)
  @install_output = @console.execute(['setup:install'], @stdin, @home_dir, @repo_dir)
end

Then /^I should see that gritano was successful (installed|updated)$/ do |opt|
  @prepare_output.should be == "Gritano's configuration has been generated.\nIf you want to customize it, check your '#{File.join(@home_dir, '.gritano')}' directory." if opt == 'installed'
  @install_output.should be == 'gritano has been installed'
end

When /^I update it$/ do
  @install_output = @console.execute(['setup:install'], @stdin, @home_dir, @repo_dir)
end