# By using the symbol ':user', we get Factory Girl to simulate the User model.

Factory.define :user do |user|
	user.name			"ThelmaJay"
	user.email 			"thelmajay@example.com"
	user.password			"foobar"
	user.password_confirmation	"foobar"
end

#Creates a sequence on unique emails.
Factory.sequence :email do |n|
  "person-#{n}@example.com"
end
