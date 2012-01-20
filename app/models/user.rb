class User < ActiveRecord::Base
	attr_accessor :password
	attr_accessible :name, :email, :password, :password_confirmation
	
	has_many :microposts, :dependent => :destroy
	
#Implementing the user/relationships has_many association
#:dependent => :destroy is added to the association since destroying a user should also destroy that user's relationships.
  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
  
  #Adding the User model following association with has_many :through. Rails allows to override the default, 
  #in this case using the :source parameter, which explicitly tells Rails that the source of the following array
  #is the set of followed ids.
  has_many :following, :through => :relationships, :source => :followed 
  
  
  #Implementing user.followers using reverse relationships
  #We have to include the class name relationship, otherwise Rails will look for a ReverseRelationship class, which doesn't exist.
  has_many :reverse_relationships, :foreign_key => "followed_id", :class_name => "Relationship", :dependent => :destroy
  
  has_many :followers, :through => :reverse_relationships, :source => :follower

	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :name, :presence => true,
		         :length   => { :maximum => 50 }	
	validates :email, :presence => true,
			  :format => { :with => email_regex },
			  :uniqueness => { :case_sensitive => false }
	

	#automatically create the virtual attribute "password_confirmation".
	validates :password, :presence => true,
			     :confirmation => true,
			     :length => { :within => 6..40 }

	#A before_save callback to create the encrypted_password attribute
	before_save :encrypt_password

	#Return true if the user's password matches the submitted password
	def has_password?(submitted_password)
		#Compare encrypted_password with the encrypted version of submitted_password
		encrypted_password == encrypt(submitted_password)
	end

	def self.authenticate(email, submitted_password)
		user = find_by_email(email)
		return nil if user.nil?
		return user if user.has_password?(submitted_password)
	end
	
	#Adding an authenticate_with_salt method to the User model
	
	def self.authenticate_with_salt(id, cookie_salt)
	  user = find_by_id(id)
	  (user && user.salt == cookie_salt) ? user : nil
	end
	
	#The following? and follow! utility methods
	#the following? method takes in a user, called followed, and checks to see if a follower with that id exists in the database.
	def following?(followed)
	  relationships.find_by_followed_id(followed)
	end
	
	#the follow! method calls create! through the relationships association to create the following relationship.
	def follow!(followed)
	  relationships.create!(:followed_id => followed.id)
	end
	
	#Unfollowing a user by destroying a user relationship.
	#Find the relationship by followed id and destroy it.
	def unfollow!(followed)
	  relationships.find_by_followed_id(followed).destroy
	end
	
	#A preliminary implementation for the micropost status feed
  def feed
    #Select all the microposts wirh user_id equal to the current user's id, which is accomplished using the 'where' method on the Micropost model
    Micropost.where("user_id = ?", id)
  end

	private

		def encrypt_password
			#new_record? - returns true if the object has not yet been saved to the database.
			#              Since the salt is a unique identifier for each user, we don't wanna it to change every time the user is updated.
			#	       With this method we ensure that the salt is only created once, when the user is first created. 
			self.salt = make_salt if new_record?
			self.encrypted_password = encrypt(password)
		end

		def encrypt(string) #related to submitted_password
			secure_hash("#{salt}--#{string}")
		end

		def make_salt #related to encrypted_password
			secure_hash("#{Time.now.utc}--#{password}")
		end

		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end
		
end

# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

