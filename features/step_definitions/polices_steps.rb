Given /^the following users exist:$/ do |table|
  table.hashes.each do |user|
    Gritano::User.create(user)
  end
end

Given /^the following repositories exist:$/ do |table|
  table.hashes.each do |repo|
    Gritano::Repository.create(repo)
  end
end

Given /^the following permissions exist:$/ do |table|
  table.hashes.each do |permission|
    Gritano::User.find_by_login(permission['user'])
      .add_access(Gritano::Repository.find_by_name(permission['repo']), permission['access'].to_sym)
  end
end

Given /^I create a new user called "(.*?)"$/ do |login|
  @user = Gritano::User.create(login: login)
end

When /^I check if "(.*?)" has (read|write) access to "(.*?)"$/ do |login, access, repo|
  @access_result = @user.check_access(Gritano::Repository.find_by_name(repo), access.to_sym)
end

Then /^I should see that the access is (denied|allowed)$/ do |result|
  @expected_result = false if result == 'denied'
  @expected_result = true if result == 'allowed'
  @access_result.should be == @expected_result
end

Given /^I create a new repository called "(.*?)" to "(.*?)"$/ do |repo, login|
  Gritano::User.find_by_login(login).create_repository(name: repo)
end

Then /^I should see that only "(.*?)" has access to "(.*?)"$/ do |login, repo|
  repository = Gritano::Repository.find_by_name(repo)
  user = Gritano::User.find_by_login(login)
  user.check_access(repository, :read).should be_true
  user.check_access(repository, :write).should be_true
  Gritano::User.all.each do |u|
    unless u.login == user.login
      u.check_access(repository, :read).should be_false
      u.check_access(repository, :write).should be_false
    end
  end
end

Given /^I (add|remove) "(.*?)" (read|write) access to "(.*?)"$/ do |arg1, arg2, arg3, arg4|
  pending # express the regexp above with the code you wish you had
end