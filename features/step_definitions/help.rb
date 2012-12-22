When /^I set bin_name to test$/ do
  Gritano::Console::Gritano.bin_name = "test "
end

Then /^gritano should show help\-test$/ do
  help = File.open("features/data/help-test.txt").readlines.join[0..-2]
  Gritano::Console::Gritano.help.should be == help
end

