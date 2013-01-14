class Micropost < ActiveRecord::Base
  attr_accessible :content, :requested_item, :willing_to_pay
  belongs_to :user

  validates :user_id, :presence => true
  validates :requested_item, :presence => true, :length =>  { maximum: 25 }
  validates :willing_to_pay, :presence => true, :length =>  { maximum: 8 }
  validates :content, :presence => true, :length => { maximum: 140 }

  default_scope order: 'microposts.created_at DESC'
end
