class Matepost < ActiveRecord::Base
  attr_accessible :content, :flying_to, :flying_from, :departing_on, :returning_on
  belongs_to :user

  validates :user_id, :presence => true
  validates :flying_to, :presence => true
  validates :flying_from, :presence => true
  validates :departing_on, :presence => true
  validates :returning_on, :presence => true
  validates :content, :presence => true, :length => { maximum: 140 }

  default_scope order: 'mateposts.created_at DESC'
end
