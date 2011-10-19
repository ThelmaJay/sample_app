class Micropost < ActiveRecord::Base

#Making the content attribute (and only the content attribute) accessible.
  attr_accessible :content
  belongs_to :user
  validates :content, :presence => true, :length => { :maximum => 140 }
  validates :user_id, :presence => true
  #To get the ordering test to pass, we use a Rails facility called default_scope with an :order parameter.
  default_scope :order => 'microposts.created_at DESC'
end
