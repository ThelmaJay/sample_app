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

#In order to test that the user.microposts method actually returns an array of microposts we will need to contruct some microposts in the User model spec, 
#which means that we should make a micropost factory. To do so we need a way to make an association in Factory Girl.
Factory.define :micropost do |micropost|
  micropost.content "Foo bar"
  micropost.association :user
end
