Given /^I start the public key checker$/ do
  @console = Gritano::CLI
end

When /^I receive "(.*?)" public key$/ do |key|
  @output = @console.check_pub_key(key, '.')
end

Then /^I should see an invalid pubkey$/ do
  @output.should be == "invalid"
end

Then /^I should see "(.*?)"'s "(.*?)" pubkey entry$/ do |user, key|
  @output.should be == "command=\"gritano-remote #{user}\" #{key}"
end