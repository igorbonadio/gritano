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

Given /^I create a new user called "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

When /^I check if "(.*?)" has read access to "(.*?)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see that the access is (denied|allowed)$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

When /^I check if "(.*?)" has write access to "(.*?)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Given /^I create a new repository called "(.*?)" to "(.*?)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see that only "(.*?)" has access to "(.*?)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Given /^I (add|remove) "(.*?)" (read|write) access to "(.*?)"$/ do |arg1, arg2, arg3, arg4|
  pending # express the regexp above with the code you wish you had
end