Given /^the following keys exist:$/ do |table|
  table.hashes.each do |key|
    Gritano::User.find_by_login(key['login']).keys.create(name: key["key"], key: "key")
  end
end

Given /^I add "(.*?)" key to "(.*?)"$/ do |key, login|
  ssh_key = File.open(File.join("features/data/keys/", key)).readlines.join
  Gritano::User.find_by_login(login).keys.create({name: key, key: ssh_key})
end

When /^I generate the authorized_keys$/ do
  @authorized_keys = Gritano::Key.authorized_keys
end

Then /^I should see "(.*?)" authorized_keys$/ do |authorized_keys|
  expected_authorized_keys = File.open(File.join("features/data/keys/", authorized_keys)).readlines.join
  @authorized_keys.should be == expected_authorized_keys
end

Then /^I should see that "(.*?)" has only one key$/ do |login|
  Gritano::User.find_by_login(login).keys.count.should be == 1
end