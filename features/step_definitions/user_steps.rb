Given /^the following users:$/ do |users|
  users.hashes.each do |user|
    Factory(:user,user)
  end
end

Given /^I am signed in as an? (.*)$/ do |title|
  Given 'I am signed in as "insider@example.com/asecret"'
  role = Role.find_by_title(title) || Factory(:role, :title => title)
  User.last.roles << role
end

Given /^the unconfirmed user "(.*)"$/ do |userspec|
  Given "I am signed up as \"#{userspec}\""
  User.last.update_attribute(:confirmed_at,nil)
end

Then /^the password for "(.*)" should be "(.*)"$/ do |email,pass|
  User.authenticate(email, pass).class.should be(User)
end

When /^I delete the (\d+)(?:st|nd|rd|th) user$/ do |pos|
  visit users_path
  within("table > tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following users:$/ do |expected_users_table|
  expected_users_table.map_column!('Name') {|n| n || ""}
  expected_users_table.map_column!('Roles') {|r| r || ""}
  expected_users_table.diff!(tableish('table tr', 'td,th'))
end

Then /^(.*@.*) should receive an email$/ do |email|
  ActionMailer::Base.deliveries.should_not be_empty
  ActionMailer::Base.deliveries.last.to.should include(email)
end
