Given /^the following users exist:$/ do |table|
  table.hashes.each do |user|
    Gritano::User.create(user)
  end
  jessica = Gritano::User.find_by_login("jessicaeto")
  jessica.save
end

Given /^the following keys exist:$/ do |table|
  table.hashes.each do |key|
    Gritano::User.find_by_login(key['login']).keys.create(name: key["key"], key: key["key"])
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