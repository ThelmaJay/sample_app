class Relationship < ActiveRecord::Base
  
  attr_accessible :followed_id
  
  #adding the belongs_to associations to the Relationship model.
  belongs_to :follower, :class_name => "User"
  belongs_to :followed, :class_name => "User"
  
  #adding the relationship model validations
  validates :follower_id, :presence => true
  validates :followed_id, :presence => true
  
end
