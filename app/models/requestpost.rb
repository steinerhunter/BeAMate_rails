class Requestpost < ActiveRecord::Base
  attr_accessible :content, :requested_item, :willing_to_pay ,:giftCardsPlace
  belongs_to :user

  validates :user_id, :presence => true
  validates :requested_item, :presence => { :message => "OOPS! Looks like you didn't tell us what you wanted..."}
  validates :requested_item, :length =>  { maximum: 25, :message => "OOPS!  Looks like your request's title is a bit too long..." }
  validates :willing_to_pay, :presence => true, :length =>  { maximum: 8 }
  validates :giftCardsPlace, :presence => true, :length => {minimum: 2}
  validates :content, :presence => { :message => "OOPS! Looks like you didn't tell us a bit more about what you wanted..."}
  validates :content, :length => { maximum: 140 , :message => "OOPS! Looks like your description is a little too long..."}

  default_scope order: 'requestposts.created_at DESC'
end
