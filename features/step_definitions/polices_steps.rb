Given /^the following users exist:$/ do |table|
  table.hashes.each do |user|
    Gritano::User.new(user)
  end
end

Given /^the following repositories exist:$/ do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

Given /^the following permissions exist:$/ do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
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

Given /^I (add|remove) "(.*?)" (read|write) access to "(.*?)"$/ do |arg1, arg2, arg3|
  pending # express the regexp above with the code you wish you had
end