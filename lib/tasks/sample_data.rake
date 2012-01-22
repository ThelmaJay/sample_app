#A Rake task for populating the database with sample users.
require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    
    make_users
    make_microposts
    make_relationships
  end
end

def make_users
  
    #Update the sample data populator to make the first user an admin
    admin = User.create!(:name => "Example User",
                         :email => "example@railstutorial.org",
                         :password => "foobar",
                         :password_confirmation => "foobar")
                     
    admin.toggle!(:admin)
                 
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
end

def make_microposts
    
    #Adding microposts to the sample data to a limit of 6 users and 50 microposts per user.
    User.all(:limit => 6).each do |user|
      50.times do
        user.microposts.create!(:content => Faker::Lorem.sentence(5))
      end
    end
end

def make_relationships  
  #Adding following/follower relationships to the sample data
  users = User.all
  user = users.first
  following = users[1..50]
  followers = users[3..40]
  following.each{ |followed| user.follow!(followed) }
  followers.each{ |follower| follower.follow!(user) }
end